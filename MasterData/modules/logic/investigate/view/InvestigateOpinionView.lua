-- chunkname: @modules/logic/investigate/view/InvestigateOpinionView.lua

module("modules.logic.investigate.view.InvestigateOpinionView", package.seeall)

local InvestigateOpinionView = class("InvestigateOpinionView", BaseView)

function InvestigateOpinionView:onInitView()
	self._simageunfinishedbg = gohelper.findChildSingleImage(self.viewGO, "root/view/#simage_unfinishedbg")
	self._simagefinishedbg = gohelper.findChildSingleImage(self.viewGO, "root/view/#simage_finishedbg")
	self._simagecircle = gohelper.findChildSingleImage(self.viewGO, "root/view/#simage_circle")
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "root/view/#simage_role")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "root/view/#simage_mask")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/view/#txt_title")
	self._btnleftarrow = gohelper.findChildButtonWithAudio(self.viewGO, "root/view/#txt_title/#btn_leftarrow")
	self._btnrightarrow = gohelper.findChildButtonWithAudio(self.viewGO, "root/view/#txt_title/#btn_rightarrow")
	self._goprogress = gohelper.findChild(self.viewGO, "root/view/#go_progress")
	self._goprogresitem = gohelper.findChild(self.viewGO, "root/view/#go_progress/#go_progresitem")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "root/view/#scroll_desc")
	self._gocontent = gohelper.findChild(self.viewGO, "root/view/#scroll_desc/viewport/#go_content")
	self._txtroledec = gohelper.findChildText(self.viewGO, "root/view/#scroll_desc/viewport/#go_content/#txt_roledec")
	self._txtdec = gohelper.findChildText(self.viewGO, "root/view/#scroll_desc/viewport/#go_content/#txt_dec")
	self._btnextend = gohelper.findChildButtonWithAudio(self.viewGO, "root/view/#btn_extend")
	self._goOpinion = gohelper.findChild(self.viewGO, "root/view/#go_Opinion")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function InvestigateOpinionView:addEvents()
	self._btnextend:AddClickListener(self._btnextendOnClick, self)
end

function InvestigateOpinionView:removeEvents()
	self._btnextend:RemoveClickListener()
end

function InvestigateOpinionView:_btnextendOnClick()
	self.viewContainer:switchTab(InvestigateEnum.OpinionTab.Extend)
end

local blockKey = "delayOpenInvestigateRoleStoryView"

function InvestigateOpinionView:_editableInitView()
	self.addEventCb(self, InvestigateController.instance, InvestigateEvent.LinkedOpinionSuccess, self._onLinkedOpinionSuccess, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)

	self._goFinish = gohelper.findChild(self.viewGO, "root/view/Bottom/#finish")

	local audioId = AudioEnum.VersionActivity2_2Investigate.play_ui_activity_course_open

	gohelper.addUIClickAudio(self._btnextend.gameObject, audioId)
end

function InvestigateOpinionView:_onLinkedOpinionSuccess(opinionId)
	local mo, _ = InvestigateOpinionModel.instance:getInfo()
	local isAllLinked = InvestigateOpinionModel.instance:allOpinionLinked(mo.id)

	if isAllLinked then
		UIBlockMgr.instance:startBlock(blockKey)
		TaskDispatcher.cancelTask(self._openInvestigateRoleStoryView, self)
		TaskDispatcher.runDelay(self._openInvestigateRoleStoryView, self, 1.3)
		gohelper.setActive(self._goFinish, true)
	end
end

function InvestigateOpinionView:_openInvestigateRoleStoryView()
	UIBlockMgr.instance:endBlock(blockKey)

	local mo, _ = InvestigateOpinionModel.instance:getInfo()

	InvestigateController.instance:openInvestigateRoleStoryView(mo.id)
end

function InvestigateOpinionView:_onOpenViewFinish(viewName)
	if viewName == ViewName.InvestigateRoleStoryView then
		self.viewContainer:switchTab(InvestigateEnum.OpinionTab.Extend)
	end
end

function InvestigateOpinionView:onTabSwitchOpen()
	return
end

function InvestigateOpinionView:onTabSwitchClose()
	return
end

function InvestigateOpinionView:onClose()
	UIBlockMgr.instance:endBlock(blockKey)
	TaskDispatcher.cancelTask(self._openInvestigateRoleStoryView, self)
end

function InvestigateOpinionView:onDestroyView()
	return
end

return InvestigateOpinionView
