-- chunkname: @modules/logic/versionactivity4_0/concertlimit/model/ConcertLimitModel.lua

module("modules.logic.versionactivity4_0.concertlimit.model.ConcertLimitModel", package.seeall)

local ConcertLimitModel = class("ConcertLimitModel", BaseModel)

function ConcertLimitModel:onInit()
	self:reInit()
end

function ConcertLimitModel:reInit()
	return
end

ConcertLimitModel.instance = ConcertLimitModel.New()

return ConcertLimitModel
