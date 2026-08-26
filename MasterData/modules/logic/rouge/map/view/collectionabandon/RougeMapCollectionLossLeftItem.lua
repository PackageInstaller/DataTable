-- chunkname: @modules/logic/rouge/map/view/collectionabandon/RougeMapCollectionLossLeftItem.lua

module("modules.logic.rouge.map.view.collectionabandon.RougeMapCollectionLossLeftItem", package.seeall)

local RougeMapCollectionLossLeftItem = class("RougeMapCollectionLossLeftItem", ListScrollCell)

function RougeMapCollectionLossLeftItem:init(go)
	self.go = go
	self.click = gohelper.getClickWithDefaultAudio(self.go)
	self.goGrid = gohelper.findChild(self.go, "#go_grid")
	self.goGridItem = gohelper.findChild(self.go, "#go_grid/#go_griditem")
	self.simageIcon = gohelper.findChildSingleImage(self.go, "#simage_icon")
	self.txtName = gohelper.findChildText(self.go, "right/#txt_name")
	self.txtDesc = gohelper.findChildText(self.go, "right/Scroll View/Viewport/Content/#txt_desc")
	self.click = gohelper.findChildClickWithDefaultAudio(self.go, "#btn_click")

	self.click:AddClickListener(self.onClickSelf, self)

	self.goIconAbandon = gohelper.findChild(self.go, "right/right_icon/#go_icon_abandon")
	self.goIconExchange = gohelper.findChild(self.go, "right/right_icon/#go_icon_exchange")
	self.goIconStorage = gohelper.findChild(self.go, "right/right_icon/#go_icon_storage")
	self.gridItemList = self:getUserDataTb_()

	self.addEventCb(self, RougeController.instance, RougeEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
end

function RougeMapCollectionLossLeftItem:onClickSelf()
	if not RougeLossCollectionListModel.instance:checkCanSelect() then
		return
	end

	gohelper.setActive(self.go, false)

	local removeComp = self._view.viewContainer:getListRemoveComp()

	removeComp:removeByIndex(self._index, self.onRemoveAnimDone, self)
end

function RougeMapCollectionLossLeftItem:onRemoveAnimDone()
	RougeLossCollectionListModel.instance:selectMo(self.mo)
end

function RougeMapCollectionLossLeftItem:onUpdateMO(mo)
	self.mo = mo
	self.collectionId = self.mo.collectionId
	self.uid = self.mo.uid

	gohelper.setActive(self.go, true)
	RougeCollectionHelper.loadShapeGrid(self.collectionId, self.goGrid, self.goGridItem, self.gridItemList)
	self.simageIcon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(self.collectionId))

	self.txtName.text = RougeCollectionConfig.instance:getCollectionName(self.collectionId)

	self:refreshIcon()
	self:refreshDesc()
end

function RougeMapCollectionLossLeftItem:refreshIcon()
	local type = RougeLossCollectionListModel.instance:getLossType()

	gohelper.setActive(self.goIconAbandon, type == RougeMapEnum.LossType.Abandon or type == RougeMapEnum.LossType.Copy)
	gohelper.setActive(self.goIconExchange, type == RougeMapEnum.LossType.Exchange)
	gohelper.setActive(self.goIconStorage, type == RougeMapEnum.LossType.Storage)
end

function RougeMapCollectionLossLeftItem:refreshDesc()
	local showTypes = RougeCollectionDescHelper.getShowDescTypesWithoutText()

	RougeCollectionDescHelper.setCollectionDescInfos3(self.collectionId, nil, self.txtDesc, showTypes)
end

function RougeMapCollectionLossLeftItem:_onSwitchCollectionInfoType()
	self:refreshDesc()
end

function RougeMapCollectionLossLeftItem:onDestroy()
	self.click:RemoveClickListener()
	self.simageIcon:UnLoadImage()
end

return RougeMapCollectionLossLeftItem
