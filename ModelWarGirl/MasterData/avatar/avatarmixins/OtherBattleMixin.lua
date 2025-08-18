-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OtherBattleMixin.lua

local ResEquipTower = require("ClientData/ResEquipTower")
local ResBossTower = require("ClientData/ResBossTower")
local ResBossTowerMisc = require("ClientData/ResBossTowerMisc")
local ResEquipTowerMisc = require("ClientData/ResEquipTowerMisc")
local UserData = require("Helper/UserData")
local ResPVP = require("ClientData/ResAsyncPVPMisc")
local ResMazeMisc = require("ClientData/ResMazeMisc")
local ResMaze = require("ClientData/ResMaze")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResBossTowerAward = require("ClientData/ResBossTowerAward")
local EventConst = require("EventConst")
local BattleConst = require("Common/FrameBattle/BattleConst")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local PVPCommon = require("Logic/PVP/PVPCommon")
local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local ResEquipTowerLimitHero = require("ClientData/ResEquipTowerLimitHero")
local ResBossTowerExpandCamp = require("ClientData/ResBossTowerExpandCamp")
local ResBossTowerExpandLevel = require("ClientData/ResBossTowerExpandLevel")
local ResBossTowerExpandMisc = require("ClientData/ResBossTowerExpandMisc")
local ResRandClient = require("ClientData/ResRandClient")
local ResAutoBattlePower = require("ClientData/ResAutoBattlePower")
local ResItem = require("ClientData/ResItem")
local ResGuideGet = require("ClientData/ResGuideGet")
local ResStage = require("ClientData/ResStage")
local EQUIP_TOWER_LIMIT_START_TICK = ClientUtils.getServerTimeByTimeStr(ResEquipTowerMisc[1].limit_start_tick)
local EQUIP_TOWER_LIMIT_CIRCLE_NUM = #ResEquipTowerLimitHero[1]
local OtherBattleMixin = {}

function OtherBattleMixin:initOtherBattleMixin(baseData, syncData)
	EQUIP_TOWER_LIMIT_START_TICK = ClientUtils.getServerTimeByTimeStr(ResEquipTowerMisc[1].limit_start_tick)
	self.equipTowerData = {}
	self.onceTowerLevel = baseData.necessary.once_tower.pass_layer

	self:initBossTowerData(baseData.necessary)
	self:initBossExpandData(baseData.necessary.camp_tower)
	self:initAsyncPvpData(syncData.other.async_pvp)
	self:initMazeData(syncData.other.maze)
	self:initSeniorPvpData(syncData.other.multipvp)
	self:initOpactPvpData()
	self:initAutoBattlePower(baseData.necessary.misc.battle_power)
end

function OtherBattleMixin:postinitOtherBattleMixin(baseData, syncData)
	EQUIP_TOWER_LIMIT_START_TICK = ClientUtils.getServerTimeByTimeStr(ResEquipTowerMisc[1].limit_start_tick)

	self:initEquipTowerData(baseData.necessary.equip_tower)
end

function OtherBattleMixin:initCheckOtherBattleMixin()
	self:checkChallengeBossHint()
	self:checkPvpFormationRedHint()
	self:checkSeniorPvpFormationRedHint()
	self:checkSeniorPvpAwardRedHint()
	self:checkMultiPvpRecordRedHint()
	self:checkOpactPvpFormationRedHind()
	self:checkOpactPvpChallengeRedHind()
	self:checkRentFormationRedHind()
	self:checkBossExpandCleanRedHint()
	self:setMazeState()
	self:checkAndGetSnapShotFormation({
		Const.FORMATION_MULTIPVP_DEFEND_1,
		Const.FORMATION_ASYNC_DEFEND
	})

	self.slotOfBossChallengeChanged = Slot(self.checkChallengeBossHint, self)
	self.slotOfMazeChanged = Slot(self.setMazeState, self)
	self.slotOfPvpChanged = Slot(self.checkPvpFormationRedHint, self)
	self.slotOfSeniorPvpChanged = Slot(self.checkSeniorPvpFormationRedHint, self)
	self.slotOfOpactPvpChanged = Slot(self.checkOpactPvpFormationRedHind, self)
	self.slotOfRentTaskChanged = Slot(self.checkRentFormationRedHind, self)
	self.slotOfBossExpandChanged = Slot(self.checkBossExpandChanged, self)

	EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfBossChallengeChanged, Const.CONDITION_LIMIT_BOSS_TOWER_EX)
	EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfBossChallengeChanged, Const.CONDITION_LIMIT_BOSS_TOWER)
	EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfMazeChanged, Const.CONDITION_LIMIT_MAZE)
	EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfPvpChanged, Const.CONDITION_LIMIT_PVP)
	EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfSeniorPvpChanged, Const.CONDITION_LIMIT_MULTIPVP)
	EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfOpactPvpChanged, Const.CONDITION_LIMIT_OPACTPVP)
	EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfRentTaskChanged, Const.CONDITION_LIMIT_RENTTASK)
	EventCenter.addEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfBossExpandChanged, Const.CONDITION_LIMIT_BOSS_EXPAND)
end

function OtherBattleMixin:destroyOtherBattleMixin()
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfBossChallengeChanged, Const.CONDITION_LIMIT_BOSS_TOWER_EX)
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfBossChallengeChanged, Const.CONDITION_LIMIT_BOSS_TOWER)
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfMazeChanged, Const.CONDITION_LIMIT_MAZE)
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfPvpChanged, Const.CONDITION_LIMIT_PVP)
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfSeniorPvpChanged, Const.CONDITION_LIMIT_MULTIPVP)
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfOpactPvpChanged, Const.CONDITION_LIMIT_OPACTPVP)
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfRentTaskChanged, Const.CONDITION_LIMIT_RENTTASK)
	EventCenter.removeEventListener(EventConst.CONDITION_LOCK_CHANGED, self.slotOfBossExpandChanged, Const.CONDITION_LIMIT_BOSS_EXPAND)
end

function OtherBattleMixin:newDayOtherBattle()
	if RegionUtils.isCN() then
		if ClientUtils.getServerTime() < (GameFsm.argLoginRespReconnect or 0) then
			Const.EQUIP_SWEEP_START_TIME = ResEquipTowerMisc[1].max_count - 1
		else
			Const.EQUIP_SWEEP_START_TIME = 0
		end
	end

	for equipTowerType, typeData in pairs(self.equipTowerData) do
		typeData.hasSweepTimes = Const.EQUIP_SWEEP_START_TIME or 0
	end

	local tickRound = math.floor(math.max(0, self.equipTowerTopTick - EQUIP_TOWER_LIMIT_START_TICK) / Const.TIME_ONE_WEEK)
	local nowRound = math.floor(math.max(0, ClientUtils.getServerTime() - EQUIP_TOWER_LIMIT_START_TICK) / Const.TIME_ONE_WEEK)

	if tickRound ~= nowRound then
		self.equipTowerTopTick = ClientUtils.getServerTime()

		for equipTowerType, typeData in pairs(self.equipTowerData) do
			typeData.limitTowerInfo = {}
		end
	end

	self:checkEquipTowerRD()

	local equipTowerLevelDlg = UIManager.tryGetUI("equipTowerLevelDlg")

	if equipTowerLevelDlg then
		equipTowerLevelDlg:onEquipTowerSuperSweepDataNotify()
		equipTowerLevelDlg:onEquipTowerDataNotify(equipTowerLevelDlg.currentPageIndex)
	end

	self:_onNewDayOpactPvp()
	self:newDayBossExpand()
end

function OtherBattleMixin:onAsyncPVPSysDataNotify(season, start_time)
	self.asyncPvpSysData = {
		season = season,
		end_time = start_time + ResPVP[1].refresh_day * 3600 * 24
	}
end

function OtherBattleMixin:onMazeSysDataNotify(season, end_time)
	self.mazeSysData = {
		season = season,
		end_time = end_time
	}

	self:checkMazeRefresh()
end

function OtherBattleMixin:getMazeLeftTime(...)
	if self.mazeSysData then
		if self.mazeData.season == self.mazeSysData.season or self.mazeData.last_days > 0 and self.mazeSysData.season == 1 then
			return self.mazeSysData.end_time - ClientUtils.getServerTime()
		else
			return -1
		end
	end

	return -1
end

function OtherBattleMixin:getAsyncPvpLeftTime(...)
	if self.asyncPvpSysData then
		return self.asyncPvpSysData.end_time - ClientUtils.getServerTime()
	end

	return -1
end

function OtherBattleMixin:initEquipTowerData(towerData)
	if RegionUtils.isCN() then
		if ClientUtils.getServerTime() < (GameFsm.argLoginRespReconnect or 0) then
			Const.EQUIP_SWEEP_START_TIME = ResEquipTowerMisc[1].max_count - 1
		else
			Const.EQUIP_SWEEP_START_TIME = 0
		end
	end

	self.equipTowerData = {}

	for equipTowerType, typeData in ipairs(towerData.data) do
		self.equipTowerData[equipTowerType] = {}
		self.equipTowerData[equipTowerType].limitTowerInfo = {}
		self.equipTowerData[equipTowerType].layer = typeData.pass_layer

		if Const.EQUIP_TOWER_OPEN_CUSTOM_LAYER then
			self.equipTowerData[equipTowerType].resId = typeData.resid
			self.equipTowerData[equipTowerType].gid = typeData.gid
		end

		if ClientUtils.getServerTimeTodayStart() > typeData.refresh_time then
			self.equipTowerData[equipTowerType].hasSweepTimes = Const.EQUIP_SWEEP_START_TIME or 0
		else
			self.equipTowerData[equipTowerType].hasSweepTimes = typeData.super_count
		end
	end

	self.equipTowerTopTick = towerData.last_update_top_time

	local tickRound = math.floor(math.max(0, self.equipTowerTopTick - EQUIP_TOWER_LIMIT_START_TICK) / Const.TIME_ONE_WEEK)
	local nowRound = math.floor(math.max(0, ClientUtils.getServerTime() - EQUIP_TOWER_LIMIT_START_TICK) / Const.TIME_ONE_WEEK)

	if tickRound == nowRound then
		for _, topTowerData in ipairs(towerData.top_data) do
			local equipTowerType = topTowerData.type
			local layer = topTowerData.layer
			local state = topTowerData.award

			if not self.equipTowerData[equipTowerType] then
				self.equipTowerData[equipTowerType] = {}
				self.equipTowerData[equipTowerType].limitTowerInfo = {}
			end

			self.equipTowerData[equipTowerType].limitTowerInfo[layer] = state
		end
	end

	self:checkEquipTowerRD()
end

function OtherBattleMixin:getEquipTowerLimitNumber(tick)
	if tick == nil then
		tick = ClientUtils.getServerTime()
	end

	local passed = math.max(0, tick - EQUIP_TOWER_LIMIT_START_TICK)

	return math.floor(passed / Const.TIME_ONE_WEEK) % EQUIP_TOWER_LIMIT_CIRCLE_NUM + 1
end

