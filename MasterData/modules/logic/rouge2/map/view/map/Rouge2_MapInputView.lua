-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapInputView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapInputView", package.seeall)

local Rouge2_MapInputView = class("Rouge2_MapInputView", BaseView)

function Rouge2_MapInputView:onInitView()
	self.goFullScreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self.goGuideClick = gohelper.findChild(self.viewGO, "#go_guide_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapInputView:addEvents()
	return
end

function Rouge2_MapInputView:removeEvents()
	return
end

function Rouge2_MapInputView:_editableInitView()
	self.click = gohelper.getClickWithDefaultAudio(self.goFullScreen)

	self.click:AddClickListener(self.onClickMap, self)

	self.click2 = gohelper.getClickWithDefaultAudio(self.goGuideClick)

	self.click2:AddClickListener(self.onClickMap, self)

	self.trFullScreen = self.goFullScreen:GetComponent(gohelper.Type_RectTransform)
	self.mapComp = Rouge2_MapController.instance:getMapComp()

	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onLoadMapDone, self.onLoadMapDone, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onBeforeChangeMapInfo, self.onBeforeChangeMapInfo, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
end

function Rouge2_MapInputView:onBeforeChangeMapInfo()
	self.mapComp = nil
end

function Rouge2_MapInputView:onLoadMapDone()
	self.mapComp = Rouge2_MapController.instance:getMapComp()
end

function Rouge2_MapInputView:onClickMap(param, position)
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

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSelectNode, nil)
end

function Rouge2_MapInputView:onCloseView(viewName)
	if viewName == ViewName.Rouge2_MapChoiceView or viewName == ViewName.Rouge2_MapExploreChoiceView then
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSelectNode, nil)
	end
end

function Rouge2_MapInputView:onClose()
	self.click:RemoveClickListener()
	self.click2:RemoveClickListener()

	self.click = nil
	self.click2 = nil
end

return Rouge2_MapInputView
