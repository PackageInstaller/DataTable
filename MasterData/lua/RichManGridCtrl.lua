--大富翁格子状态控制
local bottomEff=nil;
local pressEff=nil;
local iconEff=nil;
local gridInfo=nil;
local lastPressEff=nil;
local isPlayPress=false;
local isPlayAlpha=false;
local mCtrl=nil;
local camera=nil;
local tpEff=nil;
local isPlayTP=false;
local defaultVal=9;
local sortOrder=0;
function Awake()
    mCtrl=ComUtil.GetCom(glow,"MaterialCtrl");
    local z=gameObject.transform.position.z;
    sortOrder=defaultVal+(z*-3);    --z值越小，层级越靠前
    --设置图标和NumObj层级
    local renders=ComUtil.GetComsInChildren(effectNode,"Renderer")
    local renders2=ComUtil.GetComsInChildren(numObj,"Renderer")
    if(renders)then
        for i=0,renders.Length-1 do
            local com = renders[i];
            com.sortingOrder=sortOrder;
        end
    end
    if(renders2)then
        for i=0,renders2.Length-1 do
            local com = renders2[i];
            com.sortingOrder=sortOrder+i+1;
        end
    end
end

function Refresh(_gridInfo,_camera)
    gridInfo=_gridInfo
    camera=_camera;
    if gridInfo~=nil then
        --加载格子品质特效
        bottomEff=LoadEff(bottomEff,"RichMan/G_Monopoly_01_di_"..tostring(gridInfo:GetQuality()),diNode.transform);
        CSAPI.SetLocalPos(bottomEff,0,0.145,0);
        if gridInfo:GetShowType()==1 then
            --加载格子事件图标效果
            ResUtil.RichManIcon:LoadSR(image,gridInfo:GetIcon());
            ResUtil.RichManIcon:LoadSR(glow,gridInfo:GetIcon());
        else
            ResUtil.RichManIcon:LoadSR(icon,gridInfo:GetIcon());
        end
        clicker.name=tostring(gridInfo:GetPos())
        CSAPI.SetGOActive(icon,gridInfo:GetShowType()==2);
        CSAPI.SetGOActive(effectNode,gridInfo:GetShowType()==1);
        CSAPI.SetGOActive(floatTween,gridInfo:GetShowType()==1);
        --计算与相机的夹角
        if _camera~=nil then
            image.transform.forward=_camera.transform.forward;
            glow.transform.forward=_camera.transform.forward;
            numObj.transform.forward=_camera.transform.forward;
        end
        local isShowNum=false;
        if gridInfo:IsShowNum() and (gridInfo:GetType()==RichManEnum.GridType.Move or gridInfo:GetType()==RichManEnum.GridType.RandReward) then
            --设置数量和值
            local num= gridInfo:GetType()==RichManEnum.GridType.RandReward and gridInfo:GetValue2()[1] or gridInfo:GetValue1()[1];
            CSAPI.LoadSRInModule(numImg,"UIs/RichMan/img_10_0"..num..".png");
            isShowNum=true;
            -- EventMgr.Dispatch(EventType.RichMan_Create_HUD,{info=gridInfo,ctrl=this});
        end
        CSAPI.SetGOActive(numObj,isShowNum);
        --设置外发光颜色
        EventMgr.Dispatch(EventType.RichMan_LoadGrid_Quality,{mCtrl=mCtrl,quality=gridInfo:GetQuality()})
    end
end

function GetCamera()
    return camera and camera.gameObject or nil;
end

function LoadEff(eff, path, parent)
    if eff ~= nil then
        CSAPI.RemoveGO(eff);
        eff = nil
    end
    -- 加载格子品质特效
    return ResUtil:CreateUIGO(path,gameObject.transform);
end

--播放格子图标的透明度动画 
function PlayIconAlpha(isHide)
    -- LogError("PlayIconAlpha:"..tostring(isPlayAlpha))
    if isPlayAlpha then
        do return end
    end
    CSAPI.SetGOActive(showTween,not isHide);
    CSAPI.SetGOActive(hideTween,isHide);
    isPlayAlpha=true;
    FuncUtil:Call(function()
        isPlayAlpha=false;
    end,nil,100)
end


function PlayTPEff(isIn,func)
    if isPlayTP then
        LogError("播放触发特效中！！！");
        if func~=nil then
            func();
        end
        do return end;
    end
    if tpEff~=nil then
        CSAPI.SetGOActive(tpEff,true);
    else
        tpEff=LoadEff(tpEff,"RichMan/G_Monopoly_01_chuangsong",gameObject.transform);
    end
    isPlayTP=true;
    CSAPI.PlaySound("temp/temp.acb","Monopoly_Effects_04");
    FuncUtil:Call(function()
        CSAPI.SetGOActive(tpEff,false);
        if func~=nil then
            func();
        end
        isPlayTP=false;
    end,nil,1000)
end

function PlayPressEff(func)
    if isPlayPress then
        LogError("播放触发特效中！！！");
        if func~=nil then
            func();
        end
        do return end;
    end
    if pressEff~=nil and lastPressEff==gridInfo:GetQuality() then
        CSAPI.SetGOActive(pressEff,true);
    else
        pressEff=LoadEff(pressEff,"RichMan/G_Monopoly_01_cufa_"..tostring(gridInfo:GetQuality()),cufaNode.transform);
        lastPressEff=gridInfo:GetQuality();
    end
    --播放触发音效
    if gridInfo:GetSound() then
        CSAPI.PlaySound("temp/temp.acb",gridInfo:GetSound());
    end
    isPlayPress=true;
    FuncUtil:Call(function()
        CSAPI.SetGOActive(pressEff,false);
        if func~=nil then
            func();
        end
        isPlayPress=false;
    end,nil,1000)
end

function GetGridInfo()
    return gridInfo;
end