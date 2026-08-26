-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepMoveWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepMoveWork", package.seeall)

local SodacheStepMoveWork = class("SodacheStepMoveWork", SodacheStepBaseWork)

function SodacheStepMoveWork:onWorkStart(context)
	local uid = self._stepMo.paramLong[1]
	local newPos = self._stepMo.paramInt[1]
	local subPosId = self._stepMo.paramInt[2]
	local reason = self._stepMo.paramInt[3]

	if uid == "0" then
		context.isPlayerMove = true
	end

	local insideMo = SodacheModel.instance:getInsideMo()

	if not insideMo then
		self:onDone(true)

		return
	end

	if uid ~= "0" and not insideMo.unitBox.unitsMap[uid] then
		self:onDone(true)

		return
	end

	if SodacheModel.instance.____gmfastrun then
		insideMo.unitDirty = true

		if uid == "0" then
			insideMo.player.locationId = newPos
			insideMo.player.locationNo = subPosId
		else
			insideMo.unitBox.unitsMap[uid].locationId = newPos
			insideMo.unitBox.unitsMap[uid].locationNo = subPosId
		end

		self:onDone(true)

		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnUnitMoveStep, uid, newPos, subPosId, reason, self._onMoveEnd, self)
end

function SodacheStepMoveWork:_onMoveEnd()
	SodacheMapUtil.setUnitDataDirty()
	SodacheController.instance:dispatchEvent(SodacheEvent.OnUnitMoveStepEnd)
	self:onDone(true)
end

return SodacheStepMoveWork
