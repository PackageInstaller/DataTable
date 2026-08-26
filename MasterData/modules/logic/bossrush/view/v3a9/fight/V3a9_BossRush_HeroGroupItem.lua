-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_HeroGroupItem.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_HeroGroupItem", package.seeall)

local V3a9_BossRush_HeroGroupItem = class("V3a9_BossRush_HeroGroupItem", V3a9_BossRush_HeroItem)

function V3a9_BossRush_HeroGroupItem:_refreshState()
	gohelper.setActive(self._goAdd.gameObject, not self._isHasHero)
	gohelper.setActive(self._goHas.gameObject, self._isHasHero)
end

return V3a9_BossRush_HeroGroupItem
