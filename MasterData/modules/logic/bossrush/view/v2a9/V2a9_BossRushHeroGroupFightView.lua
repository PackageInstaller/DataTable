-- chunkname: @modules/logic/bossrush/view/v2a9/V2a9_BossRushHeroGroupFightView.lua

module("modules.logic.bossrush.view.v2a9.V2a9_BossRushHeroGroupFightView", package.seeall)

local V2a9_BossRushHeroGroupFightView = class("V2a9_BossRushHeroGroupFightView", HeroGroupFightView)

function V2a9_BossRushHeroGroupFightView:_editableInitView()
	V2a9_BossRushHeroGroupFightView.super._editableInitView(self)

	local skillroot = gohelper.findChild(self.viewGO, "#go_assassinskill")
	local path = self.viewContainer:getSetting().otherRes[2]
	local childGO = self:getResInst(path, skillroot, "skillComp")

	self._skillComp = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V2a9_BossRushHeroGroupSkillComp)

	self._skillComp:onUpdateMO()
	gohelper.setActive(skillroot, true)

	local heroRoot = gohelper.findChild(self.viewGO, "herogroupcontain/hero")
	local areaRoot = gohelper.findChild(self.viewGO, "herogroupcontain/area")

	recthelper.setAnchorX(heroRoot.transform, -350)
	recthelper.setAnchorX(areaRoot.transform, -350)
end

function V2a9_BossRushHeroGroupFightView:_refreshCloth()
	gohelper.setActive(self._btncloth.gameObject, false)
end

return V2a9_BossRushHeroGroupFightView
