-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/TestPlayStory.lua

TestPlayStory = class("TestPlayStory", DebugViewTemplate, _M)

function TestPlayStory:initialize()
	self._viewConfig = {
		{
			default = "elitestory01_1a",
			name = "script",
			title = "填写脚本名称",
			type = "Input"
		}
	}
end

function TestPlayStory:onClick(data)
	local script = data.script

	if string.len(script) > 0 then
		local this = self
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local storyAgent = storyDirector:getStoryAgent()
		local guideName = script

		storyAgent:resetSaved(guideName, function()
			if guideName then
				this:runGuideScript(guideName)
			end
		end)
	end
end

function TestPlayStory:runGuideScript(guideName)
	if guideName and string.len(guideName) > 3 then
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local storyAgent = storyDirector:getStoryAgent()

		storyAgent:trigger(guideName, nil, function()
			dump("runGuideScript >>>>>>>>")
		end)
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, {
			viewName = "homeView"
		}))

		local debugBox = self:getInjector():getInstance("DebugBox")

		debugBox:hide()
	end
end
