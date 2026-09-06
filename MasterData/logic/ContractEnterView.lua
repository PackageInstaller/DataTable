-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/contract/view/ContractEnterView.lua

module("logic.extensions.contract.view.ContractEnterView", package.seeall)

local ContractEnterView = class("ContractEnterView", ViewComponent)

function ContractEnterView:buildUI()
	ContractEnterView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._btnInfo = self:getBtn("btnInfo")
	self._btnContract = self:getBtn("btnContract")
	self._bg = self:getGo("bg")
end

function ContractEnterView:bindEvents()
	ContractEnterView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnContract:AddClickListener(self._onClickContract, self)
end

function ContractEnterView:unbindEvents()
	ContractEnterView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnContract:RemoveClickListener()
end

function ContractEnterView:onEnter()
	ContractEnterView.super.onEnter(self)
	self:_loadEffect()
end

function ContractEnterView:onExit()
	ContractEnterView.super.onExit(self)
	self:_removeEffect()
end

function ContractEnterView:_onClickClose()
	self:close()
end

function ContractEnterView:_onClickSure()
	UIStateManager.instance:push(ViewName.ContractSummonerView)
end

function ContractEnterView:_onClickInfo()
	UIStateManager.instance:push(ViewName.ContractBookView)
end

function ContractEnterView:_onClickContract()
	SurveyController.instance:reportBehavior(200640)
	UIStateManager.instance:push(ViewName.ContractNewestPetView)
end

function ContractEnterView:_loadEffect()
	self._uiEffect = UIEffectManager.instance:playEffect(self, ContractEnterViewPresentor.EffectPath, self._bg.transform, 0, 0, true, false)

	self._uiEffect:setParent(self._bg.transform)
	self._uiEffect:setScale(1)
end

function ContractEnterView:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

return ContractEnterView
