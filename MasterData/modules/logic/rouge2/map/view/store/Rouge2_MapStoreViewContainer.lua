-- chunkname: @modules/logic/rouge2/map/view/store/Rouge2_MapStoreViewContainer.lua

module("modules.logic.rouge2.map.view.store.Rouge2_MapStoreViewContainer", package.seeall)

local Rouge2_MapStoreViewContainer = class("Rouge2_MapStoreViewContainer", BaseViewContainer)

function Rouge2_MapStoreViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MapStoreView.New())
	table.insert(views, Rouge2_MapStoreStealFailView.New())
	table.insert(views, Rouge2_MapCoinView.New())
	table.insert(views, TabViewGroup.New(1, "#go_Other/#go_topleft"))

	return views
end

function Rouge2_MapStoreViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		})

		self.navigateView:setOverrideHelp(self.overrideHelpBtn, self)
		self.navigateView:setOverrideClose(self.overrideCloseCallback, self)

		return {
			self.navigateView
		}
	end
end

function Rouge2_MapStoreViewContainer:overrideCloseCallback()
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.Rouge2ExitEvent, MsgBoxEnum.BoxType.Yes_No, self._btnCloseCallback, nil, nil, self)
end

function Rouge2_MapStoreViewContainer:_btnCloseCallback()
	local layerId = Rouge2_MapModel.instance:getLayerId()
	local nodeMo = self.viewParam
	local nodeId = nodeMo and nodeMo.nodeId
	local eventMo = nodeMo and nodeMo.eventMo
	local eventId = eventMo and eventMo.eventId

	self.leaveCallbackId = Rouge2_Rpc.instance:sendRouge2EndShopEventRequest(layerId, nodeId, eventId, false, self._sendEndShopEventCallback, self)
end

function Rouge2_MapStoreViewContainer:_sendEndShopEventCallback(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	self:closeThis()
	Rouge2_MapStoreGoodsListModel.instance:clear()
end

function Rouge2_MapStoreViewContainer:onContainerClose()
	if self.leaveCallbackId then
		Rouge2_Rpc.instance:removeCallbackById(self.leaveCallbackId)
	end
end

function Rouge2_MapStoreViewContainer:overrideHelpBtn()
	Rouge2_Controller.instance:openTechniqueView(Rouge2_MapEnum.TechniqueId.MapStore)
end

return Rouge2_MapStoreViewContainer
