-- ============================================================
-- HE THONG QUAN LY TRUNG TAM NGOAI NGU - TIN HOC
-- FUNCTION KIEM TRA SI SO VA XUNG DOT LICH
-- PostgreSQL / Supabase
-- File duoc tach tu schema dump hien tai; giu nguyen logic SQL.
-- ============================================================

CREATE FUNCTION public."KiemTraSiSoGhiDanh"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    SiSoHienTai INTEGER;
    SiSoToiDa INTEGER;
BEGIN
    -- Khóa theo lớp để tránh hai lượt ghi danh đồng thời vượt sĩ số
    PERFORM pg_advisory_xact_lock(NEW."LopHocId"::BIGINT);

    SELECT "SiSoToiDa"
    INTO SiSoToiDa
    FROM public."LopHoc"
    WHERE "LopHocId" = NEW."LopHocId";

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Lớp học không tồn tại';
    END IF;

    -- Chỉ kiểm tra khi học viên đang học
    IF NEW."TrangThai" = 'DangHoc' THEN
        SELECT COUNT(*)
        INTO SiSoHienTai
        FROM public."GhiDanh"
        WHERE "LopHocId" = NEW."LopHocId"
          AND "TrangThai" = 'DangHoc'
          AND "GhiDanhId" <> COALESCE(NEW."GhiDanhId", -1);

        IF SiSoHienTai >= SiSoToiDa THEN
            RAISE EXCEPTION
                'Lớp đã đủ sĩ số tối đa (% học viên)', SiSoToiDa;
        END IF;
    END IF;

    RETURN NEW;
END;
$$;

CREATE FUNCTION public."KiemTraTrungLich"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    LopMoi RECORD;
    CoXungDot BOOLEAN;
BEGIN
    SELECT
        "GiaoVienId",
        "PhongId",
        "KhaiGiang",
        "BeGiang"
    INTO LopMoi
    FROM public."LopHoc"
    WHERE "LopHocId" = NEW."LopHocId";

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Lớp học không tồn tại';
    END IF;

    PERFORM pg_advisory_xact_lock(NEW."LopHocId"::BIGINT);

    SELECT EXISTS (
        SELECT 1
        FROM public."LichLop" LL
        JOIN public."LopHoc" LH
            ON LH."LopHocId" = LL."LopHocId"
        WHERE LL."LopHocId" <> NEW."LopHocId"
          AND LL."ThuTrongTuan" = NEW."ThuTrongTuan"
          AND LH."KhaiGiang" <= LopMoi."BeGiang"
          AND LH."BeGiang" >= LopMoi."KhaiGiang"
          AND NEW."GioBatDau" < LL."GioKetThuc"
          AND NEW."GioKetThuc" > LL."GioBatDau"
          AND (
              LH."GiaoVienId" = LopMoi."GiaoVienId"
              OR LH."PhongId" = LopMoi."PhongId"
          )
    )
    INTO CoXungDot;

    IF CoXungDot THEN
        RAISE EXCEPTION
            'Trùng lịch giáo viên hoặc phòng học với lớp khác';
    END IF;

    RETURN NEW;
END;
$$;
