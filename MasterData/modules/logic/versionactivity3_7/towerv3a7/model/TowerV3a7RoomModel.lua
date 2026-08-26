-- chunkname: @modules/logic/versionactivity3_7/towerv3a7/model/TowerV3a7RoomModel.lua

module("modules.logic.versionactivity3_7.towerv3a7.model.TowerV3a7RoomModel", package.seeall)

local TowerV3a7RoomModel = class("TowerV3a7RoomModel", BaseModel)

function TowerV3a7RoomModel:onInit()
	self:reInit()
end

function TowerV3a7RoomModel:reInit()
	return
end

function TowerV3a7RoomModel:initRoom(map)
	self._chessRoomList = {}
	self._roomConnectDic = {}

	local roomList = GameUtil.splitString2(map, true, "|", "#")

	for i, v in ipairs(roomList) do
		local id1 = v[1]
		local id2 = v[2]

		self._roomConnectDic[id1] = self._roomConnectDic[id1] or {}

		table.insert(self._roomConnectDic[id1], id2)

		self._roomConnectDic[id2] = self._roomConnectDic[id2] or {}

		table.insert(self._roomConnectDic[id2], id1)
		self:_initRoomMo(id1)
		self:_initRoomMo(id2)
	end
end

function TowerV3a7RoomModel:getRoomConnectList()
	return self._roomConnectDic
end

function TowerV3a7RoomModel:_initRoomMo(id)
	if id <= 0 or id > TowerV3a7Enum.MaxRoomCount then
		logError("_initRoomMo room id error:" .. id)

		return
	end

	local roomMo = self._chessRoomList[id]

	if not roomMo then
		roomMo = TowerV3a7RoomMO.New()

		roomMo:init(id)

		self._chessRoomList[id] = roomMo
	end
end

function TowerV3a7RoomModel:addChess(mo)
	local roomMo = self:getRoomMo(mo:getLocation())

	if not roomMo then
		logError("TowerV3a7RoomModel:addChess error roomMo is nil id:" .. mo.id .. " location:" .. mo:getLocation())

		return
	end

	if roomMo:getChessNum() >= TowerV3a7Enum.MaxChessNum then
		logError("TowerV3a7RoomModel:addChess error room is full")

		return
	end

	if roomMo:addChess(mo) then
		TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.AddChessMan, mo)
		TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.GuideAddChessMan, mo.id)
	end
end

function TowerV3a7RoomModel:removeChess(mo)
	local roomMo = self:getRoomMo(mo:getLocation())

	if not roomMo then
		logError("TowerV3a7RoomModel:removeChess error roomMo is nil id:" .. mo.id)

		return
	end

	roomMo:removeChess(mo)
	TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.RemoveChessMan, mo)
end

function TowerV3a7RoomModel:getRoomMo(id)
	return self._chessRoomList[id]
end

function TowerV3a7RoomModel:getRoomList()
	return self._chessRoomList
end

TowerV3a7RoomModel.instance = TowerV3a7RoomModel.New()

return TowerV3a7RoomModel
