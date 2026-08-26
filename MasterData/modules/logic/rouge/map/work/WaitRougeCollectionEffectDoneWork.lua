-- chunkname: @modules/logic/rouge/map/work/WaitRougeCollectionEffectDoneWork.lua

module("modules.logic.rouge.map.work.WaitRougeCollectionEffectDoneWork", package.seeall)

local WaitRougeCollectionEffectDoneWork = class("WaitRougeCollectionEffectDoneWork", BaseWork)

function WaitRougeCollectionEffectDoneWork:ctor()
	return
end

function WaitRougeCollectionEffectDoneWork:onStart()
	local hasTriggerEffects = RougeCollectionModel.instance:checkHasTmpTriggerEffectInfo()

	if not hasTriggerEffects then
		return self:onDone(true)
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	RougePopController.instance:addPopViewWithViewName(ViewName.RougeCollectionChessView)
end

function WaitRougeCollectionEffectDoneWork:_onCloseViewFinish(viewName)
	if viewName == ViewName.RougeCollectionChessView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
		self:onDone(true)
	end
end

function WaitRougeCollectionEffectDoneWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

return WaitRougeCollectionEffectDoneWork
