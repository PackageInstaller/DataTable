-- chunkname: @modules/logic/survival/controller/work/step/SurvivalUnitMoveWork.lua

module("modules.logic.survival.controller.work.step.SurvivalUnitMoveWork", package.seeall)

local SurvivalUnitMoveWork = class("SurvivalUnitMoveWork", SurvivalStepBaseWork)
local moveReasonToFuncName = {
	[SurvivalEnum.PlayerMoveReason.Fly] = "flyTo",
	[SurvivalEnum.PlayerMoveReason.Transfer] = "transferTo",
	[SurvivalEnum.PlayerMoveReason.Tornado] = "tornadoTransfer",
	[SurvivalEnum.PlayerMoveReason.Swap] = "swapPos",
	[SurvivalEnum.PlayerMoveReason.Summon] = "summonPos",
	[SurvivalEnum.PlayerMoveReason.Rocket] = "rocketTo"
}

function SurvivalUnitMoveWork:onStart2(context)
	if self.context.fastExecute then
		self:onDone(true)

		return
	end

	local entity = SurvivalMapHelper.instance:getEntity(self._stepMo.id)

	if entity then
		if not self._stepMo.paramInt[1] then
			local reason = 0
			local sceneMo = SurvivalMapModel.instance:getSceneMo()

			if not entity[moveReasonToFuncName[reason]] then
				-- block empty
			end
		end
	else
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local unitMo = sceneMo and sceneMo.unitsById[self._stepMo.id]

		if not unitMo then
			logError("找不到对应实体" .. self._stepMo.id)
		else
			sceneMo:onUnitUpdatePos(unitMo, self._stepMo.position)
		end

		self:onDone(true)
	end

	::label_1_5::
end

function SurvivalUnitMoveWork:_onMoveFinish()
	if self._stepMo.id == 0 then
		local camera = SurvivalMapHelper.instance:getSceneCameraComp()

		if camera and camera:checkIsInMiasma() then
			self:doRotateCameraTween()

			return
		end
	end

	self:onDone(true)
end

function SurvivalUnitMoveWork:doRotateCameraTween()
	local moveTarget = SurvivalMapModel.instance:getTargetPos()

	if moveTarget ~= self._stepMo.position then
		SurvivalMapModel.instance:setMoveToTarget()
		SurvivalMapModel.instance:setShowTarget()
	end

	if SurvivalMapHelper.instance:tweenToHeroPosIfNeed(0.2) then
		TaskDispatcher.runDelay(self._playCameraRotate, self, 0.2)
	else
		self:_playCameraRotate()
	end
end

function SurvivalUnitMoveWork:_playCameraRotate()
	local camera = SurvivalMapHelper.instance:getSceneCameraComp()

	if camera then
		UIBlockHelper.instance:startBlock("SurvivalUnitMoveWork_playCameraRotate", SurvivalConst.CameraTraceTime)

		local isInMiasma = SurvivalMapModel.instance:isInMiasma()
		local dir = isInMiasma and math.random(5) or 0

		if dir > 2 then
			dir = dir - 6
		end

		camera:setRotate(dir * 60)
		TaskDispatcher.runDelay(self._delayOnDone, self, SurvivalConst.CameraTraceTime)
	else
		self:onDone(true)
	end
end

function SurvivalUnitMoveWork:_delayOnDone()
	self:onDone(true)
end

function SurvivalUnitMoveWork:clearWork()
	TaskDispatcher.cancelTask(self._playCameraRotate, self)
	TaskDispatcher.cancelTask(self._delayOnDone, self)
end

function SurvivalUnitMoveWork:getRunOrder(params, flow)
	if params.moveIdSet[self._stepMo.id] then
		params.beforeFlow = FlowParallel.New()

		flow:addWork(params.beforeFlow)

		params.moveIdSet = {}
	end

	if self._stepMo.id == 0 then
		params.haveHeroMove = true
	end

	params.moveIdSet[self._stepMo.id] = true

	return SurvivalEnum.StepRunOrder.Before
end

return SurvivalUnitMoveWork
