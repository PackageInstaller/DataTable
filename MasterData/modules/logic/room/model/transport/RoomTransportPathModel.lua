-- chunkname: @modules/logic/room/model/transport/RoomTransportPathModel.lua

module("modules.logic.room.model.transport.RoomTransportPathModel", package.seeall)

local RoomTransportPathModel = class("RoomTransportPathModel", BaseModel)

function RoomTransportPathModel:onInit()
	self:_clearData()
end

function RoomTransportPathModel:reInit()
	self:_clearData()
end

function RoomTransportPathModel:clear()
	RoomTransportPathModel.super.clear(self)
	self:_clearData()
end

function RoomTransportPathModel:_clearData()
	return
end

function RoomTransportPathModel:initPath(roadInfos)
	RoomTransportHelper.initTransportPathModel(self, roadInfos)
end

function RoomTransportPathModel:removeByIds(ids)
	if ids and #ids > 0 then
		for _, id in ipairs(ids) do
			local mo = self:getById(id)

			self:remove(mo)
		end
	end
end

function RoomTransportPathModel:updateInofoById(id, info)
	local parthMO = self:getById(id)

	if parthMO and info then
		parthMO:updateInfo(info)
	end
end

function RoomTransportPathModel:getTransportPathMO(id)
	return self:getById(id)
end

function RoomTransportPathModel:getTransportPathMOList()
	return self:getList()
end

function RoomTransportPathModel:setIsJumpTransportSite(isJump)
	self._isJumpTransportSite = isJump
end

function RoomTransportPathModel:getisJumpTransportSite()
	return self._isJumpTransportSite
end

RoomTransportPathModel.instance = RoomTransportPathModel.New()

return RoomTransportPathModel
