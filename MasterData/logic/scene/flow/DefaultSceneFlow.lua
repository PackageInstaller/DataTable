-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/flow/DefaultSceneFlow.lua

module("logic.scene.flow.DefaultSceneFlow", package.seeall)

local M = class("DefaultSceneFlow", SceneBaseFlow)

function M:ctor()
	M.super.ctor(self)

	self._compList = {}
	self._workingWork = false
end

function M:init()
	M.super.init(self)
	self:_registerComponents()
	self:_notifyComponents(SceneFunctionName.onInit)
end

function M:leaveScene(passThroughParam)
	self:_notifyComponents(SceneFunctionName.onLeaveScene, passThroughParam)
end

function M:returnScene(passThroughParam)
	self:_notifyComponents(SceneFunctionName.onReturnScene, passThroughParam)
end

function M:enterScene(info)
	if self._workingWork then
		return
	end

	self:_notifyComponents(SceneFunctionName.onEnter, info)

	self._workingWork = self:createEnterSceneWork(info)

	self._workingWork:start(self)
end

function M:exitScene()
	if self._workingWork then
		return
	end

	self:_notifyComponents(SceneFunctionName.onExit, info)

	self._workingWork = self:createExitSceneWork()

	self._workingWork:start(self)
end

function M:createEnterSceneWork(info)
	local work = self:_createWork()

	work:setDoneCaller(self._onEnterFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkShowLoading.New())
	sequence:addChild(WorkLoadScene.New())
	sequence:addChild(WorkListenLoadScene.New())
	sequence:addChild(WorkFuncCaller.New(self._onSceneLoadDone, self))
	sequence:addChild(WorkHideLoading.New())
	work:addChild(sequence)

	return work
end

function M:createExitSceneWork()
	local work = self:_createWork()

	work:setDoneCaller(self._onExitFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkExitScene.New())
	work:addChild(sequence)

	return work
end

function M:_registerComponents()
	self:_addComponent("model", SceneModelFlowComp)
	self:_addComponent("pickerView", ScenePickerFlowComp)
end

function M:_createWork()
	return WorkFlow.New()
end

function M:_destroyWork()
	if self._workingWork then
		self._workingWork:destroy()

		self._workingWork = false
	end
end

function M:_notifyComponents(functionName, params)
	for _, component in pairs(self._compList) do
		local func = component[functionName]

		if func then
			func(component, params)
		end
	end
end

function M:_addComponent(compName, compClass)
	local compInst = compClass.New(self)

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function M:_removeComponent(compName)
	local compInst = self[compName]

	if compInst then
		self[compName] = nil

		table.removebyvalue(self._compList, compInst, true)
	end
end

function M:enterSceneFinish()
	return
end

function M:exitSceneFinish()
	return
end

function M:_onEnterFinish()
	local info = {}

	info.sceneId = self.model:getSceneId()
	info.sceneType = self.model:getSceneType()

	self:_notifyComponents(SceneFunctionName.onEnterDone, info)
	self:_destroyWork()
	GlobalDispatcher:dispatchEvent(EventType.SCENE_FLOW_ENTER_FINISH, info)
end

function M:_onSceneLoadDone()
	local info = {}

	info.sceneId = self.model:getSceneId()
	info.sceneType = self.model:getSceneType()

	self:_notifyComponents(SceneFunctionName.onSceneLoadDone, info)
end

function M:_onExitFinish()
	local info = {}

	info.sceneId = self.model:getSceneId()
	info.sceneType = self.model:getSceneType()

	self:_notifyComponents(SceneFunctionName.onExitDone, info)
	self:_destroyWork()
	GlobalDispatcher:dispatchEvent(EventType.SCENE_FLOW_EXIT_FINISH, info)
end

function M:onReturnSceneFinished(passThroughParam)
	self:_notifyComponents(SceneFunctionName.onReturnSceneFinished, passThroughParam)
end

return M
