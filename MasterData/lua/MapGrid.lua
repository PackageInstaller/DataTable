MapGrid = oo.class();
local this = MapGrid;

function this:Init(gridData)
    self:Reset();

    self.data = gridData;
end

--重置
function this:Reset()
    self.isStart = nil;
    self.isTarget = nil;
    self.distance = -1;
    self.preGrids = {};
end
--获取id
function this:GetId()
    return self.data.id;
end
--获取数据
function this:GetData()
    return self.data;
end

--设置为起点
function this:SetAsStart()
    self.isStart = 1;
    self:SetDistance(0);
end
--是否起点
function this:IsStart()
    return self.isStart;
end

--设置为目标
function this:SetAsTarget()
    self.isTarget = 1;
end
--是否目标
function this:IsTarget()
    return self.isTarget;
end

--设置距离
function this:SetDistance(dis)
    self.distance = dis;
end
--获取距离
function this:GetDistance()
    return self.distance;
end

--寻找目标
function this:Find(banList,ignoreCost,height,moveType)
    if(self.data.exits == nil or #self.data.exits == 0)then
        return false;
    end
    height = height or 0;
    local myHeight = self.data.height or 0;
    local isFind = false;
    for _,exitId in ipairs(self.data.exits)do
        if(banList == nil or banList[exitId] == nil)then       
            local exitGrid = MapMgr:GetGrid(exitId);               

            local exitHeight = exitGrid.data.height or 0;
            local heightMatch = math.abs(myHeight - exitHeight) <= height; 

            local costs = self.data and self.data.costs;
            local cost = ignoreCost and 1 or (costs and costs[exitId] or 1); 

             if(heightMatch)then                
                if(exitGrid:IsTarget())then
                    isFind = true;
                end 

                if(exitGrid.data.water and moveType ~= eMoveType.Water)then
                    cost = cost + 1;
                end
            else
                cost = 999;
            end

            exitGrid:SetGridDistance(self,self.distance + cost); 

            --LogError(self:GetId() .. ":" .. myHeight .. " -> " .. exitId .. ":" .. exitHeight .. "  =" .. (heightMatch and "是" or "否"));              
        end 
    end
    return isFind;
end

--设置格子距离
function this:SetGridDistance(preGrid,dis)
    if(self.distance >= 0)then
        if(dis > self.distance)then
            return;
        elseif(dis < self.distance)then
            self.preGrids = {};
        end
    end
    self:SetDistance(dis);
    table.insert(self.preGrids,preGrid);
end
function this:GetPreGrids()
    return self.preGrids;
end

--获取路径
function this:GetPath()
    --LogError(self.preGrids);
    local paths = nil;
    local id = self:GetId();
    if(self:IsStart())then
        paths = { id };
    else
        if(self.preGrids and #self.preGrids > 0)then
            paths = self.preGrids[1]:GetPath();   
            if(paths)then
                table.insert(paths,id);
            end   
        end
    end

    return paths;
end

return this;