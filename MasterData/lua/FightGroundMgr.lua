--战斗场地
local PlaceholdInfo = require "PlaceholdInfo";


local this = {};

--配置
this.cfg = nil;
--格子列表
this.gridList = nil;

--角色占位关联器
this.putAttacherMgr = nil;

--初始化场地
--myRow：我方排数
--myCol：我方列数
--enemyRow：敌方排数
--enemyCol：敌方列数
function this:InitData(myRow,myCol,enemyRow,enemyCol)    
    local cfg = {myRow = myRow,myCol = myCol,enemyRow = enemyRow,enemyCol = enemyCol,frontGrid = 1};
    self:Init(cfg);
end

--初始化战斗场地
function this:Init(cfg)    
    self.gridList = {};
    self:InitputAttacherMgr();
    self:Clean();

--    if(key == nil or key == "")then
--        return;
--    end

    --Log("开始初始化战斗场地：" .. key);

    self.cfg = cfg;--Cfgs.fight_ground:GetByKey(key);
    --Log(self.cfg);
    if(self.cfg ~= nil)then
      
       local frontGrid = self.cfg.frontGrid;
       --Log(self.cfg.frontGrid);
       local frontGridOffsetCount = (frontGrid and 1) or 0;
       --Log("frontGridOffsetCount:"..frontGridOffsetCount);
        --我方占位从右到左
        --创建我方战斗场地格子
        self:CreateGrids(self.cfg.myRow,self.cfg.myCol,TeamUtil.ourTeamId,false);

        if(frontGrid)then        
            --创建我方召唤区格子，召唤区格子固定为第一排
            self:CreateGrids(1,self.cfg.myCol,TeamUtil.ourTeamId,true);

            --敌方占位从左到右
            --创建敌方召唤区格子，召唤区格子固定为第一排
            self:CreateGrids(1,self.cfg.enemyCol,TeamUtil.enemyTeamId,true);
--            if(IsPvpSceneType(g_FightMgr.type) or g_FightMgr.type == PVPMirror)then
--                self:CreateGrids(1,self.cfg.enemyCol,TeamUtil.enemyTeamId,true);
--            end
        end

        --创建敌方战斗场地格子
        self:CreateGrids(self.cfg.enemyRow,self.cfg.enemyCol,TeamUtil.enemyTeamId,false);
    end

    FightGroundMgr:SetShowState(false);
end

--获取行数数
function this:GetRowCount(teamId)
    if(self.cfg)then
        return TeamUtil:IsEnemy(teamId) and self.cfg.enemyRow or self.cfg.myRow;
    end
    return 0;
end
--获取列数
function this:GetColCount(teamId)
    if(self.cfg)then
        return TeamUtil:IsEnemy(teamId) and self.cfg.enemyCol or self.cfg.myCol;
    end
    return 0;
end

function this:GetCfg()
    return self.cfg;
end

--获取指定排格子
function this:GetGridsByRow(rowIndex,teamId)
    local list = {};
    local colCount = self:GetColCount();
    
    for i = 1,colCount do
        local grid = self:GetGrid(rowIndex,i,teamId);
        if(grid)then
            table.insert(list,grid);
        end
    end

    return list;
end
--获取指定列格子
function this:GetGridsByCol(colIndex,teamId)
    local list = {};
    local rowCount = self:GetRowCount();
    for i = 1,rowCount do
        local grid = self:GetGrid(i,colIndex,teamId);
        if(grid)then
            table.insert(list,grid);
        end
    end

    return list;
end


--初始化角色占位关联器
function this:InitputAttacherMgr()
    if(self.putAttacherMgr == nil)then
        self.putAttacherMgr = AttacherMgr.New("CharacterputAttacherMgr");
    end
end

