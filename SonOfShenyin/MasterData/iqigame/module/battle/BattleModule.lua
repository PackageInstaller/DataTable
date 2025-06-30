-- chunkname: @IQIGame\\Module\\Battle\\BattleModule.lua

local BattleTileData = require("IQIGame/Module/Battle/BattleData/BattleTileData")
local BattleTroopData = require("IQIGame/Module/Battle/BattleData/BattleTroopData")
local BattleUnitData = require("IQIGame/Module/Battle/BattleData/BattleUnitData")
local BattleCustomWaitConditionData = require("IQIGame/Module/Battle/BattleData/BattleCustomWaitConditionData")
local BattleCustomWaitSecondData = require("IQIGame/Module/Battle/BattleData/BattleCustomWaitSecondData")
local BattleBuffData = require("IQIGame.Module.Battle.BattleData.BattleBuffData")
local BattleScene = require("IQIGame/Scene/Battle/BattleScene")
local BattleActionQueueManager = require("IQIGame/Module/Battle/BattleActionQueueManager")

BattleModule = {
	showRightToolsButton = true,
	attackBattleTroopType = 0,
	canManualExit = true,
	currentBigRound = 0,
	defaultSpeedIndex = 0,
	restartBattle = false,
	defineTeamBattleUnitID = 0,
	forceBattleOver = false,
	canExecuteInit = true,
	defineBattleTroopType = 0,
	ContinueBattle = false,
	attackTeamBattleUnitID = 0,
	totalDamageRecord = 0,
	isBattleOver = false,
	autoFight = false,
	maxBigRound = 0,
	isInBattle = false,
	playerBattleTroop = 1,
	battleSpeedList = {
		1,
		2
	},
	__UpdateUnitFuc = {},
	__CustomCondition = {},
	dialogQueue = Queue.New(),
	battleTilesData = {},
	battleUnitsData = {},
	battleTroopsData = {},
	summonUnitTable = {},
	bossTable = {},
	delayDieUnitsTable = {},
	aiTypeRecordData = {},
	damageRecord = {}
}

function BattleModule.__RecordDamage(battleUnitID, damage)
	if damage > 0 then
		return
	end

	local _damage = damage * -1

	BattleModule.totalDamageRecord = BattleModule.totalDamageRecord + _damage

	local totalDamage = BattleModule.damageRecord[battleUnitID]

	if totalDamage == nil then
		BattleModule.damageRecord[battleUnitID] = _damage

		return
	end

	BattleModule.damageRecord[battleUnitID] = totalDamage + _damage
end

