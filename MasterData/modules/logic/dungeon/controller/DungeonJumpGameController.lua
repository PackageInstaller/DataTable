-- chunkname: @modules/logic/dungeon/controller/DungeonJumpGameController.lua

module("modules.logic.dungeon.controller.DungeonJumpGameController", package.seeall)

local DungeonJumpGameController = class("DungeonJumpGameController", BaseController)

function DungeonJumpGameController:onInitFinish()
	return
end

function DungeonJumpGameController:addConstEvents()
	return
end

function DungeonJumpGameController:reInit()
	return
end

function DungeonJumpGameController:release()
	return
end

function DungeonJumpGameController:openResultView(win, elementId)
	local viewParams = {
		isWin = win,
		elementId = elementId
	}

	ViewMgr.instance:openView(ViewName.DungeonJumpGameResultView, viewParams)
end

function DungeonJumpGameController:resetGame()
	return
end

function DungeonJumpGameController:checkIsJumpGameBattle()
	local episodeId = DungeonModel.instance.curSendEpisodeId

	return episodeId == DungeonJumpGameEnum.episodeId
end

function DungeonJumpGameController:returnToJumpGameView()
	local chapterId = DungeonModel.instance.curSendChapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(true, false)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.DungeonMapView)
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.onOpenDungeonMapView, self)
		JumpController.instance:jumpByParam("3#110")
	end)
end

function DungeonJumpGameController:onOpenDungeonMapView(viewName)
	if viewName == ViewName.DungeonMapView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.onOpenDungeonMapView, self)
		ViewMgr.instance:openView(ViewName.DungeonJumpGameView)
	end
end

function DungeonJumpGameController:SaveCurProgress(curNodeIdx)
	local nodeIdx = curNodeIdx
	local progressStr = string.format("%d", nodeIdx)

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonJumpGameKey), progressStr)
end

function DungeonJumpGameController:HasLocalProgress()
	local progressStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonJumpGameKey), "")

	return progressStr and not string.nilorempty(progressStr)
end

function DungeonJumpGameController:ClearProgress()
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonJumpGameKey), "")
end

function DungeonJumpGameController:LoadProgress()
	local progressStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonJumpGameKey), "")

	if string.nilorempty(progressStr) then
		return
	end

	local arr = string.splitToNumber(progressStr, ",")

	return arr[1]
end

function DungeonJumpGameController:initStatData()
	self.statMo = DungeonGameMo.New()
end

function DungeonJumpGameController:sandStatData(result, cellId)
	self.statMo:sendJumpGameStatData(result, cellId)
end

DungeonJumpGameController.instance = DungeonJumpGameController.New()

return DungeonJumpGameController
