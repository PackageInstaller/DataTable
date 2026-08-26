-- chunkname: @modules/logic/rouge2/map/model/rpcmo/Rouge2_EntrustInfoMO.lua

module("modules.logic.rouge2.map.model.rpcmo.Rouge2_EntrustInfoMO", package.seeall)

local Rouge2_EntrustInfoMO = pureTable("Rouge2_EntrustInfoMO")

function Rouge2_EntrustInfoMO:init(info)
	self._id = info.id
	self._count = info.count
	self._finish = info.finish
	self._type = info.type
end

function Rouge2_EntrustInfoMO:getEntrustId()
	return self._id
end

function Rouge2_EntrustInfoMO:getProgress()
	return self._count
end

function Rouge2_EntrustInfoMO:isFinish()
	return self._finish
end

return Rouge2_EntrustInfoMO