BattleModule.__UpdateUnitFuc[Constant.UpdateType.CHANGE_HP] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local hp = battleUpdateUnitPOD.Param[1]
	local damage = battleUpdateUnitPOD.Param[2]
	local elementType = battleUpdateUnitPOD.Param[3]
	local battleDamageData = {}

	battleDamageData.battleUnitID = battleUnitData.battleUnitID
	battleDamageData.elementType = elementType
	battleDamageData.damage = damage * -1
	battleDamageData.isShield = false
	battleDamageData.showHitTips = true
	battleDamageData.advantage = 0

	if userData ~= nil then
		battleDamageData.showHitTips = userData.showHitTips

		if battleDamageData.showHitTips == nil then
			battleDamageData.showHitTips = true
		end

		battleDamageData.isCritical = userData.isCritical
		battleDamageData.damageType = userData.damageType
		battleDamageData.isSerialHit = userData.isSerialHit
		battleDamageData.isTimelineHitTrigger = userData.isTimelineHitTrigger
		battleDamageData.advantage = userData.advantage
	end

	battleUnitData:OnHpChange(hp, battleDamageData)
	BattleModule.Log("  battleUnitID= " .. battleUnitData.battleUnitID .. "，受到伤害：" .. damage .. "，血量变为：" .. battleUnitData.hp .. "，元素类型 = " .. elementType)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.UPDATE_MAX_HP] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local maxHp = battleUpdateUnitPOD.Param[1]

	battleUnitData:OnMaxHPChange(maxHp)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.UPDATE_SHIELD] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData

	if battleUnitData.isTroopData then
		callback()

		return
	end

	local previousShield = battleUnitData.shield
	local shield = battleUpdateUnitPOD.Param[1]
	local deltaShield = previousShield - shield
	local battleDamageData

	if deltaShield > 0 then
		battleDamageData = {
			battleUnitID = battleUnitData.battleUnitID,
			damage = deltaShield
		}
		battleDamageData.elementType = 0
		battleDamageData.isCritical = false
		battleDamageData.damageType = 0
		battleDamageData.isSerialHit = false
		battleDamageData.isTimelineHitTrigger = false
		battleDamageData.isShield = true
	end

	battleUnitData:OnShieldChange(shield, battleDamageData)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.CHANGE_ENERGY] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local energy = battleUpdateUnitPOD.Param[1]
	local addEnergy = battleUpdateUnitPOD.Param[2]

	battleUnitData:OnEnergyChange(energy, addEnergy)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.CHANGE_MAX_ENERGY] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local maxEnergy = battleUpdateUnitPOD.Param[1]

	battleUnitData:OnMaxEnergyChange(maxEnergy)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.CHANGE_POS] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local tilePos = battleUpdateUnitPOD.Param[1]

	battleUnitData:OnPosChanged(tilePos)

	if userData.UpdatePoint == BattleConstant.BattleUpdatePoint.TurnStart then
		callback()

		return
	end

	local timer = BattleApi:GetHeroMoveTimer() / BattleTimeScaleManager.TimeScale

	BattleModule.AddCustomWaitSecondCondition(timer, function()
		callback()
	end)
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.CHANE_SIZE] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitView = userData.UnitView
	local sizeA = battleUpdateUnitPOD.Param[1]
	local sizeB = battleUpdateUnitPOD.Param[2]
	local size = sizeA / sizeB

	if battleUnitView ~= nil then
		battleUnitView:ChangeSize(size)
	end

	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.AI_TYPE_CHANGE] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local value = battleUpdateUnitPOD.Param[1]

	battleUnitData:OnAITypeChange(value)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.UPDATE_SKIN_ICON] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local skinCid = tonumber(battleUpdateUnitPOD.Param[1])

	battleUnitData:ChangeSkin(skinCid)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.CHANGE_AP] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local ap = battleUpdateUnitPOD.Param[1]
	local addAP = battleUpdateUnitPOD.Param[2]

	battleUnitData:OnAPChange(ap, addAP)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.CHANGE_MAX_AP] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local maxAP = battleUpdateUnitPOD.Param[1]

	battleUnitData:OnMaxAPChange(maxAP)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.UPDATE_DMG_RECORDS] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local actualDmg = battleUpdateUnitPOD.Param[1]

	if BattleModule.totalDmg == nil then
		BattleModule.totalDmg = 0
	end

	BattleModule.totalDmg = BattleModule.totalDmg + actualDmg

	EventDispatcher.Dispatch(EventID.OnBattleTotalDamageChange, BattleModule.totalDmg, actualDmg)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.ADD_STATUS] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local fightStatusID = battleUpdateUnitPOD.Param[1]

	battleUnitData:UpdateFightStatus(fightStatusID, true)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.REMOVE_STATUS] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local fightStatusID = battleUpdateUnitPOD.Param[1]

	battleUnitData:UpdateFightStatus(fightStatusID, false)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.ADD_SP_STATUS] = function(battleUpdateUnitPOD, userData, callback)
	if battleUpdateUnitPOD.ID == BattleModule.attackTeamBattleUnitID or battleUpdateUnitPOD.ID == BattleModule.defendTeamBattleUnitID then
		callback()

		return
	end

	local battleUnitData = userData.UnitData
	local statusIndex = battleUpdateUnitPOD.Param[1] + 1
	local status = false

	if battleUpdateUnitPOD.Param[2] == 1 then
		status = true
	end

	battleUnitData:ChangeSpecialStatus(statusIndex, status)

	if statusIndex == Constant.BattleSPStatus.Dead then
		table.insert(BattleModule.delayDieUnitsTable, battleUnitData.battleUnitID)
	end

	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.UPDATE_BUFF] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local buffConfigID = battleUpdateUnitPOD.Param[1]
	local buffStack = battleUpdateUnitPOD.Param[2]
	local leftCount = battleUpdateUnitPOD.Param[3]
	local isAdd = battleUpdateUnitPOD.Param[4] == 1
	local ext = battleUpdateUnitPOD.Ext

	if battleUpdateUnitPOD.ID == BattleModule.attackTeamBattleUnitID or battleUpdateUnitPOD.ID == BattleModule.defendTeamBattleUnitID then
		local buffConfig = CfgBuffTable[buffConfigID]

		callback()

		return
	end

	if isAdd then
		battleUnitData:AddBuff(buffConfigID, buffStack, leftCount, true, ext)
	else
		battleUnitData:UpdateBuff(buffConfigID, buffStack, leftCount, true, ext)
	end

	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.TRIGGER_BUFF] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local buffConfigID = battleUpdateUnitPOD.Param[1]

	if battleUpdateUnitPOD.ID == BattleModule.attackTeamBattleUnitID or battleUpdateUnitPOD.ID == BattleModule.defendTeamBattleUnitID then
		local buffConfig = CfgBuffTable[buffConfigID]

		callback()

		return
	end

	battleUnitData:TriggerBuff(buffConfigID)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.REMOVE_BUFF] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local buffConfigID = battleUpdateUnitPOD.Param[1]

	if battleUpdateUnitPOD.ID == BattleModule.attackTeamBattleUnitID or battleUpdateUnitPOD.ID == BattleModule.defendTeamBattleUnitID then
		callback()

		return
	end

	battleUnitData:RemoveBuff(buffConfigID)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.SUMMON_ADD] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local summonBattleUnitPOD = battleUpdateUnitPOD.Call

	BattleModule.AddBattleSummonUnit(battleUnitData, summonBattleUnitPOD)
	BattleModule.Log("战斗阶段 {0} 添加召唤物 -------> {1}", userData.UpdatePoint, summonBattleUnitPOD.ID)

	if summonBattleUnitPOD.CreateType == BattleConstant.BattleUnitCreateType.Substitute then
		EventDispatcher.Dispatch(EventID.ReservesUpdate, summonBattleUnitPOD.ID)
	end

	if callback ~= nil then
		callback()
	end
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.SUMMON_REMOVE] = function(battleUpdateUnitPOD, userData, callback)
	local summonBattleUnitID = battleUpdateUnitPOD.Param[1]

	BattleModule.Log("战斗召唤系统 - 移除召唤物：battleUnitID = {0}", tostring(summonBattleUnitID))
	BattleModule.RemoveSummon(summonBattleUnitID)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.SEAL_SKILL] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local skillCid = battleUpdateUnitPOD.Param[1]
	local isSeal = battleUpdateUnitPOD.Param[2] == 1

	battleUnitData:UpdateSkillSealState(skillCid, isSeal)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.CHANGE_COMMON_CD] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local coolDown = battleUpdateUnitPOD.Param[1]

	battleUnitData:UpdateCommonSkillCD(coolDown)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.CHANGE_SKILL_COUNT] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local skillConfigID = battleUpdateUnitPOD.Param[1]
	local usedCount = battleUpdateUnitPOD.Param[2]

	battleUnitData:UpdateSkillUsedCount(skillConfigID, usedCount)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.CHANGE_SKILL_ENERGY] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local skillConfigID = battleUpdateUnitPOD.Param[1]
	local energyCost = battleUpdateUnitPOD.Param[2]

	battleUnitData:UpdateSkillEnergyCost(skillConfigID, energyCost)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.CHANGE_SKILL_AP] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local skillConfigID = battleUpdateUnitPOD.Param[1]
	local apCost = battleUpdateUnitPOD.Param[2]

	battleUnitData:UpdateSkillAPCost(skillConfigID, apCost)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.CHANGE_SKILL_CD] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local skillConfigID = battleUpdateUnitPOD.Param[1]
	local coolDown = battleUpdateUnitPOD.Param[2]

	battleUnitData:UpdateSkillCD(skillConfigID, coolDown)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.CHANGE_SKILL_TARGET] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local skillConfigID = battleUpdateUnitPOD.Param[1]
	local targetTypeID = battleUpdateUnitPOD.Param[2]

	battleUnitData:UpdateSkillTargetTypeID(skillConfigID, targetTypeID)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.REMOVE_SKILL] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData
	local skillCid = battleUpdateUnitPOD.Param[1]

	battleUnitData:RemoveSkill(skillCid)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.ADD_SKILL] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData

	battleUnitData:AddSkill(battleUpdateUnitPOD)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.CHANGE_PREVIEW_SKILL] = function(battleUpdateUnitPOD, userData, callback)
	local battleUnitData = userData.UnitData

	battleUnitData:UpdatePreviewSkillData(battleUpdateUnitPOD)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.ADD_WEAK_TYPE] = function(battleUpdateUnitPOD, userData, callback)
	local weakCid = battleUpdateUnitPOD.Param[1]
	local status = battleUpdateUnitPOD.Param[2]
	local battleUnitData = userData.UnitData

	battleUnitData:AddWake(weakCid, status)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.UPDATE_WEAK_MAX_NUM] = function(battleUpdateUnitPOD, userData, callback)
	local weakMaxNum = battleUpdateUnitPOD.Param[1]
	local battleUnitData = userData.UnitData

	battleUnitData:UpdateWakeMaxNum(weakMaxNum)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.UPDATE_WAKE_NUM] = function(battleUpdateUnitPOD, userData, callback)
	local weakNum = battleUpdateUnitPOD.Param[1]
	local battleUnitData = userData.UnitData

	battleUnitData:UpdateWakeNum(weakNum)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.UPDATE_WAKE_STATUS] = function(battleUpdateUnitPOD, userData, callback)
	local weakCid = battleUpdateUnitPOD.Param[1]
	local status = battleUpdateUnitPOD.Param[2]
	local battleUnitData = userData.UnitData

	battleUnitData:UpdateWakeStatus(weakCid, status)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.REMOVE_WEAK_TYPE] = function(battleUpdateUnitPOD, userData, callback)
	local weakCid = battleUpdateUnitPOD.Param[1]
	local battleUnitData = userData.UnitData

	battleUnitData:RemoveWake(weakCid)
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.CHANGE_TILE_TERRAIN] = function(battleUpdateUnitPOD, userData, callback)
	logError("CHANGE_TILE_TERRAIN ----->> ")
	callback()
end
BattleModule.__UpdateUnitFuc[Constant.UpdateType.SHOW_DIALOG] = function(battleUpdateUnitPOD, userData, callback)
	local dialogCid = battleUpdateUnitPOD.Param[1]

	BattleModule.dialogQueue:Enqueue(dialogCid)
	callback()
end

function BattleModule.InitBattleSpeedListData()
	BattleModule.defaultSpeedIndex = SettingModule.LoadBattleSpeedIndex()
	BattleModule.battleSpeedList = {
		1,
		2
	}

	local val = UserInfoModule.GetTalentAttr(Constant.TalentAttrType.PLAYER_FIGHT_SPEED, 0)

	if val == 0 then
		return
	end

	if table.indexOf(BattleModule.battleSpeedList, val) == -1 then
		table.insert(BattleModule.battleSpeedList, val)
	end
