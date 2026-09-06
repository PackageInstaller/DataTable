-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaFightMainView.lua

module("logic.extensions.tourarena.view.TourArenaFightMainView", package.seeall)

local TourArenaFightMainView = class("TourArenaFightMainView", ViewComponent)

function TourArenaFightMainView:buildUI()
	TourArenaFightMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._ScrollRect = goutil.findChild(self.mainGO, "sliderCol/ScrollRect")
	self._progressBar = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content/progressBar")
	self._content = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content")
	self._gridView = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content/gridView")
	self._gridCell = goutil.findChild(self.mainGO, "sliderCol/ScrollRect/ViewPort/Content/gridCell")
	self._sliderCol_total_txtNum = goutil.findChildTextComponent(self.mainGO, "sliderCol/total/txtNum")
	self._sliderCol_total_icon = goutil.findChild(self.mainGO, "sliderCol/total/icon")

	local exParams = {
		Content = self._content,
		cellGroup = self._gridView,
		progressBar = self._progressBar
	}

	self._progressList = ProgressList.create(self._ScrollRect, self._gridCell, GameUtil.handler(self._updateProgressGrid, self), GameUtil.handler(self._clearProgressCell, self), exParams)
	self._periodProgressList = ProgressList.create(self._ScrollRect, self._gridCell, GameUtil.handler(self._updatePeriodProgressGrid, self), GameUtil.handler(self._clearPeriodProgressCell, self), exParams)
	self._rankCol = goutil.findChild(self.mainGO, "rankCol")
	self._rankView = goutil.findChild(self.mainGO, "rankCol/rankView/Viewport/Content")
	self._rankCell = goutil.findChild(self.mainGO, "rankCol/rankCell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")

	GameUtil.SetActive(self._rankCell, false)

	self._fightCol = goutil.findChild(self.mainGO, "fightCol")
	self._fightView = goutil.findChild(self.mainGO, "fightCol/tableview")
	self._fightCell = goutil.findChild(self.mainGO, "fightCol/fightCell")
	self._tableviewFight = ScrollerList.create(self._fightView, self._fightCell, GameUtil.handler(self._updateCellFight, self), GameUtil.handler(self._clearCellFight, self))
end

function TourArenaFightMainView:bindEvents()
	TourArenaFightMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "TOURARENAFIGHT_JUMP_KEY_1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "TOURARENAFIGHT_JUMP_KEY_2"))
end

function TourArenaFightMainView:unbindEvents()
	TourArenaFightMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
end

function TourArenaFightMainView:onEnter()
	TourArenaFightMainView.super.onEnter(self)

	self._activityId = TourArenaController.instance:getActivityIdOfFight()
	self._activityType = TourArenaController.instance:getActivityTypeOfFight()

	local isInTime = TourArenaController.instance:isInActivityTimeOfFight(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = TourArenaFightConfig.instance:getTafActData(self._activityId)
	self._periodId = self._actData.periodId
	self._termId = self._actData.zoneTermId
	self._isNeedCheckZone = true
	self._mainViewRankZoneId = checknumber(self._actData.mainViewRankZoneId)
	self._arenaFightMo = TourArenaController.instance:getTourArenaFightMo(self._activityId)
	self._isUsePeriodMode = TourArenaController.instance:isUsePeriodMode(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.TourArenaFightInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TourArenaZoneInfoRes, self._handleTourArenaZoneInfoRes, self)
	self.addGEvent(self, GlobalNotify.TourArenaFightGainPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_IF_FORMULATASKRES, self._handleGainTaskPrizeRes, self)
	self.addGEvent(self, GlobalNotify.TourArenaFightTotalRankRes, self._onUpdateRankColUI, self)
	self.addGEvent(self, GlobalNotify.TourArenaPeriodRankRes, self._onUpdateRankColUI, self)
	self.addGEvent(self, GlobalNotify.TourArenaFightGainPeriodPrizeRes, self._onUpdate, self)

	local key = string.format("%s", self._activityId)

	local function firstCallback()
		self:_onClickBtnTip()
	end

	GameUtil.doCallbackWhenFirst(key, firstCallback, nil)
	self:_sendFightInfoReq()
	TourArenaController.instance:sendPM_TourArenaZoneInfoReq(self._termId)

	if self._isUsePeriodMode then
		TourArenaController.instance:sendPM_TourArenaPeriodRankReq(self._activityId)
	elseif self._mainViewRankZoneId > 0 then
		TourArenaController.instance:sendPM_TourArenaFightTotalRankReq(self._activityId, self._mainViewRankZoneId)
	end
end

function TourArenaFightMainView:onExit()
	TourArenaFightMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol_btnJump1_redPoint)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol_btnJump2_redPoint)
	MaterialMgr.resetAll(self._sliderCol_total_icon)
	self:_onClear()
