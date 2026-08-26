-- chunkname: @modules/logic/herogroup/model/HeroSingleGroupMO.lua

module("modules.logic.herogroup.model.HeroSingleGroupMO", package.seeall)

local HeroSingleGroupMO = pureTable("HeroSingleGroupMO")

function HeroSingleGroupMO:ctor()
	self.id = nil
	self.heroUid = nil
	self.aid = nil
	self.trial = nil
	self.trialTemplate = nil
	self.trialPos = nil
	self.assistMo = nil
end

function HeroSingleGroupMO:init(id, heroUid)
	self.id = id
	self.heroUid = heroUid or "0"
	self.trial = nil
	self.trialTemplate = nil
	self.trialPos = nil
	self.assistMo = nil
end

function HeroSingleGroupMO:setAid(aid)
	self.aid = aid
end

function HeroSingleGroupMO:setTrial(trialId, templateId, pos, noCheckEquip)
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

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

function HeroSingleGroupMO:setAssist(assistMo)
	self.assistMo = assistMo
end

function HeroSingleGroupMO:swapAssist(assistMo, index)
	self.assistMo = assistMo
	self.id = index
end

function HeroSingleGroupMO:getHeroMO()
	if self.assistMo then
		return self.assistMo.heroMO
	end

	local _, assistMo = HeroGroupModel.instance:getAssistMo()

	if self.heroUid then
		local heroMo = HeroModel.instance:getById(self.heroUid)

		if assistMo and self.heroUid and assistMo.assistMo.heroId == self.heroUid.heroId then
			return
		end

		return self.heroUid
	end
end

function HeroSingleGroupMO:getHeroCO()
	local mo = self:getHeroMO()

	return mo and lua_character.configDict[mo.heroId]
end

function HeroSingleGroupMO:getMonsterCO()
	return self.aid and lua_monster.configDict[self.aid]
end

function HeroSingleGroupMO:getTrialCO()
	return self.trial and lua_hero_trial.configDict[self.trial][self.trialTemplate]
end

function HeroSingleGroupMO:getAssist()
	return self.assistMo
end

function HeroSingleGroupMO:setEmpty()
	self.heroUid = "0"

	self:setTrial()
end

function HeroSingleGroupMO:setHeroUid(heroUid)
	self.heroUid = heroUid
end

function HeroSingleGroupMO:isEqual(heroUid)
	return not self:isEmpty() and self.heroUid == heroUid
end

function HeroSingleGroupMO:isEmpty()
	if self.aid then
		return self.aid == -1
	else
		return not self.heroUid or self.heroUid == "0"
	end
end

function HeroSingleGroupMO:canAddHero()
	if self.aid then
		return false
	else
		return not self.heroUid or self.heroUid == "0"
	end
end

function HeroSingleGroupMO:isAidConflict(heroId)
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

return HeroSingleGroupMO
