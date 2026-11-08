-- ============================================================
-- HE THONG QUAN LY TRUNG TAM NGOAI NGU - TIN HOC
-- TRIGGER KICH HOAT KIEM TRA NGHIEP VU
-- PostgreSQL / Supabase
-- File duoc tach tu schema dump hien tai; giu nguyen logic SQL.
-- ============================================================

CREATE TRIGGER "TriggerKiemTraSiSo" BEFORE INSERT OR UPDATE ON public."GhiDanh" FOR EACH ROW EXECUTE FUNCTION public."KiemTraSiSoGhiDanh"();

CREATE TRIGGER "TriggerKiemTraTrungLich" BEFORE INSERT OR UPDATE ON public."LichLop" FOR EACH ROW EXECUTE FUNCTION public."KiemTraTrungLich"();