function OtherBattleMixin:getEquipTowerLimitRefreshTick(tick)
	if tick == nil then
		tick = ClientUtils.getServerTime()
	end

	local passed = math.max(0, tick - EQUIP_TOWER_LIMIT_START_TICK)

	return Const.TIME_ONE_WEEK - passed % Const.TIME_ONE_WEEK
end

function OtherBattleMixin:equipTowerisPass(equipTowerType, layer)
	if self.equipTowerData[equipTowerType] then
		return layer <= self.equipTowerData[equipTowerType].layer
	else
		return false
	end
end

function OtherBattleMixin:hasEquipTowerGetCustomLayer()
	for type, data in pairs(self.equipTowerData or {}) do
		local customLayer = self:getEquipTowerCustomLayer(type)

		if customLayer <= data.layer + 1 then
			return true
		end
	end

	return false
end

function OtherBattleMixin:getEquipTowerCustomLayer(equipTowerType)
	for i, data in ipairs(ResEquipTower[equipTowerType] or {}) do
		if data.layer_type and data.layer_type == Const.EQUIP_TOWER_LAYER_TYPE_CUSTOM then
			return data.layer
		end
	end

	return 39
end

function OtherBattleMixin:isEquipTowerNormalOver(equipTowerType)
	local equipTowerData = self.equipTowerData[equipTowerType] or {}
	local layer = equipTowerData.layer or 0
	local levelData = ResEquipTower[equipTowerType][layer + 1]

	return levelData and levelData.layer_type == Const.EQUIP_TOWER_LAYER_TYPE_FINAL
end

function OtherBattleMixin:checkEquipTowerRD()
	for equipTowerType = 1, 3 do
		if self.equipTowerData[equipTowerType] and self.equipTowerData[equipTowerType].layer > 0 and self:getEquipTowerSuperSweepTimes(equipTowerType) > 0 then
			RedDotManager.setKeyState(UIConst["RD_HINT_EQUIPTOWER" .. equipTowerType], true)
		elseif self:isEquipTowerLimitNew(equipTowerType) then
			RedDotManager.setKeyState(UIConst["RD_HINT_EQUIPTOWER" .. equipTowerType], true)
		else
			RedDotManager.setKeyState(UIConst["RD_HINT_EQUIPTOWER" .. equipTowerType], false)
		end
	end
end

Const.EQUIP_TOWER_LIMIT_LOOKED = {}

function OtherBattleMixin:isEquipTowerLimitNew(equipTowerType, fixedLayer)
	local equipTowerData = self.equipTowerData[equipTowerType] or {}
	local layer = equipTowerData.layer or 0
	local levelData = ResEquipTower[equipTowerType][layer + 1]

	if levelData and levelData.layer_type == Const.EQUIP_TOWER_LAYER_TYPE_WEEK then
		local limitTowerInfo = equipTowerData.limitTowerInfo

		if fixedLayer then
			local layerState = limitTowerInfo[fixedLayer]

			if not layerState or layerState == 0 then
				if Const.EQUIP_TOWER_LIMIT_LOOKED[equipTowerType] and Const.EQUIP_TOWER_LIMIT_LOOKED[equipTowerType][fixedLayer] then
					return false
				else
					return true
				end
			end
		else
			for index = layer + 1, #ResEquipTower[equipTowerType] do
				local layerState = limitTowerInfo[index]

				if not layerState or layerState == 0 then
					if Const.EQUIP_TOWER_LIMIT_LOOKED[equipTowerType] and Const.EQUIP_TOWER_LIMIT_LOOKED[equipTowerType][index] then
						return false
					else
						return true
					end
				end
			end
		end
	end

	return false
end

function OtherBattleMixin:onEquipTowerSuperSweepDataNotify(refresh_time, super_count, equipTowerType)
	self.equipTowerData[equipTowerType].hasSweepTimes = super_count

	self:checkEquipTowerRD()

	local equipTowerLevelDlg = UIManager.tryGetUI("equipTowerLevelDlg")

	if equipTowerLevelDlg then
		equipTowerLevelDlg:onEquipTowerSuperSweepDataNotify()
	end
end

function OtherBattleMixin:getEquipTowerSuperSweepTimes(equipTowerType)
	local hasSweepTimes = Const.EQUIP_SWEEP_START_TIME or 0

	if self.equipTowerData[equipTowerType] then
		hasSweepTimes = self.equipTowerData[equipTowerType].hasSweepTimes
	end

	local sweepExtraCount = self:getPrivilegeValue(Const.PRIVITY_KEY_EQUIP_TOWER_SWEEP)

	return math.max(0, sweepExtraCount + ResEquipTowerMisc[1].max_count - hasSweepTimes)
end

function OtherBattleMixin:onEquipTowerDataNotify(equipTowerType, layer, top_layer, last_time, award)
	if not self.equipTowerData[equipTowerType] then
		self.equipTowerData[equipTowerType] = {}
		self.equipTowerData[equipTowerType].limitTowerInfo = {}
	end

	self.equipTowerData[equipTowerType].layer = layer

	if top_layer and top_layer > 0 then
		self.equipTowerTopTick = last_time
		self.equipTowerData[equipTowerType].limitTowerInfo[top_layer] = award
	end

	self:checkEquipTowerRD()

	local ui = UIManager.getUI("equipTowerLevelDlg", nil, false)

	if ui then
		ui:onEquipTowerDataNotify(equipTowerType, layer)
	end
end

function OtherBattleMixin:onEquipTowerSweepResp(equipTowerType, layer, times)
	local ui = UIManager.getUI("equipTowerLevelDlg", nil, false)

	if ui then
		ui:onEquipTowerSweepResp()
	end

	local heroEquipEvolutionDlg = UIManager.getUI("heroEquipEvolutionDlg", nil, false)

	if heroEquipEvolutionDlg then
		heroEquipEvolutionDlg.panelEvo.lackInfo = {}

		heroEquipEvolutionDlg.panelEvo:refreshMaterialInfo()
	end

	local cleanResultDlg = UIManager.getUI("cleanResultDlg", nil, false)

	if cleanResultDlg and ResEquipTower[equipTowerType] and ResEquipTower[equipTowerType][layer] then
		local levelData = ResEquipTower[equipTowerType][layer]

		local function AgainFunc()
			local needPower = levelData.power_cost * times

			if needPower <= self.realPowerNum then
				if self:getEquipRemainBlankNum() <= 0 then
					self:confirmBagAdd(Const.BAG_TYPE_EQUIP)

					return
				end

				RPC.equipTowerSweep(levelData.type, levelData.layer, times)
			else
				MsgManager.clientNotice(155)
			end
		end

		cleanResultDlg:setAgainConfig(AgainFunc, string.format(Lang.get(1871), times), levelData.power_cost * times)
	end
end

function OtherBattleMixin:onEquipTowerReplayRecordResp(eType, layer, data)
	local ui = UIManager.getUI("equipTowerLevelDlg", nil, false)

	if ui then
		ui:onEquipTowerReplayRecordResp(eType, layer, data)
	end
end

function OtherBattleMixin:onEquipTowerChooseHeroResp(type, layer, hero_id, gid)
	if self.equipTowerData then
		self.equipTowerData[type].resId = hero_id
		self.equipTowerData[type].gid = gid
	end

	local ui = UIManager.tryGetUI("equipTowerChooseSuitDlg")

	if ui then
		MsgManager.notice(Lang.get(51290))
		ui:setVisible(false)
	end

	local backUI = UIManager.tryGetUI("equipTowerLevelDlg")

	if backUI then
		backUI:onEquipTowerChooseHeroResp(type, layer, hero_id)
	end
end

function OtherBattleMixin:onOpActTowerReplayRecordResp(tower_id, layer, data)
	local ui = UIManager.getUI("activitySeasonTowerInfoDlg", nil, false)

	if ui then
		ui:onOpActTowerReplayRecordResp(tower_id, layer, data)
	end
end

function OtherBattleMixin:onOpActTowerGetScoreAwardResp(score)
	if score > 0 then
		UIManager.getUI("activitySeasonScoreBonusDlg", true):onShow(score)
	end
end

function OtherBattleMixin:onOnceTowerDataNotify(layer)
	self.onceTowerLevel = layer

	local ui = UIManager.getUI("onceTowerLevelDlg", nil, false)

	if ui then
		ui:refreshData()
	end
end

function OtherBattleMixin:onOnceTowerReplayRecordResp(layer, data)
	local ui = UIManager.getUI("onceTowerLevelDlg", nil, false)

	if ui then
		ui:onOnceTowerReplayRecordResp(layer, data)
	end
end

function OtherBattleMixin:initAsyncPvpData(asyncPvpData)
	self.asyncPvpData = asyncPvpData
	ClientUtils.nextGetReportTick = 0
	self.nextMatchTick = 0
	self.pvpAttackTimes = asyncPvpData.attack_times
	self.asyncPVPDefendFormation = {}

	for index, coordInfo in ipairs(asyncPvpData.defend.hero) do
		self.asyncPVPDefendFormation[coordInfo.gid] = coordInfo.idx
	end

	local infos = {}

	infos.petId = asyncPvpData.defend.pet
	self.formationOtherInfos[Const.FORMATION_ASYNC_DEFEND] = infos

	self:checkPvpFormationRedHint()

	self.rankFormation = {}
	ClientUtils.record.reportStatus = asyncPvpData.report_status

	self:setPvpRecordRedHint()
end

function OtherBattleMixin:onAsyncPVPAttackTimesNotify(times, need_refresh)
	self.pvpAttackTimes = times

	if need_refresh == 1 then
		self.nextMatchTick = 0
	end
end

function OtherBattleMixin:onAsyncPVPFormationResp(formation, petId)
	self.asyncPVPDefendFormation = {}

	for index, coordInfo in ipairs(formation) do
		self.asyncPVPDefendFormation[coordInfo.gid] = coordInfo.idx
	end

	local infos = self.formationOtherInfos[Const.FORMATION_ASYNC_DEFEND] or {}

	infos.petId = petId
	self.formationOtherInfos[Const.FORMATION_ASYNC_DEFEND] = infos

	self:checkPvpFormationRedHint()
	self:initHeroTeamInfo()

	local pvpMainDlg = UIManager.getUI("pvpMainDlg", nil, false)

	if pvpMainDlg then
		pvpMainDlg:initMyLocalInfo()
	end
end

function OtherBattleMixin:checkPvpFormationRedHint(...)
	local result = false
	local isNeedCheckLocal = true

	if self:isFormationSnapShot(Const.FORMATION_ASYNC_DEFEND) and self:isSnapFormationFull(Const.FORMATION_ASYNC_DEFEND, 5) then
		isNeedCheckLocal = false
	end

	if isNeedCheckLocal then
		local ownCount = math.min(5, CurAvatar:getHeroCount())
		local formationCount = utils.getTableElemCount(self.asyncPVPDefendFormation)

		result = formationCount ~= ownCount and not ConditionLimitManager.inGamePlayLimitState(Const.GAME_PLAY_NOTICE_ARENA)
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_PVP_FORMATION, result)
end

