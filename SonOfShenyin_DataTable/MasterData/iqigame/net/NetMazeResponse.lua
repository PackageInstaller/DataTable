-- chunkname: @IQIGame\\Net\\NetMazeResponse.lua

function net_mazeDup.wearGemstoneResult(code, seatId)
	MazeModule.wearGemstoneResult(seatId)
end

function net_mazeDup.takeOffGemstoneResult(code, seatId)
	MazeModule.takeOffGemstoneResult(seatId)
end

function net_mazeDup.upgradeOrbmentResult(code)
	MazeModule.upgradeOrbmentResult()
end

function net_mazeDup.selectSeatEffectResult(code, seatId)
	MazeModule.selectSeatEffectResult(seatId)
end

function net_mazeDup.cancelSeatEffectResult(code, seatId)
	MazeModule.cancelSeatEffectResult(seatId)
end

function net_mazeDup.unlockSeatResult(code, seatId)
	MazeModule.unlockSeatResult(seatId)
end

function net_mazeDup.enterMazeDupResult(code, mazeStagePOD)
	MazeModule.enterMazeDupResult(mazeStagePOD)
end

function net_mazeDup.claimProgressAwardResult(code, items)
	MazeModule.claimProgressAwardResult(items)
end

function net_mazeDup.notifyOrbmentPOD(orbmentPOD)
	MazeModule.notifyOrbmentPOD(orbmentPOD)
end

function net_mazeDup.notifyMazeDup(mazeStagePOD)
	MazeModule.notifyMazeDup(mazeStagePOD)
	MazeStageModule.notifyMazeDup(mazeStagePOD)
end

function net_mazeDup.chageFormationPODResult(code)
	MazeModule.chageFormationPODResult()
end

function net_mazeDup.finishMazeStageResult()
	MazeModule.finishMazeStageResult()
end

function net_labyrinth.enterStageResult(code, labyrinthStagePOD)
	MazeModule.OnEnterStageResult(labyrinthStagePOD)
end

function net_labyrinth.startEnterRoomResult(code, stageMapPOD)
	MazeModule.OnStartEnterRoomResult(stageMapPOD)
end

function net_labyrinth.enterRoomFinishResult(code, stageMapPOD, animation)
	MazeModule.OnEnterRoomFinishResult(stageMapPOD, animation)
end

function net_labyrinth.updateLabyrinthDataPOD(labyrinthDataPOD)
	MazeModule.OnUpdateLabyrinthDataPOD(labyrinthDataPOD)
end

function net_labyrinth.updateLabyrinthStagePOD(labyrinthStagePOD)
	MazeModule.OnUpdateLabyrinthStagePOD(labyrinthStagePOD)
end

function net_labyrinth.updateStageMapPOD(stageMapPOD)
	MazeModule.OnUpdateStageMapPOD(stageMapPOD)
end

function net_labyrinth.eventFinishResult(code, stageMapPOD)
	MazeModule.OnEventFinishResult(stageMapPOD)
end

function net_labyrinth.notifyStageExit(stageId)
	MazeModule.OnNotifyStageExit(stageId)
end

function net_labyrinth.exitStageResult(code, difficulty, itemShows)
	MazeModule.OnExitStageResult(difficulty, itemShows)
end

function net_labyrinth.chageFormationPODResult()
	MazeModule.OnChangeFormationPODResult()
end

function net_labyrinth.selectBuffResult(code, stageEventPOD)
	MazeModule.OnSelectBuffResult(stageEventPOD)
end

function net_labyrinth.updateLabyrinthWarehouse(updateItems)
	MazeModule.OnUpdateLabyrinthWarehouse(updateItems)
end

function net_labyrinth.addLabyrinthWarehouse(updateItems)
	MazeModule.OnUpdateLabyrinthWarehouse(updateItems)
end

function net_labyrinth.removeLabyrinthWarehouse(cidList)
	MazeModule.OnRemoveLabyrinthWarehouse(cidList)
end

function net_labyrinth.blackMarketUpgradeResult(code, level)
	MazeModule.OnBlackMarketUpgradeResult(level)
end

function net_labyrinth.updateStageWarehouse(updateItems)
	MazeModule.OnUpdateStageWarehouse(updateItems)
end

function net_labyrinth.useLabyrinthItemResult(code, itemShows)
	MazeModule.OnUseLabyrinthItemResult(itemShows)
end

function net_labyrinth.upgradeSenroResult(code, senroPOD, itemShows)
	MazeModule.OnUpgradeSenroResult(senroPOD, itemShows)
end

function net_labyrinth.resetSenroResult(code, senroPOD, itemShows)
	MazeModule.OnResetSenroResult(senroPOD, itemShows)
end

function net_labyrinth.activeSenroTalentResult(code, senroPOD)
	MazeModule.OnActiveSenroTalentResult(senroPOD)
end

function net_labyrinth.upgradeSenroTalentResult(code, senroTalentPOD)
	MazeModule.OnUpgradeSenroTalentResult(senroTalentPOD)
end

function net_labyrinth.updateLabyrinthHerosAndFormation(heroPods, formationPOD)
	MazeModule.OnUpdateLabyrinthHerosAndFormation(heroPods, formationPOD)
end

function net_labyrinth.freshStageResult(code, labyrinthDataPOD)
	MazeModule.OnRefreshStageResult(labyrinthDataPOD)
end

function net_labyrinth.updateLabyrinthBuff(mapBuffs)
	MazeModule.OnUpdateLabyrinthBuff(mapBuffs)
end

function net_labyrinth.notifyTranslateItem(itemShows)
	MazeModule.OnTranslateItemResult(itemShows)
end

function net_labyrinth.setFormationResult(code, labyrinthDataPOD)
	MazeModule.SetFormationResult(labyrinthDataPOD)
end

function net_labyrinth.freshEventResult(code)
	MazeModule.OnRefreshEventResult()
end

function net_labyrinth.holdEventResult(code, stageEventPOD, curEventIndex, curOptionIndex, subOptionIndex)
	MazeModule.OnHoldEventResult(stageEventPOD, curEventIndex, curOptionIndex, subOptionIndex)
end

function net_labyrinth.submitEventResult(code, itemShows)
	MazeModule.OnSubmitEventResult(itemShows)
end

function net_labyrinth.updateStageEventLink(stageEventLinkPOD)
	MazeModule.OnUpdateStageEventLinkResult(stageEventLinkPOD)
end

function net_labyrinth.notifyTranslateRoom(curRoomId, nextRoomId)
	MazeModule.OnTranslateEventResult(curRoomId, nextRoomId)
end

function net_labyrinth.freshBuffResult(code, buffFreshTime, buffs)
	MazeModule.OnRefreshBuffResult(buffFreshTime, buffs)
end
