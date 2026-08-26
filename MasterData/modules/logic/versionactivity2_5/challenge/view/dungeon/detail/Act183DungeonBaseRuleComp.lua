-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonBaseRuleComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonBaseRuleComp", package.seeall)

local Act183DungeonBaseRuleComp = class("Act183DungeonBaseRuleComp", Act183DungeonBaseComp)

function Act183DungeonBaseRuleComp:init(go)
	Act183DungeonBaseRuleComp.super.init(self, go)

	self._gobaseruleitem = gohelper.findChild(self.go, "#go_baseruleitem")
	self._baseRuleItemTab = self:getUserDataTb_()
end

function Act183DungeonBaseRuleComp:addEventListeners()
	return
end

function Act183DungeonBaseRuleComp:removeEventListeners()
	return
end

function Act183DungeonBaseRuleComp:updateInfo(episodeMo)
	Act183DungeonBaseRuleComp.super.updateInfo(self, episodeMo)

	self._baseRules = Act183Config.instance:getEpisodeAllRuleDesc(self._episodeId)
end

function Act183DungeonBaseRuleComp:checkIsVisible()
	return self._baseRules and #self._baseRules > 0
end

function Act183DungeonBaseRuleComp:show()
	Act183DungeonBaseRuleComp.super.show(self)
	self:createObjList(self._baseRules, self._baseRuleItemTab, self._gobaseruleitem, self._initBaseRuleItemFunc, self._refreshBaseRuleItemFunc, self._defaultItemFreeFunc)
end

function Act183DungeonBaseRuleComp:_initBaseRuleItemFunc(goItem)
	goItem.txtdesc = gohelper.findChildText(goItem.go, "txt_desc")
	goItem.imageicon = gohelper.findChildImage(goItem.go, "image_icon")

	SkillHelper.addHyperLinkClick(goItem.txtdesc)
end

function Act183DungeonBaseRuleComp:_refreshBaseRuleItemFunc(goItem, ruleDesc, index)
	goItem.txtdesc.text = SkillHelper.buildDesc(ruleDesc)

	Act183Helper.setRuleIcon(self._episodeId, index, goItem.imageicon)
end

function Act183DungeonBaseRuleComp:onDestroy()
	Act183DungeonBaseRuleComp.super.onDestroy(self)
end

return Act183DungeonBaseRuleComp
