-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/view/ScratchExchangeView.lua

module("logic.extensions.scratch.view.ScratchExchangeView", package.seeall)

local ScratchExchangeView = class("ScratchExchangeView", ViewComponent)

function ScratchExchangeView:ctor()
	ScratchExchangeView.super.ctor(self)
end

function ScratchExchangeView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._inputField = self:getInput("content/inputField")
	self._txtPrice = self:getTxt("content/txtPrice")
	self._btnAdd = self:getBtn("content/inputField/btnAdd")
	self._btnMinus = self:getBtn("content/inputField/btnMinus")
	self._btnAddTen = self:getBtn("content/inputField/btnAddTen")
	self._btnMinusTen = self:getBtn("content/inputField/btnMinusTen")
	self._btnExchange = self:getBtn("content/btnExchange")
	self._iconNode = self:getGo("content/iconNode")
	self._txtName = self:getTxt("content/txtName")
	self._txtHave = self:getTxt("content/txtHave")
	self._txtDesc = self:getTxt("content/txtDesc")
end

function ScratchExchangeView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._inputField:AddOnValueChanged(self._onInputFieldValueChanged, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
	self._btnMinus:AddClickListener(self._onClickMinus, self)
	self._btnAddTen:AddClickListener(self._onClickAddTen, self)
	self._btnMinusTen:AddClickListener(self._onClickMinusTen, self)
	self._btnExchange:AddClickListener(self._onClickBtnExchange, self)
end

function ScratchExchangeView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._inputField:RemoveOnValueChanged()
	self._btnAdd:RemoveClickListener()
	self._btnMinus:RemoveClickListener()
	self._btnAddTen:RemoveClickListener()
	self._btnMinusTen:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
end

function ScratchExchangeView:onEnter()
	self._totalScore = ScratchModel.instance:getScore()

	local cfg = ScratchConfig.instance:getScratchParamsCfg("SCORE_EXCHANGE_ITEM")
	local itemCfg = ScratchController.instance:getItemCfg()

	self._unitScore = checknumber(cfg.value)

	self:_clampNum(self._totalScore)

	self._txtHave.text = "数量：" .. tostring(ScratchController.instance:getCurExchangeItemNum())

	if itemCfg then
		self._txtName.text = itemCfg.name
		self._txtDesc.text = itemCfg.desc
	end
end

function ScratchExchangeView:onExit()
	return
end

function ScratchExchangeView:_onClickClose()
	self:close()
end

function ScratchExchangeView:_clampNum(num)
	if num < 0 then
		num = 0
	end

	num = num * self._unitScore <= self._totalScore and num or Mathf.Floor(self._totalScore / self._unitScore)
	self._exchangeNum = num

	self._inputField:SetText(tostring(self._exchangeNum))

	self._txtPrice.text = tostring(self._exchangeNum * self._unitScore)
end

function ScratchExchangeView:_onInputFieldValueChanged(str)
	self:_clampNum(checknumber(str))
end

function ScratchExchangeView:_onClickAdd()
	local num = checknumber(self._inputField:GetText())

	self:_clampNum(num + 1)
end

function ScratchExchangeView:_onClickMinus()
	local num = checknumber(self._inputField:GetText())

	self:_clampNum(num - 1)
end

function ScratchExchangeView:_onClickAddTen()
	local num = checknumber(self._inputField:GetText())

	self:_clampNum(num + 10)
end

function ScratchExchangeView:_onClickMinusTen()
	local num = checknumber(self._inputField:GetText())

	self:_clampNum(num - 10)
end

function ScratchExchangeView:_onClickBtnExchange()
	if Mathf.Floor(self._totalScore / self._unitScore) < 1 then
		FloatWordMgr.instance:show(string.format("您的积分少于%d个", self._unitScore))

		return
	end

	if self._exchangeNum == 0 then
		FloatWordMgr.instance:show("请选择至少1个十字镐")

		return
	end

	ScratchModel.instance:setExchangeSelectScore(self._exchangeNum)
	ScratchController.instance:sendScratchExchangeReq(self._exchangeNum)
	self:_onClickClose()
end

return ScratchExchangeView
