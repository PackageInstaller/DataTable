-- chunkname: @modules/logic/abyss/view/AbyssHeroGroupHeroItem.lua

module("modules.logic.abyss.view.AbyssHeroGroupHeroItem", package.seeall)

local AbyssHeroGroupHeroItem = class("AbyssHeroGroupHeroItem", HeroGroupHeroItem)

function AbyssHeroGroupHeroItem:checkAbyss()
	if HeroGroupModel.instance.heroGroupType ~= ModuleEnum.HeroGroupType.General then
		return
	end

	if self._heroMO ~= nil and self.monsterCO == nil then
		if AbyssModel.instance:isCurHeroLocked(self._heroMO.config.id) then
			self._playDeathAnim = true

			self:playAnim("herogroup_hero_deal")

			self.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self.setGrayFactor, nil, self)

			return self._heroMO.id
		else
			self._commonHeroCard:setGrayScale(false)
		end
	end
end

function AbyssHeroGroupHeroItem:checkUsed()
	local curStageMo = AbyssModel.instance:getCurStageMo()
	local haveChallenge = curStageMo:isChallenged()

	if haveChallenge then
		return
	end

	local actInfoMo = AbyssModel.instance:getCurInfoMo()

	if actInfoMo:isHeroUsed(self._heroMO.config.id, curStageMo.lastUpdateTime) then
		return self._heroMO.id
	end
end

return AbyssHeroGroupHeroItem