--创建占位格子（我方，我方召唤区，敌方，敌方召唤区）
--rowCount：排数
--colCount：列数
--gridTeamId：队伍编号
--isFrontGrid：是否召唤区格子
function this:CreateGrids(rowCount,colCount,gridTeamId,isFrontGrid)  

    local centerSpaceGrid = self:GetCenterSpace();


    --方向
    local dir = TeamUtil:GetTeamDir(gridTeamId); --TeamUtil:IsEnemy(gridTeamId) and 1 or -1;
    --第一排偏移数
    local startRowOffsetCount = (((isFrontGrid and 4) or 1) + 0.5) * dir;
    startRowOffsetCount = startRowOffsetCount + centerSpaceGrid * 0.5 * dir;
     --偏移距离
     local xOffset = startRowOffsetCount * self:GetGridSize();
     local yOffset = (colCount - 1) * 0.5 * self:GetGridSize();
     --Log("xOffset:"..xOffset..",yOffset:"..yOffset);    
     

     for rowIndex = 1,rowCount do
         for colIndex = 1,colCount do
            local x,y = self:GetGridLocalPos(rowIndex,colIndex);
            x = x * dir + xOffset;
            y = y + yOffset;

            local goGrid = self:CreateGridGO(gridTeamId);            
            
            local luaFightGrid = ComUtil.GetLuaTable(goGrid);

            local targetIndex = (isFrontGrid and 4) or rowIndex;
            luaFightGrid.Set(targetIndex,colIndex,gridTeamId);
            luaFightGrid.SetPos(x,y);
            local gridKey = luaFightGrid.GetKey();
            self.gridList[gridKey] = luaFightGrid;
         end
     end
end

function this:SetShowState(isShow,teamId)
    CSAPI.SetGOActive(self:GetGridRootGO(),isShow);
    if(isShow)then      
        if(self.teamGridRoots)then
            for id,rootGo in ipairs(self.teamGridRoots)do
                CSAPI.SetGOActive(rootGo,teamId == id);
            end
        end
    end
end

--创建一个格子
function this:CreateGridGO(teamId)
    return CSAPI.CreateGO("FightGrid",0,0,0,self:GetGridRootGO(teamId));
end


--获取格子
--rowIndex：排号
--colIndex：列号
--gridTeamId：队伍编号
function this:GetGrid(rowIndex,colIndex,gridTeamId)
    local gridKey = self:GenGridKey(rowIndex,colIndex,gridTeamId);
    
    local luaFightGrid =  self.gridList and self.gridList[gridKey];
--    if(luaFightGrid == nil)then
--        LogError("找不到格子：(" .. rowIndex .. "," .. colIndex .. "),是否敌方阵营：" .. gridTeamId);
--    end
    return luaFightGrid;
end
--获取全部格子
function this:GetAllGrids()
    return self.gridList;
end

--格子key
--rowIndex：排号（0为召唤区）
--colIndex：列号
--gridTeamId：队伍编号
function this:GenGridKey(rowIndex,colIndex,gridTeamId)
    return gridTeamId  * 10000 + rowIndex * 100 + colIndex;
end

--获取场地中点
--gridTeamId：队伍编号
function this:GetCenter(gridTeamId)
    if(self.cfg == nil)then
        return 0,0,0;
    end

     local isEnemy = TeamUtil:IsEnemy(gridTeamId);
     local rowCount = isEnemy and self.cfg.enemyRow or self.cfg.myRow;
     local center = rowCount * 0.5 + 1 + self:GetCenterSpace() * 0.5;
     local dir = isEnemy and 1 or -1;
     local x = center * dir * self:GetGridSize();
     return x,0,0;
end
--获取场地前
function this:GetFront(gridTeamId)
    local centerSpaceGrid = self:GetCenterSpace();
    local x = centerSpaceGrid * 0.5 * TeamUtil:GetTeamDir(gridTeamId) * self:GetGridSize();
    return x;
end

function this:GetCenterSpace()
    return 0;--fight_ground_center_space or 0;
end

--召唤区是否被占用
function this:IsHoldSummon(teamId)
    local luaFightGrid = self:GetGrid(4,1,teamId);
    if(luaFightGrid ~= nil)then
        return luaFightGrid.IsHold();
    end
    return false;
end
--是否有召唤怪
function this:HasSummon()
    return self:IsHoldSummon(TeamUtil.ourTeamId) or self:IsHoldSummon(TeamUtil.enemyTeamId);
