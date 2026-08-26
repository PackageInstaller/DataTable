-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballResMineEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballResMineEntity", package.seeall)

local PinballResMineEntity = class("PinballResMineEntity", PinballResEntity)

function PinballResMineEntity:onHitEnter(hitEntityId, hitX, hitY, hitDir)
	local hitEntity = PinballEntityMgr.instance:getEntity(hitEntityId)

	if not hitEntity then
		return
	end

	if hitEntity:isResType() then
		hitEntity:doHit(1)
	end
end

function PinballResMineEntity:onHitCount(hitNum)
	hitNum = hitNum or 1
	self.totalHitCount = self.totalHitCount - hitNum

	if self.linkEntity then
		self.linkEntity.totalHitCount = self.linkEntity.totalHitCount - hitNum
	end

	if self.totalHitCount <= 0 then
		PinballModel.instance:addGameRes(self.resType, self.resNum)
		PinballEntityMgr.instance:addNumShow(self.resNum, self.x + self.width, self.y + self.height)
		PinballEntityMgr.instance:removeEntity(self.id)
	end
end

function PinballResMineEntity:onCreateLinkEntity(linkEntity)
	linkEntity.totalHitCount = self.totalHitCount
end

function PinballResMineEntity:onInitByCo()
	local arr = string.splitToNumber(self.spData, "#") or {}

	self.totalHitCount = arr[1] or 0
	self.resNum = arr[2] or 0
end

return PinballResMineEntity
