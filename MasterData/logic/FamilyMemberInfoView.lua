-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyMemberInfoView.lua

module("logic.extensions.family.view.FamilyMemberInfoView", package.seeall)

local FamilyMemberInfoView = class("FamilyMemberInfoView", PlayerInfoView)

function FamilyMemberInfoView:ctor()
	FamilyMemberInfoView.super.ctor(self)
end

function FamilyMemberInfoView:destroyUI()
	FamilyMemberInfoView.super.destroyUI(self)
end

function FamilyMemberInfoView:onExitFinished()
	FamilyMemberInfoView.super.onExitFinished(self)
end

function FamilyMemberInfoView:onEnterFinished()
	FamilyMemberInfoView.super.onEnterFinished(self)
end

function FamilyMemberInfoView:unbindEvents()
	FamilyMemberInfoView.super.unbindEvents(self)
	self._btnAssign:RemoveClickListener()
	self._btnKickout:RemoveClickListener()
end

function FamilyMemberInfoView:bindEvents()
	FamilyMemberInfoView.super.bindEvents(self)
	self._btnAssign:AddClickListener(self._onClickAssign, self)
	self._btnKickout:AddClickListener(self._onClickKickout, self)
end

function FamilyMemberInfoView:onExit()
	FamilyMemberInfoView.super.onExit(self)
end

function FamilyMemberInfoView:buildUI()
	FamilyMemberInfoView.super.buildUI(self)

	local top = self:getGo("Nego_Content/Nego_Top")
	local Nego_Info = goutil.findChild(top, "Nego_Info")

	self._posColorChange = goutil.findChildComponent(Nego_Info, "position", "UIImageColorChange")
	self._txtPosition = goutil.findChildTextComponent(Nego_Info, "position/txtAim")
	self._txtLevel = goutil.findChildTextComponent(Nego_Info, "txtLevel")

	local Nego_Bottom = self:getGo("Nego_Content/Nego_Bottom")

	self._btnAssign = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Assign")
	self._btnKickout = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Kickout")
end

function FamilyMemberInfoView:onEnter()
	self._info = self:getFirstParam()

	local simpleInfo = self._info.simpleInfo

	self._TxtC_Name.text = simpleInfo.userName
	self._TxtC_Zdl.text = self._info.maxZdl

	HeadItemController.instance:setHeadCellByInfo(self._imageChange, simpleInfo)
	self._posColorChange:SetState(self._info.role)

	self._txtPosition.text = lang("tip_family_position_" .. self._info.role)
	self._txtLevel.text = self._info.simpleInfo.playerLv .. "级"
	self._groupType = FriendModel.instance:getGroupTypeById(simpleInfo.userId)
	self._mo = {
		clothes = 1,
		headInfo = simpleInfo,
		maxZdl = self._info.maxZdl
	}

	self:_setBtnStates()
end

function FamilyMemberInfoView:_setBtnStates()
	FamilyMemberInfoView.super._setBtnStates(self)

	local myRole = FamilyModel.instance:getMyRole()
	local isHigherThenOther = myRole < self._info.role

	goutil.setActive(self._btnKickout.gameObject, FamilyConfig.instance:isHasAuthority("KICK_MEMBER", myRole) and isHigherThenOther)
	goutil.setActive(self._btnAssign.gameObject, FamilyConfig.instance:isHasAuthority("APPOINT_DISMISS_4", myRole) and isHigherThenOther)
	GameUtil.SetActive(self._Btn_Report, false)
end

function FamilyMemberInfoView:_onClickAssign()
	UIStateManager.instance:open(ViewName.FamilyAssign, self._info)
end

function FamilyMemberInfoView:_onClickKickout()
	local dailyKickCount = FamilyModel.instance:getDailyKickCount()
	local kickLimit = FamilyConfig.instance:getCommonValue("DAILY_KICK_LIMIT", true)
	local canKick = kickLimit > 0 and kickLimit <= dailyKickCount
	local color = canKick and "eb4642" or "11A568"
	local content = langPara("text_family_desc_30", color, dailyKickCount, kickLimit)

	if kickLimit <= dailyKickCount then
		FloatWordMgr.instance:show(lang("text_family_desc_29"))

		return
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
		FamilyController.instance:kickUserOutFamilyReq({
			self._info.simpleInfo.userId
		}, self._onKickoutSuccess, self)
	end)
end

function FamilyMemberInfoView:_onKickoutSuccess()
	self:close()
	FloatWordMgr.instance:show(lang("text_family_desc_28"))
end

return FamilyMemberInfoView
