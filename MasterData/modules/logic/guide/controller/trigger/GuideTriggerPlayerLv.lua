-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerPlayerLv.lua

module("modules.logic.guide.controller.trigger.GuideTriggerPlayerLv", package.seeall)

local GuideTriggerPlayerLv = class("GuideTriggerPlayerLv", BaseGuideTrigger)

function GuideTriggerPlayerLv:ctor(triggerKey)
	GuideTriggerPlayerLv.super.ctor(self, triggerKey)
	PlayerController.instance:registerCallback(PlayerEvent.PlayerLevelUp, self._checkStartGuide, self)
	GameSceneMgr.instance:registerCallback(SceneType.Main, self._onMainScene, self)
end

function GuideTriggerPlayerLv:assertGuideSatisfy(param, configParam)
	local configLv = tonumber(configParam)

	return configLv <= self:getParam()
end

function GuideTriggerPlayerLv:getParam()
	return PlayerModel.instance:getPlayinfo().level
end

function GuideTriggerPlayerLv:_onMainScene(sceneLevelId, Exit0Enter1)
	if Exit0Enter1 == 1 then
		self:checkStartGuide()
	end
end

function GuideTriggerPlayerLv:_checkStartGuide()
	self:checkStartGuide()
end

return GuideTriggerPlayerLv
