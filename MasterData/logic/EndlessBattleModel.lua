-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessbattle/model/EndlessBattleModel.lua

module("logic.extensions.endlessbattle.model.EndlessBattleModel", package.seeall)

local EndlessBattleModel = class("EndlessBattleModel")

function EndlessBattleModel:ctor()
	return
end

function EndlessBattleModel:onInit()
	self:onReset()
end

function EndlessBattleModel:onReset()
	self._maxStageId = 0
	self._dailyMaxStageId = 0
	self._buffId = 0
	self._simpleForm = nil
	self._defendCount = 0
	self._battleFlag = false
	self._info = nil
	self._dailyState = -1
	self._endFmtMo = FormationMO.New()
end

function EndlessBattleModel:setFormation(simpleForm)
	self._simpleForm = simpleForm

	self._endFmtMo:SetData(self._simpleForm)
end

function EndlessBattleModel:getFormation()
	return self._simpleForm
end

function EndlessBattleModel:getMaxWaveId()
	return self._maxWaveId
end

function EndlessBattleModel:getCurWaveId()
	local curCfg = EndlessBattleConfig.instance:getStageCfgById(self._maxStageId)
	local nextCfg = EndlessBattleConfig.instance:getStageCfgById(self._maxStageId + 1)

	if nextCfg then
		return nextCfg.waveId
	else
		return curCfg.waveId
	end
end

function EndlessBattleModel:setInfiniteFightInfo(msg)
	self._info = msg

	self:setMaxWaveId(msg.maxWave)
	self:setMaxStageId(msg.maxStage)
	self:setDailyMaxStage(msg.dailyMaxStage)
	self:setDailyState(msg.dailyState)
end

function EndlessBattleModel:setOneKeyFightInfo(msg)
	self:setDailyState(1)
	self:setMaxWaveId(msg.endWave)
	self:setMaxStageId(msg.endStage)
end

function EndlessBattleModel:setMaxWaveId(waveId)
	self._maxWaveId = waveId
end

function EndlessBattleModel:getMaxStageId()
	return self._maxStageId
end

function EndlessBattleModel:getDailyState()
	return self._dailyState
end

function EndlessBattleModel:setDailyState(value)
	self._dailyState = value
end

function EndlessBattleModel:setMaxStageId(stageId)
	self._maxStageId = stageId
end

function EndlessBattleModel:setDailyMaxStage(stageId)
	self._dailyMaxStageId = stageId
end

function EndlessBattleModel:getDailyMaxStage()
	return self._dailyMaxStageId
end

function EndlessBattleModel:setBuffId(buffId)
	self._buffId = buffId
end

function EndlessBattleModel:getBuffId()
	return self._buffId
end

function EndlessBattleModel:setBattleFlag(flag)
	self._battleFlag = flag
end

function EndlessBattleModel:getBattleFlag()
	return self._battleFlag
end

function EndlessBattleModel:pushBattleStartData(value)
	if self._battleStartData == nil then
		self._battleStartData = value
	end
end

function EndlessBattleModel:popBattleStartData()
	self._battleStartData = nil

	return self._battleStartData
end

function EndlessBattleModel:setNeedShowOneKey(value)
	self._needShowOneKey = value
end

function EndlessBattleModel:getNeedShowOneKey()
	self._needShowOneKey = nil

	return self._needShowOneKey
end

function EndlessBattleModel:getOriginalCurFormation()
	return self._endFmtMo
end

function EndlessBattleModel:_getCurFormation()
	return PetHireModel.instance:getFormationMoByFormId(PetHireModel.ID_TYPE_ENDLESS)
end

function EndlessBattleModel:getAllShowPetList()
	local pets = BagPetsController.instance:getFightBagPet() or {}

	pets = PetHireModel.instance:appendListByHirePets(pets)

	return pets
end

EndlessBattleModel.instance = EndlessBattleModel.New()

return EndlessBattleModel
