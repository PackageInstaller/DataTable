-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerlottery/view/SummerLotteryBuyView.lua

module("logic.extensions.summerlottery.view.SummerLotteryBuyView", package.seeall)

local SummerLotteryBuyView = class("SummerLotteryBuyView", ViewComponent)

function SummerLotteryBuyView:ctor()
	SummerLotteryBuyView.super.ctor(self)
end

function SummerLotteryBuyView:buildUI()
	SummerLotteryBuyView.super.buildUI(self)

	self._closeBtn = self:getBtn("BG/Close")
	self._nameTxt = goutil.findChildTextComponent(self.mainGO, "BG/txt_Title")
	self._m10Btn = self:getBtn("Tip/Marks/BtnM10")
	self._m10Txt = self:getTxt("Tip/Marks/BtnM10/Txt")
	self._minusBtn = self:getBtn("Tip/Marks/BtnMs")
	self._addBtn = self:getBtn("Tip/Marks/BtnAdd")
	self._a10Btn = self:getBtn("Tip/Marks/BtnA10")
	self._a10Txt = self:getTxt("Tip/Marks/BtnA10/Txt")
	self._procNumText = self:getInput("Tip/IptItem")
	self._agreeBtn = self:getBtn("Tip/BtnAgree")
	self._cancelBtn = self:getBtn("Tip/BtnCancel")
	self._buyText = goutil.findChildTextComponent(self.mainGO, "Tip/TxtBuy")
	self._supText = goutil.findChildTextComponent(self.mainGO, "Tip/supCountTxt")
	self._supImaGo = self:getGo("Tip/supCountTxt/supCountIma")
	self._nameTxt.text = ""
	self._buyText.text = ""
	self._supText.text = ""
end

function SummerLotteryBuyView:bindEvents()
	SummerLotteryBuyView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._m10Btn:AddClickListener(function()
		local onceLimit = self:_getParam("onceLimit", 10)

		onceLimit = math.min(onceLimit, 10)

		self:_changeNumText(-onceLimit)
	end)
	self._minusBtn:AddClickListener(function()
		self:_changeNumText(-1)
	end)
	self._addBtn:AddClickListener(function()
		self:_changeNumText(1)
	end)
	self._a10Btn:AddClickListener(function()
		local onceLimit = self:_getParam("onceLimit", 10)

		onceLimit = math.min(onceLimit, 10)

		self:_changeNumText(onceLimit)
	end)
	self._procNumText:AddOnValueChanged(self._onValueChanged, self)
	self._agreeBtn:AddClickListener(self._onClickAgree, self)
	self._cancelBtn:AddClickListener(self.close, self)
end

function SummerLotteryBuyView:unbindEvents()
	SummerLotteryBuyView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._m10Btn:RemoveClickListener()
	self._minusBtn:RemoveClickListener()
	self._addBtn:RemoveClickListener()
	self._a10Btn:RemoveClickListener()
	self._procNumText:RemoveOnValueChanged()
	self._agreeBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
end

function SummerLotteryBuyView:destroyUI()
	SummerLotteryBuyView.super.destroyUI(self)
	uGuiUtil.clearImage(self._supImaGo)
end

function SummerLotteryBuyView:_getParam(key, defaultValue)
	if self._params[key] ~= nil then
		return self._params[key]
	end

	return defaultValue
end

function SummerLotteryBuyView:onEnter()
	SummerLotteryBuyView.super.onEnter(self)

	self._params = self:getFirstParam() or {}

	GameUtil.SetActive(self._supText, true)

	self._lotteryCost = self:_getParam("lotteryCost")
	self._nameTxt.text = self:_getParam("title", "")

	local onceLimit = self:_getParam("onceLimit", 10)

	onceLimit = math.min(onceLimit, 10)
	self._haveCount = MaterialMgr.getMatCount(self._lotteryCost)
	self._setNumber = Mathf.Clamp(self._haveCount, 1, onceLimit)
	self._supText.text = self._haveCount

	MaterialMgr.updateItemByStr(self._supImaGo, self._lotteryCost)

	self._m10Txt.text = string.format("-%d", onceLimit)
	self._a10Txt.text = string.format("+%d", onceLimit)

	self:_setChargeNum()
end

function SummerLotteryBuyView:_setChargeNum()
	self._procNumText:SetText(tostring(self._setNumber))

	local lotteryTips = self:_getParam("questions", lang("text_dragon_desc_2"))
	local name = MaterialMgr.getMaterialsNameByCfg(self._lotteryCost)
	local type, id, num = MaterialMgr.getMatParams(self._lotteryCost)

	self.requireNum = num * checknumber(self._setNumber)
	self._buyText.text = langPara(lotteryTips, name, self.requireNum, self._setNumber)
end

function SummerLotteryBuyView:_changeNumText(delta)
	self._setNumber = self._setNumber + delta

	local onceLimit = self:_getParam("onceLimit", 0)

	self._setNumber = onceLimit > 0 and Mathf.Clamp(self._setNumber, 1, onceLimit) or math.max(self._setNumber, 1)

	self:_setChargeNum()
end

function SummerLotteryBuyView:_onValueChanged(strNum)
	self._setNumber = checkint(strNum)

	local onceLimit = self:_getParam("onceLimit", 0)

	self._setNumber = onceLimit > 0 and Mathf.Clamp(self._setNumber, 1, onceLimit) or math.max(self._setNumber, 1)

	self:_setChargeNum()
end

function SummerLotteryBuyView:_onClickAgree()
	self._setNumber = checknumber(self._setNumber)

	if self._setNumber <= 0 then
		FloatWordMgr.instance:show(lang("text_dragon_desc_4"))

		return
	end

	local onceLimit = self:_getParam("onceLimit", 0)

	if onceLimit > 0 and onceLimit < self._setNumber then
		FloatWordMgr.instance:show(lang("text_dragon_desc_5"))

		return
	end

	local dailyLimit = self:_getParam("dailyLimit", 0)
	local dailyTime = self:_getParam("dailyTime", 0)

	if dailyLimit > 0 and self._setNumber > dailyLimit - dailyTime then
		FloatWordMgr.instance:show(lang("text_dragon_desc_6"))

		return
	end

	if self.requireNum > self._haveCount then
		local name = MaterialMgr.getMaterialsNameByCfg(self._lotteryCost)
		local notEnoughItemTips = self:_getParam("notEnoughItemTips", "text_mirror_desc_6")

		FloatWordMgr.instance:show(langPara(notEnoughItemTips, name))

		return
	end

	local onConfirmFunc = self:_getParam("onConfirmFunc")
	local thisArg = self:_getParam("thisArg")

	if onConfirmFunc then
		if thisArg then
			onConfirmFunc(thisArg, self._setNumber)
		else
			onConfirmFunc(self._setNumber)
		end
	end

	self:close()
end

return SummerLotteryBuyView
