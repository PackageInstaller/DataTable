-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonRepressResultComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonRepressResultComp", package.seeall)

local Act183DungeonRepressResultComp = class("Act183DungeonRepressResultComp", Act183DungeonBaseComp)

function Act183DungeonRepressResultComp:init(go)
	Act183DungeonRepressResultComp.super.init(self, go)

	self._gohasrepress = gohelper.findChild(self.go, "#go_hasrepress")
	self._gounrepress = gohelper.findChild(self.go, "#go_unrepress")
	self._gorepressruleitem = gohelper.findChild(self.go, "#go_repressrules/#go_repressruleitem")
	self._gorepressheropos = gohelper.findChild(self.go, "#go_hasrepress/#go_repressheropos")
	self._repressRuleItemTab = self:getUserDataTb_()
end

function Act183DungeonRepressResultComp:addEventListeners()
	return
end

function Act183DungeonRepressResultComp:removeEventListeners()
	return
end

function Act183DungeonRepressResultComp:updateInfo(episodeMo)
	Act183DungeonRepressResultComp.super.updateInfo(self, episodeMo)

	self._baseRules = Act183Config.instance:getEpisodeAllRuleDesc(self._episodeId)
end

function Act183DungeonRepressResultComp:checkIsVisible()
	local isFinished = self._status == Act183Enum.EpisodeStatus.Finished
	local isSubEpisode = self._episodeType == Act183Enum.EpisodeType.Sub
	local isLastEpisode = Act183Helper.isLastPassEpisodeInType(self._episodeMo)

	return isFinished and isSubEpisode and not isLastEpisode
end

function Act183DungeonRepressResultComp:show()
	Act183DungeonRepressResultComp.super.show(self)
	gohelper.setActive(self._gohasrepress, false)
	gohelper.setActive(self._gounrepress, true)
	self:createObjList(self._baseRules, self._repressRuleItemTab, self._gorepressruleitem, self._initRepressRuleItemFunc, self._refreshRepressResultFunc, self._defaultItemFreeFunc)
end

function Act183DungeonRepressResultComp:_initRepressRuleItemFunc(goItem)
	goItem.txtdesc = gohelper.findChildText(goItem.go, "txt_desc")
	goItem.imageicon = gohelper.findChildImage(goItem.go, "image_icon")
	goItem.godisable = gohelper.findChild(goItem.go, "image_icon/go_disable")
	goItem.goescape = gohelper.findChild(goItem.go, "image_icon/go_escape")
	goItem.gorepressbg = gohelper.findChild(goItem.go, "#go_Disable")

	SkillHelper.addHyperLinkClick(goItem.txtdesc)
end

function Act183DungeonRepressResultComp:_refreshRepressResultFunc(resultItem, desc, index)
	local ruleStatus = self._episodeMo:getRuleStatus(index)
	local hasRepress = ruleStatus == Act183Enum.RuleStatus.Repress

	resultItem.txtdesc.text = SkillHelper.buildDesc(desc)

	gohelper.setActive(resultItem.godisable, hasRepress)
	gohelper.setActive(resultItem.gorepressbg, hasRepress)
	gohelper.setActive(resultItem.goescape, not hasRepress)
	Act183Helper.setRuleIcon(self._episodeId, index, resultItem.imageicon)

	if hasRepress then
		local repressHeroMo = self._episodeMo:getRepressHeroMo()
		local heroId = repressHeroMo:getHeroId()

		if not self._repressHeroItem then
			self._repressHeroItem = IconMgr.instance:getCommonHeroIconNew(self._gorepressheropos)

			self._repressHeroItem:isShowLevel(false)
		end

		self._repressHeroItem:onUpdateHeroId(heroId)
		gohelper.setActive(self._gohasrepress, true)
		gohelper.setActive(self._gounrepress, false)
	end
end

function Act183DungeonRepressResultComp:onDestroy()
	Act183DungeonRepressResultComp.super.onDestroy(self)
end

return Act183DungeonRepressResultComp
