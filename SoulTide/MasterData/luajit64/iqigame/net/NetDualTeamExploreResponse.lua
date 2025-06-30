-- chunkname: @IQIGame\\Net\\NetDualTeamExploreResponse.lua

function net_dualTeamExplore.enterLevelResult(code, levelPOD)
	DualTeamExploreModule.OnEnterScene(levelPOD)
end

function net_dualTeamExplore.moveResult_delegate(code, teamId, nodeId, isStop)
	NetCommController.Responded()

	if code ~= 0 then
		isStop = true

		if code == 45003 then
			warning("弛豫之末外层关卡移动发生错误：客户端状态与服务器不同步. code: " .. code)
		else
			NoticeModule.ShowServerError(code)
		end
	end

	local teamIndex = teamId

	DualTeamExploreModule.AddCommand(DTEMoveCommand.New(teamIndex, nodeId, isStop))
end

function net_dualTeamExplore.notifyExecution(serviceId, executionId)
	DualTeamExploreModule.AddCommand(DTEExecutionCommand.New(serviceId, executionId))
end

function net_dualTeamExplore.notifyShowGetItems(serviceId, executionId, itemShows)
	DualTeamExploreModule.AddCommand(DTEGetItemCommand.New(serviceId, executionId, itemShows))
end

function net_dualTeamExplore.fightResult(code)
	DualTeamExploreModule.ResponseStartBattle()
end

function net_dualTeamExplore.notifyFightComplete(win, teamId, team1, team2)
	DualTeamExploreModule.QuitBattle(win, teamId, team1, team2)
end

function net_dualTeamExplore.enterDualTeamMazeResult(code, maze)
	if maze == nil then
		return
	end

	DualTeamExploreModule.OnEnterMaze(maze)
end

function net_dualTeamExplore.notifyOpenDialog(dialogCid)
	DualTeamExploreModule.AddCommand(DTEOpenDialogCommand.New(dialogCid))
end

function net_dualTeamExplore.selectDialogResult(code, nextDialogCid)
	DualTeamExploreModule.LevelPOD.currDialog = nextDialogCid

	EventDispatcher.Dispatch(EventID.JumpToNextDialog, nextDialogCid)
end

function net_dualTeamExplore.notifyLevelSettlement(success)
	DualTeamExploreModule.OnSettlement(success)
end

function net_dualTeamExplore.notifyNodeUpdate(node)
	DualTeamExploreModule.AddCommand(DTEUpdateNodeCommand.New(node))
end

function net_dualTeamExplore.notifyTeamMemberAttr(soulCid, attr, power)
	DualTeamExploreModule.AddCommand(DTEUpdateTeamMemberAttrCommand.New(soulCid, attr, power))
end

function net_dualTeamExplore.notifyTeamStatus(teamId, stop)
	DualTeamExploreModule.AddCommand(DTEUpdateTeamStatusCommand.New(teamId, stop))
end

function net_dualTeamExplore.notifyLevelStatus(separate)
	DualTeamExploreModule.AddCommand(DTEUpdateLevelStatusCommand.New(separate))
end

function net_dualTeamExplore.giveupResult(code)
	return
end

function net_dualTeamExplore.numberInputResult(code, type)
	return
end

function net_dualTeamExplore.challengeBossResult(code)
	DualTeamExploreModule.ChallengeBossResult(code)
end

function net_dualTeamExplore.challengeExBossResult(code)
	DualTeamExploreModule.ChallengeExBossResult(code)
end

function net_dualTeamExplore.notifyChallengeBossComplete(win, bossCid, getItems, openExBoss)
	DualTeamExploreModule.NotifyChallengeBossComplete(win, bossCid, getItems, openExBoss)
end

function net_dualTeamExplore.notifyChallengeExBossComplete(win, getItems, dmgRecords)
	DualTeamExploreModule.NotifyChallengeExBossComplete(win, getItems, dmgRecords)
end

function net_dualTeamExplore.notifyTicketsUpdate(value)
	DualTeamExploreModule.NotifyTicketsUpdate(value)
end

function net_dualTeamExplore.notifyFight(id)
	DualTeamExploreModule.AddCommand(DTEBattleCommand.New(id))
end

function net_dualTeamExplore.reviveResult(code, teamId, team)
	DualTeamExploreModule.OnRevive(teamId, team)
end
