-- chunkname: @modules/logic/explore/controller/steps/ExploreStepBase.lua

module("modules.logic.explore.controller.steps.ExploreStepBase", package.seeall)

local ExploreStepBase = class("ExploreStepBase")

function ExploreStepBase:ctor(data)
	self._data = data

	self:onInit()
end

function ExploreStepBase:onInit()
	return
end

function ExploreStepBase:onStart()
	self:onDone()
end

function ExploreStepBase:onDone()
	self:onDestory()

	return ExploreStepController.instance:onStepEnd()
end

function ExploreStepBase:onDestory()
	self._data = nil
end

return ExploreStepBase
