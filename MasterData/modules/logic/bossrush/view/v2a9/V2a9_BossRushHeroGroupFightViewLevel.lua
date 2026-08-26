-- chunkname: @modules/logic/bossrush/view/v2a9/V2a9_BossRushHeroGroupFightViewLevel.lua

module("modules.logic.bossrush.view.v2a9.V2a9_BossRushHeroGroupFightViewLevel", package.seeall)

local V2a9_BossRushHeroGroupFightViewLevel = class("V2a9_BossRushHeroGroupFightViewLevel", HeroGroupFightViewLevel)

function V2a9_BossRushHeroGroupFightViewLevel:_editableInitView()
	V2a9_BossRushHeroGroupFightViewLevel.super._editableInitView(self)

	local normalconditionstar = gohelper.findChild(self._gonormalcondition, "star")

	gohelper.setActive(normalconditionstar, false)
end

return V2a9_BossRushHeroGroupFightViewLevel
