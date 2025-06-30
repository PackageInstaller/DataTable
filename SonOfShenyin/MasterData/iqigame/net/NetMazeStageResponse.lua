-- chunkname: @IQIGame\\Net\\NetMazeStageResponse.lua

function net_mazeDup.enterMazeDupResult(code, mazeStagePOD, storySaveData)
	MazeStageModule.EnterMazeDupResult(mazeStagePOD, storySaveData)
	MazeModule.EnterMazeDupResult(mazeStagePOD)
end

function net_mazeDup.notifyFinishMazeDup(fightOverPOD)
	MazeStageModule.NotifyFinishMazeDup(fightOverPOD)
end

function net_mazeDup.notifyExitMazePlot()
	MazeStageModule.isExitMazePrepare = true

	BehaviorTreeUtility.CompleteLevel(true)
end
