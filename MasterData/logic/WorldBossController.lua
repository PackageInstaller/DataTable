-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/controller/WorldBossController.lua

module("logic.extensions.worldboss.controller.WorldBossController", package.seeall)

local WorldBossController = class("WorldBossController", BaseController)

WorldBossController.OpenBuyTimeAndMed = true
WorldBossController.rankInfoReqGapTime = 60
WorldBossController.FightTypeChallenge = 1
WorldBossController.FightTypePratice = 2

function WorldBossController:ctor()
	WorldBossController.super.ctor(self)
end

function WorldBossController:onInit()
	WorldBossController.super.onInit(self)

	self._isFirstLoaded = true

	GlobalDispatcher:addListener(GlobalNotify.BattleEnd, self._onBattleEnd, self)
	GlobalDispatcher:addListener(GlobalNotify.SelectNPC, self._onSelectNpc, self)
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._onSceneLoadedFinish, self, NotifyPriority.Low)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
	GlobalDispatcher:addListener(GlobalNotify.MainUIEntered, self._updateMainUITipTimer, self)
	WorldBossAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.onShowChagenSet, self))
	WorldBossAgent.instance:addHandler(WorldBossAgent.PM_NotifyAfterChallengeRes, self.setNotifyAfterChallenge, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._checkRefreshTime, self)
end

function WorldBossController:onReset()
	WorldBossController.super.onReset(self)

	self._isFirstLoaded = true
	self._worldBossInfo = nil
	self._rankInfoReqTimeStamp = nil
	self._worldBossRankInfo = nil
	self._infoAfterChallenge = nil
	self._warDone = nil
	self._btnTiredGo = nil
	self._currCityScene = nil
	self._notifyFlag = nil

	removetimer(self.destroyWorldBoss, self)
	removetimer(self._updateMainUITip, self)
	removetimer(self._doCreateWorldBoss, self)
	GlobalDispatcher:removeListener(PayShopModel.ChangeMibaoShopBuyTimes, self._onBuyItemRes, self)
end

function WorldBossController:onShowChagenSet(changeSetId, msgName)
	if changeSetId ~= nil and changeSetId >= 0 then
		if msgName == "handlePM_NotifyAfterChallengeRes" then
			BattleSettlementModel.instance:setChangeSetId(changeSetId)
		else
			MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
		end
	end
end

function WorldBossController:openWorldBossMainView()
	if self:isInBossFightTime() then
		UIStateManager.instance:push(ViewName.WorldBossMainView)
	else
		FloatWordMgr.instance:show(lang("world_Boss_tip12"))
	end
end

function WorldBossController:setBtnTiredGo(_btnTiredGo)
	self._btnTiredGo = _btnTiredGo
end

function WorldBossController:getBtnTiredGo()
	return self._btnTiredGo
end

function WorldBossController:loginRequestWorldBossInfo()
	if not FuncOpenModel.instance:getFuncIsOpen(93) then
		return
	end

	self:requestWorldBossInfo()
end

function WorldBossController:requestWorldBossInfo()
	if self:isInBossCanFightTime() then
		WorldBossAgent.instance:sendPM_WorldBossInfoReq(function(msg)
			forcePrint("=====RoleDataRequestor:_loadRequestWorldBossInfo===back")
			self:setWorldBossInfo(msg)
		end)
	end
end

function WorldBossController:setWorldBossInfo(msg)
	self._worldBossInfo = GameUtil.pbToTable(msg)

	self:operView(ViewName.WorldBossMainView, function(_view)
		_view:_updateViewByWorldBossInfoRes()
	end)
end

function WorldBossController:getWorldBossInfo()
	return self._worldBossInfo
end

function WorldBossController:getAllChallengeTime()
	local _commonConfig = WorldBossConfig.instance:getWorldBossCommonConfig()
	local _cfgAllTimes = _commonConfig.FIGHT_TIMES.value
	local _freeAddTime = GoldenDiamondCardConfig.instance:getPrivilegeDefaultValue(GoldenDiamondCardModel.PrivilegeType.WorldBossFreeTime)

	if GoldenDiamondCardModel.instance.isUser then
		_cfgAllTimes = _cfgAllTimes + _freeAddTime
	end

	if self._worldBossInfo then
		_cfgAllTimes = _cfgAllTimes + self._worldBossInfo.buyTimes or 0
	end

	return _cfgAllTimes
