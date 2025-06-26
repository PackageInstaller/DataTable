-- chunkname: @IQIGame\\Net\\NetOperationsPandaResponse.lua

function net_operationsPanda.actionResult(code, actionType, addFavor, favorNum, maxFavorNum, getItems)
	ActivePandaModule.ActionResult(actionType, addFavor, favorNum, maxFavorNum, getItems)
end

function net_operationsPanda.getGiftResult(code, giftId, itemShows)
	ActivePandaModule.GetGiftResult(giftId, itemShows)
end

function net_operationsPanda.enterBambooForestResult(code, events, currDialog)
	ActivePandaModule.EnterBambooForestResult(events, currDialog)
end

function net_operationsPanda.exploreResult(code, events)
	ActivePandaModule.ExploreResult(events)
end

function net_operationsPanda.doEventResult(code, eventId, params)
	ActivePandaModule.DoEventResult(eventId, params)
end

function net_operationsPanda.notifyCompleteEvent(eventId, itemShows)
	ActivePandaModule.NotifyCompleteEvent(eventId, itemShows)
end

function net_operationsPanda.notifyFightComplete(eventId, win, itemShows)
	ActivePandaModule.NotifyFightComplete(eventId, win, itemShows)
end

function net_operationsPanda.selectDialogResult(code, nextDialogCid)
	ActivePandaModule.currDialog = nextDialogCid

	EventDispatcher.Dispatch(EventID.JumpToNextDialog, nextDialogCid)
end

function net_operationsPanda.notifyOpenDialog(dialogCid)
	DialogModule.OpenDialog(dialogCid, false, true)
end
