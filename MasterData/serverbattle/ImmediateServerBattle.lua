-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ServerBattle\\ImmediateServerBattle.lua

local ResHero = require("ClientData/ResHero")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResMonster = require("ClientData/ResMonster")
local TheMatrixClass = require("Common/FrameBattle/TheMatrix")
local FrameMgr = require("Debug/Modules/Demo/ServerFrameMgr")
local PVPCommon = require("Logic/PVP/PVPCommon")
local BattleMiscConfig = require("Common/BattleMiscConfig")
local ImmediateServerBattle = {}
local StateBattleMixin = require("Logic/battle/StateBattleMixin")

if StateBattleMixin then
	MixinClass(ImmediateServerBattle, StateBattleMixin)
end

function ImmediateServerBattle:startServerBattle(start_data, client_operate)
	if utils.isRobot(start_data.spec.mpvp.robot) then
		local formations = PVPCommon.getMultiPvpReplayRobotFormation(start_data.spec.mpvp.robot)

		for i, formation in ipairs(formations) do
			table.insert(start_data.start_common.formation, formation)
		end
	end

	local battleInitInfo = utils.getBattleInitInfo(start_data)

	self.battleNo = battleInitInfo.battleNo
	self.randomSeed = battleInitInfo.seed
	self.battleType = battleInitInfo.battleType
	self.speData = battleInitInfo.speData

	if BattleConst.THREE_ROUND_BATTLE_TYPE[self.battleType] then
		self.battleTeamResult = {}
		self.battleTeamHeros = battleInitInfo.multiTeamHeros
		self.multiTeamPets = battleInitInfo.multiTeamPets

		for round = 1, 3 do
			self.heros = self.battleTeamHeros[round]
			self.petEntity = self.multiTeamPets[round]

			self:_initConfig()

			for _, frameInfo in ipairs(client_operate[round].framedata) do
				local frameNum = frameInfo.frameid

				self.frameMgr:onReceiveMsg(frameInfo.optype, frameInfo.data, frameNum)
			end

			local result = self:Run()

			table.insert(self.battleTeamResult, result)

			local winNum = 0
			local loseNum = 0

			for roundNum, result in pairs(self.battleTeamResult) do
				if result == 0 then
					winNum = winNum + 1
				else
					loseNum = loseNum + 1
				end
			end

			if winNum >= 2 then
				return 0
			elseif loseNum >= 2 then
				return 1
			end
		end
	else
		self.heros = battleInitInfo.heros
		self.petEntity = battleInitInfo.pets

		self:_initConfig()

		for _, frameInfo in ipairs(client_operate[1].framedata) do
			local frameNum = frameInfo.frameid

			self.frameMgr:onReceiveMsg(frameInfo.optype, frameInfo.data, frameNum)
		end

		return self:Run()
	end
end

