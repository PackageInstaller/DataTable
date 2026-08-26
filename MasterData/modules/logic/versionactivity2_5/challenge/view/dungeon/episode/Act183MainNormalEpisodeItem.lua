-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/episode/Act183MainNormalEpisodeItem.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.episode.Act183MainNormalEpisodeItem", package.seeall)

local Act183MainNormalEpisodeItem = class("Act183MainNormalEpisodeItem", Act183BaseEpisodeItem)

function Act183MainNormalEpisodeItem.getItemParentPath(order)
	return "root/middle/#go_episodecontainer/go_point" .. order
end

function Act183MainNormalEpisodeItem.getItemTemplatePath(order)
	return "root/middle/#go_episodecontainer/#go_normalepisode"
end

function Act183MainNormalEpisodeItem:init(go)
	Act183MainNormalEpisodeItem.super.init(self, go)

	self._goinfo = gohelper.findChild(self.go, "Info")
	self._imageindex = gohelper.findChildImage(self.go, "go_finish/image_index")
	self._imagecondition = gohelper.findChildImage(self.go, "Info/image_condition")
	self._animcondition = gohelper.onceAddComponent(self._imagecondition, gohelper.Type_Animator)

	Act183Helper.setEpisodeConditionStar(self._imagecondition, true)

	self._ruleComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act183EpisodeItemRuleComp)
end

function Act183MainNormalEpisodeItem:addEventListeners()
	Act183MainNormalEpisodeItem.super.addEventListeners(self)
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnUpdateRepressInfo, self._onUpdateRepressInfo, self)
end

function Act183MainNormalEpisodeItem:removeEventListeners()
	Act183MainNormalEpisodeItem.super.removeEventListeners(self)
end

function Act183MainNormalEpisodeItem:_onUpdateRepressInfo(episodeId, episodeMo)
	if self._episodeId ~= episodeId then
		return
	end

	self._ruleComp:onUpdateMo(episodeMo)
	self._ruleComp:playRepressAnim()
end

function Act183MainNormalEpisodeItem:onUpdateMo(episodeMo)
	Act183MainNormalEpisodeItem.super.onUpdateMo(self, episodeMo)

	if self._status == Act183Enum.EpisodeStatus.Finished then
		local imgIndexName = "v2a5_challenge_dungeon_level_" .. episodeMo:getPassOrder()

		UISpriteSetMgr.instance:setChallengeSprite(self._imageindex, imgIndexName)
	end

	self._isAllConditionPass = self._episodeMo:isAllConditionPass()

	self._animcondition:Play(self._isAllConditionPass and "lighted" or "gray", 0, 0)
	self._ruleComp:onUpdateMo(episodeMo)
end

function Act183MainNormalEpisodeItem:playFinishAnim()
	Act183MainNormalEpisodeItem.super.playFinishAnim(self)
	self._ruleComp:playRepressAnim()
	self:playAllConditionPassAnim()
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_EpisodeFinished_Star)
end

function Act183MainNormalEpisodeItem:playFakeRepressAnim()
	self._ruleComp:playFakeRepressAnim()
end

function Act183MainNormalEpisodeItem:playAllConditionPassAnim()
	if self._isAllConditionPass then
		self._animcondition:Play("light", 0, 0)
	end
end

return Act183MainNormalEpisodeItem
