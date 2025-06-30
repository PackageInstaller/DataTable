-- chunkname: @IQIGame\\Net\\NetTaleChallengeResponse.lua

function net_taleChallenge.triggerChallengeStoryResult(code)
	PlotChallengeModule.TriggerChallengeStoryResult()
end

function net_taleChallenge.triggerChallengeFightResult(code)
	PlotChallengeModule.TriggerChallengeFightResult()
end

function net_taleChallenge.triggerChallengeBossResult(code)
	PlotChallengeModule.TriggerChallengeBossResult()
end

function net_taleChallenge.notifyTaleChallengeStoryFinished(nodeId, list)
	PlotChallengeModule.NotifyTaleChallengeStoryFinished(nodeId, list)
end

function net_taleChallenge.notifyChallengeFightRet(nodeId, win, showList)
	PlotChallengeModule.NotifyChallengeFightRet(nodeId, win, showList)
end

function net_taleChallenge.notifyChallengeBossRet(win, showList)
	PlotChallengeModule.NotifyChallengeBossRet(win, showList)
end

function net_taleChallenge.selectDialogResult(code, nextDialogCid)
	PlotChallengeModule.currDialog = nextDialogCid

	EventDispatcher.Dispatch(EventID.JumpToNextDialog, nextDialogCid)
end

function net_taleChallenge.notifyOpenDialog(dialogCid)
	DialogModule.OpenDialog(dialogCid, false, true)
end

function net_taleChallenge.drawResult(code, id, count, rewardList, drawInfo)
	PlotChallengeModule.DrawResult(code, id, count, rewardList, drawInfo)
end
