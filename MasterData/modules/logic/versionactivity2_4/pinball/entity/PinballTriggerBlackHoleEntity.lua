-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballTriggerBlackHoleEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerBlackHoleEntity", package.seeall)

local PinballTriggerBlackHoleEntity = class("PinballTriggerBlackHoleEntity", PinballTriggerEntity)

function PinballTriggerBlackHoleEntity:onInitByCo()
	self.groupId = tonumber(self.spData) or 0
end

function PinballTriggerBlackHoleEntity:init(go)
	PinballTriggerBlackHoleEntity.super.init(self, go)

	local effect = gohelper.findChild(go, "vx_blackhole")

	gohelper.setActive(effect, true)
end

function PinballTriggerBlackHoleEntity:isBounce()
	return false
end

function PinballTriggerBlackHoleEntity:onHitEnter(hitEntityId, hitX, hitY, hitDir)
	local hitEntity = PinballEntityMgr.instance:getEntity(hitEntityId)

	if not hitEntity or hitEntity.inBlackHoleId then
		return
	end

	local otherBalckHoleEntity

	for k, entity in pairs(PinballEntityMgr.instance:getAllEntity()) do
		if entity ~= self and entity.unitType == self.unitType and entity.groupId == self.groupId then
			otherBalckHoleEntity = entity

			break
		end
	end

	if otherBalckHoleEntity then
		hitEntity.x = otherBalckHoleEntity.x
		hitEntity.y = otherBalckHoleEntity.y

		hitEntity:tick(0)

		hitEntity.inBlackHoleId = self.id

		hitEntity:onEnterHole()
	end
end

function PinballTriggerBlackHoleEntity:onHitExit(hitEntityId)
	local hitEntity = PinballEntityMgr.instance:getEntity(hitEntityId)

	if not hitEntity or not hitEntity.inBlackHoleId or hitEntity.inBlackHoleId == self.id then
		return
	end

	hitEntity.inBlackHoleId = nil

	hitEntity:onExitHole()
end

return PinballTriggerBlackHoleEntity
