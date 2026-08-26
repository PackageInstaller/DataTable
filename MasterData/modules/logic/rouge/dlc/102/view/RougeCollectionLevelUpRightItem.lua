-- chunkname: @modules/logic/rouge/dlc/102/view/RougeCollectionLevelUpRightItem.lua

module("modules.logic.rouge.dlc.102.view.RougeCollectionLevelUpRightItem", package.seeall)

local RougeCollectionLevelUpRightItem = class("RougeCollectionLevelUpRightItem", UserDataDispose)

function RougeCollectionLevelUpRightItem:init(go)
	self:__onInit()

	self.go = go
	self.tr = go:GetComponent(gohelper.Type_RectTransform)

	self:_editableInitView()
end

function RougeCollectionLevelUpRightItem:_editableInitView()
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

function RougeCollectionLevelUpRightItem:onClickSelf()
	RougeCollectionLevelUpListModel.instance:deselectMo(self.mo)
end

function RougeCollectionLevelUpRightItem:update(index, mo)
	self.mo = mo
	self.collectionId = self.mo.collectionId

	RougeCollectionHelper.loadShapeGrid(self.collectionId, self.goGrid, self.goGridItem, self.gridItemList)
	self.simageIcon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(self.collectionId))

	self.txtName.text = RougeCollectionConfig.instance:getCollectionName(self.collectionId)

	self:refreshDesc()
end

function RougeCollectionLevelUpRightItem:hide()
	gohelper.setActive(self.go, false)
end

function RougeCollectionLevelUpRightItem:show()
	gohelper.setActive(self.go, true)
end

function RougeCollectionLevelUpRightItem:refreshDesc()
	local showTypes = RougeCollectionDescHelper.getShowDescTypesWithoutText()

	RougeCollectionDescHelper.setCollectionDescInfos3(self.collectionId, nil, self.txtDesc, showTypes)
end

function RougeCollectionLevelUpRightItem:_onSwitchCollectionInfoType()
	self:refreshDesc()
end

function RougeCollectionLevelUpRightItem:destroy()
	self.click:RemoveClickListener()
	self.simageIcon:UnLoadImage()
	self:__onDispose()
end

return RougeCollectionLevelUpRightItem
