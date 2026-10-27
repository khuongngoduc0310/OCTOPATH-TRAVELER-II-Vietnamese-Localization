# Danh mục tên kỹ năng Octopath Traveler II

- `skill_name_catalog.csv`: 144 tên được liên kết trực tiếp từ `JobData` → `AbilitySetData`/`SupportAbilityData`: 96 kỹ năng nghề (8 mỗi nghề, gồm kỹ năng thần thánh) và 48 kỹ năng hỗ trợ (4 mỗi nghề), qua 12 nghề. Tất cả 144 mục có bản tiếng Việt.
- `equipment_name_catalog.csv`: 574 hàng trang bị từ `ItemDB` (kiếm, thương, dao găm, rìu, cung, trượng, khiên, giáp và phụ kiện), nối tên/mô tả Anh–Việt–Nhật cùng chỉ số và giá. 526 hàng có khóa GameText tương ứng; 48 khóa chưa có mục trong GameTextEN nên vẫn giữ mã trang bị và chỉ số để đối chiếu.
- `ability_name_inventory.csv`: 2.887 tên duy nhất trong `AbilityData` và `SupportAbilityData`, đã gộp các biến thể Boost theo khóa tên. Bao gồm các kỹ năng khác ngoài danh sách nghề, như kỹ năng nhân vật, NPC/quái vật và hành động hệ thống. Cột `Scope` đánh dấu các mục nối được trực tiếp với JobData; phần còn lại cần rà thủ công để tách EX, Sức mạnh tiềm ẩn, kỹ năng học được, NPC và quái vật.
- Cột tiếng Anh/Việt/Nhật và mô tả được nối bằng khóa GameText. 71/2.887 khóa tên chưa có hàng GameText khớp nên các cột tên sẽ để trống; mã kỹ năng vẫn có trong `AbilityCodes`.
- Nguồn dữ liệu cơ chế: PAK đang cài `Octopath_Traveler2-WindowsNoEditor.pak`; trích xuất qua CUE4Parse với `GAME_UE4_26`. Bảng tên tiếng Việt lấy từ `translations/gametext_en_vi.csv`; tiếng Nhật đối chiếu `gametext_en_ja_reference.csv`.

Cột `GameTextKey` chỉ điểm tới mục cần chỉnh trong bảng dịch. Danh mục này là công cụ rà soát; nó không tự ý sửa các bản dịch.
- Rà phong cách tên theo hướng RPG (2026-10-27): đã biên tập lại 107 tên kỹ năng nghề/hỗ trợ và 145 tên trang bị theo khóa GameText; lưu bản cũ/mới/lý do theo lô tối đa 500 trong `name_localization_review/`. Bản dịch đã đóng gói vào PAK v213 (388 tệp, round-trip 14.633 dòng). Danh mục 2.887 năng lực có cả NPC/quái/hệ thống; lượt này chỉ đổi nhóm có thể xác định chắc chắn là kỹ năng nghề/hỗ trợ người chơi, không sửa hàng loạt kỹ năng NPC/quái.
