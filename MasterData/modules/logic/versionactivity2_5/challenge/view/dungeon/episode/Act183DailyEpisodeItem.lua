-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/episode/Act183DailyEpisodeItem.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.episode.Act183DailyEpisodeItem", package.seeall)

local Act183DailyEpisodeItem = class("Act183DailyEpisodeItem", Act183BaseEpisodeItem)

function Act183DailyEpisodeItem.getItemParentPath(order)
	return "root/middle/#go_episodecontainer/go_dailypoint" .. order
end

function Act183DailyEpisodeItem.getItemTemplatePath(order)
	return "root/middle/#go_episodecontainer/#go_dailyepisode"
end

function Act183DailyEpisodeItem:init(go)
	Act183DailyEpisodeItem.super.init(self, go)

	self._goinfo = gohelper.findChild(self.go, "Info")
	self._imageindex = gohelper.findChildImage(self.go, "go_finish/image_index")
	self._ruleComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act183EpisodeItemRuleComp)
end

function Act183DailyEpisodeItem:addEventListeners()
	Act183DailyEpisodeItem.super.addEventListeners(self)
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnUpdateRepressInfo, self._onUpdateRepressInfo, self)
end

function Act183DailyEpisodeItem:removeEventListeners()
	Act183DailyEpisodeItem.super.removeEventListeners(self)
end

function Act183DailyEpisodeItem:_onUpdateRepressInfo(episodeId, episodeMo)
	if self._episodeId ~= episodeId then
		return
	end

	self._ruleComp:onUpdateMo(episodeMo)
end

function Act183DailyEpisodeItem:onUpdateMo(episodeMo)
	Act183DailyEpisodeItem.super.onUpdateMo(self, episodeMo)

	if self._status == Act183Enum.EpisodeStatus.Finished then
		local imgIndexName = "v2a5_challenge_dungeon_level_" .. episodeMo:getPassOrder()

		UISpriteSetMgr.instance:setChallengeSprite(self._imageindex, imgIndexName)
	end

	self._ruleComp:onUpdateMo(episodeMo)
end

function Act183DailyEpisodeItem:playFinishAnim()
	Act183DailyEpisodeItem.super.playFinishAnim(self)
	self._ruleComp:playRepressAnim()
end

function Act183DailyEpisodeItem:playFakeRepressAnim()
	self._ruleComp:playFakeRepressAnim()
end

return Act183DailyEpisodeItem
