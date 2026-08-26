-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonBaseAndBadgeRuleComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonBaseAndBadgeRuleComp", package.seeall)

local Act183DungeonBaseAndBadgeRuleComp = class("Act183DungeonBaseAndBadgeRuleComp", Act183DungeonBaseComp)

function Act183DungeonBaseAndBadgeRuleComp:init(go)
	Act183DungeonBaseAndBadgeRuleComp.super.init(self, go)

	self._gobadgerules = gohelper.findChild(self.go, "#go_badgerules")
	self._gobaserules = gohelper.findChild(self.go, "#go_baserules")
	self._badgeRuleComp = MonoHelper.addLuaComOnceToGo(self._gobadgerules, Act183DungeonBadgeRuleComp)
	self._baseRuleComp = MonoHelper.addLuaComOnceToGo(self._gobaserules, Act183DungeonBaseRuleComp)
	self._badgeRuleComp.container = self
	self._baseRuleComp.container = self
end

function Act183DungeonBaseAndBadgeRuleComp:addEventListeners()
	return
end

function Act183DungeonBaseAndBadgeRuleComp:removeEventListeners()
	return
end

function Act183DungeonBaseAndBadgeRuleComp:updateInfo(episodeMo)
	Act183DungeonBaseAndBadgeRuleComp.super.updateInfo(self, episodeMo)
	self._badgeRuleComp:updateInfo(episodeMo)
	self._baseRuleComp:updateInfo(episodeMo)
end

function Act183DungeonBaseAndBadgeRuleComp:refresh()
	Act183DungeonBaseAndBadgeRuleComp.super.refresh(self)
	self._badgeRuleComp:refresh()
	self._baseRuleComp:refresh()
end

function Act183DungeonBaseAndBadgeRuleComp:checkIsVisible()
	return self._badgeRuleComp:checkIsVisible() or self._baseRuleComp:checkIsVisible()
end

function Act183DungeonBaseAndBadgeRuleComp:focus(isFocusBadgeRule)
	if isFocusBadgeRule then
		return self._badgeRuleComp:focus()
	end

	return self._baseRuleComp:focus()
end

return Act183DungeonBaseAndBadgeRuleComp
