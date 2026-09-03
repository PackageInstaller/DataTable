-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/GuideEndBattle.lua

GuideEndBattle = class("GuideEndBattle", DebugViewTemplate, _M)

function GuideEndBattle:initialize()
	self._viewConfig = {
		{
			default = "M02S02",
			name = "pointId",
			title = "填写关卡ID",
			type = "Input"
		}
	}
end

function GuideEndBattle:onClick(data)
	local pointId = data.pointId

	if string.len(pointId) > 0 then
		local this = self
		local guideSystem = self:getInjector():getInstance(GuideSystem)
		local script = guideSystem:getBindGuideName(pointId)

		GameConfigs.resetGuide = script

		guideSystem:resetGuide(script, function()
			local script = GameConfigs.resetGuide

			if script then
				this:runGuideScript(script)
			end
		end)
	end
end

function GuideEndBattle:runGuideScript(guideName)
	if guideName and string.len(guideName) > 3 then
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local guideAgent = storyDirector:getGuideAgent()

		guideAgent:play(guideName, nil, function()
			return
		end)
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
	end
end
