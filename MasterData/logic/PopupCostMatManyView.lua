-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/PopupCostMatManyView.lua

module("logic.extensions.tips.view.PopupCostMatManyView", package.seeall)

local PopupCostMatManyView = class("PopupCostMatManyView", ViewComponent)

function PopupCostMatManyView:ctor()
	PopupCostMatManyView.super.ctor(self)
end

function PopupCostMatManyView:bindEvents()
	self._addBtn:AddClickListener(self._onClickAdd, self)
	self._minusBtn:AddClickListener(self._onClickMinus, self)
	self._addBtnTen:AddClickListener(self._onClickAddTen, self)
	self._minusBtnTen:AddClickListener(self._onClickMinusTen, self)
	self._buyBtn:AddClickListener(self._onClickBuy, self)
	self._returnBtn:AddClickListener(self._onClickClose, self)
	self._input:AddOnValueChanged(self._buyCountChanged, self)
end

function PopupCostMatManyView:unbindEvents()
	self._addBtn:RemoveClickListener()
	self._minusBtn:RemoveClickListener()
	self._addBtnTen:RemoveClickListener()
	self._minusBtnTen:RemoveClickListener()
	self._buyBtn:RemoveClickListener()
	self._returnBtn:RemoveClickListener()
	self._input:RemoveOnValueChanged()
end

function PopupCostMatManyView:buildUI()
	self._itemCon = self:getGo("content/itemCon")
	self._timeObj = self:getGo("content/ImgTimeBg")
	self._timeTxt = self:getGo("content/ImgTimeBg/TxtTime"):GetComponent("Text")
	self._nameTxt = self:getGo("content/TxtName"):GetComponent("Text")
	self._limitTxt = self:getGo("content/TxtLimit"):GetComponent("Text")
	self._priceTxt = self:getGo("content/BgPrice/ImgCnt/TxtPrice"):GetComponent("Text")
	self._haveTxt = self:getGo("content/TxtHave"):GetComponent("Text")
	self._descTxt = self:getGo("content/TxtDesc"):GetComponent("Text")
	self._useMatIcon = self:getGo("content/BgPrice/ImgCnt")
	self._addBtn = self:getBtn("content/BgNum/BtnAdd")
	self._minusBtn = self:getBtn("content/BgNum/BtnMinus")
	self._addBtnTen = self:getBtn("content/BgNum/BtnAddTen")
	self._minusBtnTen = self:getBtn("content/BgNum/BtnMinusTen")
	self._buyBtn = self:getBtn("content/BtnBuy")
	self._returnBtn = self:getBtn("btnRtn")
	self._input = self:getInput("content/BgNum")
	self.group = self:getGo("content/TxtName"):GetComponent("UIChangeGroup")
end

function PopupCostMatManyView:destroyUI()
	return
end

function PopupCostMatManyView:onEnter()
	local param = self._viewPresentor:getFirstParam()
	local mat = GameUtil.parseMatStr2Table(param.targetMat)
	local matType = mat[1]
	local matId = mat[2]
	local costMat = param.costMat
	local maxBuyNum = param.maxBuyNum
	local maxBuyNumTxt = param.maxBuyNumTxt
	local content = param.content
	local cellCfg = param.targetMat

	self._sureFunc = param.sureFunc
	self._actType = checknumber(matType)
	self._matId = checknumber(matId)
	self._limitTxt.text = maxBuyNumTxt
	self._haveTxt.text = "拥有：" .. MaterialFacade.instance:getMatNumber(matType, matId)

	local color = MaterialMgr.getGoodsColor(matType, matId)

	if matType == MatType.Pet then
		local cfg = CharacterConfig.instance:getPetInfoCo(matId)

		self._descTxt.text = cfg.introduce
		self._nameTxt.text = GameUtil.HtmlColorTxt(cfg.name, color)
	else
		local matCfg = MaterialMgr.getMatCfg(matType, matId)

		self._descTxt.text = matCfg.desc
		self._nameTxt.text = GameUtil.HtmlColorTxt(matCfg.name, color)
	end

	if not string.nilorempty(content) then
		self._descTxt.text = content
	end

	self.group:SetState(0)

	self._noBuyCount = false
	self._buyCount = 1

	local tCost = GameUtil.parseMatStr2Table(costMat)

	MaterialMgr.setIcon(self._useMatIcon, tCost[1], tCost[2])

	local proxy = MaterialMgr.setCellByCfg(cellCfg, self._itemCon)

	proxy:setAutoTips(false)

	self._sellLimitCount = checknumber(maxBuyNum)
	self._sellPrice = costMat

	self:_refreshBuyCount()
end

function PopupCostMatManyView:onEnterFinished()
	return
end

function PopupCostMatManyView:onExit()
	MaterialMgr.resetAll(self._itemCon)
	MaterialMgr.clearIcon(self._useMatIcon)
end

function PopupCostMatManyView:onExitFinished()
	return
end

function PopupCostMatManyView:_buyCountChanged()
	self._buyCount = checknumber(self._input:GetText())

	self:_refreshBuyCount()
end

function PopupCostMatManyView:_refreshBuyCount()
	local costNum = MaterialFacade.instance:getGoodCostByStr(self._sellPrice)
	local matType, matId, matNum = MaterialMgr.getMatParams(self._sellPrice)
	local limitCount = math.floor(MaterialModel.instance:getMaterialsNumber(matType, matId) / costNum)

	self._buyCount = math.max(self._buyCount, 1)
	self._buyCount = math.min(self._buyCount, limitCount)
	self._buyCount = self._sellLimitCount > 0 and math.min(self._buyCount, self._sellLimitCount) or math.min(self._buyCount, 99)
	self._priceTxt.text = costNum * self._buyCount

	local str = tostring(self._buyCount)

	self._input:SetText(str)
end

function PopupCostMatManyView:_onClickAdd()
	self._buyCount = self._buyCount + 1

	self:_refreshBuyCount()
end

function PopupCostMatManyView:_onClickMinus()
	self._buyCount = self._buyCount - 1

	self:_refreshBuyCount()
end

function PopupCostMatManyView:_onClickAddTen()
	self._buyCount = self._buyCount + 10

	self:_refreshBuyCount()
end

function PopupCostMatManyView:_onClickMinusTen()
	self._buyCount = self._buyCount - 10

	self:_refreshBuyCount()
end

function PopupCostMatManyView:_onClickBuy()
	if self._buyCount > self._sellLimitCount then
		FloatWordMgr.instance:show("商品可购买次数不足")
	else
		self._sureFunc(self._buyCount)
	end

	self:_onClickClose()
end

function PopupCostMatManyView:_onClickClose()
	self:close()
end

return PopupCostMatManyView
