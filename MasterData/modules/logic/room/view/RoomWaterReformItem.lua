-- chunkname: @modules/logic/room/view/RoomWaterReformItem.lua

module("modules.logic.room.view.RoomWaterReformItem", package.seeall)

local RoomWaterReformItem = class("RoomWaterReformItem", ListScrollCellExtend)
local COLOR_STR = "#BFB5A3"

function RoomWaterReformItem:onInitView()
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._goempty = gohelper.findChild(self.viewGO, "go_empty")
	self._goicon = gohelper.findChild(self.viewGO, "go_icon")
	self._btnItem = gohelper.findChildButtonWithAudio(self.viewGO, "go_icon")
	self._golocked = gohelper.findChild(self.viewGO, "go_locked")
	self._gonum = gohelper.findChild(self.viewGO, "#go_num")
	self._txtnum = gohelper.findChildTextMesh(self.viewGO, "#go_num/#txt_num")
	self._rawImageIcon = gohelper.onceAddComponent(self._goicon, gohelper.Type_RawImage)
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomWaterReformItem:addEvents()
	self._btnItem:AddClickListener(self._onBtnItemClick, self)
	self.addEventCb(self, RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, self._waterReformShowChanged, self)
	self.addEventCb(self, UnlockVoucherController.instance, UnlockVoucherEvent.OnUpdateUnlockVoucherInfo, self._onVoucherInfoChange, self)
	self.addEventCb(self, RoomWaterReformController.instance, RoomEvent.OnRoomBlockReform, self._onRoomBlockReform, self)
end

function RoomWaterReformItem:removeEvents()
	self._btnItem:RemoveClickListener()
	self.removeEventCb(self, RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, self._waterReformShowChanged, self)
	self.removeEventCb(self, UnlockVoucherController.instance, UnlockVoucherEvent.OnUpdateUnlockVoucherInfo, self._onVoucherInfoChange, self)
	self.removeEventCb(self, RoomWaterReformController.instance, RoomEvent.OnRoomBlockReform, self._onRoomBlockReform, self)
end

function RoomWaterReformItem:_onBtnItemClick()
	if not self._mo then
		return
	end

	if self._mo.waterType then
		RoomWaterReformController.instance:selectWaterType(self._mo.waterType)
	elseif self._mo.blockColor then
		RoomWaterReformController.instance:selectBlockColorType(self._mo.blockColor)
	end
end

function RoomWaterReformItem:_waterReformShowChanged()
	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()

	if isWaterReform then
		return
	end

	if self._rawImageIcon then
		self._rawImageIcon.texture = nil
	end

	self:clearItem()
end

function RoomWaterReformItem:_onVoucherInfoChange()
	if not self._mo or not self._mo.blockColor then
		return
	end

	self:_refreshLocked()
end

function RoomWaterReformItem:_onRoomBlockReform()
	self:_refreshNum()
end

function RoomWaterReformItem:_editableInitView()
	gohelper.setActive(self._goempty, false)

	self._rtIndex = OrthCameraRTMgr.instance:getNewIndex()

	OrthCameraRTMgr.instance:setRawImageUvRect(self._rawImageIcon, self._rtIndex)
	SLFramework.UGUI.GuiHelper.SetColor(self._rawImageIcon, COLOR_STR)

	self._scene = GameSceneMgr.instance:getCurScene()
	self._backBlockIds = {}
end

function RoomWaterReformItem:onUpdateMO(mo)
	local newBlockId = mo and mo.blockId

	if self._mo then
		local curBlockId = self._mo.blockId

		if newBlockId and newBlockId ~= curBlockId then
			self:clearItem()

			self._mo = mo

			self:_refreshBlock()
		end

		self:_refreshLocked()
		self:_refreshNum()
	end
end

function RoomWaterReformItem:_refreshBlock()
	if self._mo then
		local blockId = self._mo.blockId

		if not blockId then
			return
		end

		self._scene.inventorymgr:addBlockEntity(blockId, true)

		local index = self._scene.inventorymgr:getIndexById(blockId)

		OrthCameraRTMgr.instance:setRawImageUvRect(self._rawImageIcon, index)
	end
end

function RoomWaterReformItem:_refreshLocked()
	local isUnlock = false

	if self._mo.waterType then
		isUnlock = RoomWaterReformModel.instance:isUnlockWaterReform(self._mo.waterType)
	elseif self._mo.blockColor then
		isUnlock = RoomWaterReformModel.instance:isUnlockBlockColor(self._mo.blockColor)
	end

	gohelper.setActive(self._golocked, not isUnlock)
end

function RoomWaterReformItem:_refreshNum()
	local num = 0

	if self._mo then
		if self._mo then
			num = RoomWaterReformModel.instance:getChangedBlockColorCount(self._mo)
		end

		self._txtnum.text = num

		gohelper.setActive(self._gonum, num > 0)
	end
end

function RoomWaterReformItem:clearItem()
	if self._mo then
		if not self._mo then
			return
		end

		self._scene.inventorymgr:removeBlockEntity(self._mo)

		self._mo = nil
	end
end

function RoomWaterReformItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function RoomWaterReformItem:onDestroyView()
	if self._rawImageIcon then
		self._rawImageIcon.texture = nil
	end

	self:clearItem()
end

return RoomWaterReformItem
