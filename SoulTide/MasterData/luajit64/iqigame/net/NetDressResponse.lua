-- chunkname: @IQIGame\\Net\\NetDressResponse.lua

function net_dress.wearResult(code)
	DressModule.OnResultWearDress()
end

function net_dress.viewDressResult(code)
	return
end

function net_dress.notifyUpdateDress(type, dressPOD)
	DressModule.OnNotifyUpdateDress(type, dressPOD)
end
