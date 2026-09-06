-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinesuperdragon/model/DivinesuperdragonFmtMo.lua

module("logic.extensions.divinesuperdragon.model.DivinesuperdragonFmtMo", package.seeall)

local DivinesuperdragonFmtMo = class("DivinesuperdragonFmtMo", ICustomFmtMo)

function DivinesuperdragonFmtMo:initParams(activityId, clgType, creepsMasterId)
	self._activityId = activityId
	self._clgType = clgType
	self.creepsMasterId = creepsMasterId
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self.masterCfg = DivinesuperdragonConfig.instance:getMasterCfgById(self.creepsMasterId)
	self.creeps = DivinesuperdragonConfig.instance:getCreepsCfgs(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
end

function DivinesuperdragonFmtMo:initFightHandler()
	self:setFightHandler(function()
		if self._isAoqiGodProcessType then
			local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.DivineSuperDragon, self._activityId)

			if result ~= GameEnum.ResultCode.Success then
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

				return
			end
		end

		local form = self:getCurFormation():createFormPb()

		if self._clgType == GameEnum.DivinesuperdragonClgType.BuffStage then
			local stageId = DivinesuperdragonConfig.instance:getBuffStageIdByCreepsMasterId(self._activityId, self.creepsMasterId)

			DivineSuperDragonClgAgent.instance:sendPM_DivineSuperDragonClgBuffStageFightReq(self._activityId, stageId, form)
		elseif self._clgType == GameEnum.DivinesuperdragonClgType.SuperStage then
			DivineSuperDragonClgAgent.instance:sendPM_DivineSuperDragonClgSuperStageFightReq(self._activityId, form)
		end
	end)
end

function DivinesuperdragonFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, mo in ipairs(pets) do
		self:addPetToList(mo)
	end
end

function DivinesuperdragonFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function DivinesuperdragonFmtMo:getMonsterConfigList()
	return self.creeps
end

function DivinesuperdragonFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

return DivinesuperdragonFmtMo
