-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerEnterEpisode.lua

module("modules.logic.guide.controller.trigger.GuideTriggerEnterEpisode", package.seeall)

local GuideTriggerEnterEpisode = class("GuideTriggerEnterEpisode", BaseGuideTrigger)

function GuideTriggerEnterEpisode:ctor(triggerKey)
	GuideTriggerEnterEpisode.super.ctor(self, triggerKey)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
end

function GuideTriggerEnterEpisode:assertGuideSatisfy(param, configParam)
	local configEpisodeId = tonumber(configParam)

	return param == configEpisodeId
end

function GuideTriggerEnterEpisode:_onEnterOneSceneFinish(sceneType, sceneId)
	if sceneType == SceneType.Fight then
		local fightParam = FightModel.instance:getFightParam()

		if fightParam.episodeId then
			self:checkStartGuide(fightParam.episodeId)
		end
	end
end

return GuideTriggerEnterEpisode
