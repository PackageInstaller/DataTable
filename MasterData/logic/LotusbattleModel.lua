-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/model/LotusbattleModel.lua

module("logic.extensions.lotusbattle.view.LotusbattleModel", package.seeall)

local LotusbattleModel = class("LotusbattleModel", BaseModel)

function LotusbattleModel:ctor()
	return
end

function LotusbattleModel:onInit()
	self._cachePetMos = {}

	self:onReset()
end

function LotusbattleModel:onReset()
	self:resetData()
end

function LotusbattleModel:resetData()
	self._baseInfo = nil
	self._matchPlayerInfo = nil

	if self._customMo then
		self._customMo:clearAllPetList()
	end

	self._currBagPets = {}
	self._modelId = 0
	self._battlefield = {}
	self._prepareViewInfo = nil
	self._battlerecord = {}
	self._packageCreepIds = {}
	self._roundId = 0
	self._opform = nil
	self._myform = nil
	self._nextForceTime = 0
	self._bagBuffIds = {}
	self._battleFieldHeadInfos = nil
	self._currKillNum = 0
	self._isLeaveGame = false
end

function LotusbattleModel:clearDataOnMatch()
	self._matchPlayerInfo = nil

	if self._customMo then
		self._customMo:clearAllPetList()
	end

	self._currBagPets = {}
	self._battlefield = {}
	self._prepareViewInfo = nil
	self._battlerecord = {}
	self._packageCreepIds = {}
	self._roundId = 0
	self._opform = nil
	self._myform = nil
	self._nextForceTime = 0
	self._bagBuffIds = {}
	self._battleFieldHeadInfos = nil
	self._currKillNum = 0
	self._isLeaveGame = false
end

function LotusbattleModel:setBaseInfo(msg)
	self._baseInfo = msg

	self:updateNangCreepIds(self._baseInfo.packageCreepIds)
end

function LotusbattleModel:getTodayChallengeTimes(modelId)
	if self._baseInfo then
		for i, v in ipairs(self._baseInfo.modelInfo) do
			if v.model == modelId then
				return v.times
			end
		end
	end

	return 0
end

function LotusbattleModel:getActivityId()
	if self._baseInfo then
		return self._baseInfo.activityId
	end

	return 0
end

function LotusbattleModel:getModelId()
	return self._modelId
end

function LotusbattleModel:setModelId(id)
	self._modelId = id
end

function LotusbattleModel:getPackageCreepIds()
	return self._packageCreepIds
end

function LotusbattleModel:getPackagePets()
	if self._baseInfo then
		return self._baseInfo.package
	end

	return {}
end

function LotusbattleModel:setMatchPlayerInfo(msg)
	self._matchPlayerInfo = msg
end

function LotusbattleModel:getMatchPlayerInfo()
	return self._matchPlayerInfo
end

function LotusbattleModel:getCustomMo()
	self._customMo = self._customMo or LotusbattleFmtMo.New()

	return self._customMo
end

function LotusbattleModel:getBagPets()
	local petMos = {}

	for k, v in pairs(self._currBagPets) do
		table.insert(petMos, v)
	end

	return petMos
end

function LotusbattleModel:_getPackageSize()
	if self._baseInfo then
		return self._baseInfo.packageSize
	end

	return 0
end

function LotusbattleModel:getNangSlotDatas()
	local creepIds = self:getPackageCreepIds()
	local unlockNum = self:_getPackageSize()
	local list = {}

	for i = 1, 3 do
		local data = {
			creepId = 0,
			status = LotusbattlemainView.NangLockStatus.Lock
		}
		local unlock = i <= unlockNum

		if unlock then
			if creepIds[i] then
				data.status = LotusbattlemainView.NangLockStatus.Pet
				data.creepId = creepIds[i]
			else
				data.status = LotusbattlemainView.NangLockStatus.Empty
			end
		else
			data.status = LotusbattlemainView.NangLockStatus.Lock
		end

		table.insert(list, data)
	end

	return list
end

function LotusbattleModel:updateNangCreepIds(creepIds)
	self._packageCreepIds = GameUtil.pbToTable(creepIds) or {}
end

function LotusbattleModel:setPrepareBattlefield(battlefield, headInfos)
	self._battlefield = GameUtil.pbToTable(battlefield) or {}
	self._battleFieldHeadInfos = headInfos or self._battleFieldHeadInfos
end

function LotusbattleModel:getPrepareBattlefield()
	return self._battlefield
end

function LotusbattleModel:getPrepareBattleFieldHeadInfos()
	return self._battleFieldHeadInfos
end