end

function BattleModule.SetBattleSpeedByIndex(index)
	BattleModule.defaultSpeedIndex = index

	if BattleModule.battleSpeedList[BattleModule.defaultSpeedIndex] == nil then
		BattleModule.defaultSpeedIndex = 1
	end

	BattleTimeScaleManager.TimeScale = BattleModule.battleSpeedList[BattleModule.defaultSpeedIndex]

	if SettingModule.MaintainBattleSpeed() then
		SettingModule.SaveBattleSpeedListIndex(BattleModule.defaultSpeedIndex)
	end

	return BattleModule.defaultSpeedIndex
end

function BattleModule.SetBattleSpeed()
	BattleModule.defaultSpeedIndex = BattleModule.defaultSpeedIndex >= #BattleModule.battleSpeedList and 1 or BattleModule.defaultSpeedIndex + 1

	return BattleModule.SetBattleSpeedByIndex(BattleModule.defaultSpeedIndex)
end

function BattleModule.__InitAITypeRecordData()
	BattleModule.aiTypeRecordData = {}

	local recordStr = SettingModule.GetBattleUnitAITypeRecordData()

	if LuaUtility.StrIsNullOrEmpty(recordStr) then
		return
	end

	local cidList = string.split(recordStr, "|")

	for i = 1, #cidList, 2 do
		local monsterCid = tonumber(cidList[i])
		local value = tonumber(cidList[i + 1])

		BattleModule.aiTypeRecordData[monsterCid] = value
	end
end

function BattleModule.GetAiTypeByRecordData(monsterCid)
	local resultValue = BattleModule.aiTypeRecordData[monsterCid]

	return resultValue == nil and 1 or resultValue
end

function BattleModule.SetAiTypeByRecordData(battleUnitID, value, autoSave)
	if not BattleModule.EnableBattleMessageLogic then
		return false
	end

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)

	if battleUnitData == nil then
		return false
	end

	BattleTeamActionModule.SendBattleUnitChangeAITypeOrder(battleUnitID, value)

	return true
end

function BattleModule.__DoSetAiTypeByRecordData(monsterCid, value, autoSave)
	BattleModule.aiTypeRecordData[monsterCid] = value

	if autoSave then
		BattleModule.__SaveAITypeRecordData()
	end
end

function BattleModule.__SaveAITypeRecordData()
	local recordStr = ""

	for monsterCid, value in pairs(BattleModule.aiTypeRecordData) do
		if LuaUtility.StrIsNullOrEmpty(recordStr) then
			recordStr = recordStr .. tostring(monsterCid) .. "|" .. tostring(value)
		else
			recordStr = recordStr .. "|" .. tostring(monsterCid) .. "|" .. tostring(value)
		end
	end

	SettingModule.SaveBattleUnitAITypeRecordData(recordStr)
end

function BattleModule.SetBattleSceneIsReady(isReady)
	BattleModule.canExecuteInit = isReady

	if not BattleModule.canExecuteInit then
		return
	end

	EventDispatcher.Dispatch(EventID.BattleSceneReady)
	BattleModule.BeginInit()
end

function BattleModule.RequestStartBattle(isLocal, fightPOD, userdata, isAuto, isTestBattle)
	BattleModule.battleData = {}
	BattleModule.battleData.isLocal = isLocal

	BattleModule.__DoFightPODEx(fightPOD)

	BattleModule.battleData.userdata = userdata
	BattleModule.battleData.isAuto = isAuto
	BattleModule.battleData.isTestBattle = isTestBattle and isTestBattle or false

	BattleModule.__DoRequestBattleInitCommand()
end

function BattleModule.__DoFightPODEx(fightPOD)
	BattleModule.battleData.fightPOD = fightPOD

	GuideModule.CustomGuideTrigger("BattleStart")
end

function BattleModule.RequestRestartBattle()
	if not BattleModule.isInitBattleComplete then
		return
	end

	BattleModule.restartBattle = true

	BattleModule.battleScene:HideAllBattleCurve()
	net_fight.refreshRandomSeed()
end

function BattleModule.OnRestartBattle(randomSeed)
	BattleModule.Log("重新开始战斗 randomSeed： {0}", randomSeed)

	BattleModule.battleData.fightPOD.RandomSeed = randomSeed

	BattleModule.__DoRequestBattleInitCommand()
end

function BattleModule.__DoRequestBattleInitCommand()
	BattleModule.isBattleOver = false
	BattleModule.forceBattleOver = false
	BattleModule.restartBattle = false
	BattleModule.isInitBattleComplete = false
	BattleModule.EnableBattleMessageLogic = false
	BattleSkillModule.AutoFightDefaultTargetBattlePos = BattleConstant.AutoFightDefaultSelectBattlePos

	GameEntry.LuaEvent:Subscribe(BattleCommandEventArgs.BattleInitCommandEventID, BattleModule.__OnBattleInitCommandHandler)
	BattleLogicAdapter.Instance:StartMainFight(BattleModule.battleData.isLocal, BattleModule.battleData.fightPOD.Players[1], BattleModule.battleData.fightPOD, BattleModule.battleData.userdata)
end

function BattleModule.__OnBattleInitCommandHandler(sender, args)
	GameEntry.LuaEvent:Unsubscribe(BattleCommandEventArgs.BattleInitCommandEventID, BattleModule.__OnBattleInitCommandHandler)

	BattleModule.battleInitCommand = args:ToLuaTable()

	BattleModule.BeginInit()
end

function BattleModule.BeginInit()
	if not BattleModule.canExecuteInit then
		BattleModule.Log("---->场景加载限制，不允许初始化战斗")

		return
	end

	if BattleModule.battleInitCommand == nil then
		BattleModule.Log("---->战斗初始化数据为nil，不允许初始化战斗")

		return
	end

	local battleInitCommand = BattleModule.battleInitCommand

	BattleModule.battleInitCommand = nil
	BattleModule.currentBigRound = battleInitCommand.CurrentBigRound
	BattleModule.maxBigRound = battleInitCommand.MaxBigRound
	BattleModule.battleTileHorizontalSize = 4
	BattleModule.battleTileVerticalSize = 3
	BattleModule.totalDmg = 0
	BattleModule.damageRecord = {}
	BattleModule.totalDamageRecord = 0

	local monsterTeamData = CfgMonsterTeamTable[battleInitCommand.MonsterTeamID]

	BattleModule.canManualExit = true

	if monsterTeamData.CanNotQuit == true then
		BattleModule.canManualExit = false
	end

	if not BattleModule.isInBattle then
		BattleModule.StartBattle(battleInitCommand)

		return
	end

	BattleModule.__OnStartBattleWave(battleInitCommand)
end

function BattleModule.StartBattle(battleInitCommand)
	BattleModule.isInBattle = true

	BattleModule.InitBattleSpeedListData()

	if SettingModule.MaintainAutoBattle() then
		BattleTeamActionModule.isAuto = SettingModule.LoadAutoBattle()
	else
		BattleTeamActionModule.isAuto = false
	end

	if SettingModule.MaintainBattleSpeed() then
		BattleModule.SetBattleSpeedByIndex(SettingModule.LoadBattleSpeedIndex())
	else
		BattleModule.SetBattleSpeedByIndex(1)
	end

	BattleModule.__InitBattleData(battleInitCommand)

	BattleModule.battleScene = BattleScene.New(function()
		BattleEffectModule.Init(BattleModule.battleScene)
		BattleTimelineModule.Init(BattleModule.battleScene)
		BattleModule.__OnBattleSceneReady()
	end)

	UIModule.Open(Constant.UIControllerName.BattleUI, Constant.UILayer.UI, {
		wave = battleInitCommand.CurrentBigRound,
		maxWave = battleInitCommand.MaxBigRound,
		maxRound = battleInitCommand.MaxRound,
		tubstitute = battleInitCommand.Tubstitute,
		battleType = battleInitCommand.BattleType
	})
	BattleModule.battleScene:LoadBattleScene(battleInitCommand.MapID)
