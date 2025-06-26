-- chunkname: @IQIGame\\Net\\NetMazeResponse.lua

function net_maze.reviveResult(code)
	MazeModule.ResponseRevive()
end

function net_maze.enterMazeResult(code, maze)
	MazeModule.EnterMaze(maze)
end

function net_maze.enterAbyssMazeResult(code, maze)
	MazeModule.EnterMaze(maze)
end

function net_maze.enterIllusionMazeResult(code, maze)
	MazeModule.EnterMaze(maze)
end

function net_maze.enterTestMazeResult(code, maze)
	MazeModule.EnterMaze(maze)
end

function net_maze.mazeSettlementResult(code, result)
	MazeModule.ResponseMazeSettlement(result)
end

function net_maze.notifyFinishMaze(mazeCid)
	PlayerModule.UpdateFinishMaze(mazeCid)
	PlayerModule.UpdateQuickFinishMaze(mazeCid)
end

function net_maze.restoreMazeResult(code, maze)
	MazeModule.EnterMaze(maze)
end

function net_maze.saveMazeResult(code, isQuit)
	if isQuit then
		MazeModule.ExitMaze()
	end
end

function net_maze.abandonMazeResult(code, mazeCid)
	MazeModule.AbandonMaze(mazeCid)
end

function net_maze.notifyUpdateMazeInfo(pod)
	PlayerModule.UpdateMazeInfo(pod)
end

function net_maze.uploadMazeAlienEventUnlockResult(code, cid, elementCid)
	EventDispatcher.Dispatch(EventID.MazeAlienEventUnlock, cid, elementCid)
end

function net_maze.notifyUnlockRune(runeCid)
	PlayerModule.UpdateUnlockRune(runeCid)
end

function net_maze.openHiddenMazeResult(code)
	return
end

function net_maze.notifyUpdateOpenExtraMazes(mazeCids)
	PlayerModule.UpdateOpenExtraMazes(mazeCids)
end

function net_maze.notifyUpdateOpenExtraMazes(mazeCids)
	PlayerModule.UpdateOpenExtraMazes(mazeCids)
end

function net_maze.mopUpResult_delegate(code, mopUpInfo)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)
		MazeModule.OnSweepComplete(nil)

		return
	end

	MazeModule.OnSweepComplete(mopUpInfo)
end

function net_maze.illusionMopUpResult(code, mopUpInfo)
	MazeModule.OnSweepIllusionMazeComplete(mopUpInfo)
end

function net_maze.notifyUpdateCurrMazes(currMazes)
	PlayerModule.UpdateCurrMazes(currMazes)
end

function net_maze.buyMazeCountResult()
	return
end

function net_maze.notifyAbyssCid(abyssCid)
	PlayerModule.UpdateAbyssCid(abyssCid)
end

function net_maze.notifyAbyssCids(abyssCids)
	PlayerModule.UpdateAbyssCids(abyssCids)
end

function net_maze.quickChallengeResult(code, items, quickChallenge)
	return
end

function net_maze.notifyBossEnd(win, cid, dmgRecords, items, quickChallenge)
	MazeModule.NotificationQuickChallenge(win, cid, dmgRecords, items, quickChallenge)
end
