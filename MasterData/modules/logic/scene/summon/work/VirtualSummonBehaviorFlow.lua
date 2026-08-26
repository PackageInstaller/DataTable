-- chunkname: @modules/logic/scene/summon/work/VirtualSummonBehaviorFlow.lua

module("modules.logic.scene.summon.work.VirtualSummonBehaviorFlow", package.seeall)

local VirtualSummonBehaviorFlow = class("VirtualSummonBehaviorFlow", FlowParallel)

function VirtualSummonBehaviorFlow:ctor(...)
	VirtualSummonBehaviorFlow.super.ctor(self, ...)
	self:addWork(VirtualSummonBehaviorFlow_Work1.New())
end

function VirtualSummonBehaviorFlow:start(heroIdList, backToMainSceneCallBack)
	assert(heroIdList and #heroIdList > 0)

	self._heroIdList = heroIdList
	self._backToMainSceneCallBack = backToMainSceneCallBack

	VirtualSummonBehaviorFlow.super.start(self)
end

function VirtualSummonBehaviorFlow:heroIdList()
	return self._heroIdList
end

function VirtualSummonBehaviorFlow:backToMainSceneCallBack()
	return self._backToMainSceneCallBack
end

function VirtualSummonBehaviorFlow:onDestroyView()
	self:destroy()
end

function VirtualSummonBehaviorFlow:addWork(work)
	VirtualSummonBehaviorFlow.super.addWork(self, work)
	work:setRootInternal(self)

	return work
end

return VirtualSummonBehaviorFlow
