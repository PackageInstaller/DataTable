Loader:Require "MapGrid"

MapMgr = {}
local this = MapMgr

--获取地图
function this:GetMap(mapId)
    self.maps = self.maps or {}
    if (self.maps[mapId] == nil) then
        local fileName = "Map_" .. mapId
        self.maps[mapId] = Loader:Require(fileName)
        Loader:AddReplaceFile(fileName)
    end

    return self.maps[mapId]
end
--获取当前地图
function this:GetCurrMap()
    return self.currMap
end

--初始化地图
function this:Init(mapId)
    self:Reset()

    self.id = mapId
    self.currMap = self:GetMap(mapId)
    if (self.currMap == nil) then
        LogError("找不到地图" .. mapId)
    end

    self:InitGrids()
end
--初始化格子
function this:InitGrids()
    self.grids = {}
    for id, data in pairs(self.currMap) do
        local mapGrid = oo.class(MapGrid)
        mapGrid:Init(data)
        self.grids[id] = mapGrid
    end
end
function this:ResetGrids()
    for _, grid in pairs(self.grids) do
        grid:Reset()
    end
end
--获取指定格子
function this:GetGrid(gridId)
    return self.grids[gridId]
end
--获取目标格子距离为range内的所有格子
--range：范围限制（步数）
--passBanDic：不可穿过列表（怪物格子、道具格子、障碍物格子）
--targetBanDic：不可站立列表（友军所在格子、战斗中的怪物格子、障碍物格子）
--ignoreCost：忽略步数消耗，固定消耗1
--height：高度
--moveType：移动类型
function this:GetGridsInRange(gridId, range, passBanDic, targetBanDic, ignoreCost, height, moveType)
    if (gridId == nil or range == nil) then
        return nil
    end

    height = height or 0
    --LogError(height);
    ignoreCost = true
    local list = nil
    if (self.currMap == nil) then
        LogError("战棋地图未初始化")
        return nil
    end

    local targetGridData = self.currMap[gridId]
    if (targetGridData == nil) then
        LogError("当前战棋地图找不到格子" .. gridId)
        return nil
    end

    --local originHeight = targetGridData.height or 0;

    local currList = {gridId}
    local costList = {[gridId] = 0}
    local nextList = nil

    for i = 1, 1000 do
        if (currList == nil) then
            break
        end

        for _, exitId in ipairs(currList) do
            local exitGrid = self.currMap[exitId]
            local exitHeight = exitGrid.height or 0
            local cost = costList[exitId]

            --local heightMatch = math.abs(exitHeight - originHeight) <= height;

            if (targetBanDic == nil or targetBanDic[exitId] == nil) then --判定是否可以站位
                if (exitId ~= gridId) then
                    list = list or {}
                    list[exitId] = 1
                end
            end

            if (exitId == gridId or passBanDic == nil or passBanDic[exitId] == nil) then --判定是否可以穿过
                local subExits = exitGrid.exits
                if (subExits) then
                    for _, subExitId in ipairs(subExits) do
                        local subExitGrid = self.currMap[subExitId]
                        local subExitHeight = subExitGrid.height or 0
                        local heightMatch = math.abs(exitHeight - subExitHeight) <= height
                        --高度符合
                        if (heightMatch) then
                            local exitGridCosts = exitGrid.costs

                            local subExitCost = ignoreCost and 1 or (exitGridCosts and exitGridCosts[subExitId] or 1)
                            if (subExitGrid.water and moveType ~= eMoveType.Water) then
                                subExitCost = subExitCost + 1
                            end

                            local finalCost = cost + subExitCost
                            if (finalCost <= range) then --检测是否超出步数消耗限制
                                local lastCost = costList[subExitId]
                                if (lastCost == nil or finalCost < lastCost) then
                                    nextList = nextList or {}
                                    table.insert(nextList, subExitId)
                                    costList[subExitId] = finalCost
                                end
                            end
                        end
                    end
                end
            end
        end

        currList = nextList
        nextList = nil
    end

    return list
end

--重置
function this:Reset()
    self.id = nil
    self.currMap = nil
    self.grids = nil
end
--获取地图ID
function this:GetMapID()
    return self.id
end

--获取路径
--startId：起点
--targetId：目标点
--bans：禁用格子列表，例如：{1000,1002}
--height：高度
--moveType：移动类型
function this:FindPath(startId, targetId, bans, ignoreCost, height, moveType)
    if (startId == nil or targetId == nil) then
        LogError("获取路径失败！无效起始点或目标点")
        LogError(startId)
        LogError(targetId)
        return nil
    end
    if (startId == targetId) then
        return nil
    end
    ignoreCost = true
    height = height or 0

    --重置格子状态
    self:ResetGrids()

    --起点
    local startGrid = self:GetGrid(startId)
    startGrid:SetAsStart()

    --local originHeight = startGrid.height or 0;

    --目标点
    local targetGrid = self:GetGrid(targetId)
    targetGrid:SetAsTarget()

    --遍历列表
    local findList = {}
    --已添加进列表的格子
    local findAddedIdList = {}

    table.insert(findList, startGrid)
    findAddedIdList[startId] = 1

    --调整禁用格子格式
    local banList = nil
    if (bans) then
        banList = {}
        for _, gridId in ipairs(bans) do
            banList[gridId] = 1
        end
    end

    --当前找到路径距离
    local currFindPathDistance = -1

    for i = 1, 200 do
        if (i > #findList) then
            break
        end

        local currGrid = findList[i]
        local currGridDis = currGrid:GetDistance()

        local currHeight = currGrid.height or 0
        --local heightMatch = math.abs(currHeight - originHeight) <= height;
        --LogError("寻找格子" .. currGrid:GetId() .. "距离" .. currGridDis)
        --LogError("跨越高度：" .. height);
        if (currFindPathDistance < 0 or currGridDis < currFindPathDistance) then
            local isFind = currGrid:Find(banList, ignoreCost, height, moveType)
            if (isFind) then
                local newDistance = targetGrid:GetDistance()
                --LogError("新距离" .. newDistance);
                if (currFindPathDistance < 0 or newDistance < currFindPathDistance) then
                    currFindPathDistance = newDistance
                end
            end

            local currGridExits = currGrid:GetData().exits
            if (currGridExits ~= nil) then
                for _, exitId in ipairs(currGridExits) do
                    if (banList == nil or banList[exitId] == nil) then
                        if (findAddedIdList[exitId] == nil) then
                            local tmpGrid = self:GetGrid(exitId)

                            local tmpGridHeight = tmpGrid.height or 0
                            local heightMatch = math.abs(currHeight - tmpGridHeight) <= height
                            if (heightMatch) then
                                table.insert(findList, tmpGrid)
                                findAddedIdList[exitId] = 1
                            end
                        end
                    end
                end
            end
        end
    end

    return targetGrid:GetPath()
end

return this
