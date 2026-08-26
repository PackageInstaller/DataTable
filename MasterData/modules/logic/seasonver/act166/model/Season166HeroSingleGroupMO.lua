-- chunkname: @modules/logic/seasonver/act166/model/Season166HeroSingleGroupMO.lua

module("modules.logic.seasonver.act166.model.Season166HeroSingleGroupMO", package.seeall)

local Season166HeroSingleGroupMO = pureTable("Season166HeroSingleGroupMO")

function Season166HeroSingleGroupMO:ctor()
	self.id = nil
	self.heroUid = nil
	self.aid = nil
	self.trial = nil
	self.trialTemplate = nil
	self.trialPos = nil
end

function Season166HeroSingleGroupMO:init(id, heroUid)
	self.id = id
	self.heroUid = heroUid or "0"
	self.trial = nil
	self.trialTemplate = nil
	self.trialPos = nil
end

function Season166HeroSingleGroupMO:setAid(aid)
	self.aid = aid
end

function Season166HeroSingleGroupMO:setTrial(trialId, templateId, pos, noCheckEquip)
	local curGroupMO = Season166HeroGroupModel.instance:getCurGroupMO()

	if self.trial and not noCheckEquip then
		local trialCO = self:getTrialCO()

		if trialCO.equipId > 0 then
			curGroupMO:updatePosEquips({
				index = self.id - 1
			})
		end
	end

	self.trial = trialId
	self.trialTemplate = templateId or 0
	self.trialPos = self.trialPos or pos

	if not trialId then
		self.trialPos = nil
	end

	if trialId and not noCheckEquip then
		local trialCO = self:getTrialCO()

		if trialCO.equipId > 0 then
			curGroupMO:updatePosEquips({
				index = self.id - 1
			})
		end
	end
end

function Season166HeroSingleGroupMO:getHeroMO()
	return self.heroUid and HeroModel.instance:getById(self.heroUid)
end

function Season166HeroSingleGroupMO:getHeroCO()
	local mo = self:getHeroMO()

	return mo and lua_character.configDict[mo.heroId]
end

function Season166HeroSingleGroupMO:getMonsterCO()
	return self.aid and lua_monster.configDict[self.aid]
end

function Season166HeroSingleGroupMO:getTrialCO()
	return self.trial and lua_hero_trial.configDict[self.trial][self.trialTemplate]
end

function Season166HeroSingleGroupMO:setEmpty()
	self.heroUid = "0"

	self:setTrial()
end

function Season166HeroSingleGroupMO:setHeroUid(heroUid)
	self.heroUid = heroUid
end

function Season166HeroSingleGroupMO:isEqual(heroUid)
	return not self:isEmpty() and self.heroUid == heroUid
end

function Season166HeroSingleGroupMO:isEmpty()
	if self.aid then
		return self.aid == -1
	else
		return not self.heroUid or self.heroUid == "0"
	end
end

function Season166HeroSingleGroupMO:canAddHero()
	if self.aid then
		return false
	else
		return not self.heroUid or self.heroUid == "0"
	end
end

function Season166HeroSingleGroupMO:isAidConflict(heroId)
	if not self.aid or self.aid == -1 then
		return false
	end

	local aidConfig = lua_monster.configDict[tonumber(self.aid)]
	local aidHeroId = aidConfig and tonumber(string.sub(tostring(aidConfig.skinId), 1, 4))

	if aidHeroId and aidHeroId == tonumber(heroId) then
		return true
	end

	return false
end

return Season166HeroSingleGroupMO
