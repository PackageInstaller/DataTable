-- chunkname: @modules/logic/activity/model/chessmap/ActivityChessGameInteractMO.lua

module("modules.logic.activity.model.chessmap.ActivityChessGameInteractMO", package.seeall)

local ActivityChessGameInteractMO = pureTable("ActivityChessGameInteractMO")

function ActivityChessGameInteractMO:init(actId, serverData)
	self.id = serverData.id
	self.actId = actId

	self:updateMO(serverData)
end

function ActivityChessGameInteractMO:updateMO(serverData)
	self.posX = serverData.x
	self.posY = serverData.y
	self.direction = serverData.direction or 6

	if not string.nilorempty(serverData.data) then
		self.data = cjson.decode(serverData.data)
	end
end

function ActivityChessGameInteractMO:setXY(x, y)
	self.posX = x
	self.posY = y
end

return ActivityChessGameInteractMO
