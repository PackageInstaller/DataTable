-- chunkname: @modules/logic/rouge/map/view/map/RougeMapInputView.lua

module("modules.logic.rouge.map.view.map.RougeMapInputView", package.seeall)

local RougeMapInputView = class("RougeMapInputView", BaseView)

function RougeMapInputView:onInitView()
	self.goFullScreen = gohelper.findChild(self.viewGO, "#go_fullscreen")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapInputView:addEvents()
	return
end

function RougeMapInputView:removeEvents()
	return
end

function RougeMapInputView:_editableInitView()
	self.click = gohelper.getClickWithDefaultAudio(self.goFullScreen)

	self.click:AddClickListener(self.onClickMap, self)

	self.trFullScreen = self.goFullScreen:GetComponent(gohelper.Type_RectTransform)
	self.mapComp = RougeMapController.instance:getMapComp()

	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onLoadMapDone, self.onLoadMapDone, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onBeforeChangeMapInfo, self.onBeforeChangeMapInfo, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
end

function RougeMapInputView:onBeforeChangeMapInfo()
	self.mapComp = nil
end

function RougeMapInputView:onLoadMapDone()
	self.mapComp = RougeMapController.instance:getMapComp()
end

function RougeMapInputView:onClickMap(param, position)
	if not self.mapComp then
		return
	end

	local clickPosX, clickPosY = recthelper.screenPosToAnchorPos2(position, self.trFullScreen)

	for _, mapItem in ipairs(self.mapComp:getMapItemList()) do
		if mapItem:checkInClickArea(clickPosX, clickPosY, self.trFullScreen) then
			mapItem:onClick()

			return
		end
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectNode, nil)
end

function RougeMapInputView:onCloseView(viewName)
	if viewName == ViewName.RougeMapChoiceView then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectNode, nil)
	end
end

function RougeMapInputView:onClose()
	if self.click then
		self.click:RemoveClickListener()

		self.click = nil
	end
end

return RougeMapInputView
