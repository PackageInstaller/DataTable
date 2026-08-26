-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/episode/Act183MainBossEpisodeItem.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.episode.Act183MainBossEpisodeItem", package.seeall)

local Act183MainBossEpisodeItem = class("Act183MainBossEpisodeItem", Act183BaseEpisodeItem)

function Act183MainBossEpisodeItem.getItemParentPath(order)
	return "root/middle/#go_episodecontainer/go_pointboss"
end

function Act183MainBossEpisodeItem.getItemTemplatePath()
	return "root/middle/#go_episodecontainer/#go_bossepisode"
end

function Act183MainBossEpisodeItem:init(go)
	Act183MainBossEpisodeItem.super.init(self, go)

	self._animunlock = gohelper.onceAddComponent(self._gounlock, gohelper.Type_Animator)

	self.addEventCb(self, Act183Controller.instance, Act183Event.OnInitDungeonDone, self._onInitDungeonDone, self)
end

function Act183MainBossEpisodeItem:_onInitDungeonDone()
	self:_checkPlayNewUnlockAnim()
end

function Act183MainBossEpisodeItem:_checkPlayNewUnlockAnim()
	if self._status ~= Act183Enum.EpisodeStatus.Unlocked then
		return
	end

	local isNewUnlock = Act183Model.instance:isEpisodeNewUnlock(self._episodeId)

	if isNewUnlock then
		self._animunlock:Play("unlock", 0, 0)
	end
end

function Act183MainBossEpisodeItem:playFinishAnim()
	Act183MainBossEpisodeItem.super.playFinishAnim(self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_EpisodeFinished_Star)
end

return Act183MainBossEpisodeItem
