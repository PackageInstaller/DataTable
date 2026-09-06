-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinechenclg/model/DivineChenClgExtremeFmtMo.lua

module("logic.extensions.divinechenclg.model.DivineChenClgExtremeFmtMo", package.seeall)

local DivineChenClgExtremeFmtMo = class("DivineChenClgExtremeFmtMo", BaseCustomFmtMo)

function DivineChenClgExtremeFmtMo:initParams(activityId, stageId, creepId)
	self.activityId = activityId
	self.stageId = stageId
	self.creepId = creepId
	self.creeps = DivineChenClgConfig.instance:getTeamCfg(self.creepId)
	self.masterCfg = DivineChenClgConfig.instance:getCreepCfgs(self.creepId)

	self:setFormCondition(self.creeps.formCondition)

	local info = DivineChenClgModel.instance:getExtremeInfoByActId(self.activityId)

	self._lockedRaceMap = {}

	if not info.passStages then
		for i, passInfo in ipairs(info.passStages) do
			for _, petId in ipairs(passInfo.lockedPetIds) do
				local mo = BagPetsController.instance:getPet(petId)

				if mo then
					self._lockedRaceMap[mo.raceId] = true
				end
			end
		end
	end
end

function DivineChenClgExtremeFmtMo:updateData()
	self:tryInitPetList()
end

function DivineChenClgExtremeFmtMo:getMonsterConfigList()
	return self.masterCfg
end

function DivineChenClgExtremeFmtMo:getFmtInfoConfig()
	return self.creeps
end

function DivineChenClgExtremeFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DivineChenClgController.instance:startExtremeClg(self.activityId, self.stageId, self:getCurSimpleForm())
	end, nil)
end

function DivineChenClgExtremeFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedRaceMap[petMo.raceId])
end

function DivineChenClgExtremeFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已封印")
end

return DivineChenClgExtremeFmtMo
