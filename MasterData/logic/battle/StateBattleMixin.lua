-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\battle\\StateBattleMixin.lua

local ResHero = require("ClientData/ResHero")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResMonster = require("ClientData/ResMonster")
local ResBattleMonsterWaves = require("ClientData/ResBattleMonsterWaves")
local ResMazeInitConfig = require("ClientData/ResMazeInitConfig")
local ResNewMaze = require("ClientData/ResNewMaze")
local BattleMiscConfig = require("Common/BattleMiscConfig")
local StateBattleMixin = {}

function StateBattleMixin:getMatrixInput()
	local input = {}

	if self.battleType == BattleConst.BATTLE_TYPE_BEGINNER then
		input.randomSeed = 100
	else
		input.randomSeed = self.randomSeed
	end

	input.manualOpera = false
	input.entityDict = self.mEntityDict
	input.leftDir = self.leftDir
	input.upDir = self.upDir
	input.LR_LEN = 6
	input.UD_LEN = 3
	input.GRID_SIZE = 2.35
	input.centerPoint = self.centerPoint
	input.battleConfig = ResBattleConfig[self.battleNo] or {}
	input.speData = self.speData
	input.GridConfig = BattleMiscConfig.NORMAL_POS_CONFIG

	if self:isZombieBattle() then
		input.GridConfig = BattleMiscConfig.ZOMBIE_POS_CONFIG
		input.BATTLE_SPEC = BattleConst.SPECIAL_BATTLE_SUN_FLOWER
		input.LR_LEN = 7
		input.UD_LEN = 5
		input.ODD_SHORTER = true
	elseif input.battleConfig.matrix_type == 1 then
		input.GridConfig = BattleMiscConfig.SPE_BOSS_POS_CONFIG
		input.UD_LEN = 5
		input.LR_LEN = 5
	end

	if self.battleType == BattleConst.BATTLE_TYPE_STEPTOWER then
		input.speData.campBuffData = {}
	end

	input.battleType = self.battleType

	if self.sceneInfo and self.sceneInfo.chuyin_pos then
		input.GridConfig.CHUYIN_POS = self.sceneInfo.chuyin_pos
	else
		input.GridConfig.CHUYIN_POS = input.GridConfig.DEFAULT_CHUYIN_POS
	end

	if self.sceneInfo and self.sceneInfo.pet_skill_pos then
		input.GridConfig.PET_INIT_POS = self.sceneInfo.pet_skill_pos
	else
		input.GridConfig.PET_INIT_POS = input.GridConfig.DEFAULT_PET_ANIM_POS
	end

	input.petEntity = self.petEntity

	return input
end

function StateBattleMixin:getBattleMonsters()
	local battleData = ResBattleConfig[self.battleNo] or {}
	local monsters = battleData.monsters or {}

	if self:isZombieBattle() then
		monsters = {}
	end

	return monsters
end

function StateBattleMixin:battleHideGameObject()
	if self.preHideSceneObjects then
		for _, node in ipairs(self.preHideSceneObjects) do
			if node and not tolua.isnull(node) then
				node:SetActive(true)
			end
		end

		self.preHideSceneObjects = nil
	end

	if self.sceneInfo and self.sceneInfo.hide_go_name then
		self.preHideSceneObjects = {}

		for _, path in ipairs(self.sceneInfo.hide_go_name) do
			local node = UnityEngine.GameObject.Find(path)

			if node then
				table.insert(self.preHideSceneObjects, node)
				node:SetActive(false)
			end
		end
	end
end

