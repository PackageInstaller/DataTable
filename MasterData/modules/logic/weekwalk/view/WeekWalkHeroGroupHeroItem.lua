-- chunkname: @modules/logic/weekwalk/view/WeekWalkHeroGroupHeroItem.lua

module("modules.logic.weekwalk.view.WeekWalkHeroGroupHeroItem", package.seeall)

local WeekWalkHeroGroupHeroItem = class("WeekWalkHeroGroupHeroItem", HeroGroupHeroItem)

function WeekWalkHeroGroupHeroItem:checkWeekWalkCd()
	if HeroGroupModel.instance:isAdventureOrWeekWalk() and self._heroMO ~= nil and self.monsterCO == nil then
		local cd = WeekWalkModel.instance:getCurMapHeroCd(self._heroMO.config.id)

		if cd > 0 then
			self._playDeathAnim = true

			self:playAnim("herogroup_hero_deal")

			self.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self.setGrayFactor, nil, self)

			return self._heroMO.id
		else
			self._commonHeroCard:setGrayScale(false)
		end
	end
end

return WeekWalkHeroGroupHeroItem