function OtherBattleMixin:getAsyncPVPFormationCapacity()
	return PVPCommon.getMyAsyncPvpPower()
end

function OtherBattleMixin:onAsyncPVPBriefNotify(base)
	self.tempOpponent = {}

	for i, data in ipairs(base) do
		table.insert(self.tempOpponent, {
			base = data
		})
	end

	self:initPvpMatchData()
end

function OtherBattleMixin:onAsyncPVPDetailNotify(opponent, type)
	if type == Const.ASYNCPVP_DETAIL_TYPE_MATCH then
		-- block empty
	elseif type == Const.ASYNCPVP_DETAIL_TYPE_REPORT then
		-- block empty
	elseif type == Const.ASYNCPVP_DETAIL_TYPE_RANK then
		for _, data in ipairs(opponent) do
			local uid = data.base.comm.uid

			self.rankFormation[uid] = {}
			self.rankFormation[uid].formation = data.formation
			self.rankFormation[uid].tick = Time.time

			local pvpMainDlg = UIManager.getUI("pvpMainDlg", nil, false)

			if pvpMainDlg then
				pvpMainDlg.panelRankList:setExtendCellFormation()
			end

			local pvpEnemyDlg = UIManager.getUI("pvpEnemyDlg", nil, false)

			if pvpEnemyDlg then
				pvpEnemyDlg:refreshList()
			end

			local pvpRecordDlg = UIManager.getUI("pvpRecordDlg", nil, false)

			if pvpRecordDlg then
				pvpRecordDlg:refreshList()
			end
		end
	end
end

function OtherBattleMixin:readyForPvpRecord()
	if self.tempPvpReport and ClientUtils.nextGetReportTick > ClientUtils.getServerTime() then
		ClientUtils.record.pvpReport = {}

		for _, r in ipairs(self.tempPvpReport) do
			local t = {}

			t.extend = false
			t.report = r

			local uid = 0

			if r.attack.comm.uid == self.uid then
				uid = r.defend.comm.uid

				PVPCommon.checkAndChangeRobotCommInfo(r.defend.comm, Const.ROLEINFO_ROBOT_TYPE_ASYNCPVP)
			else
				uid = r.attack.comm.uid

				PVPCommon.checkAndChangeRobotCommInfo(r.attack.comm, Const.ROLEINFO_ROBOT_TYPE_ASYNCPVP)
			end

			t.otherUid = uid

			table.insert(ClientUtils.record.pvpReport, t)
		end

		table.sort(ClientUtils.record.pvpReport, function(v1, v2)
			return v1.report.base.tick > v2.report.base.tick
		end)

		local ui = UIManager.getUI("pvpRecordDlg", nil, false)

		if ui then
			ui:show(true)
		end

		self.tempPvpReport = nil
	end
end

function OtherBattleMixin:onAsyncPVPScoreResp(scores)
	self.tempPvpScores = scores

	self:initPvpMatchData()

	if scores then
		for _, data in ipairs(scores) do
			self:refreshOpponentInfo(data.uid, data.score)
		end
	end

	local ui = UIManager.getUI("pvpEnemyDlg", nil, false)

	if ui then
		ui:refreshList()
	end
end

function OtherBattleMixin:initPvpMatchData()
	if self.tempPvpScores and self.tempOpponent then
		for _, opponent in ipairs(self.tempOpponent) do
			local comm = opponent.base.comm

			PVPCommon.checkAndChangeRobotCommInfo(comm, Const.ROLEINFO_ROBOT_TYPE_ASYNCPVP)

			local matched = false

			for _, scoreData in ipairs(self.tempPvpScores) do
				if opponent.base.comm.uid == scoreData.uid then
					opponent.score = scoreData.score
					matched = true

					break
				end
			end

			if not matched then
				-- block empty
			end
		end
	else
		return
	end

	ClientUtils.record.allOpponent = {
		{},
		{},
		{}
	}

	local repeatDic = {}

	for i = #self.tempOpponent, 1, -1 do
		local v = self.tempOpponent[i]

		if repeatDic[v.base.comm.uid] then
			table.remove(self.tempOpponent, i)
		else
			repeatDic[v.base.comm.uid] = true
		end
	end

	table.sort(self.tempOpponent, function(v1, v2)
		return v1.score > v2.score
	end)

	local myPower = self:getNowFormationCapacity(Const.FORMATION_MAIN_STAGE) or 0
	local aveNum = math.ceil(#self.tempOpponent / 3)
	local offset = ResPVP[1].mid_min

	for i = 1, 3 do
		for j, v in ipairs(self.tempOpponent) do
			if v.score and j > (i - 1) * aveNum and j <= i * aveNum then
				local t = {}

				t.extend = false
				t.randomWeight = 100
				t.data = v

				if v.score < self:getPvpScore() + offset and myPower > v.base.power then
					t.canClean = true
				end

				table.insert(ClientUtils.record.allOpponent[i], t)
			end
		end
	end

	local ui = UIManager.getUI("pvpEnemyDlg", nil, false)

	if ui then
		if #self.tempOpponent > 0 then
			ui:show(true)
			ui:setEmpty(false)
		else
			ui:setEmpty(true)
		end
	end

	self.tempOpponent = nil
	self.tempPvpScores = nil
end

function OtherBattleMixin:refreshOpponentInfo(uid, newScore, formation)
	if ClientUtils.record.allOpponent then
		for i, opponents in ipairs(ClientUtils.record.allOpponent) do
			for j, opponent in ipairs(opponents) do
				if opponent.data.base.comm.uid == uid then
					opponent.data.score = newScore
					opponent.data.formation = formation or opponent.data.formation

					break
				end
			end
		end
	end
end

function OtherBattleMixin:getPvpFreeCount(...)
	local count = ResPVP[1].free_count

	return math.floor(self:getPrivilegeValue(Const.PRIVITY_KEY_ARENA_COUNT, count))
end

function OtherBattleMixin:onAsyncPVPReportGetResp(tick)
	ClientUtils.nextGetReportTick = tick or 0
	ClientUtils.nextGetReportSeasonId = self.asyncPvpSysData and self.asyncPvpSysData.season or 0

	self:readyForPvpRecord()
end

function OtherBattleMixin:onAsyncPVPReportNotify(report)
	self.tempPvpReport = report

	self:readyForPvpRecord()
end

function OtherBattleMixin:onAsyncPVPUpdateNotify(data)
	self.asyncPvpData = data
	self.pvpRank = nil

	local ui = UIManager.getUI("pvpMainDlg", nil, false)

	if ui then
		ui:refreshTime()
	end

	ui = UIManager.getUI("pvpRankAwardDlg", nil, false)

	if ui then
		ui:refreshTime()
	end
end

OtherBattleMixin.nextMatchTick = 1000000000

function OtherBattleMixin:onAsyncPVPMatchResp(tick)
	self.nextMatchTick = tick
end

function OtherBattleMixin:onAsyncPVPSweepResp(uid, add_item)
	local ui = UIManager.getUI("pvpResultCleanDlg", true)

	if ui then
		local myData = {}
		local enemyData = {}

		ui:show(myData, enemyData, add_item)
	end

	ui = UIManager.getUI("pvpEnemyDlg", nil, false)

	if ui then
		ui:refreshList()
	end
end

function OtherBattleMixin:onAsyncPVPSettleNotify(attack, defend)
	self.pvpResult = {
		attack = attack,
		defend = defend
	}

	local isUIOpen = false
	local ui = UIManager.getUI("pvpResultDlg", nil, false)

	if ui then
		isUIOpen = true

		ui:showData(attack, defend)
	end

	ui = UIManager.getUI("pvpResultCleanDlg", nil, false)

	if ui then
		isUIOpen = true

		ui:showData(attack, defend)
	end

	if not isUIOpen then
		local PVPResultDlg = require("UI/PVPMode/PVPResultDlg")

		PVPResultDlg.setPvpResultData(self.pvpResult)
	end
end

function OtherBattleMixin:onAsyncPVPReportStatusNotify(report_status)
	ClientUtils.record.reportStatus = report_status

	if ClientUtils.record.reportStatus > 0 then
		if ClientUtils.nextGetReportTick > ClientUtils.getServerTime() then
			if self.pvpRecordHintTimeDown then
				self.pvpRecordHintTimeDown:Stop()
			end

			self.pvpRecordHintTimeDown = Timer.New(Slot(self.setPvpRecordRedHint, self), ClientUtils.nextGetReportTick - ClientUtils.getServerTime(), 1)

			self.pvpRecordHintTimeDown:Start()
		else
			self:setPvpRecordRedHint()
		end
	else
		self:setPvpRecordRedHint()
	end
end

function OtherBattleMixin:setPvpRecordRedHint(...)
	local redTip = false
	local interval = 259200

	if not Framework.Tools.LuaToolkit.IsEditor() then
		interval = 259200
	end

	if ClientUtils.record.reportStatus + interval > ClientUtils.getServerTime() then
		redTip = true
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_PVP_RECORD, redTip)
end

function OtherBattleMixin:initBossTowerData(data)
	local baseData = data.boss_tower

	self.mBossTowerInfos = {}

	for i, bossInfo in ipairs(baseData.data) do
		self.mBossTowerInfos[i] = bossInfo
	end

	local todayStart = ClientUtils.getServerTimeTodayStart()

	if todayStart > baseData.last_time then
		self:newDayBossTower(true)
	end
end

function OtherBattleMixin:newDayBossTower(fromInit)
	for bossType, bossInfo in pairs(self.mBossTowerInfos) do
		bossInfo.award = 0
	end

	for i, uiName in pairs({
		"bossChooseDlg",
		"bossMainDlg"
	}) do
		local ui = UIManager.getUI(uiName, nil, false)

		if ui then
			ui:show()
		end
	end

	if not fromInit then
		self:checkChallengeBossHint()
	end
end

function OtherBattleMixin:onBossTowerAwardGetResp(award_ids, bossType, sweep_tick)
	return
end

function OtherBattleMixin:onBossTowerDataNotify(bossType, data)
	self.mBossTowerInfos[bossType] = data

	local ui = UIManager.getUI("bossChooseDlg", nil, false)

	if ui then
		ui:show()
	end

	ui = UIManager.getUI("bossMainDlg", nil, false)

	if ui then
		ui:show(bossType)
	end

	self:checkChallengeBossHint()
end

