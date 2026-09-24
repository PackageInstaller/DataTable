local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = socketer
local var_0_3 = packet
local var_0_4 = type
local var_0_5 = assert
local var_0_6 = math.ceil
local var_0_7 = get_millisecond
local var_0_8 = 1

lx.define_class("SocketNet", function(arg_1_0)
	function arg_1_0.init(arg_2_0, arg_2_1)
		var_0_5(var_0_4(arg_2_1) == "table")
		var_0_5(var_0_4(arg_2_1.on_close) == "function")
		var_0_5(var_0_4(arg_2_1.on_connecting) == "function")
		var_0_5(var_0_4(arg_2_1.on_try_connect_timeout) == "function")
		var_0_5(var_0_4(arg_2_1.on_connect_succeed) == "function")
		var_0_5(var_0_4(arg_2_1.on_disconnect) == "function")
		var_0_5(var_0_4(arg_2_1.on_process_msg) == "function")

		arg_2_0._func_list = arg_2_1
	end

	function arg_1_0:connect(arg_3_1, arg_3_2)
		self._ip = arg_3_1
		self._port = arg_3_2

		self:__reset_connect(true)

		self._begin_try_connect_time = var_0_7()

		self:__event_on_connecting()
	end

	function arg_1_0:reconnect()
		self:connect(self._ip, self._port)
	end

	function arg_1_0:close()
		self:__reset_connect()
		self:__event_on_close()
	end

	function arg_1_0:destroy()
		self:__reset_connect()

		self._func_list = nil

		self:__on_destroy()
	end

	function arg_1_0.enableMsgSeq(arg_7_0, arg_7_1)
		arg_7_0._enable_msg_seq = arg_7_1
	end

	function arg_1_0:setPingInterval(arg_8_1)
		if arg_8_1 <= 0 then
			arg_8_1 = 618
		end

		self._ping_interval = arg_8_1

		self:setPingOvertime(self._ping_overtime)
	end

	function arg_1_0:setPingOvertime(arg_9_1)
		if arg_9_1 < self._ping_interval * 2 then
			arg_9_1 = self._ping_interval * 2
		end

		self._ping_overtime = arg_9_1
	end

	function arg_1_0.setTryConnectMaxTime(arg_10_0, arg_10_1)
		if arg_10_1 <= 0 then
			arg_10_1 = 618
		end

		arg_10_0._try_connect_max_time = arg_10_1
	end

	function arg_1_0:sendMsg(arg_11_1)
		return self:__send_msg(arg_11_1)
	end

	function arg_1_0:isAlreadyConnect()
		return self._already_connect
	end

	function arg_1_0:getPingTime()
		return self._ping_value
	end

	function arg_1_0:__event_on_close()
		self._func_list.on_close()
	end

	function arg_1_0:__event_on_connecting()
		self._func_list.on_connecting()
	end

	function arg_1_0:__event_on_try_connect_timeout()
		self._func_list.on_try_connect_timeout()
	end

	function arg_1_0:__event_on_connect_succeed()
		self._func_list.on_connect_succeed()
	end

	function arg_1_0:__event_on_disconnect()
		self._func_list.on_disconnect()
	end

	function arg_1_0:__event_on_process_msg(arg_19_1, arg_19_2)
		self._func_list.on_process_msg(arg_19_1, arg_19_2)
	end

	function arg_1_0:__reset_connect(arg_20_1)
		if self._con then
			var_0_2.release(self._con)

			self._con = nil
		end

		if arg_20_1 then
			self._con = var_0_2.create()

			var_0_2.use_uncompress(self._con)
			var_0_2.use_encrypt(self._con)
			var_0_2.use_decrypt(self._con)
		end

		self._already_connect = false
		self._msg_seq_id = 0
		self._last_ping_time = 0
		self._recv_ping_time = 0
		self._ping_value = 10
	end

	function arg_1_0:__try_connect(arg_21_1)
		if arg_21_1 > self._begin_try_connect_time + self._try_connect_max_time then
			self:__reset_connect()
			self:__event_on_try_connect_timeout()

			return
		end

		if not var_0_2.connect(self._con, self._ip, self._port) then
			return
		end

		self:__send_ping(arg_21_1)
		var_0_2.check_send(self._con)

		if var_0_2.is_close(self._con) then
			self:__reset_connect(true)

			return
		end

		self._already_connect = true

		self:__event_on_connect_succeed()
	end

	function arg_1_0:__send_msg(arg_22_1)
		local var_22_0 = var_0_3.getlen(arg_22_1)

		if self._enable_msg_seq then
			var_0_3.setindex(arg_22_1, var_22_0 - var_0_3.getheadlen())
			var_0_3.pushint16(arg_22_1, self:__get_next_msg_seq_id())
		end

		local var_22_1 = false

		if self._con then
			var_22_1 = var_0_2.send_msg(self._con, arg_22_1)
		end

		var_0_3.setlen(arg_22_1, var_22_0)

		return var_22_1
	end

	function arg_1_0:__get_next_msg_seq_id()
		self._msg_seq_id = self._msg_seq_id + 1

		if self._msg_seq_id > 32767 then
			self._msg_seq_id = 1
		end

		return self._msg_seq_id
	end

	function arg_1_0:__send_ping(arg_24_1)
		local var_24_0 = var_0_3.anyfirst()

		var_0_3.settype(var_24_0, var_0_8)
		self:__send_msg(var_24_0)

		self._last_ping_time = arg_24_1

		if self._recv_ping_time <= 0 then
			self._recv_ping_time = self._last_ping_time
		end
	end

	function arg_1_0:__check_send_ping(arg_25_1)
		if arg_25_1 < self._last_ping_time + self._ping_interval then
			return
		end

		if arg_25_1 >= self._last_ping_time + self._ping_overtime then
			self._recv_ping_time = 0
		end

		self:__send_ping(arg_25_1)
	end

	function arg_1_0:__check_ping_overtime(arg_26_1)
		if self._recv_ping_time <= 0 then
			return
		end

		if arg_26_1 - self._recv_ping_time >= self._ping_overtime then
			var_0_2.close(self._con)
		end
	end

	function arg_1_0:__on_recv_ping()
		self._recv_ping_time = var_0_7()

		if self._last_ping_time <= 0 then
			return
		end

		local var_27_0 = var_0_6((self._recv_ping_time - self._last_ping_time) / 2)

		if var_27_0 < 10 then
			var_27_0 = 10
		end

		self._ping_value = var_27_0
	end

	function arg_1_0:__process_msg(arg_28_1, arg_28_2)
		if arg_28_1 == var_0_8 then
			self:__on_recv_ping()

			return
		end

		self:__event_on_process_msg(arg_28_1, arg_28_2)
	end

	function arg_1_0:__try_process_msg()
		while self._con do
			local var_29_0 = var_0_2.get_msg(self._con)

			if not var_29_0 then
				break
			end

			local var_29_1 = var_0_3.gettype(var_29_0)

			var_0_3.begin(var_29_0)
			self:__process_msg(var_29_1, var_29_0)
		end
	end

	function arg_1_0:run_once()
		if not self._con then
			return
		end

		local var_30_0 = var_0_7()

		if not self._already_connect then
			self:__try_connect(var_30_0)

			return
		end

		self:__check_send_ping(var_30_0)
		self:__check_ping_overtime(var_30_0)

		if var_0_2.is_close(self._con) then
			self:__reset_connect()
			self:__event_on_disconnect()

			return
		end

		self:__try_process_msg()

		if self._con then
			var_0_2.check_send(self._con)
			var_0_2.check_recv(self._con)
		end
	end
end, "BaseNet")

function var_0_0.create(arg_31_0)
	local var_31_0 = var_0_1.class("SocketNet", var_0_1.BaseNet:create())

	var_31_0._func_list = nil
	var_31_0._ip = nil
	var_31_0._port = 0
	var_31_0._enable_msg_seq = true
	var_31_0._ping_interval = 5000
	var_31_0._ping_overtime = 10000
	var_31_0._try_connect_max_time = 5000
	var_31_0._con = nil
	var_31_0._already_connect = false
	var_31_0._msg_seq_id = 0
	var_31_0._last_ping_time = 0
	var_31_0._recv_ping_time = 0
	var_31_0._ping_value = 10
	var_31_0._begin_try_connect_time = 0

	return var_31_0
end

return var_0_0
