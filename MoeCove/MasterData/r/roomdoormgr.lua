require "class"
local RoomDoor = require("client.Main.Assets.Content.Lua.GameScene.Cove.RoomDoor")

---@class RoomDoorMgr
local RoomDoorMgr = class("RoomDoorMgr")

local doorCfg = {
    [1] = {
		id = GE.RoomDoorType.ElevatorDoor,
		timeType = "elevator",
		ObgName = "Homeland/SuShe_Base/SuSheElevaterDoor",
	},
	[2] = {
		id = GE.RoomDoorType.WeaponDoor,
		timeType = "normal",
		ObgName = "Homeland/HL_Factory/FactoryDoor",
	},
	[3] = {
		id = GE.RoomDoorType.TiDuShiDoor,
		timeType = "normal",
		ObgName = "Homeland/SM_TiDuShi/SM_TiDuShi_DoorFrame/TiDuShiDoor",
	},
}

function RoomDoorMgr:ctor(...)
end

---实例化
---@return RoomDoorMgr RoomDoorMgr
function RoomDoorMgr.instance()
	if (RoomDoorMgr._instance == nil) then
		RoomDoorMgr._instance = RoomDoorMgr:new()
	end
	return RoomDoorMgr._instance
end

function RoomDoorMgr:init(coveMgr)
    ---@type CoveManager
	self._coveMgr = coveMgr
	---@type RoomDoor[]
	self._doorList = {}
	for _, cfg in pairs(doorCfg) do
		self:addDoor(cfg)
	end
end

function RoomDoorMgr:addDoor(cfg)
	if cfg.ObgName == nil then
		return
	end
	-- GameObject.Find 无法找到 inactive 的对象
	-- 改为：用 GameObject.Find 找到根节点，再用 Transform.Find 沿子路径查找
	-- Transform.Find 可以穿透 inactive 的子节点
	local doorObj = nil
	local firstSlash = string.find(cfg.ObgName, "/")
	if firstSlash then
		local rootName = string.sub(cfg.ObgName, 1, firstSlash - 1)
		local subPath  = string.sub(cfg.ObgName, firstSlash + 1)
		local rootGo   = GameObject.Find(rootName)
		if UICommonUtils.Checkobj(rootGo) then
			local trans = rootGo.transform:Find(subPath)
			if trans ~= nil then
				doorObj = trans.gameObject
			end
		end
	else
		doorObj = GameObject.Find(cfg.ObgName)
	end
	if UICommonUtils.Checkobj(doorObj) == false then
		LuaLogger.e("RoomDoorMgr:addDoor not find door obj:"..tostring(cfg.ObgName))
		return
	end
	---@type RoomDoorData
	local doorData = {
		timeType = cfg.timeType,
		obj = doorObj,
	}
	---@type RoomDoor
	local door = RoomDoor:new(doorData)
	self._doorList[cfg.id] = door
end

---@return RoomDoor|nil
function RoomDoorMgr:getDoor(id)
	if self._doorList[id] then
		return self._doorList[id]
	end
	return nil
end

function RoomDoorMgr:clear()
	if self._doorList ~= nil then
		for _, door in pairs(self._doorList) do
			if door ~= nil then
				door:clear()
			end
		end
		self._doorList = nil
	end
end

return RoomDoorMgr