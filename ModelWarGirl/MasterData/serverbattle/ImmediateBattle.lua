-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ServerBattle\\ImmediateBattle.lua

local ResHero = require("ClientData/ResHero")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResMonster = require("ClientData/ResMonster")
local TheMatrixClass = require("Common/FrameBattle/TheMatrix")
local ImmediateBattle = {}
local StateBattleMixin = require("Logic/battle/StateBattleMixin")

if StateBattleMixin then
	MixinClass(ImmediateBattle, StateBattleMixin)
end

function ImmediateBattle:startBattle(battleNo, randomSeed, heros, monsterAtkEnhance, monsterMhpEnhance, speData, petEntity)
	self.battleNo = battleNo
	self.randomSeed = randomSeed
	self.heros = heros or {}
	self.monsterAtkEnhance = monsterAtkEnhance
	self.monsterMhpEnhance = monsterMhpEnhance
	self.speData = speData
	self.petEntity = petEntity or {}

	self:_initConfig()
end

function ImmediateBattle:initObjInfo()
	self.mEntityDict = {}

	local battleData = ResBattleConfig[self.battleNo] or {}
	local objId = 1

	for _, hero in ipairs(self.heros) do
		if ResHero[hero.heroID] then
			hero.entityID = objId
			self.mEntityDict[objId] = hero
			objId = objId + 1
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
				self.mEntityDict[objId].monsterAtkEnhance = self.monsterAtkEnhance
				self.mEntityDict[objId].monsterMhpEnhance = self.monsterMhpEnhance
				objId = objId + 1
			end
		end
	end
end

function ImmediateBattle:_initConfig()
	self:clear()
	self:initObjInfo(self.battleNo)

	local input = self:getMatrixInput()

	input.monsterAtkEnhance = self.monsterAtkEnhance
	input.monsterMhpEnhance = self.monsterMhpEnhance
	self.mMatrixInstance = TheMatrixClass(input, false)

	self:Run()
end

local MAX_FRAME = 36000

function ImmediateBattle:Run()
	for i = 1, MAX_FRAME do
		if self.mMatrixInstance.battleOver then
			break
		else
			self.mMatrixInstance:nextFrame()
		end
	end

	if self.mMatrixInstance.battleOver then
		if self.mMatrixInstance.battleOver == BattleConst.BATTLE_OVER_LOSE then
			-- block empty
		elseif self.mMatrixInstance.battleOver == BattleConst.BATTLE_RESULT_TIME_OUT then
			-- block empty
		end
	else
		return nil
	end
end

return ImmediateBattle
