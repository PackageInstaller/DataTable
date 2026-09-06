-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exchange/view/ExchangeView.lua

module("logic.extensions.exchange.view.ExchangeView", package.seeall)

local ExchangeView = class("ExchangeView", ViewComponent)

function ExchangeView:ctor()
	ExchangeView.super.ctor(self)
end

function ExchangeView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
end

function ExchangeView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnHome:RemoveClickListener()
end

function ExchangeView:buildUI()
	self._closeButton = self:getBtn("Close")
	self._btnHome = self:getBtn("btn_home")
	self._tabBtns = {}
	self.leftBtns = self:getGo("LeftBtns")

	local btn = self:getGo("LeftBtns/Btn")

	GameUtil.SetActive(btn, false)

	local cfg = ExchangeConfig.instance:getAllTab()

	for i, v in ipairs(cfg) do
		local funcId = v.funcId

		btn = self:copyTabCell(btn, v.id)

		printInfo("legend 初始化名字", v.name, #cfg)
		self:initBtn(btn, v.name, v.id)

		if funcId == 0 or FuncOpenModel.instance:getFuncIsOpen(funcId) then
			GameUtil.SetActive(btn, true)
		else
			GameUtil.SetActive(btn, false)
		end
	end

	self.container = self:getGo("Container")
end

function ExchangeView:copyTabCell(cell, idx)
	local cp = goutil.clone(cell, "Btn" .. idx)

	GameUtil.SetActive(cp, true)
	goutil.addChildToParent(cp, self.leftBtns)

	return cp
end

function ExchangeView:initBtn(cell, name, type)
	local txt1 = goutil.findChildTextComponent(cell, "Txt")

	txt1.text = lang(name)

	self:addTabCtrl(cell, type)
end

function ExchangeView:addTabCtrl(cell, idx)
	self._tabBtns[idx] = cell

	self:setTabSelect(cell, false)

	local btnAdt = Framework.ButtonAdapter.Get(cell.gameObject)

	btnAdt:AddClickListener(function()
		self:_changeTab(idx)
	end)
end

function ExchangeView:setTabSelect(cell, select)
	local group = cell.gameObject:GetComponent("UIChangeGroup")

	if select == true then
		group:SetState(0)
	else
		group:SetState(1)
	end
end

function ExchangeView:destroyUI()
	return
end

function ExchangeView:onEnter()
	local firstIdx = -1
	local cfg = ExchangeConfig.instance:getAllTab()

	for i, v in ipairs(cfg) do
		local btn = self._tabBtns[v.id]
		local funcId = v.funcId

		if funcId == 0 or FuncOpenModel.instance:getFuncIsOpen(funcId) then
			local isOpen = true

			if funcId == GameEnum.FuncType.Family then
				isOpen = FamilyController.instance:getFamilyLv() > 0
			end

			if firstIdx == -1 and isOpen then
				firstIdx = i
			end

			GameUtil.SetActive(btn, isOpen)
		else
			GameUtil.SetActive(btn, false)
		end
	end

	if firstIdx == -1 then
		firstIdx = 1
	end

	local idx = self._viewPresentor:getFirstParam() or firstIdx

	self:_changeTab(idx)
end

function ExchangeView:onEnterFinished()
	return
end

function ExchangeView:onExit()
	local obj

	if self._tabIndex then
		local cell = self._tabBtns[self._tabIndex]

		self:setTabSelect(cell, false)
	end

	self._tabIndex = nil
end

function ExchangeView:onExitFinished()
	return
end

function ExchangeView:_changeTab(tabIndex)
	tabIndex = checknumber(tabIndex)

	local viewName = ViewName.BaseExchangeStack

	if self._tabIndex then
		if self._tabIndex ~= tabIndex then
			self:showTabAt(self.container)
		end

		local cell = self._tabBtns[self._tabIndex]

		self:setTabSelect(cell, false)
	end

	self._tabIndex = tabIndex

	printInfo("self._tabIndex:" .. self._tabIndex)

	local obj = ExchangeConfig.instance:getTabById(self._tabIndex)

	self:showTabAt(self.container, viewName, obj.id)

	local cell = self._tabBtns[self._tabIndex]

	self:setTabSelect(cell, true)
end

function ExchangeView:_onClickClose()
	UIStateManager.instance:popByName(self._viewPresentor.viewName)
end

function ExchangeView:_onClickHome()
	UIStateManager.instance:clear(true)
end

return ExchangeView