end

function TourArenaFightMainView:_handleTourArenaZoneInfoRes(msg)
	if not self._isNeedCheckZone then
		return
	end

	local termId = msg.termId
	local zoneId = checknumber(msg.zoneId)

	if termId ~= self._termId then
		return
	end

	self._isNeedCheckZone = false

	if zoneId == 0 then
		UIStateManager.instance:push(ViewName.TourArenaSelectView, termId)
	end
end

function TourArenaFightMainView:_handleGainTaskPrizeRes(msg)
	if msg == nil then
		return
	end

	if msg.activityId ~= self._activityId then
		return
	end

	self:_sendFightInfoReq()
end

function TourArenaFightMainView:_sendFightInfoReq()
	TourArenaController.instance:sendPM_TourArenaFightInfoReq(self._activityId)
end

function TourArenaFightMainView:_onSetUI()
	local startStamp, endStamp = 0, 0

	if self._activityId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end

	local redId = TourArenaFightConfig.instance:getClientCommonValue(self._activityId, "TOURARENAFIGHT_JUMP_RED_1")

	if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
		RedPointController.instance:regRedPoint(self._jumpBtnCol_btnJump1_redPoint, redId)
	end

	local redId = TourArenaFightConfig.instance:getClientCommonValue(self._activityId, "TOURARENAFIGHT_JUMP_RED_2")

	if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
		RedPointController.instance:regRedPoint(self._jumpBtnCol_btnJump2_redPoint, redId)
	end

	local matId = self._actData.collectItemId

	MaterialMgr.setIcon(self._sliderCol_total_icon, MatType.ACTIVITY_ITEM, matId, nil, nil)
end

function TourArenaFightMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TourArenaFightMainView:_onClear()
	self:_onClearSliderCol()
	self:_onClearPeriodSliderCol()
	self:_onClearRankCol()
	self:_onClearFightCol()
end

function TourArenaFightMainView:_onUpdateData()
	return
end

function TourArenaFightMainView:_onUpdateUI()
	self:_onClearSliderCol()
	self:_onClearPeriodSliderCol()

	local isUsePeriodMode = TourArenaController.instance:isUsePeriodMode(self._activityId)

	if isUsePeriodMode then
		self:_onUpdatePeriodSliderColUI()
	else
		self:_onUpdateSliderColUI()
	end

	self:_onUpdateRankColUI()
	self:_onUpdateFightColUINew()
end

function TourArenaFightMainView:_onUpdateSliderColUI()
	local prizeCfg = self:getPrizeCfg()
	local curProgress = self:getCurProgress()
	local maxProgress = self:getMaxProgress()

	self._sliderCol_total_txtNum.text = maxProgress <= curProgress and curProgress or curProgress

	self._progressList:reloadDataList(prizeCfg)
	self._progressList:updateCell()

	local proList = {}

	for _, data in ipairs(prizeCfg) do
		table.insert(proList, self:getProgress(data.prizeId))
	end

	self._progressList:updateProgressByList(proList, curProgress)

	local index = 0

	for idx, data in ipairs(prizeCfg) do
		if self:isCanGetPrize(data.prizeId) then
			index = idx

			break
		end
	end

	if index ~= 0 then
		self._progressList:rollToIdx(index)
	else
		self._progressList:rollToIdxNewest(proList, curProgress)
	end
end

function TourArenaFightMainView:_onClearSliderCol()
	self._progressList:dispose()
end