function OtherBattleMixin:checkChallengeBossHint()
	local isLock = ConditionLimitManager.inGamePlayLimitState(Const.GAME_PLAY_NOTICE_CHALLENGE_BOSS)
	local isLockDays = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BOSS_TOWER_EX)

	for bossType, bossData in pairs(ResBossTower) do
		local defData = ResBossTowerMisc[bossType]

		if isLock then
			RedDotManager.setKeyState(UIConst["RD_HINT_CHALLENGE_BOSS_" .. bossType], false)
		elseif isLockDays and defData.open_days then
			RedDotManager.setKeyState(UIConst["RD_HINT_CHALLENGE_BOSS_" .. bossType], false)
		elseif ClientUtils.notToday(defData.open_days) then
			RedDotManager.setKeyState(UIConst["RD_HINT_CHALLENGE_BOSS_" .. bossType], false)
		elseif ConditionLimitManager.inLimitState(defData.lock_id) then
			RedDotManager.setKeyState(UIConst["RD_HINT_CHALLENGE_BOSS_" .. bossType], false)
		else
			local bossInfo = self.mBossTowerInfos[bossType] or {}

			if bossInfo.award == 0 and not ClientUtils.isTickToday(bossInfo.sweep_tick) then
				if bossType == Const.BOSS_TOWER_TYPE_ZOMBIE and not self:isInCircle() then
					RedDotManager.setKeyState(UIConst["RD_HINT_CHALLENGE_BOSS_" .. bossType], false)
				else
					RedDotManager.setKeyState(UIConst["RD_HINT_CHALLENGE_BOSS_" .. bossType], true)
				end
			else
				RedDotManager.setKeyState(UIConst["RD_HINT_CHALLENGE_BOSS_" .. bossType], false)
			end
		end
	end
end

function OtherBattleMixin:getChallengeBossAwardNum(bossType)
	if self.mBossTowerInfos[bossType] then
		return self.mBossTowerInfos[bossType].award or 0
	end

	return 0
end

function OtherBattleMixin:onBossTowerReplayRecordResp(eType, layer, data)
	local ui = UIManager.getUI("bossMainDlg", nil, false)

	if ui then
		ui:onBossTowerReplayRecordResp(eType, layer, data)
	end
end

function OtherBattleMixin:initBossExpandData(data)
	local maxLayer = 0

	for tower, layerData in ipairs(ResBossTowerExpandLevel) do
		maxLayer = math.max(#layerData, maxLayer)
	end

	self.bossExpandData = utils.deepcopy(data)

	for i, bossData in ipairs(self.bossExpandData.boss_data) do
		if bossData then
			if not ClientUtils.isTickToday(bossData.refresh_time) then
				bossData.refresh_time = ClientUtils.getServerTime()
				bossData.sweep_cnt = 0
			end

			for _, typeData in ipairs(bossData.type_data) do
				typeData.layer_data = typeData.layer_data or {}

				if maxLayer > #typeData.layer_data then
					for j = 1, maxLayer - #typeData.layer_data do
						table.insert(typeData.layer_data, {
							pass_level = 0
						})
					end
				end
			end
		end
	end
end

function OtherBattleMixin:getBossExpandSweepMaxNum()
	local total = ResBossTowerExpandMisc[1].clean_times

	return self:getPrivilegeValue(Const.PRIVITY_KEY_EXPAND_BOSS, total)
end

function OtherBattleMixin:checkBossExpandChanged(...)
	local ui = UIManager.tryGetUI("mainStageDlg")

	if ui then
		ui:checkBossExpandOpen()
	end

	self:checkBossExpandCleanRedHint()
end

function OtherBattleMixin:newDayBossExpand(...)
	if self.bossExpandData then
		for i, info in ipairs(self.bossExpandData.boss_data) do
			info.refresh_time = ClientUtils.getServerTime()
			info.sweep_cnt = 0
		end
	end

	self:checkBossExpandCleanRedHint()
end

function OtherBattleMixin:checkBossExpandCleanRedHint(...)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BOSS_EXPAND) or not Const.IS_NEW_BOSSTOWER_SHOW then
		return
	end

	if self.bossExpandData then
		for i, info in ipairs(self.bossExpandData.boss_data) do
			RedDotManager.setKeyState(UIConst["RD_HINT_CHALLENGE_BOSS_EXPAND_" .. i], info.sweep_cnt < self:getBossExpandSweepMaxNum())
		end
	end
end

function OtherBattleMixin:checkBossExpandCanSweep(towerType, layer)
	if self.bossExpandData then
		local info = ResBossTowerExpandCamp[towerType]
		local bossData = self.bossExpandData.boss_data[info.boss_id]

		if bossData then
			local campData = bossData.type_data[info.camp]

			if campData then
				local layerData = campData.layer_data[layer]

				if layerData then
					return layerData.pass_level > 0
				end
			end
		end
	end

	return false
end

function OtherBattleMixin:getBossExpandPassLevel(towerType, layer)
	if self.bossExpandData then
		local info = ResBossTowerExpandCamp[towerType]
		local bossData = self.bossExpandData.boss_data[info.boss_id]

		if bossData then
			local campData = bossData.type_data[info.camp]

			if campData then
				local layerData = campData.layer_data[layer]

				if layerData then
					return layerData.pass_level
				end
			end
		end
	end

	return 0
end

function OtherBattleMixin:getRelationMaterialCanSweep(itemId)
	if ResItem[itemId].get_ids then
		for _, getId in ipairs(ResItem[itemId].get_ids) do
			local args = ResGuideGet[getId].condition_args
			local conditionOutput = self:getBossExpandCondition(args)

			if self:getIsConditionAllPass(conditionOutput) then
				return true
			end
		end

		return false
	else
		return false
	end
end

function OtherBattleMixin:getRelationMaterialLayer(itemId)
	if ResItem[itemId].get_ids then
		local args = ResGuideGet[ResItem[itemId].get_ids[1]].condition_args

		if args then
			local towerType = tonumber(args[1])
			local layer = tonumber(args[2])

			return towerType, layer
		end
	end
end

function OtherBattleMixin:getCanFastSweepRelationMaterials(hero, relation)
	local lackMaterials = hero:getRelationPointNeedMaterial(relation, true)

	if lackMaterials and relation > 0 then
		local sweepInfoList = self:getRelationMaterialsSweepInfo(hero, relation)
		local needPower = 0

		if #sweepInfoList ~= #lackMaterials then
			return false, needPower
		else
			local sweepTowerCntDic = {}
			local sweepTowerPowerDic = {}

			for _, sweepInfo in ipairs(sweepInfoList) do
				if self:checkBossExpandCanSweep(sweepInfo.tower, sweepInfo.layer) then
					sweepTowerCntDic[sweepInfo.tower] = (sweepTowerCntDic[sweepInfo.tower] or 0) + sweepInfo.times
					needPower = (needPower or 0) + sweepInfo.power * sweepInfo.times
				else
					return false, needPower
				end
			end

			for tower, times in pairs(sweepTowerCntDic) do
				local remainCnt, totalCnt = self:getBossExpandSweepCount(tower)

				if remainCnt < times then
					return false, needPower
				end
			end

			return true, needPower
		end
	else
		return false, 0
	end
end

function OtherBattleMixin:getRelationMaterialsSweepInfo(hero, relation)
	local lackMaterials = hero:getRelationPointNeedMaterial(relation, true)
	local sweepInfoList = {}

	for _, idNum in ipairs(lackMaterials) do
		local itemId = idNum.id
		local needNum = idNum.num
		local curCount = self:getItemNumById(idNum.id)
		local towerType, towerLayer = self:getRelationMaterialLayer(itemId)

		if towerType and towerLayer and ResBossTowerExpandLevel[towerType] and ResBossTowerExpandLevel[towerType][towerLayer] and self:isBossExpandLayerOpen(towerType, towerLayer) then
			local levelConfig = ResBossTowerExpandLevel[towerType][towerLayer]
			local bossExpandLevel = self:getBossExpandSweepDiff(towerType, towerLayer)
			local towerRes = levelConfig[bossExpandLevel]

			if towerRes then
				local costNum = towerRes.power_cost
				local rewardIdSweep = towerRes.clean_award
				local randItemSweep = ResRandClient[rewardIdSweep]
				local getNumOnce = 0

				for i, id in ipairs(randItemSweep.show_ids) do
					if id == itemId then
						getNumOnce = randItemSweep.show_nums and randItemSweep.show_nums[i] and randItemSweep.show_nums[i] or 1
					end
				end

				if getNumOnce > 0 then
					local sweepCount = math.ceil((needNum - curCount) / getNumOnce)

					table.insert(sweepInfoList, {
						tower = towerType,
						layer = towerLayer,
						diff = bossExpandLevel,
						times = sweepCount,
						power = costNum
					})
				end
			end
		end
	end

	return sweepInfoList
end

function OtherBattleMixin:getBossExpandSweepDiff(towerType, layer)
	local levelConfig = ResBossTowerExpandLevel[towerType][layer]
	local bossExpandLevel = 0

	if self.bossExpandData then
		local info = ResBossTowerExpandCamp[towerType]
		local serverLayerData = self.bossExpandData.boss_data[info.boss_id].type_data[info.camp].layer_data[layer]

		if serverLayerData then
			bossExpandLevel = math.min(serverLayerData.pass_level, #levelConfig)
		end
	end

	return bossExpandLevel
end

function OtherBattleMixin:getBossExpandMaxLayerNum(tower)
	local towerConfig = ResBossTowerExpandLevel[tower]

	if not towerConfig then
		return 0
	end

	local max = 0

	for i, layerData in ipairs(towerConfig) do
		if layerData[1] and layerData[1].is_open == 1 then
			max = i
		else
			break
		end
	end

	return max
end

function OtherBattleMixin:isBossExpandLayerOpen(tower, layer)
	local data = ResBossTowerExpandLevel[tower][layer]

	if data and data[1] then
		return data[1].is_open == 1
	end
end

function OtherBattleMixin:getBossExpandCurLayer(towerType)
	local maxLayer = 1

	if self.bossExpandData then
		local info = ResBossTowerExpandCamp[towerType]
		local layerConfig = ResBossTowerExpandLevel[towerType]
		local bossData = self.bossExpandData.boss_data[info.boss_id]

		if bossData then
			local campData = bossData.type_data[info.camp]

			if campData then
				for i = #campData.layer_data, 1, -1 do
					if campData.layer_data[i].pass_level > 0 then
						return math.min(self:getBossExpandMaxLayerNum(towerType), i + 1)
					end
				end
			end
		end
	end

	return maxLayer
end

function OtherBattleMixin:getBossExpandSweepCount(towerType)
	local info = ResBossTowerExpandCamp[towerType]
	local total = self:getBossExpandSweepMaxNum()
	local cleanedTimes = self.bossExpandData.boss_data[info.boss_id].sweep_cnt or 0

	return total - cleanedTimes, total
end

function OtherBattleMixin:jumpToBossExpandCurStage(towerType, layer)
	if not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BOSS_EXPAND) and Const.IS_NEW_BOSSTOWER_SHOW then
		local ui = UIManager.getUI("bossExpandMainDlg", true)

		if ui then
			ui:jumpToTowerAndLayer(towerType, layer)
		end
	end
end

function OtherBattleMixin:isBossExpandMaxLevel(tower, layer, level)
	local info = ResBossTowerExpandLevel[tower]

	if info then
		return #info[layer] == level
	end
end

