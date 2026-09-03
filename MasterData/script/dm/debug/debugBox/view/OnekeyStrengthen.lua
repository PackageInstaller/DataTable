-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/OnekeyStrengthen.lua

OnekeyStrengthen = class("OnekeyStrengthen", DebugViewTemplate, _M)

function OnekeyStrengthen:initialize()
	self._opType = 112
	self._viewConfig = {
		{
			default = 1,
			name = "code",
			title = "1小强，2中强，3最强",
			type = "Input"
		}
	}
end

function OnekeyStrengthen:onClick(data)
	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		if isSucc then
			self:storyFinish()
			self:dispatch(ShowTipEvent({
				tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
			}))
		end
	end)
end

function OnekeyStrengthen:storyFinish()
	local stageSystem = self:getInjector():getInstance(StageSystem)

	stageSystem:debugStoryAutoFinish()
end
