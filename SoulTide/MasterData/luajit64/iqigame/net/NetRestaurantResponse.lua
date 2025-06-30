-- chunkname: @IQIGame\\Net\\NetRestaurantResponse.lua

function net_restaurant.getRestaurantInfoResult(code, restaurantOperationAttributePOD)
	RestaurantOperationModule.GetRestaurantInfoResult(restaurantOperationAttributePOD)
end

function net_restaurant.transactDocumentsResult(code, positionInformationPOD)
	RestaurantOperationModule.TransactDocumentsResult(positionInformationPOD)
end

function net_restaurant.practiceResult(code, positionInformationPOD, beforeAtt, restaurantOperationAttribute)
	RestaurantOperationModule.PracticeResult(positionInformationPOD, beforeAtt, restaurantOperationAttribute)
end

function net_restaurant.levelUpResult(code, restaurantOperationAttributePOD)
	RestaurantOperationModule.LevelUpResult(restaurantOperationAttributePOD)
end

function net_restaurant.workResult(code, posts, positionInformation, post, location)
	RestaurantOperationModule.WorkResult(posts, positionInformation, post, location)
end

function net_restaurant.receiveIncomeResult(code, items)
	RestaurantOperationModule.ReceiveIncomeResult(items)
end

function net_restaurant.readBurstResult(code)
	RestaurantOperationModule.ReadBurstResult()
end

function net_restaurant.openDialogResult(code, dialogCid)
	RestaurantOperationModule.OpenDialogResult(dialogCid)
end

function net_restaurant.selectDialogResult(code, nextDialogCid)
	RestaurantOperationModule.SelectDialogResult(nextDialogCid)
end

function net_restaurant.combatTrainingResult(code)
	RestaurantOperationModule.CombatTrainingResult()
end

function net_restaurant.bossTrainingResult(code)
	RestaurantOperationModule.BossTrainingResult()
end

function net_restaurant.notifyReceiveIncome(number)
	RestaurantOperationModule.NotifyReceiveIncome(number)
end

function net_restaurant.notifyBossTraining(win, cid, dmgRecords)
	RestaurantOperationModule.NotifyBossTraining(win, cid, dmgRecords)
end

function net_restaurant.notifyCombatTrainingBossEnd(win, cid, dmgRecords, items, monster)
	RestaurantOperationModule.NotifyCombatTrainingBossEnd(win, cid, dmgRecords, items, monster)
end

function net_restaurant.notifyEventIsFinish(eventId)
	RestaurantOperationModule.NotifyEventIsFinish(eventId)
end

function net_restaurant.getProblemResult(code, restaurantOperationQuestion)
	ROAnswerGameModule.GetProblemResult(restaurantOperationQuestion)
end

function net_restaurant.answerResult(code, restaurantOperationQuestion, items)
	ROAnswerGameModule.AnswerResult(restaurantOperationQuestion, items)
end

function net_restaurant.memoryFlopInfoResult(code, restaurantOperationDraw)
	ROCardGameModule.MemoryFlopInfoResult(restaurantOperationDraw)
end

function net_restaurant.memoryFlopResult(code, restaurantOperationDraw)
	ROCardGameModule.MemoryFlopResult(restaurantOperationDraw)
end

function net_restaurant.linkGameInfoResult(code, restaurantOperationLinkGame)
	ROFruitCleanGameModule.LinkGameInfoResult(restaurantOperationLinkGame)
end

function net_restaurant.linkGameResult(code, restaurantOperationLinkGame)
	ROFruitCleanGameModule.LinkGameResult(restaurantOperationLinkGame)
end

function net_restaurant.notifyEmergency(list)
	RestaurantOperationModule.NotifyEmergency(list)
end

function net_restaurant.puzzleInfoResult(code, score)
	ROPuzzleGameModule.PuzzleInfoResult(score)
end

function net_restaurant.puzzleResult(code, score)
	ROPuzzleGameModule.PuzzleResult(score)
end

function net_restaurant.notifyEarnings(income)
	RestaurantOperationModule.NotifyEarnings(income)
end
