-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playeinfo/view/PlayerInfoOnlyReportView.lua

module("logic.extensions.playeinfo.view.PlayerInfoOnlyReportView", package.seeall)

local PlayerInfoOnlyReportView = class("PlayerInfoOnlyReportView", ViewComponent)

function PlayerInfoOnlyReportView:ctor()
	PlayerInfoOnlyReportView.super.ctor(self)
end

function PlayerInfoOnlyReportView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._Btn_Private:AddClickListener(self._onClickPrivate, self)
	self._Btn_Info:AddClickListener(self._onClickInfo, self)
	self._Btn_AddFriend:AddClickListener(self._onClickAddFriend, self)
	self._Btn_DeleteFriend:AddClickListener(self._onClickDeleteFriend, self)
	self._Btn_AddBlacklist:AddClickListener(self._onClickAddBlacklist, self)
	self._Btn_RemoveBlacklist:AddClickListener(self._onClickRemoveBlacklist, self)
	self._Btn_Report:AddClickListener(self._onClickReport, self)
	self._Btn_Pk:AddClickListener(self._onClickPk, self)

	if self._Btn_Zoo then
		self._Btn_Zoo:AddClickListener(self._onClickZoo, self)
	end

	if self._Btn_Sendflower then
		self._Btn_Sendflower:AddClickListener(self._onClickSendFlower, self)
	end
end

function PlayerInfoOnlyReportView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._Btn_Private:RemoveClickListener()
	self._Btn_Info:RemoveClickListener()
	self._Btn_AddFriend:RemoveClickListener()
	self._Btn_DeleteFriend:RemoveClickListener()
	self._Btn_AddBlacklist:RemoveClickListener()
	self._Btn_RemoveBlacklist:RemoveClickListener()
	self._Btn_Report:RemoveClickListener()
	self._Btn_Pk:RemoveClickListener()

	if self._Btn_Zoo then
		self._Btn_Zoo:RemoveClickListener()
	end

	if self._Btn_Sendflower then
		self._Btn_Sendflower:RemoveClickListener()
	end
end

function PlayerInfoOnlyReportView:buildUI()
	local Nego_Bottom = self:getGo("Nego_Content/Nego_Bottom")
	local Nego_Info = self:getGo("Nego_Content/Nego_Top/Nego_Info")

	self._closeButton = self:getBtn("Close")
	self._Btn_Private = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Private")
	self._Btn_Info = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Info")
	self._Btn_AddFriend = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_AddFriend")
	self._Btn_DeleteFriend = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_DeleteFriend")
	self._Btn_AddBlacklist = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_AddBlacklist")
	self._Btn_RemoveBlacklist = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_RemoveBlacklist")
	self._Btn_Report = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Report")
	self._Btn_Pk = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Pk")
	self._Btn_Zoo = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Zoo")
	self._Btn_Sendflower = Framework.ButtonAdapter.GetFrom(Nego_Bottom, "Btn_Sendflower")
	self._TxtC_Name = goutil.findChildComponent(Nego_Info, "TxtC_Name", "Text")
	self._TxtC_Zdl = goutil.findChildComponent(Nego_Info, "ImgZdl/TxtZdl", "Text")
	self._TxtC_League = goutil.findChildComponent(Nego_Info, "TxtC_League", "Text")
	self._imageChange = self:getGo("Nego_Content/Nego_Top/Nego_Icon/ImgC_Icon")
	self._adjustPosition = goutil.findChildComponent(self.mainGO, "Nego_Content", "UIAdjustPosition")
	self.Nego_Content = self:getGo("Nego_Content")
end

function PlayerInfoOnlyReportView:destroyUI()
	return
end

function PlayerInfoOnlyReportView:onEnter()
	local params = self:getOpenParam()

	self._mo = params[1]

	self:_refresh()
	self._Btn_Private.gameObject:SetActive(false)
	self._Btn_AddFriend.gameObject:SetActive(false)
	self._Btn_DeleteFriend.gameObject:SetActive(false)
	self._Btn_Sendflower.gameObject:SetActive(false)
	self._Btn_Pk.gameObject:SetActive(false)
	GameUtil.SetActive(self._Btn_AddBlacklist, false)
	GameUtil.SetActive(self._Btn_RemoveBlacklist, false)
	GameUtil.setHeight(self.Nego_Content, 260)
end

function PlayerInfoOnlyReportView:onEnterFinished()
	return
end

function PlayerInfoOnlyReportView:onExit()
	HeadItemController.instance:resetHeadCell(self._imageChange)
end

function PlayerInfoOnlyReportView:onExitFinished()
	return
end

function PlayerInfoOnlyReportView:_refresh()
	self._TxtC_Name.text = self._mo._senderName
	self._TxtC_Zdl.text = lang("未知")

	HeadItemController.instance:setHeadCell(self._imageChange, self._mo.headIconId, self._mo.headFrameId, self._mo.vipLv)
	self:_setBtnStates()
end

function PlayerInfoOnlyReportView:_setBtnStates()
	self._Btn_Private.gameObject:SetActive(false)
	self._Btn_Info.gameObject:SetActive(false)
	self._Btn_Info.gameObject:SetActive(false)
	self._Btn_AddFriend.gameObject:SetActive(false)
	GameUtil.SetActive(self._Btn_Zoo, false)
	self._Btn_DeleteFriend.gameObject:SetActive(false)
	self._Btn_AddBlacklist.gameObject:SetActive(false)
	self._Btn_RemoveBlacklist.gameObject:SetActive(false)
end

function PlayerInfoOnlyReportView:_onClickPrivate()
	return
end

function PlayerInfoOnlyReportView:_checkIsInBattle()
	return
end

function PlayerInfoOnlyReportView:_onClickInfo()
	return
end

function PlayerInfoOnlyReportView:_onClickAddFriend()
	self:close()
end

function PlayerInfoOnlyReportView:_onClickDeleteFriend()
	self:close()
end

function PlayerInfoOnlyReportView:_onClickAddBlacklist()
	return
end

function PlayerInfoOnlyReportView:_onClickRemoveBlacklist()
	self:close()
end

function PlayerInfoOnlyReportView:_onClickReport()
	self:close()
	UIStateManager.instance:push(ViewName.ReportView, self._mo._senderName, self._mo._senderId, self._mo:getContent())
end

function PlayerInfoOnlyReportView:_onClickClose()
	self:close()
end

function PlayerInfoOnlyReportView:_onClickPk()
	self:close()
end

function PlayerInfoOnlyReportView:_onClickZoo()
	self:close()
end

function PlayerInfoOnlyReportView:_onClickSendFlower()
	self:close()
end

return PlayerInfoOnlyReportView
