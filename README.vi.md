# OCTOPATH TRAVELER II — Bản dịch tiếng Việt

**Phiên bản 213 · Bản Việt hóa cộng đồng không chính thức · PC Windows**

Bộ phát hành gồm PAK cài sẵn và các bảng dịch có thể chỉnh sửa. Cần có bản PC của OCTOPATH TRAVELER II. Các tệp nguồn cho phép biên tập thoại, giao diện, thông tin nhân vật/vật phẩm và thuật ngữ kỹ năng/trang bị mà không thay đổi cơ chế game.

## Cài đặt nhanh

1. Tải và giải nén gói tất cả trong một; hoặc tải riêng PAK phát hành và đặt cạnh script trong thư mục `release-assets`.
2. Mở PowerShell tại thư mục này rồi chạy:

   ```powershell
   .\Install-Vietnamese.ps1 -GameRoot "C:\Games\OCTOPATH TRAVELER II"
   ```

   `GameRoot` là thư mục chứa `Octopath_Traveler2`.
3. Thoát hẳn game rồi mở lại. Script kiểm tra SHA-256 của PAK trước khi cài.

Gỡ bản dịch bằng `Uninstall-Vietnamese.ps1 -GameRoot "<thư mục game>"`. Script chỉ gỡ PAK v213 này. Nếu cài thủ công, chép `zzz_Octopath_Traveler2_Vietnamese_v213_P.pak` vào `Octopath_Traveler2\Content\Paks\~mods`.

## Chỉnh sửa bản dịch

Chỉnh CSV UTF-8 trong `translations/` bằng ứng dụng bảng tính hoặc trình soạn thảo văn bản. Giữ các cột `Path`, `Key`, `Source`, `Translation`; không sửa khóa dòng hoặc placeholder định dạng. Chỉ sửa phần tiếng Việt trong cột `Translation`. `catalogs/` và `GLOSSARY.md` hỗ trợ tra cứu thuật ngữ/ngữ cảnh; nhật ký rà tên ghi lại các thay đổi gần đây.

## Tự build PAK sau khi sửa

Script build giải nén PAK v213, nhập lại bốn CSV có thể chỉnh sửa, rồi đóng gói đủ 388 tệp. PAK đầu vào và CSV nguồn được giữ nguyên.

1. Tải [repak v0.2.3 cho Windows](https://github.com/trumank/repak/releases/tag/v0.2.3) và [UassetLocalize](https://github.com/rm-NoobInCoding/UassetLocalize). SHA-256 của gói repak đã kiểm tra được ghi trong `tools/README.md`.
2. Chạy:

   ```powershell
   .\Build-Translation.ps1 `
     -BasePak .\release-assets\zzz_Octopath_Traveler2_Vietnamese_v213_P.pak `
     -RepakPath C:\Tools\repak.exe `
     -UassetLocalizePath C:\Tools\UassetLocalize.Cli.exe
   ```

3. PAK mới nằm trong `build-output/`. Có thể cài thủ công; nếu phát hành bản mới, cập nhật đường dẫn PAK và SHA-256 trong script cài.

Xem `CONTRIBUTING.md` để biết quy tắc biên tập/kiểm tra. Bản dịch nguồn và script do dự án viết dùng giấy phép CC BY-NC-SA 4.0; xem `LICENSE.md`. Tài sản game và nhãn hiệu vẫn thuộc chủ sở hữu tương ứng. Đây là bản dịch cộng đồng, không liên kết hay được Square Enix bảo trợ.