function TourArenaFightMainView:_updateProgressGrid(go, data, idx)
	local prizeId = data.prizeId
	local mainGo = go
	local item = goutil.findChild(mainGo, "item/itemcell")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
	local effectParent = goutil.findChild(mainGo, "effect")
	local isHasGain = self:isHasGainPrize(prizeId)
	local isCanGet = self:isCanGetPrize(prizeId)
	local prizeStr = self:getPrizeStr(prizeId)

	if not string.nilorempty(prizeStr) then
		MaterialMgr.setCellByCfg(prizeStr, item)
	else
		MaterialMgr.resetAll(item)
	end

	if txtNum then
		txtNum.text = self:getProgress(prizeId)
	end

	GameUtil.SetActive(receivedGo, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	self._gridEffList = self._gridEffList or {}

	UIEffectManager.instance:stopEffect(self._gridEffList[mainGo])

	self._gridEffList[mainGo] = nil

	if isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(self._ScrollRect:GetComponent(ComponentType.ScrollRect))
			eff:setParent(effectParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._gridEffList[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effectParent, 0, 0, true, false, nil, func, nil)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGridCell, self, data))
end

function TourArenaFightMainView:_clearProgressCell(go, data, idx)
	local mainGo = go
	local item = goutil.findChild(mainGo, "item/itemcell")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)

	if self._gridEffList[mainGo] then
		UIEffectManager.instance:stopEffect(self._gridEffList[mainGo])

		self._gridEffList[mainGo] = nil
	end
end

function TourArenaFightMainView:_onClickGridCell(data)
	local result, tips = self._arenaFightMo:getTryGainPrizeOfProResultAndTips(data.prizeId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	TourArenaController.instance:sendPM_TourArenaFightGainPrizeReq(self._activityId, data.prizeId)
end

function TourArenaFightMainView:getPrizeCfg()
	return TourArenaFightConfig.instance:getTafPrizeCfg(self._activityId)
end

function TourArenaFightMainView:getPrizeStr(prizeId)
	local data = TourArenaFightConfig.instance:getTafPrizeData(self._activityId, prizeId)

	return data and data.prize
end

function TourArenaFightMainView:isCanGetPrize(prizeId)
	return self._arenaFightMo:isCanGetPrize(prizeId)
end

function TourArenaFightMainView:isHasGainPrize(prizeId)
	return self._arenaFightMo:isHasGainPrize(prizeId)
end

function TourArenaFightMainView:getCurProgress()
	return self._arenaFightMo:getCurProgress()
end

function TourArenaFightMainView:getProgress(prizeId)
	local data = TourArenaFightConfig.instance:getTafPrizeData(self._activityId, prizeId)

	return (data or nil) and (data.score or 0)
end

function TourArenaFightMainView:getMaxProgress()
	return self._arenaFightMo:getMaxProgress()
end

function TourArenaFightMainView:_onUpdatePeriodSliderColUI()
	local prizeCfg = self:getPeriodPrizeCfg()
	local curProgress = self:getCurPeriodProgress()
	local maxProgress = self:getMaxPeriodProgress()

	self._sliderCol_total_txtNum.text = maxProgress <= curProgress and curProgress or curProgress

	self._periodProgressList:reloadDataList(prizeCfg)
	self._periodProgressList:updateCell()

	local proList = {}

	for _, data in ipairs(prizeCfg) do
		table.insert(proList, self:getPeriodProgress(data.prizeId))
	end

	self._periodProgressList:updateProgressByList(proList, curProgress)

	local index = 0

	for idx, data in ipairs(prizeCfg) do
		if self:isCanGetPeriodPrize(data.prizeId) then
			index = idx

			break
		end
	end

	if index ~= 0 then
		self._periodProgressList:rollToIdx(index)
	else
		self._periodProgressList:rollToIdxNewest(proList, curProgress)
	end
end

function TourArenaFightMainView:_onClearPeriodSliderCol()
	self._periodProgressList:dispose()
end

function TourArenaFightMainView:_updatePeriodProgressGrid(go, data, idx)
	local prizeId = data.prizeId
	local mainGo = go
	local item = goutil.findChild(mainGo, "item/itemcell")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local btnGet = goutil.findChild(mainGo, "btnGet")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
	local effectParent = goutil.findChild(mainGo, "effect")
	local isHasGain = self:isHasGainPeriodPrize(prizeId)
	local isCanGet = self:isCanGetPeriodPrize(prizeId)
	local prizeStr = self:getPeriodPrizeStr(prizeId)

	if not string.nilorempty(prizeStr) then
		MaterialMgr.setCellByCfg(prizeStr, item)
	else
		MaterialMgr.resetAll(item)
	end

	if txtNum then
		txtNum.text = self:getPeriodProgress(prizeId)
	end

	GameUtil.SetActive(receivedGo, isHasGain)
	GameUtil.SetActive(btnGet, isCanGet)

	self._gridEffList = self._gridEffList or {}

	UIEffectManager.instance:stopEffect(self._gridEffList[mainGo])

	self._gridEffList[mainGo] = nil

	if isCanGet == true then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setScrollRectClipping(self._ScrollRect:GetComponent(ComponentType.ScrollRect))
			eff:setParent(effectParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		self._gridEffList[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effectParent, 0, 0, true, false, nil, func, nil)
	end

	GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickPeriodGridCell, self, data))
