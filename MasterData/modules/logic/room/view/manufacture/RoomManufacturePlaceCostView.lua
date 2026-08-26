-- chunkname: @modules/logic/room/view/manufacture/RoomManufacturePlaceCostView.lua

module("modules.logic.room.view.manufacture.RoomManufacturePlaceCostView", package.seeall)

local RoomManufacturePlaceCostView = class("RoomManufacturePlaceCostView", BaseView)

function RoomManufacturePlaceCostView:onInitView()
	self._txttitle = gohelper.findChildText(self.viewGO, "go_normalroot/#txt_title")
	self._txtname = gohelper.findChildText(self.viewGO, "go_normalroot/#txt_name")
	self._txtdesc = gohelper.findChildText(self.viewGO, "go_normalroot/#txt_desc")
	self._btninform = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/#btn_inform")
	self._scrollcost = gohelper.findChildScrollRect(self.viewGO, "go_normalroot/#scroll_cost")
	self._gocosts = gohelper.findChild(self.viewGO, "go_normalroot/#scroll_cost/Viewport/#go_costs")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "go_normalroot/#simage_icon")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomManufacturePlaceCostView:addEvents()
	self._btninform:AddClickListener(self._btninformOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomManufacturePlaceCostView:removeEvents()
	self._btninform:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function RoomManufacturePlaceCostView:_btncloseOnClick()
	self:closeThis()
end

function RoomManufacturePlaceCostView:_btninformOnClick()
	local tempMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not tempMO or tonumber(tempMO.id) > 0 then
		self:closeThis()
	elseif self:_checkCost() then
		RoomBuildingController.instance:sendBuyManufactureBuildingRpc(tempMO.buildingId)
	else
		GameFacade.showToast(ToastEnum.RoomPlaceCostItemSufficient)
	end
end

function RoomManufacturePlaceCostView:_editableInitView()
	return
end

function RoomManufacturePlaceCostView:onUpdateParam()
	return
end

function RoomManufacturePlaceCostView:onOpen()
	local tempMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not tempMO then
		self:closeThis()

		return
	end

	self:_refreshUI()
end

function RoomManufacturePlaceCostView:onClose()
	self._simageicon:UnLoadImage()
end

function RoomManufacturePlaceCostView:onDestroyView()
	return
end

function RoomManufacturePlaceCostView:_refreshUI()
	local buildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not buildingMO then
		return
	end

	local placeCfg = ManufactureConfig.instance:getManufactureBuildingCfg(buildingMO.buildingId)

	if not placeCfg then
		return
	end

	local buildingCfg = buildingMO.config

	self._txtname.text = buildingCfg.name
	self._txtdesc.text = buildingCfg.desc
	self._txttitle.text = buildingCfg.useDesc

	self._simageicon:LoadImage(ResUrl.getRoomImage("building/" .. buildingMO:getIcon()))

	self._costDataList = ItemModel.instance:getItemDataListByConfigStr(placeCfg.placeCost)

	IconMgr.instance:getCommonPropItemIconList(self, self._onItemShow, self._costDataList, self._gocosts)
end

function RoomManufacturePlaceCostView:_checkCost()
	if self._costDataList then
		for i = 1, #self._costDataList do
			local cost = self._costDataList[i]
			local quantity = ItemModel.instance:getItemQuantity(cost.materilType, cost.materilId)

			if quantity < cost.quantity then
				return false
			end
		end
	end

	return true
end

function RoomManufacturePlaceCostView:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
	cell_component:setCountText(ItemModel.instance:getItemIsEnoughText(data))
end

return RoomManufacturePlaceCostView