end

function WorldBossController:updateWorldBossBuyTimes()
	if self._worldBossInfo then
		FloatWordMgr.instance:show(lang("world_Boss_tip13"))

		self._worldBossInfo.buyTimes = self._worldBossInfo.buyTimes + 1

		self:operView(ViewName.WorldBossMainView, function(_view)
			_view:_updateChallengeTime()
		end)
	end
end

function WorldBossController:_buyChallengePrice()
	if not self._worldBossInfo then
		return
	end

	local _worldBossBuyTimesDefine = WorldBossConfig.instance:getWorldBossBuyTimesDefine()

	if not self._worldBossInfo.buyTimes then
		local _nowBuyTime = 0

		if _nowBuyTime >= #_worldBossBuyTimesDefine then
			FloatWordMgr.instance:show(lang("world_Boss_tip16"))

			return
		elseif self:isInBossCanFightTime() then
			local _cost = _worldBossBuyTimesDefine[_nowBuyTime + 1].cost
			local _costArray = string.split(_cost, ":")

			return _costArray[3]
		else
			FloatWordMgr.instance:show(lang("world_Boss_tip14"))
		end
	end
end

function WorldBossController:isLockPetIds(_petId)
	if not _petId or not self._worldBossInfo then
		return
	end

	if self._worldBossInfo.lockPetIds then
		for k, v in pairs(self._worldBossInfo.lockPetIds) do
			if v and tonumber(v) == tonumber(_petId) then
				return true
			end
		end
	end

	return false
end

function WorldBossController:worldBossClearLock()
	if not self._worldBossInfo then
		return
	end

	self._worldBossInfo.lockPetIds = nil

	GlobalDispatcher:dispatch(GlobalNotify.WorldBossMedicine)
end

function WorldBossController:sendWorldBossRankInfoReq()
	local _nowTimeStamp = ServerTime.now()

	if self._rankInfoReqTimeStamp then
		if _nowTimeStamp - self._rankInfoReqTimeStamp > WorldBossController.rankInfoReqGapTime then
			self._rankInfoReqTimeStamp = _nowTimeStamp
		else
			return -1
		end
	else
		self._rankInfoReqTimeStamp = _nowTimeStamp
	end

	WorldBossAgent.instance:sendPM_WorldBossRankInfoReq(self.setWorldBossRankInfo, self)
end

function WorldBossController:setWorldBossRankInfo(msg)
	self._worldBossRankInfo = GameUtil.pbToTable(msg)

	WorldBossAgent.instance:sendPM_WorldBossInfoReq(function(msg)
		self:setWorldBossInfo(msg)
	end)
	self:operView(ViewName.WorldBossRankView, function(_view)
		_view:_updateView()
	end)
end

function WorldBossController:getWorldBossRankInfo()
	return self._worldBossRankInfo
end

function WorldBossController:getMedicineItemInfo()
	local _worldBossCommonConfig = WorldBossConfig.instance:getWorldBossCommonConfig()
	local _itemInfo = _worldBossCommonConfig.UNLOCK_MEDICINE_ID.value

	if not _itemInfo then
		return
	end

	local _itemInfoArray = string.split(_itemInfo, ":")
	local _itemType = _itemInfoArray[1]
	local _itemId = _itemInfoArray[2]
	local _itemNum = MaterialModel.instance:getMaterialsNumber(_itemType, _itemId) or 0

	return _itemInfo, _itemNum
end

