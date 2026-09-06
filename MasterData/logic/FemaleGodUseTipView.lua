-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalegod/view/FemaleGodUseTipView.lua

module("logic.extensions.femalegod.view.FemaleGodUseTipView", package.seeall)

local FemaleGodUseTipView = class("FemaleGodUseTipView", ViewComponent)

function FemaleGodUseTipView:ctor()
	FemaleGodUseTipView.super.ctor(self)
end

function FemaleGodUseTipView:unbindEvents()
	FemaleGodUseTipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
end

function FemaleGodUseTipView:bindEvents()
	FemaleGodUseTipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FemaleGodUseTipView:buildUI()
	FemaleGodUseTipView.super.buildUI(self)

	self._content = self:getTxt("main/content")
	self._btnSure = self:getGo("main/btnSure")
	self._btnClose = self:getGo("btnClose")
	self._imgNeedCost = self:getGo("main/imgCostDiamond/img")
	self._txtCostNum = self:getTxt("main/imgCostDiamond/txtNum")
	self._txtSaleNum = self:getTxt("main/imgCostDiamond/txtNum/txtSaleNum")
	self._imgHasMaterial = self:getGo("main/imgMyDiamond/img")
	self._txtHasNum = self:getTxt("main/imgMyDiamond/txtNum")
	self._txtSaleDesc = self:getTxt("saleDesc/txt")
	self._saleDesc = self:getGo("saleDesc")
	self._deleteLine = self:getGo("main/imgCostDiamond/deleteLine")
end

function FemaleGodUseTipView:onExit()
	FemaleGodUseTipView.super.onExit(self)
	MaterialMgr.clearIcon(self._imgNeedCost)
	MaterialMgr.clearIcon(self._imgHasMaterial)
end

function FemaleGodUseTipView:onEnter()
	FemaleGodUseTipView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._costStr = params[2]
	self._price = checknumber(params[3])
	self._afterDescStr = params[4]
	self._callBackFunc = params[5]
	self._actCfg = FemaleGodConfig.instance:getActivityCfgByRelateActId(self._activityId)
	self._relatedCfg = FemaleGodConfig.instance:findRelatedCfgByRelateActId(self._activityId)
	self._extStr = self._relatedCfg.deductToZeroAddCost

	self:_onSetUI()
end

function FemaleGodUseTipView:_onSetUI()
	local costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(self._costStr)
	local costName = MaterialMgr.getMaterialsName(costMatType, costMatId)
	local expendMoneyMatStr = self._actCfg.inflationMoneyMaterialKey
	local arr = string.split(expendMoneyMatStr, ":")
	local hasExpendMoneyNum = MaterialModel.instance:getMaterialsNumber(arr[1], arr[2])
	local hasCostMatNum = MaterialModel.instance:getMaterialsNumber(costMatType, costMatId)

	GameUtil.SetActive(self._saleDesc, hasExpendMoneyNum > 0)
	GameUtil.SetActive(self._deleteLine, hasExpendMoneyNum > 0)
	GameUtil.SetActive(self._txtSaleNum.gameObject, hasExpendMoneyNum > 0)

	self._txtCostNum.text = self._price

	local afterSalePrizeNum = self:_caculateSalePrizeNum(self._price)

	self._txtSaleNum.text = afterSalePrizeNum
	self._txtHasNum.text = hasCostMatNum
	self._txtSaleDesc.text = "本次膨胀金立减 <color=#FF7E7EFF><size=28>" .. self._price - afterSalePrizeNum .. "</size></color>"

	local afterStr = self._afterDescStr == nil and "并进行一次许愿吗？" or self._afterDescStr

	if afterSalePrizeNum <= 0 and self._extStr then
		local extPrizeType, extPrizeId, extPrizeNum = MaterialMgr.getMatParams(self._extStr)
		local extName = MaterialMgr.getMaterialsName(extPrizeType, extPrizeId)

		self._content.text = langPara("确定花费%s%s" .. afterStr, extPrizeNum, extName)
	else
		self._content.text = langPara("确定花费%s%s" .. afterStr, afterSalePrizeNum, costName)
	end

	MaterialMgr.clearIcon(self._imgNeedCost)
	MaterialMgr.setIcon(self._imgNeedCost, costMatType, costMatId, nil, nil)
	MaterialMgr.clearIcon(self._imgHasMaterial)
	MaterialMgr.setIcon(self._imgHasMaterial, costMatType, costMatId, nil, nil)
end

function FemaleGodUseTipView:_caculateSalePrizeNum(costMatNum)
	local deductMaxCount = self._relatedCfg.deductMaxCount
	local deductWanPercent = self._relatedCfg.deductWanPercent
	local finalSaleNum = 0
	local expendMoneyMatStr = self._actCfg.inflationMoneyMaterialKey
	local arr = string.split(expendMoneyMatStr, ":")
	local hasExpendMoneyNum = MaterialModel.instance:getMaterialsNumber(arr[1], arr[2])

	if deductMaxCount ~= 0 then
		finalSaleNum = deductMaxCount <= hasExpendMoneyNum and (costMatNum - deductMaxCount >= 0 and costMatNum - deductMaxCount or 0) or costMatNum - hasExpendMoneyNum >= 0 and costMatNum - hasExpendMoneyNum or 0
	else
		local saleScale = (10000 - deductWanPercent) / 10000

		finalSaleNum = costMatNum * saleScale

		if hasExpendMoneyNum < costMatNum - costMatNum * saleScale then
			finalSaleNum = costMatNum - hasExpendMoneyNum
		end
	end

	return math.floor(finalSaleNum)
end

function FemaleGodUseTipView:_onClickBtnSure()
	GameUtil.callBack(self._callBackFunc)
	self:close()
end

return FemaleGodUseTipView
