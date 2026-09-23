local this = {};


function this:GetCameraGO()
     self:Init();

     if(self.goCamera == nil)then
        self.goCamera = self.mgr.gameObject;
     end

     return self.goCamera;
end

--跟随目标
--x:x偏移值
--y:y偏移值
--z:z偏移值
function this:Follow(go,x,y,z)
    self:Init();
    if(not self.mgr)then
        return;
    end
    x = x or 0;
    y = y or 0;
    z = z or 0;

    self.mgr:Follow(go,x,y,z);
end

--移动到指定位置
function this:MoveTo(x,y,z,time,callBack)
    if(_G.lock_fight_camera)then return end;--给录屏用

    self:Init();
    if(not self.mgr)then
        return;
    end
    --LogError("移动" .. tostring(time));
    x = x or 0;y = y or 0;z = z or 0;
    time = time or 500;
    self.mgr:MoveTo(x,y,z,time,callBack);
end


--设置视角
--x：俯视视角
--y：侧向视角
function this:SetViewAngle(x,y,time)
    if(_G.lock_fight_camera)then return end;--给录屏用

    self:Init();
    if(not self.mgr)then
        return;
    end
    --LogError("旋转" .. tostring(time));
    x = x or 0;y = y or 0;
    time = time or 500;
    self.mgr:SetViewAngle(x,y,time);
end

--缩放镜头
--distance：目标距离
--speed：速度
function this:Zoom(distance,speed)
    if(_G.lock_fight_camera)then return end;--给录屏用

    speed = speed or 0;
    --LogError("缩放" .. tostring(time));
    self:Init();
    if(not self.mgr)then
        return;
    end
    self.mgr:Zoom(math.min(1300,distance),speed);
end

--缩放镜头
--distance：目标距离
--time：速度
function this:ZoomInTime(distance,time)
    if(_G.lock_fight_camera)then return end;--给录屏用

    time = time or 1;
    --LogError("镜头缩放：距离：" .. tostring(distance) .. "，时间：" .. tostring(time));
    self:Init();
    if(not self.mgr)then
        return;
    end
    self.mgr:ZoomInTime(math.min(2000,distance),time);
end

function this:SetMotionBlurState(state)
    self.motionBlurState = state;
end

function this:StartMotionBlur(time,blurAmount)
--    if(not self.motionBlurState)then
--        return;
--    end

--    self.mgr:StartMotionBlur(time or 0,blurAmount or 0.5);
end

function this:SetNoiseMoveState(state)
    self:Init();
    if(not self.mgr)then
        return;
    end
    self.mgr:SetNoiseMoveState(state);
end

function this:BlackMask(intensify,speed)
    self:Init();
    if(not self.mgr)then
        return;
    end
    self.mgr:BlackMask(intensify,speed or 1);
end

--震动镜头
function this:ApplyShake(time,hz,range,range1,range2,dirGO,decayValue)
    self:Init();
    if(not self.mgr)then
        return;
    end

    range = range or 0;
    range1 = range1 or 0;
    range2 = range2 or 0;
    decayValue = decayValue or 0.25;
   self.mgr:Shake(time,hz,range,range1,range2,decayValue);

   if(self.luaCameras)then
       for luaCamera,_ in pairs(self.luaCameras)do
            if(luaCamera)then
                luaCamera.ApplyShake(time,hz,range,range1,range2,dirGO,decayValue);
            end
       end
   end
end

function this:SetCameraState(state)
    self:Init();
    if(not self.mgr)then
        return;
    end
    self.mgr.enabled = state;
end
----锁住摄像机一段时间
--function this:DetachCamera(time)
--    self.mgr:DetachCamera(time);
--end
--是否激活主摄像机
function this:EnableMainCamera(isEnable)  
    if(not self.mgr)then
        return;
    end
   self.mgr:EnableMainCamera(isEnable);
   --LogError("设置主相机激活状态：" .. tostring(isEnable));
