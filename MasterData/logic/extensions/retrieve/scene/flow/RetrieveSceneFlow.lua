-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/scene/flow/RetrieveSceneFlow.lua

module("logic.extensions.retrieve.scene.flow.RetrieveSceneFlow", package.seeall)

local M = class("RetrieveSceneFlow", DefaultSceneFlow)

function M:_registerComponents()
	M.super._registerComponents(self)
	self:_addComponent("viewMgr", RetrieveViewMgr)
	self:_addComponent("resMgr", RetrieveResourceMgr)
	self:_addComponent("unitFactory", RetrieveSceneHeroFactory)
	self:_addComponent("performMgr", RetrieveScenePerformMgr)
	self:_addComponent("sceneEffect", RetrieveSceneEffectMgr)
	self:_addComponent("audioMgr", RetrieveAudioMgr)
end

function M:createEnterSceneWork()
	local work = self:_createWork()

	work:setDoneCaller(self._onEnterFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkShowLoading.New(true))
	sequence:addChild(WorkInterval.New(0.53))
	sequence:addChild(WorkLoadScene.New())
	sequence:addChild(WorkLoadResource.New())
	sequence:addChild(WorkFuncCaller.New(self._onSceneLoadDone, self))
	sequence:addChild(WorkInterval.New(0.2))
	sequence:addChild(WorkHideLoading.New())
	work:addChild(sequence)

	return work
end

function M:createExitSceneWork()
	local work = self:_createWork()

	work:setDoneCaller(self._onExitFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(RetrieveWorkExitScene.New())
	work:addChild(sequence)

	return work
end

return M
