--大富翁地图
local eventMgr=nil;
local player=nil;
local gridItems={};
local gridCtrls={};
local qTweens={};
local mapData=nil;--当前地图数据
local isFirst=true;
local camera=nil;
local cameraMgr=nil;
local cameraTween1=nil;--UI切换时的镜头移动动画
local cameraTween2=nil;--UI切换时的镜头缩放动画
local overlookOrgPos=nil;
local isPlaying=false;
function Awake()
    local qt3=ComUtil.GetCom(qualityTween3,"ActionMaterialReplace");
    local qt4=ComUtil.GetCom(qualityTween4,"ActionMaterialReplace");
    local qt5=ComUtil.GetCom(qualityTween5,"ActionMaterialReplace")
    local qts=ComUtil.GetCom(qualityTweenStart,"ActionMaterialReplace")
    qTweens={
        qt3.replaceList[0].target,
        qt4.replaceList[0].target,
        qt5.replaceList[0].target,
    };
    for i=0,grids.transform.childCount-1 do
        local go=grids.transform:GetChild(i).gameObject;
        gridItems[tonumber(string.match(go.name,"%d+"))]=go;
    end
    camera=ComUtil.GetCom(richManCamera,"Camera");
    cameraMgr=ComUtil.GetCom(gameObject,"BattleCameraMgr");
    cameraTween1=ComUtil.GetCom(cameraAction1,"ActionMoveByCurve2");
    cameraTween2=ComUtil.GetCom(cameraAction2,"ActionMoveByCurve2")
    overlookOrgPos={CSAPI.GetPos(overlook)};
    RichManMgr:SetMapView(this);
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RichMan_GridIcon_Alpha,PlayGridIconAlpha)
    eventMgr:AddListener(EventType.RichMan_Map_Update,OnMapSwitch)
    eventMgr:AddListener(EventType.RichMan_LoadGrid_Quality,OnLoadQuality)
    eventMgr:AddListener(EventType.RichMan_Set_TargetEff,OnSetTargetEff)
    eventMgr:AddListener(EventType.Input_Scene_Battle_Grid_Down,OnGridClick)
    eventMgr:AddListener(EventType.RichMan_UIState_Switch,OnUISwitch)
    eventMgr:AddListener(EventType.RichMan_MoveAction_State,OnMove)
    eventMgr:AddListener(EventType.RichMan_ActionQueue_Start,OnQueueStart)
    eventMgr:AddListener(EventType.RichMan_ActionQueue_End,OnQueueEnd)
    local data=RichManMgr:GetCurData();
    Refresh(data:GetMapInfo());
end

function OnDestroy()
    eventMgr:ClearListener();
end

function OnQueueStart()
    isPlaying=true;
end

function OnQueueEnd()
    isPlaying=false;
end

function Refresh(_mapData)
    mapData=_mapData;
    if mapData==nil then
        LogError("未获取到地图数据！");
        do return end
    end
    if gridItems and mapData then
        EventMgr.Dispatch(EventType.RichMan_Map_Refresh);
        local activityData=RichManMgr:GetCurData();
        local curPosInfo=activityData:GetCurPosGridInfo();
        local loadingItems={};
        --设置颜色
        for i, v in ipairs(mapData:GetGridsInfo()) do
            local index=v:GetPos();--Pos为地图中实际指向的块
            if gridItems[index]==nil then
                LogError("不存在名字为:"..tostring(index).."的格子！");
                -- do return end;
            end
            if loadingItems[index]~=true then
                --加载格子
                if gridCtrls[index]~=nil then
                    gridCtrls[index].Refresh(v,camera);
                else
                    ResUtil:CreateUIGOAsync("RichMan/RichManGridCtrl",gridItems[index],function(go)
                        local lua=ComUtil.GetLuaTable(go);
                        lua.Refresh(v,camera);
                        gridCtrls[index]=lua;
                        if curPosInfo and curPosInfo:GetPos()==index then
                            lua.PlayIconAlpha(true);
                        end
                    end)
                end
            end
            loadingItems[index]=true;
        end
    end
    if player==nil then
        --创建角色
        ResUtil:CreateUIGOAsync("RichMan/RichManPlayerCtrl",roleLayer,function(go)
            player=ComUtil.GetLuaTable(go);
            player.SetGetPosFunc(GetGridGOByGridID);
            player.Init();
        end)
    end
    isFirst=false;
end

function OnMapSwitch(eventData)
    if eventData==nil then
        do return end;
    end
    if eventData.mapId then
        --读取新的map数据
        -- LogError("加载新的Map数据并刷新地图.....");
        Refresh(RichManMgr:GetMapInfo(eventData.mapId));
    end
end

function OnGridClick(id)
    if id and id~=-1 and isPlaying~=true then
        --获取格子信息，打开事件信息面板
        local _,gridCtrl=GetGridGOByGridID(id);
        if gridCtrl~=nil then
            CSAPI.OpenView("RichRollEventInfo",gridCtrl.GetGridInfo());
        end
    end
