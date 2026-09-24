-- chunkname: @modules/logic/towercompose/view/result/TowerComposeResultHeroGroupHeroItem.lua

module("modules.logic.towercompose.view.result.TowerComposeResultHeroGroupHeroItem", package.seeall)

local TowerComposeResultHeroGroupHeroItem = class("TowerComposeResultHeroGroupHeroItem", HeroGroupHeroItem)

function TowerComposeResultHeroGroupHeroItem:onUpdateMO(mo)
	TowerComposeResultHeroGroupHeroItem.super.onUpdateMO(self, mo)
	gohelper.setActive(self._subGO, false)
	transformhelper.setLocalPosXY(self._tagTr, 36.3, 212.1)
end

function TowerComposeResultHeroGroupHeroItem:setPlaneType(planeType)
	self.planeType = planeType
end

function TowerComposeResultHeroGroupHeroItem:_onClickThis()
	return
end

function TowerComposeResultHeroGroupHeroItem:_onClickEquip()
	return
end

function TowerComposeResultHeroGroupHeroItem:_checkDrag()
	return true
end

function TowerComposeResultHeroGroupHeroItem:showAssistHero(mo)
	if mo then
		self._heroMO = mo

		local skinConfig = FightConfig.instance:getSkinCO(self._heroMO.skin)

		self._commonHeroCard:onUpdateMO(skinConfig)
		UISpriteSetMgr.instance:setCommonSprite(self._careericon, "lssx_" .. tostring(self._heroMO.config.career))
		gohelper.setActive(self._trialTagGO, self._heroMO.belongOtherPlayer)

		self._trialTagTxt.text = luaLang("herogroup_trial_tag0")

		if not self._heroMO.level then
			local level = 0
			local hero_level, hero_rank = HeroConfig.instance:getShowLevel(level)

			self._lvnum.text = hero_level

			for i = 1, 3 do
				local rankGO = self._goRankList[i]

				gohelper.setActive(rankGO, i == hero_rank - 1)
			end

			gohelper.setActive(self._goStars, true)

			for i = 1, 6 do
				local starGO = self._goStarList[i]

				gohelper.setActive(starGO, i <= CharacterEnum.Star[self._heroMO.config.rare])
			end

			gohelper.setActive(self._heroGO, true)
			gohelper.setActive(self._noneGO, false)
		end
	else
		gohelper.setActive(self._heroGO, false)
		gohelper.setActive(self._noneGO, true)
	end
end

return TowerComposeResultHeroGroupHeroItem
