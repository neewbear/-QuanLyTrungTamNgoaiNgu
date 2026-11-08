-- ============================================================
-- HE THONG QUAN LY TRUNG TAM NGOAI NGU - TIN HOC
-- FUNCTION BAO CAO VA CANH BAO
-- PostgreSQL / Supabase
-- File duoc tach tu schema dump hien tai; giu nguyen logic SQL.
-- ============================================================

CREATE FUNCTION public."BaoCaoChuyenCan"(p_tu date DEFAULT NULL::date, p_den date DEFAULT NULL::date) RETURNS TABLE("LopHocId" integer, "MaLop" text, "TongLuotDiemDanh" bigint, "CoMat" bigint, "DiMuon" bigint, "VangCoPhep" bigint, "VangKhongPhep" bigint, "TyLeChuyenCan" numeric)
    LANGUAGE sql
    AS $$
    SELECT
        LH."LopHocId",
        LH."MaLop"::TEXT,
        COUNT(DD."DiemDanhId"),
        COUNT(DD."DiemDanhId") FILTER (
            WHERE DD."TrangThai" = 'CoMat'
        ),
        COUNT(DD."DiemDanhId") FILTER (
            WHERE DD."TrangThai" = 'DiMuon'
        ),
        COUNT(DD."DiemDanhId") FILTER (
            WHERE DD."TrangThai" = 'VangCoPhep'
        ),
        COUNT(DD."DiemDanhId") FILTER (
            WHERE DD."TrangThai" = 'VangKhongPhep'
        ),
        ROUND(
            100.0 * COUNT(DD."DiemDanhId") FILTER (
                WHERE DD."TrangThai" IN ('CoMat', 'DiMuon')
            ) / NULLIF(COUNT(DD."DiemDanhId"), 0),
            2
        )
    FROM public."LopHoc" LH
    LEFT JOIN public."BuoiHoc" BH
        ON BH."LopHocId" = LH."LopHocId"
    LEFT JOIN public."DiemDanh" DD
        ON DD."BuoiHocId" = BH."BuoiHocId"
    WHERE (p_Tu IS NULL OR BH."Ngay" >= p_Tu)
      AND (p_Den IS NULL OR BH."Ngay" <= p_Den)
    GROUP BY LH."LopHocId", LH."MaLop"
    ORDER BY LH."LopHocId";
$$;

