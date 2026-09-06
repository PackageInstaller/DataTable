-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupCostDiamondView.lua

module("logic.extensions.tips.view.PopupCostDiamondView", package.seeall)

local PopupCostDiamondView = class("PopupCostDiamondView", ViewComponent)

function PopupCostDiamondView:ctor()
	PopupCostDiamondView.super.ctor(self)

	self._costDiamond = 0
	self._myDiamond = 0
end

function PopupCostDiamondView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickBtnBuy, self)
end

function PopupCostDiamondView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function PopupCostDiamondView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._btnSure = self:getBtn("main/btnSure")
	self._txtCostDiamond = self:getGo("main/imgCostDiamond/txtNum"):GetComponent(goutil.Type_UIText)
	self._txtMyDiamond = self:getGo("main/imgMyDiamond/txtNum"):GetComponent(goutil.Type_UIText)
	self._txtContent = self:getGo("main/content"):GetComponent(goutil.Type_UIText)
	self._toggle = goutil.findChild(self.mainGO, "main/Toggle"):GetComponent("Toggle")
	self._toggleTxt = goutil.findChild(self.mainGO, "main/Toggle/Label"):GetComponent("Text")
	self._toggleFunc = nil
end

function PopupCostDiamondView:destroyUI()
	PopupCostDiamondView.super.destroyUI(self)
end

function PopupCostDiamondView:onEnter()
	PopupCostDiamondView.super.onEnter(self)

	self._myDiamond = RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()

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

function PopupCostDiamondView:onExit()
	PopupCostDiamondView.super.onExit(self)

	self._sureFunc = nil

	if self._toggle.isOn and self._toggleFunc then
		GameUtil.callBack(self._toggleFunc)

		self._toggleFunc = nil
	end
end

function PopupCostDiamondView:_onClickClose()
	self:close()
end

function PopupCostDiamondView:_onClickBtnBuy()
	printInfo("购买钻石")

	if not MaterialFacade.instance:checkMatEnough(MatType.Diamond, 1, self._costDiamond) then
		self:_onClickClose()

		return
	end

	if self._sureFunc then
		self._sureFunc()
	end

	self:_onClickClose()
end

return PopupCostDiamondView
