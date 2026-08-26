-- chunkname: @modules/logic/rouge/dlc/102/view/RougeCollectionLevelUpLeftItem.lua

module("modules.logic.rouge.dlc.102.view.RougeCollectionLevelUpLeftItem", package.seeall)

local RougeCollectionLevelUpLeftItem = class("RougeCollectionLevelUpLeftItem", ListScrollCell)

function RougeCollectionLevelUpLeftItem:init(go)
	self.go = go
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

function RougeCollectionLevelUpLeftItem:onClickSelf()
	if not RougeCollectionLevelUpListModel.instance:checkCanSelect() then
		return
	end

	gohelper.setActive(self.go, false)

	local removeComp = self._view.viewContainer:getListRemoveComp()

	removeComp:removeByIndex(self._index, self.onRemoveAnimDone, self)
end

function RougeCollectionLevelUpLeftItem:onRemoveAnimDone()
	RougeCollectionLevelUpListModel.instance:selectMo(self.mo)
end

function RougeCollectionLevelUpLeftItem:onUpdateMO(mo)
	self.mo = mo
	self.collectionId = self.mo.collectionId
	self.uid = self.mo.uid

	gohelper.setActive(self.go, true)
	RougeCollectionHelper.loadShapeGrid(self.collectionId, self.goGrid, self.goGridItem, self.gridItemList)
	self.simageIcon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(self.collectionId))

	self.txtName.text = RougeCollectionConfig.instance:getCollectionName(self.collectionId)

	self:refreshDesc()
end

function RougeCollectionLevelUpLeftItem:refreshDesc()
	local showTypes = RougeCollectionDescHelper.getShowDescTypesWithoutText()

	RougeCollectionDescHelper.setCollectionDescInfos3(self.collectionId, nil, self.txtDesc, showTypes)
end

function RougeCollectionLevelUpLeftItem:_onSwitchCollectionInfoType()
	self:refreshDesc()
end

function RougeCollectionLevelUpLeftItem:onDestroy()
	self.click:RemoveClickListener()
	self.simageIcon:UnLoadImage()
end

return RougeCollectionLevelUpLeftItem
