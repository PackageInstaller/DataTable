-- chunkname: @modules/logic/versionactivity1_2/yaxian/model/game/YaXianGameInteractMO.lua

module("modules.logic.versionactivity1_2.yaxian.model.game.YaXianGameInteractMO", package.seeall)

local YaXianGameInteractMO = pureTable("YaXianGameInteractMO")

function YaXianGameInteractMO:init(actId, serverData)
	self.actId = actId

	self:updateMO(serverData)
end

function YaXianGameInteractMO:updateMO(serverData)
	self.id = serverData.id

	self:setXY(serverData.x, serverData.y)
	self:setDirection(serverData.direction)

	self.config = YaXianConfig.instance:getInteractObjectCo(self.actId, self.id)

	self:updateDataByJsonData(serverData.data)
end

function YaXianGameInteractMO:updateDataByJsonData(data)
	self.data = data and cjson.decode(data) or nil

	self:updateAlertArea()
	self:updateNextPos()
end

function YaXianGameInteractMO:updateDataByTableData(data)
	self.data = data

	self:updateAlertArea()
	self:updateNextPos()
end

function YaXianGameInteractMO:updateAlertArea()
	if not self.data then
		self.alertPosList = nil

		return
	end

	if not self.data.alertArea then
		self.alertPosList = nil

		return
	end

	self.alertPosList = {}

	for _, pos in ipairs(self.data.alertArea) do
		table.insert(self.alertPosList, {
			posX = pos.x,
			posY = pos.y
		})
	end
end

function YaXianGameInteractMO:updateNextPos()
	if not self.data then
		self.nextPos = nil

		return
	end

	if not self.data.nextPoint then
		self.nextPos = nil

		return
	end

	self.nextPos = {
		posX = self.data.nextPoint.x,
		posY = self.data.nextPoint.y
	}
end

function YaXianGameInteractMO:setXY(x, y)
	self.prePosX = self.posX
	self.prePosY = self.posY
	self.posX = x
	self.posY = y
end

function YaXianGameInteractMO:setDirection(direction)
	self.preDirection = self.direction
	self.direction = direction
end

return YaXianGameInteractMO
