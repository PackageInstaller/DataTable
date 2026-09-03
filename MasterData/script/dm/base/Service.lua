-- chunkname: @/tmp/or_script/lua_compile/dm/base/Service.lua

EVT_SYNCHRONIZE_DIFF = "EVT_SYNCHRONIZE_DIFF"
EVT_VIEW_ENTER_REQUEST = "EVT_VIEW_ENTER_REQUEST"
Service = class("Service", legs.Actor, _M)

Service:has("_gameServer", {
	is = "r"
}):injectWith("GameServerAgent")

GS_SUCCESS = 0

function Service:initialize()
	super.initialize(self)
end

function Service:dispose()
	super.dispose(self)
end

function Service:newRequest(opcode, params, callback)
	local version = 0
	local loginSystem = self:getInjector():getInstance(LoginSystem)
	local rid = loginSystem:getPlayerRid()
	local cjson = require("cjson.safe")
	local paramsData = cjson.encode(params)

	if paramsData ~= nil then
		paramsData = string.char(version, string.len(rid)) .. rid .. paramsData
	end

	if GAME_SHOW_NETDATA then
		if GameConfigs.dpsLoggerEnable and GameConfigs.dpsLoggerConfig.userName then
			DpsLogger:debug(GameConfigs.dpsLoggerConfig.userName, "client===>>server(" .. opcode .. ")params:")
			DpsLogger:debug(GameConfigs.dpsLoggerConfig.userName, params)
		else
			dump(params, "client===>>server(" .. opcode .. ")")
		end
	end

	local function requestCallback(req, err, resp)
		if err == rrcp.ERR_NO_ERROR then
			local response = cjson.decode(resp)

			if response then
				if GAME_SHOW_NETDATA then
					if GameConfigs.dpsLoggerEnable and GameConfigs.dpsLoggerConfig.userName then
						DpsLogger:debug(GameConfigs.dpsLoggerConfig.userName, "client<<===server(" .. opcode .. ")response:")
						DpsLogger:debug(GameConfigs.dpsLoggerConfig.userName, response)
					else
						dump(response, "client<<===server(" .. opcode .. ")")
					end
				end

				response.resCode = response.resCode or GS_SUCCESS

				if response.resCode == GS_SUCCESS then
					if not response.d then
						if response.del then
							local var_4_0 = {}

							var_4_0.diff = response.d or {}
							var_4_0.del = response.del or {}

							self:dispatch(Event:new(EVT_SYNCHRONIZE_DIFF, var_4_0))
						else
							do
								local tipstr = Strings:get("Error_" .. response.resCode)

								if tipstr == nil or tipstr == "" then
									tipstr = response.resCode
								end

								self:dispatch(ShowTipEvent({
									duration = 0.35,
									tip = tipstr
								}))
							end
						end

						if callback then
							callback(response)
						end
					end
				end

				self:dispatch(event.Event:new(EVT_VIEW_ENTER_REQUEST, {
					response = response,
					opcode = opcode
				}))
			else
				self:dispatch(ShowTipEvent({
					duration = 0.35,
					tip = Strings:get("JSONC_DECODE_ERROR")
				}))
				assert(false, string.format("response decode error, opcode:%s, resp:%s", opcode, resp))
			end
		else
			self:dispatch(ShowTipEvent({
				duration = 0.35,
				tip = Strings:get("REQ_FAIL", {
					err = err,
					req = resp
				})
			}))
		end
	end

	return GameServerRequest:new(opcode, paramsData, requestCallback)
end

function Service:sendRequest(request, blockUI)
	if blockUI == nil then
		blockUI = true
	end

	return self._gameServer:doRequest(request, blockUI)
end

function Service:addPushHandler(op, handler)
	self._gameServer:addPushHandler(op, function(op, rawdata)
		local cjson = require("cjson.safe")
		local data = cjson.decode(rawdata)

		if GAME_SHOW_NETDATA then
			if GameConfigs.dpsLoggerEnable and GameConfigs.dpsLoggerConfig.userName then
				DpsLogger:debug(GameConfigs.dpsLoggerConfig.userName, "client<<=push==server(" .. op .. ")pushData:")
				DpsLogger:debug(GameConfigs.dpsLoggerConfig.userName, data)
			else
				dump(data, "client<<=push==server(" .. op .. ")")
			end
		end

		if not data.d then
			if data.del then
				local var_7_0 = {}

				var_7_0.diff = data.d or {}
				var_7_0.del = data.del or {}

				self:dispatch(Event:new(EVT_SYNCHRONIZE_DIFF, var_7_0))
			end
		end

		return handler(op, data)
	end)
end