end

function BattleModule.__OnStartBattleWave(battleInitCommand)
	if BattleModule.ContinueBattle then
		BattleModule.ContinueBattle = false

		BattleModule.SetBattleSpeedByIndex(SettingModule.LoadBattleSpeedIndex())
	end

	EventDispatcher.Dispatch(EventID.BattleWaveSetBlackScreen, true)
	BattleModule.__OnEndBattleWave()
	BattleModule.battleScene:LoadBattleScene(battleInitCommand.MapID)
	BattleModule.__InitBattleData(battleInitCommand)
	BattleModule.__OnBattleSceneReady()

	local battleUIUserData = {
		wave = battleInitCommand.CurrentBigRound,
		maxWave = battleInitCommand.MaxBigRound,
		maxRound = battleInitCommand.MaxRound,
		tubstitute = battleInitCommand.Tubstitute,
		battleType = battleInitCommand.BattleType
	}

	if UIModule.HasUI(Constant.UIControllerName.BattleUI) then
		EventDispatcher.Dispatch(EventID.ResetBattleUIShow, battleUIUserData)
	else
		UIModule.Open(Constant.UIControllerName.BattleUI, Constant.UILayer.UI, battleUIUserData)
	end
end

function BattleModule.__InitBattleData(battleInitCommand)
	BattleModule.attackTeamBattleUnitID = battleInitCommand.AttackTroopPOD.ID
	BattleModule.attackBattleTroopType = battleInitCommand.AttackTroopPOD.TroopType
	BattleModule.defendTeamBattleUnitID = battleInitCommand.DefendTroopPOD.ID
	BattleModule.defineTeamBattleUnitID = battleInitCommand.DefendTroopPOD.ID
	BattleModule.defineBattleTroopType = battleInitCommand.DefendTroopPOD.TroopType

	BattleModule.__UnitBattleTroopData(battleInitCommand.AttackTroopPOD)
	BattleModule.__UnitBattleTroopData(battleInitCommand.DefendTroopPOD)
	BattleModule.__InitBattleTileData(battleInitCommand.BattleTilePODs)
	BattleModule.__InitBattleUnitData(battleInitCommand.AttackUnitPODs)
	BattleModule.__InitBattleUnitData(battleInitCommand.DefendUnitPODs)
	BattleTeamActionModule.OnInit(battleInitCommand.TurnOrders)

	BattleModule.battleType = battleInitCommand.BattleType
end

function BattleModule.__OnBattleSceneReady()
	BattleModule.InitBattleGuideData()
	BattleEntitySortingOrderManager.Init()
	BattleEntitySortingOrderManager.Start(GetPreciseDecimal(2.1, 2), 100)

	for _tileId, _tileData in pairs(BattleModule.battleTilesData) do
		BattleModule.battleScene:RefreshBattleTileData(_tileData)
	end

	BattleModule.bossTable = {}

	ForPairs(BattleModule.battleUnitsData, function(_unitID, _unitData)
		if _unitData.isTroopData then
			return
		end

		if _unitData:IsDead() then
			return
		end

		if _unitData:IsBoss() then
			table.insert(BattleModule.bossTable, _unitID)
		end

		BattleModule.battleScene:AddBattleUnitView(_unitData)
	end)

	BattleModule.actionQueueManager = BattleActionQueueManager.New()
	BattleModule.__CustomCondition = {}
	BattleModule.delayDieUnitsTable = {}

	BattleModule.WaitAllBattleUnitReady(BattleModule.__DoBeforeBattle)

	BattleModule.updateFrameTimer = ModuleTimerUtil.NewFrameTimer(Constant.ModuleTimerName.Battle, BattleModule.__OnBattleFrameUpdate, 1, -1)

	BattleModule.updateFrameTimer:Start()
end

function BattleModule.__DoBeforeBattle()
	BattleModule.isInitBattleComplete = true

	EventDispatcher.Dispatch(EventID.BattleWaveSetBlackScreen, false)
	BattleTimeScaleManager.SetActive(true)
	EventDispatcher.Dispatch(EventID.ActiveBattleUI, false)

	local delayTime = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Battle, function()
		delayTime = nil

		BattleModule.battleScene:PlayAnimationBeforeBattle(BattleModule.__DoStartBattle)
	end, 1)

	delayTime:Start()
end

function BattleModule.__DoStartBattle()
	EventDispatcher.AddEventListener(EventID.ShowBattleSummons, BattleModule.ShowSummonsReady)

	BattleModule.__WaitingUICompleteAnimNameTable = {}

	EventDispatcher.AddEventListener(EventID.BattleUIAnimationComplete, BattleModule.__OnBattleUIAnimationComplete)
	LuaUtility.PlaySoundWithID(BattleApi:BattleStartSoundID())
	BattleModule.AddWaitUIAnimCallback("BattleStart", function()
		EventDispatcher.Dispatch(EventID.ActiveBattleUI, true)
		BattleModule.actionQueueManager:Start()

		BattleModule.EnableBattleMessageLogic = true
	end)
end

function BattleModule.OnBattleStartCommandEventHandler(battleStartCommand)
	BattleModule.UpdateBattleUnitsData(BattleConstant.BattleUpdatePoint.BattleStart, battleStartCommand.UpdateUnits, nil, function()
		BattleModule.AddCustomWaitCondition(BattleModule.actionQueueManager.WaitRoundActionReady, BattleModule.actionQueueManager, function(args)
			BattleModule.actionQueueManager:StartFirstRound()
		end, nil)
	end)
end

function BattleModule.CheckBattleOver(isForceOver)
	if BattleModule.actionQueueManager.battleOverCommand == nil then
		return false
	end

	if BattleModule.CheckBattleTroopIsAllDied(BattleModule.attackBattleTroopType) then
		return true
	end

	if BattleModule.CheckBattleTroopIsAllDied(BattleModule.defineBattleTroopType) then
		return true
	end

	if isForceOver then
		if BattleModule.forceBattleOver then
			return true
		end

		return false
	end

	return true
end

function BattleModule.CheckBattleTroopIsAllDied(battleTroop)
	for _unitId, _unitData in pairs(BattleModule.battleUnitsData) do
		if _unitId == BattleModule.attackTeamBattleUnitID or _unitId == BattleModule.defineTeamBattleUnitID then
			-- block empty
		elseif _unitData.troopType == battleTroop and not _unitData:IsDead() then
			return false
		end
	end

	return true
end

function BattleModule.ExecuteBattleOver()
	local battleOverCommand = BattleModule.actionQueueManager:DequeueBattleOverCommand()

	if battleOverCommand == nil then
		logError("战斗结束指令错误")

		return
	end

	UIModule.Close(Constant.UIControllerName.BattleSettingUI)
	UIModule.Close(Constant.UIControllerName.BattleGuideUI)

	if BattleModule.isBattleOver then
		return
	end

	BattleModule.isBattleOver = true

	if BattleModule.updateFrameTimer then
		BattleModule.updateFrameTimer:Stop()

		BattleModule.updateFrameTimer = nil
	end

	BattleModule.__OnUpdateBattleUnitsDataComplete(BattleConstant.BattleUpdatePoint.Priority, BattleModule.__DoBattleOver, battleOverCommand)
