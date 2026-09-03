-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/GuideReset.lua

GuideReset = class("GuideReset", DebugViewTemplate, _M)

function GuideReset:initialize()
	self._viewConfig = {
		{
			title = "两种方式,不用的填 0",
			name = "tip",
			type = "Label"
		},
		{
			title = "优先关卡名字方式",
			name = "tip",
			type = "Label"
		},
		{
			default = "0",
			name = "script",
			title = "填写脚本名称",
			type = "Input"
		},
		{
			default = "0",
			name = "pointId",
			title = "填写关卡名称",
			type = "Input"
		}
	}
end

function GuideReset:onClick(data)
	local script = data.script
	local pointId = data.pointId

	if string.len(script) > 0 or string.len(pointId) > 0 then
		local this = self
		local guideSystem = self:getInjector():getInstance(GuideSystem)
		local tempScript = guideSystem:getBindGuideName(pointId)

		if tempScript then
			script = tempScript
		end

		GameConfigs.resetGuide = script

		guideSystem:resetGuide(script, function()
			local script = GameConfigs.resetGuide

			if script then
				this:runGuideScript(script)
			end
		end)
	end

	local debugBox = self:getInjector():getInstance("DebugBox")

	debugBox:hide()
end

function GuideReset:runGuideScript(guideName)
	if guideName and string.len(guideName) > 3 then
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local guideAgent = storyDirector:getGuideAgent()

		guideAgent:trigger(guideName, nil, nil)
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
	end
end
