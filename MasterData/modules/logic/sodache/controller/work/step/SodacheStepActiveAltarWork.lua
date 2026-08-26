-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepActiveAltarWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepActiveAltarWork", package.seeall)

local SodacheStepActiveAltarWork = class("SodacheStepActiveAltarWork", SodacheStepBaseWork)

function SodacheStepActiveAltarWork:onWorkStart(context)
	self:onDone(true)
end

return SodacheStepActiveAltarWork
