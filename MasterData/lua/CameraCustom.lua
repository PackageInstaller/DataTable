--自定义镜头

local data;

function Awake()
    CameraMgr:SetCamera(this);

    local goRT = CSAPI.GetGlobalGO("CommonRT")
	CSAPI.SetCameraRenderTarget(gameObject,goRT);
end

function SetData(cameraData,targetFightAction)
    data = cameraData;
    fightAction = targetFightAction;        


    if(fightAction)then

        InitAngle();

        SetTargets({ fightAction:GetActorCharacter() },actors);
        SetTargets(fightAction:GetTargetCharacters(),targets,true);
  

--       EventMgr.Dispatch(EventType.Fight_Camera_Render,camera);   
--        if(IsEnemy())then
--            isFlipCamera = 1;
--            EventMgr.Dispatch(EventType.Fight_Flip,true);
--        end
    end

   if(data.time and data.time > 0)then
        FuncUtil:Call(ApplyComplete,nil,data.time);
   end
   
--    if(data.motion_blur)then
--        CameraMgr:StartMotionBlur(data.time or 20000,0.6);
--    end

    if(data.hide_light)then
        EventMgr.Dispatch(EventType.Fight_Scene_Light_State,false);
    end
end

function IsEnemy()
    --return true;
    local character = fightAction:GetActorCharacter();
    return character and TeamUtil:IsEnemy(character.GetTeam());
end

--初始化角度，与攻击者同向
function InitAngle()
    if(not fightAction)then
        return;
    end

    local character = fightAction:GetActorCharacter();

    if(character)then
        local x,y,z = CSAPI.GetWorldAngle(character.gameObject);     
        CSAPI.SetAngle(gameObject,0,y,0);
    end
end

function SetTargets(targetCharacters,targetParentGO,useFix)
    if(targetParentGO == nil or targetCharacters == nil)then
        return;
    end
       
--    local lua = ComUtil.GetLuaTable(targetParentGO);
--    if(lua)then            
--        lua.SetTargets(targetCharacters);
--    else
--        for _,character in pairs(targetCharacters)do
--            CSAPI.SetParent(character.gameObject,targetParentGO);
--        end    
--    end    

    for _,character in pairs(targetCharacters)do        

        local x,y,z;
        if(useFix and onlyFixX)then
            character.transform:SetParent(targetParentGO.transform);

            x,y,z = CSAPI.GetLocalPos(character.gameObject);
            x = 0;
            y = 0;
            CSAPI.SetLocalPos(character.gameObject,x,y,z);
        elseif(useFix and onlyFixZ)then
     
            character.transform:SetParent(targetParentGO.transform);

            x,y,z = CSAPI.GetLocalPos(character.gameObject);
            y = 0;
            z = 0;
            CSAPI.SetLocalPos(character.gameObject,x,y,z);
        else
            CSAPI.SetParent(character.gameObject,targetParentGO);
        end
        
    end  

    putCharacters = putCharacters or {};
    for _,character in pairs(targetCharacters)do
       table.insert(putCharacters,character);
    end  
end

--结束
function ApplyComplete()
    if(not IsNil(camera))then
        CSAPI.SetGOActive(camera,false);
        TryResetMainCamera();
    end

     if(data.motion_blur)then
        CameraMgr:StartMotionBlur(0,0.6);
    end
end


--移除
function Remove()    
   TryResetMainCamera();
   ResetPlaceCharacters();
   CSAPI.SetCameraRenderTarget(gameObject);
   CSAPI.RemoveGO(gameObject);    

   if(data)then
       --重置源场景光源
       if(data.hide_light)then
            EventMgr.Dispatch(EventType.Fight_Scene_Light_State,true);
        end
    end
end

--尝试重置主摄像机
function TryResetMainCamera()
    if(isResetMainCamera)then
        return;
    end
    isResetMainCamera = 1;
    CameraMgr:ResetCamera(this);
end

--重置角色位置
function ResetPlaceCharacters()
    if(putCharacters)then
        for _,character in pairs(putCharacters)do
            if(character and not IsNil(character.gameObject))then
                CSAPI.SetParent(character.gameObject,nil,false);
                character.ResetPlace();
            end
        end
    end
end

--震动
function ApplyShake(time,hz,range,range1,range2,dirGO,decayValue)
    if(actionShake == nil and goAction)then        
        actionShake = ComUtil.GetCom(goAction,"ActionBase");
        if(actionShake == nil)then
            return;
        end
    end
    if(actionShake)then
        range = range or 0;
        range1 = range1 or 0;
        range2 = range2 or 0;
        decayValue = decayValue or 0.25;
        actionShake:Apply(time,hz,range,range1,range2,dirGO,decayValue)
    end
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
goAction=nil;
camera=nil;
end
----#End#----