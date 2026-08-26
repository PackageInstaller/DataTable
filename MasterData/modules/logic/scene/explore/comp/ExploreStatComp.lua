-- chunkname: @modules/logic/scene/explore/comp/ExploreStatComp.lua

module("modules.logic.scene.explore.comp.ExploreStatComp", package.seeall)

local ExploreStatComp = class("ExploreStatComp", BaseSceneComp)

function ExploreStatComp:onInit()
	return
end

function ExploreStatComp:onScenePrepared(sceneId, levelId)
	self._beginTime = UnityEngine.Time.realtimeSinceStartup
	self._isExit = false

	local mapCo = ExploreConfig.instance:getMapIdConfig(ExploreModel.instance.mapId)

	self._episodeId = mapCo.episodeId
	self._chapterId = mapCo.chapterId
end

function ExploreStatComp:onTriggerSpike(id)
	self:_onExitStat("人物返回出生点", tostring(id))
end

function ExploreStatComp:onTriggerExit(id)
	self._isExit = true

	self:_onExitStat("成功", tostring(id))
end

function ExploreStatComp:onTriggerEggs(id, name)
	StatController.instance:track(StatEnum.EventName.click_eggs_option, {
		[StatEnum.EventProperties.Dialogue_id] = id,
		[StatEnum.EventProperties.eggs_name] = name
	})
end

function ExploreStatComp:_onExitStat(result, id)
	local time = UnityEngine.Time.realtimeSinceStartup - self._beginTime
	local episodeId = tostring(self._episodeId)
	local challengeCount = ExploreModel.instance:getChallengeCount() + 1
	local bonusNum, goldCoin, purpleCoin = ExploreSimpleModel.instance:getCoinCountByMapId(ExploreModel.instance.mapId)
	local reason = id or "主动退出"
	local nodePos = ExploreHelper.getKeyXY(ExploreMapModel.instance:getHeroPos())
	local storyIds = {}
	local chapterMo = ExploreSimpleModel.instance:getChapterMo(self._chapterId)

	if chapterMo then
		local configs = lua_explore_story.configDict[self._chapterId]

		if configs then
			for archiveId in pairs(chapterMo.archiveIds) do
				local co = configs[archiveId]

				table.insert(storyIds, co.title)
			end
		end
	end

	StatController.instance:track(StatEnum.EventName.Exit_backroom, {
		[StatEnum.EventProperties.UseTime] = time,
		[StatEnum.EventProperties.EpisodeId] = episodeId,
		[StatEnum.EventProperties.ChallengesNum] = challengeCount,
		[StatEnum.EventProperties.collected_treasure] = bonusNum,
		[StatEnum.EventProperties.collected_gold] = goldCoin,
		[StatEnum.EventProperties.collected_purplecoin] = purpleCoin,
		[StatEnum.EventProperties.Result] = result,
		[StatEnum.EventProperties.FailReason] = reason,
		[StatEnum.EventProperties.coordinate] = nodePos,
		[StatEnum.EventProperties.story_fragment_name] = storyIds
	})
end

function ExploreStatComp:onSceneClose()
	if not self._isExit then
		self:_onExitStat("主动中断")
	end
end

return ExploreStatComp
