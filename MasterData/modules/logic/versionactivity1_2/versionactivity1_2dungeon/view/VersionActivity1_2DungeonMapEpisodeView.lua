-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity1_2DungeonMapEpisodeView.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapEpisodeView", package.seeall)

local VersionActivity1_2DungeonMapEpisodeView = class("VersionActivity1_2DungeonMapEpisodeView", VersionActivity1_2DungeonMapEpisodeBaseView)

function VersionActivity1_2DungeonMapEpisodeView:addEvents()
	VersionActivity1_2DungeonMapEpisodeView.super.addEvents(self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self._onSetEpisodeListVisible, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.enterFight, self._onEnterFight, self)
end

function VersionActivity1_2DungeonMapEpisodeView:_onSetEpisodeListVisible(state)
	return
end

function VersionActivity1_2DungeonMapEpisodeView:getLayoutClass()
	return VersionActivity1_2DungeonMapChapterLayout.New()
end

function VersionActivity1_2DungeonMapEpisodeView:btnHardModeClick()
	local isOpen, toastId = self:hardModelIsOpen()

	if not isOpen then
		GameFacade.showToast(toastId)

		return
	end

	self:changeEpisodeMode(VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function VersionActivity1_2DungeonMapEpisodeView:hardModelIsOpen()
	local isOpen, _ = VersionActivityConfig.instance:getAct113DungeonChapterIsOpen(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard)

	if not isOpen then
		return false, 10301, 1
	end

	local hard_episode_list = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard)

	if not DungeonModel.instance:hasPassLevelAndStory(hard_episode_list[1].preEpisode) then
		return false, 10302, 2
	end

	return true
end

return VersionActivity1_2DungeonMapEpisodeView
