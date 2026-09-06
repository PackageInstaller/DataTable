-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarTowerStageView.lua

module("logic.extensions.ultimatewar.view.UltimateWarTowerStageView", package.seeall)

local UltimateWarTowerStageView = class("UltimateWarTowerStageView", ViewComponent)

function UltimateWarTowerStageView:buildUI()
	UltimateWarTowerStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClg = self:getGo("btnClg/btn")
	self._con = self:getGo("con")
	self._contentTop = self:getGo("topPlayerl/content")
	self._headRootTop = self:getGo("topPlayerl/content/headRoot")
	self._txtNameTop = self:getTxt("topPlayerl/content/txtName")
	self._txtPassTimeTop = self:getTxt("topPlayerl/content/txtPassTime")
	self._emptyTop = self:getGo("topPlayerl/empty")
	self._txtDescInfo = self:getTxt("infoCol/txtDesc")
	self._prizeScrollerview = self:getGo("prizeCol/scrView")
	self._prizeScrollercell = self:getGo("prizeCol/scrCell")
	self._progressBar = self:getGo("prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total_txtNum = self:getTxt("prizeCol/total/txtNum")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function UltimateWarTowerStageView:bindEvents()
	UltimateWarTowerStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function UltimateWarTowerStageView:unbindEvents()
	UltimateWarTowerStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnClg)
end

function UltimateWarTowerStageView:onEnter()
	UltimateWarTowerStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._towerId = checknumber(params[2])
	self._activityType = UltimateWarController.instance:getActivityType()

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)
	self._towerInfo = self._ultimateWarMo:getTowerInfo(self._towerId)
	self._actData = UltimateWarConfig.instance:getActData(self._activityId)
	self._towerData = UltimateWarConfig.instance:getTowerData(self._activityId, self._towerId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarGetMainInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarSecondStepInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarGainTowerBossPrizeRes, self._onUpdate, self)
	UltimateWarController.instance:sendPM_UltimateWarSecondStepInfoReq(self._activityId)
end

function UltimateWarTowerStageView:onExit()
	UltimateWarTowerStageView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self:_onClear()
end

function UltimateWarTowerStageView:_onSetUI()
	self._txtDescInfo.text = self._towerData.buffDesc

	local skinId = self._towerData.skinId
	local displayBagOffset = CharactorFacade.instance:getCommonLiHuiUIPosAndScale(skinId)

	if not displayBagOffset[3] then
		local x, y, scale = checknumber(displayBagOffset[1]), checknumber(displayBagOffset[2]), 1

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, displayBagOffset[3], nil, true, x, y)
	end
end

function UltimateWarTowerStageView:_onUpdate()
	local record = self._towerInfo:getRecord()

	if not record:isEmpty() then
		local headInfo = record:getHeadInfo()

		HeadItemController.instance:setHeadCellByInfo(self._headRootTop, headInfo, true)

		self._txtNameTop.text = headInfo.userName

		local timeStamp = Mathf.Floor(record:getTime() / 1000)

		self._txtPassTimeTop.text = GameUtil.formatTimeStamp("%Y.%m.%d %H:%M:%S", timeStamp)
	else
		HeadItemController.instance:resetHeadCell(self._headRootTop)
	end

	GameUtil.SetActive(self._contentTop, not record:isEmpty())
	GameUtil.SetActive(self._emptyTop, record:isEmpty())
	self:_onUpdatePrizeCol()
end

function UltimateWarTowerStageView:_onClear()
	HeadItemController.instance:resetHeadCell(self._headRootTop)
	self:_onClearPrizeCol()
end

function UltimateWarTowerStageView:_onUpdatePrizeCol()
	local dataList = self:_getProgressDataList()
	local curProgress = self:_getCurProgress()
	local sliderComp = self:_getSliderComp()
	local scoreList = {}

	for _, data in ipairs(dataList) do
		table.insert(scoreList, self:_getProgressByData(data))
	end

	local index = 0

	for idx, data in ipairs(dataList) do
		if self:_isCanGetPrize(data) then
			index = idx

			break
		elseif self:_isHasGainPrize(data) then
			index = idx
		end
	end

	self._prizeScrollerList:reloadData(dataList)
	self._prizeScrollerList:updateUnderSlider(sliderComp, curProgress, scoreList)
	self._prizeScrollerList:MoveCellToCenter(index == -1 and 0 or index)

	self._prizeCol_total_txtNum.text = curProgress
end

function UltimateWarTowerStageView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function UltimateWarTowerStageView:_getProgressDataList()
	return UltimateWarConfig.instance:getStageCfg(self._activityId, self._towerId)
end

function UltimateWarTowerStageView:_getSliderComp()
	return self._sliderComp
end

function UltimateWarTowerStageView:_getScrollRect()
	return self._prizeScrollerview:GetComponent(ComponentType.ScrollRect)
end

function UltimateWarTowerStageView:_getCurProgress()
	return self._towerInfo:getMaxPassStageId()
end

function UltimateWarTowerStageView:_getProgressByData(data)
	return data.stageId
end

function UltimateWarTowerStageView:_getPrizeIdByData(data)
	return data.stageId
end

function UltimateWarTowerStageView:_getPrizeStrByData(data)
	return data.prize
end

function UltimateWarTowerStageView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._towerInfo:isHasGainPrize(prizeId)
end

function UltimateWarTowerStageView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._towerInfo:isEnoughPrize(prizeId)
end

function UltimateWarTowerStageView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._towerInfo:isCanGetPrize(prizeId)
end

function UltimateWarTowerStageView:_updatePrizeCell(view, cell, data, tag)
	local prizeId = self:_getPrizeIdByData(data)
	local isHasGain = self:_isHasGainPrize(data)
	local isCanGet = self:_isCanGetPrize(data)
	local progress = self:_getProgressByData(data)
	local prizeStr = self:_getPrizeStrByData(data)
	local scrollRect = self:_getScrollRect()
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local received = goutil.findChild(mainGo, "received")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local effectRoot = goutil.findChild(mainGo, "effectRoot")

	if not string.nilorempty(prizeStr) then
		MaterialMgr.setCellByCfg(prizeStr, item)
	else
		MaterialMgr.resetAll(item)
	end

	if txtScore then
		txtScore.text = progress
	end

	GameUtil.SetActive(received, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

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

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPrizeGet, self, data))
end

function UltimateWarTowerStageView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)

	if self._prizeEffPool then
		UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])
	end
end

function UltimateWarTowerStageView:_onClickPrizeGet(data)
	if self:_isHasGainPrize(data) then
		FloatWordMgr.instance:show("已领取")

		return
	end

	if not self:_isEnoughGetPrize(data) then
		FloatWordMgr.instance:show("未满足")

		return
	end

	local prizeIdList = {}
	local dataList = self:_getProgressDataList()

	for idx, data in ipairs(dataList) do
		if self:_isCanGetPrize(data) then
			table.insert(prizeIdList, self:_getPrizeIdByData(data))
		end
	end

	UltimateWarController.instance:sendPM_UltimateWarGainTowerBossPrizeReq(self._activityId, 1, self._towerId, prizeIdList)
end

function UltimateWarTowerStageView:_onClickBtnClg()
	if not UltimateWarController.instance:isInActivityTime(self._activityId) then
		FloatWordMgr.instance:show("不在活动时间范围内")

		return
	end

	if self._towerInfo:isPassTower() then
		FloatWordMgr.instance:show("已通关，无法再次挑战")

		return
	end

	UltimateWarController.instance:enterBattleTowerStage(self._activityId, self._towerId)
end

return UltimateWarTowerStageView
