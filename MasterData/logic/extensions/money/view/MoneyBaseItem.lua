-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/money/view/MoneyBaseItem.lua

module("logic.extensions.money.view.MoneyBaseItem", package.seeall)

local M = class("MoneyBaseItem")

function M:ctor(go, moneyCode)
	self._needHint = false
	self._moneyCode = moneyCode
	self._viewElementsRegistry = ViewElementsRegistry.New(go)
	self._imgBg = self._viewElementsRegistry:findUIElement("currency_item_-752394813", UIComponentType.Image)
	self._moneyIconNode = self._viewElementsRegistry:findUIElement("currency_item_-1010472309", UIComponentType.Image)
	self._btnAdd = self._viewElementsRegistry:findUIElement("currency_item_-539574509", UIComponentType.ButtonAdapter)
	self._btnJump = self._viewElementsRegistry:findUIElement("currency_item_254642640", UIComponentType.ButtonAdapter)
	self._txtValue = self._viewElementsRegistry:findUIElement("currency_item_716111503", UIComponentType.Text)
	self._goHint = self._viewElementsRegistry:findUIElement("currency_item_1427221688")
	self._txtHint = self._viewElementsRegistry:findUIElement("currency_item_1102714500", UIComponentType.Text)
	self._canvasGroup = goutil.addComponentOnce(go, ComponentType.CanvasGroup)
end

function M:bindEvents()
	self._btnAdd:AddClickListener(self._onClickAddBtn, self)
	self._btnJump:AddClickListener(self._onClickJumpBtn, self)
	GlobalDispatcher:addEventListener(EventType.MONEY_UPDATE_EVENT, self._updateMoney, self)
end

function M:unbindEvents()
	self._btnAdd:RemoveClickListener()
	self._btnJump:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.MONEY_UPDATE_EVENT, self._updateMoney, self)
end

function M:onEnter()
	self:bindEvents()
	goutil.setActive(self._viewElementsRegistry:getMainGO(), true)
end

function M:onExit()
	self:unbindEvents()
	goutil.setActive(self._viewElementsRegistry:getMainGO(), false)
end

function M:getMainGo()
	return self._viewElementsRegistry:getMainGO()
end

function M:getMoneyCode()
	return self._moneyCode
end

function M:setMoneyShowType(moneyShowType)
	self._moneyShowType = moneyShowType
end

function M:getMoneyShowType()
	return self._moneyShowType
end

function M:setNeedHint(need)
	self._needHint = need

	self:setTxtHintVisible(need)
end

function M:getNeedHint()
	return self._needHint
end

function M:setMoneyIconPath(path)
	if not path then
		MoneyUtil.setMoneyIcon(self._moneyIconNode, self._moneyCode)
	else
		IconLoader.setSprite(self._moneyIconNode, IconType.Skinlib, path)
	end
end

function M:_updateMoney(e, moneyCode, moneyValue)
	if self._moneyCode == moneyCode then
		self:updateData()
	end
end

function M:updateData()
	local numStr = MoneyModel.instance:getMoneyUpdateParams(self:getMoneyCode())

	self:updateTxtValue(numStr)
end

function M:updateTxtValue(str)
	self._txtValue.text = str

	local width = math.max(self._txtValue.preferredWidth, 52) + 55

	RectTransformUtils.SetWidth(self._btnJump.gameObject.transform, width)
end

function M:updateTxtHint(str)
	self._txtHint.text = str

	self:setTxtHintVisible(not string.nilorempty(str))
end

function M:changeBgColor(colorStr)
	self._imgBg.color = parsecolor(colorStr)
end

function M:_onClickAddBtn()
	printWarn(string.format("[%s] 子类需要复写_onClickAddBtn", self:getMoneyCode()))
end

function M:_onClickJumpBtn()
	printWarn(string.format("[%s] 子类需要复写_onClickJumpBtn", self:getMoneyCode()))
end

function M:setAddBtnVisible(visible)
	self._btnAdd.gameObject:SetActive(visible)
end

function M:setJumpBtnVisible(visible)
	self._btnJump.gameObject:SetActive(visible)
end

function M:setJumpBtnPassEvent(passEvent)
	self._jumpBtnPassEvent = passEvent
end

function M:getJumpBtnPassEvent()
	return self._jumpBtnPassEvent
end

function M:setTxtHintVisible(visible)
	goutil.setActive(self._txtHint.gameObject, visible)
	goutil.setActive(self._goHint, visible)
end

function M:setEnable(enable)
	self._canvasGroup.alpha = enable and 1 or 0

	local mainGO = self._viewElementsRegistry:getMainGO()
	local imageComp = goutil.findChildImageComponent(mainGO, "imgBg")

	imageComp.raycastTarget = enable
end

function M:printStatus()
	local showType = self:getMoneyShowType()
	local showTypeInfo = MoneyUtil.getMoneyInfoByShowType(showType)
	local _define

	for k, v in ipairs(showTypeInfo.moneyCodes) do
		if v.code == self:getMoneyCode() then
			_define = v
		end
	end

	printWarn(string.format("[%s] hint[%s] addBtn[%s] hideJumpBtn[%s]", self:getMoneyCode(), self:getNeedHint(), _define.addBtn, _define.hideJumpBtn))
end

return M