end

function this:Reset()
    self:Init();
    if(not self.mgr)then
        return;
    end
   self.mgr:ResetCamera();   
end

--设置相机
function this:SetCamera(caller)
    if(caller == nil or IsNil(caller.gameObject))then
        return;
    end
    self.cameraCtrler = caller;

    self:Init();
    if(not self.mgr)then
        return;
    end

    self:EnableMainCamera(false);
    self.mgr:SetCamera(caller.gameObject)
end
--重置相机
function this:ResetCamera(caller)
    if(caller == nil or caller ~= self.cameraCtrler)then
        return;
    end

   self:Init();
    if(not self.mgr)then
        return;
    end

   self.mgr:ResetCamera();
   self:EnableMainCamera(true);
   self.cameraCtrler = nil;
end

--设置自定义的镜头启用状态
function this:SetCustomCameraState(state)
    if(self.cameraCtrler)then
        local targetCamera = ComUtil.GetComInChildren(self.cameraCtrler.gameObject,"Camera");
        if(not IsNil(targetCamera))then            
            targetCamera.enabled = state;
        end
	end
end

--应用镜头通用行为
function this:ApplyCommonAction(fightAction,name,callBack)
    --LogError("镜头：" .. tostring(name));

    --local datas = CameraActionMgr:GetDatas("common");   
    local cameraActions = self:GetCommonActions(name);--datas[CSAPI.StringToHash(name)];

    if(cameraActions ~= nil)then
        local len = #cameraActions;
        for i,v in ipairs(cameraActions)do
            self:ApplyAction(v,fightAction,nil,i == len and callBack or nil);
        end
    end
end

function this:GetCommonActions(name)
    local datas = CameraActionMgr:GetDatas("common");   
    local cameraActions = datas[CSAPI.StringToHash(name)];
    return cameraActions;
end

--添加镜头
function this:AddCamera(luaCamera)
    self.luaCameras = self.luaCameras or {};
    self.luaCameras[luaCamera] = 1;
end
--关闭所有镜头
function this:CloseAllCamera()
    if(self.luaCameras)then
        for luaCamera,_ in pairs(self.luaCameras)do
            if(luaCamera)then
                luaCamera.Remove();
            end
        end
    end 
    self.luaCameras = nil;

    self:Reset();    
end

function this:GetXLuaCamera()
    return _G.xluaCamera;
end

function this:CreateCameraEffs(cameraEffs)
    if(not cameraEffs)then
        return;
    end

    local xluaCamera = self:GetXLuaCamera();
    if(xluaCamera)then
        xluaCamera.CreateCameraEffs(cameraEffs);             
    end 
end

--应用镜头行为
function this:ApplyAction(data,fightAction,target,callBack,ignoreSummon)
--    LogError("镜头控制=======================");
--    LogError(data);

    if(data == nil)then
        LogError("无效镜头控制数据");
        return;
    end
    if(data.name)then
        FuncUtil:Call(self.DoCustom,self,data.delay,data,fightAction,callBack);
    else
        FuncUtil:Call(self.DoAction,self,data.delay,data,fightAction,callBack,ignoreSummon);
    end
end
--执行自定义镜头
function this:DoCustom(data,fightAction,callBack)
    if(data == nil or data.name == nil)then
        LogError("无效定义镜头");
        LogError(data);
        return;
    end

    if(fightAction == nil)then
        LogError("应用自定义镜头失败，缺少FightAction！");
        return;
    end

    local actor = fightAction:GetActorCharacter();
    if(actor == nil)then
        LogError("应用自定义镜头失败，找不到行动者！");
        LogError(data);
        return;
    end
    
    local x,y,z = fightAction:Calculate(data.pos_ref); 

    local giantStr = "";
    if(data.hasGiant and fightAction and fightAction.GetTargetCharacters)then
        local targetCharacters = fightAction:GetTargetCharacters();
        if(targetCharacters)then
            for _,c in pairs(targetCharacters)do
                local cfgModel = c.GetCfgModel();
                if(cfgModel and cfgModel.giant)then
                    giantStr = "_giant";
                    break;
                end
            end
        end
    end
    local cameraResName = data.name .. giantStr;
    local go = actor.CreateGO(data.name,x,y,z);
    local lua = ComUtil.GetLuaTable(go);
    if(lua)then
        self:AddCamera(lua);
        lua.SetData(data,fightAction);
    end
