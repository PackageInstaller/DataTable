-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopMibaoBuyBatchPart.lua

module("logic.extensions.payshop.view.PayshopMibaoBuyBatchPart", package.seeall)

local PayshopMibaoBuyBatchPart = class("PayshopMibaoBuyBatchPart", BaseLuaOnce)

function PayshopMibaoBuyBatchPart:buildUI()
	self._m10Btn = self:getBtn("Marks/BtnM10")
	self._minusBtn = self:getBtn("Marks/BtnMs")
	self._addBtn = self:getBtn("Marks/BtnAdd")
	self._a10Btn = self:getBtn("Marks/BtnA10")
	self._procNumText = self:getInput("IptItem")
end

function PayshopMibaoBuyBatchPart:bindEvents()
	self._m10Btn:AddClickListener(self._onClickM10, self)
	self._minusBtn:AddClickListener(self._onClickMinus, self)
	self._addBtn:AddClickListener(self._onClickAdd, self)
	self._a10Btn:AddClickListener(self._onClickA10, self)
	self._procNumText:AddOnValueChanged(self._onValueChanged, self)
end

function PayshopMibaoBuyBatchPart:unbindEvents()
	self._m10Btn:RemoveClickListener()
	self._minusBtn:RemoveClickListener()
	self._addBtn:RemoveClickListener()
	self._a10Btn:RemoveClickListener()
	self._procNumText:RemoveOnValueChanged()
end

function PayshopMibaoBuyBatchPart:onEnter(goodsDefineId, defaultNum)
	self._goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(goodsDefineId)
	self._sellMaxNum = 99

	if self._goodsCfg.payType == GameEnum.PayShopPayType.RMB then
		self._sellMaxNum = 0
	elseif self._goodsCfg.limitTimes > 0 then
		local buyTime = PayShopModel.instance:getMibaoBuyTimesById(goodsDefineId)

		self._sellMaxNum = math.max(0, self._goodsCfg.limitTimes - buyTime)
	end

	local isShow = self._sellMaxNum > 0

	if isShow then
		self._procNumText:SetText(tostring(defaultNum or 1))
	end

	goutil.setActive(self.mainGO, isShow)
end

function PayshopMibaoBuyBatchPart:onExit()
	self:RemoveListener()
end

function PayshopMibaoBuyBatchPart:_onClickM10()
	self:_changeNumText(-10)
end

function PayshopMibaoBuyBatchPart:_onClickMinus()
	self:_changeNumText(-1)
end

function PayshopMibaoBuyBatchPart:_onClickAdd()
	self:_changeNumText(1)
end

function PayshopMibaoBuyBatchPart:_onClickA10()
	self:_changeNumText(10)
end

function PayshopMibaoBuyBatchPart:_changeNumText(delta)
	local num = checknumber(self._procNumText:GetText()) + delta

	num = Mathf.Clamp(num, 1, self._sellMaxNum)

	self._procNumText:SetText(tostring(num))
	self:_invoke(num)
end

function PayshopMibaoBuyBatchPart:_onValueChanged(strNum)
	local num = checknumber(strNum)

	num = Mathf.Clamp(num, 1, self._sellMaxNum)

	self._procNumText:SetText(tostring(num))
	self:_invoke(num)
end

function PayshopMibaoBuyBatchPart:AddListener(handle, handleObj)
	self._handle = handle
	self._handleObj = handleObj
end

function PayshopMibaoBuyBatchPart:RemoveListener()
	self._handleObj = nil
	self._handle = nil
end

function PayshopMibaoBuyBatchPart:_invoke(num)
	if not self._handle then
		printInfo("没绑定哦")

		return
	end

	if self._handleObj then
		self._handle(self._handleObj, num)
	else
		self._handle(num)
	end
end

function PayshopMibaoBuyBatchPart:isShowPart()
	return self._sellMaxNum > 0 and self._goodsCfg.deducePlanId <= 0
end

function PayshopMibaoBuyBatchPart:setNum(num)
	self._procNumText:SetText(tostring(num))
end

return PayshopMibaoBuyBatchPart
