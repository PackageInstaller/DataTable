-- chunkname: @modules/logic/rouge/map/view/map/RougeMapLayerLineView.lua

module("modules.logic.rouge.map.view.map.RougeMapLayerLineView", package.seeall)

local RougeMapLayerLineView = class("RougeMapLayerLineView", BaseView)
local ArrowPosY_UseDLC_103 = 43
local ArrowPosY_NotUseDLC_103 = 0

function RougeMapLayerLineView:onInitView()
	self.goLineContainer = gohelper.findChild(self.viewGO, "#go_linecontainer")
	self.goLineIconItem = gohelper.findChild(self.viewGO, "#go_linecontainer/#go_lineitem")
	self.goLine = gohelper.findChild(self.viewGO, "#go_linecontainer/#go_line")
	self.goStart = gohelper.findChild(self.viewGO, "#go_linecontainer/#go_start")
	self.goEnd = gohelper.findChild(self.viewGO, "#go_linecontainer/#go_end")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapLayerLineView:addEvents()
	return
end

function RougeMapLayerLineView:removeEvents()
	return
end

function RougeMapLayerLineView:_editableInitView()
	gohelper.setActive(self.goLineIconItem, false)
	gohelper.setActive(self.goLine, false)

	self.rectTrStart = self.goStart:GetComponent(gohelper.Type_RectTransform)
	self.rectTrEnd = self.goEnd:GetComponent(gohelper.Type_RectTransform)

	self:hide()

	self.lineItemList = {}

	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onSelectLayerChange, self.onSelectLayerChange, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onPathSelectMapFocusDone, self.onPathSelectMapFocusDone, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, self.onUpdateMapInfo, self)
end

function RougeMapLayerLineView:onChangeMapInfo()
	if not RougeMapModel.instance:isPathSelect() then
		self:hide()

		return
	end

	self:initData()
end

function RougeMapLayerLineView:onUpdateMapInfo()
	if not RougeMapModel.instance:isPathSelect() then
		self:hide()

		return
	end

	self:refreshLayer()
end

function RougeMapLayerLineView:onSelectLayerChange(layerId)
	self.selectLayerId = layerId

	self:refreshLayerSelect()
end

function RougeMapLayerLineView:onOpen()
	self:hide()

	if not RougeMapModel.instance:isPathSelect() then
		return
	end

	self:initData()
end

function RougeMapLayerLineView:initData()
	self.pathSelectCo = RougeMapModel.instance:getPathSelectCo()
	self.nextLayerList = RougeMapModel.instance:getNextLayerList()
	self.selectLayerId = RougeMapModel.instance:getSelectLayerId()
end

function RougeMapLayerLineView:onPathSelectMapFocusDone()
	self:show()
	self:refreshLayer()
end

function RougeMapLayerLineView:refreshLayer()
	local anchorX, anchorY = RougeMapHelper.getPos(self.pathSelectCo.startPos)

	recthelper.setAnchor(self.rectTrStart, anchorX, anchorY)

	anchorX, anchorY = RougeMapHelper.getPos(self.pathSelectCo.endPos)

	recthelper.setAnchor(self.rectTrEnd, anchorX, anchorY)

	local isUseDLC_103 = RougeDLCHelper.isUsingTargetDLC(RougeDLCEnum.DLCEnum.DLC_103)

	for index, layerId in ipairs(self.nextLayerList) do
		local layerCo = lua_rouge_layer.configDict[layerId]
		local lineItem = self.lineItemList[index]

		lineItem = lineItem or self:createLineItem(layerCo)

		gohelper.setActive(lineItem.lineContainer, true)

		lineItem.lineContainer.name = layerCo.id

		lineItem.simageLine:LoadImage(layerCo.pathRes, self.onLoadImageDone, lineItem)

		local name = layerCo.name

		lineItem.txtSelectLayerName.text = name
		lineItem.txtUnSelectLayerName.text = name
		lineItem.layerCo = layerCo
		anchorX, anchorY = RougeMapHelper.getPos(layerCo.pathPos)

		recthelper.setAnchor(lineItem.rectLine, anchorX, anchorY)

		anchorX, anchorY = RougeMapHelper.getPos(layerCo.iconPos)

		recthelper.setAnchor(lineItem.rectLineIcon, anchorX, anchorY)

		local select = lineItem.layerCo.id == self.selectLayerId

		lineItem.animator:Play(select and "select_open" or "unselect_open")
		ZProj.UGUIHelper.SetColorAlpha(lineItem.imageLine, select and 1 or 0.33)
		gohelper.setActive(lineItem.goselectdlc3, isUseDLC_103)
		gohelper.setActive(lineItem.gounselectdlc3, isUseDLC_103)
		recthelper.setAnchorY(lineItem.goarrow.transform, (isUseDLC_103 or nil) and (ArrowPosY_UseDLC_103 or ArrowPosY_NotUseDLC_103))

		if isUseDLC_103 then
			local layerChoiceInfo = RougeMapModel.instance:getLayerChoiceInfo(layerId)
			local mapRuleType = layerChoiceInfo and layerChoiceInfo:getMapRuleType()

			gohelper.setActive(lineItem.goselectdlc3_normal, mapRuleType == RougeDLCEnum103.MapRuleType.Normal)
			gohelper.setActive(lineItem.goselectdlc3_hard, mapRuleType == RougeDLCEnum103.MapRuleType.Hard)
			gohelper.setActive(lineItem.gounselectdlc3_normal, mapRuleType == RougeDLCEnum103.MapRuleType.Normal)
			gohelper.setActive(lineItem.gounselectdlc3_hard, mapRuleType == RougeDLCEnum103.MapRuleType.Hard)
		end
	end

	for i = #self.nextLayerList + 1, #self.lineItemList do
		gohelper.setActive(self.lineItemList[i].lineContainer, false)
	end
