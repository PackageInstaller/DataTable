-- chunkname: @IQIGame\\Net\\NetRichManResponse.lua

function net_richMan.richManResult(code, randSum, shows)
	EventDispatcher.Dispatch(EventID.NetRichMamResultEvent, randSum, shows)
	EventDispatcher.Dispatch(EventID.ActivityUpdateEvent)
end

function net_richMan.notityRichMan(richManPOD)
	PlayerModule.PlayerInfo.richManPOD = richManPOD

	EventDispatcher.Dispatch(EventID.DiceGameRefreshEvent)
	EventDispatcher.Dispatch(EventID.ActivityUpdateEvent)
end

function net_richMan.notityRemoveRichMan(richManPOD)
	PlayerModule.PlayerInfo.richManPOD = richManPOD

	EventDispatcher.Dispatch(EventID.NotifyRemoveRichManEvent)
	EventDispatcher.Dispatch(EventID.ActivityUpdateEvent)
end