end

function BattleModule.__DoBattleOver(battleOverCommand)
	local isWin = battleOverCommand.FightResult == 1

	BattleModule.Log("战斗结束 BattleType:{0} FightResult:{1}", battleOverCommand.BattleType, battleOverCommand.FightResult)

	if isWin then
		ForPairs(BattleModule.battleUnitsData, function(_battleUnitID, _battleUnitData)
			if _battleUnitData:IsDead() then
				return
			end

			if not _battleUnitData.joinBattle then
				return
			end

			local battleUnitView = BattleModule.battleScene:GetBattleUnitViewByID(_battleUnitID)

			if battleUnitView == nil then
				return
			end

			if _battleUnitData.PODData.CreateType ~= BattleConstant.BattleUnitCreateType.Summon then
				battleUnitView:PlayAnimation("win", true)
			end
		end)
	end

	if BattleModule.isPlayback then
		return
	end

	if BattleModule.battleData.isTestBattle then
		return
	end

	local star = isWin and 3 or 0

	net_fight.fightOver(star, battleOverCommand.BattleType, battleOverCommand.FightResult, battleOverCommand.DmgRecords, battleOverCommand.Attacker, battleOverCommand.Defender, battleOverCommand.JsonOrder, battleOverCommand.UserData, BattleModule.totalDamageRecord)

	local realFightOver = BattleModule.maxBigRound == BattleModule.currentBigRound

	if not realFightOver then
		return
	end

	BattleTimeScaleManager.SetActive(false)

	BattleTimeScaleManager.TimeScale = 1

	UIModule.Close(Constant.UIControllerName.BattleUI)
end

function BattleModule.__OnBattleFrameUpdate()
	local deltaTime = UnityEngine.Time.deltaTime

	ForArrayTable(BattleModule.__CustomCondition, function(_, _condition)
		_condition:Check()
	end)
	ForArrayTable(BattleModule.__CustomCondition, function(_index, _condition)
		if not _condition.isCompleted then
			return
		end

		_condition:Dispose()
		table.remove(BattleModule.__CustomCondition, _index)
	end, true)
	BattleModule.actionQueueManager:Update()
	BattleModule.battleScene:OnFrameUpdate(deltaTime)
end

function BattleModule.__OnEndBattleWave()
	ModuleTimerUtil.Stop(Constant.ModuleTimerName.Battle)

	BattleModule.updateFrameTimer = nil
	BattleModule.__CustomCondition = {}

	BattleEffectModule.Revert()
	BattleTimelineModule.Revert()
	BattleEntitySortingOrderManager.Dispose()
	BattleModule.actionQueueManager:Dispose()

	BattleModule.actionQueueManager = nil

	BattleModule.dialogQueue:Clear()
	ForPairs(BattleModule.battleTilesData, function(k, v)
		v:Dispose()
	end)

	BattleModule.battleTilesData = {}

	ForPairs(BattleModule.battleUnitsData, function(k, v)
		v:Dispose()
	end)

	BattleModule.battleUnitsData = {}

	ForPairs(BattleModule.battleTroopsData, function(k, v)
		v:Dispose()
	end)

	BattleModule.battleTroopsData = {}

	ForPairs(BattleModule.summonUnitTable, function(k, v)
		v:Dispose()
	end)

	BattleModule.summonUnitTable = {}

	BattleModule.battleScene:Clear()
end

function BattleModule.__OnEndBattle()
	BattleModule.showRightToolsButton = true

	if not BattleModule.isInBattle then
		return
	end

	ModuleTimerUtil.Stop(Constant.ModuleTimerName.Battle)

	BattleModule.updateFrameTimer = nil
	BattleModule.__CustomCondition = {}

	BattleTimelineModule.Dispose()
	UIModule.Close(Constant.UIControllerName.BattleUI)
	BattleTimeScaleManager.SetActive(false)

	BattleTimeScaleManager.TimeScale = 1
	BattleTeamActionModule.isAuto = false

	BattleEntitySortingOrderManager.Dispose()
	BattleModule.actionQueueManager:Dispose()
	BattleModule.dialogQueue:Clear()
	ForPairs(BattleModule.battleTilesData, function(k, v)
		v:Dispose()
	end)

	BattleModule.battleTilesData = {}

	ForPairs(BattleModule.battleUnitsData, function(k, v)
		v:Dispose()
	end)

	BattleModule.battleUnitsData = {}

	ForPairs(BattleModule.battleTroopsData, function(k, v)
		v:Dispose()
	end)

	BattleModule.battleTroopsData = {}

	ForPairs(BattleModule.summonUnitTable, function(k, v)
		v:Dispose()
	end)

	BattleModule.summonUnitTable = {}

	BattleModule.battleScene:Dispose()

	BattleModule.battleScene = nil

	BattleEffectModule.Dispose()
end

function BattleModule.Dispose()
	BattleModule.__OnEndBattle()

	BattleModule.ContinueBattle = false
	BattleModule.isInBattle = false
	BattleModule.canExecuteInit = true
end

function BattleModule.__InitBattleTileData(battleTilePODs)
	for i = 1, #battleTilePODs do
		local tileData = BattleTileData.New(battleTilePODs[i])

		BattleModule.battleTilesData[tileData.battleUnitID] = tileData
	end
end

function BattleModule.__InitBattleUnitData(battleUnitPODs)
	for i = 1, #battleUnitPODs do
		BattleModule.__AddBattleUnit(battleUnitPODs[i])
	end
end

function BattleModule.__AddBattleUnit(battleUnitPOD)
	local unitData = BattleUnitData.New(battleUnitPOD)

	BattleModule.battleUnitsData[unitData.battleUnitID] = unitData
end

function BattleModule.__UnitBattleTroopData(battleTroopPOD)
	local troopData = BattleTroopData.New(battleTroopPOD)

	BattleModule.battleTroopsData[troopData.battleUnitID] = troopData
end

function BattleModule.AddBattleUnit(battleUnitPOD)
	local unitData = BattleModule.__AddBattleUnit(battleUnitPOD)

	BattleModule.battleScene:AddBattleUnitView(unitData)
end

function BattleModule.AddBattleSummonUnit(battleUnitID, summonBattleUnitPOD)
	local summonUnitData = BattleUnitData.New(summonBattleUnitPOD)

	BattleModule.battleUnitsData[summonUnitData.battleUnitID] = summonUnitData

	BattleModule.battleScene:AddBattleUnitView(summonUnitData)
end

function BattleModule.GetBattleUnitDataByUnitID(battleUnitId)
	if battleUnitId == BattleModule.attackTeamBattleUnitID then
		return BattleModule.battleTroopsData[battleUnitId]
	end

	if battleUnitId == BattleModule.defendTeamBattleUnitID then
		return BattleModule.battleTroopsData[battleUnitId]
	end

	return BattleModule.battleUnitsData[battleUnitId]
end

function BattleModule.GetBattleUnitDataByTileIndex(tileIndex)
	local result

	BattleModule.ForeachBattleUnits(function(_unitId, _unitData)
		if _unitId == BattleModule.attackTeamBattleUnitID then
			return false
		end

		if _unitId == BattleModule.defendTeamBattleUnitID then
			return false
		end

		if _unitData:IsDead() then
			return false
		end

		local tileKey = BattleModule.BattleTilePosStoC(_unitData.troopType, _unitData.battlePos)

		if tileKey == tileIndex then
			result = _unitData

			return true
		end
	end)

	return result
end

function BattleModule.GetBattleUnitViewByTilePos(troopType, battlePos)
	local tileKey = BattleModule.BattleTilePosStoC(troopType, battlePos)

	return BattleModule.battleScene:GetBattleUnitViewByTileKey(tileKey)
