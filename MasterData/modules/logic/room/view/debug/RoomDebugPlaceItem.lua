-- chunkname: @modules/logic/room/view/debug/RoomDebugPlaceItem.lua

module("modules.logic.room.view.debug.RoomDebugPlaceItem", package.seeall)

local RoomDebugPlaceItem = class("RoomDebugPlaceItem", ListScrollCellExtend)

function RoomDebugPlaceItem:onInitView()
	self._icon = gohelper.onceAddComponent(gohelper.findChild(self.viewGO, "icon"), gohelper.Type_RawImage)
	self._txtdefineid = gohelper.findChildText(self.viewGO, "#txt_defineid")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._txtuseCount = gohelper.findChildText(self.viewGO, "#txt_useCount")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomDebugPlaceItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugReplaceBlock, self._delayUpdateTask, self)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugRootOutBlock, self._delayUpdateTask, self)
end

function RoomDebugPlaceItem:removeEvents()
	self._btnclick:RemoveClickListener()
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugReplaceBlock, self._delayUpdateTask, self)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugRootOutBlock, self._delayUpdateTask, self)
end

function RoomDebugPlaceItem:_btnclickOnClick()
	RoomDebugPlaceListModel.instance:setSelect(self._mo.id)
end

function RoomDebugPlaceItem:_editableInitView()
	self._isSelect = false

	gohelper.addUIClickAudio(self._btnclick.gameObject, AudioEnum.UI.UI_Common_Click)
end

function RoomDebugPlaceItem:_refreshUI()
	self._txtdefineid.text = "资源id：" .. self._mo.id
	self._txtname.text = RoomHelper.getBlockPrefabName(self._mo.config.prefabPath)
	self._txtuseCount.text = string.format("使用总次数：%s\n本地图次数：%s", RoomDebugController.instance:getUseCountByDefineId(self._mo.id), self:_getMapUseCountByDefineId(self._mo.id))
end

function RoomDebugPlaceItem:_getMapUseCountByDefineId(defineId)
	local blockMOList = RoomMapBlockModel.instance:getFullBlockMOList()
	local count = 0

	for i, blockMO in ipairs(blockMOList) do
		if blockMO.blockState == RoomBlockEnum.BlockState.Map and blockMO.blockId > 0 and blockMO.defineId == defineId then
			count = count + 1
		end
	end

	return count
end

function RoomDebugPlaceItem:_delayUpdateTask()
	if not self._hasDelayUpdateTask then
		self._hasDelayUpdateTask = true

		TaskDispatcher.runDelay(self._onRunDelayUpdateTask, self, 0.1)
	end
end

function RoomDebugPlaceItem:_onRunDelayUpdateTask()
	if self._hasDelayUpdateTask then
		self._hasDelayUpdateTask = false

		self:_refreshUI()
	end
end

function RoomDebugPlaceItem:onUpdateMO(mo)
	gohelper.setActive(self._goselect, self._isSelect)

	if self._mo then
		self._mo = mo

		self:_refreshBlock(mo and mo.blockId)
		self:_refreshUI()
	end
end

function RoomDebugPlaceItem:_refreshBlock(blockId)
	local scene = GameSceneMgr.instance:getCurScene()
	local oldBlockId = self._lastOldBlockId

	self._lastOldBlockId = blockId

	if oldBlockId then
		scene.inventorymgr:removeBlockEntity(oldBlockId)
	end

	gohelper.setActive(self._icon, blockId and true or false)

	if blockId then
		scene.inventorymgr:addBlockEntity(blockId)

		local index = scene.inventorymgr:getIndexById(blockId)

		OrthCameraRTMgr.instance:setRawImageUvRect(self._icon, index)
	end
end

function RoomDebugPlaceItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)

	self._isSelect = isSelect
end

function RoomDebugPlaceItem:onDestroyView()
	self:_refreshBlock(nil)
	TaskDispatcher.cancelTask(self._onRunDelayUpdateTask, self)
end

return RoomDebugPlaceItem
