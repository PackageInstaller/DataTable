-- chunkname: @IQIGame\\Net\\NetSurvivalResponse.lua

function net_survival.startChallengeResult(code, cid)
	SurvivalModule.StartChallengeResult(cid)
end

function net_survival.endChallengeResult(code, getItems, monster, boss, id, pass)
	SurvivalModule.EndChallengeResult(getItems, monster, boss, id, pass)
end

function net_survival.levelResult(code, level)
	SurvivalModule.LevelResult(level)
end

function net_survival.startChallengeUnlimitedResult(code)
	SurvivalModule.StartChallengeUnlimitedResult()
end

function net_survival.endChallengeUnlimitedResult(code, id, boss, getItems)
	SurvivalModule.EndChallengeUnlimitedResult(id, boss, getItems)
end

function net_survival.selectDialogResult(code, nextDialogCid)
	SurvivalModule.SelectDialogResult(nextDialogCid)
end

function net_survival.notifyOpenDialog(dialogCid)
	SurvivalModule.NotifyOpenDialog(dialogCid)
end

function net_survival.notifyUpdateSurvivalPassStatus(survivalPassStatusPOD)
	SurvivalModule.NotifyUpdateSurvivalPassStatus(survivalPassStatusPOD)
end

function net_survival.notifyDialogRewards(getItems)
	SurvivalModule.NotifyDialogRewards(getItems)
end
