-- chunkname: @modules/logic/story/view/StoryLogView.lua

module("modules.logic.story.view.StoryLogView", package.seeall)

local StoryLogView = class("StoryLogView", BaseView)

function StoryLogView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_close")
	self._scrolllog = gohelper.findChildScrollRect(self.viewGO, "#scroll_log")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryLogView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function StoryLogView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function StoryLogView:_btncloseOnClick()
	self:closeThis()
end

function StoryLogView:_editableInitView()
	return
end

function StoryLogView:onUpdateParam()
	return
end

function StoryLogView:onOpen()
	self:_refreshView()
end

function StoryLogView:onOpenFinish()
	PostProcessingMgr.instance:setIgnoreUIBlur(true)
end

function StoryLogView:_refreshView()
	local log = StoryModel.instance:getLog()

	StoryLogListModel.instance:setLogList(log)

	self._scrolllog.verticalNormalizedPosition = 0
end

function StoryLogView:onClose()
	PostProcessingMgr.instance:setIgnoreUIBlur(false)
	AudioEffectMgr.instance:stopAudio(StoryLogListModel.instance:getPlayingLogAudioId(), 0)
end

function StoryLogView:onDestroyView()
	return
end

return StoryLogView