function WorldBossController:onClickClearTired()
	local _, _itemNum = self:getMedicineItemInfo()

	if _itemNum and _itemNum > 0 then
		local _worldBossInfo = WorldBossController.instance:getWorldBossInfo()

		if not _worldBossInfo then
			return
		end

		if _worldBossInfo.lockPetIds then
			if #_worldBossInfo.lockPetIds <= 0 then
				FloatWordMgr.instance:show(lang("world_Boss_tip2"))

				return
			end
		else
			FloatWordMgr.instance:show(lang("world_Boss_tip2"))

			return
		end

		TipsFacade.instance:openPopupWindow("提示", lang("world_Boss_tip3"), function()
			WorldBossAgent.instance:sendPM_WorldBossClearLockReq(function()
				self:worldBossClearLock()
			end)
		end, nil, "确定", "取消")
	elseif _itemNum and _itemNum == 0 then
		local itemId = 2113
		local info = PayShopConfig.instance:getPayShopGoodsCfgById(itemId)

		if info then
			if info.sellTargetLimit ~= "none" and info.limitTimes > 0 then
				local times = PayShopModel.instance:getMibaoBuyTimesById(itemId)

				if times >= info.limitTimes then
					FloatWordMgr.instance:show("已售罄")

					return
				end
			end

			GlobalDispatcher:addListener(PayShopModel.ChangeMibaoShopBuyTimes, self._onBuyItemRes, self)
			ShopController.instance:checkBuyGood(info, 1, string.format(lang("world_Boss_tip17"), info.limitTimes))
		else
			FloatWordMgr.instance:show("该商品已售罄")
		end
	else
		FloatWordMgr.instance:show(lang("world_Boss_tip4"))
	end
end

function WorldBossController:_onBuyItemRes(msg)
	return
end

function WorldBossController:setNotifyAfterChallenge(msg)
	self._infoAfterChallenge = GameUtil.pbToTable(msg)
	self._warDone = true
end

function WorldBossController:_onBattleEnd()
	if self._warDone then
		self._warDone = false

		UIJumper.instance:pushOneStack(ViewName.WorldBossMainView, true)
	end
end

function WorldBossController:_onSceneLoadedFinish(sceneType, sceneId)
	self.currSceneType = sceneType
	self.currSceneId = sceneId

	self:_checkTodayBoss()
end

function WorldBossController:_checkRefreshTime()
	self:_checkTodayBoss()
end

function WorldBossController:_checkTodayBoss()
	local bossId = 0
	local startStamp = 0
	local nowStamp = ServerTime.now()
	local data = self:getCommonBossDataByStamp(nowStamp, "BOSS_INTERFACE_DISPLAY_TIME")

	if data == nil then
		local nextStamp = nowStamp + 86400

		data = self:getCommonBossDataByStamp(nextStamp, "BOSS_INTERFACE_DISPLAY_TIME")
	end

	if data then
		bossId = data.bossId

		local startTime = string.format("%s %s", data.date, data.time)

		startStamp = GameUtil.string2time(startTime)
	end

	if bossId <= 0 then
		return
	end

	local sceneType = self.currSceneType
	local sceneId = self.currSceneId
	local _enemyTeamInfo = self:getEnemyTeamInfo(bossId)

	self.BossOrderId = tonumber(_enemyTeamInfo.bossNpc)
	self._currCityScene = nil

	local _bossSceneId = self:_getBossSceneId()

	if sceneType ~= SceneType.City then
		return
	end

	if _bossSceneId and _bossSceneId == sceneId then
		self._currCityScene = SceneMgr.instance:getCurScene()

		self:_createWorldBoss(sceneId, startStamp)
	end
end

function WorldBossController:_onStartEnterGame()
	if not self._notifyFlag then
		local date = self:_getBossBeginTime(true)

		if date then
			GlobalDispatcher:dispatch(GlobalNotify.SetPushOpen, {
				5
			}, date.hour, date.min)
		end

		self._notifyFlag = true
	end
end

function WorldBossController:_getBossSceneId()
	local npcCo = SceneConfig.instance:getNpcCo(self.BossOrderId)

	if not npcCo then
		return
	end

	return npcCo.sceneId
end

function WorldBossController:_createWorldBoss(sceneId, startTime)
	removetimer(self._doCreateWorldBoss, self)

	if self:isInBossFightTime() then
		local npcCo = SceneConfig.instance:getNpcCo(self.BossOrderId)

		if npcCo and npcCo.sceneId == sceneId and npcCo.funcType == UnitConst.NPC_TASK_TRIGGERD and self._currCityScene then
			self._currCityScene.unitFactory:createNpcById(self.BossOrderId)
			self:_updateMainUITipTimer()
			self:_destroyWorldBossTimer()
		end
	else
		local time = startTime - ServerTime.now()

		if time > 0 then
			settimer(time, self._doCreateWorldBoss, self, false)
		end
	end
