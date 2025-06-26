-- chunkname: @IQIGame\\Net\\NetDatingResponse.lua

function net_dating.datingResult(code, soulCid, chooseCid)
	return
end

function net_dating.notifyDatingEnd(soulCid, eventCid, getItems, favorData)
	DatingModule.NotifyDatingEnd(soulCid, eventCid, getItems, favorData)
end

function net_dating.notifyDating(soulCid, datingRecord)
	DatingModule.NotifyDating(soulCid, datingRecord)
end
