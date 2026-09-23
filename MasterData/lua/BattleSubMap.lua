--子地图

--初始化
function Init(subMapData,gridRes)
    data = subMapData;
    InitGrids(gridRes);
end
--初始化格子
function InitGrids(gridRes)
    grids = {};
    for x = 1,data.h do
        for y = 1,data.w do                     
            local go = CSAPI.CreateGO("BattleMapGridItem",0,0,0,gameObject);
            local lua = ComUtil.GetLuaTable(go);
            lua.Init(this,x,y,gridRes);

            grids[lua.GetID()] = lua;
        end
    end
end
--获取格子
function GetGrid(id)
    if(grids)then
        return grids[id];
    end
end
--获取全部格子
function GetAllGrids()
    return grids;
end

--获取ID
function GetID()
    return data.id;
end

--宽度
function Width()
    return data.w;
end
--高度
function Height()
    return data.h;
end

--获取格子数据
function GetGridData(id)
    return data.datas[id];
end
--获取格子ID
function GetGridID(x,y)
    return data.id * 10000 + x * 100 + y;
end

--设置格子亮度状态
function SetGridLightStates(list,state,startGridId)   
    local startGrid = startGridId and GetGrid(startGridId);
    local startPosX,startPosY,startPosZ;
    if(startGrid)then
        startPosX,startPosY,startPosZ = CSAPI.GetPos(startGrid.gameObject);
    end

    if(grids)then
        for _,grid in pairs(grids)do
            local gridId = grid.GetID();
            local targetState = list and list[gridId] and state or 0;
            grid.SetLightState(targetState);
--            if(startGrid)then
--                grid.PlayLightAni(startPosX,startPosZ);
--            end
        end
    end            
end


--寻路
--startId：开始位置
--targetId：结束位置
--bans：禁用格子列表，例如：{10101,10203}
--cost：步数限制
--height：高度限制,nil表示忽略高度限制
--ignoreWaterCost：是否忽略水面格子的额外消费
function FindPath(startId,targetId,bans,cost,height,ignoreWaterCost,ignoreGridType)
--    LogError(startId .. " -> " .. targetId .. ",cost:" .. tostring(cost) .. ",height:" .. height);
--    LogError(bans);
    if(startId == targetId)then
        return nil;
    end
    local startGrid = GetGrid(startId);--起点
    local targetGrid = GetGrid(targetId);--终点
    if(not startGrid or not targetGrid)then
        return;
    end
    
    ClearGridsCost();

    startGrid.SetAsStart();
    targetGrid.SetAsTarget();

    cost = cost or 100;
    height = height or -1;

    local findList = {};
    table.insert(findList,startGrid);
    
    for i = 1,200 do        
        if(i > #findList)then          
            break;
        end   

        local currGrid = findList[i];
        local currGridHeight = currGrid.Height();
        local currGridNears = currGrid.GetNears();
        local currGridCost = currGrid.GetCost();        
        if(currGridNears and currGridCost <= cost)then       
               
            for _,grid in ipairs(currGridNears)do
                local gridId = grid.GetID();               
                

                    local validState = grid.GetValidState();
                    if(validState)then--格子是否有效
                        
                        local gridHeight = grid.Height();                
                        if(height < 0 or math.abs(currGridHeight - gridHeight) <= height)then--高度检测
                            local nextCost = currGridCost + grid.GetMyCost();
                            local state = grid.SetGridCost(currGrid,nextCost,ignoreWaterCost);
                            --水面格子会额外增加步数消耗
                            nextCost = grid.GetCost();

                            if(state and nextCost <= cost)then
                                                                  
                                if(grid.IsTarget())then--找到目标格子                                       
                                    return GetPath(grid);
                                end

                                local isBan = bans and bans[gridId];
                                if(not isBan)then--未禁止的格子
                                    if(ignoreGridType or grid.IsCanPass())then--该格子可路过
                                        table.insert(findList,grid);
                                    end
                                end
                                
                            end
                        end

                    
                end
                
            end
        end
    end
end
function GetPath(targetGrid)  
    local path = {};
    for i = 1,100 do
       table.insert(path,1,targetGrid);    
       if(targetGrid.IsStart())then
          break;
       end 
       targetGrid = targetGrid.GetPreGrid();
    end

    return path;
end

--清除格子消耗
function ClearGridsCost()
    if(grids)then
        for _,grid in pairs(grids)do
            grid.ClearCost();
        end
    end
end



--获取目标格子距离为range内的所有格子
--passBans：不可穿过格子单位列表（怪物格子、部分道具格子等）
--targetBans：不可站立列表（友军所在格子、战斗中的怪物格子等）
--cost：步数限制
--height：高度
--ignoreWaterCost：是否忽略水面格子的额外消费
function GetGridsInRange(startId,passBans,targetBans,cost,height,ignoreWaterCost)   
      
    local startGrid = GetGrid(startId);--起点
    if(not startGrid)then
        return;
    end
    
    local targetGrids = {};
    
    ClearGridsCost();

    startGrid.SetAsStart();
    cost = cost or 100;
    height = height or -1;

    local findList = {};
    table.insert(findList,startGrid);
  
    for i = 1,200 do        
        if(i > #findList)then          
            break;
        end   

        local currGrid = findList[i];
        local currGridHeight = currGrid.Height();
        local currGridNears = currGrid.GetNears();
        local currGridCost = currGrid.GetCost();   
        
   
        if(currGridNears and currGridCost <= cost)then       
               
            for _,grid in ipairs(currGridNears)do
                local gridId = grid.GetID();  

                local validState = grid.GetValidState();
                if(validState)then--格子是否有效
                        
                    local gridHeight = grid.Height();                
                    if(height < 0 or math.abs(currGridHeight - gridHeight) <= height)then--高度检测
                        local nextCost = currGridCost + grid.GetMyCost();
                        local state = grid.SetGridCost(currGrid,nextCost,ignoreWaterCost);
                        --水面格子会额外增加步数消耗
                        nextCost = grid.GetCost();

                        if(state)then    
                            
                            --检测是否可到达格子单位
                            local isTargetBan = targetBans and targetBans[gridId];
                            if(not isTargetBan and nextCost <= cost)then    
                                if(grid ~= startGrid)then      
                                    targetGrids[gridId] = grid;  
                                end          
                            end    

                            --检测是否可通过格子单位
                            local isBan = passBans and passBans[gridId];
                            if(not isBan)then--未禁止的格子   

                                if(grid.IsCanPass())then--该格子可路过
                                    table.insert(findList,grid);
                                end
                            end
                        end
                    end

                end
                    
                
            end
        end
    end

    targetGrids[startId] = startGrid;
    return targetGrids;
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  

end
----#End#----