--格子选择管理器

items = {};
selectItems = {};


--目标队伍id
teamId = 1;
--格子列表
gridList = nil;

--第一个格子位置
firstGrid = nil;

--选中索引值
selRowIndex = nil;
selColIndex = nil;

--当前首格所在索引值
curRowIndex = nil;
curColIndex = nil;

--选择范围限制
selRangeLimit = nil;

function Awake()
    _G.FightGridSelMgr = this;

    InitItems();

    GetSelGoalMgr():Preload();
end

--初始化skillItem
function InitItems()
    items = {};
    selectItems = {};

    transItem = transform:Find("item");
    item = transItem.gameObject;
    CSAPI.SetGOActive(item,false);
end

--创建item
function CreateItems(count)
    local itemCount = #items;
    if(itemCount >= count)then
        return;
    end

    for i = itemCount + 1,count do
        local newItem = CSAPI.CloneGO(item,transform);
        table.insert(items,newItem);

        local transSelectItem = newItem.transform:Find("selected");
        if(transSelectItem ~= nil)then
            local selectGO = transSelectItem.gameObject;
            table.insert(selectItems,selectGO); 
            CSAPI.SetGOActive(selectGO,false);
        end
    end
end

--设置
--targetTeamId：目标队伍
--targetRangeList：范围
--targetRangeLimit：范围限制
--idsLimit：限制目标
--targetCoverCharacterType：覆盖角色类型：1，必须覆盖。2，不允许覆盖。空，都可以
function Show(targetTeamId,targetRangeList,targetRangeLimit,idsLimit,targetCoverCharacterType,isCrossState)   
    selRowIndex = nil;
    selColIndex = nil;   
    curRowIndex = 1;
    curColIndex = 1;

    isCross = isCrossState;

    targetIdsLimit = idsLimit;
    coverCharacterType = targetCoverCharacterType;


    teamId = targetTeamId;

    firstGrid = FightGroundMgr:GetGrid(1,1,teamId);
  
    SetRange(targetRangeList,targetRangeLimit);

    SetDefaultPos();
    if(lastX or lastY or lastZ)then
        SetPos(lastX,lastY,lastZ);          
    end   

    UpdateSelRange();

    UpdateSelGoals();

    FightGroundMgr:SetShowState(true,teamId);

    EventMgr.Dispatch(EventType.Guide_Hint);
    FuncUtil:Call(UpdateHint,nil,1000);    
end

function UpdateHint()
    
    local characters = GetSelCharacterList();
    if(characters)then
        for _,character in pairs(characters)do
            character.ShowHint();
            break;
        end
    end
end

--设置默认位置
function SetDefaultPos()
    local cfgFightGround = FightGroundMgr.cfg;
    if(cfgFightGround == nil)then
        return;
    end
    local isEnemyTeam = TeamUtil:IsEnemy(teamId);
    local rowCount = isEnemyTeam and cfgFightGround.enemyRow or cfgFightGround.myRow;
    local colCount = isEnemyTeam and cfgFightGround.enemyCol or cfgFightGround.myCol;

    for i = 1,rowCount + 1 do
        for j = 1,colCount do
            local rowIndex,colIndex = CalculatePos(i,j);
            local isValid = IsRangeValid(rowIndex,colIndex);
            --LogError(isValid and "有效" or "无效")
            if(isValid)then
                SetRangePos(rowIndex,colIndex);
                --SetSelValidState(false);
                return;
            end
        end
    end        
end

--隐藏
function Hide()
    teamId = nil;
    firstGrid = nil;
    --LogError("输出");
    SetRange();

    UpdateSelGoals();

    FightGroundMgr:SetShowState(false);

    lastX = nil;
    lastY = nil;
    lastZ = nil;
end

