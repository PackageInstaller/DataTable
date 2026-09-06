-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaGameMainView.lua

module("logic.extensions.tourarena.view.TourArenaGameMainView", package.seeall)

local TourArenaGameMainView = class("TourArenaGameMainView", ViewComponent)

function TourArenaGameMainView:buildUI()
	TourArenaGameMainView.super.buildUI(self)

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
	self._rankCol = goutil.findChild(self.mainGO, "rankCol")
	self._rankView = goutil.findChild(self.mainGO, "rankCol/rankView/Viewport/Content")
	self._rankCell = goutil.findChild(self.mainGO, "rankCol/rankCell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")

	GameUtil.SetActive(self._rankCell, false)

	self._stageCol = goutil.findChild(self.mainGO, "stageCol")
	self._stageView = goutil.findChild(self.mainGO, "stageCol/stageView")
	self._stageCell = goutil.findChild(self.mainGO, "stageCol/stageCell")

	GameUtil.SetActive(self._stageCell, false)
end

function TourArenaGameMainView:bindEvents()
	TourArenaGameMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "TOURARENAGAME_JUMP_KEY_1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "TOURARENAGAME_JUMP_KEY_2"))
end

function TourArenaGameMainView:unbindEvents()
	TourArenaGameMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
end

function TourArenaGameMainView:onEnter()
	TourArenaGameMainView.super.onEnter(self)

	self._activityId = TourArenaController.instance:getActivityIdOfGame()
	self._activityType = TourArenaController.instance:getActivityTypeOfGame()

	local isInTime = TourArenaController.instance:isInActivityTimeOfGame(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actData = TourArenaGameConfig.instance:getTagActData(self._activityId)
	self._termId = self._actData.zoneTermId
	self._isNeedCheckZone = true
	self._mainViewRankZoneId = checknumber(self._actData.mainViewRankZoneId)
	self._arenaGameMo = TourArenaController.instance:getTourArenaGameMo(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.TourArenaGameUpdateView, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TourArenaGameInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TourArenaZoneInfoRes, self._handleTourArenaZoneInfoRes, self)
	self.addGEvent(self, GlobalNotify.TourArenaGameGainPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TourArenaGameEndGameRes, self._handleTourArenaGameEndGameRes, self)
	self.addGEvent(self, GlobalNotify.TourArenaGameTotalRankRes, self._onUpdateRankColUI, self)
	TourArenaController.instance:sendPM_TourArenaGameInfoReq(self._activityId)
	TourArenaController.instance:sendPM_TourArenaZoneInfoReq(self._termId)

	if self._mainViewRankZoneId > 0 then
		TourArenaController.instance:sendPM_TourArenaGameTotalRankReq(self._activityId, self._mainViewRankZoneId)
	end

	local key = string.format("%s", self._activityId)

	local function firstCallback()
		self:_onClickBtnTip()
	end

	GameUtil.doCallbackWhenFirst(key, firstCallback, nil)
	settimer(5, self._ticking, self)
end

function TourArenaGameMainView:onExit()
	TourArenaGameMainView.super.onExit(self)
	removetimer(self._ticking, self)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol_btnJump1_redPoint)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol_btnJump2_redPoint)
	UIEffectManager.instance:stopEffect(self._mainEff)
	self:_onClear()
end

function TourArenaGameMainView:_handleTourArenaZoneInfoRes(msg)
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

function TourArenaGameMainView:_handleTourArenaGameEndGameRes(msg)
	TourArenaController.instance:sendPM_TourArenaGameInfoReq(self._activityId)
end

function TourArenaGameMainView:_ticking()
	if self._gameStageInfos == nil then
		return
	end

	for _, info in ipairs(self._gameStageInfos) do
		if info.isInTime ~= self._arenaGameMo:isInTimePeriodOfGame(info.gameId) then
			GlobalDispatcher:dispatch(GlobalNotify.TourArenaGameUpdateView)

			break
		end
	end
end

function TourArenaGameMainView:_onSetUI()
	local startStamp, endStamp = 0, 0

	if self._activityId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end

	local redId = TourArenaGameConfig.instance:getClientCommonValue(self._activityId, "TOURARENAGAME_JUMP_RED_1")

	if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
		RedPointController.instance:regRedPoint(self._jumpBtnCol_btnJump1_redPoint, redId)
	end

	local redId = TourArenaGameConfig.instance:getClientCommonValue(self._activityId, "TOURARENAGAME_JUMP_RED_2")

	if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
		RedPointController.instance:regRedPoint(self._jumpBtnCol_btnJump2_redPoint, redId)
	end

	local effParent = self.mainGO
	local pathName = "20240403/3znyouxiwang/fx_ui_3znyouxiwang"

	UIEffectManager.instance:stopEffect(self._mainEff)

	if not goutil.isNil(effParent) and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._mainEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function TourArenaGameMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function TourArenaGameMainView:_onClear()
	if self._gameStageInfos then
		table.clear(self._gameStageInfos)

		self._gameStageInfos = nil
	end

	self:_onClearSliderCol()
	self:_onClearRankCol()
	self:_onClearStageCol()