function StateBattleMixin:initObjInfo()
	self.relicHero = nil
	self.mEntityDict = {}

	local battleData = ResBattleConfig[self.battleNo] or {}
	local objId = 1

	self.battleHeroNum = 0

	for _, hero in ipairs(self.heros) do
		if self.onlineMode and hero.heroRelic and hero.heroRelic:getBgmIdByType(Const.RELIC_BGM_TYPE_BATTLE) then
			self.relicHero = hero.heroObj

			self.relicHero:setEquips(nil, nil, hero.heroRelic)
		end

		if ResHero[hero.heroID] then
			hero.entityID = objId
			self.mEntityDict[objId] = hero
			objId = objId + 1

			if hero.camp == BattleConst.CAMP_PLAYER then
				self.battleHeroNum = self.battleHeroNum + 1
			end
		end
	end

	if self.battleType ~= BattleConst.BATTLE_TYPE_ASYNC_PVP then
		local friends = battleData.friends or {}

		for pos, monsterID in ipairs(friends) do
			if ResMonster[monsterID] then
				self.mEntityDict[objId] = utils.getBattleMonsterInfo(monsterID, pos, BattleConst.CAMP_PLAYER, objId)
				objId = objId + 1
			end
		end

		local monsterHps = {}

		if self.speData and self.speData.monsterHps then
			monsterHps = self.speData.monsterHps
		end

		local monsters = self:getBattleMonsters()

		for pos, monsterID in ipairs(monsters) do
			if ResMonster[monsterID] and (not monsterHps[pos] or not (monsterHps[pos] <= 0)) then
				self.mEntityDict[objId] = utils.getBattleMonsterInfo(monsterID, pos, BattleConst.CAMP_MONSTER, objId)
				objId = objId + 1
			end
		end
	end
end

function StateBattleMixin:checkOpenWearInfo()
	local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_BAGWEAR)

	if not isLocked and not utils.tableIsContainsElement(BattleConst.HIDE_WEAR_TYPE, self.battleType) then
		return true
	end

	return false
end

function StateBattleMixin:clear()
	if self.mMatrixInstance then
		self.mMatrixInstance:destroy()

		self.mMatrixInstance = nil
	end

	if self.frameMgr then
		self.frameMgr:destroy()

		self.frameMgr = nil
	end

	if self.mActorMgr then
		self.mActorMgr:destroy()

		self.mActorMgr = nil
	end

	if self.mBattleOverMgr then
		self.mBattleOverMgr:destroy()

		self.mBattleOverMgr = nil
	end

	if self.battleMvp then
		self.battleMvp = nil
	end
end

function StateBattleMixin:isZombieBattle()
	if ResBattleMonsterWaves[self.battleNo] then
		return true
	end
end

function StateBattleMixin:isClanBossBattle()
	return self.battleType == BattleConst.BATTLE_TYPE_CIRCLE and self.speData and self.speData.clanData and self.speData.clanData.isBoss
end

function StateBattleMixin:needExtraSpeed()
	if self.battleType == BattleConst.BATTLE_TYPE_MAZE and self.speData and self.speData.mazeData then
		local maze_id = self.speData.mazeData.maze_id
		local mazeConifg = ResMazeInitConfig[maze_id]

		return mazeConifg and mazeConifg.can_extra_speed == 1, 4
	elseif self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE and self.speData and self.speData.newMazeData then
		local actId = self.speData.newMazeData.tmpID
		local newMazeConfig = ResNewMaze[actId]

		return newMazeConfig and newMazeConfig.fight_four_times == 1, 4
	elseif self.battleType == BattleConst.BATTLE_TYPE_STAGE or self.battleType == BattleConst.BATTLE_TYPE_ONCETOWER then
		return not ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_SPEED8_FIGHT), 8
	else
		return self.battleType == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP or self.battleType == BattleConst.BATTLE_TYPE_OPACT_PVP or self.battleType == BattleConst.BATTLE_TYPE_ASYNC_PVP or self.battleType == BattleConst.BATTLE_TYPE_MAZE or self.battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER or self.battleType == BattleConst.BATTLE_TYPE_EQUIPTOWER or self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER and self:isZombieBattle() or self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND, 4
	end
end

function StateBattleMixin:checkRecordWatchCamera()
	if self.inWatchMode then
		local angles = CameraModeManager.getBattleCameraAngles()

		if angles then
			local x = angles.x
			local y = angles.y
			local UserData = require("Helper/UserData")

			UserData.saveCommonData(BattleConst.BATTLE_CAMERA_MODE_RECORD, x .. "," .. y)
		end
	end
end

function StateBattleMixin:setWatchMode(watchMode)
	self.inWatchMode = watchMode

	if self.mActorMgr and self.mActorMgr.actors then
		for _, actor in pairs(self.mActorMgr.actors) do
			actor:refreshLogoVisible()
		end
	end
end

function StateBattleMixin:getBattleObjMgr(...)
	if self.mMatrixInstance then
		return self.mMatrixInstance.bObjMgr
	end
end

return StateBattleMixin
