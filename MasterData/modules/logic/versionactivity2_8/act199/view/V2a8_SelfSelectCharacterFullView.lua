-- chunkname: @modules/logic/versionactivity2_8/act199/view/V2a8_SelfSelectCharacterFullView.lua

module("modules.logic.versionactivity2_8.act199.view.V2a8_SelfSelectCharacterFullView", package.seeall)

local V2a8_SelfSelectCharacterFullView = class("V2a8_SelfSelectCharacterFullView", BaseView)

function V2a8_SelfSelectCharacterFullView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "role/#simage_role1")
	self._simagefrontbg = gohelper.findChildSingleImage(self.viewGO, "#simage_frontbg")
	self._txtremainTime = gohelper.findChildText(self.viewGO, "timebg/#txt_remainTime")
	self._goinviteContent = gohelper.findChild(self.viewGO, "#go_inviteContent")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "#go_inviteContent/#btn_check")
	self._gouninvite = gohelper.findChild(self.viewGO, "#go_inviteContent/#go_uninvite")
	self._btninvite = gohelper.findChildButtonWithAudio(self.viewGO, "#go_inviteContent/#go_uninvite/#btn_invite")
	self._btnuninviteTips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_inviteContent/#go_uninvite/#btn_uninviteTips")
	self._goinvited = gohelper.findChild(self.viewGO, "#go_inviteContent/#go_invited")
	self._btninviteTips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_inviteContent/#go_invited/#btn_inviteTips")
	self._simagerolehead = gohelper.findChildSingleImage(self.viewGO, "#go_inviteContent/#go_invited/#btn_inviteTips/#simage_rolehead")
	self._txtrolename = gohelper.findChildText(self.viewGO, "#go_inviteContent/#go_invited/#txt_rolename")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a8_SelfSelectCharacterFullView:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
	self._btninvite:AddClickListener(self._btninviteOnClick, self)
	self._btnuninviteTips:AddClickListener(self._btnuninviteTipsOnClick, self)
	self._btninviteTips:AddClickListener(self._btninviteTipsOnClick, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self.addEventCb(self, V2a8_SelfSelectSix_PickChoiceController.instance, V2a8_SelfSelectSix_PickChoiceEvent.GetHero, self._refreshUI, self)
end

function V2a8_SelfSelectCharacterFullView:removeEvents()
	self._btncheck:RemoveClickListener()
	self._btninvite:RemoveClickListener()
	self._btnuninviteTips:RemoveClickListener()
	self._btninviteTips:RemoveClickListener()
	self.removeEventCb(self, V2a8_SelfSelectSix_PickChoiceController.instance, V2a8_SelfSelectSix_PickChoiceEvent.GetHero, self._refreshUI, self)
end

function V2a8_SelfSelectCharacterFullView:_btncheckOnClick()
	HelpController.instance:openBpRuleTipsView(luaLang("ruledetail"), "Rule Details", luaLang("anniversary_bonus_rule"))
end

function V2a8_SelfSelectCharacterFullView:_btninviteOnClick()
	V2a8_SelfSelectSix_PickChoiceListModel.instance:initDatas(self._actId)
	ViewMgr.instance:openView(ViewName.V2a8_SelfSelectSix_PickChoiceView)
end

function V2a8_SelfSelectCharacterFullView:_editableInitView()
	return
end

function V2a8_SelfSelectCharacterFullView:onUpdateParam()
	return
end

function V2a8_SelfSelectCharacterFullView:onOpen()
	self._actId = self.viewParam.actId

	Activity199Rpc.instance:sendGet199InfoRequest(self._actId, self._refreshUI, self)
end

function V2a8_SelfSelectCharacterFullView:_refreshUI()
	local havePick = Activity199Model.instance:getSelectHeroId() ~= 0

	gohelper.setActive(self._goinvited, havePick)
	gohelper.setActive(self._gouninvite, not havePick)

	if havePick then
		self:_refreshSelectRole()
	end

	self._txtremainTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function V2a8_SelfSelectCharacterFullView:_refreshSelectRole()
	local heroId = Activity199Model.instance:getSelectHeroId()
	local heroConfig = HeroConfig.instance:getHeroCO(heroId)

	if not heroConfig then
		logError("SummonNewCustomPick.refreshUI error, heroConfig is nil, id:" .. tostring(heroId))

		return
	end

	local skinConfig = SkinConfig.instance:getSkinCo(heroConfig.skinId)

	if not skinConfig then
		logError("SummonNewCustomPick.refreshUI error,  skinCfg is nil, id:" .. tostring(heroConfig.skinId))

		return
	end

	self._simagerolehead:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))

	self._txtrolename.text = heroConfig.name
end

function V2a8_SelfSelectCharacterFullView:onDestroyView()
	return
end

function V2a8_SelfSelectCharacterFullView:onRefreshActivity()
	local status = ActivityHelper.getActivityStatus(self._actId)

	if status == ActivityEnum.ActivityStatus.NotOnLine or status == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

return V2a8_SelfSelectCharacterFullView
