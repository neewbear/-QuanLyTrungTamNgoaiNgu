# CƠ SỞ DỮ LIỆU – HỆ THỐNG QUẢN LÝ TRUNG TÂM NGOẠI NGỮ – TIN HỌC

## 1. Giới thiệu

Thư mục này chứa toàn bộ mã nguồn SQL thuộc phần cơ sở dữ liệu của đề tài. Nội dung được tổ chức theo từng nhóm chức năng, bao gồm cấu trúc dữ liệu, các ràng buộc, nghiệp vụ xử lý, chức năng đặc thù và báo cáo thống kê.

Hệ quản trị cơ sở dữ liệu sử dụng: **PostgreSQL 17 / Supabase**.

## 2. Cấu trúc thư mục

| Thư mục | Nội dung |
|---|---|
| `00_Backup/` | Lưu bản sao schema gốc để đối chiếu và phục hồi khi cần. |
| `01_CauTrucCoBan/` | Tạo bảng, cấu hình identity, khóa chính, UNIQUE, khóa ngoại và RLS. |
| `02_DuLieuMau/` | Ghi chú về dữ liệu mẫu và tình trạng xuất dữ liệu. |
| `03_NghiepVuCoBan/` | Các hàm điểm danh nhiều học viên và tính điểm tổng kết. |
| `04_NghiepVuDacThu/` | Các hàm kiểm tra sĩ số, trùng lịch và những trigger tương ứng. |
| `05_BaoCaoThongKe/` | Các hàm báo cáo chuyên cần, công nợ, doanh thu, thù lao giáo viên và cảnh báo vắng học. |
| `06_KiemThu/` | Lưu các kịch bản và kết quả kiểm thử cơ sở dữ liệu. |

## 3. Hướng dẫn triển khai

Có hai cách tham khảo mã nguồn:

**Cách 1 – Sử dụng file tổng hợp**

Chạy file:

`01_CauTrucCoBan/00_TaoMoiCSDL_TheoThuTu.sql`

File này tổng hợp các lệnh tạo cấu trúc CSDL theo thứ tự triển khai.

**Cách 2 – Theo dõi từng thành phần**

Các file được chia theo thứ tự:

1. `01_TaoBang.sql`: tạo các bảng.
2. `02_KhoaChinh_Unique.sql`: thiết lập khóa chính và ràng buộc UNIQUE.
3. `03_KhoaNgoai.sql`: thiết lập các khóa ngoại.
4. `04_BatRLS.sql`: bật Row Level Security cho các bảng.

Sau khi hoàn thành cấu trúc cơ bản, có thể tham khảo các nhóm nghiệp vụ và báo cáo tại những thư mục tiếp theo.

**Lưu ý:** Hai cách trên là hai phương án thay thế nhau. Không chạy file tổng hợp rồi chạy lại các file thành phần trên cùng một CSDL, vì có thể phát sinh lỗi do đối tượng đã tồn tại.

Các script tạo mới chỉ dành cho môi trường chưa có các đối tượng tương ứng. Không chạy lại trên Supabase đang chứa dữ liệu của dự án.

## 4. Các thành phần cơ sở dữ liệu

Cấu trúc hiện tại gồm:

- 15 bảng dữ liệu.
- 15 khóa chính.
- 9 ràng buộc UNIQUE.
- 19 khóa ngoại.
- 9 hàm SQL phục vụ nghiệp vụ và báo cáo.
- 2 trigger xử lý nghiệp vụ.
- 15 bảng được bật Row Level Security (RLS).

Các nghiệp vụ đáng chú ý:

- Kiểm tra sĩ số khi học viên đăng ký lớp.
- Phát hiện trùng lịch giáo viên hoặc phòng học.
- Điểm danh nhiều học viên.
- Tính điểm tổng kết.
- Theo dõi chuyên cần và cảnh báo tình trạng vắng học.
- Tổng hợp công nợ, doanh thu và thù lao giáo viên.

## 5. Lưu ý về dữ liệu và bảo mật

- `00_Backup/schema_full_backup.sql` là bản dump schema-only dùng để đối chiếu.
- Bản dump không chứa các lệnh INSERT hoặc COPY để tái tạo dữ liệu mẫu.
- Dữ liệu hiện có được quản lý trực tiếp trên Supabase; việc sắp xếp các file SQL không làm thay đổi dữ liệu này.
- Các bảng đã bật RLS nhưng bản dump hiện tại không chứa các policy. Việc cấu hình policy cần được thực hiện và đánh giá riêng khi triển khai quyền truy cập.
- Không đưa thông tin kết nối, mật khẩu hoặc khóa bí mật của Supabase vào repository.

## 6. Tình trạng hoàn thiện

Các file SQL đã được phân loại theo nhóm chức năng để thuận tiện cho việc đọc, kiểm tra, bảo trì và triển khai.

Dữ liệu mẫu và các kịch bản kiểm thử riêng sẽ được bổ sung khi có nội dung được xác nhận và kết quả thực thi tương ứng.