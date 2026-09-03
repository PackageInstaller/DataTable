-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/changeServerTime.lua

changeServerTime = class("changeServerTime", DebugViewTemplate, _M)

function changeServerTime:initialize()
	self._opType = 99
	self._viewConfig = {
		{
			default = 0,
			name = "timestamp",
			title = "时间(秒)",
			type = "Input"
		},
		{
			default = 0,
			name = "timestamp_D",
			title = "n天以后",
			type = "Input"
		},
		{
			default = 0,
			name = "timestamp_H",
			title = "n小时以后",
			type = "Input"
		}
	}
end

function changeServerTime:onClick(data)
	local parms = {
		type = 99
	}

	if data.timestamp == 0 then
		if data.timestamp_H == 0 and data.timestamp_D == 0 then
			return
		else
			local serverTimeMap = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimestamp()

			parms.timestamp = serverTimeMap + 86400 * data.timestamp_H + 3600 * data.timestamp_H
		end
	else
		parms.timestamp = data.timestamp
	end

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		self:dispatch(ShowTipEvent({
			tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
		}))
	end)
end

changeTagetServerTime = class("changeTagetServerTime", DebugViewTemplate, _M)

function changeTagetServerTime:initialize()
	self._opType = 402
	self._viewConfig = {
		{
			default = 11,
			name = "target",
			title = "目标游戏服逗号分隔",
			type = "Input"
		},
		{
			default = 0,
			name = "timestamp",
			title = "yyyy-MM-dd HH:mm:ss",
			type = "Input"
		},
		{
			default = 0,
			name = "timestamp_D",
			title = "n天以后",
			type = "Input"
		},
		{
			default = 0,
			name = "timestamp_H",
			title = "n小时以后",
			type = "Input"
		}
	}
end

function changeTagetServerTime:onClick(data)
	local parms = {
		type = 402
	}

	if data.timestamp == 0 then
		if data.timestamp_H == 0 and data.timestamp_D == 0 then
			return
		else
			local serverTimeMap = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimestamp()

			parms.timestamp = serverTimeMap + 86400 * data.timestamp_H + 3600 * data.timestamp_H
		end
	else
		parms.timestamp = TimeUtil:timeByRemoteDate(TimeUtil:parseDateTime({}, data.timestamp))
		data.timestamp = parms.timestamp
	end

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		self:dispatch(ShowTipEvent({
			tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
		}))
	end)
end

openLdebug = class("openLdebug", DebugViewTemplate, _M)

function openLdebug:initialize()
	self._viewConfig = {
		{
			default = 6789,
			name = "port",
			title = "端口",
			type = "Input"
		}
	}
end

function openLdebug:onClick(data)
	local var_8_0 = require(".ldebug").start

	require(".ldebug"):start(data.port or 6789)
	self:dispatch(ShowTipEvent({
		tip = Strings:get("EXEC_SUCC")
	}))
end
