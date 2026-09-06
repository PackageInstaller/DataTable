-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/controller/WTowerController.lua

module("logic.extensions.warriortower.controller.WTowerController", package.seeall)

local WTowerController = class("WTowerController", BaseController)

WTowerController.GetWarriorTowerProfitInfoRes = "WTowerController_GetWarriorTowerProfitInfoRes"

function WTowerController:onInit()
	WTowerController.super.onInit(self)

	self._towerInfoLoaded = false

	WarriorTowerAgent.instance:addHandler(WarriorTowerAgent.AfterFightRes, self.onAfterFightRes, self)
	WarriorTowerAgent.instance:setShowChangeSetFunc(GameUtil.handler(self.onShowChagenSet, self))
	GlobalDispatcher:addListener(WarriorTowerAgent.WarriorTowerAutoFightRes, self._autoFightRes, self)
end

function WTowerController:setStart(_start)
	self._startBattle = _start
end

function WTowerController:_onSceneChanged(sceneType, sceneId)
	if sceneType == SceneType.City and self._startBattle then
		self._startBattle = false

		UIStateManager.instance:push(ViewName.warriortower)
	end
end

function WTowerController:getFmtZdl(towerId)
	if towerId == WTowerModel.TowerType.Warrior then
		return GlobalModel.instance:getCurrStrength()
	else
		local fmtMo
		local power, speed = WTowerModel.instance:getCurFormation():getPowerAndSpeed()

		return checknumber(power)
	end
end

function WTowerController:_autoFightRes(status, msg)
	if status == 0 then
		WTowerModel.instance:setChallengeInfos(msg.towerId, msg.progressId)
		WTowerModel.instance:refreshBoxStates()
		self:notify(WTowerModel.ReceiveAuto, msg.changeSetId)
	end
end

function WTowerController:onShowChagenSet(changeSetId, msgName)
	if changeSetId ~= nil and changeSetId >= 0 then
		if msgName == "handleAfterFightRes" or msgName == "handleFightRes" or msgName == "handleWarriorTowerAutoFightRes" then
			printInfo("勇者之塔设置changeSetId", changeSetId, msgName)
			BattleSettlementModel.instance:setChangeSetId(changeSetId)
		else
			MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
		end
	end
end

function WTowerController:onAfterFightRes(msg, status)
	if status == 0 then
		WTowerModel.instance:setChallengeInfos(msg.towerId, msg.progressId)
		WTowerModel.instance:refreshBoxStates()
		WTowerController.instance:localNotify(WTowerModel.REFRESH_TOWER_INFO)
	end
end

function WTowerController:onReset()
	self._towerInfoLoaded = false
	self._mainProgress = 0
	self._srvMsgGet = false
end

function WTowerController:loadTowerInfo()
	if not self._towerInfoLoaded then
		WarriorTowerAgent.instance:sendUserTowerInfoReq(function(msg)
			local TowerInfo = msg.towerInfo

			if TowerInfo then
				for k, v in ipairs(TowerInfo) do
					WTowerModel.instance:setChallengeInfos(v.towerId, v.progressId)
					WTowerModel.instance:setBoxStates(v.towerId, v.prizeState)
				end

				WTowerController.instance:localNotify(WTowerModel.REFRESH_TOWER_INFO)
			end
		end)
	end
end

function WTowerController:setParams(towerId, towerIndex)
	local levelCfg = WTowerConfig.instance:getCfgById(towerIndex, towerId)
	local params = {}

	params.fightWinExp = levelCfg.fightWinExp
	params.isFinalLevel = towerIndex >= WTowerConfig.instance:getCfgCount(towerId)

	if BattleRecordRankController.instance:isWTowerWithBattleRecord(towerIndex, towerId) then
		params.videoKey = BattleRecordRankController.instance:getWTowerRankKey(towerId, towerIndex)
	end

	printInfo("test 是否最后一关", params.isFinalLevel, towerIndex, towerId)
	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.WarriorTower, params)
