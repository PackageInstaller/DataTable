-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ServerBattle\\ImmediateBattleForAI.lua

local ResHero = require("ClientData/ResHero")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResMonster = require("ClientData/ResMonster")
local TheMatrixClass = require("Common/FrameBattle/TheMatrix")
local ImmediateBattleForAI = {}
local StateBattleMixin = require("Logic/battle/StateBattleMixin")

if StateBattleMixin then
	MixinClass(ImmediateBattleForAI, StateBattleMixin)
end

function ImmediateBattleForAI:startBattle(battleNo, randomSeed, heros, monsterAtkEnhance, monsterMhpEnhance, speData, petEntity, manualOpera, enemy_heros)
	self.battleNo = battleNo
	self.randomSeed = randomSeed
	self.enemy_heros = enemy_heros or {}
	self.monsterAtkEnhance = monsterAtkEnhance
	self.monsterMhpEnhance = monsterMhpEnhance
	self.heros = heros or {}
	self.speData = speData
	self.petEntity = petEntity or {}

	self:_initConfig(manualOpera)
end

function ImmediateBattleForAI:initObjInfo()
	self.mEntityDict = {}

	local battleData = ResBattleConfig[self.battleNo] or {}

	if battleData.monster_rate then
		self.monsterAtkEnhance = 1 + (battleData.monster_rate or 0) / 10000
	end

	if battleData.monster_mhp_rate then
		self.monsterMhpEnhance = 1 + (battleData.monster_mhp_rate or 0) / 10000
	end

	local objId = 1

	for _, hero in ipairs(self.heros) do
		if ResHero[hero.heroID] then
			hero.entityID = objId
			self.mEntityDict[objId] = hero
			objId = objId + 1
		end
	end

	for _, hero in ipairs(self.enemy_heros) do
		if ResHero[hero.heroID] then
			hero.entityID = objId
			self.mEntityDict[objId] = hero
			objId = objId + 1
		end
	end

	if self.battleType ~= BattleConst.BATTLE_TYPE_ASYNC_PVP and self.battleNo then
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

function ImmediateBattleForAI:_initConfig(manualOpera)
	self:clear()
	self:initObjInfo(self.battleNo)

	local input = self:getMatrixInput()

	input.monsterAtkEnhance = self.monsterAtkEnhance
	input.monsterMhpEnhance = self.monsterMhpEnhance
	input.manualOpera = manualOpera
	self.mMatrixInstance = TheMatrixClass(input, false)
end

return ImmediateBattleForAI
