-- chunkname: @modules/logic/fight/system/work/FightWorkAct220FightEndStory.lua

module("modules.logic.fight.system.work.FightWorkAct220FightEndStory", package.seeall)

local FightWorkAct220FightEndStory = class("FightWorkAct220FightEndStory", BaseWork)

function FightWorkAct220FightEndStory:onStart(context)
	local fightRecordMO = FightModel.instance:getRecordMO()

	if not fightRecordMO or fightRecordMO.fightResult ~= FightEnum.FightResult.Succ then
		self:onDone(true)

		return
	end

	local fightEpisodeId = DungeonModel.instance.curSendEpisodeId

	if not fightEpisodeId or fightEpisodeId == 0 then
		self:onDone(true)

		return
	end

	local episodeId, actId = Activity220Config.instance:get220EpisodeIdByFightEpisodeId(nil, fightEpisodeId)

	if not actId or not episodeId then
		self:onDone(true)

		return
	end

	local config = Activity220Config.instance:getEpisodeConfig(actId, episodeId)

	if not config or config.gameId ~= 0 then
		self:onDone(true)

		return
	end

	local storyClear = config.storyClear

	if storyClear and storyClear > 0 then
		local param = {}

		param.mark = true
		param.isReplay = false

		StoryController.instance:registerCallback(StoryEvent.AllStepFinished, self._onStoryFinish, self)
		StoryController.instance:playStory(storyClear, param, nil, self)
	else
		self:onDone(true)
	end
end

function FightWorkAct220FightEndStory:_onStoryFinish()
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, self._onStoryFinish, self)
	self:onDone(true)
end

function FightWorkAct220FightEndStory:clearWork()
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, self._onStoryFinish, self)
end

return FightWorkAct220FightEndStory
