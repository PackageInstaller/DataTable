-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/DebugRTPKScore.lua

DebugRTPKScore = class("DebugRTPKScore", DebugViewTemplate, _M)

function DebugRTPKScore:initialize()
	self._opType = 403
	self._viewConfig = {
		{
			default = 1500,
			name = "count",
			title = "score",
			type = "Input"
		}
	}
end

DebugRTPKAddRank = class("DebugRTPKAddRank", DebugViewTemplate, _M)

function DebugRTPKAddRank:initialize()
	self._opType = 405
	self._viewConfig = {
		{
			default = 3000,
			name = "max",
			title = "积分上限 ",
			type = "Input"
		},
		{
			default = 1000,
			name = "min",
			title = "积分下限 ",
			type = "Input"
		},
		{
			default = 20,
			name = "count",
			title = "人数 ",
			type = "Input"
		}
	}
end

DebugRTPKClearAll = class("DebugRTPKClearAll", DebugViewTemplate, _M)

function DebugRTPKClearAll:initialize()
	self._opType = 404
	self._viewConfig = {
		{
			title = "清除数据",
			name = "reset",
			type = "Label"
		}
	}
end

DebugRTPKAddCount = class("DebugRTPKAddCount", DebugViewTemplate, _M)

function DebugRTPKAddCount:initialize()
	self._opType = 406
	self._viewConfig = {
		{
			default = 1,
			name = "code",
			title = "1挑战2已挑战3连胜4连败5累积胜场 ",
			type = "Input"
		},
		{
			default = 5,
			name = "count",
			title = "次数",
			type = "Input"
		}
	}
end

RTPKChangeServerTime = class("RTPKChangeServerTime", DebugViewTemplate, _M)

function RTPKChangeServerTime:initialize()
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
		}
	}
end

function RTPKChangeServerTime:onClick(data)
	data.timestamp_D = 0
	data.timestamp_H = 0

	if data.timestamp == 0 then
		return
	else
		data.timestamp = TimeUtil:timeByRemoteDate(TimeUtil:parseDateTime({}, data.timestamp))
	end

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		self:dispatch(ShowTipEvent({
			tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
		}))
	end)
end

RTPKServerMatch = class("RTPKServerMatch", DebugViewTemplate, _M)

function RTPKServerMatch:initialize()
	self._opType = 407
	self._viewConfig = {
		{
			default = 1,
			name = "code",
			title = "1正常数据2指定数据",
			type = "Input"
		},
		{
			default = 0,
			name = "combat",
			title = "排行榜平均战力",
			type = "Input"
		},
		{
			default = 0,
			name = "login",
			title = "登录游戏总人数",
			type = "Input"
		}
	}
end

RTPKMatchSwitch = class("RTPKMatchSwitch", DebugViewTemplate, _M)

function RTPKMatchSwitch:initialize()
	self._opType = 408
	self._viewConfig = {
		{
			default = 0,
			name = "code",
			title = "1关闭0开启",
			type = "Input"
		}
	}
end
