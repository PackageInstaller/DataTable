-- chunkname: @modules/logic/v3a8_dragonboat/view/V3a8_DragonBoatActivity_FullViewContainer.lua

module("modules.logic.v3a8_dragonboat.view.V3a8_DragonBoatActivity_FullViewContainer", package.seeall)

local V3a8_DragonBoatActivity_FullViewContainer = class("V3a8_DragonBoatActivity_FullViewContainer", V3a8_DragonBoatActivity_ImplContainer)

function V3a8_DragonBoatActivity_FullViewContainer:buildViews()
	self._mainView = V3a8_DragonBoatActivity_FullView.New()

	return {
		self._mainView
	}
end

function V3a8_DragonBoatActivity_FullViewContainer:onContainerClose()
	GameUtil.onDestroyViewMember(self, "_flowFromPanel")
	V3a8_DragonBoatActivity_FullViewContainer.super.onContainerClose()
end

function V3a8_DragonBoatActivity_FullViewContainer:doFlowFromPanel(voteResultInfo)
	GameUtil.onDestroyViewMember(self, "_flowFromPanel")

	local kViewName = ViewName.V3a8_DragonBoatActivity_PanelView

	if ViewMgr.instance:isOpen(kViewName) then
		self._flowFromPanel = GaoSiNiaoFlowSequence_Base.New()

		self._flowFromPanel:addWork(GaoSiNiaoWork_WaitCloseView.s_create(kViewName))
		self._flowFromPanel:addWork(FunctionWork.New(self._mainView.doFlowFromPanel, self._mainView, voteResultInfo))
		self._flowFromPanel:start()
	else
		self._mainView:doFlowFromPanel(voteResultInfo)
	end
end

return V3a8_DragonBoatActivity_FullViewContainer
