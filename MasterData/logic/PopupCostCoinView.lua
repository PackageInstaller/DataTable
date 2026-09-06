-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupCostCoinView.lua

module("logic.extensions.tips.view.PopupCostCoinView", package.seeall)

local PopupCostCoinView = class("PopupCostCoinView", ViewComponent)

function PopupCostCoinView:ctor()
	PopupCostCoinView.super.ctor(self)

	self._costDiamond = 0
	self._myDiamond = 0
end

function PopupCostCoinView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickBtnBuy, self)
end

function PopupCostCoinView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function PopupCostCoinView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._btnSure = self:getBtn("main/btnSure")
	self._txtCostDiamond = self:getGo("main/imgCostDiamond/txtNum"):GetComponent(goutil.Type_UIText)
	self._txtMyDiamond = self:getGo("main/imgMyDiamond/txtNum"):GetComponent(goutil.Type_UIText)
	self._txtContent = self:getGo("main/content"):GetComponent(goutil.Type_UIText)
	self._toggle = goutil.findChild(self.mainGO, "main/Toggle"):GetComponent("Toggle")
	self._toggleTxt = goutil.findChild(self.mainGO, "main/Toggle/Label"):GetComponent("Text")
	self._toggleFunc = nil
end

function PopupCostCoinView:destroyUI()
	PopupCostCoinView.super.destroyUI(self)
end

function PopupCostCoinView:onEnter()
	PopupCostCoinView.super.onEnter(self)

	self._myDiamond = RoleModel.instance:getCoin()

	local param = self._viewPresentor:getFirstParam()

	self._costDiamond = param.costNum
	self._txtCostDiamond.text = self._costDiamond
	self._txtMyDiamond.text = self._myDiamond
	self._txtContent.text = param.content
	self._sureFunc = param.sureFunc
	self._toggleFunc = param.togFunc
	self._toggle.isOn = false

	if param.togFunc then
		self._toggle.gameObject:SetActive(true)
	else
		self._toggle.gameObject:SetActive(false)
	end

	if param.togTxt then
		self._toggleTxt.text = param.togTxt
	end
end

function PopupCostCoinView:onExit()
	PopupCostCoinView.super.onExit(self)

	self._sureFunc = nil

	if self._toggle.isOn and self._toggleFunc then
		GameUtil.callBack(self._toggleFunc)

		self._toggleFunc = nil
	end
end

function PopupCostCoinView:_onClickClose()
	self:close()
end

function PopupCostCoinView:_onClickBtnBuy()
	if not MaterialFacade.instance:checkMatEnough(MatType.Coin, 1, self._costDiamond) then
		self:_onClickClose()

		return
	end

	if self._sureFunc then
		self._sureFunc()
	end

	self:_onClickClose()
end

return PopupCostCoinView
