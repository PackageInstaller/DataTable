-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvGlobalPrizeView.lua

module("logic.extensions.domainadventure.view.DomAdvGlobalPrizeView", package.seeall)

local DomAdvGlobalPrizeView = class("DomAdvGlobalPrizeView", ViewComponent)

function DomAdvGlobalPrizeView:ctor()
	DomAdvGlobalPrizeView.super.ctor(self)
end

function DomAdvGlobalPrizeView:buildUI()
	DomAdvGlobalPrizeView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "txtCount")
	self._txtCost = goutil.findChildTextComponent(self.mainGO, "txtCost")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")
	self._tipsStr = self._txtTips.text
	self._prizeScrView = goutil.findChild(self.mainGO, "prizeScrView")
	self._prizeScrCell = goutil.findChild(self.mainGO, "prizeScrCell")
	self._prizeScrollRect = self._prizeScrView:GetComponent(ComponentType.ScrollRect)
	self._progressBar = goutil.findChild(self.mainGO, "prizeScrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeScrView/Viewport/Content/progressBar")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrView, self._prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function DomAdvGlobalPrizeView:bindEvents()
	DomAdvGlobalPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DomAdvGlobalPrizeView:unbindEvents()
	DomAdvGlobalPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DomAdvGlobalPrizeView:onEnter()
	DomAdvGlobalPrizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = DomainAdventureController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._scene = SceneMgr.instance:getCurScene()
	self._domAdvMo = DomainAdventureController.instance:getDomAdvMo(self._activityId)

	self.addGEvent(self, GlobalNotify.DomainAdventureSceneMapDataUpdate, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DomainAdventureGainGlobalPrizeRes, self._onUpdate, self)
	self:_onUpdate()
end

function DomAdvGlobalPrizeView:onExit()
	DomAdvGlobalPrizeView.super.onExit(self)
	self:_onClearPrizeCol()
end

function DomAdvGlobalPrizeView:_onUpdate()
	self:_onUpdatePrizeCol()
end

function DomAdvGlobalPrizeView:_onUpdatePrizeCol()
	local dataList = DomainAdventureConfig.instance:getGlobalPrizeCfg(self._activityId) or {}
	local curProgress = self:_getCurProgress()
	local sliderComp = self._sliderComp
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 1

	for idx, data in ipairs(dataList) do
		index = idx

		if self:_isCanGetPrize(data) then
			break
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToBegin(index - 1, false)

	local maxData = dataList[#dataList]
	local maxProgress = maxData and self:_getProgressByData(maxData) or 0

	self._txtCount.text = curProgress < maxProgress and string.format("<color=#20b376>%s</color>/%s", curProgress, maxProgress) or string.format("%s/%s", curProgress, maxProgress)

	local costItem = DomainAdventureConfig.instance:getCostItem(self._activityId)
	local maxCost = DomainAdventureController.instance:getMaxCostStrengthInPirze(self._activityId)
	local curCost = DomainAdventureController.instance:getTotalCostStrength(self._activityId)

	self._txtCost.text = curCost < maxCost and string.format("<color=#0083e7>%s</color>/%s", Mathf.Min(curCost, maxCost), maxCost) or string.format("%s/%s", Mathf.Min(curCost, maxCost), maxCost)

	local matName = MaterialMgr.getMaterialsNameByCfg(costItem)

	self._txtTips.text = string.format(self._tipsStr, maxCost, matName)
end

function DomAdvGlobalPrizeView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function DomAdvGlobalPrizeView:_getProgressByData(data)
	return data.occupiedGridCount
end

function DomAdvGlobalPrizeView:_getPrizeIdByData(data)
	return data.prizeId
end

function DomAdvGlobalPrizeView:_getPrizeStrByData(data)
	return data.prize
end

function DomAdvGlobalPrizeView:_getCurProgress()
	return self._domAdvMo:getOccupiedGlobalBlockNum()
end

function DomAdvGlobalPrizeView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._domAdvMo:isGainGlobalPrize(prizeId)
end

function DomAdvGlobalPrizeView:_isEnoughGet(data)
	return self:_getCurProgress() >= self:_getProgressByData(data)
end

function DomAdvGlobalPrizeView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return DomainAdventureController.instance:isCanGetGlobalPrize(self._activityId, prizeId)
end

function DomAdvGlobalPrizeView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local isEnoughGet = self:_isEnoughGet(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local scrollRect = self._prizeScrollRect
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local imgGain = goutil.findChild(mainGo, "imgGain")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local imgDot = goutil.findChild(mainGo, "imgDot")
	local txtProgress = goutil.findChildTextComponent(mainGo, "txtProgress")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	MaterialMgr.setCellByCfg(prizeStr, item)

	txtProgress.text = progress

	GameUtil.SetActive(imgGain, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	txtName.text = MaterialMgr.getMaterialsNameByCfg(prizeStr)
	self._prizeEffPool = self._prizeEffPool or {}

	UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])

	if isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(scrollRect)
			eff:setParent(effectRoot.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._prizeEffPool[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effectRoot, 0, 0, true, false, nil, func, nil)
	end

	GameUtil.setUIImageSpriteIdx(imgDot, isEnoughGet and 1 or 0)
	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
	GameUtil.addClickHandler(mainGo, function()
		local result, tips = DomainAdventureController.instance:getTryGetGlobalPrizeResultAndTips(self._activityId, prizeId)

		FloatWordMgr.instance:show(tips)
	end, self)
end

function DomAdvGlobalPrizeView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)
	GameUtil.rmClickHandler(mainGo)

	if self._prizeEffPool then
		UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])
	end
end

function DomAdvGlobalPrizeView:_onClickPrizeGet(data)
	local prizeId = self:_getPrizeIdByData(data)
	local result, tips = DomainAdventureController.instance:getTryGetGlobalPrizeResultAndTips(self._activityId, prizeId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	DomainAdventureController.instance:sendPM_DomainAdventureGainGlobalPrizeReq(self._activityId, prizeId)
end

return DomAdvGlobalPrizeView
