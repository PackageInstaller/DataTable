-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/boss/VersionActivity1_6_BossInfoRuleView.lua

module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossInfoRuleView", package.seeall)

local VersionActivity1_6_BossInfoRuleView = class("VersionActivity1_6_BossInfoRuleView", WeekWalkEnemyInfoViewRule)

function VersionActivity1_6_BossInfoRuleView:_addRuleItem(ruleCo, targetId)
	local go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)

	table.insert(self._childGoList, go)
	gohelper.setActive(go, true)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)

	local simage = gohelper.findChildImage(go, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleCo.icon)

	tagicon.maskable = true
	simage.maskable = true
end

return VersionActivity1_6_BossInfoRuleView
