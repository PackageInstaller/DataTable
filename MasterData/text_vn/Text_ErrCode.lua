__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_CMD_UNDEFINED_Desc = {
    Text = "Lệnh không tồn tại"
  },
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "Sự kiện đã kết thúc"
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "Số ngày đăng nhập không đủ, chưa đủ điều kiện nhận thưởng"
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "Tham gia hoạt động, điều kiện chưa đạt"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "Không tồn tại sự kiện này"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "Sự kiện chưa mở"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "Hoạt động chưa bắt đầu"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "Nhiệm vụ sự kiện chưa hoàn thành"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "Hoạt động dùng thử, không thể nhận thưởng nếu chưa hoàn thành cấp độ"
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "Trong hoạt động thử nghiệm, không tìm thấy cấp độ này"
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "Trong hoạt động này, Người Giữ Gìn đã hỗ trợ bạn một lần"
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "Hoạt động này yêu cầu Người Giữ Gìn đã theo dõi lẫn nhau mới có thể hỗ trợ trong chiến đấu"
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "Danh sách trợ lý thường dùng của Người giữ gìn đã đạt giới hạn, xin điều chỉnh danh sách trợ lý thường dùng"
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "Kỹ năng chưa đáp ứng điều kiện đã thiết lập"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "Cấp độ thăng cấp của thân thể được đánh thức không đủ"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "Thân thể thức tỉnh chưa đến thời gian mở"
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "Thân thể được đánh thức đã dùng rồi"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "Không được lặp lại chặn"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "Bạn đã bị đưa vào danh sách đen, không thể thao tác"
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "Bạn đã bị đối phương đưa vào danh sách đen, không thể theo dõi và thích"
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "Bạn đã thêm đối phương vào danh sách đen, không thể thích và theo dõi"
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "Số người đã đưa vào danh sách đen đạt giới hạn"
  },
  ErrCode_ERR_BATTLE_CREATE_FAILED_Desc = {
    Text = "Tạo trận đấu thất bại"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "Bạn không có đủ tiền để mua cấp độ của thẻ thông hành"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "Thao tác thất bại"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "Thẻ thông hành chưa thiết lập giá đặc quyền của việc mua"
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "Quyền cấp độ thẻ thông hành đã đạt tối đa, không thể mua lại"
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "Cấp quyền không đủ, không thể nhận"
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "Không có phần thưởng này"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "Đã nhận phần thưởng"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "Nguồn lỏng bạc tâm thiếu"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "Số lần mua phiếu không đủ"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "Vật tạo ra không thể được tăng cường"
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "Thẻ này đã đạt cấp độ tối đa, không thể nâng cấp thêm"
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "Thẻ này không thể nâng cấp"
  },
  ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc = {
    Text = "Chứa từ chặn"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "Lặp lại bình luận"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "Lặp lại xóa bỏ"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "Lặp lại thích"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "Lặp lại hủy thích"
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "Chiều dài vượt quá giới hạn"
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "Những bình luận thích đã bị xóa"
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "Thời gian bình luận đã hết"
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Thẻ độc quyền nâng cấp, không giới hạn số lần"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "Không tìm thấy cốt truyện cho thử thách bản sao"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "Không tìm thấy nhiệm vụ cốt truyện của bản sao thử thách"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "Dữ liệu cấp độ Thám hiểm Giấc mơ đang được cập nhật, vui lòng thử lại sau."
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "Nhiệm vụ thách thức đã hoàn thành, không thể nhận lại phần thưởng"
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "Nhiệm vụ thách thức chưa hoàn thành, chưa thể nhận phần thưởng"
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "Phần thưởng chương chưa đạt số điểm yêu cầu"
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "Bạn đã nhận phần thưởng chương"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "Không tìm thấy nút hiện tại"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "Tên nhân vật đã bị trùng"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "Lỗi truyền dữ liệu từ máy khách"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "Không thể tìm thấy nút hiện tại để đóng"
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "Lỗi bảng cấu hình"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "Không thể nhận được phần thưởng"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "Thưởng chưa đủ điều kiện để nhận"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "Cấp độ không có dữ liệu điểm bài tập"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "Không có điểm nhiệm vụ cho bản sao này"
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "Chưa tìm thấy mô-đun đề tài"
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "Chưa tìm thấy nhiệm vụ"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "Không tìm thấy dữ liệu của các phần trong chủ đề"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "Đơn vị đã được gửi, không cần gửi lại"
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "Các nhiệm vụ phụ chưa hoàn thành"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "Nhiệm vụ đã hoàn thành"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "Nhiệm vụ trong đơn vị chưa hoàn thành hết, chưa thể gửi"
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "Đăng ký Người Giữ Gìn mới hiện đang tạm ngưng"
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "Chưa có nhân vật, cần tạo mới"
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "Số lần sử dụng lệnh tùy chỉnh đã vượt quá giới hạn"
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "Sáng tạo tăng cường"
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "Linh phìpeptide đã đủ, không cần thêm"
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "Hiện tại không thể thực hiện nghi lễ"
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "Đồ trang sức không tồn tại"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "Sai vùng sự kiện"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "Thẻ bài sự kiện không tồn tại"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "Số lượng thẻ bài chọn sự kiện quá nhiều"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "Sự kiện lựa chọn tạo vật không tồn tại"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "Số lượng sự kiện sáng tạo được chọn quá nhiều"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = "Có lỗi trong phần loại của bảng cấu hình sự kiện bản sao"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "Lỗi dữ liệu sự kiện"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "Chiến đấu rơi thẻ bài không giới hạn số lần"
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "Trong chiến đấu, việc làm mới vật phẩm rơi ra không có giới hạn số lần"
  },
  ErrCode_ERR_EVENT_FINISH_Desc = {
    Text = "Sự kiện phiên bản đã hoàn thành"
  },
  ErrCode_ERR_EVENT_NOT_FIND_Desc = {
    Text = "Phiên bản phụ không tồn tại"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "Mật bạc không đủ để mua"
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "Không tìm thấy nút này trong sự kiện"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "Sự kiện nhóm ngẫu nhiên không có dữ liệu"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "Chức năng điểm liên lạc bị khóa lại"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "Chức năng đã chọn tại trại không thể được chọn lại"
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "Các tính năng của trại đã hết lượt sử dụng"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "Sự kiện cửa hàng làm mới không giới hạn số lần"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "Số lần xóa thẻ bài trong cửa hàng sự kiện đã hết"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "Số lượng thẻ bài chọn sự kiện không đủ"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "Không đủ số lượng vật phẩm sáng tạo"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "Không tìm thấy thông tin thẻ độc quyền"
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "Đường nâng cấp không có ID nhân vật đã cấu hình"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "Thẻ độc quyền chưa được mở khóa"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "Thẻ đặc biệt không có sự thay đổi nên không thể chuyển đổi"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "Việc chuyển đổi thẻ độc quyền đã thất bại"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "Thẻ độc quyền chưa nâng cấp không thể thay đổi"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "Không tìm thấy uuid của thẻ độc quyền này"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "Trợ chiến thức tỉnh thể đã hết hiệu lực, vui lòng làm mới danh sách trợ chiến để chọn trợ chiến thức tỉnh thể."
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "Đạo cụ chế tạo chưa mở khóa"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "Không đủ tiền tệ để chế tạo đạo cụ"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc = {
    Text = "Không đủ nguyên liệu khác để tổng hợp"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "Công trình đã tồn tại, không thể xây dựng thêm"
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "Vị trí đã có thân thể được đánh thức, không thể nhập trú"
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "Công trình đã đạt cấp độ tối đa"
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "Công trình không tồn tại"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "Điều kiện nâng cấp/xây dựng công trình không đủ"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "Không đủ đạo cụ để nâng cấp/xây dựng"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "Hiện tại không có phần thưởng để nhận ở điểm nút hiện tại"
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "Hết lượt thử thách"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "Sức khỏe hiện tại quá thấp, bạn đã yếu đuối."
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "Mở khóa khi đạt cấp 2 trong bản sao khám phá"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "Sau khi hoàn thành một lần khám phá, có thể tiến hành khám phá ngay lập tức"
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "Phiên bản lỗi"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "Không tìm thấy phó bản"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "Nút chưa mở khóa"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "Nút đã được hoàn thành"
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "Điểm chưa hoàn thành"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "Các nút không kề nhau"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "Cửa hàng không đủ số lần làm mới"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "Cấp độ người chơi chưa đạt"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "Giới thiệu chứa ký tự không hợp lệ, vui lòng nhập lại"
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "Đối phương đang điều tra hoặc tham gia các hoạt động khác"
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "Giá trị chỉ mục sai"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "Ngài đã là người mời bên kia"
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "Đã có người mời"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "Trạng thái bản sao lỗi, vui lòng đăng nhập lại"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "Túi đồ đã đầy"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "Số lần mua hôm nay đã đạt đến giới hạn"
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "Đạo cụ đã được trang bị"
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "Đạo cụ đã được khóa"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "Đạo cụ chưa khóa"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "Vật phẩm đã đạt cấp bậc tối đa"
  },
  ErrCode_ERR_ITEM_NOT_ENOUGH_Desc = {
    Text = "Vật phẩm không đủ"
  },
  ErrCode_ERR_ITEM_NOT_FIND_Desc = {
    Text = "Không tìm thấy đạo cụ"
  },
  ErrCode_ERR_ITEM_NOT_MATCH_Desc = {
    Text = "Đạo cụ không khớp"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "Không thể sử dụng đạo cụ này"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "Đạo cụ trùng lặp"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "Vòng mệnh hoặc lệnh khóa chưa đến thời gian mở"
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "Số lượng vật phẩm sử dụng sai"
  },
  ErrCode_ERR_ITEM_UNUSABLE_Desc = {
    Text = "Vật phẩm không thể dùng"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "Không thể tìm thấy nút kích hoạt trước"
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "Năng lượng hiện tại không đủ để kích hoạt cổng dịch chuyển, cần {s1} điểm năng lượng để kích hoạt cổng dịch chuyển."
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "Đã đạt tới cấp tối đa"
  },
  ErrCode_ERR_LOCKED_Desc = {
    Text = "Chưa mở khóa"
  },
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "Khu vực phụ bản chưa được mở khóa"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "Cốt truyện dọn chưa được mở khóa"
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "Bản sao được chọn chưa được mở khóa"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "Cốt truyện đã chọn chưa được mở khóa"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "Lỗi máy chủ khi đăng nhập"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "Phụ kiện đã nhận"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "Thư điện tử không tồn tại"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "Phối hợp thất bại"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "Đã đạt tối đa số lần có thể thức tỉnh!"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "Không thể thách đấu màn chơi chỉ định vàng -"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "Hãy chọn thân thể được đánh thức để ra trận"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "Bản vàng được chỉ định chưa được mở khóa - Vui lòng hoàn thành cuộc điều tra đã được chỉ định"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "Chưa đến thời gian đổi tên lại, vui lòng đợi"
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "Tên chứa ký tự không hợp lệ, vui lòng nhập lại"
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "Độ dài tên không hợp lệ, phải từ 2-4 ký tự"
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "Ký tự nhập quá dài"
  },
  ErrCode_ERR_NOTE_LENGTH_SHORT_Desc = {
    Text = "Văn bản nhập vào quá ngắn"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "Không đủ điểm"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "Bạn không có vật phẩm này"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "Không thể di chuyển"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "Chức năng này hiện chưa khả dụng"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "Thưởng không đáp ứng điều kiện, chưa thể nhận"
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "Đang cập nhật hồ sơ cá nhân, vui lòng kiểm tra lại sau."
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "Hiện tại không có trận giao hữu đang diễn ra"
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "Hiện tại không có bí ẩn"
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "Lỗi dữ liệu NPC"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "Npc đã được kích hoạt"
  },
  ErrCode_ERR_NPC_NOT_FIND_Desc = {
    Text = "NPC không tồn tại"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "Người này hiện không trực tuyến"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "Cấp độ người chơi chưa đạt"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "Dòng cốt truyện không đủ sao, không thể quét ải"
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "Không thể tìm thấy sự kiện đối thoại cốt truyện"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "Số lần mua thử thách cốt truyện không đủ"
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "Đã nhận phần thưởng"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "Không có phần thưởng này"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "Gắn phù chú thất bại"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "Chưa nhận được thành tựu PVP"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "Đội hình đối đầu pha thiếu lệnh khóa"
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "Đội hình đối đầu pha thiếu vòng mệnh"
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "Không đạt điều kiện mở chế độ chọn vòng"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "Thách thức đang hồi chiêu"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "Hết lượt thử thách"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "Không có đối thủ"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "Hãy chọn thân thể được đánh thức để ra trận"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "Một bên đã thắng hai ván, không thể chơi thêm một ván nữa"
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "Đối thủ đã rời khỏi"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "Chiến đấu mã hóa Không tồn tại hoặc đã hết hạ"
  },
  ErrCode_ERR_RANK_OUT_OF_RANGE_Desc = {
    Text = "Hiện không hỗ trợ xem thông tin xếp hạng ngoài top 2000."
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "Bảng thông số nạp tiền không có cấu hình này"
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "Đã nạp miễn phí, không thể thực hiện nạp lại"
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "Số lần làm mới hàng hóa đã đạt giới hạn"
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "Không ở trạng thái theo dõi qua lại"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "Vật phẩm đã đầy"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "Yêu cầu quá nhiều lần trong thời gian ngắn, vui lòng thử lại sau, xin cảm ơn"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "Số lượng vật phẩm cần thiết để nâng cấp tinh nhuệ không đủ"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "Không đủ tiền tệ để tiêu thụ khi nâng cấp thân thể được đánh thức"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "Lỗi dữ liệu nhân vật"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "Thân thể được đánh thức đã đạt mức tối đa, không thể tiếp tục nâng cao"
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "Thân thể được đánh thức không đủ cấp độ"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "Thân thể được đánh thức đã đạt cấp tối đa và không thể nâng cấp"
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "Đồng tiền không đủ"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "Thân thể được đánh thức đã đạt cấp cao nhất"
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "Chưa đạt đến cấp độ tối đa, không thể nâng cấp"
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "Không có dữ liệu về thân thể được đánh thức"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "Thân thể được thức tỉnh không có kỹ năng"
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "Không có thông tin khe cắm"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "Tiềm năng của thân thể được đánh thức đã đạt đến cấp độ cao nhất"
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "Đạo cụ nâng cấp tiềm năng của thân thể được đánh thức không đủ"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "Thân thể được thức tỉnh chưa mở khóa kỹ năng"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "Kỹ năng đã đạt cấp tối đa"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "Đạo cụ nâng cấp kỹ năng không đủ"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "Bạn không có đủ tiền để nâng cấp kỹ năng"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "Đã đạt tới cấp tối đa"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "Đã hết số lần nâng cấp ô thủ công"
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "Đã tiến cấp, không thể tiếp tục tiến cấp"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "Đạo cụ không đủ để tiêu thụ nâng cấp thân thể được đánh thức"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "Không đủ tiền tệ để tiêu thụ khi nâng cấp thân thể được đánh thức"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "Giới vực không đạt điều kiện"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "Thức tỉnh giả xuất chiến trong tháp giới vực không đáp ứng yêu cầu của giới vực"
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "Cấp độ đã nhập không nằm trong các cấp độ hiện tại đã mở"
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "Tháp Giới Vực không thể dùng các thân thể được đánh thức giống nhau tham gia trận đấu"
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "Thiếu bạc tâm"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "Đang bảo trì khuôn viên, vui lòng chờ đến khi kết thúc bảo trì"
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "Dịch vụ chưa được khởi động"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "Sản phẩm đã mua"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "Hiện tại không thể thực hiện cảm ứng"
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "Hàng hóa đã hết hạn, không thể đổi"
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "Hàng hóa đang bán đã hết hàng"
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "Không có dữ liệu cửa hàng"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "Cửa hàng loại này không tồn tại"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "Không bán mặt hàng này"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "Cửa hàng không cung cấp mặt hàng này"
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "Không có lượt làm mới"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "Cửa hàng không có sản phẩm này"
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "Hiện không ở nút cửa hàng nên không thể làm mới"
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "Người chơi không tồn tại"
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "Tất cả các phân thân của Nguyên Thủy Chi Thị đều đã bị tiêu diệt"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "Số lượt thử thách loại cấp độ hàng ngày đã đạt giới hạ"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "Nhấp quá nhanh, vui lòng thử sau"
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "Chức năng đánh thức chưa được kích hoạt"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "Chưa đạt điều kiện kích hoạt"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "Cảm ứng đã kích hoạt, không cần lặp lại"
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "Trạng thái ban đầu của cảm ứng không thể đặt lại"
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "Không đủ vật liệu cộng hưởng."
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "Điểm cảm ứng đã đạt cấp độ tối đa"
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "Không tìm thấy sự cộng hưởng trong bản sao"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "Không tìm thấy dữ liệu cộng hưởng"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "Không tìm thấy dữ liệu liên quan đến cấp độ cộng hưởng"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "Không thể đặt lại số lần"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "Hiệu ứng sản xuất thân thể được đánh thức đã mở khóa, không cần mở lại"
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "Đã nhận phần thưởng"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "Nhiệm vụ đã hoàn thành, không thể gọi lại"
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "Điều kiện giao phó không đủ"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "Nhiệm vụ đã hoàn thành"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "Chưa tìm thấy nhiệm vụ"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "Nhiệm vụ chưa hoàn thành, bạn chưa thể nhận thưởng"
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "Tên đội không được chứa ký tự không phải tiếng Trung hoặc tiếng Anh"
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "Tên đội không được dài hơn 8 ký tự"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "Yêu cầu có ít nhất bốn đơn vị đã được thức tỉnh trong đội hình để vào cửa ải"
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "Không tìm thấy thiết lập đội"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "Đội hình thân thể được đánh thức không có vòng mệnh"
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "Điều tra lỗi nhóm của bản sao giới vực"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "Vòng mệnh không có thật"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "Điều kiện không đủ"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "Lỗi Token đăng nhập"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "Hiện tại không tìm thấy nút kích hoạt"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "Phụ kiện chưa được ghi lại, không thể thay thế thuộc tính"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "Hủy theo dõi người đó trước mới có thể chặn họ"
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "Thân thể được đánh thức, vòng mệnh hoặc lệnh khóa đã dùng hôm nay"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "Mở khóa nhánh phụ thất bại: Nhánh phụ có sẵn"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "Mở nhánh phụ thất bại: Nhánh phụ chưa được kích hoạt"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "Kích hoạt nhánh phụ thất bại: Không cần mở khóa vật phẩm"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "Không thể mở khóa nhánh phụ: Nhánh phụ đã được mở khóa"
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "Số phiên bản không khớp, vui lòng cập nhật phiên bản khách hàng mới nhất; nếu đã cập nhật, vui lòng chờ đến khi bảo trì trường học hoàn tất"
  },
  ErrCode_FAILED_Desc = {
    Text = "Thất bại"
  },
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "Nhân vật đã tồn tại, không cần tạo lại"
  },
  ErrCode_SUCCESS_Desc = {
    Text = "Thao tác thành công"
  }
})
return Text_ErrCode
