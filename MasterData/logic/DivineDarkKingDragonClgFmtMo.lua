-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/model/DivineDarkKingDragonClgFmtMo.lua

module("logic.extensions.divinedarkkingdragonclg.model.DivineDarkKingDragonClgFmtMo", package.seeall)

local DivineDarkKingDragonClgFmtMo = class("DivineDarkKingDragonClgFmtMo", BaseCustomFmtMo)

function DivineDarkKingDragonClgFmtMo:initParams(activityId, phaseId, stageId)
	self.activityId = activityId
	self.phaseId = phaseId
	self.stageId = stageId
	self.stageCfg = DivineDarkKingDragonClgConfig.instance:getStageCfgByStageId(self.activityId, self.phaseId, self.stageId)

	local creepsMasterId = self.stageCfg.creepsMasterId

	self._masterData = DivineDarkKingDragonClgConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = DivineDarkKingDragonClgConfig.instance:getCreepCfgs(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:clearAllPetList()

	self._lockedPetMap = {}

	local infoMap = DivineDarkKingDragonClgModel.instance:getPhaseInfoMap(self.activityId) or {}

	for _, phaseInfo in pairs(infoMap) do
		if not phaseInfo.lockRaceIds then
			for i, raceId in ipairs(phaseInfo.lockRaceIds) do
				self._lockedPetMap[checknumber(raceId)] = true
			end
		end
	end
end

function DivineDarkKingDragonClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineDarkKingDragonClgController.instance:startChallenge(self.activityId, self.phaseId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineDarkKingDragonClgFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function DivineDarkKingDragonClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineDarkKingDragonClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineDarkKingDragonClgFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedPetMap[petMo.raceId])
end

function DivineDarkKingDragonClgFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已被锁定")
end

return DivineDarkKingDragonClgFmtMo