end

function TourArenaFightMainView:_clearPeriodProgressCell(go, data, idx)
	local mainGo = go
	local item = goutil.findChild(mainGo, "item/itemcell")
	local btnGet = goutil.findChild(mainGo, "btnGet")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnGet)

	if self._gridEffList[mainGo] then
		UIEffectManager.instance:stopEffect(self._gridEffList[mainGo])

		self._gridEffList[mainGo] = nil
	end
end

function TourArenaFightMainView:_onClickPeriodGridCell(data)
	local result, tips = self._arenaFightMo:getTryGainPeriodPrizeOfProResultAndTips(data.prizeId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	TourArenaController.instance:sendPM_TourArenaFightGainPeriodPrizeReq(self._activityId, data.prizeId)
end

function TourArenaFightMainView:getPeriodPrizeCfg()
	return TourArenaFightConfig.instance:getTafPeriodPrizeCfg(self._periodId)
end

function TourArenaFightMainView:getPeriodPrizeStr(prizeId)
	local data = TourArenaFightConfig.instance:getTafPeriodPrizeData(self._periodId, prizeId)

	return data and data.prize
end

function TourArenaFightMainView:isCanGetPeriodPrize(prizeId)
	return self._arenaFightMo:isCanGetPeriodPrize(prizeId)
end

function TourArenaFightMainView:isHasGainPeriodPrize(prizeId)
	return self._arenaFightMo:isHasGainPeriodPrize(prizeId)
end

function TourArenaFightMainView:getCurPeriodProgress()
	return self._arenaFightMo:getCurPeriodProgress()
end

function TourArenaFightMainView:getPeriodProgress(prizeId)
	local data = TourArenaFightConfig.instance:getTafPeriodPrizeData(self._periodId, prizeId)

	return (data or nil) and (data.score or 0)
end

function TourArenaFightMainView:getMaxPeriodProgress()
	return self._arenaFightMo:getMaxPeriodProgress()
end

function TourArenaFightMainView:_onUpdateRankColUI()
	local parentTran = self._rankView.transform
	local childGo = self._rankCell
	local rankInfoList = {}

	if self._isUsePeriodMode then
		local msg = self._arenaFightMo:getPeriodRankResMsg()

		if msg then
			for idx, v in ipairs(msg.infoList) do
				if idx > 10 then
					break
				end

				local info = {}

				info.headInfo = v.headInfo
				info.userName = v.headInfo.userName
				info.areaName = v.headInfo.areaName
				info.score = v.value
				info.rank = v.rank

				table.insert(rankInfoList, info)
			end
		end
	elseif self._mainViewRankZoneId > 0 then
		local zoneId = self._mainViewRankZoneId
		local msg = self._arenaFightMo:_getTotalRankResMsg(zoneId)

		if msg then
			for idx, v in ipairs(msg.rankInfos) do
				if idx > 10 then
					break
				end

				local info = {}

				info.areaName = v.rankInfos.headInfo.areaName
				info.headInfo = v.rankInfos.headInfo
				info.userName = v.rankInfos.headInfo.userName
				info.score = v.rankInfos.value
				info.rank = v.rankInfos.rank

				table.insert(rankInfoList, info)
			end
		end
	else
		local zoneIdList = self._arenaFightMo:getZoneIdListOfRankFirstInfo()

		for _, zoneId in ipairs(zoneIdList) do
			local commonRankInfo = self._arenaFightMo:getCommonRankInfoOfZoneRankFirst(zoneId)
			local zoneData = TourArenaZoneConfig.instance:getTazData(zoneId)
			local info = {}

			info.areaName = zoneData and zoneData.name
			info.headInfo = commonRankInfo.rankInfos.headInfo
			info.userName = commonRankInfo.rankInfos.headInfo.userName
			info.score = commonRankInfo.rankInfos.value
			info.rank = commonRankInfo.rankInfos.rank

			table.insert(rankInfoList, info)
		end
	end

	local childCount = #rankInfoList
	local children = GameUtil.getChildren(parentTran)

	for index, mainGo in ipairs(children) do
		GameUtil.SetActive(mainGo, index <= childCount)
	end

	for index = 1, childCount do
		local mainGo = children[index]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, index))
		end

		GameUtil.SetActive(mainGo, true)
		self:_updateRankCell(mainGo, rankInfoList[index], index)
	end

	GameUtil.SetActive(self._emptyGo, #rankInfoList <= 0)
end

function TourArenaFightMainView:_onClearRankCol()
	local children = GameUtil.getChildren(self._rankView.transform)

	for index, mainGo in ipairs(children) do
		self:_clearRankCell(mainGo)
	end
end

function TourArenaFightMainView:_updateRankCell(mainGo, info, index)
	local headInfo = info.headInfo
	local areaName = info.areaName
	local score = info.score
	local rank = info.rank
	local headcell = goutil.findChild(mainGo, "headcell")
	local txtPlayerName = goutil.findChildTextComponent(mainGo, "txtPlayerName")
	local aren_txt = goutil.findChildTextComponent(mainGo, "aren/txt")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local imgRank = goutil.findChild(mainGo, "imgRank")
	local rankGo = goutil.findChild(mainGo, "rankGo")
	local rankGo_txt = goutil.findChildTextComponent(mainGo, "rankGo/txt")

	HeadItemController.instance:setHeadCellByInfo(headcell, headInfo, true)

	txtPlayerName.text = headInfo.userName
	aren_txt.text = areaName
	txtScore.text = score

	local isTop3 = checknumber(rank) <= 3

	GameUtil.SetActive(imgRank, isTop3)
	GameUtil.SetActive(rankGo, not isTop3)

	if isTop3 then
		GameUtil.setUIImageSpriteIdx(imgRank, rank - 1)
	else
		rankGo_txt.text = rank
	end
end

function TourArenaFightMainView:_clearRankCell(mainGo)
	local headcell = goutil.findChild(mainGo, "headcell")

	HeadItemController.instance:resetHeadCell(headcell)
end

function TourArenaFightMainView:_onUpdateFightColUINew()
	local cfg = TourArenaFightConfig.instance:getTafTypeCfg(self._activityId)

	self._tableviewFight:reloadData(cfg)
end

function TourArenaFightMainView:_onUpdateFightColUI()
	local parentTran = self._fightView.transform
	local childGo = self._fightCell
	local cfg = TourArenaFightConfig.instance:getTafTypeCfg(self._activityId)
	local childCount = #cfg
	local children = GameUtil.getChildren(parentTran)

	for index, mainGo in ipairs(children) do
		GameUtil.SetActive(mainGo, index <= childCount)
	end

	for index, data in ipairs(cfg) do
		local mainGo = children[index]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, index))
		end

		GameUtil.SetActive(mainGo, true)
		self:_updateFightCell(mainGo, data.typeId, index)
	end
