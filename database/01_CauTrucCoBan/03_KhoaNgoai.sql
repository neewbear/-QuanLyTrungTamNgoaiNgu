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
