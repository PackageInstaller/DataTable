-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/controller/VersionActivity2_8DungeonBossBattleController.lua

module("modules.logic.versionactivity2_8.dungeonboss.controller.VersionActivity2_8DungeonBossBattleController", package.seeall)

local VersionActivity2_8DungeonBossBattleController = class("VersionActivity2_8DungeonBossBattleController", BaseController)

function VersionActivity2_8DungeonBossBattleController:onInit()
	return
end

function VersionActivity2_8DungeonBossBattleController:reInit()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.onOpenDungeonMapView, self)
end

function VersionActivity2_8DungeonBossBattleController:addConstEvents()
	return
end

function VersionActivity2_8DungeonBossBattleController:checkIsBossBattle()
	local chapterId = DungeonModel.instance.curSendChapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

	return chapterCo and chapterCo.id == VersionActivity2_8BossEnum.BossActChapterId
end

function VersionActivity2_8DungeonBossBattleController:enterBossView(isFromGroupView)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local chapterId = DungeonModel.instance.curSendChapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)
	local actId = chapterCo.actId
	local status = ActivityHelper.getActivityStatus(actId)
	local isAct = status == ActivityEnum.ActivityStatus.Normal

	DungeonModel.instance:resetSendChapterEpisodeId()

	self._isFromGroupView = isFromGroupView

	MainController.instance:enterMainScene(self._isFromGroupView, false)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		self._delayOpenViewAndParam = nil

		if isAct then
			local enterView = ViewName.VersionActivity2_8BossActEnterView

			self._delayOpenViewAndParam = {
				enterView,
				{
					episodeId = episodeId
				}
			}

			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, enterView)
		else
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.DungeonMapView)
		end

		if self._delayOpenViewAndParam then
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.onOpenDungeonMapView, self)
		end

		JumpController.instance:jumpByParam("3#110")
	end)
end

function VersionActivity2_8DungeonBossBattleController:onOpenDungeonMapView(viewName)
	if viewName == ViewName.DungeonMapView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.onOpenDungeonMapView, self)

		if self._delayOpenViewAndParam then
			ViewMgr.instance:openView(unpack(self._delayOpenViewAndParam))

			self._delayOpenViewAndParam = nil
		end
	end
end

VersionActivity2_8DungeonBossBattleController.instance = VersionActivity2_8DungeonBossBattleController.New()

return VersionActivity2_8DungeonBossBattleController
