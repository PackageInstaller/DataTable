-- Instantiate = UnityEngine.GameObject.Instantiate
-- GameObject = UnityEngine.GameObject

require "class"
---@class BaseMap:BaseClass
local BaseMap = class("BaseMap")
local MapBlock = require "MapBlock"


--战斗角色
function BaseMap:ctor()
	LuaLogger.ds("BaseMap ctor")
	self:init()
end

function BaseMap:init()
	self.minCols = 1
	self.minRows = 1
	self.maxCols = 8
	self.maxRows = 12
	self.fullMaxCols = 8
	self.fullMaxRows = 12
	self.ratio = 1
	self.offsetX = 0
	self.offsetY = 0
	self.offsetZ = 0
	---@type table<integer, MapBlock>
	self.blocks = {}
	self.centralBlockId = nil
	self._directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}} -- 上下左右四个方向
end

---@class MapBlockData
---@field id integer
---@field cid integer?
---@field col integer
---@field row integer
---@field terrain integer
---@field roleId integer?
---@field terrainCfgData MapTerrainTypeTable
---@field blockTorpedo boolean 

---工厂方法：创建地块实例，子类可覆盖以返回特定地块类型
---@param blockData MapBlockData
---@return MapBlock
function BaseMap:createBlock(blockData)
	return MapBlock:new(blockData)
end

---初始化战斗地图
---@param levelConfig PveLevelTable 关卡配置
---@param callback function? 回调函数
function BaseMap:initMap(levelConfig, callback)
	LuaLogger.ds("BaseMap:initMap")

	self.testMapData = {}
	self.blocks = {}

    local mapConfig = Config.GetBattleMapInfo(levelConfig.BattleMapId)
	local mapData = self:readMapFile(mapConfig.mapInfo)
	
	local parameter = mapData.parameter
	local startBlockData = mapData.mapinfo[levelConfig.startPosId]
	self.minCols = startBlockData.gridZ
	self.minRows = startBlockData.gridX
	self.maxCols = levelConfig.numY--parameter.y_Num
	self.maxRows = levelConfig.numX--parameter.x_Num
	self.fullMaxCols = parameter.y_Num
	self.fullMaxRows = parameter.x_Num
	self.ratio = parameter.ratio
	self.offsetX = parameter.x_offset or 0
	self.offsetY = parameter.y_offset or 0
	self.offsetZ = parameter.z_offset or 0
	for _, data in ipairs(mapData.mapinfo) do
		---@type MapBlockData
		local blockData = {}
		local col = data.gridZ - 1
		local row = data.gridX - 1
		blockData.id = self:getFullBlockId(col, row)
		blockData.cid = data.tileKey
		blockData.col = col
		blockData.row = row
		blockData.terrain = data.obstruct
		blockData.roleId = nil
		local terrainData = Config.GetMapTerrainTypeInfo(blockData.terrain)
		blockData.terrainCfgData = terrainData
		blockData.blockTorpedo = terrainData.isBlock == 1
		local block = self:createBlock(blockData)
		self.blocks[block.id] = block
	end

	self.centralBlockId = self:blockCidToId(levelConfig.CentralPosition)
end

function BaseMap:initPVMap(mapId, callback)
	LuaLogger.ds("BaseMap:initPVMap")
	self.testMapData = {}
	self.blocks = {}

	local mapConfig = Config.GetBattleMapInfo(mapId)
	local mapData = self:readMapFile(mapConfig.mapInfo)
	local parameter = mapData.parameter
	local startBlockData = mapData.mapinfo[1]
	self.minCols = startBlockData.gridZ
	self.minRows = startBlockData.gridX
	self.maxCols = parameter.y_Num
	self.maxRows = parameter.x_Num
	self.fullMaxCols = parameter.y_Num
	self.fullMaxRows = parameter.x_Num
	self.ratio = parameter.ratio
	self.offsetX = parameter.x_offset or 0
	self.offsetY = parameter.y_offset or 0
	self.offsetZ = parameter.z_offset or 0

	for _, data in ipairs(mapData.mapinfo) do
		---@type MapBlockData
		local blockData = {}
		blockData.id = self:getBlockId(data.gridZ - 1, data.gridX - 1)
		blockData.cid = data.tileKey
		blockData.col = data.gridZ - 1
		blockData.row = data.gridX - 1
		blockData.terrain = data.obstruct
		blockData.roleId = nil
		local terrainData = Config.GetMapTerrainTypeInfo(blockData.terrain)
		blockData.terrainCfgData = terrainData
		blockData.blockTorpedo = terrainData.isBlock == 1
		local block = self:createBlock(blockData)
		self.blocks[block.id] = block
	end

	self.centralBlockId = 1

	if callback then
		callback()
	end
