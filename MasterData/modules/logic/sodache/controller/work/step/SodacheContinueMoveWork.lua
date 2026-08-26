-- chunkname: @modules/logic/sodache/controller/work/step/SodacheContinueMoveWork.lua

module("modules.logic.sodache.controller.work.step.SodacheContinueMoveWork", package.seeall)

local SodacheContinueMoveWork = class("SodacheContinueMoveWork", BaseWork)

function SodacheContinueMoveWork:onStart(context)
	if SodacheModel.instance.____gmfastrun then
		self:onDone(true)

		return
	end

	if not context.isEnd and not SodacheMapUtil.haveTriggerEvent() then
		SodacheMapUtil.instance:tryMoveNextPath()
	else
		SodacheMapUtil.instance:setMovePaths()
	end

	self:onDone(true)
end

return SodacheContinueMoveWork
