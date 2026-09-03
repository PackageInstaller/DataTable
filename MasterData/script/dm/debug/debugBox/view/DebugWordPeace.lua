-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/DebugWordPeace.lua

DebugWordPeace = class("DebugWordPeace", DebugViewTemplate, _M)

function DebugWordPeace:initialize()
	self._opType = 461
	self._viewConfig = {
		{
			default = "1",
			name = "num",
			title = "社团数",
			type = "Input"
		},
		{
			default = "100",
			name = "combat",
			title = "基础战力",
			type = "Input"
		},
		{
			default = "1",
			name = "robot",
			title = "生成机器人",
			type = "Input"
		},
		{
			default = "1",
			name = "robotNum",
			title = "攻击数量",
			type = "Input"
		}
	}
end

function DebugWordPeace:onClick(data)
	dump(data, "data")

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		if isSucc then
			self:dispatch(ShowTipEvent({
				tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
			}))
		end

		local worldPeaceSystem = self:getInjector():getInstance("WorldPeaceSystem")

		worldPeaceSystem:requestUpdateData(nil, false)
	end)
end

DebugWordPeaceSineUp = class("DebugWordPeaceSineUp", DebugViewTemplate, _M)

function DebugWordPeaceSineUp:initialize()
	self._opType = 462
	self._viewConfig = {}
end

function DebugWordPeaceSineUp:onClick(data)
	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		if isSucc then
			self:dispatch(ShowTipEvent({
				tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
			}))
		end
	end)
end

DebugWordPeaceTime = class("DebugWordPeaceTime", DebugViewTemplate, _M)

function DebugWordPeaceTime:initialize()
	self._opType = 402
	self._viewConfig = {
		{
			default = "1",
			name = "timestamp",
			title = "调整跨服&game服时间",
			type = "Input"
		}
	}
end

function DebugWordPeaceTime:onClick(data)
	dump(data, "data")

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		if isSucc then
			self:dispatch(ShowTipEvent({
				tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
			}))
		end
	end)
end

DebugWordPeaceAttr = class("DebugWordPeaceAttr", DebugViewTemplate, _M)

function DebugWordPeaceAttr:initialize()
	self._opType = 463
	self._viewConfig = {
		{
			default = "1",
			name = "hp",
			title = "hp",
			type = "Input"
		},
		{
			default = "1",
			name = "atk",
			title = "atk",
			type = "Input"
		},
		{
			default = "1",
			name = "def",
			title = "def",
			type = "Input"
		}
	}
end

function DebugWordPeaceAttr:onClick(data)
	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		if isSucc then
			self:dispatch(ShowTipEvent({
				tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
			}))
		end
	end)
end

DebugWordPeaceRoboot = class("DebugWordPeaceRoboot", DebugViewTemplate, _M)

function DebugWordPeaceRoboot:initialize()
	self._opType = 464
	self._viewConfig = {
		{
			default = "50",
			name = "num",
			title = "一次周期刷出几队",
			type = "Input"
		},
		{
			default = "1",
			name = "revive",
			title = "是否无限复活",
			type = "Input"
		}
	}
end

function DebugWordPeaceRoboot:onClick(data)
	dump(data, "data")

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		if isSucc then
			self:dispatch(ShowTipEvent({
				tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
			}))
		end
	end)
end

DebugWordPeaceSwear = class("DebugWordPeaceSwear", DebugViewTemplate, _M)

function DebugWordPeaceSwear:initialize()
	self._opType = 466
	self._viewConfig = {}
end

function DebugWordPeaceSwear:onClick(data)
	dump(data, "data")

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		if isSucc then
			self:dispatch(ShowTipEvent({
				tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
			}))
		end
	end)
end

DebugWordPeaceSwearFixRank = class("DebugWordPeaceSwearFixRank", DebugViewTemplate, _M)

function DebugWordPeaceSwearFixRank:initialize()
	self._opType = 467
	self._viewConfig = {
		{
			default = "7",
			name = "rank",
			title = "评级",
			type = "Input"
		}
	}
end

function DebugWordPeaceSwearFixRank:onClick(data)
	dump(data, "data")

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		if isSucc then
			self:dispatch(ShowTipEvent({
				tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
			}))
		end
	end)
end

AddWorldBossTimes = class("AddWorldBossTimes", DebugViewTemplate, _M)

function AddWorldBossTimes:initialize()
	self._opType = 516
	self._viewConfig = {
		{
			default = "10",
			name = "times",
			title = "次数",
			type = "Input"
		}
	}
end

function AddWorldBossTimes:onClick(data)
	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		if isSucc then
			self:dispatch(ShowTipEvent({
				tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
			}))
		end
	end)
end
