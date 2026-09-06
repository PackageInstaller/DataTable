-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilymanagerView.lua

module("logic.extensions.family.view.FamilymanagerView", package.seeall)

local FamilymanagerView = class("FamilymanagerView", ViewComponent)

FamilymanagerView.TabType = {
	Email = 1,
	Invite = 2
}

function FamilymanagerView:ctor()
	FamilymanagerView.super.ctor(self)
end

function FamilymanagerView:unbindEvents()
	FamilymanagerView.super.unbindEvents(self)

	for k, v in pairs(self._btns) do
		GameUtil.rmClickHandler(v.btn)
	end

	self._btnClose:RemoveClickListener()
end

function FamilymanagerView:bindEvents()
	FamilymanagerView.super.bindEvents(self)

	for k, v in pairs(self._btns) do
		GameUtil.addClickHandler(v.btn, GameUtil.handler(self._onClickTabBtn, self, v.tabType))
	end

	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function FamilymanagerView:buildUI()
	FamilymanagerView.super.buildUI(self)

	self._btns = {}

	for k, tIdx in pairs(FamilymanagerView.TabType) do
		local var_4_0 = {
			btn = self:getGo("tabs/btn" .. tIdx)
		}

		var_4_0.change = self:getGo("tabs/btn" .. tIdx):GetComponent(ComponentType.UIImageSpriteChange)
		var_4_0.tabType = tIdx
		self._btns[tIdx] = var_4_0
	end

	self._btnClose = self:getBtn("btnClose")
	self._containerGo = self:getGo("container")
	self._redpointGo = self:getGo("tabs/btn3/redpoint")
end

function FamilymanagerView:onExit()
	FamilymanagerView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redpointGo)
end

function FamilymanagerView:onEnter()
	FamilymanagerView.super.onEnter(self)
	RedPointController.instance:regRedPoint(self._redpointGo, RedPointModel.ID_FAMILY_MGR_PARTY)
	self:_onClickTabBtn(FamilymanagerView.TabType.Email)
	FamilyAgent.instance:sendGetFamilyManagePanelInfoReq()
end

function FamilymanagerView:_onClickTabBtn(tabType)
	self._tabType = tabType

	local viewName

	if tabType == FamilymanagerView.TabType.Email then
		viewName = ViewName.FamilymgremailView
	elseif tabType == FamilymanagerView.TabType.Invite then
		viewName = ViewName.FamilymgrinviteView
	end

	self:showTabAt(self._containerGo, viewName)
	self:_setBtnState()
end

function FamilymanagerView:_onClickbtnClose()
	self:close()
end

function FamilymanagerView:_setBtnState()
	for tabType, v in pairs(self._btns) do
		v.change:SetState(tabType == self._tabType and 1 or 0)
	end
end

return FamilymanagerView
