-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_IllustrationMainView.lua

module("modules.logic.rouge2.outside.view.Rouge2_IllustrationMainView", package.seeall)

local Rouge2_IllustrationMainView = class("Rouge2_IllustrationMainView", BaseView)

function Rouge2_IllustrationMainView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._goBottom = gohelper.findChild(self.viewGO, "#go_Bottom")
	self._btnillustration = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Bottom/#btn_illustration")
	self._goillustrationSelected = gohelper.findChild(self.viewGO, "#go_Bottom/#btn_illustration/#go_illustrationSelected")
	self._btnreview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Bottom/#btn_review")
	self._goreviewSelected = gohelper.findChild(self.viewGO, "#go_Bottom/#btn_review/#go_reviewSelected")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_IllustrationMainView:addEvents()
	self._btnillustration:AddClickListener(self._btnillustrationOnClick, self)
	self._btnreview:AddClickListener(self._btnreviewOnClick, self)
end

function Rouge2_IllustrationMainView:removeEvents()
	self._btnillustration:RemoveClickListener()
	self._btnreview:RemoveClickListener()
end

function Rouge2_IllustrationMainView:_btnillustrationOnClick()
	if self._listSelected then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_main_switch_scene_2_2)
	self.viewContainer:selectTabView(1)
	self:_setBtnIllustrationSelected(true)
end

function Rouge2_IllustrationMainView:_btnreviewOnClick()
	if not self._listSelected then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_main_switch_scene_2_2)
	self.viewContainer:selectTabView(2)
	self:_setBtnIllustrationSelected(false)
end

function Rouge2_IllustrationMainView:_editableInitView()
	self:_setBtnIllustrationSelected(true)

	self._goreddotIllustration = gohelper.findChild(self.viewGO, "#go_Bottom/#btn_illustration/#go_reddot")
	self._goreddotStory = gohelper.findChild(self.viewGO, "#go_Bottom/#btn_review/#go_reddot")

	RedDotController.instance:addRedDot(self._goreddotIllustration, RedDotEnum.DotNode.V3a2_Rouge_Review_Illustration_Tab, 0)
	RedDotController.instance:addRedDot(self._goreddotStory, RedDotEnum.DotNode.V3a2_Rouge_Review_AVG_Tab, 0)
end

function Rouge2_IllustrationMainView:onUpdateParam()
	return
end

function Rouge2_IllustrationMainView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio6)
end

function Rouge2_IllustrationMainView:_setBtnIllustrationSelected(value)
	self._listSelected = value

	gohelper.setActive(self._goillustrationSelected, value)
	gohelper.setActive(self._goreviewSelected, not value)
end

function Rouge2_IllustrationMainView:onClose()
	return
end

function Rouge2_IllustrationMainView:onDestroyView()
	return
end

return Rouge2_IllustrationMainView
