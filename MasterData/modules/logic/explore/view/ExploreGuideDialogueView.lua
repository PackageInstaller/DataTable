-- chunkname: @modules/logic/explore/view/ExploreGuideDialogueView.lua

module("modules.logic.explore.view.ExploreGuideDialogueView", package.seeall)

local ExploreGuideDialogueView = class("ExploreGuideDialogueView", BaseView)

function ExploreGuideDialogueView:onInitView()
	self._btnfullscreen = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullscreen")
	self._gochoicelist = gohelper.findChild(self.viewGO, "#go_choicelist")
	self._gochoiceitem = gohelper.findChild(self.viewGO, "#go_choicelist/#go_choiceitem")
	self._txttalkinfo = gohelper.findChildText(self.viewGO, "go_normalcontent/txt_contentcn")
	self._txttalker = gohelper.findChildText(self.viewGO, "#txt_talker")

	gohelper.setActive(self._gochoicelist, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreGuideDialogueView:addEvents()
	self._btnfullscreen:AddClickListener(self.onClickFull, self)
	GuideController.instance:registerCallback(GuideEvent.OnClickSpace, self.onClickFull, self)
	GuideController.instance:registerCallback(GuideEvent.OneKeyFinishGuides, self.closeThis, self)
end

function ExploreGuideDialogueView:removeEvents()
	GuideController.instance:unregisterCallback(GuideEvent.OnClickSpace, self.onClickFull, self)
	GuideController.instance:unregisterCallback(GuideEvent.OneKeyFinishGuides, self.closeThis, self)
	self._btnfullscreen:RemoveClickListener()
end

function ExploreGuideDialogueView:onClickFull()
	if self._hasIconDialogItem:isPlaying() then
		self._hasIconDialogItem:conFinished()

		return
	end
end

function ExploreGuideDialogueView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)
	self:_refreshView()
end

function ExploreGuideDialogueView:onUpdateParam()
	self:_refreshView()
end

function ExploreGuideDialogueView:_refreshView()
	local content = string.gsub(self.viewParam.tipsContent, " ", " ")

	self._hasIconDialogItem = self._hasIconDialogItem or MonoHelper.addLuaComOnceToGo(self.viewGO, TMPFadeIn)

	self._hasIconDialogItem:playNormalText(content)

	self._txttalker.text = self.viewParam.tipsTalker
end

return ExploreGuideDialogueView
