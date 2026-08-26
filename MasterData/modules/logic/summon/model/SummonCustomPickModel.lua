-- chunkname: @modules/logic/summon/model/SummonCustomPickModel.lua

module("modules.logic.summon.model.SummonCustomPickModel", package.seeall)

local SummonCustomPickModel = class("SummonCustomPickModel", BaseModel)

function SummonCustomPickModel:isCustomPickOver(poolId)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(poolId)

	if summonServerMO and summonServerMO.customPickMO then
		return summonServerMO.customPickMO:isPicked(poolId)
	end

	return false
end

function SummonCustomPickModel:isHaveFirstSSR(poolId)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(poolId)

	if summonServerMO and summonServerMO.customPickMO then
		return summonServerMO.customPickMO:isHaveFirstSSR()
	end

	return false
end

function SummonCustomPickModel:getMaxSelectCount(poolId)
	local summonPoolCfg = SummonConfig.instance:getSummonPool(poolId)
	local maxSelectCount = -1

	if summonPoolCfg then
		if summonPoolCfg.type == SummonEnum.Type.StrongCustomOnePick then
			maxSelectCount = 1
		else
			local splitStrs = string.split(summonPoolCfg.param, "|")

			if splitStrs and #splitStrs > 0 then
				maxSelectCount = tonumber(splitStrs[1]) or 0
			end
		end
	end

	return maxSelectCount
end

SummonCustomPickModel.instance = SummonCustomPickModel.New()

return SummonCustomPickModel
