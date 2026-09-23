--模型节点

local isRemove=false;
local matCtrl=nil;
local modelCtrl=nil;
local alphaKey="_Transparency";
local playTween=false;
function Set(followTarget,goFromCamera,goToCamera)
    CSAPI.AddPosFollow_C2C(gameObject,followTarget,goFromCamera,goToCamera);
    CSAPI.SetGOActive(shadow,false);
end

function SetData(_d,_playTween)
    this.data=_d;
    playTween=_playTween;
end

function GetData()
    return this.data;
end

function GetLoadData()
    return {cfg=this.data:GetModelCfg(),parentGO=model,callBack=OnResLoadComplete}
end

function OnResLoadComplete(go)
    modelGo = go;
    matCtrl = ComUtil.GetCom(go,"MaterialCtrl"); 
    if playTween then
        PlayShowTween(function()
            CSAPI.SetGOActive(shadow,true);
            EventMgr.Dispatch(EventType.Team_Model_LoadOver);
        end);
    else
        CSAPI.SetGOActive(shadow,true);
        EventMgr.Dispatch(EventType.Team_Model_LoadOver);
    end
    -- CSAPI.SetGOActive(bottomObj,false);
    SetModelRotation(0,-90,0);
    modelCtrl=ComUtil.GetLuaTableInChildren(go);
    -- if modelCtrl then --获取头顶位置，并设置箭头的位置
    --     local pos=modelCtrl.GetHeadPos();
    --     local pos2=transform:InverseTransformPoint(UnityEngine.Vector3(pos[1],pos[2],pos[3]));
    --     CSAPI.SetLocalPos(arrow,pos2.x,pos2.y+0.2,pos2.z);
    -- end
    if isRemove==true then
        RemoveModel();
    end
end

-- function ShowArrow(isShow)
--     CSAPI.SetGOActive(arrow,isShow);
-- end

function SetModelRotation(x,y,z)
    CSAPI.SetAngle(model,x,y,z)
end

function Remove()
    isRemove=true;
    RemoveModel();
    CSAPI.RemoveGO(gameObject);
end

-- function SetGridSize(formationType)
--     local size=FormationUtil.GetGridSize(formationType,true);
--     CSAPI.SetScale(shadow,size[1],size[2],1);
-- end

function RemoveModel()
    if(modelGo)then
        CSAPI.RemoveGO(modelGo);
        modelGo = nil;        
    end
end

function SetShadow(b)
    if(shadow) then 
        CSAPI.SetGOActive(shadow,b)
    end 
end

function PlayHideTween()
    CSAPI.ApplyAction(modelGo,"action_formation_modelHide");
end

function PlayShowTween(func)
    --设置透明度为0
    SetMatAlpha(0);
    --设置显示动画
    CSAPI.ApplyAction(modelGo,"action_formation_modelShow",func);
end

--设置模型的透明度
function SetMatAlpha(a)
    if matCtrl then
        if a then
            matCtrl:SetFloat(alphaKey,a);
        else
            matCtrl:ResetFloat(alphaKey); 
        end
    end
end

-- function SetLeader(isLeader)
--     CSAPI.SetGOActive(leaderObj,isLeader);
-- end

function SetBottom(isShow)
    -- CSAPI.SetGOActive(bottomObj,isShow);
end

function SetStar(num)
    if num then
        -- for i=0,starObj.transform.childCount-1 do
        --     local go=starObj.transform:GetChild(i).gameObject;
        --     if num-1>=i then
        --         CSAPI.SetGOActive(go,true);
        --     else
        --         CSAPI.SetGOActive(go,false);
        --     end
        -- end
    end
end

function SetPos(x,y,z)
    CSAPI.SetLocalPos(gameObject,x,y,z);
    -- CSAPI.SetLocalPos(bottomObj,0,0.5,z-2);
end

function SetLv(lv)
    -- CSAPI.SetTextMesh(txt_lv,lv);
end

function OnDestroy()
    isRemove = true;
    RemoveModel();
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
shadow=nil;
model=nil;
end
----#End#----