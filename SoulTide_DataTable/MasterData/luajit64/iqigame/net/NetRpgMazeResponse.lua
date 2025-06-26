-- chunkname: @IQIGame\\Net\\NetRpgMazeResponse.lua

function net_rpgMaze.notifyTicketsUpdate(value)
	RpgMazeModule.UpdateTickets(value)
end

function net_rpgMaze.challengeBossResult(code)
	RpgMazeModule.ChallengeBossResult()
end

function net_rpgMaze.challengeExBossResult(code)
	RpgMazeModule.ChallengeExBossResult()
end

function net_rpgMaze.notifyChallengeBossComplete(win, bossCid, getItems, openExBoss)
	RpgMazeModule.NotifyChallengeBossComplete(win, bossCid, getItems, openExBoss)
end

function net_rpgMaze.notifyChallengeExBossComplete(win, getItems, dmgRecords)
	RpgMazeModule.NotifyChallengeExBossComplete(win, getItems, dmgRecords)
end

function net_rpgMaze.enterRPGMazeResult(code, maze)
	MazeModule.EnterMaze(maze)
end
