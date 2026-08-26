-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepBaseWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepBaseWork", package.seeall)

local SodacheStepBaseWork = class("SodacheStepBaseWork", BaseWork)

function SodacheStepBaseWork:ctor(stepMo)
	self._stepMo = stepMo
end

function SodacheStepBaseWork:onStart(context)
	context.beginDt = ServerTime.now()

	self:onWorkStart(context)
end

function SodacheStepBaseWork:onWorkStart(context)
	self:onDone(true)
end

function SodacheStepBaseWork:isInsideStep()
	return true
end

function SodacheStepBaseWork:canMergeExecute()
	return false
end

return SodacheStepBaseWork