end

function TourArenaFightMainView:_onClearFightCol()
	self._tableviewFight:dispose()
end

function TourArenaFightMainView:_updateFightCell(mainGo, typeId, index)
	local typeData = TourArenaFightConfig.instance:getTafTypeData(self._activityId, typeId)
	local imgBg = goutil.findChild(mainGo, "imgBg")
	local goLock = goutil.findChild(mainGo, "lock")
	local goOver = goutil.findChild(mainGo, "over")
	local txtOpenDate = goutil.findChildTextComponent(mainGo, "lock/txtOpenDate")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local path = typeData.picturePath

	self:_loadBigBg(imgBg, path, true)
	GameUtil.SetActive(goLock, false)
	GameUtil.SetActive(goOver, false)
	GameUtil.SetGray(imgBg, false)

	local timeNow = ServerTime.now()
	local openTimeStr = typeData.openTime

	if not GameUtil.isEmptyString(openTimeStr) then
		local dateOpen = GameUtil.string2date(openTimeStr)
		local timeOpen = GameUtil.string2time(openTimeStr)

		if timeNow <= timeOpen then
			GameUtil.SetGray(imgBg, true)

			txtOpenDate.text = string.format("%02d.%02d开启", dateOpen.month, dateOpen.day)

			GameUtil.SetActive(goLock, true)
		end
	end

	txtName.text = typeData.name

	local endTimeStr = typeData.endTime

	if not GameUtil.isEmptyString(endTimeStr) then
		local timeEnd = GameUtil.string2time(endTimeStr)

		if timeEnd <= timeNow then
			GameUtil.SetGray(imgBg, true)
			GameUtil.SetActive(goOver, true)
		end
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickFightCell, self, typeId))
end

