-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionEnterEpisode.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterEpisode", package.seeall)

local WaitGuideActionEnterEpisode = class("WaitGuideActionEnterEpisode", BaseGuideAction)

function WaitGuideActionEnterEpisode:onStart(context)
	WaitGuideActionEnterEpisode.super.onStart(self, context)

	self._episodeId = tonumber(self.actionParam)

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._checkInEpisode, self)
	self:_checkInEpisode(GameSceneMgr.instance:getCurSceneType(), nil)
end

function WaitGuideActionEnterEpisode:_checkInEpisode(sceneType, sceneId)
	if sceneType == SceneType.Fight then
		local fightParam = FightModel.instance:getFightParam()

		if not self._episodeId or self._episodeId == fightParam.episodeId then
			GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._checkInEpisode, self)
			self:onDone(true)
		end
	end
end

function WaitGuideActionEnterEpisode:clearWork()
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._checkInEpisode, self)
end

return WaitGuideActionEnterEpisode