function OtherBattleMixin:onCampTowerDataNotify(tower, layer, level)
	local info = ResBossTowerExpandCamp[tower]
	local config = ResBossTowerExpandLevel[tower]

	if self.bossExpandData then
		local data = self.bossExpandData.boss_data[info.boss_id].type_data[info.camp].layer_data[layer]
		local layerData = config[layer]

		if data.pass_level ~= level then
			local isHighest = false
			local cacheData = {}

			if level == 1 and layer < self:getBossExpandMaxLayerNum(tower) then
				cacheData.isNewLayer = true
				cacheData.isNewDiff = true
			elseif level == #layerData then
				cacheData.isHighest = true
			else
				cacheData.isNewDiff = true
			end

			cacheData.level = level
			self.bossExpandLevelTip = cacheData
		end

		data.pass_level = level
	end

	local ui = UIManager.tryGetUI("bossExpandMainDlg")

	if ui then
		ui:refreshLevelUI()
	end
end

function OtherBattleMixin:onCampTowerSweepResp(data)
	local sweepMainDlg = UIManager.getUI("sweepMainDlg", nil, false)

	if not sweepMainDlg then
		MsgManager.clientNotice(629)
	end

	if self.bossExpandData then
		for i, info in ipairs(data) do
			local config = ResBossTowerExpandCamp[info.tower]

			self.bossExpandData.boss_data[config.boss_id].sweep_cnt = self.bossExpandData.boss_data[config.boss_id].sweep_cnt + info.times
		end
	end

	local ui = UIManager.tryGetUI("bossExpandMainDlg")

	if ui then
		ui:refreshUI()
	end

	ui = UIManager.tryGetUI("bossChooseDlg")

	if ui then
		ui:refreshUI()
	end

	self:checkBossExpandCleanRedHint()
	self:checkRelationHeroNewHint()

	local heroShowRoomGrowUpDlg = UIManager.getUI("heroShowRoomGrowUpDlg", nil, false)

	if heroShowRoomGrowUpDlg then
		heroShowRoomGrowUpDlg:refreshDetailInfo()
	end
end

function OtherBattleMixin:onCampTowerReplayRecordResp(tower, layer, level, data)
	local ui = UIManager.tryGetUI("bossExpandMainDlg")

	if ui then
		ui:onPenaltyZoneReplayRecordResp(tower, layer, level, data)
	end
end

function OtherBattleMixin:onCampTowerUpdateStageResp(stage)
	if self.bossExpandData then
		self.bossExpandData.stage = stage
	end
end

function OtherBattleMixin:isBossExpandCleanMind()
	if self.bossExpandData.stage <= 0 then
		return
	end

	local season, chapter, level = ClientUtils.parseStage(self.bossExpandData.stage)
	local info = ResStage[season][chapter]
	local total = level + ResBossTowerExpandMisc[1].stage_mind_gap

	if info then
		if total > #info then
			info = ResStage[season][chapter + 1]

			if info then
				return self:mainStageStatePassed(season, chapter + 1, total - #info)
			end
		else
			return self:mainStageStatePassed(season, chapter, total)
		end
	end
end

function OtherBattleMixin:isBossExpandCanFightHigher(tower, layer)
	if self.bossExpandData then
		local levelConfig = ResBossTowerExpandLevel[tower][layer]
		local info = ResBossTowerExpandCamp[tower]
		local passLevel = self.bossExpandData.boss_data[info.boss_id].type_data[info.camp].layer_data[layer].pass_level

		if passLevel < #levelConfig then
			return true
		end
	end
end

function OtherBattleMixin:getLayerNameByLevel(levelId)
	local des

	for towerId, Bossdata in ipairs(ResBossTowerExpandLevel) do
		for camp, layerData in ipairs(Bossdata) do
			for diff, levelData in ipairs(layerData) do
				if levelId == levelData.level_id then
					local bossId = ResBossTowerExpandCamp[towerId].boss_id

					des = utils.format(Lang.get(49882), levelData.layer, UIConst.BOSS_EXPAND_DIFF_CONFIG[diff].des)

					break
				end
			end

			if des then
				break
			end
		end

		if des then
			break
		end
	end

	return des or ""
end

function OtherBattleMixin:initMazeData(data)
	self.mazeData = data

	self:checkMazeRefresh()
	self:refreshMazeHeros()
end

function OtherBattleMixin:refreshMazeHeros()
	self.mazeHeroNum = 0

	for _, roleInfo in ipairs(self.mazeData.record) do
		local hero = self.heroDic[roleInfo.gid]

		self.mazeHeroNum = self.mazeHeroNum + 1

		if hero then
			hero:setMazeAttr(roleInfo.hp)
		end
	end
end

function OtherBattleMixin:setMazeState()
	local result = self.needResetMaze and not ConditionLimitManager.inGamePlayLimitState(Const.GAME_PLAY_NOTICE_MAZE)

	result = result or false

	RedDotManager.setKeyState(UIConst.RD_HINT_MAZE, result)
end

function OtherBattleMixin:onMazeHeroRecordUpdateNotify(hero)
	if self.heroDic[hero.gid] then
		self.heroDic[hero.gid]:setMazeAttr(hero.hp)
	end
end

function OtherBattleMixin:onMazeUpdateNotify(maze)
	local preLayer = self.mazeData.layer
	local isReset = #maze.record == 0

	if isReset then
		self:resetHero(self.mazeData)
	end

	self.mazeData = maze

	self:checkMazeRefresh(true)

	if preLayer ~= maze.layer and maze.node_id == 0 and self.showMazeChange == true then
		UIManager.getUI("mazeChangeDlg", true):show()

		self.showMazeChange = nil
	end

	self:refreshMazeHeros()

	local ui = UIManager.getUI("mazeMainDlg", nil, false)

	if ui then
		ui:refreshTime()
		ui:show()
	end
end

function OtherBattleMixin:getMazeHeroLimit(...)
	local configLimit = ResMazeMisc[1].battle_count

	if self.mazeData then
		local houseLimit = RearHouseCommon.getCrystalNum(self.mazeData.house_level)

		return math.min(Const.MAZE_MAX_HERO_LIMIT, math.max(houseLimit, configLimit))
	end

	return math.min(Const.MAZE_MAX_HERO_LIMIT, configLimit)
end

function OtherBattleMixin:resetHero(preMazeData)
	if not preMazeData then
		return
	end

	for _, roleInfo in ipairs(preMazeData.record) do
		local hero = self.heroDic[roleInfo.gid]

		if hero then
			hero:resetMazeAttr()
		end
	end
end

function OtherBattleMixin:isMazeFinish(...)
	if self.mazeData and self.mazeData.layer > 0 and self.mazeData.maze_id > 0 then
		local data = ResMaze[self.mazeData.maze_id][self.mazeData.layer]

		if self.mazeData.node_id >= #data then
			return true
		end
	end

	return false
end

function OtherBattleMixin:getNextMazeRefreshSeconds(...)
	local leftTime = self:getMazeLeftTime()

	if self.needResetMaze then
		return leftTime, false
	end

	if self.mazeData then
		local layer = self.mazeData.layer

		if self.mazeData.maze_id ~= 0 and layer ~= 0 then
			local data = ResMaze[self.mazeData.maze_id][layer]

			if data == nil or self.mazeData.node_id < #data then
				return leftTime, false
			end
		else
			return -1, false
		end
	end

	return leftTime, true
end

function OtherBattleMixin:onMazeSelectBranchResp(branch_index)
	local ui = UIManager.getUI("mazeMainDlg", nil, false)

	if ui then
		ui:show()
	end
end

function OtherBattleMixin:onMazeSelectRelicsResp(relics_index)
	local ui = UIManager.getUI("mazeMainDlg", nil, false)

	if ui then
		ui:show()
	end
end

function OtherBattleMixin:onMazeSelectResp(maze_id)
	self.needResetMaze = false

	self:setMazeState()

	self.reminded = false

	GameFsm.translateState(Const.STATE_MAIN_MAZE)
end

function OtherBattleMixin:onMazeRelicsNotify(relics)
	return
end

function OtherBattleMixin:onMazeRelicsRandNotify(relics)
	return
end

function OtherBattleMixin:checkMazeRefresh(noTip)
	if self.mazeData and self.mazeSysData then
		if self.mazeData.maze_id <= 0 then
			self.needResetMaze = true
		elseif self.mazeData.last_days > 0 and self.mazeSysData.season == 1 then
			-- block empty
		elseif self.mazeData.season ~= self.mazeSysData.season then
			self.needResetMaze = true
		end

		self:setMazeState()

		if not noTip and self.needResetMaze then
			self:resetMazeTip()
		end
	end
end

function OtherBattleMixin:newDayMaze()
	return
end

function OtherBattleMixin:resetMazeTip(battleOver)
	local isInMazeFormation = false

	if GameFsm.isInState(Const.STATE_BATTLE) then
		local state = GameFsm.getCurState()

		if state.battleType == BattleConst.BATTLE_TYPE_MAZE and not state:isInFight() then
			isInMazeFormation = true
		end
	end

	if battleOver then
		if self.reminded then
			return
		end

		self.reminded = true

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", ResClientNotice[118].notice, self.resetMazeUI)
	elseif GameFsm.isInState(Const.STATE_MAIN_MAZE) then
		if self.reminded then
			return
		end

		self.reminded = true

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", ResClientNotice[118].notice, self.resetMazeUI)
	elseif isInMazeFormation then
		if self.reminded then
			return
		end

		self.reminded = true

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", ResClientNotice[119].notice, self.resetMazeUI)
	else
		local ui = UIManager.getUI("mazeChooseDlg", nil, false)

		if ui then
			ui:show()
		end
	end
end

function OtherBattleMixin.resetMazeUI(...)
	for i, uiName in ipairs({
		"mazeInfoLvDlg",
		"mazeHeroCheckDlg",
		"mazeHallowChooseDlg",
		"mazeFinishDlg",
		"mazeFirstPassDlg"
	}) do
		local ui = UIManager.getUI(uiName, nil, false)

		if ui then
			ui:setVisible(false)
		end
	end

	local ui = UIManager.getUI("mazeChooseDlg", nil, false)

	if ui then
		ui:show()
	else
		UIManager.getUI("mazeChooseDlg", true):show()
	end
end

function OtherBattleMixin:onMazeSweepResp()
	self.needResetMaze = false

	self:setMazeState()

	local ui = UIManager.getUI("mazeChooseDlg", nil, false)

	if ui then
		ui:show(true)
	end

	if CurAvatar.cachedMazeSweapAward then
		UIManager.getUI("mazeCleanDlg", true):setNewSweepMode()
	end
end

function OtherBattleMixin:isMazeFirstPass(...)
	local mazeId = self.mazeData.maze_id
	local layer = self.mazeData.layer

	for i, data in ipairs(self.mazeData.pass_record) do
		if data.maze_id == mazeId then
			local totalLayer = #ResMaze[mazeId]

			return totalLayer ~= data.max_layer and layer > data.max_layer
		end
	end

	return true
end

function OtherBattleMixin:getMaxPassedMazeId(...)
	local maxId = 1

	for i, data in ipairs(self.mazeData.pass_record) do
		maxId = math.max(maxId, data.maze_id)
	end

	return maxId
end

function OtherBattleMixin:getMazeNoHurtCount(maze_id)
	for i, data in ipairs(self.mazeData.pass_record) do
		if data.maze_id == maze_id then
			return data.no_death_cnt
		end
	end

	return 0
end

function OtherBattleMixin:isThisMazeFinished(...)
	local mazeId = self.mazeData.maze_id
	local layer = self.mazeData.layer
	local data = ResMaze[mazeId]

	if data then
		local layerData = data[layer]

		if layerData then
			return #layerData == self.mazeData.node_id
		else
			return true
		end
	else
		return true
	end
end

function OtherBattleMixin:getMazeCheckOpenInfo(...)
	local record = UserData.loadCommonDataInt(CurAvatar.uid .. Const.MAZE_NEXT_OPEN_ID)

	if record == 0 then
		record = 12
	end

	local id = math.floor(record / 10)
	local remindId = record % 10

	return id, remindId
end

function OtherBattleMixin:saveMazeCheckOpenInfo(mazeId, state)
	local value = mazeId * 10 + state

	UserData.saveCommonDataInt(CurAvatar.uid .. Const.MAZE_NEXT_OPEN_ID, value)
end

function OtherBattleMixin:checkShowMazeSweapAward(itemObjs)
	self.cachedMazeSweapAward = itemObjs
end

function OtherBattleMixin:onMazeSelectSweepRelicsResp(layer, node, relics_index)
	return
end

function OtherBattleMixin:initSeniorPvpData(seniorPvpData)
	ClientUtils.record.seniorPvpFormations = ClientUtils.record.seniorPvpFormations or {}
	ClientUtils.record.seniorPvpNextReportGetTime = 0
	self.seniorPvpFormations = ClientUtils.record.seniorPvpFormations
	self.seniorPvpData = seniorPvpData
	ClientUtils.record.multiPvpReportStatus = self.seniorPvpData.report_tick

	if ClientUtils.record.multiPvpTeamLessTip == nil then
		ClientUtils.record.multiPvpTeamLessTip = true
	end
end

function OtherBattleMixin:onMultiPVPMatchResp(next_tick, data)
	ClientUtils.record.seniorPvpNextMatchTime = next_tick
	ClientUtils.record.seniorPvpMatchData = data

	local ui = UIManager.getUI("seniorPvpEnemyDlg", nil, false)

	if ui then
		ui:refreshData()
	else
		UIManager.getUI("seniorPvpEnemyDlg", true):show()
	end
end

function OtherBattleMixin:getSeniorPvpFormation(uid)
	local info = self.seniorPvpFormations[uid]

	if info then
		if info.tick + Const.FORMATION_GET_INTERVAL <= Time.time then
			RPC.multiPVPTargetCache(uid)
		else
			return info.formation
		end
	else
		RPC.multiPVPTargetCache(uid)
	end
end

function OtherBattleMixin:onMultiPVPAwardGetResp(awards, award_tick)
	self.seniorPvpData.awrad_num = 0
	self.seniorPvpData.award_tick = award_tick

	self:checkSeniorPvpAwardRedHint()

	local ui = UIManager.getUI("seniorPvpMainDlg", nil, false)

	if ui then
		ui:refreshUI()
	end

	MsgManager.notice(Lang.get(1872))
end

function OtherBattleMixin:onFormationsUpdateByTypeResp(type, item)
	self:refreshMultiPvpDefendFormation(type, item)

	if type == Const.FORMATION_TYPE_OPACTPVP_DEFEND and item and item[1] and #item[1] then
		local actObj = self:getPVPArenaActivity()

		if actObj and actObj.actData.arenaData and (actObj.actData.arenaData.enrolled == 0 or actObj.actData.arenaData.inited == 0) then
			RPC.opactArenaEnroll(actObj.opId)
		end
	end

	if type == Const.FORMATION_TYPE_TOPPVP_DEFEND and item and item[1] and #item[1] then
		local actData = CurAvatar:getTopPVPActivityData()

		if actData then
			actData:refreshUI()
		end
	end

	local ui = UIManager.getUI("seniorPvpMainDlg", nil, false)

	if ui then
		ui:refreshUI()
	end
end

function OtherBattleMixin:onMultiPVPReportGetResp(tick)
	ClientUtils.record.seniorPvpNextReportGetTime = tick

	RedDotManager.setKeyState(UIConst.RD_HINT_SENIORPVP_RECORD, false)
end

function OtherBattleMixin:onMultiPVPReportGetNotify(report)
	ClientUtils.record.seniorPvpReports = report

	UIManager.getUI("seniorPvpRecordDlg", true):show()
end

function OtherBattleMixin:checkSeniorPvpFormationRedHint(use_pos)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_MULTIPVP) then
		return
	end

	if use_pos ~= nil and use_pos ~= Const.FORMATION_MULTIPVP_DEFEND_1 and use_pos ~= Const.FORMATION_MULTIPVP_DEFEND_2 and use_pos ~= Const.FORMATION_MULTIPVP_DEFEND_3 then
		return
	end

	local isNeedCheckLocal = true

	if self:isFormationSnapShot(Const.FORMATION_MULTIPVP_DEFEND_1) and self:isSnapFormationFull(Const.FORMATION_MULTIPVP_DEFEND_1, 15) then
		isNeedCheckLocal = false
	end

	local result = false

	if isNeedCheckLocal then
		local allCount = 0
		local singleCount = 0
		local isLess
		local allUsedMap = {}

		for i = 1, 3 do
			local formation = self:getNowFormation(Const["FORMATION_MULTIPVP_DEFEND_" .. i])

			singleCount = 0

			for gid, pos in pairs(formation) do
				local hero = self.heroDic[gid]

				if hero then
					singleCount = singleCount + 1
					allUsedMap[hero.id] = true
				end
			end

			allCount = allCount + singleCount

			if singleCount < 5 then
				isLess = true
			end
		end

		local ownCount = self:getHeroCount()

		if allCount < ownCount and isLess == true then
			for gid, hero in pairs(self.heroDic) do
				if allUsedMap[hero.id] ~= true then
					result = true

					break
				end
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_SENIORPVP_FORMATION, result)
end

