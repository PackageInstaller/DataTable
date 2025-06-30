-- chunkname: @IQIGame\\Module\\Fondle\\FondleModule.lua

FondleModule = {}

function FondleModule.AddEventListener()
	FondleModule.RemoveEventListener()
	GameEntry.LuaEvent:Subscribe(L2DPlayActionEventArgs.EventId, FondleModule.OnL2DPlayActionEvent)
end

function FondleModule.RemoveEventListener()
	GameEntry.LuaEvent:Unsubscribe(L2DPlayActionEventArgs.EventId, FondleModule.OnL2DPlayActionEvent)
end

function FondleModule.ReloadFondle(fondleNum, nextRecoveryFondleTime)
	FondleModule.AddEventListener()

	FondleModule.fondleMaxNum = CfgDiscreteDataTable[6506010].Data[1]
	FondleModule.fondleNum = fondleNum
	FondleModule.nextRecoveryFondleNumTime = nextRecoveryFondleTime
end

function FondleModule.OnL2DPlayActionEvent(sender, args)
	local cfgAction

	if args.actionId ~= nil and args.actionId > 0 then
		cfgAction = CfgSoulActionTable[args.actionId]
	end
end

function FondleModule.Fondle(soulCid)
	local soulData = SoulModule.GetSoulData(soulCid)

	FondleModule.lastFavorLv = soulData.favorLv

	net_girl.fondle(soulCid)
end

function FondleModule.FondleResult(soulCid, actionCid, addFavor, dislike, fondleNum)
	local soulData = SoulModule.GetSoulData(soulCid)

	soulData.dailyDislike = dislike
	FondleModule.fondleNum = fondleNum

	local isFavorUp = soulData.favorLv > FondleModule.lastFavorLv

	if isFavorUp then
		GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.FavorUp))
	end

	EventDispatcher.Dispatch(EventID.FondleResultSuccess, actionCid, addFavor, isFavorUp)
	EventDispatcher.Dispatch(EventID.FondleNumChange)
end

function FondleModule.NotifyFondleNumRecovery(fondleNum, nextRecoveryFondleNumTime)
	FondleModule.fondleNum = fondleNum
	FondleModule.nextRecoveryFondleNumTime = nextRecoveryFondleNumTime

	EventDispatcher.Dispatch(EventID.FondleNumChange)
end

function FondleModule.Shutdown()
	FondleModule.RemoveEventListener()
end
