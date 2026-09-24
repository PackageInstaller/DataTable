local var_0_0 = lx
local var_0_1 = type
local var_0_2 = assert
local var_0_3 = tostring
local var_0_4 = string.format
local var_0_5 = packet
local var_0_6 = lx.Time
local var_0_7 = lx.json_format
local var_0_8 = crypto.md5
local var_0_10 = gamecore.protocol
local var_0_11 = UnityEngine.Application
local var_0_12 = gamecore.opcode_request_response
local var_0_13 = gameenum.error_code
local var_0_14 = gameenum.data_version
local var_0_19 = UnityEngine.RuntimePlatform
local var_0_20 = 10000

lx.define_class("NetworkManager", function(arg_1_0)
	function arg_1_0.init(arg_2_0, arg_2_1)
		var_0_2(var_0_1(arg_2_1) == "table")
		var_0_2(var_0_1(arg_2_1.on_check_network_try_again) == "function")
		var_0_2(var_0_1(arg_2_1.on_system_busy_try_again) == "function")
		var_0_2(var_0_1(arg_2_1.on_need_oauth_again) == "function")
		var_0_2(var_0_1(arg_2_1.on_protocol_version_no_match) == "function")
		var_0_2(var_0_1(arg_2_1.on_close) == "function")
		var_0_2(var_0_1(arg_2_1.on_connect_succeed) == "function")
		var_0_2(var_0_1(arg_2_1.on_reconnect) == "function")
		var_0_2(var_0_1(arg_2_1.on_disconnect) == "function")
		var_0_2(var_0_1(arg_2_1.on_send_request) == "function")
		var_0_2(var_0_1(arg_2_1.on_recv_response) == "function")
		var_0_2(var_0_1(arg_2_1.on_request_timeout) == "function")
		var_0_2(var_0_1(arg_2_1.on_request_timeout_reconnect) == "function")
		var_0_2(var_0_1(arg_2_1.on_all_request_finish) == "function")
		var_0_2(var_0_1(arg_2_1.on_server_is_full_please_try_again_later) == "function")
		var_0_2(var_0_1(arg_2_1.on_in_other_local_login) == "function")
		var_0_2(var_0_1(arg_2_1.on_json_version_no_match) == "function")
		var_0_2(var_0_1(arg_2_1.on_battle_version_no_match) == "function")
		var_0_2(var_0_1(arg_2_1.on_need_real_name) == "function")
		var_0_2(var_0_1(arg_2_1.need_real_name_again) == "function")
		var_0_2(var_0_1(arg_2_1.on_prevent_addicted_limit) == "function")

		arg_2_0._func_list = arg_2_1
	end

	function arg_1_0:reset()
		self:__reset()
	end

	function arg_1_0:start(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6, arg_4_7)
		var_0_2(var_0_1(arg_4_1) == "string")
		var_0_2(var_0_1(arg_4_2) == "string")
		var_0_2(var_0_1(arg_4_3) == "string")
		var_0_2(var_0_1(arg_4_4) == "number")

		self._token = arg_4_1
		self._channel = arg_4_2
		self._uid = arg_4_5
		self._channel_uid = arg_4_6
		self._product_id = arg_4_7

		self:__init_role_con(arg_4_1, 0, arg_4_3, arg_4_4)
	end

	function arg_1_0.setLogFunc(arg_5_0, arg_5_1)
		arg_5_0._log_func = arg_5_1
	end

	function arg_1_0.enableLog(arg_6_0, arg_6_1)
		arg_6_0._enable_log = arg_6_1
	end

	function arg_1_0.enableSessionID(arg_7_0, arg_7_1)
		arg_7_0._enable_session = arg_7_1
	end

	function arg_1_0.setRequestTimeout(arg_8_0, arg_8_1)
		if arg_8_1 < 0 then
			arg_8_1 = 0
		end

		arg_8_0._request_timeout = arg_8_1
	end

	function arg_1_0.setRequestTimeoutReconnect(arg_9_0, arg_9_1)
		if arg_9_1 < 0 then
			arg_9_1 = 0
		end

		arg_9_0._request_timeout_reconnect = arg_9_1
	end

	function arg_1_0.bindProtocolProcessor(arg_10_0, arg_10_1)
		var_0_2(var_0_1(arg_10_1) == "table")

		arg_10_0._processor = arg_10_1
	end

	function arg_1_0:registerProtocol(arg_11_1, arg_11_2, arg_11_3)
		self:__register_protocol(arg_11_1, arg_11_2, arg_11_3)
	end

	function arg_1_0:sendMsg(arg_12_1, arg_12_2)
		local var_12_0 = var_0_10:getMsgNameType(arg_12_1)

		if not var_12_0 then
			var_0_0.error("not find protocol, name:" .. var_0_3(arg_12_1))
		end

		local var_12_1, var_12_2, var_12_3 = var_0_12.getRequestMsgInfo(var_12_0)

		if not var_12_3 then
			var_0_0.error("the protocol error, not is request, name:" .. var_0_3(arg_12_1))
		end

		if self:__find_wait_request(arg_12_1) then
			if gamecore.AuditServerManager:isDevelopVersion() then
				log.errorlog(var_0_4("why send duplicate request, name:%s", var_0_3(arg_12_1)))
			end

			return
		end

		local var_12_4 = {
			send_time = 0,
			received = false,
			name = arg_12_1,
			msgtype = var_12_0,
			data = arg_12_2,
			sessionID = self:__get_next_sessionID(),
			response_msgtype = var_12_2
		}

		;(function()
			self:__add_wait_request(var_12_4)
			self:__send_the_request(var_12_4)
		end)()
	end

	function arg_1_0:getIP()
		return self._ip
	end

	function arg_1_0:__get_next_sessionID()
		self._msg_sessionID = self._msg_sessionID + 1

		if self._msg_sessionID > 4294967295 then
			self._msg_sessionID = 1
		end

		return self._msg_sessionID
	end

	function arg_1_0:__send_the_request(arg_16_1)
		arg_16_1.send_time = var_0_6:getTime()

		self:__try_remove_request_timeout(arg_16_1.name)

		local var_16_0 = arg_16_1.name
		local var_16_1 = arg_16_1.msgtype
		local var_16_2 = arg_16_1.data
		local var_16_3 = arg_16_1.sessionID
		local var_16_4 = var_0_10:createMessage(arg_16_1.msgtype, arg_16_1.data)

		if self._enable_session then
			var_0_5.setindex(var_16_4, var_0_5.getlen(var_16_4) - var_0_5.getheadlen())
			var_0_5.pushuint32(var_16_4, var_16_3)
		end

		if self._ready then
			self._func_list.on_send_request(var_16_0, var_16_2)
		end

		self:__on_send_msg(nil, var_16_0, var_16_1, var_16_3, var_16_2)

		return (self._role_con:sendMsg(var_16_4))
	end

	function arg_1_0:__resend_request()
		for iter_17_0, iter_17_1 in pairs(self._request_sequence) do
			self:__send_the_request(iter_17_1)
		end
	end

	function arg_1_0:__on_process_msg(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
		self:__on_recv_msg(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
		self:__received_the_request_response(arg_18_3, arg_18_4)

		local var_18_0, var_18_1, var_18_2 = var_0_12.checkResponseMsgInfo(arg_18_3)
		local var_18_3 = self._processor and self._processor[var_18_2]

		if var_18_3 then
			local var_18_4, var_18_5 = xpcall(var_18_3, debug.traceback, self._processor, arg_18_5)

			if not var_18_4 then
				log.errorlog(var_0_4("func_name:%s\n%s", var_18_2, var_18_5))
			end

			return
		end

		local var_18_6 = self._msgtype_handle_set[arg_18_3]

		if not self._msgtype_handle_set[arg_18_3] then
			log.errorlog(var_0_4("not find msgtype process function, msgtype:[%s]", var_0_3(arg_18_3)))

			return
		end

		if var_18_6.arg then
			local var_18_7, var_18_8 = xpcall(var_18_6.func, debug.traceback, var_18_6.arg, arg_18_5)

			if not var_18_7 then
				log.errorlog(var_0_4(var_18_8))
			end
		else
			local var_18_9, var_18_10 = xpcall(var_18_6.func, debug.traceback, arg_18_5)

			if not var_18_9 then
				log.errorlog(var_0_4(var_18_10))
			end
		end
	end

	function arg_1_0:__on_need_oauth_again()
		self._role_can_next_auth = false
		self._role_reconnecting = false

		self:__reset_session()
		self._func_list.on_need_oauth_again()
	end

	function arg_1_0:__find_wait_request(arg_20_1)
		for iter_20_0, iter_20_1 in pairs(self._request_sequence) do
			if iter_20_1.name == arg_20_1 then
				return iter_20_1
			end
		end

		return nil
	end

	function arg_1_0:cancelPendingRequestByName(arg_21_1)
		local var_21_0 = {}

		for iter_21_0, iter_21_1 in pairs(self._request_sequence) do
			if iter_21_1.name ~= arg_21_1 then
				table.insert(var_21_0, iter_21_1)
			end
		end

		for iter_21_2 in pairs(self._request_sequence) do
			self._request_sequence[iter_21_2] = nil
		end

		for iter_21_3 = 1, #var_21_0 do
			self._request_sequence[iter_21_3] = var_21_0[iter_21_3]
		end

		if self._request_reconnect_timeout_set then
			self._request_reconnect_timeout_set[arg_21_1] = nil
		end

		self:__try_remove_request_timeout(arg_21_1)
	end

	function arg_1_0:__prune_stale_request_timeout_tracking()
		for iter_22_0, iter_22_1 in pairs(self._request_timeout_set) do
			if not self:__find_wait_request(iter_22_0) then
				self._request_timeout_set[iter_22_0] = nil
			end
		end

		for iter_22_2, iter_22_3 in pairs(self._request_reconnect_timeout_set) do
			if not self:__find_wait_request(iter_22_2) then
				self._request_reconnect_timeout_set[iter_22_2] = nil
			end
		end

		if next(self._request_timeout_set) and not next(self._request_timeout_set) then
			self._func_list.on_all_request_finish()
		end
	end

	function arg_1_0:__add_wait_request(arg_23_1)
		if arg_23_1.msgtype == 5003 or arg_23_1.msgtype == 7007 then
			return
		end

		table.insert(self._request_sequence, arg_23_1)
	end

	function arg_1_0:__received_the_request_response(arg_24_1, arg_24_2)
		for iter_24_0, iter_24_1 in pairs(self._request_sequence) do
			if iter_24_1.response_msgtype == arg_24_1 then
				if iter_24_1.sessionID ~= arg_24_2 then
					var_0_0.error(var_0_4("why sessionID not equal. msgtype:%s", arg_24_1))
				end

				table.remove(self._request_sequence, iter_24_0)
				self._func_list.on_recv_response(iter_24_1.name, iter_24_1.data)
				self:__try_remove_request_timeout(iter_24_1.name)

				return
			end
		end
	end

	function arg_1_0:__try_remove_request_timeout(arg_25_1)
		if not self._request_timeout_set[arg_25_1] then
			return
		end

		self._request_timeout_set[arg_25_1] = nil

		if not next(self._request_timeout_set) then
			self._func_list.on_all_request_finish()
		end
	end

	function arg_1_0:__reset_request_timeout_set()
		if next(self._request_timeout_set) then
			self._func_list.on_all_request_finish()
		end

		self._request_timeout_set = {}
	end

	function arg_1_0.__reset_request_reconnect_timeout_set(arg_27_0)
		arg_27_0._request_reconnect_timeout_set = {}
	end

	function arg_1_0:__reset_session()
		self:__reset_request_timeout_set()
		self:__reset_request_reconnect_timeout_set()

		self._ready = false
		self._request_sequence = {}
		self._msg_sessionID = 0
	end

	function arg_1_0:__init_role_con(arg_29_1, arg_29_2, arg_29_3, arg_29_4)
		self._role_auth.account_id = arg_29_2
		self._role_auth.token = arg_29_1
		self._role_auth.random = ""
		self._role_auth.auth_string = ""
		self._role_con = self._role_con or var_0_0.SocketNet:create()

		self._role_con:init(self._wrap_role_func_list)
		self._role_con:connect(arg_29_3, arg_29_4)
		self._role_con:enableMsgSeq(false)
		self._role_con:setPingInterval(5000)
		self._role_con:setTryConnectMaxTime(10000)
	end

	function arg_1_0:__reconnect_to_role()
		self._role_reconnecting = true

		self._role_con:reconnect()
	end

	function arg_1_0:__register_protocol(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
		local var_31_0 = var_0_10:getMsgNameType(arg_31_1)

		if not var_31_0 then
			var_0_0.error("not find protocol, name:" .. var_0_3(arg_31_1))
		end

		if arg_31_4 then
			self._msgtype_handle_set[var_31_0] = nil
		end

		if self._msgtype_handle_set[var_31_0] then
			var_0_0.error(var_0_4("on registerProtocol, but already register. name:[%s], msgtype:[%s]", arg_31_1, var_0_3(var_31_0)))
		end

		self._msgtype_handle_set[var_31_0] = {
			func = arg_31_2,
			arg = arg_31_3
		}
	end

	function arg_1_0:__on_connect_succeed_as_role()
		self.__register_protocol(self, "login.ChangeGateNotify", self.__msg_on_change_gate, self, true)
		self.__register_protocol(self, "login.RandomNotify", self.__msg_on_random, self, true)
		self.__register_protocol(self, "login.AuthResp", self.__msg_on_auth_result, self, true)
		self.__register_protocol(self, "login.InOtherLocalLoginNotify", self.__msg_on_in_other_local_login, self, true)
		self.__register_protocol(self, "user.ServerTimeNotify", self.__msg_on_server_utc_time, self, true)
		self.__register_protocol(self, "user.TellIPNotify", self.__msg_on_ip, self, true)
		self.__register_protocol(self, "user.ReadyNotify", self.__msg_on_ready, self, true)
		self.__register_protocol(self, "user.LoadDataResultNotify", self.__msg_on_load_data_result, self, true)
	end

	function arg_1_0.__parse_msg(arg_33_0, arg_33_1, arg_33_2)
		local var_33_0 = var_0_5.getlen(arg_33_2)

		var_0_5.setindex(arg_33_2, var_33_0 - var_0_5.getheadlen() - 4)
		var_0_5.setlen(arg_33_2, var_33_0 - 4)

		return var_0_5.getuint32(arg_33_2), var_0_10:getMsgTypeName(arg_33_1), (var_0_10:parseMessage(arg_33_1, arg_33_2))
	end

	function arg_1_0:__on_process_msg_as_role(arg_34_1, arg_34_2)
		local var_34_0, var_34_1, var_34_2 = self:__parse_msg(arg_34_1, arg_34_2)

		self:__on_process_msg("role", var_34_1, arg_34_1, var_34_0, var_34_2)
	end

	function arg_1_0:__on_send_msg(arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5)
		if not self._enable_log or not self._log_func then
			return
		end

		self._log_func(var_0_4("req [%s] %s(%s)[%s]:\n%s", arg_35_1, arg_35_2, var_0_3(arg_35_3), var_0_3(arg_35_4), var_0_7(arg_35_5)))
	end

	function arg_1_0:__on_recv_msg(arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5)
		if not self._enable_log or not self._log_func then
			return
		end

		self._log_func(var_0_4("on [%s] %s(%s)[%s]:\n%s", arg_36_1, arg_36_2, var_0_3(arg_36_3), var_0_3(arg_36_4), var_0_7(arg_36_5)))
	end

	function arg_1_0:__msg_on_change_gate(arg_37_1)
		self._role_con:connect(arg_37_1.ip, arg_37_1.port)
	end

	function arg_1_0:__calculate_auth_info(arg_38_1, arg_38_2)
		if arg_38_1 then
			self._role_auth.random = arg_38_1
		end

		if arg_38_2 and #arg_38_2 > 0 then
			self._role_auth.token = arg_38_2

			return 0, "", arg_38_2, true
		end

		local var_38_0 = self._role_auth.auth_string

		self._role_auth.auth_string = var_0_8.sum(var_0_4("%s+%s+%s", var_0_3(self._role_auth.account_id), self._role_auth.token, self._role_auth.random))
		self._role_auth.token = var_0_8.sum(var_0_4("%s+%s+%s", self._role_auth.token, var_0_3(self._role_auth.account_id), var_38_0))

		return self._role_auth.account_id, self._role_auth.auth_string, "", false
	end

	function arg_1_0:__msg_on_random(arg_39_1)
		if self._role_auth.account_id ~= 0 then
			self._token = nil
		end

		local var_39_0 = "default"

		if var_0_11.platform == var_0_19.Android then
			var_39_0 = "Android "
		elseif var_0_11.platform == var_0_19.IPhonePlayer then
			var_39_0 = "iOS "
		end

		local var_39_1 = var_39_0 .. DeviceInfo.GetOperateSystemVer()
		local var_39_2, var_39_3, var_39_4, var_39_5 = self:__calculate_auth_info(arg_39_1.random, self._token)

		self:sendMsg("login.AuthReq", {
			account_id = var_39_2,
			channel = self._channel,
			auth_string = var_39_3,
			token = var_39_4,
			first_auth = var_39_5,
			uid = self._uid,
			channel_uid = self._channel_uid,
			product_id = self._product_id,
			protocol_version = var_0_10:getVersion(),
			json_version = var_0_14.get_json_version(),
			battle_version = var_0_14.get_battle_version(),
			login_os = var_39_1
		})
		gamecore.user:set_is_first_auth(var_39_5)
	end

	function arg_1_0:__msg_on_auth_result(arg_40_1)
		if arg_40_1.error_code == var_0_13.succeed then
			if gamecore.user and gamecore.user.onAuthSucceed then
				gamecore.user:onAuthSucceed()
			end

			if self._role_auth.account_id == 0 then
				self._role_auth.account_id = arg_40_1.account_id

				self:__calculate_auth_info()
			end

			self._role_can_next_auth = true
			self._role_reconnecting = false
		elseif arg_40_1.error_code == var_0_13.system_busy_try_again then
			if self._role_reconnecting then
				return
			end

			self._func_list.on_system_busy_try_again(function()
				self:__reconnect_to_role()
			end)
		elseif arg_40_1.error_code == var_0_13.need_oauth_again then
			self:__on_need_oauth_again()
		elseif arg_40_1.error_code == var_0_13.protocol_version_no_match then
			self._func_list.on_protocol_version_no_match()
		elseif arg_40_1.error_code == var_0_13.json_version_no_match then
			self._func_list.on_json_version_no_match()
		elseif arg_40_1.error_code == var_0_13.battle_version_no_match then
			self._func_list.on_battle_version_no_match()
		elseif arg_40_1.error_code == var_0_13.need_real_name then
			self._func_list.on_need_real_name()
		elseif arg_40_1.error_code == var_0_13.need_real_name_again then
			self._func_list.need_real_name_again()
		elseif arg_40_1.error_code == var_0_13.server_is_full_please_try_again_later then
			if self._role_reconnecting then
				return
			end

			self._func_list.on_server_is_full_please_try_again_later(function()
				self:__reconnect_to_role()
			end)
		elseif arg_40_1.error_code == var_0_13.prevent_addicted_limit then
			self._func_list.on_prevent_addicted_limit()
		elseif arg_40_1.error_code == var_0_13.server_close then
			if self._role_reconnecting then
				return
			end

			self._func_list.on_server_close(function()
				self:__reconnect_to_role()
			end)
		elseif arg_40_1.error_code == var_0_13.blacklist_limit then
			if self._role_reconnecting then
				return
			end

			local var_40_0

			if arg_40_1.time then
				var_40_0 = arg_40_1.time
			end

			if var_40_0 then
				gamecore.user:set_ban_time(var_40_0)
			end

			self._func_list.on_blacklist_limit(function()
				self:__reconnect_to_role()
			end)
		end
	end

	function arg_1_0:__msg_on_in_other_local_login(arg_45_1)
		self._role_can_next_auth = false
		self._role_reconnecting = false

		self:__reset_session()
		self._func_list.on_in_other_local_login()
	end

	function arg_1_0.__msg_on_server_utc_time(arg_46_0, arg_46_1)
		var_0_0.ServerTime:updateServerTime(arg_46_1.utc_time)
	end

	function arg_1_0.__msg_on_ip(arg_47_0, arg_47_1)
		arg_47_0._ip = arg_47_1.ip
	end

	function arg_1_0:__msg_on_ready(arg_48_1)
		self:sendMsg("user.LoadDataReq", {})
	end

	function arg_1_0:__msg_on_load_data_result(arg_49_1)
		if arg_49_1.result then
			self:__resend_request()

			self._ready = true

			self._func_list.on_connect_succeed()
		else
			self._func_list.on_system_busy_try_again(function()
				self._role_con:reconnect()
			end)
		end
	end

	function arg_1_0:run_once(arg_51_1)
		if not self._ready or self._request_timeout <= 0 then
			return
		end

		self:__prune_stale_request_timeout_tracking()

		local var_51_0 = 0
		local var_51_1 = 0

		for iter_51_0, iter_51_1 in pairs(self._request_sequence) do
			if arg_51_1 > iter_51_1.send_time + self._request_timeout_reconnect and not self._request_reconnect_timeout_set[iter_51_1.name] then
				self._request_reconnect_timeout_set[iter_51_1.name] = iter_51_1.name
				var_51_1 = var_51_1 + 1
			end

			if arg_51_1 > iter_51_1.send_time + self._request_timeout and not self._request_timeout_set[iter_51_1.name] then
				self._request_timeout_set[iter_51_1.name] = iter_51_1.name
				var_51_0 = var_51_0 + 1
			end
		end

		if var_51_0 > 0 then
			self._func_list.on_request_timeout(self._request_timeout_set)
		end

		if var_51_1 > 0 then
			self._role_reconnecting = false

			self._func_list.on_request_timeout_reconnect(self._request_timeout_set, function()
				self:__reconnect_to_role()
			end)
		end
	end

	function arg_1_0:__reset()
		self._ip = ""
		self._token = ""
		self._channel = ""
		self._role_auth.account_id = 0
		self._role_auth.token = ""
		self._role_auth.random = ""
		self._role_auth.auth_string = ""
		self._ready = false
		self._msg_sessionID = 0
		self._role_can_next_auth = false
		self._role_reconnecting = false

		self:__reset_session()

		if self._role_con then
			self._role_con:close()
		end
	end

	function arg_1_0.__init_func_list(arg_54_0)
		arg_54_0._wrap_role_func_list = {
			on_close = function()
				arg_54_0._func_list.on_close()
			end,
			on_connecting = function()
				return
			end,
			on_try_connect_timeout = function()
				arg_54_0._role_reconnecting = false

				arg_54_0._func_list.on_check_network_try_again(function()
					arg_54_0:__reconnect_to_role()
				end)
			end,
			on_connect_succeed = function()
				arg_54_0:__on_connect_succeed_as_role()
			end,
			on_disconnect = function()
				arg_54_0._ready = false

				arg_54_0._func_list.on_disconnect()

				if arg_54_0.__reset_request_timeout_set then
					arg_54_0:__reset_request_timeout_set()
				end

				if arg_54_0.__reset_request_reconnect_timeout_set then
					arg_54_0:__reset_request_reconnect_timeout_set()
				end

				if not arg_54_0._role_can_next_auth then
					return
				end

				arg_54_0._role_con:reconnect()

				if not arg_54_0._role_reconnecting then
					arg_54_0._role_reconnecting = true

					arg_54_0._func_list.on_reconnect()
				end
			end,
			on_process_msg = function(arg_61_0, arg_61_1)
				if arg_54_0.__on_process_msg_as_role then
					arg_54_0:__on_process_msg_as_role(arg_61_0, arg_61_1)
				end
			end
		}
		arg_54_0._wrap_battle_func_list = {
			on_close = function()
				return
			end,
			on_connecting = function()
				return
			end,
			on_try_connect_timeout = function()
				return
			end,
			on_connect_succeed = function()
				return
			end,
			on_disconnect = function()
				return
			end,
			on_process_msg = function(arg_67_0, arg_67_1)
				return
			end
		}
	end
end)

return function()
	local var_68_0 = var_0_0.class("NetworkManager")

	var_68_0._log_func = nil
	var_68_0._enable_log = false
	var_68_0._processor = nil
	var_68_0._msgtype_handle_set = {}
	var_68_0._ip = ""
	var_68_0._token = ""
	var_68_0._channel = ""
	var_68_0._func_list = nil
	var_68_0._role_auth = {
		random = "",
		token = "",
		auth_string = "",
		account_id = 0
	}
	var_68_0._enable_session = true
	var_68_0._request_timeout = 0
	var_68_0._ready = false
	var_68_0._request_sequence = {}
	var_68_0._request_timeout_set = {}
	var_68_0._request_reconnect_timeout_set = {}
	var_68_0._msg_sessionID = 0
	var_68_0._role_can_next_auth = false
	var_68_0._role_reconnecting = false
	var_68_0._role_con = nil
	var_68_0._wrap_role_func_list = nil
	var_68_0._wrap_battle_func_list = nil

	var_68_0:__reset()
	var_68_0:__init_func_list()

	return var_68_0
end
