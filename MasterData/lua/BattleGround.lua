--战场

local currDis=0; --当前摄像机距离
local currMinDis=0;--当前摄像机最小可以设置的距离
local currMaxDis=0;--当前摄像机最大可以设置的距离

local cameraMgr;

function Awake()

    actionTileGridGen = CSAPI.ApplyAction(gameObject,"ActionTileGridGen");
    shakeCtrl = ComUtil.GetCom(shakeNode,"ActionBase");
    CSAPI.SetParent(actionTileGridGen.gameObject,tileGridNode);
    

	eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Battle_Bg,OnBattleBg);
	eventMgr:AddListener(EventType.Input_Scene_Battle_Grid_Click,OnClickGrid);  
    eventMgr:AddListener(EventType.Input_Scene_Battle_Grid_Down,OnDownGrid); 
    eventMgr:AddListener(EventType.Input_Scene_Battle_Grid_Keep,OnKeepGrid); 
    eventMgr:AddListener(EventType.Battle_View_Show_Changed,OnCtrlStateChanged);
    cameraMgr = ComUtil.GetCom(gameObject,"BattleCameraMgr");    
    cameraMgr:SetZoomChanged(OnZoomChanged);
    ctrlState = true;
    --ResUtil:LoadBigSR(bg,"UIs/Battle/bg");   
end

function OnDestroy()
    cameraMgr:RemoveZoomChanged();
	eventMgr:ClearListener();
end

function OnBattleBg(go)
    CSAPI.SetParent(go,bgNode);
end
--Apply(int time = 100, int hz = 100, int xRange = 10, int yRange = 10, int zRange = 10, GameObject dirGO = null, float decayValue = 0.3f)
function ApplyShake(time,range)
    time = time or 1000;
    range = range or 100;
    if(not IsNil(shakeCtrl))then
        shakeCtrl:Apply(time,50,range,range,range);
    end
end

--设置相机可控距离
function SetDis(dis,min,max)
    if(cameraMgr)then    
        currDis=dis or 800;
        currMinDis=min or 700;
        currMaxDis=max or 1000;
        cameraMgr:SetDis(currDis,currMinDis,currMaxDis);
    end
end
function SetOverlook(val,min,max)    
    val = val or 30;
    if(cameraMgr)then    
        cameraMgr:SetOverlook(val,min,max);
    end
end
function SetSide(val,min,max)    
    val = val or 36;
    if(cameraMgr)then    
        cameraMgr:SetSide(val,min,max);
    end
end

--设置跟随目标
function SetFollow(go)
    cameraMgr:SetFollowTarget(go);
end

function SetInputState(state)
    if(cameraMgr)then
        cameraMgr:SetInputState(state);
    end
end

function SetCtrlState(ctrlState)
    if(cameraMgr)then
        cameraMgr:SetCtrlState(ctrlState);
    end
end

function OnCtrlStateChanged(state)
    ctrlState = state;
    --在BattleView显示之后初始化一次距离条的值
    local v1=currMaxDis-currMinDis;
    local v2=currDis-currMinDis;
    local progress=v2/v1;
    EventMgr.Dispatch(EventType.Battle_Ground_Zoom,progress);
    --LogError(tostring("___" ..  tostring(state)));
end 

function OnClickGrid(id)
    --CSAPI.PlayUISound("ui_generic_click");

    if(not ctrlState)then
        return;
    end

    local currTime = CSAPI.GetTime();
    local lastTime = gridDownTime;
    gridDownTime = nil;
    if(lastTime and currTime - lastTime > 1)then        
        return;
    end    
    if clickFunc==nil then
        clickFunc={};
        clickFunc[eDungeonMapState.Normal]=OnClickGridNormal;
        -- clickFunc[eDungeonMapState.Info]=OnClickGridInfo;
    end
    local mapState=BattleMgr:GetMapState();
    if mapState~=nil then
        clickFunc[mapState](id);
    end
end
function OnDownGrid(id)
    gridDownTime = CSAPI.GetTime();
    showGridInfoFlag = nil;
    --OnClickGridInfo(id);
end
function OnKeepGrid(id)
    if(gridDownTime and not showGridInfoFlag)then
        local currTime = CSAPI.GetTime();
        if(currTime - gridDownTime > 1)then        
            showGridInfoFlag = 1;
            EventMgr.Dispatch(EventType.Battle_Select_Ground_Info,id);
            -- LogError("显示格子信息：" .. id);    
        end   
    end     
end


