--战斗场地格子

--排号
rowIndex = nil;
--列号
colIndex = nil;
--队伍id
teamId = 1;

--占位信息
placeholderInfo = nil;

--x坐标
x = 0;
--y坐标（unity中的z轴）
y = 0;


--设置格子
--row：排（从1开始）
--col：列（从1开始）
--gridTeamId：是否敌方格子
function Set(row,col,gridTeamId)
    rowIndex = row;
    colIndex = col;
    teamId = gridTeamId;
    key = FightGroundMgr:GenGridKey(row,col,gridTeamId);
    CSAPI.SetGOActive(goRes,IsFrontGrid() == false); 
    
    SetSize();
    SetSelState(false);

--    goWalls = nil;
--    closeGrids = nil;
--    SetWalls(nil);

--    local res = "Common/" .. (TeamUtil:IsEnemy(teamId) and "grid_enemy.png" or "grid_our.png");
--    CSAPI.LoadSR(front,res);
--    CSAPI.LoadSR(back,res);
--    CSAPI.LoadSR(left,res);
--    CSAPI.LoadSR(right,res);
end
--设置为召唤区格子
function SetSize()
    local isSummonGrid = false;
    if(IsFrontGrid() and colIndex == 1)then
        isSummonGrid = true;
    end

    if(isSummonGrid)then
        local summonGridState = true;

--        if(TeamUtil:IsEnemy(teamId))then
--            if(not IsPvpSceneType(g_FightMgr.type) and g_FightMgr.type ~= PVPMirror)then
--                summonGridState = false;
--            end
--        end

        CSAPI.SetGOActive(goRes,summonGridState);

        local cfgFightGrid = FightGroundMgr.cfg;
        local colCount = TeamUtil:IsEnemy(teamId) and cfgFightGrid.enemyCol or cfgFightGrid.myCol;
        local z = (colCount - 1) / 2 * FightGroundMgr:GetGridSize();
        CSAPI.SetPos(goRes,0,0,-z);

        CSAPI.SetSRSize(goGrid,1.95,1.95 * 3);
        CSAPI.SetSRSize(goSel,1.85,1.85 + 4);
    else
        CSAPI.SetPos(goRes,0,0,0);
        CSAPI.SetSRSize(goGrid,1.95,1.95);
        CSAPI.SetSRSize(goSel,1.85,1.85);
    end

end

--设置位置
--posX：x坐标
--posY：y坐标（unity中的z轴）
function SetPos(posX,posY)
    x = posX;
    y = posY;
    CSAPI.SetPos(gameObject,x,0,y);
end

--是否召唤区格子
function IsFrontGrid()
    return rowIndex and (rowIndex == 4 or rowIndex == 0);
end
--是否敌方格子
function IsEnemyGrid()
    return TeamUtil:IsEnemyTeam(teamId);
end

--是否被占用
function IsHold()
    return placeholderInfo ~= nil;
end

--放入
function ApplyPutIn(info)
    if(placeholderInfo ~= nil)then
        LogError("重复占用格子,排：" .. rowIndex .. "，列：" .. colIndex .. "，队伍：" .. teamId);
        return false;
    end
    placeholderInfo = info; 
    return true;
end
--移除占用
function PutOut()
    placeholderInfo = nil; 
end
--获取占位信息
function GetPlaceHolderInfo()
    return placeholderInfo;
end

--获取占用该格子的角色
function GetCharacter()
    if(placeholderInfo ~= nil)then
        return placeholderInfo:GetCharacter();
    end
    return nil;
end

--移除
function Remove()
    CSAPI.RemoveGO(gameObject);
    placeholderInfo = nil;
end

--设置墙
function SetWalls(arr)
    if(arr == nil)then
        CSAPI.SetGOActive(walls,false);   
        return;     
    end

    CSAPI.SetGOActive(walls,true);  

    local myWalls = GetWalls();
    for k,v in ipairs(myWalls) do
        if(v)then
            CSAPI.SetGOActive(v,arr[k] ~= nil);   
        end
    end
end
--获取墙
--function GetWalls()
--    if(goWalls == nil)then
--        local go2 = nil;
--        local go4 = nil;
--        if(TeamUtil:IsEnemy(teamId))then
--            go2 = left;
--            go4 = right;
--        else
--            go2 = right;
--            go4 = left;
--        end
--        goWalls = {front,go2,back,go4};
--    end   

--    return goWalls;
--end

--格子key
function GetKey()
    return key;
end
--获取邻格
--function GetCloseGrids()
--    if(closeGrids == nil)then
--        closeGrids = {};

--        closeGrids[1] = FightGroundMgr:GetGrid(rowIndex,colIndex + 1,teamId);      
--        closeGrids[2] = FightGroundMgr:GetGrid(rowIndex - 1,colIndex,teamId);      
--        closeGrids[3] = FightGroundMgr:GetGrid(rowIndex,colIndex - 1,teamId);      
--        closeGrids[4] = FightGroundMgr:GetGrid(rowIndex + 1,colIndex,teamId);      
--    end

--    return closeGrids;
--end

function SetSelState(isSel)
    CSAPI.SetGOActive(goSel,isSel);
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
goRes=nil;
goGrid=nil;
goSel=nil;
end
----#End#----