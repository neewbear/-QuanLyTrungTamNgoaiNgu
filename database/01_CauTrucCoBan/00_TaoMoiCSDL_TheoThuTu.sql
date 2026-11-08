-- ============================================================
-- SCRIPT TONG HOP TAO CAU TRUC CSDL TREN MOI TRUONG MOI
-- CHI CHAY TREN DATABASE MOI / CHUA CO CAC BANG TUONG UNG.
-- KHONG CHAY LAI TREN SUPABASE DANG CO DU LIEU.
-- ============================================================


-- ============================================================
-- HE THONG QUAN LY TRUNG TAM NGOAI NGU - TIN HOC
-- TAO 15 BANG VA CAU HINH IDENTITY
-- PostgreSQL / Supabase
-- File duoc tach tu schema dump hien tai; giu nguyen logic SQL.
-- ============================================================

CREATE TABLE public."BuoiHoc" (
    "BuoiHocId" integer NOT NULL,
    "LopHocId" integer NOT NULL,
    "Ngay" date NOT NULL,
    "SoThuTu" integer NOT NULL,
    "TrangThai" character varying(30) DEFAULT 'DaLenLich'::character varying NOT NULL,
    "GhiChu" character varying(255),
    CONSTRAINT "CK_BuoiHoc_SoThuTu" CHECK (("SoThuTu" > 0)),
    CONSTRAINT "CK_BuoiHoc_TrangThai" CHECK ((("TrangThai")::text = ANY ((ARRAY['Huy'::character varying, 'DaHoanThanh'::character varying, 'DaLenLich'::character varying])::text[])))
);

CREATE TABLE public."DauDiem" (
    "DauDiemId" integer NOT NULL,
    "KhoaHocId" integer NOT NULL,
    "Ten" character varying(100) NOT NULL,
    "HeSo" numeric(5,2) NOT NULL,
    CONSTRAINT "CK_DauDiem_HeSo" CHECK (("HeSo" > (0)::numeric))
);

CREATE TABLE public."Diem" (
    "DiemId" integer NOT NULL,
    "HocVienId" integer NOT NULL,
    "LopHocId" integer NOT NULL,
    "DauDiemId" integer NOT NULL,
    "DiemSo" numeric(4,2) NOT NULL,
    "NgayCapNhat" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "GhiChu" character varying(255),
    CONSTRAINT "CK_Diem_DiemSo" CHECK ((("DiemSo" >= (0)::numeric) AND ("DiemSo" <= (10)::numeric)))
);

CREATE TABLE public."DiemDanh" (
    "DiemDanhId" integer NOT NULL,
    "BuoiHocId" integer NOT NULL,
    "HocVienId" integer NOT NULL,
    "TrangThai" character varying(30) NOT NULL,
    "GhiChu" character varying(255),
    CONSTRAINT "CK_DiemDanh_TrangThai" CHECK ((("TrangThai")::text = ANY ((ARRAY['DiMuon'::character varying, 'VangKhongPhep'::character varying, 'VangCoPhep'::character varying, 'CoMat'::character varying])::text[])))
);

CREATE TABLE public."GhiDanh" (
    "GhiDanhId" integer NOT NULL,
    "HocVienId" integer NOT NULL,
    "LopHocId" integer NOT NULL,
    "NgayGhiDanh" date DEFAULT CURRENT_DATE NOT NULL,
    "TrangThai" character varying(30) DEFAULT 'DangHoc'::character varying NOT NULL,
    CONSTRAINT "CK_GhiDanh_TrangThai" CHECK ((("TrangThai")::text = ANY ((ARRAY['Huy'::character varying, 'HoanThanh'::character varying, 'BaoLuu'::character varying, 'DangHoc'::character varying])::text[])))
);

CREATE TABLE public."GiaoVien" (
    "GiaoVienId" integer NOT NULL,
    "NguoiDungId" integer NOT NULL,
    "HoTen" character varying(100) NOT NULL,
    "ChuyenMon" character varying(100),
    "ThuLaoMoiTiet" numeric(18,2) DEFAULT 0 NOT NULL,
    CONSTRAINT "CK_GiaoVien_ThuLao" CHECK (("ThuLaoMoiTiet" >= (0)::numeric))
);

CREATE TABLE public."HocVien" (
    "HocVienId" integer NOT NULL,
    "NguoiDungId" integer NOT NULL,
    "HoTen" character varying(100) NOT NULL,
    "NgaySinh" date,
    "SoDienThoai" character varying(15)
);