--点击格子(正常情况)
function OnClickGridNormal(id)  
    local state = BattleMgr:CheckClickGridTime(); 
    if(not state)then
        return;   
    end
    local doingData = BattleMgr:GetCurrData();
    if(doingData)then
        --LogError(doingData);
        return;
    end
    local allCharacters = BattleCharacterMgr:GetAll();
    if(allCharacters)then
        for _,tmpCharacter in pairs(allCharacters)do
            local gridId = tmpCharacter.GetCurrGridId();
            if(gridId == id)then                
                if(BattleMgr:TryOpenFightFormationView(gridId))then
                    --点击战斗中的目标                  
                    return;
                end

                if(tmpCharacter.GetType() ~= eDungeonCharType.MonsterGroup and tmpCharacter.GetType() ~= eDungeonCharType.Prop)then
                    if(tmpCharacter.GetType() == eDungeonCharType.MyCard)then
                        --选中自己的队伍
                    end
                    return;
                else
                    break;
                end
            end
        end
    end

    local  character = BattleMgr:GetCtrlCharacter();
    if(character)then
         if(character.IsFighting())then
            Tips.ShowTips(StringConstant.battle_move_limit_1);
            return;
        end
        local grid = GetGrid(id);
        if(grid and grid.IsReachable())then
            BattleMgr:ApplyMove(id);
        else
            Tips.ShowTips(LanguageMgr:GetByID(1074))--StringConstant.battle_move_limit);
        end
    end
   
end

--移动目标
function ApplyMove(character,targetId,isSlide)
    local startId = character.GetCurrGridId();
    if(startId == nil)then
        LogError("无法移动战棋目标，目标不在棋盘中");
    end
    
    if(startId == targetId)then
        --LogError("不存在路径");
        OnMoveCallBack();
        return;
    end    

    local path = BattleMgr:FindPathNew(character,targetId,100);--服务器给的移动位置，忽略步数限制
    if(path == null)then
        OnMoveCallBack();
        LogError(string.format("不存在路径:%s --> %s",character.GetCurrGridId(),targetId));
        return;
    end

    local lightGridIds = {}--亮起的格子路径
    local pathGos = {};
    for _,grid in ipairs(path)do
        if(grid)then
            table.insert(pathGos,grid.gameObject);    
            lightGridIds[grid.GetID()] = 1;
        end
    end

    SetGridLightStates();
    --SetGridLightStates(lightGridIds,character.GetType() == eDungeonCharType.MonsterGroup,startId);
    character.MoveTo(targetId,pathGos,OnMoveCallBack,nil,isSlide);
end

--移动完成回调
function OnMoveCallBack()
   BattleMgr:MoveComplete();
end

function OnTransferCallBack()
    BattleMgr:TransferComplete();
end

--用户缩放时
function OnZoomChanged(z)
    --计算当前缩放的进度
    currDis=math.abs(z)*100;
    local v1=currMaxDis-currMinDis;
    local v2=currDis-currMinDis;
    local progress=v2/v1;
    EventMgr.Dispatch(EventType.Battle_Ground_Zoom,progress);
end

--申请传送
function ApplyTransfer(character,posGridId,targetGridId,isTranferState,callBack,caller,transferProp)  

    --传送动画
    local transferAnim = GetTransferAnim(posGridId,targetGridId,isTranferState);

    local go = CSAPI.CreateGO("MapTransfers/" .. transferAnim,0,0,0,characters);
    if(go)then
        local lua = ComUtil.GetLuaTable(go);
        lua.ApplyTransfer(character,posGridId,targetGridId,callBack,caller,transferProp);
    else
        LogError("找不到传送路径对象" .. transferAnim);
    end
end

function GetBattleDungeonData()
    return battleDungeonData;
end

function GetTransferAnim(posGridId,targetGridId,isTranferState)
    if(isTranferState)then
        return battleDungeonData.mapid .. "#" .. posGridId .. "_" .. targetGridId;
    end
    return "common";
end
--获取道具数据
function GetPropData(propId)
    if(battleDungeonData.props)then
        for _,propData in ipairs(battleDungeonData.props)do
            if(propId == propData.id)then
                return propData;
            end
        end
    end
end

--获取摄像机
function GetCamera()
    return goCamera;
end
--获取角色根节点
function GetCharacterParentGO()
    return characters;
end

function SetTileGridGos(gos)
    local arr = {};

    if(gos)then
        for _,go in ipairs(gos)do
            
            local x,y,z = CSAPI.GetPos(go);
            --LogError(go.name .. ",x" .. x .. ",y" .. y .. ",z" .. z);
            table.insert(arr,x);
            table.insert(arr,y + 0.508);
            table.insert(arr,z);
        end
    end
    if(actionTileGridGen)then
        actionTileGridGen:SetPoses(arr);
    end
end


--设置格子高亮范围
function SetLightRange(character)        
    if(character)then
        local list = GetLightRange(character);

        local gridId = character.GetCurrGridId();
      
        local isEnemy = character.GetType() ~= eDungeonCharType.MyCard;


        SetGridLightStates(list,isEnemy,gridId);
    else
        SetGridLightStates();
    end
    