end

function WorldBossController:_doCreateWorldBoss()
	self:_checkTodayBoss()
end

function WorldBossController:_destroyWorldBossTimer()
	local _leftTime = checknumber(self:_getBossDispalyTime()) - ServerTime.now()

	if _leftTime > 0 then
		settimer(_leftTime, self.destroyWorldBoss, self, false)
	end
end

function WorldBossController:removeAllBossRed()
	local cfg = WorldBossConfig.instance:getWorldBossType() or {}

	for i, v in ipairs(cfg.dataList) do
		local redId = RedPointModel.ID_WORLD_BOSS_PRE .. v.bossId

		RedPointController.instance:setRedPointInfo(redId, false)
	end
end

function WorldBossController:destroyWorldBoss()
	removetimer(self.destroyWorldBoss, self)
	self:removeAllBossRed()
	GlobalDispatcher:dispatch("UpdataCustomOpensItem", false, 2)

	if self._currCityScene and self.BossOrderId then
		self._currCityScene.unitFactory:destroyNpcById(self.BossOrderId)

		self.BossOrderId = nil
	end

	self:_checkTodayBoss()
end

function WorldBossController:goToWorldBoss()
	if not self:isInBossFightTime() then
		FloatWordMgr.instance:show(lang("world_Boss_tip15"))

		return
	end

	TaskController.instance:foreceClearState()
	UIStateManager.instance:clear(true)
	UIStateManager.instance:push(ViewName.WorldBossMainView)
end

function WorldBossController:_onSelectNpc(_npcId)
	if not _npcId then
		return
	end

	if _npcId == self.BossOrderId then
		UIStateManager.instance:push(ViewName.WorldBossMainView)
	end
end

function WorldBossController:_updateMainUITipTimer()
	if self:isInBossFightTime() then
		self:_updateMainUITip()
	else
		local _bossBeginTimeStamp = checknumber(self:_getBossBeginTime())

		if _bossBeginTimeStamp > ServerTime.now() then
			settimer(_bossBeginTimeStamp - ServerTime.now() + 0.02, self._updateMainUITipTimer, self, false)
		end
	end
end

function WorldBossController:_updateMainUITip()
	self:removeAllBossRed()
	removetimer(self._updateMainUITip, self)

	if not FuncOpenModel.instance:getFuncIsOpen(93) then
		return
	end

	local _bossEndTime = WorldBossController.instance:_getBossEndTime()

	if not _bossEndTime then
		return
	end

	if self:isInBossFightTime() then
		local todayBossId = WorldBossController.instance:getTodayBossId()

		if todayBossId then
			local redId = RedPointModel.ID_WORLD_BOSS_PRE .. todayBossId

			RedPointController.instance:setRedPointInfo(redId, true, true, 0, _bossEndTime)
		end
	end
end

function WorldBossController:_checkMainUI()
	removetimer(self._checkMainUI, self)

	if self._mainUIFlag then
		self._mainUIFlag = false
	else
		self:_updateMainUITip()
	end
end

function WorldBossController:setMainUIFlag(flag)
	self._mainUIFlag = flag
end

function WorldBossController:getWorldBossPrizeTypeByBossId()
	local _todayBossId = WorldBossController.instance:getTodayBossId()

	if not _todayBossId then
		return
	end

	local _worldBossChallengePrize = WorldBossConfig.instance:getWorldBossChallengePrize(_todayBossId)
	local _prizeTypeList = {}

	for k, v in pairs(_worldBossChallengePrize) do
		local _prizeArray = string.split(MaterialMgr.changeItemStr(v.prize), "#")

		for i = 1, #_prizeArray do
			local _prizeArrayItem = string.split(_prizeArray[i], ":")
			local _prizeArrayItemStr = _prizeArrayItem[1] .. ":" .. _prizeArrayItem[2] .. ":0"

			if #_prizeTypeList <= 0 then
				table.insert(_prizeTypeList, _prizeArrayItemStr)
			else
				local finded = false

				for _, _itemStr in ipairs(_prizeTypeList) do
					if _itemStr == _prizeArrayItemStr then
						finded = true

						break
					end
				end

				if not finded then
					table.insert(_prizeTypeList, _prizeArrayItemStr)
				end
			end
		end
	end

	return _prizeTypeList
