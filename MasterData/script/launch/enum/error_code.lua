local var_0_0 = {
	need_oauth_again = 1001,
	server_close = 4,
	json_version_no_match = 1004,
	failed = 3,
	send_to_role_failed = 2002,
	pay_web_create_order_fail = 4001,
	battle_version_no_match = 1005,
	pay_order_already_save_finish = 4002,
	blacklist_limit = 5,
	protocol_version_no_match = 1002,
	pay_order_already_finish_not_save = 4004,
	target_friend_is_full = 1501,
	prevent_addicted_limit = 1008,
	target_already_is_friend = 1502,
	target_request_is_full = 1503,
	param_less = 1,
	need_real_name = 1006,
	player_not_online = 2003,
	server_is_full_please_try_again_later = 1003,
	succeed = 0,
	not_find_player = 2001,
	pay_order_state_not_finish = 4003,
	need_real_name_again = 1007,
	system_busy_try_again = 2
}

var_0_0._error_msg_set = {
	[var_0_0.succeed] = "成功",
	[var_0_0.param_less] = "缺少参数",
	[var_0_0.system_busy_try_again] = "系统繁忙，请重试",
	[var_0_0.failed] = "失败",
	[var_0_0.server_close] = "服务器关闭",
	[var_0_0.need_oauth_again] = "需要再次进行授权",
	[var_0_0.server_is_full_please_try_again_later] = "服务器爆满，请稍后再试",
	[var_0_0.protocol_version_no_match] = "协议版本不匹配",
	[var_0_0.target_friend_is_full] = "对方好友已达上限",
	[var_0_0.target_already_is_friend] = "对方已经是好友",
	[var_0_0.target_request_is_full] = "对方推荐列表已满",
	[var_0_0.not_find_player] = "找不到玩家",
	[var_0_0.send_to_role_failed] = "发送到玩家所在role服务器失败",
	[var_0_0.player_not_online] = "玩家不在线"
}

function var_0_0.get_error_msg(arg_1_0, arg_1_1)
	return var_0_0._error_msg_set[arg_1_1]
end

return var_0_0
