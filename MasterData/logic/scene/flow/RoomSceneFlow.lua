-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/flow/RoomSceneFlow.lua

module("logic.scene.flow.RoomSceneFlow", package.seeall)

local M = class("RoomSceneFlow", DefaultSceneFlow)

function M:_registerComponents()
	M.super._registerComponents(self)
	self:_addComponent("cam", MainSceneCamFlowComp)
	self:_addComponent("unitFactory", MainSceneUnitFactory)
	self:_addComponent("elementMgr", MainSceneElementMgr)
	self:_addComponent("performMgr", MainScenePerformMgr)
	self:_addComponent("viewMgr", MainSceneViewMgr)
end

function M:createEnterSceneWork(info)
	local showLoading = info.isLoading ~= false

	self._notOpenUI = info.notOpenUI
	self._isBackScene = info.isBack
	self._isJumpToMainView = info.jumpToMainView

	local work = self:_createWork()

	work:setDoneCaller(self._onEnterFinish, self)

	local sequence = FlowSequence.New()

	if showLoading then
		sequence:addChild(WorkShowLoading.New(true))
		sequence:addChild(WorkEnableLoadingOptimize.New())
	end

	local parallel = FlowParallel.New()

	parallel:addChild(WorkListenLoadScene.New())
	parallel:addChild(WorkLoadScene.New())
	sequence:addChild(parallel)
	sequence:addChild(WorkFuncCaller.New(self._blockTips, self, true))
	sequence:addChild(WorkFuncCaller.New(self._onSceneLoadDone, self))
	sequence:addChild(MainSceneWorkLoadHero.New())

	if showLoading then
		sequence:addChild(WorkDisableLoadingOptimize.New())
	end

	sequence:addChild(WorkHideLoading.New())

	if self:_isNeedWaitToAirtightAni() and not info.isBack then
		sequence:addChild(WorkInterval.New(0.1))
		sequence:addChild(MainSceneWorkAirtightTimeChange.New())
	end

	sequence:addChild(WorkFuncCaller.New(self._openView, self))
	sequence:addChild(WorkDealJumpSceneView.New(SceneType.Room))
	sequence:addChild(WorkFuncCaller.New(self._blockTips, self, false))
	work:addChild(sequence)

	return work
end

function M:getIsNotOpenUI()
	return self._notOpenUI
end

function M:getIsBackScene()
	return self._isBackScene
end

function M:getIsJumpToMainView()
	return self._isJumpToMainView
end

function M:_openView()
	self.viewMgr:openView()
end

function M:_blockTips(block)
	GlobalDispatcher:dispatchEvent(EventType.TIPS_BLOCK_CONTROL, block, "mainSceneFlow")
end

function M:_isNeedWaitToAirtightAni()
	local needWait = false
	local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()

	if not inSpTime then
		local inTime, playAni = AirtightRoomUtil.getNextEnvAnim()

		needWait = inTime and playAni
	end

	return needWait
end

return M
