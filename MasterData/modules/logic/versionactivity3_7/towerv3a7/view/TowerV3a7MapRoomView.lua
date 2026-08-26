-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/view/TowerV3a7MapRoomView.lua

module("modules.logic.versionactivity3_7.towerv3a7.view.TowerV3a7MapRoomView", package.seeall)

local TowerV3a7MapRoomView = class("TowerV3a7MapRoomView", BaseView)

function TowerV3a7MapRoomView:onInitView()
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._godragroot = gohelper.findChild(self.viewGO, "#go_dragroot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerV3a7MapRoomView:addEvents()
	return
end

function TowerV3a7MapRoomView:removeEvents()
	return
end

function TowerV3a7MapRoomView:_editableInitView()
	return
end

function TowerV3a7MapRoomView:getDragRoot()
	return self._godragroot
end

function TowerV3a7MapRoomView:onOpen()
	self._mapConfig = TowerV3a7Model.instance:getMapConfig()

	if not self._mapConfig then
		return
	end

	self._roomItemDic = self:getUserDataTb_()
	self._roomCampStatus = {}

	self:_initRoomList()
	self:_initRoomItemList()
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.AddChessMan, self._onAddChessMan, self)
	self.addEventCb(self, TowerV3a7Controller.instance, TowerV3a7Event.RemoveChessMan, self._onRemoveChessMan, self)
	TaskDispatcher.runRepeat(self._frameHandler, self, 0)
end

function TowerV3a7MapRoomView:_frameHandler()
	TowerV3a7RoomMO.setFight(false)

	for k, item in pairs(self._roomItemDic) do
		item:update()

		self._roomCampStatus[k] = item:getCampStatus()
	end

	self:_setFight(TowerV3a7RoomMO.isFight())

	for k, item in pairs(self._roomItemDic) do
		item:updatePath(self._roomCampStatus)
	end

	for i = 1, TowerV3a7Enum.MaxRoomCount do
		local mo = TowerV3a7RoomModel.instance:getRoomMo(i)

		if mo then
			mo:updateChessPathfinding()
		end
	end
end

function TowerV3a7MapRoomView:_setFight(value)
	if self._isFight == value then
		return
	end

	self._isFight = value

	if self._isFight then
		AudioMgr.instance:trigger(TowerV3a7Enum.Audio.StartBattle)
	else
		AudioMgr.instance:trigger(TowerV3a7Enum.Audio.EndBattle)
	end
end

function TowerV3a7MapRoomView:_onAddChessMan(mo)
	local roomItem = self._roomItemDic[mo:getLocation()]

	if roomItem then
		roomItem:addChess(mo)
	else
		logError("roomItem not exist", mo:getLocation())
	end
end

function TowerV3a7MapRoomView:_onRemoveChessMan(mo)
	local roomItem = self._roomItemDic[mo:getLocation()]

	if roomItem then
		roomItem:removeChess(mo)
	else
		logError("roomItem not exist", mo:getLocation())
	end
end

function TowerV3a7MapRoomView:_initRoomItemList()
	for i = 1, TowerV3a7Enum.MaxRoomCount do
		local mo = TowerV3a7RoomModel.instance:getRoomMo(i)

		if mo then
			self:_initRoomItem(i, mo)
		end
	end
end

function TowerV3a7MapRoomView:_initRoomItem(id, roomMo)
	if not self._roomItemDic[id] then
		self._roomItemDic[id] = self._roomItem[id]

		self._roomItemDic[id]:onUpdateMO(roomMo, self)
	end
end

function TowerV3a7MapRoomView:_initRoomList()
	self._roomItem = self:getUserDataTb_()

	local path = self.viewContainer._viewSetting.otherRes.roomItem

	for i = 1, TowerV3a7Enum.MaxRoomCount do
		local roomGo = self:getResInst(path, self._gomap, "room_" .. tostring(i))

		self._roomItem[i] = MonoHelper.addNoUpdateLuaComOnceToGo(roomGo, TowerV3a7RoomItem)
	end
end

function TowerV3a7MapRoomView:onClose()
	TaskDispatcher.cancelTask(self._frameHandler, self)
	AudioMgr.instance:trigger(TowerV3a7Enum.Audio.EndBattle)
end

function TowerV3a7MapRoomView:onDestroyView()
	return
end

return TowerV3a7MapRoomView
