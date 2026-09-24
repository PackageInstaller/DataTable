local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = type
local var_0_3 = assert
local var_0_4 = tostring
local var_0_5 = tonumber
local var_0_6 = os.remove
local var_0_7 = math.floor
local var_0_8 = string.format
local var_0_9 = table.insert
local var_0_10 = table.concat
local var_0_11 = encode
local var_0_12 = socketer
local var_0_13 = crypto.md5
local var_0_14 = lx.url_util
local var_0_15 = lx.json_encode
local var_0_16 = lx.json_decode
local var_0_17 = 0
local var_0_18 = 1
local var_0_19 = 2
local var_0_20 = 3
local var_0_21 = 4

lx.define_class("http_request", function(arg_1_0)
	function arg_1_0:set_url(arg_2_1)
		self:__check_can_change()

		self._url_raw = arg_2_1
		self._url = arg_2_1
	end

	function arg_1_0:set_timeout(arg_3_1)
		self:__check_can_change()

		self._timeout = arg_3_1
	end

	function arg_1_0:set_headers(arg_4_1)
		self:__check_can_change()

		for iter_4_0, iter_4_1 in pairs(arg_4_1) do
			self._headers[iter_4_0] = iter_4_1
		end
	end

	function arg_1_0:set_fields(arg_5_1)
		self:__check_can_change()

		self._fields = self:__format_table_fields(arg_5_1)
	end

	function arg_1_0:set_cookie(arg_6_1)
		self:__check_can_change()

		self._cookie = arg_6_1
		self._headers.Cookie = arg_6_1
	end

	function arg_1_0:set_post()
		self:__check_can_change()

		self._is_post = true
		self._headers["Content-Type"] = "application/x-www-form-urlencoded; charset=utf-8"
	end

	function arg_1_0:set_upload_param(arg_8_1, arg_8_2, arg_8_3)
		self:__check_can_change()

		self._is_post = true
		self._headers["Content-Type"] = nil
		self._upload_param, self._send_limit_size = {
			speed = 0,
			total_size = 0,
			progress = 0,
			start_time = 0,
			already_size = 0,
			path = arg_8_1,
			uri = arg_8_2,
			progress_func = arg_8_3
		}, 4194304
	end

	function arg_1_0:set_download_param(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
		self:__check_can_change()

		local var_9_0 = {
			progress = 0,
			start_time = 0,
			speed = 0,
			already_size = 0,
			write_path = arg_9_2,
			meta_path = arg_9_2 .. ".download.meta",
			file_md5 = arg_9_5,
			total_size = arg_9_1,
			progress_func = arg_9_3
		}

		if not arg_9_4 then
			var_9_0.meta_path = nil
		end

		self._recv_limit_size = 4194304
		self._download_param = var_9_0
	end

	function arg_1_0:set_response_func(arg_10_1)
		self:__check_can_change()

		self._response_func = arg_10_1
	end

	function arg_1_0:set_error_func(arg_11_1)
		self:__check_can_change()

		self._error_func = arg_11_1
	end

	function arg_1_0:execute()
		if self._id ~= 0 then
			var_0_3(self._id == 0, "repeat execute.")
		end

		self:__check_generate_param()

		if self._upload_param then
			local var_12_0 = io.open(self._upload_param.path, "rb")

			if not var_12_0 then
				self:__on_error(-2)

				return
			end

			self._upload_param.total_size = var_12_0:seek("end"), var_12_0:seek("set")
			self._upload_param.file = var_12_0
		end

		local var_12_1 = self._download_param

		if self._download_param then
			local var_12_2, var_12_3 = self:__check_download(var_12_1, self._url)

			if not var_12_2 then
				self:__on_error(-2)

				return
			end

			var_12_1.file = var_12_2

			self:__save_download_meta_file(var_12_1, self._url)

			if var_12_3 then
				var_12_1.first_pos = var_12_3
				var_12_1.already_size = var_12_3
				self._headers.Range = var_0_8("bytes=%s-", var_0_4(var_12_3))
			end
		end

		self._id, self._start_execute_time = var_0_1.http_request_manager:__add_wait_execute(self)

		if self._upload_param then
			self._upload_param.start_time = self._start_execute_time
		end

		if var_12_1 then
			var_12_1.start_time = self._start_execute_time
		end

		self._last_active_time = self._start_execute_time

		self:__reset()
	end

	function arg_1_0:__run_once(arg_13_1)
		if self._state == var_0_21 then
			self:__close_file()

			local var_13_0 = false
			local var_13_1 = self._response.body_data

			if self._download_param then
				var_13_1 = self._download_param.write_path

				if self._download_param.file_md5 and self._download_param.file_md5 ~= var_0_13.file_sum(self._download_param.write_path) then
					var_0_6(self._download_param.write_path)

					var_13_0 = true
				end

				if self._download_param.meta_path then
					var_0_6(self._download_param.meta_path)
				end
			end

			if var_13_0 then
				self:__on_error(-3)
			elseif self._response.is_finish and self._response_func then
				self._response_func(self._url, var_13_1, self._cookie)
			end

			return true
		end

		if arg_13_1 - self._last_active_time > self._timeout then
			self:__on_error(-1)

			return true
		end

		if self._state == var_0_17 then
			self:__wait_connect()
		end

		if self._state == var_0_18 then
			self:__wait_send_body(arg_13_1)
		end

		if self._state == var_0_19 or self._state == var_0_18 then
			self:__wait_headers()
		end

		if self._state == var_0_20 then
			self:__wait_body(arg_13_1)
		end

		var_0_12.check_send(self._con)
		var_0_12.check_recv(self._con)

		return false
	end

	function arg_1_0:__on_destroy()
		if self._con then
			var_0_12.release(self._con)

			self._con = nil
		end

		self:__close_file()
	end

	function arg_1_0:__check_can_change()
		if self._id ~= 0 then
			var_0_3(self._id == 0, "already execute.")
		end
	end

	function arg_1_0:__check_generate_param()
		if self._url == "" then
			var_0_3(self._url ~= "")
		end

		if self._upload_param then
			var_0_3(self._fields == "")
			var_0_3(self._is_post)
		end

		if self._download_param then
			var_0_3(not self._is_post)
		end

		local var_16_0 = var_0_14.parse(self._url)

		if var_0_2(var_16_0) ~= "table" then
			var_0_3(var_0_2(var_16_0) == "table")
		end

		var_16_0.port = var_16_0.port and var_0_5(var_16_0.port) or 80
		var_16_0.path = var_16_0.path or "/"

		local var_16_1 = ""

		if not self._is_post and self._fields ~= "" then
			var_16_1 = "?" .. self._fields
		end

		self._host = var_16_0.host
		self._authority = var_16_0.authority
		self._path = var_16_0.path .. var_16_1
		self._ip = var_0_1.http_request_manager:__get_host_ip(self._host)
		self._port = var_16_0.port
	end

	function arg_1_0.__format_table_fields(arg_17_0, arg_17_1)
		if var_0_2(arg_17_1) == "table" then
			local var_17_0 = {}

			for iter_17_0, iter_17_1 in pairs(arg_17_1) do
				var_0_9(var_17_0, var_0_8("%s=%s", var_0_4(iter_17_0), var_0_11.url_encode(var_0_4(iter_17_1))))
			end

			arg_17_1 = var_0_10(var_17_0, "&")
		end

		return arg_17_1
	end

	function arg_1_0:__reset()
		if self._con then
			var_0_12.release(self._con)
		end

		self._con = var_0_12.create()
		self._state = var_0_17
		self._response.chunked = false
		self._response.length = nil
		self._response.has_next = false
		self._response.recv_data = ""
		self._response.body_data = ""
		self._response.already_body_size = 0
	end

	function arg_1_0:__close_file()
		if self._upload_param and self._upload_param.file then
			self._upload_param.file:close()

			self._upload_param.file = nil
		end

		local var_19_0 = self._download_param

		if self._download_param and var_19_0.file then
			var_19_0.file:close()

			var_19_0.file = nil
		end
	end

	function arg_1_0:__on_error(arg_20_1)
		self:__close_file()

		if self._error_func then
			self._error_func(self._url, arg_20_1)
		end
	end

	function arg_1_0:__make_request()
		local var_21_0 = {}

		if self._is_post then
			var_0_9(var_21_0, var_0_8("POST %s HTTP/1.1\r\n", self._path))
		else
			var_0_9(var_21_0, var_0_8("GET %s HTTP/1.1\r\n", self._path))
		end

		var_0_9(var_21_0, var_0_8("Host: %s\r\n", self._host))
		var_0_9(var_21_0, "Accept: */*\r\n")

		for iter_21_0, iter_21_1 in pairs(self._headers) do
			var_0_9(var_21_0, var_0_8("%s: %s\r\n", iter_21_0, iter_21_1))
		end

		local var_21_1 = #self._fields

		if self._upload_param then
			var_21_1 = self._upload_param.total_size

			var_0_9(var_21_0, var_0_8("upload_filename: %s\r\n", self._upload_param.uri))
		end

		if self._is_post and var_21_1 > 0 then
			var_0_9(var_21_0, var_0_8("Content-Length: %d\r\n", var_21_1))
			var_0_9(var_21_0, "\r\n")

			if not self._upload_param then
				self._post_param = {
					already_size = 0,
					total_size = var_21_1,
					data = self._fields
				}
			end
		else
			var_0_9(var_21_0, "\r\n")
		end

		return var_0_10(var_21_0)
	end

	function arg_1_0:__send_request_headers()
		var_0_12.set_send_limit(self._con, self._send_limit_size)
		var_0_12.set_recv_limit(self._con, self._recv_limit_size)
		var_0_12.send_data(self._con, self:__make_request())
	end

	function arg_1_0:__wait_connect()
		if var_0_12.connect(self._con, self._ip, self._port) then
			self:__send_request_headers()

			self._state = var_0_18
		end
	end

	function arg_1_0:__wait_send_body(arg_24_1)
		if self._post_param or self._upload_param then
			local var_24_0 = self._send_limit_size - 1 - var_0_12.get_send_buffer_byte_size(self._con)

			if var_24_0 <= 0 then
				return
			end

			if self._post_param then
				local var_24_1 = self._post_param.total_size - self._post_param.already_size

				if self._post_param.total_size - self._post_param.already_size > 0 then
					if var_24_0 < var_24_1 then
						var_24_1 = var_24_0
					end

					var_0_12.send_data(self._con, (self._post_param.data:sub(self._post_param.already_size + 1, self._post_param.already_size + var_24_1)))

					self._post_param.already_size = self._post_param.already_size + var_24_1
					self._last_active_time = arg_24_1

					return
				end
			end

			if self._upload_param then
				local var_24_2 = self._upload_param.file:read(var_24_0)

				if var_24_2 then
					var_0_12.send_data(self._con, var_24_2)
					self:__calculate_process(self._upload_param, #var_24_2, arg_24_1)

					self._last_active_time = arg_24_1

					return
				end
			end
		end

		self._state = var_0_19
	end

	function arg_1_0:__wait_headers()
		if not var_0_12.find_data_end_size(self._con, "\r\n\r\n") then
			return
		end

		local var_25_0 = var_0_12.get_line(self._con, "\r\n")

		if not var_25_0 then
			return
		end

		local var_25_1 = {}

		while true do
			local var_25_2 = var_0_12.get_line(self._con, "\r\n")

			if not var_25_2 then
				break
			end

			local var_25_3, var_25_4 = var_25_2:match("^([^%s:]+):%s*(.+)$")

			if var_25_3 then
				var_25_1[var_25_3:lower()] = var_25_4
			end
		end

		local var_25_5, var_25_6 = var_25_0:match("HTTP/[%d%.]+%s+([%d]+)%s+(.*)$")
		local var_25_7 = var_0_5(var_25_5)

		if var_25_1["set-cookie"] then
			self._cookie = var_25_1["set-cookie"]
		end

		if var_25_7 == 301 or var_25_7 == 302 then
			local var_25_8 = var_25_1.location

			if not var_25_1.location then
				return
			end

			self._url = var_0_14.absolute(self._url, var_25_8)

			self:__check_generate_param()
			self:__reset()

			return
		end

		if var_25_7 == 200 or var_25_7 == 206 and self._download_param then
			local var_25_9 = self._response

			var_25_9.recv_data = ""
			var_25_9.body_data = ""
			var_25_9.already_body_size = 0

			if var_25_1["content-length"] then
				var_25_9.chunked = false
				var_25_9.length = var_0_5(var_25_1["content-length"])
				var_25_9.has_next = false
			elseif var_25_1["transfer-encoding"] then
				if var_25_1["transfer-encoding"]:lower() == "chunked" then
					var_25_9.chunked = true
					var_25_9.length = nil
					var_25_9.has_next = true
				else
					var_0_3(false)
				end
			else
				var_0_3(false)
			end

			self._state = var_0_20
		else
			self:__on_error(var_25_7)

			self._state = var_0_21
		end
	end

	function arg_1_0:__wait_body(arg_26_1)
		local var_26_0 = 0

		while var_26_0 < self._recv_limit_size * 2 do
			local var_26_1, var_26_2 = var_0_12.get_data(self._con, self._recv_limit_size * 2)

			if var_26_1 == nil then
				break
			end

			var_26_0 = var_26_0 + var_26_2
			self._response.recv_data = self._response.recv_data .. var_26_1
		end

		self:__parse_response_data(self._response)

		if self._download_param then
			self._response.body_data = ""

			self:__on_download_data(self._response.body_data, #self._response.body_data, arg_26_1)
		end

		if self._response.chunked then
			if not self._response.has_next then
				self._response.is_finish = true
				self._state = var_0_21
			end
		elseif self._response.already_body_size == self._response.length then
			self._response.is_finish = true
			self._state = var_0_21
		end

		if var_26_0 > 0 then
			self._last_active_time = arg_26_1
		end
	end

	function arg_1_0:__parse_response_data(arg_27_1)
		if arg_27_1.chunked then
			self:__parse_chunk_data(arg_27_1)
		else
			arg_27_1.already_body_size = arg_27_1.already_body_size + #arg_27_1.recv_data
			arg_27_1.body_data = arg_27_1.body_data .. arg_27_1.recv_data
			arg_27_1.recv_data = ""
		end
	end

	function arg_1_0:__on_download_data(arg_28_1, arg_28_2, arg_28_3)
		self._download_param.file:write(arg_28_1)
		self:__calculate_process(self._download_param, arg_28_2, arg_28_3)
	end

	function arg_1_0.__calculate_process(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
		arg_29_1.already_size = arg_29_1.already_size + arg_29_2
		arg_29_1.speed = var_0_7((arg_29_1.already_size - (arg_29_1.first_pos or 0)) / (((arg_29_3 - arg_29_1.start_time <= 1e-06 or nil) and 1) / 1000))
		arg_29_1.progress = arg_29_1.already_size / arg_29_1.total_size
		arg_29_1.progress = arg_29_1.progress * 100

		if arg_29_1.progress > 100 then
			arg_29_1.progress = 100
		end

		if arg_29_1.progress_func then
			arg_29_1.progress_func(arg_29_1.total_size, arg_29_1.already_size, arg_29_1.progress, arg_29_1.speed)
		end
	end

	function arg_1_0.__parse_chunk_data(arg_30_0, arg_30_1)
		while arg_30_1.length == nil or arg_30_1.length <= #arg_30_1.recv_data do
			if arg_30_1.length == nil then
				local var_30_0, var_30_1 = arg_30_1.recv_data:find("\r\n")

				if var_30_0 then
					arg_30_1.length = var_0_5(arg_30_1.recv_data:sub(1, var_30_0 - 1), 16)
					arg_30_1.recv_data = arg_30_1.recv_data:sub(var_30_1 + 1)
				end

				if arg_30_1.length == nil and #arg_30_1.recv_data > 32 then
					var_0_3(false, "chunked size error.")
				end
			end

			if arg_30_1.length == nil then
				break
			end

			if arg_30_1.length == 0 then
				arg_30_1.has_next = false
				arg_30_1.recv_data = ""

				break
			end

			if arg_30_1.length > 0 and #arg_30_1.recv_data >= arg_30_1.length + 2 then
				arg_30_1.already_body_size = arg_30_1.already_body_size + arg_30_1.length
				arg_30_1.body_data = arg_30_1.body_data .. arg_30_1.recv_data:sub(1, arg_30_1.length)
				arg_30_1.recv_data = arg_30_1.recv_data:sub(arg_30_1.length + 2 + 1)
				arg_30_1.length = nil
			end
		end
	end

	function arg_1_0.__load_download_meta_file(arg_31_0, arg_31_1)
		if not arg_31_1 then
			return nil
		end

		local var_31_0 = io.open(arg_31_1, "rb")

		if not var_31_0 then
			return nil
		end

		local var_31_1 = var_31_0:read("*a")

		var_31_0:close()

		return var_0_16(var_31_1)
	end

	function arg_1_0.__save_download_meta_file(arg_32_0, arg_32_1, arg_32_2)
		if not arg_32_1.meta_path then
			return
		end

		local var_32_0 = io.open(arg_32_1.meta_path, "wb")

		var_32_0:write(var_0_15({
			url = arg_32_2,
			total_size = arg_32_1.total_size,
			file_md5 = arg_32_1.file_md5
		}))
		var_32_0:close()
	end

	function arg_1_0:__check_download(arg_33_1, arg_33_2)
		local var_33_0 = io.open(arg_33_1.write_path, "rb")

		if not var_33_0 then
			return io.open(arg_33_1.write_path, "wb")
		end

		var_33_0:close()

		local var_33_1 = self:__load_download_meta_file(arg_33_1.meta_path)

		if var_33_1 then
			if not var_33_1 or var_33_1.url ~= arg_33_2 or arg_33_1.total_size ~= var_33_1.total_size or arg_33_1.file_md5 ~= var_33_1.file_md5 then
				return io.open(arg_33_1.write_path, "wb")
			end
		elseif arg_33_1.total_size == get_file_length(arg_33_1.write_path) and arg_33_1.file_md5 == var_0_13.file_sum(arg_33_1.write_path) then
			self:__save_download_meta_file(arg_33_1, arg_33_2)
		else
			return io.open(arg_33_1.write_path, "wb")
		end

		local var_33_2 = io.open(arg_33_1.write_path, "ab")
		local var_33_3 = var_33_2:seek("end")

		if arg_33_1.total_size == var_33_3 then
			var_33_2:close()

			var_33_2 = io.open(arg_33_1.write_path, "rb+")
			var_33_3 = var_33_3 - 1

			var_33_2:seek("set", var_33_3)
		end

		return var_33_2, var_33_3
	end
end)

function var_0_0.create(arg_34_0)
	local var_34_0 = var_0_1.class("http_request")

	var_34_0._url_raw = ""
	var_34_0._url = ""
	var_34_0._timeout = 5000
	var_34_0._headers = {}
	var_34_0._fields = ""
	var_34_0._cookie = ""
	var_34_0._is_post = false
	var_34_0._send_limit_size = 65536
	var_34_0._recv_limit_size = 65536
	var_34_0._post_param = nil
	var_34_0._upload_param = nil
	var_34_0._download_param = nil
	var_34_0._response_func = nil
	var_34_0._error_func = nil
	var_34_0._id = 0
	var_34_0._start_execute_time = 0
	var_34_0._last_active_time = 0
	var_34_0._host = nil
	var_34_0._authority = nil
	var_34_0._path = nil
	var_34_0._ip = nil
	var_34_0._port = nil
	var_34_0._con = nil
	var_34_0._state = var_0_17
	var_34_0._response = {
		is_finish = false,
		recv_data = "",
		body_data = "",
		already_body_size = 0,
		chunked = false,
		has_next = false
	}

	return var_34_0
end

return var_0_0
