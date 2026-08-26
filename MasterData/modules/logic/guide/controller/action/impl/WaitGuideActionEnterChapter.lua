-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionEnterChapter.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterChapter", package.seeall)

local WaitGuideActionEnterChapter = class("WaitGuideActionEnterChapter", BaseGuideAction)

function WaitGuideActionEnterChapter:onStart(context)
	WaitGuideActionEnterChapter.super.onStart(self, context)

	self.chapterId = tonumber(self.actionParam)

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._checkInEpisode, self)
	self:_checkInEpisode(GameSceneMgr.instance:getCurSceneType(), nil)
end

function WaitGuideActionEnterChapter:_checkInEpisode(sceneType, sceneId)
	if sceneType == SceneType.Fight then
		local fightParam = FightModel.instance:getFightParam()

		if not fightParam then
			self:onDone(true)

			return
		end

		local episodeConfig = DungeonConfig.instance:getEpisodeCO(fightParam.episodeId)

		if not episodeConfig then
			self:onDone(true)

			return
		end

		if not self.chapterId or self.chapterId == episodeConfig.chapterId then
			GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._checkInEpisode, self)
			self:onDone(true)
		end
	end
end

function WaitGuideActionEnterChapter:clearWork()
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._checkInEpisode, self)
end

return WaitGuideActionEnterChapter
