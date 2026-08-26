-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonBadgeRuleComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonBadgeRuleComp", package.seeall)

local Act183DungeonBadgeRuleComp = class("Act183DungeonBadgeRuleComp", Act183DungeonBaseComp)

function Act183DungeonBadgeRuleComp:init(go, mgr)
	Act183DungeonBadgeRuleComp.super.init(self, go, mgr)

	self._gobadgeruleitem = gohelper.findChild(self.go, "#go_badgeruleitem")
	self._badgeRuleItemTab = self:getUserDataTb_()

	self.addEventCb(self, Act183Controller.instance, Act183Event.OnUpdateSelectBadgeNum, self._onUpdateSelectBadgeNum, self)
end

function Act183DungeonBadgeRuleComp:addEventListeners()
	return
end

function Act183DungeonBadgeRuleComp:removeEventListeners()
	return
end

function Act183DungeonBadgeRuleComp:updateInfo(episodeMo)
	Act183DungeonBadgeRuleComp.super.updateInfo(self, episodeMo)

	self._baseRules = Act183Config.instance:getEpisodeAllRuleDesc(self._episodeId)
	self._useBadgeNum = self._episodeMo:getUseBadgeNum()
	self._readyUseBadgeNum = self._useBadgeNum or 0
	self._isNeedPlayBadgeAnim = false
end

function Act183DungeonBadgeRuleComp:checkIsVisible()
	return self._readyUseBadgeNum > 0
end

function Act183DungeonBadgeRuleComp:show()
	Act183DungeonBadgeRuleComp.super.show(self)

	local badgeCo = Act183Config.instance:getBadgeCo(self._activityId, self._readyUseBadgeNum)

	self:createObjList({
		badgeCo
	}, self._badgeRuleItemTab, self._gobadgeruleitem, self._initBadgeRuleItemFunc, self._refreshBadgeRuleItemFunc, self._defaultItemFreeFunc)
end

function Act183DungeonBadgeRuleComp:_initBadgeRuleItemFunc(goItem)
	goItem.txtdesc = gohelper.findChildText(goItem.go, "txt_desc")
	goItem.anim = gohelper.onceAddComponent(goItem.go, gohelper.Type_Animator)

	SkillHelper.addHyperLinkClick(goItem.txtdesc)
end

function Act183DungeonBadgeRuleComp:_refreshBadgeRuleItemFunc(goItem, badgeCo, index)
	goItem.txtdesc.text = SkillHelper.buildDesc(badgeCo.decs)

	if self._isNeedPlayBadgeAnim then
		goItem.anim:Play("in", 0, 0)
	end
end

function Act183DungeonBadgeRuleComp:_onUpdateSelectBadgeNum(episodeId, badgeNum)
	if self._episodeId ~= episodeId then
		return
	end

	self._readyUseBadgeNum = badgeNum
	self._isNeedPlayBadgeAnim = true

	self.container:refresh()
	self.container.mgr:focus(Act183DungeonBaseAndBadgeRuleComp)
end

function Act183DungeonBadgeRuleComp:onDestroy()
	Act183DungeonBadgeRuleComp.super.onDestroy(self)
end

return Act183DungeonBadgeRuleComp