CREATE TABLE public."KhoaHoc" (
    "KhoaHocId" integer NOT NULL,
    "MonId" integer NOT NULL,
    "Ten" character varying(150) NOT NULL,
    "TrinhDo" character varying(50),
    "SoBuoi" integer NOT NULL,
    "HocPhi" numeric(18,2) NOT NULL,
    CONSTRAINT "CK_KhoaHoc_HocPhi" CHECK (("HocPhi" >= (0)::numeric)),
    CONSTRAINT "CK_KhoaHoc_SoBuoi" CHECK (("SoBuoi" > 0))
);

CREATE TABLE public."LichLop" (
    "LichLopId" integer NOT NULL,
    "LopHocId" integer NOT NULL,
    "ThuTrongTuan" smallint NOT NULL,
    "GioBatDau" time without time zone NOT NULL,
    "GioKetThuc" time without time zone NOT NULL,
    CONSTRAINT "CK_LichLop_Gio" CHECK (("GioKetThuc" > "GioBatDau")),
    CONSTRAINT "CK_LichLop_Thu" CHECK ((("ThuTrongTuan" >= 2) AND ("ThuTrongTuan" <= 8)))
);

CREATE TABLE public."LopHoc" (
    "LopHocId" integer NOT NULL,
    "KhoaHocId" integer NOT NULL,
    "MaLop" character varying(30) NOT NULL,
    "GiaoVienId" integer NOT NULL,
    "PhongId" integer NOT NULL,
    "SiSoToiDa" integer NOT NULL,
    "KhaiGiang" date NOT NULL,
    "BeGiang" date NOT NULL,
    "TrangThai" character varying(30) DEFAULT 'SAP_KHAI_GIANG'::character varying NOT NULL,
    CONSTRAINT "CK_LopHoc_Ngay" CHECK (("BeGiang" >= "KhaiGiang")),
    CONSTRAINT "CK_LopHoc_SiSo" CHECK (("SiSoToiDa" > 0)),
    CONSTRAINT "CK_LopHoc_TrangThai" CHECK ((("TrangThai")::text = ANY ((ARRAY['HUY'::character varying, 'DA_KET_THUC'::character varying, 'DANG_HOC'::character varying, 'SAP_KHAI_GIANG'::character varying])::text[])))
);

CREATE TABLE public."MonHoc" (
    "MonHocId" integer NOT NULL,
    "Ten" character varying(100) NOT NULL
);

CREATE TABLE public."NguoiDung" (
    "NguoiDungId" integer NOT NULL,
    "TenDangNhap" character varying(50) NOT NULL,
    "MatKhau" character varying(255) NOT NULL,
    "Email" character varying(100),
    "VaiTro" character varying(30) NOT NULL,
    "TrangThai" boolean DEFAULT true NOT NULL,
    CONSTRAINT "CK_NguoiDung_VaiTro" CHECK ((("VaiTro")::text = ANY ((ARRAY['PHU_HUYNH'::character varying, 'HOC_VIEN'::character varying, 'GIAO_VIEN'::character varying, 'ADMIN'::character varying])::text[])))
);

CREATE TABLE public."PhieuThu" (
    "PhieuThuId" integer NOT NULL,
    "GhiDanhId" integer NOT NULL,
    "SoTien" numeric(18,2) NOT NULL,
    "HinhThuc" character varying(50) NOT NULL,
    "ThoiDiem" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "NguoiThuId" integer,
    CONSTRAINT "CK_PhieuThu_HinhThuc" CHECK ((("HinhThuc")::text = ANY ((ARRAY['THE'::character varying, 'CHUYEN_KHOAN'::character varying, 'TIEN_MAT'::character varying])::text[]))),
    CONSTRAINT "CK_PhieuThu_SoTien" CHECK (("SoTien" > (0)::numeric))
);

CREATE TABLE public."PhongHoc" (
    "PhongHocId" integer NOT NULL,
    "TenPhong" character varying(50) NOT NULL,
    "SucChua" integer NOT NULL,
    CONSTRAINT "CK_PhongHoc_SucChua" CHECK (("SucChua" > 0))
);

