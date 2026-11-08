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
