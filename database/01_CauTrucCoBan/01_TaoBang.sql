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