end

function BattleModule.GetBattleUnitViewByUnitID(battleUnitId)
	return BattleModule.battleScene:GetBattleUnitViewByID(battleUnitId)
end

function BattleModule.GetBattleUnitViewByInstanceID(instanceID)
	return BattleModule.battleScene:GetBattleUnitViewByInstanceID(instanceID)
end

function BattleModule.ForeachBattleTiles(action)
	for _unitID, _tileData in pairs(BattleModule.battleTilesData) do
		if action(_unitID, _tileData) == true then
			return
		end
	end
end

function BattleModule.GetBattleTileDataByTileIndex(tileIndex)
	for _unitID, _tileData in pairs(BattleModule.battleTilesData) do
		if _tileData.tileIndex == tileIndex then
			return _tileData
		end
	end

	return nil
end

function BattleModule.GetBattleTileDataByUnitID(battleUnitID)
	return BattleModule.battleTilesData[battleUnitID]
end

function BattleModule.GetBattleTileViewDataByUnitID(battleUnitID)
	local tileData = BattleModule.GetBattleTileDataByUnitID(battleUnitID)

	return BattleModule.GetBattleTileDataByTileIndex(tileData.tileIndex)
end

function BattleModule.GetBattleTileViewByTileIndex(tileIndex)
	return BattleModule.battleScene:GetBattleTileView(tileIndex)
end

function BattleModule.GetBattleTileViewByMovePointInstanceID(instanceID)
	return BattleModule.battleScene:GetBattleTileViewByMovePointInstanceID(instanceID)
end

function BattleModule.ForeachBattleUnitsView(action)
	BattleModule.battleScene:ForeachBattleUnitView(action)
end

function BattleModule.OnBattleUnitDie(battleUnitID)
	BattleModule.__DoBattleUnitDie(battleUnitID, true)
end

function BattleModule.RemoveSummon(battleUnitID)
	local battleUnitData = BattleModule.battleUnitsData[battleUnitID]

	if battleUnitData == nil then
		return
	end

	battleUnitData.specialStatus[Constant.BattleSPStatus.Dead] = true
	battleUnitData.joinBattle = true

	BattleModule.__DoBattleUnitDie(battleUnitID, false)
end

function BattleModule.__DoBattleUnitDie(battleUnitID, playTimeline)
	EventDispatcher.Dispatch(EventID.BattleUnitDead, battleUnitID)

	if not playTimeline then
		EventDispatcher.Dispatch(EventID.RemoveBattleUnit, battleUnitID)

		return
	end

	BattleTimelineModule.PlayStateTimeline(battleUnitID, BattleConstant.BattleStateTimelineType.Die, function()
		EventDispatcher.Dispatch(EventID.RemoveBattleUnit, battleUnitID)
	end)
end

function BattleModule.UpdateBattleUnitsData(updatePoint, updateUnitsPOD, userData, callback)
	if updateUnitsPOD == nil then
		BattleModule.__OnUpdateBattleUnitsDataComplete(updatePoint, callback)

		return
	end

	local totalCount = #updateUnitsPOD

	if totalCount == 0 then
		BattleModule.__OnUpdateBattleUnitsDataComplete(updatePoint, callback)

		return
	end

	local function checkSuccessFunc()
		totalCount = totalCount - 1

		if totalCount <= 0 then
			BattleModule.__OnUpdateBattleUnitsDataComplete(updatePoint, callback)
		end
	end

	for podIndex = 1, #updateUnitsPOD do
		local battleUpdateUnitPOD = updateUnitsPOD[podIndex]

		if battleUpdateUnitPOD.Scope == Constant.UpdateScope.BattleTile then
			BattleModule.UpdateBattleTileData(updatePoint, battleUpdateUnitPOD, userData, function()
				checkSuccessFunc()
			end)
		else
			BattleModule.UpdateBattleUnitData(updatePoint, updateUnitsPOD[podIndex], userData, function()
				checkSuccessFunc()
			end)
		end
	end
end

function BattleModule.__OnUpdateBattleUnitsDataComplete(updatePoint, callback, args)
	ForPairs(BattleModule.battleUnitsData, function(_battleUnitID, _battleUnitData)
		if _battleUnitData:IsDead() then
			return
		end

		if not _battleUnitData.joinBattle then
			return
		end

		if _battleUnitID == BattleModule.attackTeamBattleUnitID then
			return
		end

		if _battleUnitID == BattleModule.defineTeamBattleUnitID then
			return
		end

		BattleEffectModule.RefreshUnitRendererFeature(_battleUnitID)
	end)
	EventDispatcher.Dispatch(EventID.UpdateBattleUnitsDataComplete, updatePoint)

	if updatePoint == BattleConstant.BattleUpdatePoint.SkillStart or updatePoint == BattleConstant.BattleUpdatePoint.SkillHit or updatePoint == BattleConstant.BattleUpdatePoint.SkillEnd then
		callback(args)

		return
	end

	local dieCount = #BattleModule.delayDieUnitsTable

	for i = 1, dieCount do
		local battleUnitID = BattleModule.delayDieUnitsTable[i]

		BattleModule.OnBattleUnitDie(battleUnitID)
	end

	BattleModule.delayDieUnitsTable = {}

	if dieCount > 0 then
		if updatePoint == BattleConstant.BattleUpdatePoint.TurnEnd and BattleModule.__tempRecordTurnMoverID ~= 0 and BattleModule.__tempRecordTurnMoverID ~= nil then
			local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(BattleModule.__tempRecordTurnMoverID)

			if battleUnitData.troopType == BattleModule.playerBattleTroop then
				CVModule.PlayCV(Constant.CVActionType.FightKillEnemy, battleUnitData:GetHeroCid())

				BattleModule.__tempRecordTurnMoverID = 0
			end
		end

		local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Battle, function()
			callback(args)
		end, BattleConstant.OnUnitDieEffectTime, 1, true)

		timer:Start()
	else
		callback(args)
	end
end

function BattleModule.ExecuteDelayDie(callback)
	local dieCount = #BattleModule.delayDieUnitsTable

	for i = 1, dieCount do
		local battleUnitID = BattleModule.delayDieUnitsTable[i]

		BattleModule.OnBattleUnitDie(battleUnitID)
	end

	BattleModule.delayDieUnitsTable = {}

	if dieCount > 0 then
		if BattleModule.__tempRecordTurnMoverID ~= 0 and BattleModule.__tempRecordTurnMoverID ~= nil then
			local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(BattleModule.__tempRecordTurnMoverID)

			if battleUnitData.troopType == BattleModule.playerBattleTroop then
				CVModule.PlayCV(Constant.CVActionType.FightKillEnemy, battleUnitData:GetHeroCid())

				BattleModule.__tempRecordTurnMoverID = 0
			end
		end

		local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Battle, function()
			callback()
		end, BattleConstant.OnUnitDieEffectTime, 1, true)

		timer:Start()
	else
		callback()
	end
end

function BattleModule.UpdateBattleUnitData(updatePoint, battleUpdateUnitPOD, userData, callback)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUpdateUnitPOD.ID)

	if battleUnitData == nil then
		logError("BattleModule.UpdateBattleUnitData: battleUnitID={0} is not existent.", battleUpdateUnitPOD.ID)
		callback()

		return
	end

	local updateFunc = BattleModule.__UpdateUnitFuc[battleUpdateUnitPOD.Type]

	if updateFunc == nil then
		warning("BattleModule __UpdateUnitFuc 未实现数据更新类型 ---> {0}", battleUpdateUnitPOD.Type)
		callback()

		return
	end

	local temp_userData = userData and userData or {}

	temp_userData.UpdatePoint = updatePoint
	temp_userData.UnitData = battleUnitData
	temp_userData.UnitView = BattleModule.GetBattleUnitViewByUnitID(battleUpdateUnitPOD.ID)

	updateFunc(battleUpdateUnitPOD, temp_userData, function()
		EventDispatcher.Dispatch(EventID.BattleUnitUpdateStatus, battleUpdateUnitPOD.ID)

		if temp_userData.UnitView ~= nil then
			temp_userData.UnitView = nil
		end

		temp_userData = nil

		callback()
	end)