CREATE FUNCTION public."BaoCaoCongNo"(p_lophocid integer DEFAULT NULL::integer) RETURNS TABLE("HocVienId" integer, "HoTen" text, "MaLop" text, "HocPhi" numeric, "DaDong" numeric, "ConNo" numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        HV."HocVienId",
        HV."HoTen"::TEXT,
        LH."MaLop"::TEXT,
        KH."HocPhi"::NUMERIC,
        COALESCE(SUM(PT."SoTien"), 0)::NUMERIC,
        GREATEST(
            KH."HocPhi"::NUMERIC
            - COALESCE(SUM(PT."SoTien"), 0),
            0
        )::NUMERIC
    FROM public."GhiDanh" GD
    JOIN public."HocVien" HV
        ON HV."HocVienId" = GD."HocVienId"
    JOIN public."LopHoc" LH
        ON LH."LopHocId" = GD."LopHocId"
    JOIN public."KhoaHoc" KH
        ON KH."KhoaHocId" = LH."KhoaHocId"
    LEFT JOIN public."PhieuThu" PT
        ON PT."GhiDanhId" = GD."GhiDanhId"
    WHERE LOWER(TRIM(GD."TrangThai")) = 'danghoc'
      AND (p_LopHocId IS NULL OR LH."LopHocId" = p_LopHocId)
    GROUP BY
        HV."HocVienId",
        HV."HoTen",
        LH."MaLop",
        KH."HocPhi";
END;
$$;

CREATE FUNCTION public."BaoCaoDoanhThu"() RETURNS TABLE("KhoaHocId" integer, "TenKhoaHoc" text, "SoLuotGhiDanh" bigint, "TongDoanhThu" numeric)
    LANGUAGE sql
    AS $$
    SELECT
        KH."KhoaHocId",
        KH."Ten"::TEXT,
        COUNT(DISTINCT GD."GhiDanhId"),
        COALESCE(SUM(PT."SoTien"), 0)::NUMERIC
    FROM public."KhoaHoc" KH
    LEFT JOIN public."LopHoc" LH
        ON LH."KhoaHocId" = KH."KhoaHocId"
    LEFT JOIN public."GhiDanh" GD
        ON GD."LopHocId" = LH."LopHocId"
    LEFT JOIN public."PhieuThu" PT
        ON PT."GhiDanhId" = GD."GhiDanhId"
    GROUP BY KH."KhoaHocId", KH."Ten"
    ORDER BY KH."KhoaHocId";
$$;

CREATE FUNCTION public."BaoCaoThuLaoGiaoVien"() RETURNS TABLE("GiaoVienId" integer, "HoTen" text, "SoBuoiDaLenLich" bigint, "SoTietDuKien" bigint, "ThuLaoMoiTiet" numeric, "TongThuLaoDuKien" numeric)
    LANGUAGE sql
    AS $$
    SELECT
        GV."GiaoVienId",
        GV."HoTen"::TEXT,
        COUNT(BH."BuoiHocId")::BIGINT,
        SUM(
            CEIL(
                EXTRACT(EPOCH FROM (LL."GioKetThuc" - LL."GioBatDau"))
                / 60.0 / 45
            )
        )::BIGINT,
        GV."ThuLaoMoiTiet"::NUMERIC,
        (
            SUM(
                CEIL(
                    EXTRACT(EPOCH FROM (LL."GioKetThuc" - LL."GioBatDau"))
                    / 60.0 / 45
                )
            ) * GV."ThuLaoMoiTiet"
        )::NUMERIC
    FROM public."GiaoVien" GV
    JOIN public."LopHoc" LH
        ON LH."GiaoVienId" = GV."GiaoVienId"
    JOIN public."LichLop" LL
        ON LL."LopHocId" = LH."LopHocId"
    JOIN public."BuoiHoc" BH
        ON BH."LopHocId" = LH."LopHocId"
    WHERE BH."TrangThai" = 'DaLenLich'
    GROUP BY
        GV."GiaoVienId",
        GV."HoTen",
        GV."ThuLaoMoiTiet"
    ORDER BY GV."GiaoVienId";
$$;

CREATE FUNCTION public."CanhBaoVangQua20"(p_lophocid integer DEFAULT NULL::integer) RETURNS TABLE("HocVienId" integer, "HoTen" text, "LopHocId" integer, "MaLop" text, "TongSoBuoi" bigint, "SoBuoiVang" bigint, "TyLeVang" numeric)
    LANGUAGE sql
    AS $$
    SELECT
        HV."HocVienId",
        HV."HoTen"::TEXT,
        LH."LopHocId",
        LH."MaLop"::TEXT,
        COUNT(DD."DiemDanhId"),
        COUNT(DD."DiemDanhId") FILTER (
            WHERE DD."TrangThai" IN ('VangCoPhep', 'VangKhongPhep')
        ),
        ROUND(
            100.0 * COUNT(DD."DiemDanhId") FILTER (
                WHERE DD."TrangThai" IN ('VangCoPhep', 'VangKhongPhep')
            ) / NULLIF(COUNT(DD."DiemDanhId"), 0),
            2
        )
    FROM public."GhiDanh" GD
    JOIN public."HocVien" HV
        ON HV."HocVienId" = GD."HocVienId"
    JOIN public."LopHoc" LH
        ON LH."LopHocId" = GD."LopHocId"
    JOIN public."BuoiHoc" BH
        ON BH."LopHocId" = LH."LopHocId"
    JOIN public."DiemDanh" DD
        ON DD."BuoiHocId" = BH."BuoiHocId"
       AND DD."HocVienId" = HV."HocVienId"
    WHERE LOWER(TRIM(GD."TrangThai")) = 'dang hoc'
      AND (p_LopHocId IS NULL OR LH."LopHocId" = p_LopHocId)
    GROUP BY
        HV."HocVienId",
        HV."HoTen",
        LH."LopHocId",
        LH."MaLop"
    HAVING
        COUNT(DD."DiemDanhId") FILTER (
            WHERE DD."TrangThai" IN ('VangCoPhep', 'VangKhongPhep')
        ) * 100.0 / NULLIF(COUNT(DD."DiemDanhId"), 0) > 20
    ORDER BY LH."LopHocId", HV."HocVienId";
$$;
