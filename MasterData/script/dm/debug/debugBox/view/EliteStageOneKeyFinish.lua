-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/EliteStageOneKeyFinish.lua

EliteEliteStageOneKeyFinish = class("EliteStageOneKeyFinish", DebugViewTemplate, _M)

function EliteStageOneKeyFinish:initialize()
	self._opType = 124
	self._viewConfig = {
		{
			default = "E04S02",
			name = "pointId",
			title = "关卡Id",
			type = "Input"
		}
	}
end

function EliteStageOneKeyFinish:onClick(data)
	local pointId = data.pointId

	if not pointId or pointId == "" then
		return
	end

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

function EliteStageOneKeyFinish:storyFinish()
	local stageSystem = self:getInjector():getInstance(StageSystem)

	stageSystem:debugStoryAutoFinish()
end