end

function BattleModule.UpdateBattleTileData(updatePoint, battleUpdateUnitPOD, userData, callback)
	local tileID = battleUpdateUnitPOD.ID
	local battleTileData = BattleModule.GetBattleTileDataByUnitID(tileID)
	local battleTileView = BattleModule.GetBattleTileViewByTileIndex(battleTileData.tileIndex)

	if battleTileData == nil then
		logError("BattleUnitData:UpdateBattleTileData:  battleGridData is nil, tileID={0}", tileID)

		if callback ~= nil then
			callback()
		end

		return
	end

	if battleTileView == nil then
		logError("BattleUnitData:UpdateBattleTileData:  battleGridView is nil, tileID={0}", tileID)

		if callback ~= nil then
			callback()
		end

		return
	end

	if battleUpdateUnitPOD.Type == Constant.UpdateType.CHANGE_TILE_TERRAIN then
		local terrainCid = battleUpdateUnitPOD.Param[1]

		battleTileData.TerrainCid = terrainCid

		battleTileView:UpdateTerrainCid(terrainCid)
	elseif battleUpdateUnitPOD.Type == Constant.UpdateType.UPDATE_BUFF then
		local buffConfigID = battleUpdateUnitPOD.Param[1]
		local buffStack = battleUpdateUnitPOD.Param[2]
		local leftCount = battleUpdateUnitPOD.Param[3]
		local isAdd = battleUpdateUnitPOD.Param[4] == 1
		local battleBuffData = battleTileData.buffsData[buffConfigID]

		if isAdd then
			battleBuffData = BattleBuffData.New(buffConfigID, buffStack, leftCount)
			battleTileData.buffsData[buffConfigID] = battleBuffData

			BattleModule.Log("地格单位 {0} 添加一个BUFF {1}", tostring(battleUpdateUnitPOD.ID), tostring(buffConfigID))
			battleTileView:AddBuff(battleBuffData)
		elseif battleBuffData ~= nil then
			battleBuffData:Update(buffStack, leftCount)
			BattleModule.Log("地格单位 {0} 更新一个BUFF {1}", tostring(battleUpdateUnitPOD.ID), tostring(buffConfigID))
			battleTileView:UpdateBuff(battleBuffData)
		else
			logError("地格单位 {0} 更新一个不存在的BUFF {1}", tostring(battleUpdateUnitPOD.ID), tostring(buffConfigID))
		end
	elseif battleUpdateUnitPOD.Type == Constant.UpdateType.TRIGGER_BUFF then
		local buffConfigID = battleUpdateUnitPOD.Param[1]

		battleTileView:TriggerBuff(buffConfigID)
	elseif battleUpdateUnitPOD.Type == Constant.UpdateType.REMOVE_BUFF then
		local buffConfigID = battleUpdateUnitPOD.Param[1]

		BattleModule.Log("地格单位 {0} 移除一个BUFF {1}", tostring(battleUpdateUnitPOD.ID), tostring(buffConfigID))
		battleTileView:RemoveBuff(buffConfigID)
	end

	BattleModule.Log("BattleModule.UpdateBattleTileData  更新地格数据：" .. tostring(tileID) .. " Type " .. tostring(battleUpdateUnitPOD.Type) .. " Param[1] " .. tostring(battleUpdateUnitPOD.Param[1]))

	if callback ~= nil then
		callback()
	end
end

function BattleModule.CheckDialog(callback)
	if BattleModule.dialogQueue.Size == 0 then
		callback()

		return
	end

	local dialogCid = BattleModule.dialogQueue:Dequeue()

	EventDispatcher.Dispatch(EventID.ShowBattleDialog, dialogCid, callback)
end

function BattleModule.BattleTilePosStoC(troopType, servicePos)
	return troopType * BattleConstant.BattleTilePosTroopTypeOffset + servicePos
end

function BattleModule.BattleTilePosCtoS(troopType, clientPos)
	return clientPos - troopType * BattleConstant.BattleTilePosTroopTypeOffset
end

function BattleModule.SceneWorldPointToWorldPointInRectangle(sceneWorldPoint, rectTrans)
	local screenPoint = BattleModule.battleScene.battleCameraCom:WorldToScreenPoint(sceneWorldPoint)

	return UGUIUtil.ScreenPointToWorldPointInRectangleByScreenPoint(rectTrans, screenPoint)
end

function BattleModule.GetHeroBattleElementEntityCfgBySkinCid(skinCid)
	local skinCfg = CfgHeroSkinTable[skinCid]
	local elementEntityCid = skinCfg.BattleEntityID

	return CfgElementEntityTable[elementEntityCid]
end

function BattleModule.GetBattleUnitHeadIcon(battleUnitId)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitId)

	return BattleModule.GetBattleUnitSkinImageByUnitData(battleUnitData, Constant.SkinImageType.HeadIcon)
end

function BattleModule.GetBattleUnitHeadIconByUnitData(battleUnitData)
	return BattleModule.GetBattleUnitSkinImageByUnitData(battleUnitData, Constant.SkinImageType.HeadIcon)
end

function BattleModule.GetBattleUnitSkinImageByUnitData(battleUnitData, SkinImageType)
	local skinCfg = CfgHeroSkinTable[battleUnitData.PODData.HeroSkinId]

	return SkinModule.GetHeroSkinImgPathByType(skinCfg, SkinImageType)
end

function BattleModule.WaitAllBattleUnitReady(callback)
	local function checkFunc()
		for _battleUnitID, _battleUnitData in pairs(BattleModule.battleUnitsData) do
			if not _battleUnitData.joinBattle then
				local isReady = BattleModule.battleScene:IsBattleUnitReadyToShow(_battleUnitID)

				if not isReady then
					return false
				end

				local tileKey = BattleModule.BattleTilePosStoC(_battleUnitData.troopType, _battleUnitData.battlePos)
				local battleUnitView = BattleModule.battleScene:GetBattleUnitViewByTileKey(tileKey)

				if battleUnitView ~= nil and battleUnitView.battleUnitID ~= _battleUnitID then
					local tempUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitView.battleUnitID)

					if not tempUnitData:IsDead() then
						logError("战斗召唤出错，战斗单位 {0} 和 {1} 出现在同一地格 -----> {2}", battleUnitView.battleUnitID, _battleUnitID, _battleUnitData.battlePos)
					end

					return false
				end
			end
		end

		for _unitID, _summonTable in pairs(BattleModule.summonUnitTable) do
			for _summonUnitID, _ in pairs(_summonTable) do
				local isReady = BattleModule.battleScene:IsBattleUnitReadyToShow(_summonUnitID)

				if not isReady then
					return false
				end
			end
		end

		local isSkinViewReady = true

		ForPairs(BattleModule.battleScene.battleUnitSkinView, function(_battleUnitID, _battleUnitView)
			if _battleUnitView.isReadyToShow then
				return
			end

			if BattleTimelineModule.CheckBattleUnitTimelineIsReady(_battleUnitID) then
				return
			end

			isSkinViewReady = false

			return true
		end)

		return isSkinViewReady
	end

	local customCondition = BattleCustomWaitConditionData.New(checkFunc, nil, callback, nil)

	table.insert(BattleModule.__CustomCondition, customCondition)
