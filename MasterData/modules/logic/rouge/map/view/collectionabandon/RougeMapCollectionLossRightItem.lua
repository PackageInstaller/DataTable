-- chunkname: @modules/logic/rouge/map/view/collectionabandon/RougeMapCollectionLossRightItem.lua

module("modules.logic.rouge.map.view.collectionabandon.RougeMapCollectionLossRightItem", package.seeall)

local RougeMapCollectionLossRightItem = class("RougeMapCollectionLossRightItem", UserDataDispose)

function RougeMapCollectionLossRightItem:init(go)
	self:__onInit()

	self.go = go
	self.tr = go:GetComponent(gohelper.Type_RectTransform)

	self:_editableInitView()
end

function RougeMapCollectionLossRightItem:_editableInitView()
	self.click = gohelper.getClickWithDefaultAudio(self.go)
	self.goGrid = gohelper.findChild(self.go, "#go_grid")
	self.goGridItem = gohelper.findChild(self.go, "#go_grid/#go_griditem")
	self.simageIcon = gohelper.findChildSingleImage(self.go, "#simage_icon")
	self.txtName = gohelper.findChildText(self.go, "right/#txt_name")
	self.txtDesc = gohelper.findChildText(self.go, "right/Scroll View/Viewport/Content/#txt_desc")
	self.click = gohelper.findChildClickWithDefaultAudio(self.go, "#btn_click")

	self.click:AddClickListener(self.onClickSelf, self)

	self.gridItemList = self:getUserDataTb_()

	self.addEventCb(self, RougeController.instance, RougeEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
end

function RougeMapCollectionLossRightItem:onClickSelf()
	RougeLossCollectionListModel.instance:deselectMo(self.mo)
end

function RougeMapCollectionLossRightItem:update(index, mo)
	self.mo = mo
	self.collectionId = self.mo.collectionId

	RougeCollectionHelper.loadShapeGrid(self.collectionId, self.goGrid, self.goGridItem, self.gridItemList)
	self.simageIcon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(self.collectionId))

	self.txtName.text = RougeCollectionConfig.instance:getCollectionName(self.collectionId)

	self:refreshDesc()
end

function RougeMapCollectionLossRightItem:hide()
	gohelper.setActive(self.go, false)
end

function RougeMapCollectionLossRightItem:show()
	gohelper.setActive(self.go, true)
end

function RougeMapCollectionLossRightItem:refreshDesc()
	local showTypes = RougeCollectionDescHelper.getShowDescTypesWithoutText()

	RougeCollectionDescHelper.setCollectionDescInfos3(self.collectionId, nil, self.txtDesc, showTypes)
end

function RougeMapCollectionLossRightItem:_onSwitchCollectionInfoType()
	self:refreshDesc()
end

function RougeMapCollectionLossRightItem:destroy()
	self.click:RemoveClickListener()
	self.simageIcon:UnLoadImage()
	self:__onDispose()
end

return RougeMapCollectionLossRightItem