function LotusbattleModel:setPrepareBaseInfo(msg)
	self._prepareViewInfo = msg
end

function LotusbattleModel:getPrepareBaseInfo()
	return self._prepareViewInfo
end

function LotusbattleModel:setRecordInfo(battlerecord)
	self._battlerecord = battlerecord
end

function LotusbattleModel:getRecordInfo()
	return self._battlerecord
end

function LotusbattleModel:inserPets(creepIds)
	for i, creepId in ipairs(creepIds) do
		if creepId > 0 and not self._currBagPets[creepId] then
			petMo = self:getPetMoByCreepsId(creepId)
			self._currBagPets[creepId] = petMo
		end
	end
end

function LotusbattleModel:insertBuff(buffId)
	if buffId and buffId > 0 then
		self._bagBuffIds[buffId] = buffId
	end
end

function LotusbattleModel:getBagBuffIds()
	return self._bagBuffIds
end

function LotusbattleModel:setResultViewDatas(battleMsg)
	self._resultViewDatas = battleMsg
end

function LotusbattleModel:getResultViewDatas()
	return self._resultViewDatas
end

function LotusbattleModel:getResultMyBuffId()
	return self._resultViewDatas.myBuffId
end

function LotusbattleModel:getResultOpBuffId()
	return self._resultViewDatas.opBuffId
end

function LotusbattleModel:getResultOpCreepIds()
	return self._resultViewDatas.opCreepIds
end

function LotusbattleModel:setNextForceTime(nextForceTime)
	self._nextForceTime = math.ceil(checknumber(nextForceTime) / 1000)
end

function LotusbattleModel:getNextForceTime()
	return self._nextForceTime
end

function LotusbattleModel:getKillNum()
	return self._currKillNum
end

function LotusbattleModel:setWinBattleNum(winStreak)
	self._currKillNum = checknumber(winStreak)
end

function LotusbattleModel:setEndGameMsg(msg)
	self._endGameMsg = msg
end

function LotusbattleModel:getTopWinCreepsIds()
	return self._endGameMsg.creepIds
end

function LotusbattleModel:getTopWinPackageCreepsIds()
	return self._endGameMsg.packageCreepsIds
end

function LotusbattleModel:getTopWinBuffIds()
	return self._endGameMsg.buffIds
end

function LotusbattleModel:getTopWinModelId()
	return self._endGameMsg.modelId
end

function LotusbattleModel:getTopWinRank()
	return self._endGameMsg.rank
end

function LotusbattleModel:getTopWinKillNum()
	return self._endGameMsg.killNum
end

function LotusbattleModel:getTopWinScore()
	return self._endGameMsg.score
end

function LotusbattleModel:getOpFormExtParams()
	local form = self:getOpSimpleform()

	if form then
		return form.extParams
	end

	return {}
end

function LotusbattleModel:getOpSimpleform()
	if self._opform then
		return self._opform.curForm
	end
end

function LotusbattleModel:setNextSetFormationData(msg)
	local myForm = msg.myForm
	local opForm = msg.opForm

	self._roundId = msg.roundId

	self:setMyForm(myForm)
	self:setOpForm(opForm)
end

function LotusbattleModel:setOpForm(opForm)
	self._opform = opForm
end

function LotusbattleModel:setMyForm(myForm)
	self._myform = myForm
end

function LotusbattleModel:getMySimpleform()
	if self._myform then
		return self._myform.curForm
	end
end

function LotusbattleModel:getLastFormInTeamPetNum()
	local num = 0

	if self._myform then
		for i, v in ipairs(self._myform.curForm.pos) do
			if v > 0 then
				num = num + 1
			end
		end
	end

	return num
end

function LotusbattleModel:unlockPackage()
	if self._baseInfo then
		self._baseInfo.packageSize = self._baseInfo.packageSize + 1
	end
end

function LotusbattleModel:getPetMoByCreepsId(creepsId)
	local petMo = self._cachePetMos[creepsId]

	if petMo then
		return petMo
	end

	local cfg = LotusbattleConfig.instance:getCreepsCfg(creepsId)

	if not cfg then
		printError("creepsId没配置:", creepsId)
	end

	local temp = FightingPowerPetMo.New()

	temp:fromChallengeCreepCo(cfg)

	petMo = temp:toBaseBagPetMo()
	self._cachePetMos[creepsId] = petMo

	return petMo
end

function LotusbattleModel:setLeaveGame()
	self._isLeaveGame = true
end

function LotusbattleModel:isLeaveGame()
	return self._isLeaveGame
end

LotusbattleModel.instance = LotusbattleModel.New()

return LotusbattleModel