end

function TourArenaGameMainView:_onUpdateData()
	self._gameStageInfos = {}

	local gameCfg = TourArenaGameConfig.instance:getTagGameCfg(self._activityId)

	for _, gameData in ipairs(gameCfg) do
		local gameId = gameData.gameId
		local info = {}

		info.gameId = gameId
		info.leftTimes = self._arenaGameMo:getLeftTimesOfGame(gameId)
		info.isIgnoreTimes = self._arenaGameMo:isIgnoreTimesOfGame(gameId)
		info.isInTime = self._arenaGameMo:isInTimePeriodOfGame(gameId)
		info.openDate = self._arenaGameMo:getFirstStageOpenTime(gameId)
		info.endDate = self._arenaGameMo:getLastStageEndTime(gameId)
		self._gameStageInfos[gameId] = info
	end
end

function TourArenaGameMainView:_onUpdateUI()
	self:_onUpdateSliderColUI()
	self:_onUpdateRankColUI()
	self:_onUpdateStageColUI()
end

function TourArenaGameMainView:_onUpdateSliderColUI()
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
		if self:isHasGainPrize(data.prizeId) then
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

function TourArenaGameMainView:_onClearSliderCol()
	self._progressList:dispose()
end

function TourArenaGameMainView:_updateProgressGrid(go, data, idx)
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

function TourArenaGameMainView:_clearProgressCell(go, data, idx)
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

function TourArenaGameMainView:_onClickGridCell(data)
	local result, tips = self._arenaGameMo:getTryGainPrizeOfProResultAndTips(data.prizeId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	TourArenaController.instance:sendPM_TourArenaGameGainPrizeReq(self._activityId, data.prizeId)
end

function TourArenaGameMainView:getPrizeCfg()
	return TourArenaGameConfig.instance:getTagPrizeCfg(self._activityId)
end

function TourArenaGameMainView:getPrizeStr(prizeId)
	local data = TourArenaGameConfig.instance:getTagPrizeData(self._activityId, prizeId)

	return data and data.prize
end

function TourArenaGameMainView:isCanGetPrize(prizeId)
	return self._arenaGameMo:isCanGetPrize(prizeId)
end

function TourArenaGameMainView:isHasGainPrize(prizeId)
	return self._arenaGameMo:isHasGainPrize(prizeId)
end

function TourArenaGameMainView:getCurProgress()
	return self._arenaGameMo:getCurProgress()
end

function TourArenaGameMainView:getProgress(prizeId)
	local data = TourArenaGameConfig.instance:getTagPrizeData(self._activityId, prizeId)

	return (data or nil) and (data.score or 0)
end

function TourArenaGameMainView:getMaxProgress()
	return self._arenaGameMo:getMaxProgress()
end

function TourArenaGameMainView:_onUpdateRankColUI()
	local parentTran = self._rankView.transform
	local childGo = self._rankCell
	local rankInfoList = {}

	if self._mainViewRankZoneId > 0 then
		local zoneId = self._mainViewRankZoneId
		local msg = self._arenaGameMo:_getTotalRankResMsg(zoneId)

		if msg then
			for idx, v in ipairs(msg.rankInfos) do
				if idx > 10 then
					break
				end

				local info = {}

				info.zoneId = zoneId
				info.headInfo = v.rankInfos.headInfo
				info.userName = v.rankInfos.headInfo.userName
				info.score = v.rankInfos.value
				info.rank = v.rankInfos.rank

				table.insert(rankInfoList, info)
			end
		end
	else
		local zoneIdList = self._arenaGameMo:getZoneIdListOfRankFirstInfo()

		for _, zoneId in ipairs(zoneIdList) do
			local commonRankInfo = self._arenaGameMo:getCommonRankInfoOfZoneRankFirst(zoneId)
			local info = {}

			info.zoneId = zoneId
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

function TourArenaGameMainView:_onClearRankCol()
	local children = GameUtil.getChildren(self._rankView.transform)

	for index, mainGo in ipairs(children) do
		self:_clearRankCell(mainGo)
	end
end

function TourArenaGameMainView:_updateRankCell(mainGo, info, index)
	local zoneId = info.zoneId
	local headInfo = info.headInfo
	local userName = info.userName
	local score = info.score
	local zoneData = TourArenaZoneConfig.instance:getTazData(zoneId)
	local headcell = goutil.findChild(mainGo, "headcell")
	local txtPlayerName = goutil.findChildTextComponent(mainGo, "txtPlayerName")
	local aren_txt = goutil.findChildTextComponent(mainGo, "aren/txt")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local imgRank = goutil.findChild(mainGo, "imgRank")
	local rankGo = goutil.findChild(mainGo, "rankGo")
	local rankGo_txt = goutil.findChildTextComponent(mainGo, "rankGo/txt")

	HeadItemController.instance:setHeadCellByInfo(headcell, headInfo, true)

	txtPlayerName.text = userName
	aren_txt.text = zoneData.name
	txtScore.text = score

	local rank = info.rank
	local isTop3 = checknumber(rank) <= 3

	GameUtil.SetActive(imgRank, isTop3)
	GameUtil.SetActive(rankGo, not isTop3)

	if isTop3 then
		GameUtil.setUIImageSpriteIdx(imgRank, rank - 1)
	else
		rankGo_txt.text = rank
	end
end

function TourArenaGameMainView:_clearRankCell(mainGo)
	local headcell = goutil.findChild(mainGo, "headcell")

	HeadItemController.instance:resetHeadCell(headcell)
end

function TourArenaGameMainView:_onUpdateStageColUI()
	local parentTran = self._stageView.transform
	local childGo = self._stageCell
	local childCount = #self._gameStageInfos
	local children = GameUtil.getChildren(parentTran)

	for index, mainGo in ipairs(children) do
		GameUtil.SetActive(mainGo, index <= childCount)
	end

	for index, info in ipairs(self._gameStageInfos) do
		local mainGo = children[index]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, index))
		end

		GameUtil.SetActive(mainGo, true)
		self:_updateStageCell(mainGo, info.gameId, index)
	end
