-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/flow/ProfilerSceneFlow.lua

module("logic.scene.flow.ProfilerSceneFlow", package.seeall)

local M = class("ProfilerSceneFlow", DefaultSceneFlow)

function M:_registerComponents()
	self:_addComponent("model", SceneModelFlowComp)
end

function M:createEnterSceneWork()
	local work = self:_createWork()

	work:setDoneCaller(self._onEnterFinish, self)

	local sequence = FlowSequence.New()
	local parallel = FlowParallel.New()

	parallel:addChild(WorkListenLoadScene.New())
	parallel:addChild(WorkLoadScene.New())
	sequence:addChild(WorkShowLoading.New())
	sequence:addChild(parallel)
	sequence:addChild(WorkFuncCaller.New(self._onSceneLoadDone, self))
	sequence:addChild(WorkInterval.New(0.2))
	sequence:addChild(WorkHideLoading.New())
	work:addChild(sequence)

	return work
end

return M
