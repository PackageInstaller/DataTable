-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_BossHeroGroupFightView.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_BossHeroGroupFightView", package.seeall)

local Rouge2_BossHeroGroupFightView = class("Rouge2_BossHeroGroupFightView", HeroGroupFightView)

function Rouge2_BossHeroGroupFightView:_refreshCloth()
	gohelper.setActive(self._btncloth.gameObject, false)
end

function Rouge2_BossHeroGroupFightView:isShowDropHeroGroup()
	return false
end

function Rouge2_BossHeroGroupFightView:onOpenFinish()
	Rouge2_BossHeroGroupFightView.super.onOpenFinish(self)
	Rouge2_BossBattleController.instance:startFight()
end

return Rouge2_BossHeroGroupFightView
