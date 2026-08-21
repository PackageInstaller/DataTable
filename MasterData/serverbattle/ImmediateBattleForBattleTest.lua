-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ServerBattle\\ImmediateBattleForBattleTest.lua

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
			hero.camp = BattleConst.CAMP_PLAYER
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

function ImmediateBattle:outputFrameState(frameId, logPath)
	local frame_state = "当前帧:" .. frameId .. "\n"

	for _, obj in pairs(self.mMatrixInstance.bObjMgr.objects) do
		local data_source = Lang.get(96463)

		if obj.camp == BattleConst.CAMP_MONSTER then
			data_source = Lang.get(96464)
		end

		if obj.hero and obj.hero.gid then
			local hp = math.max(0, math.min(10000, math.ceil(10000 * obj.hp / obj.mhp)))
			local hp_remain = obj.hp
			local hp_loss = obj.mhp - obj.hp
			local usingSkill, nowSkillLevel = obj:getSkillId()
			local stateData = ""

			for _, state in ipairs(obj.stateGroup.orderStates) do
				local _data = state.stateData

				if _data then
					local state_id = 0

					if _data.state_id then
						state_id = _data.state_id
					end

					stateData = stateData .. " state_id:" .. state_id
				end
			end

			local propsData = ""

			for propName, value in pairs(obj.stateGroup.props) do
				propsData = propsData .. " prop_name:" .. propName .. " prop_value:" .. value
			end

			frame_state = frame_state .. data_source .. " hero:" .. obj.hero.id .. " hp:" .. hp .. " hp_remain:" .. hp_remain .. " hp_loss:" .. hp_loss .. " skillId:" .. usingSkill .. " skillLvel:" .. nowSkillLevel .. " state:" .. stateData .. " props:" .. propsData .. "\n"
		end

		if obj.monsterID then
			local hp = math.max(0, math.min(10000, math.ceil(10000 * obj.hp / obj.mhp)))
			local hp_remain = obj.hp
			local hp_loss = obj.mhp - obj.hp
			local stateData = ""

			for _, state in ipairs(obj.stateGroup.orderStates) do
				local _data = state.stateData

				if _data then
					local state_id = 0

					if _data.state_id then
						state_id = _data.state_id
					end

					stateData = stateData .. " state_id:" .. state_id
				end
			end

			frame_state = frame_state .. data_source .. " monsterID" .. obj.monsterID .. " hp:" .. hp .. " hp_remain:" .. hp_remain .. " hp_loss:" .. hp_loss .. " state:" .. stateData .. "\n"
		end
	end

	local filename = logPath .. "\\frame_output_" .. tostring(self.randomSeed) .. "_" .. tostring(frameId) .. ".txt"
	local gFile = io.open(filename, "w")

	if gFile then
		gFile:write(frame_state)
		gFile:close()
	end
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