function OtherBattleMixin:checkSeniorPvpAwardRedHint(...)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_MULTIPVP) then
		return
	end

	local ratio = 0.5
	local info = PVPCommon.getRankPartInfo(self.seniorPvpData.rank)
	local num = self.seniorPvpData.awrad_num + info.award_speed * (ClientUtils.getServerTime() - self.seniorPvpData.award_tick) / 600
	local result = num > 0 and num >= PVPCommon.getAwardLimit() * ratio

	if result == false then
		ClientTimerManager.stopGlobalTimer("multiPvpAwardFull")

		local leftTime = (PVPCommon.getAwardLimit() * ratio - num) / (info.award_speed / 600)

		ClientTimerManager.startGlobalTimer("multiPvpAwardFull", leftTime, Slot(self.checkSeniorPvpAwardRedHint, self))
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_SENIORPVP_AWARD, result)
end

function OtherBattleMixin:onMultiPVPUpdateNotify(data)
	if data.report_tick == 0 or data.report_tick == self.seniorPvpData.report_tick then
		-- block empty
	else
		ClientUtils.record.multiPvpReportStatus = data.report_tick

		if (ClientUtils.record.seniorPvpNextReportGetTime or 0) > ClientUtils.getServerTime() then
			if self.multiPvpRecordHintTimeDown then
				self.multiPvpRecordHintTimeDown:Stop()
			end

			self.multiPvpRecordHintTimeDown = Timer.New(Slot(self.checkMultiPvpRecordRedHint, self), ClientUtils.record.seniorPvpNextReportGetTime - ClientUtils.getServerTime(), 1)

			self.multiPvpRecordHintTimeDown:Start()
		else
			RedDotManager.setKeyState(UIConst.RD_HINT_SENIORPVP_RECORD, true)
		end

		local result = (ClientUtils.record.seniorPvpNextReportGetTime or 0) < ClientUtils.getServerTime()

		RedDotManager.setKeyState(UIConst.RD_HINT_SENIORPVP_RECORD, result)
	end

	self.seniorPvpData = data

	local ui = UIManager.getUI("seniorPvpMainDlg", nil, false)

	if ui then
		ui:refreshUI()
	end

	self:checkSeniorPvpAwardRedHint()
end

function OtherBattleMixin:checkMultiPvpRecordRedHint(...)
	local redTip = false
	local interval = 259200

	if not Framework.Tools.LuaToolkit.IsEditor() then
		interval = 259200
	end

	if ClientUtils.record.multiPvpReportStatus + interval > ClientUtils.getServerTime() then
		redTip = true
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_SENIORPVP_RECORD, redTip)
end

function OtherBattleMixin:onNewDayWorldBoss()
	local actData = self:getWorldBossActData()

	if actData then
		actData:newDayRefreshDailyTimes()
	end

	WorldBossCommon.refreshWorldBossActData()
end

local opactNewDayUIs = {
	"activityPvpMainDlg",
	"activityPvpEnemyDlg",
	"activityPvpRecordDlg"
}

function OtherBattleMixin:_onNewDayOpactPvp(...)
	self.opactPvpChallengedInfo = {}

	for _, name in ipairs(opactNewDayUIs) do
		local ui = UIManager.getUI(name, nil, false)

		if ui and ui.onNewDay then
			ui:onNewDay()
		end
	end
end

function OtherBattleMixin:initOpactPvpData(...)
	self.opactPvpFormations = {}
	self.opactNextGetReportTime = 0
	self.opactPvpChallengedInfo = {}

	if ClientUtils.record.opactPvpTeamLessTip == nil then
		ClientUtils.record.opactPvpTeamLessTip = true
	end
end

function OtherBattleMixin:checkOpactPvpTopTenData(...)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_OPACTPVP) then
		return
	end

	if not ClientUtils.record.opactPvpTopTen then
		local actObj = self:getActivityObjByType(Const.ACT_TYPE_ARENA)

		if not actObj then
			RPC.opactArenaRankTopGet()
		end
	end
end

function OtherBattleMixin:onOpactArenaRankTopGetResp(rank_data)
	ClientUtils.record.opactPvpTopTen = rank_data

	SceneManager.refreshArenaRank()

	local ActivityDataArena = require("Avatar/AvatarMixins/OpActivity/ActivityDataArena")

	ActivityDataArena.topMsgShow(rank_data)
end

function OtherBattleMixin:getOpactPvpTopThree(...)
	local data = {}

	if ClientUtils.record.opactPvpTopTen then
		for i = 1, 3 do
			local info = ClientUtils.record.opactPvpTopTen[i]

			if info then
				table.insert(data, info.comm)
			end
		end
	end

	return data
end

function OtherBattleMixin:onOpactArenaEnrollResp()
	local actData = self:getPVPArenaActivityData()

	if actData then
		actData.enrolled = 1
		actData.inited = 1
	end

	local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

	if ui then
		ui:onLeagueChange(true)
		ui:refreshRankList(true)
	end

	self:checkOpactPvpChallengeRedHind()
end

