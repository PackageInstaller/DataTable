-- chunkname: @modules/logic/scene/summon/comp/SummonSceneViewComp.lua

module("modules.logic.scene.summon.comp.SummonSceneViewComp", package.seeall)

local SummonSceneViewComp = class("SummonSceneViewComp", BaseSceneComp)

function SummonSceneViewComp:openView()
	self._param = SummonController.instance.summonViewParam
	self._viewOpenFromEnterScene = false

	self:startOpenMainView()
end

function SummonSceneViewComp:needWaitForViewOpen()
	return not SummonController.instance:isInSummonGuide()
end

function SummonSceneViewComp:startOpenMainView()
	if self:needWaitForViewOpen() then
		if not ViewMgr.instance:isOpen(ViewName.SummonADView) then
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onViewOpened, self)

			self._viewOpenFromEnterScene = true

			SummonMainController.instance:openSummonView(self._param, true)
		else
			TaskDispatcher.runDelay(self.delayDispatchOpenViewFinish, self, 0.001)
		end
	else
		TaskDispatcher.runDelay(self.delayDispatchOpenViewFinish, self, 0.001)
	end
end

function SummonSceneViewComp:delayDispatchOpenViewFinish()
	self:dispatchEvent(SummonSceneEvent.OnViewFinish)
end

function SummonSceneViewComp:onViewOpened(viewName)
	if viewName == ViewName.SummonADView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onViewOpened, self)
		self:dispatchEvent(SummonSceneEvent.OnViewFinish)
	end
end

function SummonSceneViewComp:onScenePrepared(sceneId, levelId)
	if self._viewOpenFromEnterScene then
		-- block empty
	end
end

function SummonSceneViewComp:onSceneClose()
	self._viewOpenFromEnterScene = false

	TaskDispatcher.cancelTask(self.delayDispatchOpenViewFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onViewOpened, self)
	ViewMgr.instance:closeView(ViewName.SummonView)

	if SummonController.instance:isInSummonGuide() then
		ViewMgr.instance:closeView(ViewName.SummonADView)
	end
end

function SummonSceneViewComp:onSceneHide()
	self:onSceneClose()
end

return SummonSceneViewComp
