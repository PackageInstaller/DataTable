-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityProsperityView.lua

module("logic.extensions.eternalcity.view.EternalCityProsperityView", package.seeall)

local EternalCityProsperityView = class("EternalCityProsperityView", ViewComponent)

function EternalCityProsperityView:buildUI()
	EternalCityProsperityView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtProsperity = self:getTxt("descCol/txtProsperity")
	self._btnGain = self:getGo("prize/btnGain")
	self._prizeItem = self:getGo("prize/item")
	self._tagHasGain = self:getGo("prize/tagHasGain")
	self._effRootPrize = self:getGo("prize/effRoot")
	self._txtTips = self:getTxt("prize/txtTips")
	self._strTxtTips = self._txtTips.text
	self._descScrCell = self:getGo("descCol/scrCell")
	self._descScrView = self:getGo("descCol/scrView")
	self._descScrollerList = ScrollerList.create(self._descScrView, self._descScrCell, GameUtil.handler(self._updateDescScrCell, self), GameUtil.handler(self._clearDescScrCell, self))
end

function EternalCityProsperityView:bindEvents()
	EternalCityProsperityView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGain, self._onClickBtnGain, self)
end

function EternalCityProsperityView:unbindEvents()
	EternalCityProsperityView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGain)
end

function EternalCityProsperityView:onEnter()
	EternalCityProsperityView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = EternalCityController.instance:getSubMo(self._activityId)
	self._actData = EternalCityConfig.instance:getActivityData(self._activityId)
	self._historyMaxProsperity = self._subMo:getHistoryMaxProsperity()
	self._curProsperityData = EternalCityConfig.instance:getProsperityDataByProsperity(self._activityId, self._historyMaxProsperity)

	local goldMats = {}
	local prosperityRewardMats = self._subMo:getProsperityRewardMats()

	for prosperity, matMo in pairs(prosperityRewardMats) do
		goldMats[matMo.matType .. ":" .. matMo.matId] = true
	end

	local prizeStr = _G.next(goldMats)

	self._prizeProxy = MaterialMgr.setCellByCfg(prizeStr, self._prizeItem)

	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityGainProfitRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityNotifyProsperityChangeRes, self._onUpdate, self)
	self:_onUpdate()
	settimer(10, self._onTicking, self, true)
	self:_onTicking()
end

function EternalCityProsperityView:onExit()
	EternalCityProsperityView.super.onExit(self)
	removetimer(self._onTicking, self)
	MaterialMgr.resetAll(self._prizeItem)
	self:_onClearDescCol()
end

function EternalCityProsperityView:_onTicking()
	self._prizeProxy.binder:setNum(0)

	local curMin = 0

	if self._curProsperityData then
		curMin = EternalCityController.instance:getGainProfitDiffMin(self._activityId)

		local matMo = self._subMo:getProsperityRewardMat(self._curProsperityData.prosperity)

		if matMo then
			if not matMo.matNum then
				local matNum = 0

				self._prizeProxy.binder:setNum(curMin * matNum)
			end
		end
	end

	local minLimit = self._subMo:getGainProfitInterval()

	if self._curProsperityData then
		if not self._curProsperityData.maxStoreRewardTime then
			local maxLimit = 0

			self._txtTips.text = string.format(self._strTxtTips, minLimit, curMin, maxLimit)

			local isCanGain = EternalCityController.instance:isCanGainProfit(self._activityId)

			if isCanGain then
				self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", self._effRootPrize, nil, true, nil, nil)
			else
				self:stopViewEffectUniGo(self._effRootPrize)
			end

			GameUtil.SetActive(self._btnGain, isCanGain)
		end
	end
end

function EternalCityProsperityView:_onUpdate()
	self._historyMaxProsperity = self._subMo:getHistoryMaxProsperity()
	self._curProsperityData = EternalCityConfig.instance:getProsperityDataByProsperity(self._activityId, self._historyMaxProsperity)

	self:_onUpdateDescCol()
	self:_onTicking()

	self._txtProsperity.text = string.format("当前繁荣度：%s", self._historyMaxProsperity)
end

function EternalCityProsperityView:_onUpdateDescCol()
	local dataList = {}
	local datas = EternalCityConfig.instance:getProsperityDatas(self._activityId) or {}

	for prosperity, data in pairs(datas) do
		table.insert(dataList, data)
	end

	table.sort(dataList, function(a, b)
		return a.prosperity < b.prosperity
	end)
	self._descScrollerList:reloadData(dataList)

	local index = 0

	for idx, data in pairs(dataList) do
		if self._curProsperityData then
			local isActive = self._curProsperityData.prosperity == data.prosperity

			if isActive then
				index = idx - 1

				break
			end
		end
	end

	self._descScrollerList:MoveCellToCenter(index)
end

function EternalCityProsperityView:_onClearDescCol()
	self._descScrollerList:dispose()
end

function EternalCityProsperityView:_updateDescScrCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local isActive = self._curProsperityData and self._curProsperityData.prosperity == data.prosperity or false
	local matMo = self._subMo:getProsperityRewardMat(data.prosperity)
	local txtProsperity = goutil.findChildTextComponent(mainGo, "txtProsperity")
	local txtCount = goutil.findChildTextComponent(mainGo, "txtCount")
	local icon = goutil.findChild(mainGo, "txtCount/icon")
	local tagActive = goutil.findChild(mainGo, "tagActive")
	local empty = goutil.findChild(mainGo, "empty")

	if matMo then
		MaterialMgr.setIcon(icon, matMo.matType, matMo.matId, nil, nil)
	else
		MaterialMgr.clearIcon(icon)
	end

	if matMo then
		txtCount.text = matMo.matNum or 0
	end

	GameUtil.SetActive(txtCount.gameObject, matMo ~= nil)
	GameUtil.SetActive(empty, matMo == nil)

	txtProsperity.text = data.prosperity

	GameUtil.SetActive(tagActive, isActive)
	GameUtil.setUIGroupIdx(mainGo, isActive and 1 or 0)
end

function EternalCityProsperityView:_clearDescScrCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "txtCount/icon")

	MaterialMgr.clearIcon(icon)
end

function EternalCityProsperityView:_onClickBtnGain()
	local isCanGain = EternalCityController.instance:isCanGainProfit(self._activityId)

	if not isCanGain then
		return
	end

	EternalCityController.instance:sendPM_EternalCityGainProfitReq(self._activityId)
end

return EternalCityProsperityView
