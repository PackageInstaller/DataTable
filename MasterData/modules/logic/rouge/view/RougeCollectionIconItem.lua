-- chunkname: @modules/logic/rouge/view/RougeCollectionIconItem.lua

module("modules.logic.rouge.view.RougeCollectionIconItem", package.seeall)

local RougeCollectionIconItem = class("RougeCollectionIconItem", UserDataDispose)

function RougeCollectionIconItem:ctor(viewGO)
	self:__onInit()

	self.viewGO = viewGO
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._gogridcontainer = gohelper.findChild(self.viewGO, "#go_gridcontainer")
	self._gogrid = gohelper.findChild(self.viewGO, "#go_gridcontainer/#go_grid")
	self._goholetool = gohelper.findChild(self.viewGO, "#go_holetool")
	self._goholeitem = gohelper.findChild(self.viewGO, "#go_holetool/#go_holeitem")
	self._gridList = self:getUserDataTb_()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionIconItem:addEvents()
	return
end

function RougeCollectionIconItem:removeEvents()
	return
end

local defaultPerCellWidth, defaultPerCellHeight = 46, 46

function RougeCollectionIconItem:onUpdateMO(collectionCfgId)
	self._collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

	self._simageicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(collectionCfgId))
	RougeCollectionHelper.loadShapeGrid(collectionCfgId, self._gogridcontainer, self._gogrid, self._gridList)
	gohelper.setActive(self.viewGO, true)
end

function RougeCollectionIconItem:setPerCellSize(perCellWidth, perCellHeight)
	RougeCollectionHelper.computeAndSetCollectionIconScale(self._collectionCfg.id, self._simageicon.transform, perCellWidth, perCellHeight)

	self._perCellWidth = perCellWidth or defaultPerCellWidth
	self._perCellHeight = perCellHeight or defaultPerCellHeight
end

function RougeCollectionIconItem:setCollectionIconSize(width, height)
	recthelper.setSize(self._simageicon.transform, width, height)
end

function RougeCollectionIconItem:setHolesVisible(isVisible)
	gohelper.setActive(self._goholetool, isVisible)
end

function RougeCollectionIconItem:destroy()
	self._simageicon:UnLoadImage()
	self.__onDispose(self, self)
end

return RougeCollectionIconItem
