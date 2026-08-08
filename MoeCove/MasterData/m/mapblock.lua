
require "class"
---@class MapBlock:BaseClass
local MapBlock = class("MapBlock")

--地图地块基类
---@param blockData MapBlockData
function MapBlock:ctor(blockData)
    ---@type integer
    self.id = blockData.id
    ---@type integer 地格所在地图cid
    self.cid = blockData.cid
    self.col = blockData.col
    self.row = blockData.row
    self.terrain = blockData.terrain
    self.terrainCfgData = blockData.terrainCfgData
end

function MapBlock:getPosition()
    return Vector3.New(self.col, self.row, 0)
end

return MapBlock
