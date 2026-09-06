-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/DragonBuyView.lua

module("logic.extensions.lottery.view.DragonBuyView", package.seeall)

local DragonBuyView = class("DragonBuyView", ViewComponent)

function DragonBuyView:ctor()
	DragonBuyView.super.ctor(self)
end

function DragonBuyView:buildUI()
	DragonBuyView.super.buildUI(self)

	self._closeBtn = self:getBtn("BG/Close")
	self._nameTxt = goutil.findChildTextComponent(self.mainGO, "BG/txt_Title")
	self._m10Btn = self:getBtn("Tip/Marks/BtnM10")
	self._minusBtn = self:getBtn("Tip/Marks/BtnMs")
	self._addBtn = self:getBtn("Tip/Marks/BtnAdd")
	self._a10Btn = self:getBtn("Tip/Marks/BtnA10")
	self._procNumText = self:getInput("Tip/IptItem")
	self._agreeBtn = self:getBtn("Tip/BtnAgree")
	self._cancelBtn = self:getBtn("Tip/BtnCancel")
	self._buyText = goutil.findChildTextComponent(self.mainGO, "Tip/TxtBuy")
	self._supText = goutil.findChildTextComponent(self.mainGO, "Tip/supCountTxt")
	self._supImaGo = self:getGo("Tip/supCountTxt/supCountIma")
	self._nameTxt.text = ""
	self._buyText.text = ""
	self._supText.text = ""
	self._costCount = self:getTxt("imgCostDiamond/txtNum")
	self._imgIcon1 = self:getGo("imgCostDiamond/img")
	self._curCount = self:getTxt("imgMyDiamond/txtNum")
	self._imgIcon2 = self:getGo("imgMyDiamond/img")
end

function DragonBuyView:bindEvents()
	DragonBuyView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._m10Btn:AddClickListener(function()
		self:_changeNumText(-10)
	end)
	self._minusBtn:AddClickListener(function()
		self:_changeNumText(-1)
	end)
	self._addBtn:AddClickListener(function()
		self:_changeNumText(1)
	end)
	self._a10Btn:AddClickListener(function()
		self:_changeNumText(10)
	end)
	self._procNumText:AddOnValueChanged(self._onValueChanged, self)
	self._agreeBtn:AddClickListener(self._onClickAgree, self)
	self._cancelBtn:AddClickListener(self.close, self)
end

function DragonBuyView:unbindEvents()
	DragonBuyView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._m10Btn:RemoveClickListener()
	self._minusBtn:RemoveClickListener()
	self._addBtn:RemoveClickListener()
	self._a10Btn:RemoveClickListener()
	self._procNumText:RemoveOnValueChanged()
	self._agreeBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
end

function DragonBuyView:destroyUI()
	DragonBuyView.super.destroyUI(self)
	uGuiUtil.clearImage(self._supImaGo)
end

function DragonBuyView:onEnter()
	DragonBuyView.super.onEnter(self)

	self._params = self:getFirstParam()

	if self._params == nil or self._params.poolCfg == nil then
		printError("sr---超神龙召唤   DragonBuyView:onEnter()      未传参数！！！")

		return
	end

	GameUtil.SetActive(self._supText, true)

	self._nameTxt.text = lang("text_dragon_desc_1")
	self._haveCount = MaterialMgr.getMatCount(self._params.poolCfg.lotteryCost)
	self._supText.text = self._haveCount
	self._curCount.text = self._haveCount
	self._setNumber = self._haveCount >= 10 and 10 or self._haveCount

	MaterialMgr.updateItemByStr(self._supImaGo, self._params.poolCfg.lotteryCost)
	MaterialMgr.updateItemByStr(self._imgIcon1, self._params.poolCfg.lotteryCost)
	MaterialMgr.updateItemByStr(self._imgIcon2, self._params.poolCfg.lotteryCost)
	self:_setChargeNum()
end

function DragonBuyView:_setChargeNum()
	if self._procNumText:GetText() ~= tostring(self._setNumber) then
		self._procNumText:SetText(tostring(self._setNumber))
	end

	if not string.nilorempty(self._params.poolCfg.lottertyTips) then
		local name = MaterialMgr.getMaterialsNameByCfg(self._params.poolCfg.lotteryCost)
		local type, id, num = MaterialMgr.getMatParams(self._params.poolCfg.lotteryCost)

		self.requireNum = num * checknumber(self._setNumber)
		self._buyText.text = langPara(self._params.poolCfg.lottertyTips, name, self.requireNum, self._setNumber)
		self._costCount.text = num
	else
		self._buyText.text = lang("text_dragon_desc_2")
		self._costCount.text = ""
	end
end

function DragonBuyView:_changeNumText(delta)
	self._setNumber = self._setNumber + delta
	self._setNumber = Mathf.Clamp(self._setNumber, 1, self._params.poolCfg.onceLimit)

	self:_setChargeNum()
end

function DragonBuyView:_onValueChanged(strNum)
	self._setNumber = checkint(strNum)
	self._setNumber = Mathf.Clamp(self._setNumber, 1, self._params.poolCfg.onceLimit)

	self:_setChargeNum()
end

function DragonBuyView:_onClickAgree()
	self._setNumber = checknumber(self._setNumber)

	if self._setNumber <= 0 then
		FloatWordMgr.instance:show(lang("text_dragon_desc_4"))

		return
	end

	if self._setNumber > self._params.poolCfg.onceLimit then
		FloatWordMgr.instance:show(lang("text_dragon_desc_5"))

		return
	end

	if self._setNumber > self._params.poolCfg.dailyLimit - self._params.dailyTime then
		FloatWordMgr.instance:show(lang("text_dragon_desc_6"))

		return
	end

	if self.requireNum > self._haveCount then
		local name = MaterialMgr.getMaterialsNameByCfg(self._params.poolCfg.lotteryCost)

		FloatWordMgr.instance:show(langPara("text_mirror_desc_6", name))

		return
	end

	DragonController.instance:csGodLotteryDoneReq(self._params.actId, self._params.poolCfg.poolGroupId, self._setNumber)
	self:close()
end

return DragonBuyView