end

--执行
function this:DoAction(data,fightAction,callBack,ignoreSummon)
--    LogError("镜头设置=================================================================");
--    LogError(data);

    local time = data.time or 1;
    
    if(data.overlook_angle ~= nil or data.side_angle ~= nil)then
        local angleSide = data.side_angle;
        if(angleSide ~= nil and angleSide ~= 0)then
            if(fightAction ~= nil)then               
                local actor = fightAction:GetActorCharacter();
                if(actor ~= nil and actor.IsEnemy())then
                    angleSide = angleSide * -1;
--                    angleSide = angleSide + 180;
                end
            end
        end

        self:SetViewAngle(data.overlook_angle or 9999,angleSide or 9999,time);
    end
    if(data.distance ~= nil)then
        local dis = data.distance;
        if(not data.ignore_dis_fix and  fightAction and data.pos_ref)then       
            local disFix = fightAction:GetCameraAddHeight(data.pos_ref);
            dis = dis + disFix;
        end
        local disAdd = (not ignoreSummon and FightGroundMgr:HasSummon()) and 200 or 0;
        self:ZoomInTime(dis + disAdd,time);
    end

    local x,y,z = nil;
    if(data.pos_ref ~= nil)then
        x = data.pos_ref.offset_row;
        y = data.pos_ref.offset_height;
        z = data.pos_ref.offset_col;
    end


   

    if(data.pos_ref ~= nil)then
        if(fightAction ~= nil)then
            x,y,z = fightAction:Calculate(data.pos_ref); 
        else
            x,y,z = FightPosRefUtil:Calculate(data.pos_ref);
        end  

--        local yAdd = 0;
--        if(data.pos_ref.y_add)then
--            yAdd = fightAction:GetCameraAddHeight(data.pos_ref) or 0;
--        end
--        y = y + yAdd * 0.01;

        self:MoveTo(x,y,z,time,callBack);                
    end

    if(data.motion_blur)then
        self:StartMotionBlur(time,0.6);
    end
end


----开关Bloom
function this:SwitchBloom(isOn)
    if(self.mgr)then
        self.mgr:SwitchCameraBloom(isOn);
    end
end
--开关HDR
function this:SwitchHDR(isOn)
    if(self.mgr)then
        self.mgr:SwitchCameraHDR(isOn);
    end
end
--设置镜头看着指定目标
function this:LookTargets(targetLists,angleOverLook,angleSide,dis,time)
    local x,y,z;
    time = time or 200;
    
    local zMin = 9999;
    local zMax = -9999;
    local teamId = nil;
    for _,id in pairs(targetLists)do
        local character = CharacterMgr:Get(id);
        if(character ~= nil)then
            x,y,z = character.GetPos();
            zMin = z < zMin and z or zMin; 
            zMax = z > zMax and z or zMax; 

            teamId = character.GetTeam();
        end
    end

    local targetZ = (zMin + zMax) / 2;
    x,y,z = FightGroundMgr:GetCenter(teamId);
    z = targetZ;
    --CameraMgr:MoveTo(x,y,z,time,self.DetachCamera);
    CameraMgr:MoveTo(x,y,z,time);
    CameraMgr:SetViewAngle(angleOverLook,angleSide,time);
    CameraMgr:ZoomInTime(dis,time);
end



--初始化
function this:Init()
    if(self.mgr == nil)then
        self.mgr = CS.SceneCameraMgr.ins;
    end
end

return this;