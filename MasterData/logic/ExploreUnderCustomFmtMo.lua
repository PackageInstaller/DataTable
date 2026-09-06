-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/model/ExploreUnderCustomFmtMo.lua

module("logic.extensions.exploreunder.model.ExploreUnderCustomFmtMo", package.seeall)

local ExploreUnderCustomFmtMo = class("ExploreUnderCustomFmtMo", ICustomFmtMo)

function ExploreUnderCustomFmtMo:initParams(difficultId, creespId)
	self._difficultId = difficultId
	self._masterList = ExploreUnderConfig.instance:getCreepsMasterCfgs(creespId)
	self._creepsCfg = ExploreUnderConfig.instance:getCreepsCfg(creespId)
	self.isHideFmtZdl = true
	self.topTitleStr = self._creepsCfg.name
	self.ruleDescStr = self._creepsCfg.WinDesc
end

function ExploreUnderCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(ViewName.ExploreUnderMainView, true)
		BattleFacade.instance:startExploreUnderFight(self._creepsCfg.creepsMasterId)
		ExploreUnderController.instance:dealEvent(ExploreUnderModel.EventAction.fight, {
			{
				value = tostring(self._difficultId),
				key = ExploreUnderModel.EventExtraParamKey.difficulty
			}
		})
	end

	self:setFightHandler(handler, nil)
end

function ExploreUnderCustomFmtMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function ExploreUnderCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function ExploreUnderCustomFmtMo:getMonsterConfigList()
	return self._masterList
end

function ExploreUnderCustomFmtMo:getFmtInfoConfig()
	return self._creepsCfg
end

function ExploreUnderCustomFmtMo:getCurFormation()
	return FormationModel.instance:getTeamFormation()
end

return ExploreUnderCustomFmtMo
