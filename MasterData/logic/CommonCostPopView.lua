-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/CommonCostPopView.lua

module("logic.extensions.tips.view.CommonCostPopView", package.seeall)

local CommonCostPopView = class("CommonCostPopView", ViewComponent)

function CommonCostPopView:buildUI()
	CommonCostPopView.super.buildUI(self)

	self._btnLess = self:getGo("adjust/btnLess")
	self._btnAdd = self:getGo("adjust/btnAdd")
	self._btnMin = self:getGo("adjust/btnMin")
	self._btnMax = self:getGo("adjust/btnMax")
	self._inputField = self:getInput("inputField")
	self._btnClose = self:getGo("btnClose")
	self._btnCancel = self:getGo("btnCancel")
	self._txtBtnCancel = self:getTxt("btnCancel/txt")
	self._btnSure = self:getGo("btnSure")
	self._txtBtnSure = self:getTxt("btnSure/txt")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtCoin = self:getTxt("txtCoin")
	self._strTxtCoin = self._txtCoin.text
end

function CommonCostPopView:bindEvents()
	CommonCostPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnLess, function()
		self:_calcValue(-1)
	end, self)
	GameUtil.addClickHandler(self._btnAdd, function()
		self:_calcValue(1)
	end, self)
	GameUtil.addClickHandler(self._btnMin, function()
		self:_onValueChanged(0)
	end, self)
	GameUtil.addClickHandler(self._btnMax, function()
		self:_onValueChanged(self._maxTimes)
	end, self)
	self._inputField:AddOnValueChanged(self._onValueChanged, self)
end

function CommonCostPopView:unbindEvents()
	CommonCostPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnLess)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnMin)
	GameUtil.rmClickHandler(self._btnMax)
	self._inputField:RemoveOnValueChanged()
end

function CommonCostPopView:onEnter()
	CommonCostPopView.super.onEnter(self)

	local params = self:getOpenParam()[1]

	self._minCoinNum = 0
	self._maxCoinNum = params.coinNum
	self._curCoinNum = self._maxCoinNum
	self._exchangeRate = params.exchangeRate or 1
	self._minTimes = 0
	self._maxTimes = Mathf.Floor(self._maxCoinNum / self._exchangeRate)
	self._curTimes = Mathf.Min(1, self._maxTimes)
	self._titleTxt = params.titleTxt or "提示"
	self._cancelTxt = params.cancelTxt or "取消"
	self._sureTxt = params.sureTxt or "确定"
	self._descTxt = params.descTxt or "请输入数量"
	self._cancelCallBack = params.cancelCallBack
	self._sureCallBack = params.sureCallBack
	self._otherCallBack = params.otherCallBack
	self._updateDescTxtCallBack = params.updateDescTxtCallBack
	self._updateCoinTxtCallBack = params.updateCoinTxtCallBack
	self._isOnlyCanClose = params.isOnlyCanClose
	self._txtTitle.text = self._titleTxt
	self._txtBtnCancel.text = self._cancelTxt
	self._txtBtnSure.text = self._sureTxt

	self:_onValueChanged(self._curTimes)
end

function CommonCostPopView:onExit()
	CommonCostPopView.super.onExit(self)

	self._cancelCallBack = nil
	self._sureCallBack = nil
	self._updateDescTxtCallBack = nil
end

function CommonCostPopView:getMinCoinNum()
	return self._minCoinNum
end

function CommonCostPopView:getMaxCoinNum()
	return self._maxCoinNum
end

function CommonCostPopView:getCurCoinNum()
	return self._curCoinNum
end

function CommonCostPopView:getExchangeRate()
	return self._exchangeRate
end

function CommonCostPopView:getMinTimes()
	return self._minTimes
end

function CommonCostPopView:getMaxTimes()
	return self._maxTimes
end

function CommonCostPopView:getCurTimes()
	return self._curTimes
end

function CommonCostPopView:getTxtDesc()
	return self._txtDesc
end

function CommonCostPopView:getTxtCoin()
	return self._txtCoin
end

function CommonCostPopView:_onUpdate()
	if self._updateCoinTxtCallBack then
		GameUtil.callBack(self._updateCoinTxtCallBack, self)
	else
		self._txtCoin.text = string.format(self._strTxtCoin, self._curCoinNum, self._maxCoinNum)
	end

	GameUtil.SetGray(self._btnSure, self._curTimes <= 0)

	if self._updateDescTxtCallBack then
		GameUtil.callBack(self._updateDescTxtCallBack, self)
	else
		self._txtDesc.text = self._descTxt
	end
end

function CommonCostPopView:_onValueChanged(numStr)
	local targetTimes = checkint(numStr)

	targetTimes = Mathf.Clamp(targetTimes, 0, self._maxTimes)
	self._curTimes = targetTimes

	self._inputField:SetText(tostring(self._curTimes))

	self._curCoinNum = self._maxCoinNum - self._curTimes * self._exchangeRate

	self:_onUpdate()
end

function CommonCostPopView:_calcValue(deltaTimes)
	local costCoinNum = deltaTimes * self._exchangeRate

	if costCoinNum <= self._curCoinNum then
		local times = self._curTimes + checkint(deltaTimes)

		self:_onValueChanged(times)
	end
end

function CommonCostPopView:_onClickBtnSure()
	if self._curTimes > 0 then
		GameUtil.callBack(self._sureCallBack, self)
		self:close()
	end
end

function CommonCostPopView:_onClickBtnCancel()
	GameUtil.callBack(self._cancelCallBack, self)
	self:close()
end

function CommonCostPopView:_onClickBtnClose()
	if self._isOnlyCanClose and self._isOnlyCanClose == true then
		self:close()
	else
		GameUtil.callBack(self._cancelCallBack, self)
		self:close()
	end
end

return CommonCostPopView