end


--清除战斗场地
function this:Clean()
    self.cfg = nil;
    if(self.gridList)then
        for _,luaFightGrid in pairs(self.gridList) do
            luaFightGrid.Remove();
        end
    end
    self.gridList = {};
end

--判定目标排是否召唤位排
function this:IsSummonRow(rowIndex)
    return rowIndex == 0 or rowIndex == 4;
end
--获取单元格大小
--global_setting表中配置
function this:GetGridSize()
    self.gridSize = self.gridSize or (fight_ground_grid and fight_ground_grid * 0.01);        
    return self.gridSize or 0;
end

--获取格子对象根目录（预先设置好的全局对象，在GameRoot中）
function this:GetGridRootGO(teamId)    
    if(teamId)then
        self.teamGridRoots = self.teamGridRoots or {};
        if(not self.teamGridRoots[teamId])then
            self.teamGridRoots[teamId] = CSAPI.GetGlobalGO("TeamGrid" .. tostring(teamId));
        end
        return self.teamGridRoots[teamId];
    else
        if(self.goGridRoot == nil)then        
            self.goGridRoot = CSAPI.GetGlobalGO("GridRoot");
        end
        return self.goGridRoot;
    end
    
end

--计算格子的相对位置
function this:GetGridLocalPos(rowIndex,colIndex)
    local x = 0;
    local y = 0;    
    local size = self:GetGridSize();
    x = (rowIndex - 1) * size;
    y = -(colIndex - 1) * size;
    --Log("rowIndex："..rowIndex,"colIndex："..colIndex,"x："..x,"y："..y);
    return x,y;
end

--获取角色占位关联器
function this:GetCharacterAttacher(targetCharacter)
    return self.putAttacherMgr:Get(targetCharacter);
end

--放入战斗场地。如果有占位信息列表，排号和列表表示的是第一个占位的位置
--target：目标角色
--rowIndex：排号（0为召唤区）
--colIndex：列号
--gridTeamId：队伍编号
function this:PutIn(target,rowIndex,colIndex,gridTeamId)
    local putInState = false;
    local placeholderList = target.GetPlaceHolderInfo();--占位信息
    local placeholderInfo = PlaceholdInfo.New(rowIndex,colIndex,gridTeamId,placeholderList);

    putInState = placeholderInfo:CheckPutIn();
    if(putInState)then
        CSAPI.SetPos(target.gameObject,placeholderInfo.x,0,placeholderInfo.y);

        local attacher = self.putAttacherMgr:GetOrAdd(target);
        placeholderInfo:PutIn(attacher);
    end
    
    return putInState;
end


--从战斗场地移出
function this:PutOut(target)
    local attacher = self.putAttacherMgr:Get(target);
    if(attacher ~= nil and attacher.list ~= nil)then     
        for _,v in pairs(attacher.list) do
            v:PutOut();
            break;
        end
    end
    self.putAttacherMgr:Remove(target);
end

--检测单个占位能否放入
function this:CheckSinglePutIn(rowIndex,colIndex,gridTeamId)
    local luaFightGrid = self:GetGrid(rowIndex,colIndex,gridTeamId);
    if(luaFightGrid ~= nil)then
        return luaFightGrid.IsHold() == false;
    end
    return false;
end
--检测占位能否放入
function this:CheckPutIn(rowIndex,colIndex,gridTeamId,placeholderInfo)    
    --单占位
    if(placeholderInfo == nil)then
        return self:CheckSinglePutIn(rowIndex,colIndex,gridTeamId);
    end

    local placeholderInfo = PlaceholdInfo.New(rowIndex,colIndex,gridTeamId,placeholderList);
    return placeholderInfo:CheckPutIn();
end

--获取主战区
function this:GetLimitMainFightRange()
    if(self.mainLimit == nil)then
        self.mainLimit = 
        {
            {1,1},{1,2},{1,3},
            {2,1},{2,2},{2,3},
            {3,1},{3,2},{3,3}
        };
    end
    return self.mainLimit;
end

return this;