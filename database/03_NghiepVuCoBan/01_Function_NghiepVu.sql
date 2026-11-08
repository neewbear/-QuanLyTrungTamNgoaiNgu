-- ============================================================
-- HE THONG QUAN LY TRUNG TAM NGOAI NGU - TIN HOC
-- FUNCTION HO TRO DIEM DANH VA TINH DIEM
-- PostgreSQL / Supabase
-- File duoc tach tu schema dump hien tai; giu nguyen logic SQL.
-- ============================================================

CREATE FUNCTION public."DiemDanhNhieuHocVien"(danhsach jsonb) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    BanGhi JSONB;
    SoLuong INTEGER := 0;
BEGIN
    FOR BanGhi IN
        SELECT value
        FROM jsonb_array_elements(DanhSach)
    LOOP
        INSERT INTO public."DiemDanh" (
            "BuoiHocId",
            "HocVienId",
            "TrangThai",
            "GhiChu"
        )
        VALUES (
            (BanGhi->>'BuoiHocId')::INTEGER,
            (BanGhi->>'HocVienId')::INTEGER,
            BanGhi->>'TrangThai',
            BanGhi->>'GhiChu'
        )
        ON CONFLICT ("BuoiHocId", "HocVienId")
        DO UPDATE SET
            "TrangThai" = EXCLUDED."TrangThai",
            "GhiChu" = EXCLUDED."GhiChu";

        SoLuong := SoLuong + 1;
    END LOOP;

    RETURN SoLuong;
END;
$$;

CREATE FUNCTION public."TinhDiemTongKet"(p_hocvienid integer, p_lophocid integer) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    DiemTongKet NUMERIC;
    TongHeSo NUMERIC;
    SoDauDiem INTEGER;
    SoDiemDaNhap INTEGER;
BEGIN
    -- Kiểm tra tổng hệ số của khóa học
    SELECT
        COALESCE(SUM("HeSo"), 0),
        COUNT(*)
    INTO TongHeSo, SoDauDiem
    FROM public."DauDiem" DD
    JOIN public."LopHoc" LH
        ON LH."KhoaHocId" = DD."KhoaHocId"
    WHERE LH."LopHocId" = p_LopHocId;

    IF SoDauDiem = 0 OR TongHeSo <> 1 THEN
        RAISE EXCEPTION
            'Cấu hình đầu điểm hoặc tổng hệ số không hợp lệ';
    END IF;

    -- Kiểm tra số đầu điểm đã nhập
    SELECT COUNT(*)
    INTO SoDiemDaNhap
    FROM public."Diem" D
    JOIN public."DauDiem" DD
        ON DD."DauDiemId" = D."DauDiemId"
    WHERE D."HocVienId" = p_HocVienId
      AND D."LopHocId" = p_LopHocId;

    IF SoDiemDaNhap <> SoDauDiem THEN
        RAISE EXCEPTION
            'Chưa nhập đủ điểm thành phần cho học viên';
    END IF;

    -- Tính điểm tổng kết theo hệ số
    SELECT ROUND(SUM(D."DiemSo" * DD."HeSo"), 2)
    INTO DiemTongKet
    FROM public."Diem" D
    JOIN public."DauDiem" DD
        ON DD."DauDiemId" = D."DauDiemId"
    WHERE D."HocVienId" = p_HocVienId
      AND D."LopHocId" = p_LopHocId;

    RETURN DiemTongKet;
END;
$$;
