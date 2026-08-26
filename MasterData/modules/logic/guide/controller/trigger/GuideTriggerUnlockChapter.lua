-- chunkname: @modules/logic/guide/controller/trigger/GuideTriggerUnlockChapter.lua

module("modules.logic.guide.controller.trigger.GuideTriggerUnlockChapter", package.seeall)

local GuideTriggerUnlockChapter = class("GuideTriggerUnlockChapter", BaseGuideTrigger)

function GuideTriggerUnlockChapter:ctor(triggerKey)
	GuideTriggerUnlockChapter.super.ctor(self, triggerKey)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateRewardPoint, self._checkStartGuide, self)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, self._checkStartGuide, self)
	StoryController.instance:registerCallback(StoryEvent.Finish, self._checkStartGuide, self)
	GameSceneMgr.instance:registerCallback(SceneType.Main, self._onMainScene, self)
end

function GuideTriggerUnlockChapter:assertGuideSatisfy(param, configParam)
	local chapterId = tonumber(configParam)

	return not DungeonModel.instance:chapterIsLock(chapterId)
end

function GuideTriggerUnlockChapter:_onMainScene(sceneLevelId, Exit0Enter1)
	if Exit0Enter1 == 1 then
		self:checkStartGuide()
	end
end

function GuideTriggerUnlockChapter:_checkStartGuide()
	self:checkStartGuide()
end

return GuideTriggerUnlockChapter