end
--获取角色能去的范围
function GetLightRange(character,customCost)        
    if(character)then
        --gridId：目标格子
        --cost：范围
        --height：高度
        --isEnemy：是否敌方单位
        --ignoreWaterCost：忽略水面额外消耗
        local gridId = character.GetCurrGridId();
        local cost = customCost or character.GetMoveStep();
        local height = character.GetJumpStep();
        local isEnemy = character.GetType() ~= eDungeonCharType.MyCard;
        local ignoreWaterCost = character.IsIgonreWaterCost();

        local passBans,targetBans = BattleMgr:GetGridBans(character);
        local list = GetGridsInRange(gridId,passBans,targetBans,cost,height,ignoreWaterCost); 
        

        local characterGrid = character.GetCurrGrid();
        local characterNearGrids = characterGrid.GetNears();
        local characterNearGridIds = {};
        if(characterNearGrids)then
            for _,characterNearGrid in ipairs(characterNearGrids)do
                if(characterNearGrid)then
                    characterNearGridIds[characterNearGrid.GetID()] = 1;
                end
            end
        end
        for gridId,grid in pairs(list)do
            local gridProp = BattleMgr:GetUnitOnGrid(gridId,eDungeonCharType.Prop);
            if(gridProp and (gridProp.IsCanDestroy() or gridProp.IsCanPush()))then--可破坏、可推动道具只有靠近时才可点击
                if(not characterNearGridIds[gridId])then--角色靠近该格
                    list[gridId] = nil;
                else 
                    if(gridProp.IsCanDestroy() and not character.CanDestroyObj())then
                        list[gridId] = nil;
                    end
                    if(gridProp.IsCanPush() and not character.CanPushObj())then
                        list[gridId] = nil;
                    end
                end
            end
        end

        return list;
    else
        return nil;
    end
    
end

--设置格子亮度状态
--arr：格子id组，如{100,101,105}
function SetGridLightArr(arr,isEnemy,startGridId)
    local lightGridIds = {};
    for _,gridId in ipairs(arr)do
        lightGridIds[gridId] = 1;   
    end

    SetGridLightStates(lightGridIds,isEnemy,startGridId);
end
--设置格子亮度状态
--lightGrids：格子id，{100=1,101=1,105=1}
function SetGridLightStates(lightGridIds,isEnemy,startGridId)
    if(luaSubMaps)then
        for _,luaSubMap in pairs(luaSubMaps) do  
            luaSubMap.SetGridLightStates(lightGridIds,isEnemy and 2 or 1,startGridId);                     
        end
    end

    local lightGos = {};

    if(lightGridIds)then
        for gridId,v in pairs(lightGridIds)do
            local grid = GetGrid(gridId);
            if(grid and not IsNil(grid.gameObject))then
                table.insert(lightGos,grid.gameObject);
            end
        end        
    end

    SetTileGridGos(lightGos);
end

--移除
function Remove()
    --LogError("移除格子场地");
    if(isRemoved)then
        return;
    end
    isRemoved = true;
    CSAPI.RemoveGO(gameObject);
end



--新副本代码------------------------------------------------------------------------------------------------------------------------------------------------

--新初始化副本
function InitDungeon(dungeonId,callBack)
    completeCallBack = callBack;

    Log( "(新)初始化战棋副本" .. dungeonId);

    battleDungeonData = DungeonMgr:GetBattleDungeonData(dungeonId);

    local mapId = battleDungeonData.mapid;    
    local map = MapMgr:GetMap(mapId);
    if(map == nil)then
        LogError("初始化副本地图失败！" .. tostring(mapId));
        return;
    end
    local cfgScene = Cfgs.scene:GetByID(mapId);
    local createGidRes = cfgScene == nil;

    InitMap(map,createGidRes);
    CreateMapScene(mapId);
end
--初始化地图
function InitMap(map,gridRes)
    if(map == nil)then        
        return;
    end

    ---InitMapRes(map.res);

    luaSubMaps = {};
    
    if(map.sub_maps)then
        for _,subMap in pairs(map.sub_maps)do
           local luaSubMap = InitSubMap(subMap,gridRes);     
           luaSubMaps[luaSubMap.GetID()] = luaSubMap;
        end
    end

    --设置镜头移动限制
    local xMoveLimit = map.x_move_limit or {100,-100};
    local yMoveLimit = map.y_move_limit or {100,-100};
    if(cameraMgr)then
        cameraMgr:SetMoveLimit(xMoveLimit[1],xMoveLimit[2],yMoveLimit[1],yMoveLimit[2]);
    end  

    --设置镜头距离
    if(map.camera_dis)then
        SetDis(map.camera_dis[3],map.camera_dis[1],map.camera_dis[2]); 
    else
        if(g_battle_camera_dis)then
            SetDis(550,g_battle_camera_dis[1],g_battle_camera_dis[2]); 
        end
    end

    --设置镜头俯视
    if(map.camera_overlook)then
        SetOverlook(map.camera_overlook[3],map.camera_overlook[1],map.camera_overlook[2]); 
    else
        if(g_battle_camera_angle)then
            SetOverlook(nil,g_battle_camera_angle[1],g_battle_camera_angle[2]); 
        end
    end

    --设置镜头平视
    if(map.camera_side)then
        SetSide(map.camera_side[3],map.camera_side[1],map.camera_side[2]); 
    else
        if(g_battle_camera_angle)then
            SetSide(nil,g_battle_camera_angle[3],g_battle_camera_angle[4]); 
        end
    end