end

function WTowerController:onClickNextLevel()
	local towerId = WTowerModel.instance:getTowerId()
	local curLv = WTowerModel.instance:getCurLevel(towerId)

	WTowerController.instance:setParams(towerId, curLv)
	self:startBattle(towerId, true)
	BattleFacade.instance:startWTower(checknumber(curLv), towerId)
	UIJumper.instance:pushClearCurStack(ViewName.warriortower, true)
end

function WTowerController:setBattleSettlementParams()
	local towerId = WTowerModel.instance:getTowerId()
	local curLv = WTowerModel.instance:getCurLevel(towerId)

	WTowerController.instance:setParams(towerId, curLv)
end

function WTowerController:startBattle(towerId, isAddBattleCount)
	self._battleCount = isAddBattleCount and self._battleCount + 1 or 0

	printInfo("test 开始战斗 startBattle", self._battleCount)
	WarriorTowerAgent.instance:sendFightReq(towerId, function(status, msg)
		return
	end, nil, function()
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
	end)
end

function WTowerController:isCanNextBattle()
	return self._battleCount > 0
end

function WTowerController:updateItem(item, itemStr)
	local info = string.split(itemStr, ":")

	item._go:SetActive(true)

	local cfg = ItemConfig.instance:getCfgById(checknumber(info[2]))

	uGuiUtil.setSpriteToImage(item._icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(cfg.icon))

	item._numTxt.text = "x" .. info[3]
end

function WTowerController:getBoxPrize(towerId)
	WarriorTowerAgent.instance:sendGainProgressPrizeReq(towerId, function(msg)
		local prizeIds = msg.prizeId

		WTowerModel.instance:getBoxes(prizeIds)
		WTowerController.instance:localNotify("RefreshPrize")
	end)
end

function WTowerController:getCenterBoxIndex()
	local boxInfos = WTowerModel.instance:getBoxInfos(true)

	for i = 1, #boxInfos do
		if boxInfos[i]._state == 2 or boxInfos[i]._state == 3 then
			return i
		end
	end

	return #boxInfos
end

function WTowerController:getIfHaveMain()
	local curLevel = WTowerModel.instance:getCurLevel(WTowerModel.TowerType.Warrior)
	local condition = self:getUnlockLeafMainTowerLevel()

	return condition < curLevel
end

function WTowerController:getUnlockLeafMainTowerLevel()
	return checknumber(WTowerConfig.instance:getParaCfg("videoUnlockLevel"))
end

function WTowerController:getIfTowerUnlock(towerId)
	local curLevel = WTowerModel.instance:getCurLevel(WTowerModel.TowerType.Warrior)
	local condition = WTowerModel.instance:getTowerUnlockLevel(towerId)
	local currTime = ServerTime.now()
	local weekday = tonumber(GameUtil.formatTimeStamp("%w", currTime))
	local hour = tonumber(GameUtil.formatTimeStamp("%H", currTime))

	if hour >= 0 and hour < 5 then
		weekday = weekday - 1
	end

	if weekday <= 0 then
		weekday = weekday + 7
	end

	local openTime = WTowerConfig.instance:getDicCfg(towerId).periods
	local isOpen = false

	for k, v in pairs(openTime) do
		if v == weekday then
			isOpen = true
		end
	end

	return condition < curLevel and isOpen
end

function WTowerController:openWarrior()
	function openView()
		if self:getIfHaveMain() then
			UIStateManager.instance:push(ViewName.WarriormaintowerView)
		else
			UIStateManager.instance:push(ViewName.warriortower)
		end
	end

	if not self._towerInfoLoaded then
		self:getWarriorInfo(function(msg)
			openView()
		end)
	else
		openView()
	end
end