end

function BattleModule.ShowSummonsReady(userData)
	BattleModule.ShowAllSummons()
end

function BattleModule.ShowAllSummons(callback)
	for _unitID, _unitData in pairs(BattleModule.battleUnitsData) do
		if not _unitData.joinBattle then
			BattleModule.battleScene:BattleUnitJoinBattle(_unitID, function()
				EventDispatcher.Dispatch(EventID.BattleUnitJoinFight, _unitID)
			end)
		end
	end

	ForPairs(BattleModule.battleScene.battleUnitSkinView, function(_battleUnitID, _battleUnitView)
		BattleModule.battleScene:BattleUnitSkinViewJoinBattle(_battleUnitID)
	end)

	if callback ~= nil then
		callback()
	end
end

function BattleModule.AddCustomWaitCondition(condition, args1, callback, args2)
	local customCondition = BattleCustomWaitConditionData.New(condition, args1, callback, args2)

	table.insert(BattleModule.__CustomCondition, customCondition)
end

function BattleModule.AddCustomWaitConditionByConditionData(customData)
	table.insert(BattleModule.__CustomCondition, customData)
end

function BattleModule.AddCustomWaitSecondCondition(second, callback, args)
	local customWaitSecondData = BattleCustomWaitSecondData.New(second, callback, args)

	table.insert(BattleModule.__CustomCondition, customWaitSecondData)
end

function BattleModule.__OnBattleUIAnimationComplete(animaName)
	if BattleModule.__WaitingUICompleteAnimNameTable[animaName] == nil then
		return
	end

	BattleModule.__WaitingUICompleteAnimNameTable[animaName] = true
end

function BattleModule.AddWaitUIAnimCallback(uiAnimName, callback, args)
	BattleModule.__WaitingUICompleteAnimNameTable[uiAnimName] = false

	BattleModule.AddCustomWaitCondition(function(_uiAnimName)
		return BattleModule.__WaitingUICompleteAnimNameTable[_uiAnimName]
	end, uiAnimName, callback, args)
	EventDispatcher.Dispatch(EventID.PlayBattleUIAnimation, uiAnimName)
end

function BattleModule.ForeachBattleUnits(action)
	for _unitId, _unitData in pairs(BattleModule.battleUnitsData) do
		if action(_unitId, _unitData) == true then
			return
		end
	end
end

function BattleModule.InitBattleGuideData()
	if BattleModule.guideData == nil then
		BattleModule.__OnInitBattleGuideData()
	else
		BattleModule.__OnRefreshBattleGuideData()
	end
end

function BattleModule.__OnInitBattleGuideData()
	BattleModule.guideData = {}

	for _cid, _data in ipairs(CfgBattleGuideTable) do
		if BattleModule.guideData[_data.Type] == nil then
			BattleModule.guideData[_data.Type] = {}
		end

		local itemData = {}

		itemData.cid = _cid
		itemData.guideType = _data.Type
		itemData.moduleId = _data.ModuleId
		itemData.unLock = BattleModule.__BattleGuideIsUnLock(_data)
		itemData.isNew = itemData.unLock and BattleModule.__BattleGuideIsNew(_data) or false

		table.insert(BattleModule.guideData[_data.Type], itemData)
	end
end

function BattleModule.__OnRefreshBattleGuideData()
	ForPairs(BattleModule.guideData, function(_guideType, _guideItems)
		ForArray(_guideItems, function(_index, _guideItem)
			if _guideItem.unLock and not _guideItem.isNew then
				return
			end

			local cfgData = CfgBattleGuideTable[_guideItem.cid]

			if not _guideItem.unLock then
				_guideItem.unLock = BattleModule.__BattleGuideIsUnLock(cfgData)
			end

			if not _guideItem.unLock then
				return
			end

			_guideItem.isNew = BattleModule.__BattleGuideIsNew(cfgData)
		end)
		table.sort(_guideItems, function(_a, _b)
			local _cfgA = CfgBattleGuideTable[_a.cid]
			local _cfgB = CfgBattleGuideTable[_b.cid]

			return _cfgA.Sequence > _cfgB.Sequence
		end)
	end)
end

function BattleModule.__BattleGuideIsNew(cfg)
	if #cfg.UnlockCondition == 0 then
		return false
	end

	return true
end

function BattleModule.__BattleGuideIsUnLock(cfg)
	local conditionResult = ConditionModule.CheckMultiple(cfg.UnlockCondition)

	return ConditionModule.CheckMultipleAllIsPass(conditionResult)
end

function BattleModule.RecordDamage_BattleStartCommand(battleStartCommand)
	local updateUnits = battleStartCommand.UpdateUnits

	BattleModule.RecordDamage_BattleUpdateUnitPOD(updateUnits)
end

function BattleModule.RecordDamage_BattleRoundCommand(battleRoundCommand)
	local updateUnits = battleRoundCommand.UpdateUnits

	BattleModule.RecordDamage_BattleUpdateUnitPOD(updateUnits)
end

function BattleModule.RecordDamage_BattleChooseSkillCommand(battleChooseSkillCommand)
	local updateUnits = battleChooseSkillCommand.UpdateUnits

	BattleModule.RecordDamage_BattleUpdateUnitPOD(updateUnits)
end

function BattleModule.RecordDamage_BattleTurnCommand(battleTurnCommand)
	local beforeUpdateUnits = battleTurnCommand.BeforeActionPOD.UpdateUnits

	BattleModule.RecordDamage_BattleUpdateUnitPOD(beforeUpdateUnits)

	local inActionPOD = battleTurnCommand.InActionPOD

	if inActionPOD ~= nil then
		ForPairs(inActionPOD.CastSkills, function(_, castSkillPOD)
			BattleModule.RecordDamage_BattleUpdateUnitPOD(castSkillPOD.BeforeUpdateUnits)

			local skillHitPOD = castSkillPOD.SkillHits

			ForPairs(skillHitPOD, function(_, _skillHitPOD)
				BattleModule.RecordDamage_BattleUpdateUnitPOD(_skillHitPOD.UpdateUnits)
			end)
			BattleModule.RecordDamage_BattleUpdateUnitPOD(castSkillPOD.AfterUpdateUnits)
		end)
	end

	local afterUpdateUnits = battleTurnCommand.AfterActionPOD.UpdateUnits

	BattleModule.RecordDamage_BattleUpdateUnitPOD(afterUpdateUnits)
end

function BattleModule.RecordDamage_BattleRoundEndCommand(battleRoundEndCommand)
	local updateUnits = battleRoundEndCommand.UpdateUnits

	BattleModule.RecordDamage_BattleUpdateUnitPOD(updateUnits)
end

function BattleModule.RecordDamage_BattleOverCommand(battleOverCommand)
	local updateUnits = battleOverCommand.UpdateUnits

	BattleModule.RecordDamage_BattleUpdateUnitPOD(updateUnits)
end

function BattleModule.RecordDamage_BattleUpdateUnitPOD(updateUnits)
	if updateUnits == nil then
		return
	end

	ForPairs(updateUnits, function(_, updateUnitPOD)
		if updateUnitPOD.Type ~= Constant.UpdateType.CHANGE_HP then
			return
		end

		local damage = updateUnitPOD.Param[2]

		BattleModule.__RecordDamage(updateUnitPOD.ID, damage)
	end)
end

function BattleModule.Log(log, ...)
	if SYZZBattleLog.IsEnableLogBattlePhase then
		logDebug("BattleClient--DEBUG: " .. log, ...)
	end
end
