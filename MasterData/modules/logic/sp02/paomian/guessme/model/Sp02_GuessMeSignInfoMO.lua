-- chunkname: @modules/logic/sp02/paomian/guessme/model/Sp02_GuessMeSignInfoMO.lua

module("modules.logic.sp02.paomian.guessme.model.Sp02_GuessMeSignInfoMO", package.seeall)

local Sp02_GuessMeSignInfoMO = pureTable("Sp02_GuessMeSignInfoMO")

function Sp02_GuessMeSignInfoMO:init(info)
	self._id = info.id
	self._status = info.status
end

function Sp02_GuessMeSignInfoMO:getStatus()
	return self._status
end

function Sp02_GuessMeSignInfoMO:getId()
	return self._id
end

return Sp02_GuessMeSignInfoMO
