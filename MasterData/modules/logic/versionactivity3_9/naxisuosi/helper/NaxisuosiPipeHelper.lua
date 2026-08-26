-- chunkname: @modules/logic/versionactivity3_9/naxisuosi/helper/NaxisuosiPipeHelper.lua

module("modules.logic.versionactivity3_9.naxisuosi.helper.NaxisuosiPipeHelper", package.seeall)

local NaxisuosiPipeHelper = {}

function NaxisuosiPipeHelper.getRotation(typeId, value)
	local dict = NaxisuosiPipeEnum.rotate[typeId]

	return (dict and dict[value] or nil) and (dict[value][1] or 0)
end

function NaxisuosiPipeHelper._getRes(typeId, index, argsRes)
	local result

	if argsRes then
		local dict = argsRes[typeId]

		result = dict and dict[index]

		if not string.nilorempty(result) then
			return result, true
		end
	end

	local dict = NaxisuosiPipeEnum.res[typeId]

	return dict and dict[index]
end

function NaxisuosiPipeHelper.getBackgroundRes(typeId, argsRes)
	return NaxisuosiPipeHelper._getRes(typeId, 1, argsRes)
end

function NaxisuosiPipeHelper.getConnectRes(typeId, argsRes)
	return NaxisuosiPipeHelper._getRes(typeId, 2, argsRes)
end

function NaxisuosiPipeHelper.getErrorRes(typeId, argsRes)
	return NaxisuosiPipeHelper._getRes(typeId, 3, argsRes)
end

function NaxisuosiPipeHelper.getResByStatus(typeId, status, mapType, argsRes)
	return NaxisuosiPipeHelper._getRes(typeId, (status == NaxisuosiPipeEnum.LineStatus.Connect or nil) and (NaxisuosiPipeEnum.connectResIndex[mapType] or 2), argsRes)
end

return NaxisuosiPipeHelper
