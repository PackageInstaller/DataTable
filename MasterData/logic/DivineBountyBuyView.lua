-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinebounty/view/DivineBountyBuyView.lua

module("logic.extensions.divinebounty.view.DivineBountyBuyView", package.seeall)

local DivineBountyBuyView = class("DivineBountyBuyView", ViewComponent)

function DivineBountyBuyView:ctor()
	DivineBountyBuyView.super.ctor(self)
end

function DivineBountyBuyView:unbindEvents()
	DivineBountyBuyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnA10)
	GameUtil.rmClickHandler(self._btnA100)
	GameUtil.rmClickHandler(self._btnMs)
	GameUtil.rmClickHandler(self._btnM10)
	GameUtil.rmClickHandler(self._btnM100)
	self._inputCount:RemoveOnValueChanged()
end

function DivineBountyBuyView:bindEvents()
	DivineBountyBuyView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnAdd, self._onAdd, self)
	GameUtil.addClickHandler(self._btnA10, self._onAddTen, self)
	GameUtil.addClickHandler(self._btnA100, self._onAdd100, self)
	GameUtil.addClickHandler(self._btnMs, self._onReduce, self)
	GameUtil.addClickHandler(self._btnM10, self._onReduceTen, self)
	GameUtil.addClickHandler(self._btnM100, self._onReduce100, self)
	GameUtil.addClickHandler(self._btnBuy, self._handleBuyEvent, self)
end

function DivineBountyBuyView:buildUI()
	DivineBountyBuyView.super.buildUI(self)

	self._btnClose = self:getBtn("closeBtn")
	self._btnBuy = self:getBtn("buyBtn")
	self._txtPrice = goutil.findChildTextComponent(self._btnBuy.gameObject, "text")
	self._txtLimit = self:getGo("limitText"):GetComponent(goutil.Type_UIText)
	self._inputCount = self:getInput("batchBuyRoot/IptItem")

	local marks = goutil.find("batchBuyRoot/Marks")

	self._btnAdd = goutil.findChildButtonComponent(marks, "BtnAdd")
	self._btnA10 = goutil.findChildButtonComponent(marks, "BtnA10")
	self._btnA100 = goutil.findChildButtonComponent(marks, "BtnA100")
	self._btnMs = goutil.findChildButtonComponent(marks, "BtnMs")
	self._btnM10 = goutil.findChildButtonComponent(marks, "BtnM10")
	self._btnM100 = goutil.findChildButtonComponent(marks, "BtnM100")
end

function DivineBountyBuyView:onExit()
	DivineBountyBuyView.super.onExit(self)
	DivineBountyAgent:sendPM_DivineBountyGetShopInfoReq()
end

function DivineBountyBuyView:onEnter()
	DivineBountyBuyView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineBountyBuyShopItemRes, self.close, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._reloadMyCoins, self)
	self._inputCount:AddOnValueChanged(self._onValueChanged, self)

	local params = self:getOpenParam()

	if not params then
		return
	end

	local cfg = params[1]

	self._itemId = cfg.itemId

	local limitTimes = cfg.limitTimes
	local buyTimes = DivineBountyModel.instance:getShopItemBuyTimes(self._itemId) or 0

	self._maxCount = limitTimes - buyTimes

	local txt = params[2]

	if not string.nilorempty(txt) then
		self._txtLimit.text = txt
	end

	goutil.setActive(self._txtLimit.gameObject, not string.nilorempty(txt))
	self:_initView(cfg)
end

function DivineBountyBuyView:_initView(data)
	if not data then
		return
	end

	local icon = self:getGo("item/icon")
	local txtName = self:getGo("item/txtName"):GetComponent(goutil.Type_UIText)
	local iconPay = goutil.findChild(self._txtPrice.gameObject, "payIcon")

	self._matType, self._matId, self._prize = MaterialMgr.getMatParams(data.price)
	self._name = MaterialMgr.getMaterialsNameByCfg(data.content)

	self:_reloadMyCoins()
	MaterialMgr.setIcon(iconPay, self._matType, self._matId)
	MaterialMgr.setCellByCfg(data.content, icon)

	self._lastNum = 1
	txtName.text = self._name
	self._inputCount.input.text = self._lastNum
	self._txtPrice.text = self._prize
end

function DivineBountyBuyView:_onValueChanged(strNum)
	local num = checkint(strNum)

	self:_changeCount(num)
end

function DivineBountyBuyView:_reloadMyCoins()
	self._myCoins = MaterialModel.instance:getMaterialsNumber(self._matType, self._matId)
end

function DivineBountyBuyView:_changeCount(change)
	change = change or 0

	local curCount = Mathf.Clamp(change, 0, self._maxCount)

	if curCount < 1 then
		curCount = 1
	end

	local needCoins = curCount * self._prize

	if needCoins > self._myCoins then
		curCount = math.floor(self._myCoins / self._prize)
	end

	self._lastNum = curCount
	self._inputCount.input.text = tostring(curCount)
	self._txtPrice.text = self._prize * curCount
end

function DivineBountyBuyView:_handleBuyEvent()
	local itemId = self._itemId
	local curCount = tonumber(self._inputCount:GetText())
	local curFare = curCount * self._prize
	local str = string.format("确定花费" .. curFare .. "神曜币，购买" .. curCount .. "个" .. self._name .. "吗？")

	print("itemId = ", itemId, "curCount = ", curCount)

	local function localFunc()
		DivineBountyAgent.instance:sendPM_DivineBountyBuyShopItemReq(itemId, curCount)
	end

	TipsFacade.instance:openPopupCostMatViewNew(self._matType, self._matId, curFare, str, localFunc, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function DivineBountyBuyView:_onReduce()
	local num = checkint(self._lastNum) - 1

	self:_changeCount(num)
end

function DivineBountyBuyView:_onAdd()
	local num = checkint(self._lastNum) + 1

	self:_changeCount(num)
end

function DivineBountyBuyView:_onReduceTen()
	local num = checkint(self._lastNum) - 10

	self:_changeCount(num)
end

function DivineBountyBuyView:_onReduce100()
	local num = checkint(self._lastNum) - 100

	self:_changeCount(num)
end

function DivineBountyBuyView:_onAddTen()
	local num = checkint(self._lastNum) + 10

	self:_changeCount(num)
end

function DivineBountyBuyView:_onAdd100()
	local num = checkint(self._lastNum) + 100

	self:_changeCount(num)
end

return DivineBountyBuyView
