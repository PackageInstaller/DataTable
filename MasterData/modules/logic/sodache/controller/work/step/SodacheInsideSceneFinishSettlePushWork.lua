-- chunkname: @modules/logic/sodache/controller/work/step/SodacheInsideSceneFinishSettlePushWork.lua

module("modules.logic.sodache.controller.work.step.SodacheInsideSceneFinishSettlePushWork", package.seeall)

local SodacheInsideSceneFinishSettlePushWork = class("SodacheInsideSceneFinishSettlePushWork", SodacheMsgPushWork)

function SodacheInsideSceneFinishSettlePushWork:onWorkStart(context)
	if SodacheModel.instance.____gmfastrun then
		local outSideMo = SodacheModel.instance:getOutsideMo()

		outSideMo.inside = false

		self:onDone(true)

		return
	end

	context.isEnd = true

	ViewMgr.instance:openView(ViewName.SodacheResultView, self._msg)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onViewClose, self)
end

function SodacheInsideSceneFinishSettlePushWork:_onViewClose(viewName)
	if viewName == ViewName.SodacheResultView then
		SodacheUtil.setInside(false)
		self:onDone(true)
	end
end

function SodacheInsideSceneFinishSettlePushWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onViewClose, self)
end

return SodacheInsideSceneFinishSettlePushWork
