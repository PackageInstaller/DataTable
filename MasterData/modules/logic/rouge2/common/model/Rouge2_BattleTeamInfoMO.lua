-- chunkname: @modules/logic/rouge2/common/model/Rouge2_BattleTeamInfoMO.lua

module("modules.logic.rouge2.common.model.Rouge2_BattleTeamInfoMO", package.seeall)

local Rouge2_BattleTeamInfoMO = pureTable("Rouge2_BattleTeamInfoMO")

function Rouge2_BattleTeamInfoMO:init(info)
	self.pos = info.pos
	self.heroUid = info.heroUid
	self.equipUidList = info.equipUid
	self.trialId = info.trialId
	self.trialEquipUid = info.trialEquipUid
	self.trialTemplateId = 0
end

function Rouge2_BattleTeamInfoMO:getHeroUid()
	if self.heroUid and self.heroUid ~= "0" then
		return self.heroUid
	elseif self.trialId and self.trialId ~= 0 then
		return (HeroGroupHandler.getTrialHeroUID(self.trialId, self.trialTemplateId))
	end
end

function Rouge2_BattleTeamInfoMO:getHeroId()
	if self.heroUid and self.heroUid ~= "0" then
		local heroMo = HeroModel.instance:getById(self.heroUid)

		return heroMo and heroMo.heroId
	elseif self.trialId and self.trialId ~= 0 then
		local trialCo = lua_hero_trial.configDict[self.trialId][self.trialTemplateId]

		return trialCo and trialCo.heroId
	end
end

function Rouge2_BattleTeamInfoMO:isTrial()
	return self.trialId and self.trialId ~= 0
end

function Rouge2_BattleTeamInfoMO:getTrialId()
	return self.trialId
end

function Rouge2_BattleTeamInfoMO:getTrialCo()
	return lua_hero_trial.configDict[self.trialId][self.trialTemplateId]
end

function Rouge2_BattleTeamInfoMO:getEquipUidList()
	return self.equipUidList
end

function Rouge2_BattleTeamInfoMO:getTrialIdStr()
	return string.format("%s#%s", self.trialId, self.trialTemplateId)
end

return Rouge2_BattleTeamInfoMO
