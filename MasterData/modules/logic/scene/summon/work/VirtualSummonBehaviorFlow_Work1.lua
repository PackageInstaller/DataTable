-- chunkname: @modules/logic/scene/summon/work/VirtualSummonBehaviorFlow_Work1.lua

module("modules.logic.scene.summon.work.VirtualSummonBehaviorFlow_Work1", package.seeall)

local VirtualSummonBehaviorFlow_Work1 = class("VirtualSummonBehaviorFlow_Work1", VirtualSummonBehaviorFlow_WorkBase)

function VirtualSummonBehaviorFlow_Work1:_heroIdList()
	return self.root:heroIdList()
end

function VirtualSummonBehaviorFlow_Work1:_backToMainSceneCallBack()
	return self.root:backToMainSceneCallBack() or function()
		return
	end
end

local kBlock = "SummonController-doVirtualSummonBehavior"

function VirtualSummonBehaviorFlow_Work1:onStart(context)
	self:clearWork()
	self:startBlock(kBlock)
	VirtualSummonScene.instance:registerCallback(SummonSceneEvent.OnPreloadFinishAtScene, self._onSummonPreloadFinish, self)
	SummonController.instance:doVirtualSummonBehavior(self:_heroIdList(), true, true, self._onCloseSommonScene, self, true)
	TaskDispatcher.runDelay(self._onFirstLoadSceneBlock, self, 0.5)
end

function VirtualSummonBehaviorFlow_Work1:_onFirstLoadSceneBlock()
	SummonController.instance:onFirstLoadSceneBlock()
	TaskDispatcher.cancelTask(self.onDone, self)
	TaskDispatcher.runDelay(self.onDone, self, 5)
end

function VirtualSummonBehaviorFlow_Work1:_onSummonPreloadFinish()
	TaskDispatcher.cancelTask(self.onDone, self)
	self:onDone(true)
end

function VirtualSummonBehaviorFlow_Work1:clearWork()
	TaskDispatcher.cancelTask(self.onDone, self)
	TaskDispatcher.cancelTask(self._onFirstLoadSceneBlock, self)
	VirtualSummonScene.instance:unregisterCallback(SummonSceneEvent.OnPreloadFinishAtScene, self._onSummonPreloadFinish, self)
	self:endBlock(kBlock)
end

function VirtualSummonBehaviorFlow_Work1:_onCloseSommonScene()
	local toSceneType = SceneType.Main
	local callback = self:_backToMainSceneCallBack()

	SummonController.instance:setSummonEndOpenCallBack()
	MainController.instance:enterMainScene(true)
	VirtualSummonScene.instance:close(true)

	if GameSceneMgr.instance:getCurSceneType() ~= toSceneType then
		SceneHelper.instance:waitSceneDone(toSceneType, callback)
	else
		callback()
	end
end

return VirtualSummonBehaviorFlow_Work1
