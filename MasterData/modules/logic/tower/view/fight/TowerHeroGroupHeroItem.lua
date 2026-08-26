-- chunkname: @modules/logic/tower/view/fight/TowerHeroGroupHeroItem.lua

module("modules.logic.tower.view.fight.TowerHeroGroupHeroItem", package.seeall)

local TowerHeroGroupHeroItem = class("TowerHeroGroupHeroItem", HeroGroupHeroItem)

function TowerHeroGroupHeroItem:checkTower()
	if HeroGroupModel.instance.heroGroupType ~= ModuleEnum.HeroGroupType.General then
		return
	end

	if self._heroMO ~= nil and self.monsterCO == nil then
		if TowerModel.instance:isHeroLocked(self._heroMO.config.id) then
			self._commonHeroCard:setGrayScale(false)
		elseif TowerModel.instance:isHeroBan(self._heroMO.config.id) then
			self._playDeathAnim = true

			self:playAnim("herogroup_hero_deal")

			self.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self.setGrayFactor, nil, self)

			return self._heroMO.id
		else
			self._commonHeroCard:setGrayScale(false)
		end
	elseif self.trialCO ~= nil then
		if TowerModel.instance:isHeroLocked(self.trialCO.heroId) then
			self._commonHeroCard:setGrayScale(false)
		elseif TowerModel.instance:isHeroBan(self.trialCO.heroId) then
			self._playDeathAnim = true

			self:playAnim("herogroup_hero_deal")

			self.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self.setGrayFactor, nil, self)

			return tostring(tonumber(self.trialCO.id .. "." .. self.trialCO.trialTemplate) - 1099511627776)
		else
			self._commonHeroCard:setGrayScale(false)
		end
	end
end

return TowerHeroGroupHeroItem
