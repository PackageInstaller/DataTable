-- chunkname: @modules/logic/sp02/paomian/marcus/model/Sp02_MarcusBonusInfoMO.lua

module("modules.logic.sp02.paomian.marcus.model.Sp02_MarcusBonusInfoMO", package.seeall)

local Sp02_MarcusBonusInfoMO = pureTable("Sp02_MarcusBonusInfoMO")

function Sp02_MarcusBonusInfoMO:init(info)
	self._id = info.id
	self._status = info.status
end

function Sp02_MarcusBonusInfoMO:getStatus()
	return self._status
end

function Sp02_MarcusBonusInfoMO:getId()
	return self._id
end

return Sp02_MarcusBonusInfoMO