end

function WorldBossController:getWorldBossRankPrize()
	local _worldBossRankPrize = WorldBossConfig.instance:getBigRankPrize(101)
	local _rankPrizeDatas = {}

	for k, v in pairs(_worldBossRankPrize) do
		for vId, vInfo in pairs(v) do
			local desc = ""

			desc = vId ~= 1 and string.format(lang("world_Boss_tip11"), k, vId) or lang("world_Boss_tip10")

			table.insert(_rankPrizeDatas, {
				desc = desc,
				startRank = k,
				endRank = vId,
				prize = vInfo.prize
			})
		end
	end

	table.sort(_rankPrizeDatas, function(a, b)
		return a.startRank < b.startRank
	end)

	return _rankPrizeDatas
end

function WorldBossController:getWorldBossDamagePrize()
	local _todayBossId = WorldBossController.instance:getTodayBossId()

	if not _todayBossId then
		return {}
	end

	local _worldBossRankPrize = WorldBossConfig.instance:getWorldBossChallengePrize(_todayBossId)
	local list = {}

	for k, v in pairs(_worldBossRankPrize) do
		table.insert(list, v)
	end

	ArraySort.sortOn(list, "processorSection", ArraySort.DESCENDING)

	local res = {}

	for i, v in ipairs(list) do
		local desc = ""

		if i == 1 then
			desc = langPara("火力值 %s以上", v.processorSection)
		else
			local cfg = list[i - 1]

			desc = langPara("火力值 %s-%s", v.processorSection, cfg.processorSection - 1)
		end

		table.insert(res, {
			desc = desc,
			prize = v.prize
		})
	end

	return res
end

function WorldBossController:getTodayBossId()
	local data = self:getTodayCommonBossData("BOSS_INTERFACE_DISPLAY_TIME")

	return (data or nil) and (data.bossId or nil)
end

function WorldBossController:getTodayCommonBossData(offsetField)
	local nowStamp = ServerTime.now()

	return self:getCommonBossDataByStamp(nowStamp, offsetField)
end

function WorldBossController:getCommonBossDataByStamp(nowStamp, offsetField)
	local _bossTimeList = WorldBossConfig.instance:getWorldBossLayoutByGameDay(nowStamp)
	local _worldBossCommonConfig = WorldBossConfig.instance:getWorldBossCommonConfig()
	local offsetTime = _worldBossCommonConfig[offsetField].value * 60

	for i, data in ipairs(_bossTimeList) do
		local startTime = string.format("%s %s", data.date, data.time)
		local startStamp = GameUtil.string2time(startTime)
		local endStamp = startStamp + offsetTime

		if GameUtil.getTimePeriodBySecWithOther(nowStamp, startStamp, endStamp) == GameUtil.inTimePeriod then
			return data
		end
	end

	return nil
end

function WorldBossController:getEnemyTeamId(_todayBossId)
	if not _todayBossId then
		return
	end

	local _worldBossType = WorldBossConfig.instance:getWorldBossType()
	local _enemyTeamId

	for k, v in pairs(_worldBossType) do
		if tonumber(_todayBossId) == tonumber(v.bossId) then
			_enemyTeamId = tonumber(v.teamId)

			break
		end
	end

	return _enemyTeamId
end

function WorldBossController:getEnemyTeamInfo(_todayBossId)
	if not _todayBossId then
		return
	end

	local _worldBossType = WorldBossConfig.instance:getWorldBossType()
	local _enemyTeamInfo

	for k, v in pairs(_worldBossType) do
		if tonumber(_todayBossId) == tonumber(v.bossId) then
			_enemyTeamInfo = v

			break
		end
	end

	return _enemyTeamInfo
