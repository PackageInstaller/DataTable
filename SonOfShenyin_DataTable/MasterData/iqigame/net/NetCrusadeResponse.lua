-- chunkname: @IQIGame\\Net\\NetCrusadeResponse.lua

function net_crusadeDup.receiveCrusadeResult(code)
	EventDispatcher.Dispatch(EventID.ReceiveCrusadeResultEvent)
end

function net_crusadeDup.enterDupResult(code)
	return
end

function net_crusadeDup.notifyAddDup(dups)
	for i, v in pairs(dups) do
		PlayerModule.PlayerInfo.crusadeDupPODs[i] = v
	end

	EventDispatcher.Dispatch(EventID.WorldDailyHuntUIRefresh)
end

function net_crusadeDup.notifyUpdateDup(dup)
	for i, v in pairs(PlayerModule.GetCrusadeData()) do
		if v.index == dup.index then
			PlayerModule.PlayerInfo.crusadeDupPODs[i] = dup

			break
		end
	end

	EventDispatcher.Dispatch(EventID.WorldDailyHuntUIRefresh)
end