end

function TourArenaGameMainView:_onClearStageCol()
	local children = GameUtil.getChildren(self._stageView.transform)

	for index, mainGo in ipairs(children) do
		self:_clearStageCell(mainGo)
	end
end

function TourArenaGameMainView:_updateStageCell(mainGo, gameId, index)
	local gameData = TourArenaGameConfig.instance:getTagGameData(self._activityId, gameId)
	local info = self._gameStageInfos[gameId]
	local leftTimes = info.leftTimes
	local isIgnoreTimes = info.isIgnoreTimes
	local openDateStr = info.openDate
	local endDateStr = info.endDate
	local imgBg = goutil.findChild(mainGo, "imgBg")
	local leftTimesGo = goutil.findChild(mainGo, "leftTimes")
	local leftTimes_txt = goutil.findChildTextComponent(mainGo, "leftTimes/txt")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local goLock = goutil.findChild(mainGo, "lock")
	local goOver = goutil.findChild(mainGo, "over")
	local txtOpenDate = goutil.findChildTextComponent(mainGo, "lock/txtOpenDate")
	local path = gameData.picturePath

	self:_loadBigBg(imgBg, "ui/bigbg/" .. path, true)

	txtName.text = gameData.name

	GameUtil.SetGray(imgBg, false)
	GameUtil.SetActive(goLock, false)
	GameUtil.SetActive(goOver, false)
	GameUtil.SetActive(leftTimesGo, false)

	local timePeriod = GameUtil.getTimePeriod(openDateStr, endDateStr)

	if timePeriod == GameUtil.inTimePeriod then
		GameUtil.SetActive(leftTimesGo, not isIgnoreTimes)

		leftTimes_txt.text = string.format("剩余：%s次", leftTimes)
	elseif timePeriod == GameUtil.beforeTimePeriod then
		local dateOpen = GameUtil.string2date(openDateStr)

		txtOpenDate.text = string.format("%02d.%02d开启", dateOpen.month, dateOpen.day)

		GameUtil.SetGray(imgBg, true)
		GameUtil.SetActive(goLock, true)
	elseif timePeriod == GameUtil.afterTimePeriod then
		GameUtil.SetGray(imgBg, true)
		GameUtil.SetActive(goOver, true)
	end

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickStageCell, self, gameId))
end

function TourArenaGameMainView:_clearStageCell(mainGo)
	local imgBg = goutil.findChild(mainGo, "imgBg")

	self:_unLoadBigBg(imgBg)
	GameUtil.rmClickHandler(mainGo)
end

function TourArenaGameMainView:_onClickStageCell(gameId)
	local stageCfg = TourArenaGameConfig.instance:getTagStageCfg(self._activityId, gameId)
	local stageIdList = {}

	for _, stageData in ipairs(stageCfg) do
		table.insert(stageIdList, stageData.stageId)
	end

	if #stageIdList == 1 then
		local stageId = stageIdList[1]
		local result, tips = TourArenaController.instance:getTryGameResultAndTips(self._activityId, gameId, stageId)

		FloatWordMgr.instance:show(tips)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		TourArenaController.instance:openTourArenaGame(self._activityId, gameId, stageId)
	else
		UIStateManager.instance:push(ViewName.TourArenaGameStageSelectView, self._activityId, gameId)
	end
end

function TourArenaGameMainView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

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

function TourArenaGameMainView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function TourArenaGameMainView:_onClickBtnJump(key)
	local jumpToStr = TourArenaGameConfig.instance:getClientCommonValue(self._activityId, key, false)

	GotoMgr.gotoByString(jumpToStr)
end

function TourArenaGameMainView:_onClickBtnTip()
	local key = TourArenaGameConfig.instance:getClientCommonValue(self._activityId, "TOURARENAGAME_RULE_MAIN_KEY", false)

	TipsFacade.instance:openRulesView(key)
end

return TourArenaGameMainView
