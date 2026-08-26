-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeroGroupHeroItem.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeroGroupHeroItem", package.seeall)

local WeekWalk_2HeroGroupHeroItem = class("WeekWalk_2HeroGroupHeroItem", HeroGroupHeroItem)

function WeekWalk_2HeroGroupHeroItem:checkWeekWalkCd()
	if self._heroMO ~= nil and self.monsterCO == nil then
		local cd = WeekWalk_2Model.instance:getCurMapHeroCd(self._heroMO.config.id)

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

return WeekWalk_2HeroGroupHeroItem
