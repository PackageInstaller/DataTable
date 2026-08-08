require "class"

---@class CoveRoomManager
local CoveRoomManager = class("CoveRoomManager")
local CoveRoom = require "CoveRoom"

function CoveRoomManager:ctor(...)
	LuaLogger.ds("CoveRoomManager ctor")
	self._coveMgr = nil
	self._roomList = {} --场景中的房间列表
end

---实例化
---@return CoveRoomManager CoveRoomManager
function CoveRoomManager.instance()
	if (CoveRoomManager._instance == nil) then
		CoveRoomManager._instance = CoveRoomManager:new()
	end
	return CoveRoomManager._instance
end

function CoveRoomManager:init(coveMgr)
	self._coveMgr = coveMgr
	self:initRooms()
end

---根据配置初始化房间
function CoveRoomManager:initRooms()
	local scene = self._coveMgr:getScene()
	local roomData
	local constructionConfig = Config.GetAllConfig("ConstructionTable")
	for constructId, constructCfg in pairs(constructionConfig) do
		if constructCfg.workLocation and constructCfg.workLocation ~= 0 then
			local index = constructCfg.workLocation
			local room = nil
			if scene.rooms:ContainsKey(constructCfg.workLocation) then
				room = scene.rooms[index]
			end

			if room ~= nil then
				roomData = self:getRoomData(constructCfg, room)
				self:createRoom(roomData)
			end

		end
	end
end

function CoveRoomManager:getRoomData(constructCfg, room)
	local data = {
		constructCfg = constructCfg,
		maxRoleNum = room.Count,
		targetList = room
	}
	return data
end

function CoveRoomManager:createRoom(roomData)
	local room = CoveRoom:new(roomData)
	table.insert(self._roomList, room)
end

---获取房间数据 CoveRoom
function CoveRoomManager:getRoom(id)
	for _, room in ipairs(self._roomList) do
		if (room.id == id) then
			return room
		end
	end
	LuaLogger.e("getRoom Fail id:"..id)
	return nil
end

---获取空房间
function CoveRoomManager:getVacantRooms()
	local list = {}
	for _, room in ipairs(self._roomList) do
		if (not room:isFull()) then
			table.insert(list, room)
		end
	end
	return list
end

---根据权重获取随机的房间
function CoveRoomManager:getRandomRoom(roleId, lastRoomId)


	local totalWight = 0
	local roomList = {}
	for _, room in ipairs(self._roomList) do
		--未满 喜欢的房间可与上一回合房间相同，不喜欢的房间不能
		if room:isWorkArea() == false and room:isFull() == false and (lastRoomId ~= room.id or room:isFavour(roleId) == true) then
			local wight = room:getRandomWight(roleId)
			local data = {
				room = room,
				wight = wight,
			}
			totalWight = totalWight + wight
			table.insert(roomList, data)
		end
	end
	local compareWight = math.random(1, totalWight)
	local index = 1
	while totalWight > 0 do
		totalWight = totalWight - roomList[index].wight
		if totalWight < compareWight then
			
			return roomList[index].room
		end
		index = index + 1
	end

	return nil
end



function CoveRoomManager:getRoomWithRoomId(roleId, roomId)

	for _, room in ipairs(self._roomList) do
		if room.id == roomId then
			return room
		end
	end
	return  nil
end
function CoveRoomManager:getPointInfo(pointId)
	if not pointId then
		return
	end

	local data = {}
	local areaId = math.floor(pointId / 100000)
	local index = pointId % 100000
	for _, room in ipairs(self._roomList) do
		if room.constructCfg.workLocation == areaId then
			data.target = room:getTargetByPointId(pointId)
			data.effectList = Config.GetHomeMovePointInfo(pointId)
		end
	end
	return data
end


function CoveRoomManager:GetRoomId(pointId)
	if not pointId then
		return 0
	end
	local roomId = math.floor(pointId / 100000)
	return roomId
end

function CoveRoomManager:removeRoom(room)
	for i = #self._roomList, 1, -1 do
		if (self._roomList[i].id == room.id) then
			table.remove(self._roomList, i)
		end
	end
	room:removeRoom()
end

function CoveRoomManager:removeAllRoom()
	for _, room in ipairs(self._roomList) do
		room:removeRoom()
	end
	self._roomList = {}
end

function CoveRoomManager:clear()
	self:removeAllRoom()
end

return CoveRoomManager