--设置范围
function SetRange(targetRangeList,targetRangeLimit)

    gridList = targetRangeList;
    selRangeLimit = targetRangeLimit;

    --范围列表
    if(gridList ~= nil and #gridList == 0)then
        gridList = {{1,1}};
    end
    
    local rangeCount = gridList ~= nil and #gridList or 0;
    CreateItems(rangeCount);
    local count = #items;

    for i = 1,count do
        local rowIndex = nil;
        local colIndex = nil;
        if(gridList ~= nil and gridList[i] ~= nil)then
            rowIndex = gridList[i][1];
            colIndex = gridList[i][2];
        end
        SetItemState(items[i],rowIndex,colIndex);
    end    

     UpdateSelRange();
end

--设置item状态
function SetItemState(targetItem,rowIndex,colIndex)
    local isShow = rowIndex ~= nil and colIndex ~= nil;

    --无召唤物情况下，召唤区选中格子不显示
    if(FightGroundMgr:IsSummonRow(rowIndex) and FightGroundMgr:IsHoldSummon(teamId) == false)then
        isShow = false;
    end 

    --CSAPI.SetGOActive(targetItem,isShow);
    CSAPI.SetGOActive(targetItem,false);

    if(isShow)then
        local dir = TeamUtil:IsEnemy(teamId) and 1 or -1;
        local gridSize = FightGroundMgr:GetGridSize();

        local x = (rowIndex - 1) * gridSize * dir;
        local y = 0;
        local z = (colIndex - 1) * gridSize * -1;
        CSAPI.SetLocalPos(targetItem,x,y,z);
    end
end


function CloseInput(state)
    closeInput = state;
end


--设置位置
function SetPos(x,y,z,targetInputState)
    if(closeInput)then
        return;
    end
    if(firstGrid == nil)then
        --LogError("first grid is nil");
        return;    
    end
--    if(moveCharacter)then
--        UpdateMoveCharacter(x,y,z,targetInputState);
--        return;
--    end

 

    inputState = targetInputState;


    local rowIndex,colIndex = ToNormalRowCol(x,y,z); 
    --LogError( "选择目标格：排" .. rowIndex .. "列" .. colIndex .. "，inputState：" .. inputState);

    if(inputState == 0)then
        if((not rowIndex or rowIndex < 1 or rowIndex > 4) or (not colIndex or colIndex < 1 or colIndex > 3))then
            EventMgr.Dispatch(EventType.Input_Select_Cancel);  
            --CSAPI.PlayUISound("ui_generic_click");            
            return;
        end
    end

    --重新点击选中位置为确认
    if(inputState == 2)then
        if(IsSelectOK(rowIndex,colIndex))then
            EventMgr.Dispatch(EventType.Input_Select_OK); 
        end    
        return;        
    end

    if(FightGroundMgr:IsSummonRow(rowIndex))then
        if(coverCharacterType == 1 and not FightGroundMgr:IsHoldSummon(teamId))then
            return;
        end
    end


    lastX = x;
    lastY = y;
    lastZ = z;

--    LogError("================================");
--    Log( x .. "," .. z);  
--    Log( firstGrid.x .. "," .. firstGrid.y);
--    Log( "选择目标格：排" .. rowIndex .. "列" .. colIndex);

    UpdateSelPos(rowIndex,colIndex);
    CSAPI.PlayUISound("ui_number_battle");
--    if(inputState and IsSelectOK(rowIndex,colIndex))then
--        EventMgr.Dispatch(EventType.Input_Select_OK);   
--        --return;  
--    end
end

function ToNormalRowCol(x,y,z)
    local dir = TeamUtil:GetTeamDir(teamId);

    local gridSize = FightGroundMgr:GetGridSize();

    local xDelta = x - firstGrid.x;
    local zDelta = z - firstGrid.y;

    xDelta = xDelta / gridSize;
    zDelta = zDelta / gridSize;

    local rowIndex = math.floor(xDelta * dir + 0.5) + 1;
    local colIndex = math.floor(zDelta * -1 + 0.5) + 1;
--    if(rowIndex == 4)then
--        rowIndex = 0;
--    end

    return rowIndex,colIndex;
end

--function UpdateMoveCharacter(x,y,z,targetInputState)
--     local rowIndex,colIndex = ToNormalRowCol(x,y,z); 
--    if(targetInputState == 0)then
--        --设置要移动的角色
--        moveTarget = nil;              

--        local targetGrid = FightGroundMgr:GetGrid(rowIndex,colIndex,teamId);
--        if(targetGrid ~= nil)then
--            moveTarget = targetGrid.GetCharacter();
--        end

--        --设置移动目标区域
--        if(moveTarget)then
--            local placeHolderInfo = moveTarget.GetPlaceHolderInfo();  
--            local newRangeLimit = FightGroundMgr:GetLimitMainFightRange();
----            local newRangeLimit = {};
----            local allGrids = FightGroundMgr:GetAllGrids();
----            if(allGrids)then
----                for k,grid in pairs(allGrids)do
----                    if(teamId == grid.teamId)then
----                        local character = grid.GetCharacter();
----                        if(not character or character == moveTarget)then
----                            if(grid.rowIndex > 0)then
----                                table.insert(newRangeLimit,{grid.rowIndex,grid.colIndex});
----                            end
----                        end
----                    end                   
----                end
----            end
--            Show(TeamUtil.ourTeamId,placeHolderInfo,newRangeLimit,nil,2);
--        end
--    elseif(targetInputState == 2)then
--       if(moveTarget)then
--            local lastRowIndex,lastColIndex = moveTarget.GetCoord();
--            if(curRowIndex == lastRowIndex and curColIndex == lastColIndex)then
--                Tips.ShowTips("不能移动到相同位置");
--                moveTarget.ResetPlace();
--                moveTarget = nil;
--                Show(TeamUtil.ourTeamId,{},rangeLimit,nil,1);
--            else
--                local selGrids = GetSelGrids();

--                if(selGrids)then   
--                    local grids = {};
--                    for _,data in pairs(selGrids)do
--                        table.insert(grids,{data.rowIndex,data.colIndex});
--                    end             
--                    moveTarget.ApplyPutIn(grids);
--                    Tips.ShowTips("移动成功");
--                    Hide();
--                end
--            end           
--       end
--       moveTarget = nil;
--    end

--    if(moveTarget)then
--        moveTarget.SetPos(x,y,z);    

--        UpdateSelPos(rowIndex,colIndex);       
--    end
--end

function UpdateSelPos(rowIndex,colIndex)
     local isInRange = IsInRange(rowIndex,colIndex);

    if(isInRange == false)then
        rowIndex,colIndex = CalculatePos(rowIndex,colIndex);
        --LogError("点击位置不在当前选中范围内，重新计算点击位置，排：" .. tostring(rowIndex) .. "，列：" ..tostring(colIndex));
        local isValid = IsRangeValid(rowIndex,colIndex);
        --LogError("点击位置是否有效？" .. tostring(isValid));
        if(isValid)then
            SetRangePos(rowIndex,colIndex);
        end    
    end   
       
    if(selRowIndex ~= rowIndex or selColIndex ~= colIndex)then
        selRowIndex = rowIndex;
        selColIndex = colIndex;

        UpdateSelGoals();   
    end   
end

--计算合适位置
function CalculatePos(rowIndex,colIndex)
    local rowLock = selRowIndex == nil or selRowIndex ~= rowIndex;
    local colLock = selColIndex == nil or selColIndex ~= colIndex;
--    Log( "rowLock:" .. tostring(rowLock) .. ",colLock:" .. tostring(colLock));
--    if(selRowIndex ~= nil and selColIndex ~= nil)then
--         Log( "rowIndex" .. rowIndex .. ",colIndex" .. colIndex);
--         Log( "selRowIndex" .. selRowIndex .. ",selColIndex" .. selColIndex);
--    end

    local targetRowIndex,targetColIndex;
    if(inputState == 1)then
        targetRowIndex,targetColIndex = GetNearest(rowIndex,colIndex,rowLock,colLock); 
    end
    if(targetRowIndex == nil or targetColIndex == nil)then
        --锁定方向未能找到适合的格子，用最近单元格代替
        --LogError("找最近的代替");
        targetRowIndex,targetColIndex = GetNearest(rowIndex,colIndex,false,false); 
    end

--    if(targetRowIndex ~= nil and targetRowIndex ~= nil)then
--        rowIndex = targetRowIndex;--1 - targetRowIndex + rowIndex;
--        colIndex = targetColIndex;--1 - targetColIndex + colIndex;
--    else
--        LogError("没找到合适的格子");
--    end
    return targetRowIndex,targetColIndex;
end

--获取当前选择范围离新目标位置最靠近的格子坐标
--rowIndex：新目标位置排号
--colIndex：新目标位置列号号
--rowLock：排锁定，列号必须一致，即只计算排向的距离
--colLock：列锁定，排号必须一致，即只计算列向的距离
function GetNearest(rowIndex,colIndex,rowLock,colLock)
     --之前没有选中的排或列，这是第一次选择
     if(curRowIndex == nil or curColIndex == nil)then
        if(gridList ~= nil and #gridList > 0)then
            return gridList[1][1],gridList[1][2];
        else
            return 1,1;
        end
    end

    --将新选择的排号和列号转换成当前选择范围的相对位置
    local relRowIndex = rowIndex - curRowIndex + 1;
    local relColIndex = colIndex - curColIndex + 1;
    --Log("将新选择的排号和列号转换成当前选择范围的相对位置：排" .. relRowIndex .. "列" .. relColIndex);
    
    --返回的排号、列号
    local targetRowIndex = nil;
    local targetColIndex = nil;
    
    local distance = nil;
    --LogError("=================================");
    if(gridList)then
        for _,v in pairs(gridList) do
            --范围的单元格与选中位置的偏差
            local rowOffset = v[1] - relRowIndex;
            local colOffset = v[2] - relColIndex;

            if((rowLock == false and colLock == false) --无锁定
            or (rowLock and colOffset == 0) --锁定在排方向
            or (colLock and rowOffset == 0))then --锁定在列方向
                --该格子与选中位置距离
                local curDistance = math.abs(rowOffset) + math.abs(colOffset);
                --Log(v);
                --Log("当前距离：" .. curDistance);
                if(distance == nil or distance > curDistance)then

                    local tempRowIndex = 1 - v[1] + rowIndex;
                    local tempColIndex = 1 - v[2] + colIndex;

                    local isValid = IsRangeValid(tempRowIndex,tempColIndex);
                    --Log(isValid and "有效" or "无效");
                    if(isValid)then
                        distance = curDistance;
                        targetRowIndex = tempRowIndex;
                        targetColIndex = tempColIndex;
                    end                
                end 
            end
        end
    end
    --Log("row:" .. targetRowIndex .. ",col:" .. targetColIndex);
    return targetRowIndex,targetColIndex;
end
--设置选中范围首位置
function SetRangePos(rowIndex,colIndex)
    local xLocal,zLocal = FightGroundMgr:GetGridLocalPos(rowIndex,colIndex);
    xLocal = xLocal * TeamUtil:GetTeamDir(teamId);

    x = firstGrid.x + xLocal;
    z = firstGrid.y + zLocal;
    CSAPI.SetPos(gameObject,x,y,z); 

    curRowIndex = rowIndex;
    curColIndex = colIndex;

    UpdateSelGoals();
end

--是否在选择的范围内
function IsInRange(rowIndex,colIndex)
    if(curRowIndex == nil or curColIndex == nil or gridList == nil)then
        return false;
    end

    rowIndex = rowIndex - curRowIndex + 1;
    colIndex = colIndex - curColIndex + 1;

    for _,v in pairs(gridList) do
        if(rowIndex == v[1] and colIndex == v[2])then
            return true;
        end
    end

    return false;
end


local crossRange = 
{
{-3,1},
{-2,1},
{-1,1},
{0,1},
{1,1},
{0,1},
{1,1},
{2,1},
{3,1},
{1,-3},
{1,-2},
{1,-1},
{1,0},
{1,2},
{1,3}
};

--范围选择是否有效
function IsRangeValid(targetRowIndex,targetColIndex)
    if(gridList == nil or teamId == nil or targetRowIndex == nil or targetColIndex == nil)then
--        Log( gridList == nil and "a1" or "b1");
--        Log( teamId == nil and "a2" or "b2");
--        Log( targetRowIndex == nil and "a3" or "b3");
--        Log( targetColIndex == nil and "a4" or "b4");
        return false;
    end

    --点击的格子不存在
    local clickGrid = FightGroundMgr:GetGrid(targetRowIndex,targetColIndex,teamId);
    if(not clickGrid)then
        return false;
    end


    --限制技能选择范围
    if(selRangeLimit ~= nil)then
        local match = false; 
        for _,v in ipairs(selRangeLimit)do
            local v1 = v[1];
            v1 = (v1 == 0) and 4 or v1;--召唤位兼任0，4
            if(v1 == targetRowIndex and v[2] == targetColIndex)then
                match = true;
                break;
            end
        end
        if(match == false)then
            return false;
        end
    end
    if(coverCharacterType == nil)then
        return true;
    end
    
    if(FightGroundMgr:IsSummonRow(targetRowIndex))then
        if(FightGroundMgr:IsHoldSummon(teamId) == false and coverCharacterType == 1)then
            return false;
        end
    end

    
    --LogError( "排:" .. targetRowIndex .. ",列:" .. targetColIndex)
    --不需要覆盖角色
    --LogError(gridList);
    local targetGridList = gridList;
    if(isCross)then
        targetGridList = crossRange;
        --LogError(targetGridList);
    end

    local isConverCharacter = false;
    for _,v in pairs(targetGridList) do
        local rowIndex = v[1]  + targetRowIndex - 1;
        local colIndex = v[2]  + targetColIndex - 1;
        --LogError("rowIndex:" .. rowIndex .. ",colIndex:" .. colIndex)
        local fightGrid = FightGroundMgr:GetGrid(rowIndex,colIndex,teamId);
        if(fightGrid ~= nil)then
            if(fightGrid.IsHold())then
                --检测目标角色限制
                local character = fightGrid.GetCharacter();

                local  isMovingTarget = moveCharacter and moveTarget and moveTarget == character;

                if(not isMovingTarget)then
                    if(targetIdsLimit ~= nil)then                    
                        if(character ~= nil)then
                            local id = character.GetID();
                            if(targetIdsLimit[id] ~= nil)then
                                isConverCharacter = true;
                            end
                        end
                    else
                        isConverCharacter = true;
                    end
                end
            end
        else
            --LogError("有无效格子");
            if(not isCross)then
                return false;
            end
        end
    end

    if((isConverCharacter and coverCharacterType == 1)
    or (isConverCharacter == false and coverCharacterType == 2))then
        return true;
    end
    return false;
end

--获取选中的角色列表
function GetSelCharacterList()
    if(gridList == nil or teamId == nil or curRowIndex == nil or curColIndex == nil)then
        return nil;
    end
  
    local list = {};

    for _,v in pairs(gridList) do
        local rowIndex = v[1]  + curRowIndex - 1;
        local colIndex = v[2]  + curColIndex - 1;
        --LogError(rowIndex .. "," .. colIndex);
        local fightGrid = FightGroundMgr:GetGrid(rowIndex,colIndex,teamId);
        if(fightGrid ~= nil)then
            local character = fightGrid.GetCharacter();
            if(character ~= nil)then
                local id = character.GetID();
                list[id] = character;
            end
        end       
    end

    return list;
end

--获取选中格子
function GetSelGrids()
    if(gridList == nil or teamId == nil or curRowIndex == nil or curColIndex == nil)then
        return nil;
    end
  
    local list = {};

     for _,v in pairs(gridList) do
        local rowIndex = v[1]  + curRowIndex - 1;
        local colIndex = v[2]  + curColIndex - 1;
        local fightGrid = FightGroundMgr:GetGrid(rowIndex,colIndex,teamId);        

        --LogError(rowIndex .. "," .. colIndex);
        if(fightGrid)then
            local key = fightGrid.GetKey();
            if(list[key] == nil)then
               list[key] = fightGrid; 
               --LogError("选中格子===========");
               --LogError(key)              
            end

            --前排格子
            if(fightGrid.IsFrontGrid())then
                local firstRowGrids = FightGroundMgr:GetGridsByRow(4,teamId);
                for _,firstRowGrid in ipairs(firstRowGrids) do
                    local firstRowGridKey = firstRowGrid.GetKey();
                    if(list[firstRowGridKey] == nil)then
                        list[firstRowGridKey] = firstRowGrid; 
                    end
                end
            end

            local character = fightGrid.GetCharacter();
            
            local isMovingCharacter = moveCharacter and moveTarget == character;
            if(character ~= nil and not isMovingCharacter)then
                local id = character.GetID();
                local placeHolderInfo = character.GetGrids();--GetPlaceHolderInfo();
                
                for _,info in ipairs(placeHolderInfo)do
                    local infoRow = info[1];--rowIndex + info[1] - 1;
                    local infoCol = info[2];--colIndex + info[2] - 1;

                    local characterGrid = FightGroundMgr:GetGrid(infoRow,infoCol,teamId);      
                    if(characterGrid)then  
                        local characterGridKey = characterGrid.GetKey();
                        if(list[characterGridKey] == nil)then
                           list[characterGridKey] = characterGrid;                            
                        end
                    end
                end
            end
        end       
    end
   
    return list;
end

function UpdateSelRange()
    local list = GetSelGrids();   
    local allGrids = FightGroundMgr:GetAllGrids();
 
    if(allGrids)then
        for k,grid in pairs(allGrids)do
            --local gridTeamId = grid.teamId;
            local rowIndex,colIndex = CalculatePos(grid.rowIndex,grid.colIndex);
            local state = teamId == grid.teamId and IsRangeValid(rowIndex,colIndex);
            if(state == false and list and list[k])then                      
                state = true;
            end
            
            if(grid.IsFrontGrid())then--召唤位、无人、不是位置选择
                if(not grid.IsHold() and coverCharacterType ~= 2)then
                    state = false;
                end
            end
            grid.SetSelState(state);
        end
    end
end



function GetSelGoalMgr()
    if(selGoalMgr == nil)then
        selGoalMgr = require "FightSelGoalMgr";
    end   
    return selGoalMgr;
end

function UpdateSelGoals()

    if(moveCharacter and not moveTarget)then
        GetSelGoalMgr():UpdateSelGrids();
        return;
    end 

    local characters = GetSelCharacterList();

    if(coverCharacterType == 2)then
        local selGrids = GetSelGrids();
        --LogError(selGrids);
        selGoalMgr:UpdateSelGrids(selGrids);
    else       
              
        selGoalMgr:UpdateSelGoals(characters);

        local selGrids = GetSelGrids();
        local targetGrids = {};
        if(selGrids)then
            for gridId,grid in pairs(selGrids)do
                if(not grid.IsHold() and not grid.IsFrontGrid())then
                    targetGrids[gridId] = grid;
                end
            end
        end
        selGoalMgr:UpdateSelGrids(targetGrids,true);

        UpdateCrossGrids();        
    end
  
    EventMgr.Dispatch(EventType.Input_Select_Target_Character_Changed,characters); 
end

function UpdateCrossGrids()
    local allGrids = FightGroundMgr:GetAllGrids();
    local targetGrids = nil;
    if(allGrids)then
        for k,grid in pairs(allGrids)do
            local state = CheckCross(grid);           
            
            if(grid.IsFrontGrid())then--召唤位、无人、不是位置选择
                if(not grid.IsHold() and coverCharacterType ~= 2)then
                    state = false;
                end
            end

            if(state)then
                targetGrids = targetGrids or {};
                targetGrids[grid.GetKey()] = grid;
            end
        end
    end
    if(targetGrids)then
        selGoalMgr:UpdateSelGrids(targetGrids,true);
    end
end

---检查是否十字范围
function CheckCross(targetGrid)
    if(not isCross)then
        return false;
    end 
    if(not targetGrid)then
        return false;
    end
    if(not curRowIndex or not curColIndex)then
        return false;
    end
    
    return teamId == targetGrid.teamId and (targetGrid.rowIndex == curRowIndex or targetGrid.colIndex == curColIndex);
end


function IsSelectOK(rowIndex,colIndex)
    if(rowIndex == curRowIndex and colIndex == curColIndex)then
        return true;
    end

    local isInRange = IsInRange(rowIndex,colIndex);        
    if(isInRange)then
        --LogError("有效");        
        return true;
    end

    return false;

--    --以前需要点选确定需要点到人的逻辑
--    local selGrids = nil;

--    if(coverCharacterType == 2)then
--        selGrids = GetSelGrids();
--    else       
--        local characters = GetSelCharacterList();
--        if(characters)then
--            selGrids = {};
--            for id,character in pairs(characters)do
--                if(character ~= nil)then
--                    local characterTeamId = character.GetTeam();
--                    local characterGrids = character.GetGrids();

--                    for _,info in ipairs(characterGrids)do
--                        local infoRow = info[1];
--                        local infoCol = info[2];

--                        local characterGrid = FightGroundMgr:GetGrid(infoRow,infoCol,characterTeamId);      
--                        if(characterGrid)then  
--                            local characterGridKey = characterGrid.GetKey();
--                            if(selGrids[characterGridKey] == nil)then
--                               selGrids[characterGridKey] = characterGrid; 
--                            end
--                        end
--                    end
--                end
--            end
--        end
--    end


--    if(selGrids)then
--        local grid = FightGroundMgr:GetGrid(rowIndex,colIndex,teamId);      
--        if(grid)then
--            local key = grid.GetKey();
--            if(selGrids[key])then
--                return true;
--            end
--        end
--    end

--    return false;
end

--是否移动角色操作
function SetMoveCharacter(state)
   moveCharacter = state;
   moveTarget = nil;
end