end

---导出关卡地图数据文件
function BaseMap:exportMapFile(mapData)
	local file = io.open(Config.LevelLuaPath.."levelMap_10110.lua","w")
	io.output(file)
	-- tablex.dumpSetting.ShowQuote = true
	tablex.dumpSetting.ShowIndex = false
	io.write("return " .. tablex.dump(mapData))
	io.close()
end

---读取地图数据文件
function BaseMap:readMapFile(fileName)
	local mapData = tablex.clone(require(fileName))
	return mapData
end

function BaseMap:getBlocks()
	return self.blocks
end

---@param blockId integer 地块实例化id
---@return MapBlock?
function BaseMap:getBlockById(blockId)
	return self.blocks[blockId]
end

---@param cid integer
---@return MapBlock?
function BaseMap:getBlockByCid(cid)
	for _, block in pairs(self.blocks) do
		if (block.cid == cid) then
			return block
		end
	end
	return nil
end

---@param col integer
---@param row integer
---@return MapBlock?
function BaseMap:getBlock(col, row)
	local blockId = self:getBlockId(col, row)
    if blockId >= 0 then
        return self:getBlockById(blockId)
    end
	return nil
end

function BaseMap:getRandomBlock()
	return self.blocks[math.floor(UnityEngine.Random.Range(1,#self.blocks))]
end

---@return integer
function BaseMap:getBlockId(col, row)
	if (row >= self.minRows - 1) and (row < self.minRows - 1 + self.maxRows) and
		(col >= self.minCols - 1) and (col < self.minCols - 1 + self.maxCols) then
		return row * self.fullMaxCols + col + 1
	else
		-- LuaLogger.es("不在地图范围内，检查输入值", col, row)
		return -1
	end
end
function BaseMap:getFullBlockId(col, row)
	if (row >= 0) and (row < self.fullMaxRows) and
		(col >= 0) and (col < self.fullMaxCols) then
		return row * self.fullMaxCols + col + 1
	else
		-- LuaLogger.es("不在地图范围内，检查输入值", col, row)
		return -1
	end
end

function BaseMap:blockCidToId(cid)
	for _, block in pairs(self.blocks) do
		if (block.cid == cid) then
			return block.id
		end
	end
	LuaLogger.ws("BaseMap:blockCidToId wrong cid", cid)
	return nil
end

function BaseMap:getCentralBlock()
	return self:getBlockById(self.centralBlockId)
end

---获取地块之间的距离
---@param blockA MapBlock
---@param blockB MapBlock
---@return integer distance 距离
function BaseMap:getDistance(blockA, blockB)
	local distance = math.abs(blockA.col - blockB.col) + math.abs(blockA.row - blockB.row)
	return distance
end

function BaseMap:isBlockInList(blockList, blockData)
	return tablex.any(blockList, function(i) return i.blockId == blockData.blockId end)
end

---检测两个格子之间的距离
---@param block1 MapBlock
---@param block2 MapBlock
---@return integer
function BaseMap:checkDistanceBetweenTwoBlock(block1, block2)
	local colDis = math.abs(block1.col - block2.col)
	local rowDis = math.abs(block1.row - block2.row)
	return colDis + rowDis
end

function BaseMap:clear()
	self:init()
end

return BaseMap