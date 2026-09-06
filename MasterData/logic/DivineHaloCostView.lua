-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehalogame/view/DivineHaloCostView.lua

module("logic.extensions.divinehalogame.view.DivineHaloCostView", package.seeall)

local DivineHaloCostView = class("DivineHaloCostView", ViewComponent)

function DivineHaloCostView:ctor()
	DivineHaloCostView.super.ctor(self)
end

function DivineHaloCostView:unbindEvents()
	DivineHaloCostView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnM10)
	GameUtil.rmClickHandler(self._btnA10)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnMs)
	GameUtil.rmClickHandler(self._btnSure)
	self._inputComp:RemoveOnValueChanged()
end

function DivineHaloCostView:bindEvents()
	DivineHaloCostView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnM10, self._onClickBtnLessTen, self)
	GameUtil.addClickHandler(self._btnA10, self._onClickBtnAddTen, self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickBtnAdd, self)
	GameUtil.addClickHandler(self._btnMs, self._onClickBtnLess, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	self._inputComp:AddOnValueChanged(self._onValueChanged, self)
end

function DivineHaloCostView:buildUI()
	DivineHaloCostView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._content = self:getTxt("content")
	self._txtNumCost = self:getTxt("curCost/txtNum")
	self._txtNumCurOwn = self:getTxt("curOwn/txtNum")
	self._iconCost = self:getGo("curCost/icon")
	self._iconCurOwn = self:getGo("curOwn/icon")
	self._btnSure = self:getGo("btnSure")
	self._inputComp = self:getInput("inputNum")
	self._txtInput = self:getTxt("inputNum/Text")
	self._btnA10 = self:getGo("adjust/BtnA10")
	self._btnMs = self:getGo("adjust/BtnMs")
	self._btnAdd = self:getGo("adjust/BtnAdd")
	self._btnM10 = self:getGo("adjust/BtnM10")
end

function DivineHaloCostView:onExit()
	DivineHaloCostView.super.onExit(self)
	MaterialMgr.clearIcon(self._iconCost)
	MaterialMgr.clearIcon(self._iconCurOwn)
end

function DivineHaloCostView:onEnter()
	DivineHaloCostView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineHaloGameBuyTimesRes, self.close, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 476001
	end

	self._curBuyNum = 1
	self._info = DivineHaloGameModel.instance:getInfo(self._activityId)
	self._actCfg = DivineHaloGameConfig.instance:getActData(self._activityId)
	self._stageCfgs = DivineHaloGameConfig.instance:getStageDatas(self._activityId)
	self._buyTimeCfg = DivineHaloGameConfig.instance:getBuyTimeDataByBuyTime(self._activityId, self._info.todayBuyTimes + 1)

	self:_updateUI()
end

function DivineHaloCostView:_onClickBtnLessTen()
	if self._curBuyNum == 1 then
		FloatWordMgr.instance:show("购买次数无法再减少")

		return
	end

	self._curBuyNum = self._curBuyNum <= 10 and 1 or self._curBuyNum - 10

	self._inputComp:SetText(self._curBuyNum)
end

function DivineHaloCostView:_onClickBtnAddTen()
	local limitNum = Mathf.Min(self._actCfg.dailyBuyTimesLimit + self._info.existingTimes, self._actCfg.storeTimesLimit)
	local totalStageNum = #self._stageCfgs

	if not self._info.passStageIds then
		local passedStageIds = {}
		local leftStageNum = totalStageNum - #passedStageIds
		local needBuyStageNum = Mathf.Max(0, leftStageNum - self._info.existingTimes)

		limitNum = Mathf.Min(limitNum, self._info.existingTimes + needBuyStageNum)

		if needBuyStageNum <= self._curBuyNum then
			FloatWordMgr.instance:show("当前购买次数足够通关，无需购买更多次数")

			return
		end

		local totalPlayTime = self._info.existingTimes + leftStageNum

		if totalPlayTime == self._actCfg.storeTimesLimit then
			FloatWordMgr.instance:show("已达购买次数上限")

			return
		end

		self._curBuyNum = limitNum < self._info.existingTimes + self._curBuyNum + 10 and limitNum - self._info.existingTimes or self._curBuyNum + 10

		self._inputComp:SetText(self._curBuyNum)
	end
end

function DivineHaloCostView:_onClickBtnAdd()
	local limitNum = Mathf.Min(self._actCfg.dailyBuyTimesLimit + self._info.existingTimes, self._actCfg.storeTimesLimit)
	local totalStageNum = #self._stageCfgs

	if not self._info.passStageIds then
		local passedStageIds = {}
		local leftStageNum = totalStageNum - #passedStageIds
		local needBuyStageNum = Mathf.Max(0, leftStageNum - self._info.existingTimes)

		limitNum = Mathf.Min(limitNum, self._info.existingTimes + needBuyStageNum)

		if needBuyStageNum <= self._curBuyNum then
			FloatWordMgr.instance:show("当前购买次数足够通关，无需购买更多次数")

			return
		end

		local totalPlayTime = self._info.existingTimes + self._curBuyNum

		if totalPlayTime == self._actCfg.storeTimesLimit then
			FloatWordMgr.instance:show("已达购买次数上限")

			return
		end

		if limitNum >= self._info.existingTimes + self._curBuyNum + 1 then
			self._curBuyNum = self._curBuyNum + 1
		end

		self._inputComp:SetText(self._curBuyNum)
	end
end

function DivineHaloCostView:_onClickBtnLess()
	if self._curBuyNum == 1 then
		FloatWordMgr.instance:show("购买次数无法再减少")

		return
	end

	if self._curBuyNum > 1 then
		self._curBuyNum = self._curBuyNum - 1
	end

	self._inputComp:SetText(self._curBuyNum)
end

function DivineHaloCostView:_onClickBtnSure()
	DivineHaloGameController.instance:sendPM_DivineHaloGameBuyTimesReq(self._activityId, self._curBuyNum)
end

function DivineHaloCostView:_onValueChanged(numStr)
	local buyNum = checkint(numStr)
	local limitNum = Mathf.Min(self._actCfg.dailyBuyTimesLimit + self._info.existingTimes, self._actCfg.storeTimesLimit)

	if limitNum < buyNum + self._info.existingTimes then
		buyNum = limitNum - self._info.existingTimes
	end

	if buyNum <= 0 then
		buyNum = 1
	end

	self._curBuyNum = buyNum

	self._inputComp:SetText(tostring(self._curBuyNum))
	self:_updateUI()
end

function DivineHaloCostView:_updateUI()
	local matName = MaterialMgr.getMaterialsNameByCfg(self._buyTimeCfg.cost)
	local costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(self._buyTimeCfg.cost)
	local totalPlayTime = self._info.existingTimes + self._curBuyNum

	self._content.text = string.format("是否消耗%d%s购买%d次闯关次数?\n购买后次数：%d / %d", self._curBuyNum * costMatNum, matName, self._curBuyNum, totalPlayTime, self._actCfg.storeTimesLimit)
	self._txtNumCost.text = self._curBuyNum * costMatNum
	self._txtNumCurOwn.text = MaterialModel.instance:getMaterialsNumber(costMatType, costMatId)

	MaterialMgr.setIcon(self._iconCost, costMatType, costMatId, nil, nil)
	MaterialMgr.setIcon(self._iconCurOwn, costMatType, costMatId, nil, nil)
	self._inputComp:SetText(tostring(self._curBuyNum))
end

return DivineHaloCostView
