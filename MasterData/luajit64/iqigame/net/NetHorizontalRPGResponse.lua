-- chunkname: @IQIGame\\Net\\NetHorizontalRPGResponse.lua

function net_horizontalRPG.elementExecutionResult(code)
	HorizontalRPGModule.ElementExecutionResult()
end

function net_horizontalRPG.elementExecutionElseResult(code)
	HorizontalRPGModule.ElementExecutionElseResult()
end

function net_horizontalRPG.combatTrainingResult(code)
	HorizontalRPGModule.CombatTrainingResult()
end

function net_horizontalRPG.bossTrainingResult(code)
	HorizontalRPGModule.BossTrainingResult()
end

function net_horizontalRPG.quickChallengeResult(code, items)
	HorizontalRPGModule.QuickChallengeResult(items)
end

function net_horizontalRPG.challengeResult(code, levelCid, mazePOD, horizontalRPGMapPOD, levelDialogCid)
	HorizontalRPGModule.ChallengeResult(levelCid, mazePOD, horizontalRPGMapPOD, levelDialogCid)
end

function net_horizontalRPG.selectLevelDialogResult(code, nextDialogCid)
	HorizontalRPGModule.SelectLevelDialogResult(nextDialogCid)
end

function net_horizontalRPG.selectDialogResult(code, nextDialogCid)
	HorizontalRPGModule.SelectDialogResult(nextDialogCid)
end

function net_horizontalRPG.modifyWeatherResult(code, state)
	HorizontalRPGModule.ModifyWeatherResult(state)
end

function net_horizontalRPG.notifyCombatTrainingBossEnd(win, cid, dmgRecords, items, openExBoss, freeBossNumber, ticks)
	HorizontalRPGModule.NotifyCombatTrainingBossEnd(win, cid, dmgRecords, items, openExBoss, freeBossNumber, ticks)
end

function net_horizontalRPG.notifyBossTraining(win, cid, dmgRecords)
	HorizontalRPGModule.NotifyBossTraining(win, cid, dmgRecords)
end

function net_horizontalRPG.notifyBossUnlock(boss)
	HorizontalRPGModule.NotifyBossUnlock(boss)
end

function net_horizontalRPG.notifyTicketsUpdate(value)
	HorizontalRPGModule.NotifyTicketsUpdate(value)
end

function net_horizontalRPG.notifyElementExecution(horizontalRPGResPods)
	HorizontalRPGModule.NotifyElementExecution(horizontalRPGResPods)
end

function net_horizontalRPG.notifyCMD(horizontalRPGPOD)
	HorizontalRPGModule.NotifyCMD(horizontalRPGPOD)
end

function net_horizontalRPG.notifyFinnishLevels(cid)
	HorizontalRPGModule.NotifyFinnishLevels(cid)
end

function net_horizontalRPG.notifyUnlockedDifficulty(difficulty)
	HorizontalRPGModule.NotifyUnlockedDifficulty(difficulty)
end

function net_horizontalRPG.notifyChallengeFightEnd(win, levelCid, dmgRecords, items)
	HorizontalRPGModule.NotifyChallengeFightEnd(win, levelCid, dmgRecords, items)
end

function net_horizontalRPG.notifyChallengeStoryFinished(levelCid, items)
	HorizontalRPGModule.NotifyChallengeStoryFinished(levelCid, items)
end

function net_horizontalRPG.notifyHRPGFinished(levelCid, items)
	HorizontalRPGModule.NotifyHRPGFinished(levelCid, items)
end