function TourArenaFightMainView:_onClickFightCell(typeId)
	local typeData = TourArenaFightConfig.instance:getTafTypeData(self._activityId, typeId)
	local timePeriod = GameUtil.getTimePeriod(typeData.openTime, typeData.endTime)

	if timePeriod == GameUtil.inTimePeriod then
		GotoMgr.gotoByString(typeData.jumpStr)
	elseif timePeriod == GameUtil.beforeTimePeriod then
		FloatWordMgr.instance:show("活动未开启")
	elseif timePeriod == GameUtil.afterTimePeriod then
		FloatWordMgr.instance:show("活动已结束")
	end
end

function TourArenaFightMainView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = GameUrl.getBigbgPngUrl(path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function TourArenaFightMainView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function TourArenaFightMainView:_updateCellFight(view, cellGo, data)
	local typeData = data
	local imgBg = goutil.findChild(cellGo, "imgBg")
	local goLock = goutil.findChild(cellGo, "lock")
	local goOver = goutil.findChild(cellGo, "over")
	local txtOpenDate = goutil.findChildTextComponent(cellGo, "lock/txtOpenDate")
	local txtName = goutil.findChildTextComponent(cellGo, "txtName")
	local path = typeData.picturePath

	self:_loadBigBg(imgBg, path, true)
	GameUtil.SetActive(goLock, false)
	GameUtil.SetActive(goOver, false)
	GameUtil.SetGray(imgBg, false)

	local timeNow = ServerTime.now()
	local openTimeStr = typeData.openTime

	if not GameUtil.isEmptyString(openTimeStr) then
		local dateOpen = GameUtil.string2date(openTimeStr)
		local timeOpen = GameUtil.string2time(openTimeStr)

		if timeNow <= timeOpen then
			GameUtil.SetGray(imgBg, true)

			txtOpenDate.text = string.format("%02d.%02d开启", dateOpen.month, dateOpen.day)

			GameUtil.SetActive(goLock, true)
		end
	end

	txtName.text = typeData.name

	local endTimeStr = typeData.endTime

	if not GameUtil.isEmptyString(endTimeStr) then
		local timeEnd = GameUtil.string2time(endTimeStr)

		if timeEnd <= timeNow then
			GameUtil.SetGray(imgBg, true)
			GameUtil.SetActive(goOver, true)
		end
	end

	GameUtil.addClickHandler(cellGo, GameUtil.handler(self._onClickFightCell, self, typeData.typeId))
end

function TourArenaFightMainView:_clearCellFight(cellGo)
	local imgBg = goutil.findChild(cellGo, "imgBg")

	self:_unLoadBigBg(imgBg)
	GameUtil.rmClickHandler(cellGo)
end

function TourArenaFightMainView:_onClickBtnJump(key)
	local jumpToStr = TourArenaFightConfig.instance:getClientCommonValue(self._activityId, key, false)

	GotoMgr.gotoByString(jumpToStr)
end

function TourArenaFightMainView:_onClickBtnTip()
	local key = TourArenaFightConfig.instance:getClientCommonValue(self._activityId, "TOURARENAFIGHT_RULE_MAIN_KEY", false)

	TipsFacade.instance:openRulesView(key)
end

return TourArenaFightMainView
