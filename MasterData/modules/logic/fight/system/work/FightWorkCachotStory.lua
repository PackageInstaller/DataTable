-- chunkname: @modules/logic/fight/system/work/FightWorkCachotStory.lua

module("modules.logic.fight.system.work.FightWorkCachotStory", package.seeall)

local FightWorkCachotStory = class("FightWorkCachotStory", BaseWork)

function FightWorkCachotStory:onStart(context)
	local fightRecordMO = FightModel.instance:getRecordMO()
	local episodeCo = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local rogueinfo = V1a6_CachotModel.instance:getRogueInfo()

	if not rogueinfo then
		self:onDone(true)

		return
	end

	if fightRecordMO and fightRecordMO.fightResult == FightEnum.FightResult.Succ and episodeCo and episodeCo.type == DungeonEnum.EpisodeType.Cachot then
		if rogueinfo.room == V1a6_CachotEnum.SecondLayerFirstRoom then
			local storyId = V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.StoryNode3).value
			local param = {}

			param.mark = true
			param.isReplay = false

			if storyId and storyId ~= 0 and not StoryModel.instance:isStoryFinished(tonumber(storyId)) then
				StoryController.instance:registerCallback(StoryEvent.AllStepFinished, self._onStoryFinish, self)
				StoryController.instance:playStory(tonumber(storyId), param, nil, self)
			else
				self:onDone(true)
			end
		else
			self:onDone(true)
		end
	else
		self:onDone(true)
	end
end

function FightWorkCachotStory:_onStoryFinish()
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, self._onStoryFinish, self)
	self:onDone(true)
end

function FightWorkCachotStory:clearWork()
	StoryController.instance:unregisterCallback(StoryEvent.AllStepFinished, self._onStoryFinish, self)
end

return FightWorkCachotStory
