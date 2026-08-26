-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/episode/Act183EpisodeItemRuleComp.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.episode.Act183EpisodeItemRuleComp", package.seeall)

local Act183EpisodeItemRuleComp = class("Act183EpisodeItemRuleComp", LuaCompBase)

function Act183EpisodeItemRuleComp:init(go)
	self.go = go
	self._goinfo = gohelper.findChild(self.go, "Info")
	self._imagerule1 = gohelper.findChildImage(self.go, "Info/rules/image_rule1")
	self._gorepress1 = gohelper.findChild(self.go, "Info/rules/image_rule1/go_repress1")
	self._imagerule2 = gohelper.findChildImage(self.go, "Info/rules/image_rule2")
	self._gorepress2 = gohelper.findChild(self.go, "Info/rules/image_rule2/go_repress2")
	self._goescape1 = gohelper.findChild(self.go, "Info/rules/image_rule1/go_repressbutterfly1")
	self._goescape2 = gohelper.findChild(self.go, "Info/rules/image_rule2/go_repressbutterfly2")
	self._animrepress1 = gohelper.onceAddComponent(self._gorepress1, gohelper.Type_Animator)
	self._animrepress2 = gohelper.onceAddComponent(self._gorepress2, gohelper.Type_Animator)
	self._animescape1 = gohelper.onceAddComponent(self._goescape1, gohelper.Type_Animator)
	self._animescape2 = gohelper.onceAddComponent(self._goescape2, gohelper.Type_Animator)
end

function Act183EpisodeItemRuleComp:addEventListeners()
	return
end

function Act183EpisodeItemRuleComp:removeEventListeners()
	return
end

function Act183EpisodeItemRuleComp:onUpdateMo(episodeMo)
	self._episodeMo = episodeMo
	self._episodeId = episodeMo:getEpisodeId()
	self._hasRules = Act183Helper.isEpisodeHasRule(self._episodeId)

	self:refreshRules()
end

function Act183EpisodeItemRuleComp:refreshRules()
	gohelper.setActive(self._goinfo, self._hasRules)

	if not self._hasRules then
		return
	end

	Act183Helper.setRuleIcon(self._episodeId, 1, self._imagerule1)
	Act183Helper.setRuleIcon(self._episodeId, 2, self._imagerule2)

	self._rule1status = self._episodeMo:getRuleStatus(1)
	self._rule2status = self._episodeMo:getRuleStatus(2)

	gohelper.setActive(self._gorepress1, self._rule1status == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(self._gorepress2, self._rule2status == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(self._goescape1, self._rule1status == Act183Enum.RuleStatus.Escape)
	gohelper.setActive(self._goescape2, self._rule2status == Act183Enum.RuleStatus.Escape)
end

function Act183EpisodeItemRuleComp:playRepressAnim()
	if not self._hasRules then
		return
	end

	if self._rule1status == Act183Enum.RuleStatus.Repress then
		self._animrepress1:Play("in", 0, 0)
	else
		self._animescape1:Play("in", 0, 0)
	end

	if self._rule2status == Act183Enum.RuleStatus.Repress then
		self._animrepress2:Play("in", 0, 0)
	else
		self._animescape2:Play("in", 0, 0)
	end
end

function Act183EpisodeItemRuleComp:playFakeRepressAnim()
	if not self._hasRules then
		return
	end

	self._animescape1:Play("in", 0, 0)
	self._animescape2:Play("in", 0, 0)
	gohelper.setActive(self._goescape1, true)
	gohelper.setActive(self._goescape2, true)
end

return Act183EpisodeItemRuleComp
