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