end

function RougeMapLayerLineView:refreshLayerSelect()
	for _, lineItem in ipairs(self.lineItemList) do
		local select = lineItem.layerCo.id == self.selectLayerId

		lineItem.animator:Play(select and "select" or "unselect")
		ZProj.UGUIHelper.SetColorAlpha(lineItem.imageLine, select and 1 or 0.33)
	end
end

function RougeMapLayerLineView:createLineItem()
	local lineItem = self:getUserDataTb_()
	local lineContainer = gohelper.create2d(self.goLineContainer)
	local line = gohelper.clone(self.goLine, lineContainer, "line")
	local lineIconItem = gohelper.clone(self.goLineIconItem, lineContainer, "lineIcon")

	gohelper.setActive(line, true)
	gohelper.setActive(lineIconItem, true)

	lineItem.lineContainer = lineContainer
	lineItem.rectLine = line:GetComponent(gohelper.Type_RectTransform)
	lineItem.rectLineIcon = lineIconItem:GetComponent(gohelper.Type_RectTransform)
	lineItem.simageLine = SLFramework.UGUI.SingleImage.Get(line)
	lineItem.imageLine = line:GetComponent(gohelper.Type_Image)
	lineItem.iconSelect = gohelper.findChild(lineIconItem, "select")
	lineItem.txtSelectLayerName = gohelper.findChildText(lineIconItem, "select/#txt_line")
	lineItem.iconUnSelect = gohelper.findChild(lineIconItem, "unselect")
	lineItem.txtUnSelectLayerName = gohelper.findChildText(lineIconItem, "unselect/#txt_line")
	lineItem.animator = lineIconItem:GetComponent(gohelper.Type_Animator)
	lineItem.goselectdlc3 = gohelper.findChild(lineIconItem, "select/#go_dlc3")
	lineItem.goselectdlc3_normal = gohelper.findChild(lineIconItem, "select/#go_dlc3/normal")
	lineItem.goselectdlc3_hard = gohelper.findChild(lineIconItem, "select/#go_dlc3/hard")
	lineItem.gounselectdlc3 = gohelper.findChild(lineIconItem, "unselect/#go_dlc3")
	lineItem.gounselectdlc3_normal = gohelper.findChild(lineIconItem, "unselect/#go_dlc3/normal")
	lineItem.gounselectdlc3_hard = gohelper.findChild(lineIconItem, "unselect/#go_dlc3/hard")
	lineItem.goarrow = gohelper.findChild(lineIconItem, "select/arrow")
	lineItem.click = gohelper.getClickWithDefaultAudio(lineIconItem)

	lineItem.click:AddClickListener(self.onClickLine, self, lineItem)
	gohelper.setActive(lineItem.iconSelect, true)
	gohelper.setActive(lineItem.iconUnSelect, true)
	table.insert(self.lineItemList, lineItem)

	return lineItem
end

function RougeMapLayerLineView:onClickLine(lineItem)
	local layerId = lineItem.layerCo.id

	RougeMapModel.instance:updateSelectLayerId(layerId)
end

function RougeMapLayerLineView.onLoadImageDone(lineItem)
	lineItem.imageLine:SetNativeSize()
end

function RougeMapLayerLineView:show()
	gohelper.setActive(self.goLineContainer, true)
end

function RougeMapLayerLineView:hide()
	gohelper.setActive(self.goLineContainer, false)
end

function RougeMapLayerLineView:onDestroyView()
	for _, lineItem in ipairs(self.lineItemList) do
		lineItem.simageLine:UnLoadImage()
		lineItem.click:RemoveClickListener()
	end

	self.lineItemList = nil
end

return RougeMapLayerLineView