end

function WorldBossController:getBossCreeps(_enemyTeamId)
	if not _enemyTeamId then
		return
	end

	local _worldBossCreeps = WorldBossConfig.instance:getWorldBossCreeps()

	return _worldBossCreeps[_enemyTeamId]
end

function WorldBossController:getEmenyBossInfo()
	local _todayBossId = WorldBossController.instance:getTodayBossId()

	if not _todayBossId then
		return
	end

	local _enemyTeamId = WorldBossController.instance:getEnemyTeamId(_todayBossId)

	if not _enemyTeamId then
		return
	end

	local _teamInfo = WorldBossController.instance:getBossCreeps(_enemyTeamId)

	if not _teamInfo then
		return
	end

	local _bossRaceInfo

	for i, v in pairs(_teamInfo) do
		if v.raceId then
			_bossRaceInfo = v

			break
		end
	end

	return _bossRaceInfo
end

function WorldBossController:isInBossFightTime()
	local data = self:getTodayCommonBossData("BOSS_INTERFACE_DISPLAY_TIME")

	return data ~= nil
end

function WorldBossController:_getBossEndTime(isDate)
	local endStamp = self:getBossCommonEndTimeStamp("BOSS_FIGHT_END_TIME")

	if endStamp then
		if isDate then
			return GameUtil.time2date(endStamp)
		else
			return endStamp
		end
	end
end

function WorldBossController:_getBossBeginTime(isDate)
	local nowStamp = ServerTime.now()
	local data = self:getCommonBossDataByStamp(nowStamp, "BOSS_FIGHT_END_TIME")

	if data then
		local startTime = string.format("%s %s", data.date, data.time)
		local startStamp = GameUtil.string2time(startTime)

		if isDate then
			return GameUtil.time2date(startTime)
		else
			return startStamp
		end
	end
end

function WorldBossController:_getBossDispalyTime(isDate)
	local endStamp = self:getBossCommonEndTimeStamp("BOSS_INTERFACE_DISPLAY_TIME")

	if endStamp then
		if isDate then
			return GameUtil.time2date(endStamp)
		else
			return endStamp
		end
	end
end

function WorldBossController:getBossCommonEndTimeStamp(offsetField)
	local result = 0
	local now = ServerTime.now()
	local _bossTimeList = WorldBossConfig.instance:getWorldBossLayoutByGameDay(now)
	local _worldBossCommonConfig = WorldBossConfig.instance:getWorldBossCommonConfig()
	local _bossFightEndTime = _worldBossCommonConfig[offsetField].value * 60

	for i, cfg in ipairs(_bossTimeList) do
		local startTime = string.format("%s %s", cfg.date, cfg.time)
		local startStamp = GameUtil.string2time(startTime)
		local endStamp = startStamp + _bossFightEndTime

		if now < endStamp or i == #_bossTimeList then
			result = endStamp

			break
		end
	end

	return result
end

function WorldBossController:isInBossCanFightTime()
	local data = self:getTodayCommonBossData("BOSS_FIGHT_END_TIME")

	return data ~= nil
end

function WorldBossController:isRedPoint()
	return self:isInBossCanFightTime() and WorldBossController.instance:getWorldBossInfo().fightTimes - self:getAllChallengeTime() > 0
end

function WorldBossController:operView(viewName, _callBack)
	if not viewName then
		return
	end

	local _view, _ = self:getView(viewName)

	if _view and ViewMgr.instance:isOpen(viewName) and _callBack then
		_callBack(_view)
	end
end

function WorldBossController:getView(_viewName)
	local presentor = ViewMgr.instance:getViewPresentor(_viewName)
	local view = self:_getViewByViewName(presentor, _viewName)

	return view, presentor
end

function WorldBossController:_getViewByViewName(presentor, viewName)
	if not presentor or not presentor._views or not viewName then
		return
	end

	for i = 1, #presentor._views do
		if presentor._views[i]._viewPresentor.viewName == viewName then
			return presentor._views[i]
		end
	end
end

WorldBossController.instance = WorldBossController.New()

return WorldBossController
