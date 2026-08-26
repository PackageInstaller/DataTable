-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballResWoodEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballResWoodEntity", package.seeall)

local PinballResWoodEntity = class("PinballResWoodEntity", PinballResEntity)

function PinballResWoodEntity:isBounce()
	return false
end

function PinballResWoodEntity:onHitEnter(hitEntityId, hitX, hitY, hitDir)
	local hitEntity = PinballEntityMgr.instance:getEntity(hitEntityId)

	if not hitEntity then
		return
	end

	hitEntity.vx = hitEntity.vx * (1 - self.decv)
	hitEntity.vy = hitEntity.vy * (1 - self.decv)
end

function PinballResWoodEntity:onHitCount()
	PinballModel.instance:addGameRes(self.resType, self.resNum)
	PinballEntityMgr.instance:addNumShow(self.resNum, self.x + self.width, self.y + self.height)
	self:markDead()
end

function PinballResWoodEntity:onInitByCo()
	local arr = string.splitToNumber(self.spData, "#") or {}

	self.resNum = arr[1] or 0
	self.decv = (arr[2] or 0) / 1000
	self.decv = Mathf.Clamp(self.decv, 0, 1)
end

return PinballResWoodEntity