function WTowerController:getWarriorInfo(callBack)
	WarriorTowerAgent.instance:sendUserTowerInfoReq(function(msg)
		local TowerInfo = msg.towerInfo

		if TowerInfo then
			for k, v in ipairs(TowerInfo) do
				WTowerModel.instance:setChallengeInfos(v.towerId, v.progressId)
				WTowerModel.instance:setBoxStates(v.towerId, v.prizeState)
			end

			self._towerInfoLoaded = true

			WTowerController.instance:localNotify(WTowerModel.REFRESH_TOWER_INFO)
		end

		GameUtil.callBack(callBack, msg)
	end)
end

function WTowerController:getIfCanGetBonus(towerId)
	local data = WTowerModel.instance:getBoxInfo(towerId)

	for k, v in pairs(data) do
		if v._state == 2 then
			return true
		end
	end

	return false
end

function WTowerController:openBranchTower(towerId)
	WTowerModel.instance:setTowerId(towerId)
	UIStateManager.instance:push(ViewName.warriortower)
end

function WTowerController:sendGetFormation(towerId)
	WarriorTowerAgent.instance:sendGetWarriorTowerFormReq(towerId, function(msg)
		WTowerModel.instance:setFormation(msg.simpleForm)
	end)
end

function WTowerController:reqGetMainProgress()
	WarriorTowerAgent.instance:sendGetWarriorMainTowerProgressReq(self._onMainProgressRes, self)
end

function WTowerController:_onMainProgressRes(msg)
	forcePrint("=====RoleDataRequestor:_loadWarriorTowerProgress===back")

	if checknumber(self._mainProgress) ~= msg.progressId then
		self:setMainProgress(msg.progressId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.WTowerDataReady)
end

function WTowerController:getSrvMsgGet()
	return self._srvMsgGet
end

function WTowerController:getMainProgress()
	return checknumber(self._mainProgress)
end

function WTowerController:setMainProgress(num)
	self._mainProgress = num or 0
end

function WTowerController:saveRecordForm(towerId, simpleForm, callback)
	WarriorTowerAgent.instance:sendSetWarriorTowerFormReq(towerId, simpleForm, function(msg)
		WTowerModel.instance:setFormation(msg.simpleForm)
		GameUtil.callBack(callback)
	end)
end

function WTowerController:isFilterReward(str)
	self._filterList = self._filterList or string.split(WTowerConfig.instance:getParaCfg("timeBox_showReward_0"), "#")

	for i, v in ipairs(self._filterList) do
		if v == str then
			return true
		end
	end

	return false
end

function WTowerController:sendGetWarriorTowerProfitInfoReq()
	WarriorTowerAgent.instance:sendGetWarriorTowerProfitInfoReq(function(msg)
		WTowerModel.instance:setTimeBoxInfo(msg.nextBalanceMillis, msg.turnHasBuyTotalTimes, msg.turnLeftBuyFreeTimes)
		GlobalDispatcher:dispatch(WTowerController.GetWarriorTowerProfitInfoRes)
	end)
end

function WTowerController:sendTurnTimeWarriorTowerReq()
	local turnTotalTimes, turnFreeTimes = WTowerModel.instance:getTimeBoxTimes()

	printInfo("test WTowerController:sendTurnTimeWarriorTowerReq", turnTotalTimes, turnFreeTimes)
	WarriorTowerAgent.instance:sendTurnTimeWarriorTowerReq(turnFreeTimes > 0, function()
		WTowerModel.instance:setTimeBoxFreeTimes(turnFreeTimes - 1)
		WTowerModel.instance:setTimeBoxTotalTimes(turnTotalTimes + 1)
	end)
end

function WTowerController:sendGainWarriorTowerProfitPrizeReq()
	WarriorTowerAgent.instance:sendGainWarriorTowerProfitPrizeReq(function(msg)
		WTowerModel.instance:setBoxGainTime(msg.nextBalanceMillis)
	end)
end

WTowerController.instance = WTowerController.New()

return WTowerController
