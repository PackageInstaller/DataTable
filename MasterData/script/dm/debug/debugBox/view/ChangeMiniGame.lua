-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/ChangeMiniGame.lua

ChangeDartsLevel = class("ChangeDartsLevel", DebugViewTemplate, _M)

function ChangeDartsLevel:initialize()
	self._opType = 999999
	self._viewConfig = {
		{
			default = 1,
			name = "level",
			title = "level",
			type = "Input"
		}
	}
end

function ChangeDartsLevel:onClick(data)
	local mText = self._viewConfig[1].mtext
	local dartsSystem = self:getInjector():getInstance(MiniGameSystem):getDartsSystem()

	dartsSystem:setCurLevel(tonumber(mText))
end

addMiniGameTimes = class("addMiniGameTimes", DebugViewTemplate, _M)

function addMiniGameTimes:initialize()
	self._opType = 420
	self._viewConfig = {
		{
			default = "Activity_Jump",
			name = "actId",
			title = "活动ID",
			type = "Input"
		},
		{
			default = 50,
			name = "times",
			title = "次数",
			type = "Input"
		}
	}
end

ChangeJumpStage = class("ChangeJumpStage", DebugViewTemplate, _M)

function ChangeJumpStage:initialize()
	self._opType = 999999
	self._viewConfig = {
		{
			default = 1,
			name = "stage",
			title = "跳台层数",
			type = "Input"
		}
	}
end

function ChangeJumpStage:onClick(data)
	local mText = self._viewConfig[1].mtext
	local jumpSystem = self:getInjector():getInstance(MiniGameSystem):getJumpSystem()

	jumpSystem:setBeginStage(tonumber(mText))
end

ChangeDiceNum = class("ChangeDiceNum", DebugViewTemplate, _M)

function ChangeDiceNum:initialize()
	self._opType = 424
	self._viewConfig = {
		{
			default = 1,
			name = "point",
			title = "骰子点数",
			type = "Input"
		}
	}
end

function ChangeDiceNum:onClick(data)
	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		self:dispatch(ShowTipEvent({
			tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
		}))
		print("cdscdsnkjcndsjkcndskcndkscndksncdksnckdsnckdsnckds")
		self:dispatch(Event:new("DEBUG_ROADWAY_FIXDICENUM", {
			response = response,
			param = {
				doActivityType = 101
			}
		}))
	end)
end

ChangeWorldBossTimes = class("ChangeWorldBossTimes", DebugViewTemplate, _M)

function ChangeWorldBossTimes:initialize()
	self._opType = 426
	self._viewConfig = {
		{
			default = 10,
			name = "time",
			title = "次数",
			type = "Input"
		}
	}
end