function OtherBattleMixin:onOpactArenaRoleOpenResp(score, league, award_dan)
	local actData = self:getPVPArenaActivityData()

	if actData then
		actData.opened = 1
		actData.score = score
		actData.league = league
		actData.award_dan = award_dan
	end

	ClientUtils.record.newOpactPvpPartInfo = PVPCommon.getPartInfoByScore(score, league)

	local actObj = self:getPVPArenaActivity()

	if actObj then
		local isValid, unlockDesc = actObj:isValid()

		if isValid then
			CurAvatar:jumpToShowActivity(actObj.actId)
		end
	end

	local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

	if ui then
		ui:checkWelcome("seasonOpen")
	end
end

function OtherBattleMixin:onOpactArenaRoleGetNearRankResp(rank_item)
	self:checkAndGetOpactPvpMatchInfo(rank_item, true)
end

function OtherBattleMixin:onOpactArenaMatchResp(tick, result, match_times)
	local actData = self:getPVPArenaActivityData()

	if actData then
		actData.match_tick = tick
		actData.match_times = match_times
		actData.match_result = result
	end

	self.nextActivityPvpMatchTime = PVPCommon.getNextActPvpMatchTime(tick)

	self:checkAndGetOpactPvpMatchInfo(result)
end

function OtherBattleMixin:onOpactArenaRoleMatchNotify(tick, result)
	local actData = self:getPVPArenaActivityData()

	if actData then
		actData.match_result = result
		actData.match_tick = tick
	end
end

function OtherBattleMixin:checkAndGetOpactPvpMatchInfo(result, isNear)
	local matchDatas
	local uids = {}

	if isNear then
		self.opactPvpNearMatchDatas = {}

		for i, info in ipairs(result) do
			if info.uid ~= self.uid then
				table.insert(self.opactPvpNearMatchDatas, info)
			end
		end

		matchDatas = self.opactPvpNearMatchDatas
		self.opactPvpNearCommGotPage = nil
	else
		self.activityPvpOpponentData = utils.deepcopy(result)
		matchDatas = self.activityPvpOpponentData

		for i, info in ipairs(result) do
			table.insert(uids, info.uid)
		end
	end

	for i, data in ipairs(matchDatas) do
		data.comm = Const.DEFAULT_COMMINFO
	end

	self:getCommInfoDetail(uids, matchDatas)
end

function OtherBattleMixin:getCommInfoDetail(uids, data)
	if #uids > 0 then
		self:getRoleCommInfosNoTip(uids, Functor(self.getActivityPvpOpponentsCB, self, data))
	end
end

function OtherBattleMixin:getActivityPvpOpponentsCB(data, infos)
	for i, data in ipairs(data or {}) do
		for _, info in ipairs(infos) do
			if info.uid == data.uid then
				data.comm = info.commInfo
			end
		end
	end

	local ui = UIManager.getUI("activityPvpEnemyDlg", nil, false)

	if ui then
		ui:refreshUI(true)
	end
end

function OtherBattleMixin:onOpactArenaRoleInfoNotify(activity_id, ranking, score, league, battle_cnt, defence_tick, attack_item)
	local actId = self:getPVPArenaActivityOpId()

	if actId and actId ~= activity_id then
		return
	end

	local actData = self:getPVPArenaActivityData()

	if actData then
		actData.score = score
		actData.league = league
		actData.battle_cnt = battle_cnt
	end

	self.opactPvpRank = ranking + 1
	self.opactNewestReportTime = defence_tick

	self:checkOpactPvpReportRedHint()
	self:checkPartChangeRedHint(score, league)

	self.opactPvpChallengedInfo = {}

	for i, info in ipairs(attack_item) do
		self.opactPvpChallengedInfo[info.uid] = info.timestamp
	end

	local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

	if ui then
		ui:refreshUI()
	end
end

function OtherBattleMixin:onOpactArenaRoleDefendNotify(tick, score, ranking)
	local actData = self:getPVPArenaActivityData()

	if actData then
		actData.score = score
	end

	self.opactPvpRank = ranking + 1
	self.opactPvpScoreRefreshTick = ClientUtils.getServerTime()
	self.opactNewestReportTime = tick

	self:checkPartChangeRedHint(score)

	local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

	if ui then
		ui:refreshScore()
	end

	self:checkOpactPvpReportRedHint()
end

function OtherBattleMixin:onFormationSnapshotResp(pos, snapshot)
	self:setFormationSnapShot(pos, snapshot == 1)

	if self:formationPosIsRent(pos) then
		if snapshot == 1 then
			self:refreshRentFormationSnapshot()
		else
			self:checkRentFormationRedHind()
			self:refreshRentSetupUI()
		end
	elseif pos == Const.FORMATION_OPACTPVP_DEFEND_1 then
		local ui = UIManager.getUI("activityPvpCheckTeamDlg", nil, false)

		if ui then
			ui:refreshLockUI(true)
		end

		local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

		if ui then
			ui:refreshPower()
			ui:refreshRankList()
		end

		self:checkOpactPvpFormationRedHind()
	elseif pos == Const.FORMATION_TOPPVP_DEFEND_1 then
		local ui = UIManager.getUI("topPvpCheckTeamDlg", nil, false)

		if ui then
			ui:refreshLockUI(true)
		end
	elseif pos == Const.FORMATION_MULTIPVP_DEFEND_1 then
		local ui = UIManager.getUI("seniorPvpCheckTeamDlg", nil, false)

		if ui then
			ui:refreshLockUI(true)
		end

		local ui = UIManager.getUI("seniorPvpMainDlg", nil, false)

		if ui then
			ui:refreshUI()
		end

		self:checkSeniorPvpFormationRedHint()
	elseif pos == Const.FORMATION_ASYNC_DEFEND then
		local ui = UIManager.getUI("asycPvpCheckTeamDlg", nil, false)

		if ui then
			ui:refreshLockUI(true)
		end

		local ui = UIManager.getUI("pvpMainDlg", nil, false)

		if ui then
			ui:refreshUI()
		end

		self:checkPvpFormationRedHint()
	end
end

function OtherBattleMixin:onFormationSnapshotSwapIdxResp(pos, idxs)
	MsgManager.notice(Lang.get(1873))

	local key

	if pos == Const.FORMATION_MULTIPVP_DEFEND_1 then
		key = "FORMATION_MULTIPVP_DEFEND_"
	elseif pos == Const.FORMATION_OPACTPVP_DEFEND_1 then
		key = "FORMATION_OPACTPVP_DEFEND_"
	end

	if key then
		for i = 1, #idxs do
			if i ~= idxs[i] + 1 then
				self:swapFormation(Const[key .. i], Const[key .. idxs[i] + 1])

				break
			end
		end
	end
end

function OtherBattleMixin:onFormationSnapshotGetResp(formation)
	local pos = formation.type

	if not self.formationSnapshotDict then
		self.formationSnapshotDict = {}
	end

	self.formationSnapshotDict[pos] = formation

	if self:formationPosIsRent(pos) then
		self:checkRentFormationRedHind()
		self:refreshRentSetupUI()
	elseif pos == Const.FORMATION_OPACTPVP_DEFEND_1 then
		local ui = UIManager.getUI("activityPvpCheckTeamDlg", nil, false)

		if ui then
			ui:setSnapShotFormation(formation)
		end

		local actObj = self:getPVPArenaActivity()

		if actObj then
			actObj.actData:refreshSnapShotFormation(formation)
		end
	elseif pos == Const.FORMATION_TOPPVP_DEFEND_1 then
		local ui = UIManager.getUI("topPvpCheckTeamDlg", nil, false)

		if ui then
			ui:setSnapShotFormation(formation)
		end

		local actObj = self:getTopPVPActivity()

		if actObj then
			actObj.actData:refreshSnapShotFormation(formation)
		end
	elseif pos == Const.FORMATION_MULTIPVP_DEFEND_1 then
		local ui = UIManager.getUI("seniorPvpCheckTeamDlg", nil, false)

		if ui then
			ui:refreshSnapShotFormation()
		end

		local ui = UIManager.getUI("seniorPvpMainDlg", nil, false)

		if ui then
			ui:refreshUI()
		end

		self:checkSeniorPvpFormationRedHint()
	elseif pos == Const.FORMATION_ASYNC_DEFEND then
		local ui = UIManager.getUI("asycPvpCheckTeamDlg", nil, false)

		if ui then
			ui:refreshSnapShotFormation()
		end

		local ui = UIManager.getUI("pvpMainDlg", nil, false)

		if ui then
			ui:refreshUI()
		end

		self:checkPvpFormationRedHint()
	end
end

function OtherBattleMixin:onOpactArenaUpgradeLeagueResp(league, score, ranking)
	local actData = self:getPVPArenaActivityData()

	if actData then
		actData.league = league
		actData.score = score
	end

	self.opactPvpRank = ranking + 1
	self.opactPvpScoreRefreshTick = ClientUtils.getServerTime()

	self:checkPartChangeRedHint(score, league)

	local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

	if ui then
		ui:onLeagueChange()
	end
end

function OtherBattleMixin:onOpactArenaReportGetResp(report, tick)
	self.opactNextGetReportTime = tick + Const.OPACTPVP_GET_REPORT_CD
	ClientUtils.record.opactPvpReports = report

	local actData = self:getPVPArenaActivityData()

	if actData then
		actData.get_report_tick = tick
	end

	UIManager.getUI("activityPvpRecordDlg", true):show()
	self:checkOpactPvpReportRedHint()
end

function OtherBattleMixin:onOpactArenaRoleDanAwardNotify(award_dan)
	local actData = self:getPVPArenaActivityData()

	if actData then
		actData.award_dan = award_dan
	end
end

function OtherBattleMixin:onOpactArenaSetRandFormaionResp(rand)
	local arenaData = self:getPVPArenaActivityData()

	if arenaData then
		arenaData.rand_formation = rand
	end

	local ui = UIManager.getUI("activityPvpCheckTeamDlg", nil, false)

	if ui then
		ui:refreshRandTeamUI()
	end
end

function OtherBattleMixin:onOpactArenaSettleNotify(self_score, target_uid, target_score, self_ranking)
	local actData = self:getPVPArenaActivityData()

	if actData then
		actData.score = self_score
	end

	self.opactPvpRank = self_ranking + 1

	if self.opactPvpChallengedInfo then
		self.opactPvpChallengedInfo[target_uid] = ClientUtils.getServerTime()
	end

	self:checkPartChangeRedHint(self_score)

	local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

	if ui then
		ui:refreshScore()
	end

	self:checkOpactPvpChallengeRedHind()
end

