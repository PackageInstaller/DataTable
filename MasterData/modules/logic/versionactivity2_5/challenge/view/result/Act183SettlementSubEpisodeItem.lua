-- chunkname: @modules/logic/versionactivity2_5/challenge/view/result/Act183SettlementSubEpisodeItem.lua

module("modules.logic.versionactivity2_5.challenge.view.result.Act183SettlementSubEpisodeItem", package.seeall)

local Act183SettlementSubEpisodeItem = class("Act183SettlementSubEpisodeItem", LuaCompBase)

function Act183SettlementSubEpisodeItem:init(go)
	self.go = go
	self._imageindex = gohelper.findChildImage(go, "image_index")
	self._imagestar = gohelper.findChildImage(go, "image_star")
	self._gobadgebg = gohelper.findChild(go, "mask")
	self._txtbadgenum = gohelper.findChildText(go, "txt_badgenum")
	self._imageruleicon1 = gohelper.findChildImage(go, "rules/go_rule1/image_icon")
	self._gorepress1 = gohelper.findChild(go, "rules/go_rule1/go_repress")
	self._goescape1 = gohelper.findChild(go, "rules/go_rule1/go_escape")
	self._imageruleicon2 = gohelper.findChildImage(go, "rules/go_rule2/image_icon")
	self._gorepress2 = gohelper.findChild(go, "rules/go_rule2/go_repress")
	self._goescape2 = gohelper.findChild(go, "rules/go_rule2/go_escape")
	self._imageicon = gohelper.findChildImage(go, "image_episode")
	self._goherocontainer = gohelper.findChild(go, "heros")
	self._gorules1 = gohelper.findChild(go, "rules")
	self._gorules2 = gohelper.findChild(go, "rules2")
	self._gorepress1_v2 = gohelper.findChild(go, "rules2/go_rule1/go_repress")
	self._goescape1_v2 = gohelper.findChild(go, "rules2/go_rule1/go_escape")
	self._imageruleicon2_v2 = gohelper.findChildImage(go, "rules2/go_rule2/image_icon")
	self._gorepress2_v2 = gohelper.findChild(go, "rules2/go_rule2/go_repress")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183SettlementSubEpisodeItem:addEvents()
	return
end

function Act183SettlementSubEpisodeItem:removeEvents()
	return
end

function Act183SettlementSubEpisodeItem:_editableInitView()
	self._herogroupComp = MonoHelper.addLuaComOnceToGo(self._goherocontainer, Act183SettlementSubEpisodeHeroComp)
end

function Act183SettlementSubEpisodeItem:setHeroTemplate(templateGo)
	if self._herogroupComp then
		self._herogroupComp:setHeroTemplate(templateGo)
	end
end

function Act183SettlementSubEpisodeItem:onUpdateMO(groupRecordMo, episodeRecordMo)
	local isAllConditionPass = episodeRecordMo:isAllConditionPass()
	local useBadgeNum = episodeRecordMo:getUseBadgeNum()

	UISpriteSetMgr.instance:setChallengeSprite(self._imageindex, "v2a5_challenge_result_level_" .. episodeRecordMo:getPassOrder())

	self._txtbadgenum.text = useBadgeNum

	gohelper.setActive(self._txtbadgenum.gameObject, useBadgeNum > 0)
	gohelper.setActive(self._gobadgebg, useBadgeNum > 0)

	local episodeId = episodeRecordMo:getEpisodeId()

	Act183Helper.setRuleIcon(episodeId, 1, self._imageruleicon1)
	Act183Helper.setRuleIcon(episodeId, 2, self._imageruleicon2)
	Act183Helper.setSubEpisodeResultIcon(episodeId, self._imageicon)
	self:refreshRepressIcon(episodeRecordMo)
	self:refreshHeroGroup(episodeRecordMo)
	Act183Helper.setEpisodeConditionStar(self._imagestar, isAllConditionPass, nil)
	gohelper.setActive(self.go, true)
end

function Act183SettlementSubEpisodeItem:refreshRepressIcon(episodeRecordMo)
	local rulestatus1 = episodeRecordMo:getRuleStatus(1)
	local rulestatus2 = episodeRecordMo:getRuleStatus(2)
	local heroMos = episodeRecordMo:getHeroMos()

	if heroMos then
		if not #heroMos then
			local heroCount = 0
			local useRepressIcon_v2 = heroCount == 5

			if useRepressIcon_v2 then
				gohelper.setActive(self._gorepress1_v2, rulestatus1 == Act183Enum.RuleStatus.Repress)
				gohelper.setActive(self._gorepress2_v2, rulestatus2 == Act183Enum.RuleStatus.Repress)
				gohelper.setActive(self._goescape1_v2, rulestatus1 == Act183Enum.RuleStatus.Escape)
				gohelper.setActive(self._goescape2_v2, rulestatus2 == Act183Enum.RuleStatus.Escape)
			else
				gohelper.setActive(self._gorepress1, rulestatus1 == Act183Enum.RuleStatus.Repress)
				gohelper.setActive(self._gorepress2, rulestatus2 == Act183Enum.RuleStatus.Repress)
				gohelper.setActive(self._goescape1, rulestatus1 == Act183Enum.RuleStatus.Escape)
				gohelper.setActive(self._goescape2, rulestatus2 == Act183Enum.RuleStatus.Escape)
			end

			gohelper.setActive(self._gorules1, not useRepressIcon_v2)
			gohelper.setActive(self._gorules2, useRepressIcon_v2)
		end
	end
end

function Act183SettlementSubEpisodeItem:refreshHeroGroup(episodeRecordMo)
	if self._herogroupComp then
		self._herogroupComp:onUpdateMO(episodeRecordMo)
	end
end

function Act183SettlementSubEpisodeItem:onDestroy()
	return
end

return Act183SettlementSubEpisodeItem
