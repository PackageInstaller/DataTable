-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/AirWorkShopDefFlow.lua

module("logic.extensions.airworkshop.flow.defflow.AirWorkShopDefFlow", package.seeall)

local M = class("AirWorkShopDefFlow", SceneBaseFlow)

function M:ctor()
	self._compList = {}
	self._workingWork = false

	self:_registerComponents()
	self:_notifyComponents(AirWorkShopFunctionName.onInit)
end

function M:enter(levelId, mapMO)
	self.model:init(levelId, mapMO)
	self:_notifyComponents(AirWorkShopFunctionName.onStart)

	local work = self:_createWork()

	work:setDoneCaller(self._onEnterFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkShowLoading.New(false))
	sequence:addChild(WorkInterval.New(0.5))
	sequence:addChild(AirWorkShopWorkLoadScene.New())
	sequence:addChild(WorkInterval.New(0.1))
	sequence:addChild(WorkLoadResource.New())
	sequence:addChild(AirWorkShopWorkResourceLoaded.New())
	sequence:addChild(AirWorkShopWorkTriggerEnterDone.New())
	sequence:addChild(AirWorkShopWorkInit.New())
	sequence:addChild(AirWorkShopWorkWaitBasicViewsOpen.New())
	sequence:addChild(WorkHideLoading.New())
	sequence:addChild(WorkInterval.New(0.5))
	sequence:addChild(AirWorkShopWorkEnterFinish.New())
	work:addChild(sequence)
	work:start(self)
end

function M:exit()
	local work = self:_createWork()

	work:setDoneCaller(self._onExitFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(AirWorkShopWorkExit.New())
	work:addChild(sequence)
	work:start(self)
end

function M:forceExit()
	self:_destroyWork()
	self:_processBeforeExit()
	self:_processExitFinish()
end

function M:_registerComponents()
	self:_addComponent("model", AirWorkShopModelComponent)
	self:_addComponent("boardMgr", AirWorkShopCheckerBoardMgr)
	self:_addComponent("resMgr", AirWorkShopResourceMgr)
	self:_addComponent("unitMgr", AirWorkShopUnitMgr)
	self:_addComponent("unitOperator", AirWorkShopUnitOperator)
	self:_addComponent("boardModel", AirWorkShopBoardModel)
	self:_addComponent("viewMgr", AirWorkShopViewMgr)
	self:_addComponent("scenePickerHandler", AirWorkShopScenePickerHandler)
	self:_addComponent("pathArrow", AirWorkShopPathArrow)
	self:_addComponent("highlandChecker", AirWorkShopHighlandChecker)
	self:_addComponent("cameraShot", AirWorkShopCameraShot)
	self:_addComponent("hotAreaChecker", AirWorkHotAreaChecker)
end

function M:_onEnterFinish(result)
	if result ~= WorkResult.Succeed then
		printError("enter fail")

		return
	end
end

function M:_onExitFinish(result)
	self:_processExitFinish()
end

function M:_processExitFinish()
	self:_clearForExit()
	self.resMgr:clearCacheResources()
end

function M:clearForExit()
	if self.model:isJumpToAnotherScene() then
		local removeSceneInStack = true
		local removeAll = true

		SceneFace.instance:exitScene(removeSceneInStack, removeAll)
	else
		SceneFace.instance:backScene()
	end

	self:_processBeforeExit()
	self:_clearForExit()
end

function M:_processBeforeExit()
	return
end

function M:_clearForExit(isRestart)
	self:_notifyComponents(AirWorkShopFunctionName.onBeforeClear)
	self:_notifyComponents(AirWorkShopFunctionName.onClear)
end

function M:_createWork()
	self:_destroyWork()

	self._workingWork = WorkFlow.New()

	return self._workingWork
end

function M:_destroyWork()
	if self._workingWork then
		self._workingWork:destroy()

		self._workingWork = false
	end
end

function M:_notifyComponents(functionName, ...)
	for _, component in pairs(self._compList) do
		local func = component[functionName]

		if func then
			func(component, ...)
		end
	end
end

function M:internal_NotifyComponent(functionName)
	self:_notifyComponents(functionName)
end

function M:_addComponent(compName, compClass)
	local compInst = compClass.New()

	self[compName] = compInst
	compInst.flow = self

	table.insert(self._compList, compInst)
end

function M:_removeComponent(compName)
	local compInst = self[compName]

	if compInst then
		self[compName] = nil

		table.removebyvalue(self._compList, compInst, true)
	end
end

return M
