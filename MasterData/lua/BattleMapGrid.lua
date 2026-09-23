--副本格子

function Awake()
    collider = ComUtil.GetCom(gameObject,"Collider");
    lightAction = ComUtil.GetCom(spriteNode,"ActionBase");
end

--重置
function Reset()
    nearGrids = nil;
    activeState = nil;
end

--初始化
function Init(subMap,mapX,mapY,createRes)
    Reset();

    myMap = subMap;
    x = mapX;
    y = mapY;

    id = myMap.GetGridID(x,y);
    data = myMap.GetGridData(id);
    
    gameObject.name = id .. "";

    InitOthers();
    InitPos();

    if(createRes)then
        InitRes();
    end

    SetLightState(0);
end

--初始化其他
function InitOthers()
--    if(not data)then
--        return;
--    end
    --模型角度
    CSAPI.SetAngle(node,0,data and data.angle or 0,0);
    --模型翻转
    CSAPI.SetScale(node,data and data.flip and -1 or 1,1,1);

    --初始隐藏
    local isHide = data and ((data.type == eMapGridType.Hide or data.type == eMapGridType.None) and not data.force_show);
    SetShowState(not isHide);
end

--初始化位置
function InitPos()
    local mapWidth = myMap.Width();
    local mapHeight = myMap.Height();
    local xOffset = (mapWidth - 1) / 2;
    local zOffset = (mapHeight - 1) / 2;

    local xPos = y - 1;
    local yPos = Height() * 0.25;
    local zPos = x - 1;
    
    CSAPI.SetLocalPos(gameObject,xPos - xOffset,yPos,zPos - zOffset);     
end
--获取位置
function GetPos()
    return CSAPI.GetPos(gameObject);
end

--初始化资源
function InitRes()   
    local res = data and data.res or "0/1";--默认资源
    if(res)then
        CSAPI.CreateGOAsync("Grids/" .. res, 0, 0, 0, node);
    end
end

function GetID()
    return id;
end

function Height()
    return data and data.height or 0;
end

--设置显示状态
function SetShowState(state)
    showState = state;
    local value = state and 1 or 0.0001;
    CSAPI.SetScale(node,value,value,value);

    if(collider)then
        collider.enabled = state;
    end
end

--设置高亮状态
--state：
--0：关闭
--1：绿色
--2：红色
function SetLightState(state)
    state = state or 0;
    CSAPI.SetGOActive(our,state == 1);
    CSAPI.SetGOActive(enemy,state == 2);
    currLightState = state;
end
--是否亮起状态
function IsLight()
    return currLightState and currLightState ~= 0;
end
--播放亮起动画
function PlayLightAni(startPosX,startPosZ)
    if(not startPosX or not startPosZ)then
        return;
    end
    --CSAPI.SetGOActive(spriteNode,false);
    CSAPI.SetScale(spriteNode,0.001,0.001,0.001);

    local x,y,z = CSAPI.GetPos(gameObject);
    local deltaX = math.abs(x - startPosX);
    local deltaZ = math.abs(z - startPosZ);

    local delayTime = CSAPI.RandomInt(0, 15) + (deltaX + deltaZ) * 60;
    FuncUtil:Call(DelayPlayLightAni,nil,delayTime);
end

function DelayPlayLightAni()
    if(lightAction)then
        lightAction:Play();
    end
    --CSAPI.SetGOActive(spriteNode,true);
end

--是否可抵达
function IsReachable()
    return IsLight() and GetValidState();
end

--该格子是否可以路过
--当前不能路过的格子：冰面、指向滑动
function IsCanPass()
    return GetType() ~= eMapGridType.Ice and GetType() ~= eMapGridType.Slide;
end

--获取类型
function GetType()
    return data and data.type or 0;
end
--获取方向
function GetDir()
    return data and data.dir;
end

--是否有效
function GetValidState()
    local gridType = GetType();
    if(gridType == eMapGridType.None)then
        return false;
    elseif(gridType == eMapGridType.Hide)then
        return activeState;
    end

    return true;
end

--获取坑类型
function GetHoleType()
    return data and data.hole_type;    
end
--是否激活
function IsHoleActive()
     --地图单位（友军，怪物，道具）
    local characters = BattleCharacterMgr:GetAll();
    if(characters)then
        for id,character in pairs(characters)do
            if(not character.IsDead())then
                local characterType = character.GetType();
                local characterGridId = character.GetCurrGridId();
                
                if(characterType == eDungeonCharType.Prop and characterGridId == GetID())then                    
                    return true;
                end
            end
        end
    end

    return false;
  
end

--设置激活状态
--针对隐藏格子
function SetActiveState(state)
    activeState = state;
    SetShowState(activeState);
    if(not state)then        
        SetLightState(0)
    end
end

--寻路相关----------------------------------------------------------------------------------

--获取邻格
function GetNears()
    if(not nearGrids)then
        local walls = data and data.walls;

        nearGrids = {};
        if(not walls or not walls[1])then PushNearGrid(nearGrids,1,0); end--上
        if(not walls or not walls[2])then PushNearGrid(nearGrids,0,1); end--右
        if(not walls or not walls[3])then PushNearGrid(nearGrids,-1,0); end--下
        if(not walls or not walls[4])then PushNearGrid(nearGrids,0,-1); end--左
    end

    return nearGrids;
end

function GetNearGrid(xDir,yDir)    
    return myMap.GetGrid(myMap.GetGridID(x + xDir,y + yDir));
end

function PushNearGrid(arr,xDir,yDir)
    local grid = GetNearGrid(xDir,yDir);
    if(grid)then
        table.insert(arr,grid);
    end
end

--清除消耗
function ClearCost()
    currFromGrid = nil;
    currCost = nil;

    isStart = nil;
    isTarget = nil;
end
--设置格子消耗
--fromGrid：前一个格子
--cost：进入该格子时总消费
--ignoreWaterCost：是否忽略水面格子的额外消费
function SetGridCost(fromGrid,cost,ignoreWaterCost)
    
    local costAdd = 0;
    if(not ignoreWaterCost and GetType() == eMapGridType.Water)then
        costAdd = 1;
    end

    cost = cost + costAdd;

    if(currFromGrid)then
        if(cost >= currCost)then--上一种进入该格子的路径更优
            return false;
        end
    end

    currFromGrid = fromGrid;
    currCost = cost;
    
    return true;
end
--寻路中的上一个格子
function GetPreGrid()
    return currFromGrid;
end
--获取当前消耗
function GetCost()
    return currCost;
end

--获取该格子消耗
function GetMyCost()
    myCost = myCost or math.max(0,1 - GetGravityCost());
    return myCost;
end
--获取重力影响该格子消耗
function GetGravityCost()
    return data.nGravity or 0;
end

--设置为起点
function SetAsStart()
    isStart = 1;
    SetGridCost(nil,0,true);
end
--是否起点
function IsStart()
    return isStart;
end

--设置为目标
function SetAsTarget()
    isTarget = 1;
end
--是否目标
function IsTarget()
    return isTarget;
end


--播放角色移动路径动画
function PlayAni(isEnemy)    
    if(IsLight())then
        SetLightState(false);
    end

    local res = "common/map_grid";--isEnemy and "common/map_grid_enemy" or "common/map_grid_our";

    ResUtil:CreateEffect(res,0,0,0,goLight);
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
node=nil;
goLight=nil;
spriteNode=nil;
our=nil;
enemy=nil;
end
----#End#----