CREATE TABLE public."ThongBaoLop" (
    "ThongBaoId" integer NOT NULL,
    "LopHocId" integer NOT NULL,
    "TieuDe" character varying(200) NOT NULL,
    "NoiDung" character varying(1000) NOT NULL,
    "DangLuc" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE public."BuoiHoc" ALTER COLUMN "BuoiHocId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."BuoiHoc_BuoiHocId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public."DauDiem" ALTER COLUMN "DauDiemId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."DauDiem_DauDiemId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public."DiemDanh" ALTER COLUMN "DiemDanhId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."DiemDanh_DiemDanhId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public."Diem" ALTER COLUMN "DiemId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."Diem_DiemId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public."GhiDanh" ALTER COLUMN "GhiDanhId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."GhiDanh_GhiDanhId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public."GiaoVien" ALTER COLUMN "GiaoVienId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."GiaoVien_GiaoVienId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public."HocVien" ALTER COLUMN "HocVienId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."HocVien_HocVienId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public."KhoaHoc" ALTER COLUMN "KhoaHocId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."KhoaHoc_KhoaHocId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public."LichLop" ALTER COLUMN "LichLopId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."LichLop_LichLopId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public."LopHoc" ALTER COLUMN "LopHocId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."LopHoc_LopHocId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public."MonHoc" ALTER COLUMN "MonHocId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."MonHoc_MonHocId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public."NguoiDung" ALTER COLUMN "NguoiDungId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."NguoiDung_NguoiDungId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public."PhieuThu" ALTER COLUMN "PhieuThuId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."PhieuThu_PhieuThuId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public."PhongHoc" ALTER COLUMN "PhongHocId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."PhongHoc_PhongHocId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE public."ThongBaoLop" ALTER COLUMN "ThongBaoId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."ThongBaoLop_ThongBaoId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


-- ============================================================
-- HE THONG QUAN LY TRUNG TAM NGOAI NGU - TIN HOC
-- KHOA CHINH VA RANG BUOC UNIQUE
-- PostgreSQL / Supabase
-- File duoc tach tu schema dump hien tai; giu nguyen logic SQL.
-- ============================================================

ALTER TABLE ONLY public."BuoiHoc"
    ADD CONSTRAINT "BuoiHoc_pkey" PRIMARY KEY ("BuoiHocId");

ALTER TABLE ONLY public."DauDiem"
    ADD CONSTRAINT "DauDiem_pkey" PRIMARY KEY ("DauDiemId");

ALTER TABLE ONLY public."DiemDanh"
    ADD CONSTRAINT "DiemDanh_pkey" PRIMARY KEY ("DiemDanhId");

ALTER TABLE ONLY public."Diem"
    ADD CONSTRAINT "Diem_pkey" PRIMARY KEY ("DiemId");

ALTER TABLE ONLY public."GhiDanh"
    ADD CONSTRAINT "GhiDanh_pkey" PRIMARY KEY ("GhiDanhId");

ALTER TABLE ONLY public."GiaoVien"
    ADD CONSTRAINT "GiaoVien_pkey" PRIMARY KEY ("GiaoVienId");

ALTER TABLE ONLY public."HocVien"
    ADD CONSTRAINT "HocVien_pkey" PRIMARY KEY ("HocVienId");

ALTER TABLE ONLY public."KhoaHoc"
    ADD CONSTRAINT "KhoaHoc_pkey" PRIMARY KEY ("KhoaHocId");

ALTER TABLE ONLY public."LichLop"
    ADD CONSTRAINT "LichLop_pkey" PRIMARY KEY ("LichLopId");

ALTER TABLE ONLY public."LopHoc"
    ADD CONSTRAINT "LopHoc_pkey" PRIMARY KEY ("LopHocId");

ALTER TABLE ONLY public."MonHoc"
    ADD CONSTRAINT "MonHoc_pkey" PRIMARY KEY ("MonHocId");

ALTER TABLE ONLY public."NguoiDung"
    ADD CONSTRAINT "NguoiDung_pkey" PRIMARY KEY ("NguoiDungId");

ALTER TABLE ONLY public."PhieuThu"
    ADD CONSTRAINT "PhieuThu_pkey" PRIMARY KEY ("PhieuThuId");

ALTER TABLE ONLY public."PhongHoc"
    ADD CONSTRAINT "PhongHoc_pkey" PRIMARY KEY ("PhongHocId");

ALTER TABLE ONLY public."ThongBaoLop"
    ADD CONSTRAINT "ThongBaoLop_pkey" PRIMARY KEY ("ThongBaoId");

ALTER TABLE ONLY public."BuoiHoc"
    ADD CONSTRAINT "UQ_BuoiHoc_Lop_Ngay" UNIQUE ("LopHocId", "Ngay");

ALTER TABLE ONLY public."DiemDanh"
    ADD CONSTRAINT "UQ_DiemDanh_BuoiHoc_HocVien" UNIQUE ("BuoiHocId", "HocVienId");

ALTER TABLE ONLY public."Diem"
    ADD CONSTRAINT "UQ_Diem_HocVien_Lop_DauDiem" UNIQUE ("HocVienId", "LopHocId", "DauDiemId");

ALTER TABLE ONLY public."GhiDanh"
    ADD CONSTRAINT "UQ_GhiDanh_HocVien_Lop" UNIQUE ("HocVienId", "LopHocId");

ALTER TABLE ONLY public."GiaoVien"
    ADD CONSTRAINT "UQ_GiaoVien_NguoiDung" UNIQUE ("NguoiDungId");

ALTER TABLE ONLY public."HocVien"
    ADD CONSTRAINT "UQ_HocVien_NguoiDung" UNIQUE ("NguoiDungId");

ALTER TABLE ONLY public."LopHoc"
    ADD CONSTRAINT "UQ_LopHoc_MaLop" UNIQUE ("MaLop");

ALTER TABLE ONLY public."MonHoc"
    ADD CONSTRAINT "UQ_MonHoc_Ten" UNIQUE ("Ten");

ALTER TABLE ONLY public."NguoiDung"
    ADD CONSTRAINT "UQ_NguoiDung_TenDangNhap" UNIQUE ("TenDangNhap");

ALTER TABLE ONLY public."PhongHoc"
    ADD CONSTRAINT "UQ_PhongHoc_TenPhong" UNIQUE ("TenPhong");


-- ============================================================
-- HE THONG QUAN LY TRUNG TAM NGOAI NGU - TIN HOC
-- CAC KHOA NGOAI GIUA CAC BANG
-- PostgreSQL / Supabase
-- File duoc tach tu schema dump hien tai; giu nguyen logic SQL.
-- ============================================================

ALTER TABLE ONLY public."BuoiHoc"
    ADD CONSTRAINT "FK_BuoiHoc_LopHoc" FOREIGN KEY ("LopHocId") REFERENCES public."LopHoc"("LopHocId");

ALTER TABLE ONLY public."DauDiem"
    ADD CONSTRAINT "FK_DauDiem_KhoaHoc" FOREIGN KEY ("KhoaHocId") REFERENCES public."KhoaHoc"("KhoaHocId");

ALTER TABLE ONLY public."DiemDanh"
    ADD CONSTRAINT "FK_DiemDanh_BuoiHoc" FOREIGN KEY ("BuoiHocId") REFERENCES public."BuoiHoc"("BuoiHocId");

ALTER TABLE ONLY public."DiemDanh"
    ADD CONSTRAINT "FK_DiemDanh_HocVien" FOREIGN KEY ("HocVienId") REFERENCES public."HocVien"("HocVienId");

ALTER TABLE ONLY public."Diem"
    ADD CONSTRAINT "FK_Diem_DauDiem" FOREIGN KEY ("DauDiemId") REFERENCES public."DauDiem"("DauDiemId");

ALTER TABLE ONLY public."Diem"
    ADD CONSTRAINT "FK_Diem_HocVien" FOREIGN KEY ("HocVienId") REFERENCES public."HocVien"("HocVienId");

ALTER TABLE ONLY public."Diem"
    ADD CONSTRAINT "FK_Diem_LopHoc" FOREIGN KEY ("LopHocId") REFERENCES public."LopHoc"("LopHocId");

ALTER TABLE ONLY public."GhiDanh"
    ADD CONSTRAINT "FK_GhiDanh_HocVien" FOREIGN KEY ("HocVienId") REFERENCES public."HocVien"("HocVienId");

ALTER TABLE ONLY public."GhiDanh"
    ADD CONSTRAINT "FK_GhiDanh_LopHoc" FOREIGN KEY ("LopHocId") REFERENCES public."LopHoc"("LopHocId");

ALTER TABLE ONLY public."GiaoVien"
    ADD CONSTRAINT "FK_GiaoVien_NguoiDung" FOREIGN KEY ("NguoiDungId") REFERENCES public."NguoiDung"("NguoiDungId");

ALTER TABLE ONLY public."HocVien"
    ADD CONSTRAINT "FK_HocVien_NguoiDung" FOREIGN KEY ("NguoiDungId") REFERENCES public."NguoiDung"("NguoiDungId");

ALTER TABLE ONLY public."KhoaHoc"
    ADD CONSTRAINT "FK_KhoaHoc_MonHoc" FOREIGN KEY ("MonId") REFERENCES public."MonHoc"("MonHocId");

ALTER TABLE ONLY public."LichLop"
    ADD CONSTRAINT "FK_LichLop_LopHoc" FOREIGN KEY ("LopHocId") REFERENCES public."LopHoc"("LopHocId");

ALTER TABLE ONLY public."LopHoc"
    ADD CONSTRAINT "FK_LopHoc_GiaoVien" FOREIGN KEY ("GiaoVienId") REFERENCES public."GiaoVien"("GiaoVienId");

ALTER TABLE ONLY public."LopHoc"
    ADD CONSTRAINT "FK_LopHoc_KhoaHoc" FOREIGN KEY ("KhoaHocId") REFERENCES public."KhoaHoc"("KhoaHocId");

ALTER TABLE ONLY public."LopHoc"
    ADD CONSTRAINT "FK_LopHoc_PhongHoc" FOREIGN KEY ("PhongId") REFERENCES public."PhongHoc"("PhongHocId");

ALTER TABLE ONLY public."PhieuThu"
    ADD CONSTRAINT "FK_PhieuThu_GhiDanh" FOREIGN KEY ("GhiDanhId") REFERENCES public."GhiDanh"("GhiDanhId");

ALTER TABLE ONLY public."PhieuThu"
    ADD CONSTRAINT "FK_PhieuThu_NguoiThu" FOREIGN KEY ("NguoiThuId") REFERENCES public."NguoiDung"("NguoiDungId");

ALTER TABLE ONLY public."ThongBaoLop"
    ADD CONSTRAINT "FK_ThongBaoLop_LopHoc" FOREIGN KEY ("LopHocId") REFERENCES public."LopHoc"("LopHocId");


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


-- ============================================================
-- HE THONG QUAN LY TRUNG TAM NGOAI NGU - TIN HOC
-- TRIGGER KICH HOAT KIEM TRA NGHIEP VU
-- PostgreSQL / Supabase
-- File duoc tach tu schema dump hien tai; giu nguyen logic SQL.
-- ============================================================

CREATE TRIGGER "TriggerKiemTraSiSo" BEFORE INSERT OR UPDATE ON public."GhiDanh" FOR EACH ROW EXECUTE FUNCTION public."KiemTraSiSoGhiDanh"();

CREATE TRIGGER "TriggerKiemTraTrungLich" BEFORE INSERT OR UPDATE ON public."LichLop" FOR EACH ROW EXECUTE FUNCTION public."KiemTraTrungLich"();


-- ============================================================
-- HE THONG QUAN LY TRUNG TAM NGOAI NGU - TIN HOC
-- BAT ROW LEVEL SECURITY CHO CAC BANG
-- PostgreSQL / Supabase
-- File duoc tach tu schema dump hien tai; giu nguyen logic SQL.
-- ============================================================

ALTER TABLE public."BuoiHoc" ENABLE ROW LEVEL SECURITY;

ALTER TABLE public."DauDiem" ENABLE ROW LEVEL SECURITY;

ALTER TABLE public."Diem" ENABLE ROW LEVEL SECURITY;

ALTER TABLE public."DiemDanh" ENABLE ROW LEVEL SECURITY;

ALTER TABLE public."GhiDanh" ENABLE ROW LEVEL SECURITY;

ALTER TABLE public."GiaoVien" ENABLE ROW LEVEL SECURITY;

ALTER TABLE public."HocVien" ENABLE ROW LEVEL SECURITY;

ALTER TABLE public."KhoaHoc" ENABLE ROW LEVEL SECURITY;

ALTER TABLE public."LichLop" ENABLE ROW LEVEL SECURITY;

ALTER TABLE public."LopHoc" ENABLE ROW LEVEL SECURITY;

ALTER TABLE public."MonHoc" ENABLE ROW LEVEL SECURITY;

ALTER TABLE public."NguoiDung" ENABLE ROW LEVEL SECURITY;

ALTER TABLE public."PhieuThu" ENABLE ROW LEVEL SECURITY;

ALTER TABLE public."PhongHoc" ENABLE ROW LEVEL SECURITY;

ALTER TABLE public."ThongBaoLop" ENABLE ROW LEVEL SECURITY;