end

function OnSetTargetEff(eventData)
    if eventData~=nil then
        -- LogError("OnSetTargetEff---------------->"..tostring(eventData.isShow))
        if eventData.isShow==true and eventData.grids then
            --设置位置
            local gridInfo=eventData.grids[#eventData.grids]
            local targetTrans=GetGridGOByGridID(gridInfo:GetPos());
            local targetPos=targetTrans.position;
            -- LogError(gridInfo:GetPos().."\t"..tostring(targetPos.x).."\t"..tostring(targetPos.y).."\t"..tostring(targetPos.z))
            CSAPI.SetPos(targetEff,targetPos.x,targetPos.y,targetPos.z);
        end
        CSAPI.SetGOActive(targetEff,eventData.isShow)
    end
end

--设置格子图标的渐隐播放
function PlayGridIconAlpha(eventData)
    if eventData and eventData.pos and gridCtrls[eventData.pos]~=nil then
        -- LogError("播放Pos值:"..tostring(eventData.pos).."的格子的透明度效果,\t 是否渐隐:"..tostring(eventData.isHide));
        gridCtrls[eventData.pos].PlayIconAlpha(eventData.isHide);
    end
end

--UI切换 isMain:是否是主界面
function OnUISwitch(isMain)
    if not IsNil(cameraMgr) then
        cameraMgr.enabled=not isMain;
        --设置拖拽范围
        local activityData=RichManMgr:GetCurData();
        local previewRange=activityData:GetPreviewRange();
        local xLimit=isMain and {0,0} or previewRange[1];
        local zLimit=isMain and {0,0} or previewRange[2];
        -- LogError(tostring(isMain).."\t"..table.tostring(xLimit).."\t"..table.tostring(zLimit))
        cameraMgr:SetMoveLimit(xLimit[1]*100,xLimit[2]*100,zLimit[1]*100,zLimit[2]*100);
        --播放摄像头切换动画
        local orgPos=activityData:GetCameraDistance();
        local targetPos=activityData:GetPlayDistance();
        if cameraTween1~=nil and cameraTween2~=nil and orgPos~=targetPos then
            local zoomSPos,zoomTPos,moveSPos,moveTPos=0,0,{0,0,0},{0,0,0}
            if isMain then
                zoomSPos=targetPos;
                zoomTPos=orgPos;
                moveSPos={CSAPI.GetLocalPos(overlook)};
                moveTPos=overlookOrgPos;
            else
                zoomSPos=orgPos;
                zoomTPos=targetPos;
                moveSPos=overlookOrgPos;
                moveTPos={CSAPI.GetLocalPos(player.gameObject)};;
            end
            cameraTween1:SetStartPos(moveSPos[1],moveSPos[2],moveSPos[3]);
            cameraTween1:SetTargetPos(moveTPos[1],moveTPos[2],moveTPos[3]);
            cameraTween2:SetStartPos(0,0,zoomSPos);
            cameraTween2:SetTargetPos(0,0,zoomTPos);
            CSAPI.SetGOActive(cameraAction1,true);
            CSAPI.SetGOActive(cameraAction2,true);
            EventMgr.Dispatch(EventType.RichMan_Mask_Changed,true)
            FuncUtil:Call(function()
                CSAPI.SetGOActive(cameraAction1,false);
                CSAPI.SetGOActive(cameraAction2,false);
                --设置跟随
                -- cameraMgr:SetFollowTarget(player.gameObject);
                --设置最小缩放距离
                if gameObject~=nil and not IsNil(gameObject) then
                    local pos=zoomTPos*-100;
                    cameraMgr:SetDis(pos,pos,pos);
                end
                EventMgr.Dispatch(EventType.RichMan_Mask_Changed,false)
            end,nil,800);
        else
            local dis=isMain and orgPos or targetPos;
            cameraMgr:SetDis(dis,dis);
        end
    end
end

function OnMove(isMove)
    if isMove then
        cameraMgr:SetFollowTarget(player.gameObject);
    end
end

function GetGridGOByGridID(gridID)
    if gridID~=nil and gridItems~=nil and gridItems[gridID]~=nil then
        local ctrl=nil
        if gridCtrls~=nil and gridCtrls[gridID]~=nil then
            ctrl=gridCtrls[gridID];
        end
        return gridItems[gridID].transform,ctrl;
    else
        LogError("未获取到名字为："..tostring(gridID).."的格子GameObject！");
    end
end

function OnLoadQuality(eventData)
    if eventData~=nil then
        LoadGridGrow(eventData.mCtrl,eventData.quality)
    end
end

--设置格子品质
function LoadGridGrow(mCtrl,quality)
    if  mCtrl and quality then
        local material=nil;
        material=qTweens[quality-2]
        if material then --替换目标品质材质
            mCtrl:ReplaceMaterial(material);
        end
    end
end