function OtherBattleMixin:checkOpactPvpFormationRedHind(use_pos)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_OPACTPVP) then
		return
	end

	local actObj = self:getPVPArenaActivity()

	if not actObj or actObj:inFreeze() then
		RedDotManager.setKeyState(UIConst.RD_HINT_OPACTPVP_FORMATION, false)

		return
	end

	if use_pos ~= nil and use_pos ~= Const.FORMATION_OPACTPVP_DEFEND_1 and use_pos ~= Const.FORMATION_OPACTPVP_DEFEND_2 and use_pos ~= Const.FORMATION_OPACTPVP_DEFEND_3 then
		return
	end

	local result = false
	local isNeedCheckLocal = true

	if self:isFormationSnapShot(Const.FORMATION_OPACTPVP_DEFEND_1) then
		local actData = self:getPVPArenaActData()

		if actData and actData:isSnapFormationFull() then
			isNeedCheckLocal = false
		end
	end

	if isNeedCheckLocal then
		local allCount = 0
		local singleCount = 0
		local isLess
		local allUsedMap = {}

		for i = 1, 3 do
			local formation = self:getNowFormation(Const["FORMATION_OPACTPVP_DEFEND_" .. i])

			singleCount = 0

			for gid, pos in pairs(formation) do
				local hero = self.heroDic[gid]

				if hero then
					singleCount = singleCount + 1
					allUsedMap[hero.id] = true
				end
			end

			allCount = allCount + singleCount

			if singleCount < 5 then
				isLess = true
			end
		end

		local ownCount = self:getHeroCount()

		if allCount < ownCount and isLess == true then
			for gid, hero in pairs(self.heroDic) do
				if allUsedMap[hero.id] ~= true then
					result = true

					break
				end
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_OPACTPVP_FORMATION, result)

	local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

	if ui then
		ui:onFormationChange()
	end
end

function OtherBattleMixin:getOpactPvpFormation(uid)
	local info = self.opactPvpFormations[uid]

	if info then
		if info.tick + Const.FORMATION_GET_INTERVAL <= Time.time then
			local actId = self:getPVPArenaActivityOpId()

			if actId then
				RPC.opactArenaDetailGet(actId, uid)
			end
		else
			return info.formation
		end
	else
		local actId = self:getPVPArenaActivityOpId()

		if actId then
			RPC.opactArenaDetailGet(actId, uid)
		end
	end
end

function OtherBattleMixin:checkOpactPvpChallengeRedHind(...)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_OPACTPVP) then
		return
	end

	local actObj = self:getPVPArenaActivity()

	if not actObj or actObj:inFreeze() then
		RedDotManager.setKeyState(UIConst.RD_HINT_OPACTPVP_CHALLENGE, false)

		return
	end

	local result = PVPCommon.getLeftChallengeTimes() > 0

	RedDotManager.setKeyState(UIConst.RD_HINT_OPACTPVP_CHALLENGE, result)
end

function OtherBattleMixin:checkOpactPvpReportRedHint()
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_OPACTPVP) then
		return
	end

	local actObj = self:getPVPArenaActivity()

	if not actObj then
		RedDotManager.setKeyState(UIConst.RD_HINT_OPACTPVP_REPORT, false)

		return
	end

	if (self.opactNewestReportTime or 0) + 259200 < ClientUtils.getServerTime() then
		RedDotManager.setKeyState(UIConst.RD_HINT_OPACTPVP_REPORT, false)

		return
	end

	local leftGetTime = self.opactNextGetReportTime - ClientUtils.getServerTime()

	if leftGetTime > 0 then
		RedDotManager.setKeyState(UIConst.RD_HINT_OPACTPVP_REPORT, false)
		ClientTimerManager.stopGlobalTimer("OpactPvpReportRedHint")
		ClientTimerManager.startGlobalTimer("OpactPvpReportRedHint", leftGetTime, Slot(self.checkOpactPvpReportRedHint, self))

		return
	end

	local tick = math.huge
	local actData = self:getPVPArenaActivityData()

	if actData then
		tick = actData.get_report_tick
	end

	local result = tick < (self.opactNewestReportTime or 0)

	RedDotManager.setKeyState(UIConst.RD_HINT_OPACTPVP_REPORT, result)
end

function OtherBattleMixin:checkPartChangeRedHint(newScore, league)
	local actObj = self:getPVPArenaActivity()

	if not actObj or actObj:inFreeze() then
		RedDotManager.setKeyState(UIConst.RD_HINT_OPACTPVP_PART_CHANGE, false)

		return
	end

	if newScore == nil then
		return
	end

	local arenaData = self:getPVPArenaActivityData()

	if arenaData == nil then
		RedDotManager.setKeyState(UIConst.RD_HINT_OPACTPVP_PART_CHANGE, false)

		return
	end

	local info = PVPCommon.getPartInfoByScore(newScore, league)
	local dan = arenaData.award_dan
	local actData = self:getPVPArenaActData()

	if actData and actData:getPreDan() then
		dan = actData:getPreDan()
	end

	if dan ~= info.dan then
		RedDotManager.setKeyState(UIConst.RD_HINT_OPACTPVP_PART_CHANGE, true)
	else
		RedDotManager.setKeyState(UIConst.RD_HINT_OPACTPVP_PART_CHANGE, false)
	end
end

function OtherBattleMixin:checkTopPvpTopData(...)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_TOPPVP) then
		return
	end

	RPC.rankCacheGetPage(Const.RANK_CACHE_TYPE_TOP_PVP, 1, 0, 1)
end

function OtherBattleMixin:onBPPvpGroupReportGetResp(report)
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		actData:updateGroupMatchRecord(report)
		UIManager.getUI("topPvpRecordDlg", true):show(BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH)
	end
end

function OtherBattleMixin:onBPPvpKnockoutReportGetResp(report)
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		actData:updateKnockoutRecord(report)
		UIManager.getUI("topPvpRecordDlg", true):show(BattleConst.BATTLE_TYPE_TOP_PVP_KNOCKOUT)
	end
end

function OtherBattleMixin:checkTopPvpFormationRedHind(use_pos)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_OPACTPVP) then
		return
	end

	local actObj = self:getTopPVPActivity()

	if not actObj or actObj:inFreeze() then
		RedDotManager.setKeyState(RD_HINT_TOPPVP_GROUPMATCH_FORMATION, false)

		return
	end

	if use_pos ~= nil and use_pos ~= Const.Const.FORMATION_TOPPVP_DEFEND_1 and use_pos ~= Const.FORMATION_TOPPVP_DEFEND_2 and use_poe ~= FORMATION_TOPPVP_DEFEND_3 then
		return
	end

	local result = false
end

function OtherBattleMixin:checkRentFormationRedHind(use_pos)
	if not self.rentTaskFlag then
		return
	end

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_RENTTASK) then
		return
	end

	if use_pos ~= nil and use_pos ~= Const.FORMATION_RENT_TEAMS[1] and use_pos ~= Const.FORMATION_RENT_TEAMS[2] and use_pos ~= Const.FORMATION_RENT_TEAMS[3] and use_pos ~= Const.FORMATION_RENT_TEAMS[4] and use_pos ~= Const.FORMATION_RENT_TEAMS[5] then
		return
	end

	local result = false
	local snapIsFull = true
	local isNeedCheckLocal = true

	if self:isFormationSnapShot(Const.FORMATION_RENT_TEAMS[1]) and self.formationSnapshotDict then
		for pos, formationSnapshot in pairs(self.formationSnapshotDict) do
			local count = 0

			for i, teamInfo in ipairs(formationSnapshot.item) do
				for j, info in ipairs(teamInfo.data.item) do
					count = count + 1
				end
			end

			if count < 5 then
				snapIsFull = false

				break
			end
		end

		isNeedCheckLocal = not snapIsFull
	end

	if isNeedCheckLocal then
		local allCount = 0
		local singleCount = 0
		local isLess
		local allUsedMap = {}

		for i = 1, self.rentMaxUnlockTeams do
			local formation = self:getNowFormation(Const.FORMATION_RENT_TEAMS[i])

			singleCount = 0

			for gid, pos in pairs(formation) do
				local hero = self.heroDic[gid]

				if hero then
					singleCount = singleCount + 1
					allUsedMap[hero.id] = true
				end
			end

			allCount = allCount + singleCount

			if singleCount < 5 then
				isLess = true
			end
		end

		local ownCount = self:getHeroCount()

		if allCount < ownCount and isLess == true then
			for gid, hero in pairs(self.heroDic) do
				if allUsedMap[hero.id] ~= true then
					result = true

					break
				end
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_RENT_FORAMTIONLACK, result)
end

function OtherBattleMixin:refreshRentSetupUI(...)
	local rentSetupDlg = UIManager.getUI("rentTeamSetupDlg", nil, false)

	if rentSetupDlg then
		rentSetupDlg:refreshTeamSetupDlg()
	end
end

function OtherBattleMixin:formationPosIsRent(pos)
	for i, v in ipairs(Const.FORMATION_RENT_TEAMS) do
		if v == pos then
			return true
		end
	end

	return false
end

function OtherBattleMixin:getFormationSnapshot(pos, idx)
	idx = idx or 1

	if self.formationSnapshotDict and self.formationSnapshotDict[pos] then
		return self.formationSnapshotDict[pos].item[idx].data
	end
end

function OtherBattleMixin:getFormationSnapShotItemData(pos)
	if self.formationSnapshotDict and self.formationSnapshotDict[pos] then
		return self.formationSnapshotDict[pos].item
	end
end

function OtherBattleMixin:getFormationSnapShotFullData(pos)
	if self.formationSnapshotDict and self.formationSnapshotDict[pos] then
		return self.formationSnapshotDict[pos]
	end
end

function OtherBattleMixin:isSnapFormationFull(pos, fullNum)
	local snapShotFormation = self:getFormationSnapShotItemData(pos)

	if snapShotFormation then
		local count = 0

		for i, teamInfo in ipairs(snapShotFormation) do
			for j, info in ipairs(teamInfo.data.item) do
				count = count + 1
			end
		end

		return count == fullNum
	else
		return true
	end
end

function OtherBattleMixin:checkAndGetSnapShotFormation(posList)
	for i, pos in ipairs(posList) do
		if self:isFormationSnapShot(pos) and not self:getFormationSnapShotItemData() then
			RPC.formationSnapshotGet(pos)
		end
	end
end

function OtherBattleMixin:initAutoBattlePower(power)
	self.autoBattlePower = {}

	for _, info in ipairs(power.power_data) do
		self.autoBattlePower[info.type] = {
			info.num,
			info.fresh_tick
		}
	end
end

function OtherBattleMixin:getAutoBattlePower(gamePlayId)
	local power = 0
	local nextTick = -1
	local configData = ResAutoBattlePower[gamePlayId]

	if configData then
		local power_max = configData.power_max
		local recover_time = configData.recover_time
		local recover_count = configData.recover_count or 1
		local serverData = self.autoBattlePower[gamePlayId]

		if serverData then
			local ti = math.max(ClientUtils.getServerTime() - serverData[2], 0)
			local passNum = math.floor(ti / recover_time)

			power = math.min((serverData[1] or 0) + passNum * recover_count, power_max)

			if power < power_max then
				nextTick = (passNum + 1) * recover_time - ClientUtils.getServerTime() + serverData[2]
			end
		else
			power = power_max
		end
	end

	return power, nextTick
end

function OtherBattleMixin:onPVEAutoBattlePowerNotify(power)
	for _, info in ipairs(power.power_data) do
		self.autoBattlePower[info.type] = {
			info.num,
			info.fresh_tick
		}
	end
end

return OtherBattleMixin
