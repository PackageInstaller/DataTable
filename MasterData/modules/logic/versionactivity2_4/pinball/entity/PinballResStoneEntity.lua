-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballResStoneEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballResStoneEntity", package.seeall)

local PinballResStoneEntity = class("PinballResStoneEntity", PinballResEntity)

function PinballResStoneEntity:onHitCount()
	PinballModel.instance:addGameRes(self.resType, self.resNum)
	PinballEntityMgr.instance:addNumShow(self.resNum, self.x + self.width, self.y + self.height)
	PinballEntityMgr.instance:removeEntity(self.id)
end

function PinballResStoneEntity:onInitByCo()
	self.resNum = tonumber(self.spData) or 0
end

return PinballResStoneEntity
