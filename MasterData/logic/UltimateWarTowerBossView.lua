-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarTowerBossView.lua

module("logic.extensions.ultimatewar.view.UltimateWarTowerBossView", package.seeall)

local UltimateWarTowerBossView = class("UltimateWarTowerBossView", ViewComponent)

function UltimateWarTowerBossView:buildUI()
	UltimateWarTowerBossView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClg = self:getGo("btnClg/btn")
	self._con = self:getGo("con")
	self._txtDescInfo = self:getTxt("infoCol/txtDesc")

	local rankScrView = self:getGo("ruleCol/rankScrView")
	local rankScrCell = self:getGo("ruleCol/rankScrCell")

	self._rankScrollList = ScrollerList.create(rankScrView, rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._emptyGo = self:getGo("ruleCol/emptyGo")
	self._btnDetailRank = self:getGo("ruleCol/btnDetail")
	self._prizeCol = self:getGo("prizeCol")
	self._prizeScrollerview = self:getGo("prizeCol/scrView")
	self._prizeScrollercell = self:getGo("prizeCol/scrCell")
	self._progressBar = self:getGo("prizeCol/scrView/Viewport/Content/progressBar")
	self._sliderComp = self:getSlider("prizeCol/scrView/Viewport/Content/progressBar")
	self._prizeCol_total_txtNum = self:getTxt("prizeCol/total/txtNum")
	self._prizeScrollerList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function UltimateWarTowerBossView:bindEvents()
	UltimateWarTowerBossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnDetailRank, self._onClickBtnDetailRank, self)
end

function UltimateWarTowerBossView:unbindEvents()
	UltimateWarTowerBossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnDetailRank)
end

function UltimateWarTowerBossView:onEnter()
	UltimateWarTowerBossView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = UltimateWarController.instance:getActivityType()

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._rankType = UltimateWarEnum.RankType_TowerBoss
	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)
	self._actData = UltimateWarConfig.instance:getActData(self._activityId)
	self._rankList = {}
	self._myRank = 0

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarGetMainInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarSecondStepInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarRankViewRes, self._handlePM_UltimateWarRankViewRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarGainTowerBossPrizeRes, self._handlePM_UltimateWarGainTowerBossPrizeRes, self)
	UltimateWarController.instance:sendPM_UltimateWarSecondStepInfoReq(self._activityId)
	UltimateWarController.instance:sendPM_UltimateWarRankViewReq(self._activityId, self._rankType)
end

function UltimateWarTowerBossView:onExit()
	UltimateWarTowerBossView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self:_onClear()
end

function UltimateWarTowerBossView:_handlePM_UltimateWarRankViewRes(msg)
	if msg.activityId ~= self._activityId or msg.type ~= self._rankType then
		return
	end

	self._rankList = msg.rankList
	self._myRank = msg.myRank

	self:_onUpdateRuleColUI()
end

function UltimateWarTowerBossView:_handlePM_UltimateWarGainTowerBossPrizeRes()
	self:_onUpdate()
end

function UltimateWarTowerBossView:_handlePM_UltimateWarSubmitTowerBossFormRes()
	UltimateWarController.instance:sendPM_UltimateWarRankViewReq(self._activityId, self._rankType)
end

function UltimateWarTowerBossView:_onSetUI()
	self._txtDescInfo.text = UltimateWarConfig.instance:getTowerBossBuffDesc(self._activityId)

	local creepsMasterId = UltimateWarConfig.instance:getTowerBossCreepsMasterId(self._activityId)
	local creepsCfg = UltimateWarConfig.instance:getCreepsData(creepsMasterId)
	local skinId = checknumber(creepsCfg[1].faceId)

	if skinId <= 0 then
		skinId = checknumber(creepsCfg[1].raceId)
	end

	local displayBagOffset = CharactorFacade.instance:getCommonLiHuiUIPosAndScale(skinId)

	if not displayBagOffset[3] then
		local x, y, scale = checknumber(displayBagOffset[1]), checknumber(displayBagOffset[2]), 1

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, displayBagOffset[3], nil, true, x, y)
	end
end

function UltimateWarTowerBossView:_onUpdate()
	self:_onUpdatePrizeCol()
	self:_onUpdateRuleColUI()
end

function UltimateWarTowerBossView:_onClear()
	self:_onClearPrizeCol()
	self:_onClearRuleCol()
end

function UltimateWarTowerBossView:_onUpdateRuleColUI()
	self._rankScrollList:reloadData(self._rankList)

	local isEmpty = #self._rankList <= 0

	GameUtil.SetActive(self._emptyGo, isEmpty)
end

function UltimateWarTowerBossView:_onClearRuleCol()
	self._rankScrollList:dispose()
end

function UltimateWarTowerBossView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local rank = info.rank
	local headInfo = info.headInfo
	local name = headInfo.userName
	local value = info.value
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")

	txtRank.text = info.rank

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtName.text = name
	txtScore.text = value
end

function UltimateWarTowerBossView:_clearRankCell(cell)
	return
end

function UltimateWarTowerBossView:_onUpdatePrizeCol()
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

function UltimateWarTowerBossView:_onClearPrizeCol()
	self._prizeScrollerList:dispose()
end

function UltimateWarTowerBossView:_getProgressDataList()
	return UltimateWarConfig.instance:getDamagePrizeCfg(self._activityId) or {}
end

function UltimateWarTowerBossView:_getSliderComp()
	return self._sliderComp
end

function UltimateWarTowerBossView:_getScrollRect()
	return self._prizeScrollerview:GetComponent(ComponentType.ScrollRect)
end

function UltimateWarTowerBossView:_getCurProgress()
	return self._ultimateWarMo:getBossMaxDamageInSecond()
end

function UltimateWarTowerBossView:_getProgressByData(data)
	return data.damage
end

function UltimateWarTowerBossView:_getPrizeIdByData(data)
	return data.prizeId
end

function UltimateWarTowerBossView:_getPrizeStrByData(data)
	return data.prize
end

function UltimateWarTowerBossView:_isHasGainPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._ultimateWarMo:isHasGainPrizeInTowerBoss(prizeId)
end

function UltimateWarTowerBossView:_isEnoughGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._ultimateWarMo:isEnoughPrizeInTowerBoss(prizeId)
end

function UltimateWarTowerBossView:_isCanGetPrize(data)
	local prizeId = self:_getPrizeIdByData(data)

	return self._ultimateWarMo:isCanGetPrizeInTowerBoss(prizeId)
end

function UltimateWarTowerBossView:_updatePrizeCell(view, cell, data, tag)
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

function UltimateWarTowerBossView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)

	if self._prizeEffPool then
		UIEffectManager.instance:stopEffect(self._prizeEffPool[mainGo])
	end
end

function UltimateWarTowerBossView:_onClickPrizeGet(data)
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

	UltimateWarController.instance:sendPM_UltimateWarGainTowerBossPrizeReq(self._activityId, 2, -1, prizeIdList)
end

function UltimateWarTowerBossView:_onClickBtnClg()
	if not UltimateWarController.instance:isInActivityTime(self._activityId) then
		FloatWordMgr.instance:show("不在活动时间范围内")

		return
	end

	if not self._ultimateWarMo:isPassAllTower() then
		FloatWordMgr.instance:show("通关所有元素塔后开启")

		return
	end

	UltimateWarController.instance:enterBattleTowerBoss(self._activityId)
end

function UltimateWarTowerBossView:_onClickBtnDetailRank()
	UltimateWarController.instance:openCommonTabRank(self._activityId, ViewName.UltimateWarTowerBossRankChildView)
end

return UltimateWarTowerBossView