end

--function InitMapRes(resArr)
--    if(resArr)then
--        for _,res in ipairs(resArr)do            
--            CSAPI.CreateGOAsync("Grids/" .. res, 0,0, 0, mapRes);
--        end
--    end
--end

--初始化子地图
function InitSubMap(subMap,gridRes)
     local pos = subMap.pos;
     local x = pos and pos[1] / 100 or 0;
     local y = pos and pos[2] / 100 or 0;
     local z = pos and pos[3] / 100 or 0;

     local go = CSAPI.CreateGO("BattleSubMap",x,y,z,subMaps);
     local lua = ComUtil.GetLuaTable(go);
     lua.Init(subMap,gridRes);

     return lua;
end
--获取格子
function GetGrid(id)
    if(luaSubMaps)then
        for _,luaSubMap in pairs(luaSubMaps) do           
            local grid = luaSubMap.GetGrid(id);
            if(grid)then
                return grid;
            end
        end
    end
end

function GetGridByGO(go)
    if(luaSubMaps)then
        for _,luaSubMap in pairs(luaSubMaps) do           
            local grids = luaSubMap.GetAllGrids();
            if(grids)then
                for _,grid in pairs(grids) do                        
                    if(grid.gameObject == go)then
                        return grid;
                    end
                end
            end
        end
    end
end

--获取坑洞格子
function GetHoleGrids()
    if(holes == nil)then
        holes = {};

        if(luaSubMaps)then
            for _,luaSubMap in pairs(luaSubMaps) do           
                local grids = luaSubMap.GetAllGrids();
                if(grids)then
                    for _,grid in pairs(grids) do                        
                        if(grid.GetHoleType())then
                            table.insert(holes,grid);
                        end
                    end
                end
            end
        end
        
    end
    
    return holes;
end


--寻找路径
function FindPath(startId,targetId,bans,cost,height,ignoreWaterCost,ignoreGridType)
    if(luaSubMaps)then
        for _,luaSubMap in pairs(luaSubMaps) do           
            local path = luaSubMap.FindPath(startId,targetId,bans,cost,height,ignoreWaterCost,ignoreGridType);
            if(path)then
                return path;
            end
        end
    end
end
--获取指定格子范围内的格子
--ignoreWaterCost：忽略水面额外消耗
function GetGridsInRange(targetId,passBans,targetBans,cost,height,ignoreWaterCost)
    if(luaSubMaps)then
        for _,luaSubMap in pairs(luaSubMaps) do           
            local grids = luaSubMap.GetGridsInRange(targetId,passBans,targetBans,cost,height,ignoreWaterCost);
            if(grids)then
                return grids;
            end
        end
    end
end

function CreateMapScene(id)
    local cfgScene = Cfgs.scene:GetByID(id);
    if(cfgScene and cfgScene.res)then
        needCreate = #cfgScene.res;
        for i,res in ipairs(cfgScene.res)do
            CSAPI.CreateGOAsync(res,0,0,0,mapRes,OnMapGoCreated);
--            if(i == #cfgScene.res)then
--                CSAPI.CreateGOAsync(res,0,0,0,mapRes,OnMapGoCreated);
--            else
--                CSAPI.CreateGOAsync(res,0,0,0,mapRes);
--            end
        end
    else
        OnMapResCreated();
    end
end

function OnMapGoCreated(go)
    if(not createCount)then
        FuncUtil:Call(OnMapResCreated,nil,2000);
    end

    createCount = createCount or 0;
    createCount = createCount + 1;
    if(createCount >= needCreate)then
        OnMapResCreated();
    end
end

function OnMapResCreated()
    local callBack = completeCallBack;
    if(callBack)then
        completeCallBack = nil;
        callBack();
    end
end

function GetSubMaps()
    return luaSubMaps;
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
characters=nil;
grids=nil;
subMaps=nil;
mapRes=nil;
goCamera=nil;
SceneCamera=nil;
bgNode=nil;
tileGridNode=nil;
end
----#End#----