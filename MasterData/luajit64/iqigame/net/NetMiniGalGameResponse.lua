-- chunkname: @IQIGame\\Net\\NetMiniGalGameResponse.lua

function net_miniGalGame.startNewGameResult(code, pod)
	MonsterAcademyModule.StartNewGameResult(pod)
end

function net_miniGalGame.loadGameResult(code, pod)
	MonsterAcademyModule.LoadGameResult(pod)
end

function net_miniGalGame.saveGameResult(code)
	MonsterAcademyModule.SaveGameResult()
end

function net_miniGalGame.selectDialogResult(code, nextDialogId)
	MonsterAcademyModule.SelectDialogResult(nextDialogId)
end

function net_miniGalGame.shopBuyResult(code)
	MonsterAcademyModule.ShopBuyResult()
end

function net_miniGalGame.towerFightResult(code, towerMonsterId, fightStatus, rewards)
	MonsterAcademyModule.TowerFightResult(towerMonsterId, fightStatus, rewards)
end

function net_miniGalGame.itemUseResult(code)
	MonsterAcademyModule.ItemUseResult()
end

function net_miniGalGame.submitMiniGameOverResult(code, rewards)
	MonsterAcademyModule.SubmitMiniGameOverResult(rewards)
end

function net_miniGalGame.triggerEventResult(code)
	MonsterAcademyModule.TriggerEventResult()
end

function net_miniGalGame.triggerEventResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 48006 then
			NoticeModule.ShowNotice(21045053)

			return
		elseif code == 48010 then
			NoticeModule.ShowNotice(21045054)

			return
		end

		NoticeModule.ShowServerError(code)

		return
	end

	net_miniGalGame.triggerEventResult(code)
end

function net_miniGalGame.callFromGirlResult(code)
	MonsterAcademyModule.CallFromGirlResult()
end

function net_miniGalGame.notifyOpenDialog(dialogId, dynamicType, dynamicValue)
	MonsterAcademyModule.NotifyOpenDialog(dialogId, dynamicType, dynamicValue)
end

function net_miniGalGame.notifyGalItemsStatus(items)
	MonsterAcademyModule.NotifyGalItemsStatus(items)
end

function net_miniGalGame.notifyGalTaskFinish(taskId, rewards)
	MonsterAcademyModule.NotifyGalTaskFinish(taskId, rewards)
end

function net_miniGalGame.notifyGalMiniGameStart(type, gameId)
	MonsterAcademyModule.NotifyGalMiniGameStart(type, gameId)
end

function net_miniGalGame.notifyFight(fightId, win, rewards)
	MonsterAcademyModule.NotifyFight(fightId, win, rewards)
end

function net_miniGalGame.notifyGalShop(shopRecord)
	MonsterAcademyModule.NotifyGalShop(shopRecord)
end

function net_miniGalGame.notifyGalGirlsData(girls)
	MonsterAcademyModule.NotifyGalGirlsData(girls)
end

function net_miniGalGame.notifyGalBaseData(base)
	MonsterAcademyModule.NotifyGalBaseData(base)
end

function net_miniGalGame.notifyUpdateSaveData(podList)
	MonsterAcademyModule.NotifyUpdateSaveData(podList)
end

function net_miniGalGame.notifyScheduleList(scheduleList)
	MonsterAcademyModule.NotifyScheduleList(scheduleList)
end

function net_miniGalGame.notifyCallFromGirl(girl)
	MonsterAcademyModule.NotifyCallFromGirl(girl)
end

function net_miniGalGame.notifyEventTriggeredCount(eventCount)
	MonsterAcademyModule.NotifyEventTriggeredCount(eventCount)
end

function net_miniGalGame.notifyAchievementData(achievementData)
	MonsterAcademyModule.NotifyAchievementData(achievementData)
end

function net_miniGalGame.notifyLocalAchievementData(achievementData)
	MonsterAcademyModule.NotifyLocalAchievementData(achievementData)
end

function net_miniGalGame.notifyItemUsedCount(itemUsedCount)
	MonsterAcademyModule.NotifyItemUsedCount(itemUsedCount)
end

function net_miniGalGame.notifyComplete(saveIdx, functionId)
	MonsterAcademyModule.NotifyComplete(saveIdx, functionId)
end

function net_miniGalGame.sendMessageResult(code, messageId, girlId)
	MonsterAcademyModule.SendMessageResult(messageId, girlId)
end

function net_miniGalGame.notifyMessageFromGirl(girlId, pod)
	MonsterAcademyModule.NotifyMessageFromGirl(girlId, pod)
end

function net_miniGalGame.notifyMessageGroupCount(MessageGroupCount)
	MonsterAcademyModule.NotifyMessageGroupCount(MessageGroupCount)
end
