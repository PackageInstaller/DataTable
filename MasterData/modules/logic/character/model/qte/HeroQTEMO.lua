-- chunkname: @modules/logic/character/model/qte/HeroQTEMO.lua

module("modules.logic.character.model.qte.HeroQTEMO", package.seeall)

local HeroQTEMO = class("HeroQTEMO")

function HeroQTEMO:setHero(heroId, heroMo)
	self._heroId = heroId
	self._heroMo = heroMo and heroMo or HeroModel.instance:getByHeroId(heroId)
end

function HeroQTEMO:onRefresh(qteGroupId)
	self._qteGroupId = qteGroupId
	self._qteSkillGroupCo = lua_fight_qte_skillgroup.configDict[qteGroupId]

	self:_refreshSkillEffect()
	self:_refreshCost()
end

function HeroQTEMO:getQteGroupId()
	return self._qteGroupId
end

function HeroQTEMO:_refreshSkillEffect()
	if not self._qteSkillGroupCo then
		return
	end

	self._activeSkillEffectCo = self:_getSkillEffectCo(self._qteSkillGroupCo.activeId)
	self._passiveSkillEffectCos = {}

	for i = 1, 2 do
		self._passiveSkillEffectCos[i] = self:_getSkillEffectCo(self._qteSkillGroupCo["passiveId" .. i])
	end

	self._endSkillEffectCo = self:_getSkillEffectCo(self._qteSkillGroupCo.endId)
end

function HeroQTEMO:_getSkillEffectCo(skillId)
	if not skillId or skillId <= 0 then
		return
	end

	local skillCo = lua_skill.configDict[skillId]

	if not skillCo then
		logError("HeroQTEMO:_getSkillEffectCo  not find skillCo:" .. skillId)

		return
	end

	local skillEffectCO = lua_skill_effect.configDict[skillCo.skillEffect]

	if not skillEffectCO then
		logError("HeroQTEMO:_getSkillEffectCo  not find skillEffectCO:" .. skillCo.skillEffect)

		return
	end

	return skillEffectCO
end

function HeroQTEMO:_refreshCost()
	self._costNums = {}

	self:_refreshSkillEffectCost(self._activeSkillEffectCo)
	self:_refreshSkillEffectCost(self._endSkillEffectCo)

	for _, co in pairs(self._passiveSkillEffectCos) do
		self:_refreshSkillEffectCost(co)
	end
end

function HeroQTEMO:_refreshSkillEffectCost(co)
	if co and not string.nilorempty(co.qtePowerCost) then
		local param = string.splitToNumber(co.qtePowerCost, "#")
		local type = param[1]
		local num = param[2]

		self._costNums[type] = self._costNums[type] or 0
		self._costNums[type] = self._costNums[type] + num
	end
end

function HeroQTEMO:getTotalCostNum()
	return self._costNums
end

function HeroQTEMO:getActiveId()
	if not self._qteSkillGroupCo then
		return
	end

	return self._qteSkillGroupCo.activeId
end

return HeroQTEMO
