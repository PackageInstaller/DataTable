-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/GuideChange.lua

GuideChangeClose = class("GuideChangeClose", DebugViewTemplate, _M)

function GuideChangeClose:initialize()
	self._viewConfig = {
		{
			title = "关闭",
			name = "result",
			type = "Label"
		}
	}
end

function GuideChangeClose:onClick(data)
	GameConfigs.closeGuide = true

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()

	guideAgent:save("GUIDE_SKIP_ALL")
	guideAgent:skip(false)
	self:dispatch(ShowTipEvent({
		tip = Strings:get("EXEC_SUCC")
	}))

	local debugBox = self:getInjector():getInstance("DebugBox")

	debugBox:hide()
end

ChapterChangeClose = class("ChapterChangeClose", DebugViewTemplate, _M)

function ChapterChangeClose:initialize()
	self._viewConfig = {
		{
			title = "关闭",
			name = "result",
			type = "Label"
		}
	}
end

function ChapterChangeClose:onClick(data)
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()

	guideAgent:save("guide_chapterOne1_4")
	guideAgent:skip(false)
	self:dispatch(ShowTipEvent({
		tip = Strings:get("EXEC_SUCC")
	}))

	local debugBox = self:getInjector():getInstance("DebugBox")

	debugBox:hide()
end
