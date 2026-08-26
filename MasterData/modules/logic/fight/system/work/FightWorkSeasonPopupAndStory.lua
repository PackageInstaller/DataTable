-- chunkname: @modules/logic/fight/system/work/FightWorkSeasonPopupAndStory.lua

module("modules.logic.fight.system.work.FightWorkSeasonPopupAndStory", package.seeall)

local FightWorkSeasonPopupAndStory = class("FightWorkSeasonPopupAndStory", BaseWork)

function FightWorkSeasonPopupAndStory:onStart()
	local episode_config = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if episode_config and episode_config.type == DungeonEnum.EpisodeType.Season then
		if PopupController.instance:getPopupCount() > 0 then
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		else
			self:_checkStory()
		end
	else
		self:onDone(true)
	end
end

function FightWorkSeasonPopupAndStory:_onCloseViewFinish()
	if PopupController.instance:getPopupCount() == 0 then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		self:_checkStory()
	end
end

function FightWorkSeasonPopupAndStory:_checkStory()
	local storyId = FightModel.instance:getAfterStory()

	if storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
		local param = {}

		param.mark = true
		param.episodeId = DungeonModel.instance.curSendEpisodeId

		StoryController.instance:playStory(storyId, param, self._storyEnd, self)
	else
		self:onDone(true)
	end
end

function FightWorkSeasonPopupAndStory:_storyEnd()
	self:onDone(true)
end

function FightWorkSeasonPopupAndStory:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

return FightWorkSeasonPopupAndStory
