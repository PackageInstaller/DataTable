-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPassBuyLevelPopView.lua

module("logic.extensions.lottery.view.SeasonPassBuyLevelPopView", package.seeall)

local SeasonPassBuyLevelPopView = class("SeasonPassBuyLevelPopView", ViewComponent)

function SeasonPassBuyLevelPopView:ctor()
	SeasonPassBuyLevelPopView.super.ctor(self)
end

function SeasonPassBuyLevelPopView:buildUI()
	SeasonPassBuyLevelPopView.super.buildUI(self)

	self._nameTxt = goutil.findChildTextComponent(self.mainGO, "BG/txt_Title")
	self._btnClose = self:getBtn("BG/Close")
	self._m10Btn = self:getBtn("Tip/Marks/BtnM10")
	self._minusBtn = self:getBtn("Tip/Marks/BtnMs")
	self._addBtn = self:getBtn("Tip/Marks/BtnAdd")
	self._a10Btn = self:getBtn("Tip/Marks/BtnA10")
	self._agreeBtn = self:getBtn("Tip/BtnAgree")
	self._procNumText = self:getInput("Tip/IptItem")
	self._buyText = goutil.findChildTextComponent(self.mainGO, "Tip/TxtBuy")
	self._txtDes = goutil.findChildTextComponent(self.mainGO, "Tip/txtDes")
	self._goSupCountTxt = self:getGo("Tip/supCountTxt")
	self._iconCost = goutil.findChild(self.mainGO, "Tip/txtCost/icon")
	self._iconHave = goutil.findChild(self.mainGO, "Tip/txtHave/icon")
	self._txtCost = goutil.findChildTextComponent(self.mainGO, "Tip/txtCost/txtNum")
	self._txtHave = goutil.findChildTextComponent(self.mainGO, "Tip/txtHave/txtNum")

	goutil.setActive(self._goSupCountTxt, false)

	self._nameTxt.text = "购买等级"
	self._buyText.text = ""
end

function SeasonPassBuyLevelPopView:bindEvents()
	SeasonPassBuyLevelPopView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
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
end

function SeasonPassBuyLevelPopView:unbindEvents()
	SeasonPassBuyLevelPopView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._m10Btn:RemoveClickListener()
	self._minusBtn:RemoveClickListener()
	self._addBtn:RemoveClickListener()
	self._a10Btn:RemoveClickListener()
	self._procNumText:RemoveOnValueChanged()
	self._agreeBtn:RemoveClickListener()
end

function SeasonPassBuyLevelPopView:destroyUI()
	SeasonPassBuyLevelPopView.super.destroyUI(self)
end

function SeasonPassBuyLevelPopView:onExit()
	SeasonPassBuyLevelPopView.super.onExit(self)
	MaterialMgr.clearIcon(self._iconCost)
	MaterialMgr.clearIcon(self._iconHave)
end

function SeasonPassBuyLevelPopView:onEnter()
	SeasonPassBuyLevelPopView.super.onEnter(self)

	local params = self:getOpenParam()

	if params == nil then
		self:close()

		return
	end

	data = params[1]
	self._viewData = data

	if data.useBuyLevel >= data.maxBuyLevel or data.nowLevel >= data.maxLevel then
		self:close()

		return
	end

	local arr = string.split(data.costCfg, ":")

	self._costType = arr[1]
	self._costId = arr[2]
	self._costName = MaterialMgr.getMaterialsNameByCfg(data.costCfg)
	self._setNumber = 1

	self:_setChargeNum()
end

function SeasonPassBuyLevelPopView:_setChargeNum()
	self._procNumText:SetText(tostring(self._setNumber))

	self._requireNum = self:_getBuyLevelCostByNum(checknumber(self._setNumber))
	self._buyText.text = "是否购买" .. self._setNumber .. "级, 升至" .. self._viewData.nowLevel + self._setNumber .. "级吗？"
	self._txtDes.text = "最多可购买" .. self._viewData.useBuyLevel + self._setNumber .. "/" .. self._viewData.maxBuyLevel .. "级"

	MaterialMgr.setIcon(self._iconCost, self._costType, self._costId)
	MaterialMgr.setIcon(self._iconHave, self._costType, self._costId)

	self._txtCost.text = self._requireNum
	self._txtHave.text = MaterialMgr.getMatCount(self._viewData.costCfg)
end

function SeasonPassBuyLevelPopView:_getBuyLevelCostByNum(buyNum)
	local count = 0
	local useBuyLevel = self._viewData.useBuyLevel

	for i = useBuyLevel + 1, useBuyLevel + buyNum do
		local _, _, num = MaterialMgr.getMatParams(self._viewData.buyLevelCostConfig[i].cost)

		count = count + num
	end

	return count
end

function SeasonPassBuyLevelPopView:_changeNumText(delta)
	self._setNumber = self._setNumber + delta
	self._setNumber = Mathf.Clamp(self._setNumber, 1, self._viewData.maxBuyLevel - self._viewData.useBuyLevel)

	if self._viewData.nowLevel + self._setNumber > self._viewData.maxLevel then
		FloatWordMgr.instance:show("当前购买已到最高等级")

		self._setNumber = self._viewData.maxLevel - self._viewData.nowLevel
	end

	self:_setChargeNum()
end

function SeasonPassBuyLevelPopView:_onValueChanged(strNum)
	self._setNumber = checkint(strNum)
	self._setNumber = Mathf.Clamp(self._setNumber, 1, self._viewData.maxBuyLevel - self._viewData.useBuyLevel)

	self:_setChargeNum()
end

function SeasonPassBuyLevelPopView:_onClickAgree()
	self._setNumber = checknumber(self._setNumber)

	if self._setNumber <= 0 then
		FloatWordMgr.instance:show("请选择购买等级数量")

		return
	end

	if self._setNumber > self._viewData.maxBuyLevel - self._viewData.useBuyLevel then
		FloatWordMgr.instance:show("购买等级次数超出限制")

		return
	end

	if self._viewData.nowLevel + self._setNumber > self._viewData.maxLevel then
		FloatWordMgr.instance:show("购买后等级超出战令最大等级限制")

		return
	end

	local haveCount = MaterialMgr.getMatCount(self._viewData.costCfg)

	if haveCount < self._requireNum then
		local tips = "所需" .. self._costName .. "不足！"

		FloatWordMgr.instance:show(tips)

		return
	end

	SeasonModeWarOrderController.instance:sendSeasonPassBuyLevel(self._viewData.nowLevel + self._setNumber)
	self:close()
end

return SeasonPassBuyLevelPopView
