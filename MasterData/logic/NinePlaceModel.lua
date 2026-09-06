-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/model/NinePlaceModel.lua

module("logic.extensions.nineplace.model.NinePlaceModel", package.seeall)

local NinePlaceModel = class("NinePlaceModel", BaseModel)

NinePlaceModel.GetNinePlaceProcessInfoRes = "NinePlaceModel.GetNinePlaceProcessInfoRes"
NinePlaceModel.BattleEnd = "NinePlaceModel.BattleEnd"

function NinePlaceModel:ctor()
	self.config = NinePlaceConfig.instance
end

function NinePlaceModel:onInit()
	self:onReset()
end

function NinePlaceModel:onReset()
	self.nineplaceProcessInfo = {}
	self.formStrengthInfos = {}
end

function NinePlaceModel:setNinePlaceProcessInfo(infos)
	self.nineplaceProcessInfo = infos

	GlobalDispatcher:dispatch(NinePlaceModel.GetNinePlaceProcessInfoRes)
	RedPointModel.instance:updateAllRedPoint()
end

function NinePlaceModel:getNinePlaceProcessInfos()
	return self.nineplaceProcessInfo
end

function NinePlaceModel:getNinePlaceProcessInfo(stageId)
	if self.nineplaceProcessInfo then
		for i, v in ipairs(self.nineplaceProcessInfo) do
			if v.stageId == stageId then
				return v
			end
		end
	end
end

function NinePlaceModel:isStagePass(stageId)
	local info = self:getNinePlaceProcessInfo(stageId)
	local list = self.config:getMonstersCfgByStageId(stageId)

	return ((info or nil) and info.masterIdx) >= #list
end

function NinePlaceModel:isStageUnlock(stageId)
	local info = self:getNinePlaceProcessInfo(stageId)

	return info and info.masterIdx > 0
end

function NinePlaceModel:isStageCanChalenge(stageId)
	return self:checkStageCanChallenge(stageId)
end

function NinePlaceModel:isMonsterCanChallenge(stageId, creepsMasterId)
	local canChallenge = false

	if self.nineplaceProcessInfo then
		local masterIdx = self:creepsMasterId2Index(stageId, creepsMasterId)
		local list = self.config:getMonstersCfgByStageId(stageId)
		local len = #list

		for i, v in ipairs(self.nineplaceProcessInfo) do
			if v.stageId == stageId and v.masterIdx == masterIdx and len > v.masterIdx then
				canChallenge = true

				break
			end
		end
	end

	return canChallenge
end

function NinePlaceModel:setChallengeEnd(msg)
	if self.nineplaceProcessInfo and msg.isWin then
		for i, v in ipairs(self.nineplaceProcessInfo) do
			if v.stageId == msg.passedStageId then
				v.masterIdx = msg.passedMasterIdx + 1

				FormationNewModel.instance:initFormStrengthInfo(msg.passedStageId)

				break
			end
		end
	end

	GlobalDispatcher:dispatch(NinePlaceModel.BattleEnd)
end

function NinePlaceModel:createPet(creepsMasterId, creepsId)
	local spPetCo = self.config:getPetCfg(creepsMasterId, creepsId)

	if not spPetCo then
		return
	end

	local fPowerPet = FightingPowerPetMo.New()

	fPowerPet:fromChallengeCreepCo(spPetCo)

	return fPowerPet
end

function NinePlaceModel:getEnemyForm(creepsMasterId)
	local cfgs = self.config:getPetsCfg(creepsMasterId)
	local from = {}
	local pos2creepsId = {}

	for k, v in pairs(cfgs) do
		pos2creepsId[v.posId] = v.creepsId
	end

	for i = 1, 9 do
		from[i] = pos2creepsId[i] or 0
	end

	return from
end

function NinePlaceModel:creepsMasterId2Index(stageId, creepsMasterId)
	local index = 0
	local list = self.config:getMonstersCfgByStageId(stageId)

	for i, v in ipairs(list) do
		if creepsMasterId == v.creepsMasterId then
			index = i - 1

			break
		end
	end

	return index
end

function NinePlaceModel:checkBattleFuncRed()
	local red = false
	local open = FuncOpenModel.instance:getFuncIsOpen(97)

	if open then
		local cfgs = self.config:getStageCfgs()

		for i, v in ipairs(cfgs) do
			red = self:checkStageCanChallenge(v.stageId)

			if red then
				break
			end
		end
	end

	return red
end

function NinePlaceModel:checkCanUnlockRed()
	local canUnlock = false
	local cfgs = NinePlaceConfig.instance:getStageCfgs()

	for i, v in ipairs(cfgs) do
		if self:checkCanUnlockRedById(v.stageId) then
			canUnlock = true

			break
		end
	end

	return canUnlock
end

function NinePlaceModel:checkCanUnlockRedById(stageId)
	local canUnlock = false
	local info = self:getNinePlaceProcessInfo(stageId)

	if info and info.masterIdx <= 0 then
		local cfg = NinePlaceConfig.instance:getStageCfgById(stageId)

		if FuncOpenController.instance:getConditionReached(cfg.openCondition) then
			canUnlock = true
		end
	end

	return canUnlock
end

function NinePlaceModel:checkStageCanChallenge(stageId)
	local red = false
	local cfg = self.config:getStageCfgById(stageId)
	local open = FuncOpenController.instance:getConditionReached(cfg.openCondition)

	if open then
		local info = self:getNinePlaceProcessInfo(stageId)

		if info then
			local list = self.config:getMonstersCfgByStageId(stageId)

			for i, v in ipairs(list) do
				red = self:isMonsterCanChallenge(stageId, v.creepsMasterId)

				if red then
					break
				end
			end
		else
			red = true
		end
	end

	return red
end

function NinePlaceModel:checkMosterCanChallenge(stageId, creepsMasterId)
	local red = false
	local cfg = self.config:getMonsterCfg(stageId, creepsMasterId)
	local info = self:getNinePlaceProcessInfo(stageId)

	if info then
		local index = self:creepsMasterId2Index(stageId, creepsMasterId)

		if info.masterIdx == index then
			red = true
		end
	end

	return red
end

function NinePlaceModel:isStageCreepsPass(stageId, creepsMasterId)
	local pass = false

	creepsMasterId = checknumber(creepsMasterId)
	stageId = checknumber(stageId)

	local info = self:getNinePlaceProcessInfo(stageId)

	if info then
		local index = self:creepsMasterId2Index(stageId, creepsMasterId)

		if index < info.masterIdx then
			pass = true
		end
	end

	return pass
end

function NinePlaceModel:cilckNpcChallenge(stageId)
	local info = self:getNinePlaceProcessInfo(stageId)

	if info then
		local masterIdx = info.masterIdx
		local list = self.config:getMonstersCfgByStageId(stageId)
		local cfg = list[masterIdx + 1]

		if cfg then
			UIStateManager.instance:push(ViewName.NineplaceMissionView, stageId, cfg.creepsMasterId)
		end
	end
end

function NinePlaceModel:isSceneNpc(npcId)
	local cfgs = NinePlaceConfig.instance:getStageCfgs()

	for i, v in ipairs(cfgs) do
		if v.NpcId == npcId then
			return true
		end
	end
end

function NinePlaceModel:getStageIdByNpcId(npcId)
	local cfgs = NinePlaceConfig.instance:getStageCfgs()

	for i, v in ipairs(cfgs) do
		if v.NpcId == npcId then
			return v.stageId
		end
	end
end

NinePlaceModel.instance = NinePlaceModel.New()

return NinePlaceModel