function ImmediateServerBattle:startServerBattleByResult(start_data, client_operate)
	if utils.isRobot(start_data.spec.mpvp.robot) then
		local formations = PVPCommon.getMultiPvpReplayRobotFormation(start_data.spec.mpvp.robot)

		for i, formation in ipairs(formations) do
			table.insert(start_data.start_common.formation, formation)
		end
	end

	local battleInitInfo = utils.getBattleInitInfo(start_data)

	self.battleNo = battleInitInfo.battleNo
	self.randomSeed = battleInitInfo.seed
	self.battleType = battleInitInfo.battleType
	self.speData = battleInitInfo.speData

	if BattleConst.THREE_ROUND_BATTLE_TYPE[self.battleType] then
		self.battleTeamResult = {}
		self.battleTeamDetailResult = {}
		self.battleTeamHeros = battleInitInfo.multiTeamHeros
		self.multiTeamPets = battleInitInfo.multiTeamPets

		for round = 1, 3 do
			self.heros = self.battleTeamHeros[round]
			self.petEntity = self.multiTeamPets[round]

			self:_initConfig()

			if client_operate and client_operate[round] and client_operate[round].framedata then
				for _, frameInfo in ipairs(client_operate[round].framedata) do
					local frameNum = frameInfo.frameid

					self.frameMgr:onReceiveMsg(frameInfo.optype, frameInfo.data, frameNum)
				end
			end

			local result, detailInfo = self:Run()

			table.insert(self.battleTeamResult, result)
			table.insert(self.battleTeamDetailResult, detailInfo)

			local winNum = 0
			local loseNum = 0

			for roundNum, result in pairs(self.battleTeamResult) do
				if result == 0 then
					winNum = winNum + 1
				else
					loseNum = loseNum + 1
				end
			end

			if winNum >= 2 then
				return self:getBattleResult(0, self.battleTeamResult, self.battleTeamDetailResult)
			elseif loseNum >= 2 then
				return self:getBattleResult(1, self.battleTeamResult, self.battleTeamDetailResult)
			end
		end
	else
		self.heros = battleInitInfo.heros
		self.petEntity = battleInitInfo.pets

		self:_initConfig()

		if client_operate and client_operate[1] and client_operate[1].framedata then
			for _, frameInfo in ipairs(client_operate[1].framedata) do
				local frameNum = frameInfo.frameid

				self.frameMgr:onReceiveMsg(frameInfo.optype, frameInfo.data, frameNum)
			end
		end

		local result, detailInfo = self:Run()

		return self:getBattleResult(result)
	end
end

function ImmediateServerBattle:getBattleResult(lose, battleTeamResult, battleTeamDetailResult)
	local result = {}

	result.win = 0
	result.battle_version = BattleMiscConfig.BATTLE_MODIFY_VERSION

	if self.mMatrixInstance then
		if lose == 0 then
			result.win = 1
		end

		result.frame = self.mMatrixInstance.battleRealPassedFrame
		result.battle_time = self.mMatrixInstance.bObjMgr:getBattleTime()
		result.damage = math.floor(self.mMatrixInstance.bObjMgr:getBattleDamage())
		result.monster_losehp = math.floor(self.mMatrixInstance.bObjMgr:getMonsterLoseHp())

		local campData = {}

		campData.team = self.mMatrixInstance.bObjMgr:getDamageResultInfo()
		result.camp_data = campData

		local bitNum = 0
		local base = 1
		local okNum, states = self.mMatrixInstance.bObjMgr:getBattleTargetState()

		for index, state in ipairs(states) do
			if state[1] then
				bitNum = bitNum + base
			end

			base = base * 2
		end

		result.cond_bit = bitNum
		result.suppres = self.mMatrixInstance.bObjMgr.suppressLevel

		if battleTeamResult then
			bitNum = 0
			base = 1

			for roundNum, winResult in ipairs(battleTeamResult or {}) do
				if winResult == 0 then
					bitNum = bitNum + base
				end

				base = base * 2
			end

			result.round_bit = bitNum
			result.round_cnt = #battleTeamResult

			local round_time = {}

			for _, detailInfo in ipairs(battleTeamDetailResult) do
				table.insert(round_time, {
					time = detailInfo.round_time
				})
			end

			result.round_time = round_time
		end
	end

	local buff = protobuf.encode("datap.ReplayResult", result)

	return buff
end

function ImmediateServerBattle:_initConfig()
	self:clear()
	self:initObjInfo()

	local input = self:getMatrixInput()

	self.mMatrixInstance = TheMatrixClass(input, false)
	self.frameMgr = FrameMgr(self.mMatrixInstance)
end

local MAX_FRAME = 36000

function ImmediateServerBattle:Run()
	for i = 1, MAX_FRAME do
		if self.mMatrixInstance.battleOver then
			break
		else
			self.frameMgr:nextFrame()
		end
	end

	local detailInfo = {}

	detailInfo.round_time = self.mMatrixInstance.curFrame

	if self.mMatrixInstance.battleOver == BattleConst.BATTLE_OVER_WIN then
		return 0, detailInfo
	else
		return 1, detailInfo
	end
end

return ImmediateServerBattle
