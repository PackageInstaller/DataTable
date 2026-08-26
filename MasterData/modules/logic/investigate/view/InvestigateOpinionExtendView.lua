-- chunkname: @modules/logic/investigate/view/InvestigateOpinionExtendView.lua

module("modules.logic.investigate.view.InvestigateOpinionExtendView", package.seeall)

local InvestigateOpinionExtendView = class("InvestigateOpinionExtendView", BaseView)

function InvestigateOpinionExtendView:onInitView()
	self._simageunfinishedbg = gohelper.findChildSingleImage(self.viewGO, "root/view/#simage_unfinishedbg")
	self._simagefinishedbg = gohelper.findChildSingleImage(self.viewGO, "root/view/#simage_finishedbg")
	self._simagefullbg2 = gohelper.findChildSingleImage(self.viewGO, "root/view/#simage_fullbg2")
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "root/view/#simage_role")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/view/#txt_title")
	self._goOpinion = gohelper.findChild(self.viewGO, "root/view/#go_Opinion")
	self._goprogress = gohelper.findChild(self.viewGO, "root/view/#go_progress")
	self._goprogresitem = gohelper.findChild(self.viewGO, "root/view/#go_progress/#go_progresitem")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "root/view/#scroll_desc")
	self._txtroledec = gohelper.findChildText(self.viewGO, "root/view/#scroll_desc/viewport/content/#txt_roledec")
	self._txtdec = gohelper.findChildText(self.viewGO, "root/view/#scroll_desc/viewport/content/#txt_dec")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/view/#btn_close")
	self._btnrolestory = gohelper.findChildButtonWithAudio(self.viewGO, "root/view/#btn_rolestory")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function InvestigateOpinionExtendView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnrolestory:AddClickListener(self._btnrolestoryOnClick, self)
end

function InvestigateOpinionExtendView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnrolestory:RemoveClickListener()
end

function InvestigateOpinionExtendView:_btnrolestoryOnClick()
	local mo, _ = InvestigateOpinionModel.instance:getInfo()
	local isAllLinked = InvestigateOpinionModel.instance:allOpinionLinked(mo.id)

	if isAllLinked then
		InvestigateController.instance:openInvestigateRoleStoryView(mo.id)
	end
end

function InvestigateOpinionExtendView:_btncloseOnClick()
	self.viewContainer:switchTab(InvestigateEnum.OpinionTab.Normal)
end

function InvestigateOpinionExtendView:_editableInitView()
	self._btnAnimator = self._btnrolestory.gameObject:GetComponent("Animator")
	self._rootAnimator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	local audioId = AudioEnum.VersionActivity2_2Investigate.play_ui_activity_course_open

	gohelper.addUIClickAudio(self._btnclose.gameObject, audioId)
end

function InvestigateOpinionExtendView:playAnim(name, callback, callbackObj)
	self._rootAnimator:Play(name, callback, callbackObj)
end

function InvestigateOpinionExtendView:onTabSwitchOpen()
	self.addEventCb(self, InvestigateController.instance, InvestigateEvent.ChangeArrow, self._onChangeArrow, self)
	self:_onChangeArrow()
end

function InvestigateOpinionExtendView:onTabSwitchClose()
	self.removeEventCb(self, InvestigateController.instance, InvestigateEvent.ChangeArrow, self._onChangeArrow, self)
end

function InvestigateOpinionExtendView:_onChangeArrow()
	local mo, _ = InvestigateOpinionModel.instance:getInfo()
	local isAllLinked = InvestigateOpinionModel.instance:allOpinionLinked(mo.id)

	gohelper.setActive(self._btnclose, true)
	gohelper.setActive(self._btnrolestory, isAllLinked)

	if isAllLinked and not InvestigateController.hasOnceActionKey(InvestigateEnum.OnceActionType.StoryBtn, mo.id) then
		InvestigateController.setOnceActionKey(InvestigateEnum.OnceActionType.StoryBtn, mo.id)
		self._btnAnimator:Play("finish", 0, 0)
	end
end

function InvestigateOpinionExtendView:onOpen()
	self:_onChangeArrow()
end

function InvestigateOpinionExtendView:onClose()
	return
end

function InvestigateOpinionExtendView:onDestroyView()
	return
end

return InvestigateOpinionExtendView
