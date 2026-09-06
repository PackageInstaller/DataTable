-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruichallenge/model/FanRuiDestinyCustomFmtMo.lua

module("logic.extensions.fanruichallenge.model.FanRuiDestinyCustomFmtMo", package.seeall)

local FanRuiDestinyCustomFmtMo = class("FanRuiDestinyCustomFmtMo", ICustomFmtMo)

function FanRuiDestinyCustomFmtMo:initParams(activityId, stageId, choiceIds)
	self._activityId = activityId
	self._stageId = stageId
	self._choiceIds = choiceIds

	local cfgStage = FanRuiChallengeConfig.instance:getDestinyClgStageCfg(activityId, stageId)

	self._monsterCfg = FanRuiChallengeConfig.instance:getMonsterCfg(cfgStage.creepsMasterId)
	self._creepsCfgs = FanRuiChallengeConfig.instance:getCreepsCfgs(cfgStage.creepsMasterId)
end

function FanRuiDestinyCustomFmtMo:updateData()
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.WinDesc

	self:setFormCondition(self._monsterCfg.formCondition)
end

function FanRuiDestinyCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

function FanRuiDestinyCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function FanRuiDestinyCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local form = self:getCurSimpleForm()
		local projectedReq = {}

		for i = 1, 3 do
			local item = {}

			item.type = i
			item.choice = Mathf.Clamp(checknumber(self._choiceIds[i]), 1, 3)

			table.insert(projectedReq, item)
		end

		FanRuiChallengeAgent.instance:sendPM_FanRuiClgFightThemeDestinyReq(self._activityId, form, projectedReq)
	end

	self:setFightHandler(handler, nil)
end

function FanRuiDestinyCustomFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function FanRuiDestinyCustomFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

function FanRuiDestinyCustomFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

return FanRuiDestinyCustomFmtMo
