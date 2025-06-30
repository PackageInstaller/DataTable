-- chunkname: @IQIGame\\Net\\NetAbyssPlusResponse.lua

function net_abyssPlus.enterLevelResult(code, maze)
	MazeModule.EnterMaze(maze)
end

function net_abyssPlus.useRuneResult(code)
	return
end

function net_abyssPlus.challengeExBossResult(code)
	EndlessPlusMazeModule.ChallengeExBossResult()
end

function net_abyssPlus.notifyChallengeExBossComplete(win, getItems, dmgRecords)
	EndlessPlusMazeModule.NotifyChallengeExBossComplete(win, getItems, dmgRecords)
end
