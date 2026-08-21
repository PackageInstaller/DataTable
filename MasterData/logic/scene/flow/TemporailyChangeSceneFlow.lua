-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/flow/TemporailyChangeSceneFlow.lua

module("logic.scene.flow.TemporailyChangeSceneFlow", package.seeall)

local M = class("TemporailyChangeSceneFlow")

function M:destroyWork()
	if self._workChange then
		self._workChange:destroy()

		self._workChange = false
	end

	if self._workBack then
		self._workBack:destroy()

		self._workBack = false
	end

	self.info = nil
	self.infoBack = nil
end

function M:runChangeSceneWork(info)
	if self._workChange then
		SceneFace.instance:printMsg("temporaily change scene Work Running", true)

		return
	end

	self.info = info
	self._workChange = WorkFlow.New()

	self._workChange:setDoneCaller(self._onTemporailyChangeSceneFinish, self)

	local sequence = FlowSequence.New()

	if info.needLoading then
		sequence:addChild(WorkShowLoading.New(true))
		sequence:addChild(WorkInterval.New(0.3))
		sequence:addChild(WorkEnableLoadingOptimize.New())
	end

	sequence:addChild(WorkFuncCaller.New(self._leaveCurScene, self))

	local parallel = FlowParallel.New()

	parallel:addChild(WorkListenLoadScene.New())
	parallel:addChild(WorkTemporailyEnterScene.New())
	sequence:addChild(parallel)
	sequence:addChild(WorkFuncCaller.New(self._onChangeSceneLoadDone, self))

	for _, work in ipairs(info.finishWorkLst or {}) do
		sequence:addChild(work)
	end

	sequence:addChild(WorkChangeSceneFinish.New())

	if info.needLoading then
		sequence:addChild(WorkDisableLoadingOptimize.New())
		sequence:addChild(WorkHideLoading.New())
	end

	self._workChange:addChild(sequence)
	self._workChange:start(self)
end

function M:_leaveCurScene()
	local leaveInfo = SceneFace.instance:getCacheSceneLeave()
	local sceneType = leaveInfo.sceneType
	local sceneId = leaveInfo.sceneId
	local passThroughParam = leaveInfo.passThroughParam

	SceneFace.instance:printMsg(string.format("temporaily leave scene [%s][%s]", sceneType, sceneId))

	local curScene = SceneMgr.instance:getScene(sceneType)

	if curScene.onLeaveScene then
		curScene:onLeaveScene(passThroughParam)
	end

	SceneFace.instance:printMsg(string.format("temporaily leave scene flow [%s][%s]", sceneType, sceneId))

	local curSceneFlow = leaveInfo.flow

	if curSceneFlow then
		curSceneFlow:leaveScene(passThroughParam)
	end

	SceneFace.instance:printMsg(string.format("temporaily leave scene [%s][%s] finish", sceneType, sceneId))
end

function M:_onChangeSceneLoadDone()
	local curSceneFlow = SceneFace.instance:getCurSceneFlow()

	if curSceneFlow then
		local info = {
			sceneId = self.info.sceneId,
			sceneType = self.info.sceneType
		}

		curSceneFlow:_notifyComponents(SceneFunctionName.onSceneLoadDone, info)
	end
end

function M:_onTemporailyChangeSceneFinish()
	self:destroyWork()
end

function M:runBackSceneWork(info)
	if self._workBack then
		SceneFace.instance:printMsg("back to leave scene Working Running", true)
	end

	self.infoBack = info
	self._workBack = WorkFlow.New()

	self._workBack:setDoneCaller(self._onTemporailyBackSceneFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkShowLoading.New(true))
	sequence:addChild(WorkInterval.New(0.4))
	sequence:addChild(WorkEnableLoadingOptimize.New())

	local parallel = FlowParallelOr.New()

	parallel:addChild(WorkListenLoadScene.New())
	parallel:addChild(WorkTemporailyReturnScene.New())
	sequence:addChild(parallel)
	sequence:addChild(WorkFuncCaller.New(self._onBackSceneLoadDone, self))
	sequence:addChild(WorkInterval.New(0))
	sequence:addChild(WorkBackSceneFinish.New())
	sequence:addChild(WorkDisableLoadingOptimize.New())
	sequence:addChild(WorkInterval.New(0))
	sequence:addChild(WorkHideLoading.New())
	self._workBack:addChild(sequence)
	self._workBack:start(self)
end

function M:_onBackSceneLoadDone()
	local sceneType = self.infoBack.sceneType
	local sceneId = self.infoBack.sceneId
	local readyBackFlow = self.infoBack.readyBackFlow
	local passThroughParam = self.infoBack.passThroughParam

	SceneMgr.instance:returnScene(sceneType, sceneId)

	SceneFace.instance._curSceneFlow = readyBackFlow
	SceneFace.instance._curSceneTyp = sceneType

	if readyBackFlow then
		readyBackFlow:returnScene(passThroughParam)
	end
end

function M:_onTemporailyBackSceneFinish()
	self:destroyWork()
end

return M
