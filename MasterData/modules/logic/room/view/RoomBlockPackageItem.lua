-- chunkname: @modules/logic/room/view/RoomBlockPackageItem.lua

module("modules.logic.room.view.RoomBlockPackageItem", package.seeall)

local RoomBlockPackageItem = class("RoomBlockPackageItem", ListScrollCellExtend)

function RoomBlockPackageItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomBlockPackageItem:addEvents()
	return
end

function RoomBlockPackageItem:removeEvents()
	return
end

function RoomBlockPackageItem:_editableInitView()
	self._go = self.viewGO
	self._goitem = gohelper.findChild(self.viewGO, "item")
	self._txtnum = gohelper.findChildText(self.viewGO, "item/txt_num")
	self._txtdegree = gohelper.findChildText(self.viewGO, "item/txt_degree")
	self._imagerare = gohelper.findChildImage(self.viewGO, "item/image_rare")
	self._txtname = gohelper.findChildText(self.viewGO, "item/txt_name")
	self._goreddot = gohelper.findChild(self.viewGO, "item/txt_name/go_reddot")
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._btnItem = gohelper.findChildButtonWithAudio(self.viewGO, "item")
	self._goempty = gohelper.findChild(self.viewGO, "item/go_empty")
	self._simagedegree = gohelper.findChildImage(self.viewGO, "item/txt_degree/icon")

	self._btnItem:AddClickListener(self._btnitemOnClick, self)
	UISpriteSetMgr.instance:setRoomSprite(self._simagedegree, "jianshezhi")
	self:_onInit(self.viewGO)
end

function RoomBlockPackageItem:removeEventListeners()
	self._btnItem:RemoveClickListener()
end

function RoomBlockPackageItem:_btnitemOnClick()
	RoomHelper.hideBlockPackageReddot(self._packageId)
	RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlockPackage, self._packageId)
end

function RoomBlockPackageItem:getGO()
	return self._go
end

function RoomBlockPackageItem:setShowIcon(isShowIcon)
	self._isShowIcon = isShowIcon
end

function RoomBlockPackageItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goselect, isSelect)
	self:_onSelectUI()
end

function RoomBlockPackageItem:onUpdateMO(mo)
	self._showPackageMO = mo

	self:setPackageId(mo.id)
end

function RoomBlockPackageItem:getPackageId()
	return self._packageId
end

function RoomBlockPackageItem:setPackageId(packageId)
	self._packageId = packageId
	self._packageCfg = RoomConfig.instance:getBlockPackageConfig(packageId) or nil
	self._packageMO = RoomInventoryBlockModel.instance:getPackageMOById(packageId)
	self._blockNum = self._packageMO and self._packageMO:getUnUseCount() or 0

	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.RoomBlockPackage, self._packageId)
	self:_refreshUI()
end

function RoomBlockPackageItem:_refreshUI()
	if not self._packageCfg then
		return
	end

	self._txtname.text = self._packageCfg.name
	self._txtnum.text = self._blockNum
	self._txtdegree.text = self._packageCfg.blockBuildDegree * self._blockNum

	gohelper.setActive(self._goempty, self._blockNum == 0)
	gohelper.setActive(self._txtnum.gameObject, self._blockNum > 0)
	gohelper.setActive(self._txtdegree.gameObject, self._blockNum > 0)
	self:_onRefreshUI()
end

function RoomBlockPackageItem:onDestroy()
	return
end

function RoomBlockPackageItem:_onInit(go)
	return
end

function RoomBlockPackageItem:_onRefreshUI()
	return
end

function RoomBlockPackageItem:_onSelectUI()
	return
end

return RoomBlockPackageItem
