local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	
	return ins;
end

--初始化
function this:Init(character)
    self.character = character;
end 

--重置
function this:Reset()
    self.fightAction = nil;

    self.cfgSkill = nil;--技能配置
    self.castName = nil;--技能名称
    self.castStateData = nil;--技能状态数据
    self.castCameraData = nil;--技能镜头数据

    self.timerComplete = false;
    self.isTeleport = nil;
    self.isTeleportBack = nil;

    
    self:ClearCharactersFloatDatas();
end

--清理角色缓存的伤害数据
function this:ClearCharactersFloatDatas()
    local allCharacters = CharacterMgr:GetAll();
    if(allCharacters)then
        for id,character in pairs(allCharacters)do
            character.ClearFloatDatas();
        end
    end
end


--播放技能行为
function this:Play(fightAction)
    --CSAPI.DisableInput(1000);
    self.isPlaying = true;
    self:Reset();   
    self:InitPlay(fightAction);
    
    if(self.cfgSkill.type ~= SkillType.Summon)then
        FuncUtil:Call(self.character.ApplyCastPreFB,nil,FightClient:GetFightMaskDelayTime(),self.castName);
        --self.character.ApplyCastPreFB(self.castName);  
    end
    
    if(fightAction and fightAction:IsOverLoadSkill() and self.character)then        
        self.character.SetOverloadState(true,false); 
        self.character.PlayOverloadSound(false);
    end

    EventMgr.Dispatch(EventType.Character_FightInfo_Show,false); 
    if(self:HasCustomCamera() and not self.character.IsSkipSkill())then                
        --self:SetSceneMaskState(true);
        
        local delayTime = FightClient:GetFightMaskDelayTime();
        EventMgr.Dispatch(EventType.Character_HeadInfo_Scale_State,false);       
        EventMgr.Dispatch(EventType.Fight_Mask,self.character.GetID()); 
        FuncUtil:Call(self.CastReady,self,delayTime);
        FuncUtil:Call(self.SetSceneMaskState,self,delayTime,true);

        local hideSceneTime = self:GetHideSceneTime();
        if(hideSceneTime and hideSceneTime > 0 and not self.character.IsSkipSkill())then
            FuncUtil:Call(self.RecoverScene,self,hideSceneTime + delayTime);
        end
        --协战标签
        local protectCharacter = self.fightAction:GetProtectCharacter();
        if(protectCharacter)then
            local targetCharacter = self.fightAction:GetTargetCharacter();  
            EventMgr.Dispatch(EventType.Fight_Trigger_Event_Update,{ character = targetCharacter,typeIndex = 4}); 
        end
    else
        local protectCharacter = self.fightAction:GetProtectCharacter();
        if(protectCharacter)then            
            self:PlayProtecter();
            FuncUtil:Call(self.CastReady,self,1000);
        else
            self:CastReady();
        end      
    end
    
end

--播放时初始化
function this:InitPlay(fightAction)
    self.fightAction = fightAction;    

    --获取技能配置
    self.cfgSkill = Cfgs.skill:GetByID(self.fightAction:GetSkillID());
    if(self.cfgSkill == nil)then
        LogError("找不到技能配置");
        LogError(self.fightAction.data);        
    end
    --cast状态名称    
    self.castName = self.cfgSkill.cast;    
    --cast状态数据
    self.castStateData = self.character.GetCastStateData(self.castName);   
--    if(not self.castStateData)then
--        LogError("找不到技能状态数据：" .. table.tostring(self.cfgSkill));
--    end
    --cast镜头数据
    self.castCameraData = self.character.GetCastCameraData(self.castName);   
end

--技能准备
function this:CastReady()
    
    if(self:HasCustomCamera() and not self.character.IsSkipSkill())then     
        FightPosRefUtil:SetOverTurn(true);
    end

    self:InitCastSpe();

    self:InitCharactersShowState();

    self:InitFeature();    

    self:InitStartPos();  

    self:InitRot();

    --镜头屏蔽
    self:InitCamera();
    
    self:InitCastView();          

    if(self:HasCustomCamera() and not self.character.IsSkipSkill())then      
        
        self:SetOverTurn(true);--大招改成180翻转，而非镜像

        local skillScene = self.castStateData and self.castStateData.skill_scene;
        if(not skillScene or skillScene ~= "black")then
            FightClient:SetSkillSceneState(true,not self.character.IsEnemy());            
        end  

        EventMgr.Dispatch(EventType.Fight_View_Mask,false); 
        --有专属镜头数据，目前用这个判定是否特殊招式
        self:CastStart();
        
        EventMgr.Dispatch(EventType.Fight_Skill_Skip,true); 
    else
        local fightSetting = FightClient:GetSetting();
        local delayTime = self:NeedShowTeleport() and ((fightSetting.cast_transfer_show_delay or 600) + (fightSetting.teleport_cast_delay or 50)) or 300;
        FuncUtil:Call(self.CastStart,self,delayTime);
    end    
end

function this:SetOverTurn(state)
    
    if(self.character)then      
        local skillCharacters = self.fightAction:GetAllCharacters();
        if(skillCharacters)then      
            for _,character in pairs(skillCharacters)do
                if(self.character.GetTeam() ~= character.GetTeam())then
                    character.SetHitState(state);
                end
            end
        end

        self.character.SetOverTurn(state);
    end
end

function this:SetSceneMaskState(state)
    if(state and self.character and self.character.IsSkipSkill())then
        return;
    end


    if(self.sceneMaskState ~= nil and self.sceneMaskState == state)then
        return;
    end

    --LogError("状态：" .. tostring(state));

    self.sceneMaskState = state;
    EventMgr.Dispatch(EventType.Scene_Mask_Changed,state);

    EventMgr.Dispatch(EventType.Fight_View_Show_Changed,not state); 

    EventMgr.Dispatch(EventType.Fight_View_Main_Info_Show_State,not state);     
end

--是否有专属镜头
function this:HasCustomCamera()
    return self.castCameraData ~= nil;
end

function this:GetHideSceneTime()
    
    if(self.castStateData )then
        local playTime = self.castStateData.play_time or 0;
        local hideTime = self.castStateData.hide_scene_time or 0;
        if(playTime > hideTime)then
            return hideTime;
        end
    end
end
function this:HasRecoverSceneTime()
    local time = self:GetHideSceneTime();
    return time and time > 0;
end

--初始化技能特殊设置
function this:InitCastSpe()
    if(self.character.IsSkipSkill())then
        return;
    end


     --技能特殊设置
    if(self.castStateData and self.castStateData.spe_setting)then
         self:SetOverTurn(true);

         self.goSpeSetting = self.character.CreateGO(self.castStateData.spe_setting);
         
         self.character.FixGoScale(self.goSpeSetting);

         local angle = self.character.GetOverTurnAngle();
         --LogError(angle);
         CSAPI.SetAngle(self.goSpeSetting,0,angle,0);
    end     
end

--初始化角色显示状态
function this:InitCharactersShowState()

    if(self.character.IsSkipSkill())then
        return;
    end

    --同调不初始化角色显示状态，由同调脚本控制
    local skillType = self.cfgSkill and self.cfgSkill.type;  
    if(skillType == SkillType.Unite)then
        return;
    end    

    if(self.fightAction:IsOverLoadSkill())then
        CharacterMgr:SetAllShowState(true);     
    end

    local partCharacter = nil;

    if(not self.castStateData or (not self.castStateData.feature and not self.castStateData.dont_hide_others))then
    
        local list = self.fightAction:GetAllCharacters();      
        local allCharacters = CharacterMgr:GetAll();

        --local showTeleport = self:NeedShowTeleport();
        for id,tmpCharacter in pairs(allCharacters)do
            
            local isHelp = self.fightAction:IsHelp();
            if(tmpCharacter and (not isHelp or tmpCharacter == self.character))then       
                local dontHideFriend = self.castStateData and self.castStateData.dont_hide_friend and tmpCharacter.GetTeam() == self.character.GetTeam();
                local dontHideEnemy = self.castStateData and self.castStateData.dont_hide_enemy and tmpCharacter.GetTeam() ~= self.character.GetTeam();
                if(self.castStateData and (dontHideFriend or dontHideEnemy))then
                    --不隐藏友军
                else
                    local hasCustomCamera = self:HasCustomCamera();

                    local isShow = list[id] ~= nil;

                    --被保护的角色，在大招中不显示
                    if(hasCustomCamera and not self.character.IsSkipSkill())then
                        local protectCharacter = self.fightAction:GetProtectCharacter();
                        if(protectCharacter == tmpCharacter)then
                            isShow = false;
                        end
                    end
                    --LogError(tmpCharacter.GetModelName() .. ":" .. tostring(isShow))
                    tmpCharacter.SetShowState(isShow,nil,not hasCustomCamera,true);
                    --showTeleport or 
                    if(not isShow)then
                        tmpCharacter.SetEffShowState(false);   
                    else
                        if(tmpCharacter ~= self.character and tmpCharacter.IsPart())then--角色部位
                            partCharacter = tmpCharacter;
                            --LogError("aa");
                        end
                    end
                end                                             
            end
        end        
    end

    if(partCharacter)then
        partCharacter.ShowParts();
        self.partCharacter = partCharacter;
    end
    --初始化被保护者（）
    --self.fightAction:InitProtectCharacter();
end

function this:HashFeature()
    return self.castStateData and self.castStateData.feature and not self:HasCustomCamera();
end

function this:InitFeature()
    if(self:HashFeature())then
        CameraMgr:BlackMask(0.8,1.5);

        local list = CharacterMgr:GetAll();  
        local skillList = self.fightAction:GetAllCharacters();      

        for _,character in pairs(list)do            
            if(character)then     
                if(skillList[character.GetID()])then    
                    character.SetLayer(30,0);  
                else
                    character.SetLayer(24,29);
                    character.SetEffShowState(false); 
                    character.SetShowState(false,nil,true,true); 
                end                                     
            end
        end 

    end    
end

function this:InitRot()
    if(self.castStateData and self.castStateData.face_to_target)then
        local targetCharacter = self.fightAction:GetTargetCharacter();
        if(not targetCharacter)then
            return;
        end
        self.character.FaceTo(targetCharacter.gameObject);
    end
end

--初始化自己的位置
function this:InitStartPos()     
    if(self.character.IsSkipSkill())then
        return;
    end
    
    if(self.castStateData and self.castStateData.start_pos)then
        local x,y,z = self.fightAction:Calculate(self.castStateData.start_pos);      
        --local x0,y0,z0 = self.character.GetPos();  
        --LogError("x:" .. tostring(x) .. "y:" .. tostring(y) .. "z:" .. tostring(z));
        if(self:HasCustomCamera())then
            --目标位置在不动区域内，不瞬移
            self.character.SetPos(x,y,z);     
        else
            if(self:NeedShowTeleport())then
                self.isTeleport = 1;
                
                local goType = self.castStateData.go_type or 0;
                local effData = self.castStateData.go_eff and {eff = self.castStateData.go_eff,action = self.castStateData.go_action};
                --LogError(self.castStateData);
                self:TransferCharacter(self.character,x,y,z,goType,effData);    
                
                --buff处理
                if(self.castStateData.hide_buff)then
                    self.character.SetBuffEffShowState(false);
                end
                              
            else                
                self.character.SetPos(x,y,z);
            end                       
        end
        
    end
end


--播放保护者行为
function this:PlayProtecter()
    local protectCharacter = self.fightAction:GetProtectCharacter();
    local targetCharacter = self.fightAction:GetTargetCharacter() or self.fightAction:GetDebuffCharacter();
    if(targetCharacter == nil)then
        LogError("触发援护，但没找到被保护的目标，请把下一条数据截出来");
        LogError(self.fightAction.data);
        return;
    end

    local dir = protectCharacter.GetDir();
    local x,y,z = protectCharacter.GetPartPos(1);
    x = x + dir * -1;

    self:TransferCharacter(targetCharacter,x,y,z);  

    EventMgr.Dispatch(EventType.Fight_Trigger_Event_Update,{ character = targetCharacter,typeIndex = 4}); 
end

function this:TransferCharacter(character,x,y,z,goType,effData)
    if(goType and goType == 1)then
        character.EnterState("castmove");
        CSAPI.MoveTo(character.gameObject,nil,x,y,z,nil,0.3);
    else
        character.SetShowState(false,nil,true,nil,effData);
        local fightSetting = FightClient:GetSetting();
        local cast_transfer_show_delay = fightSetting.cast_transfer_show_delay or 600;

        FuncUtil:Call(self.DelaySetPos,self,cast_transfer_show_delay,character,x,y,z); 
    end
end

function this:DelaySetPos(character,x,y,z)
    character.SetPos(x,y,z);     
    --character.SetShowState(true,nil,true);
    local effData = self.castStateData and self.castStateData.back_eff and {eff = self.castStateData.back_eff,action = self.castStateData.back_action};                              
    character.SetShowState(true,nil,true,nil,effData);
end
--是否需要瞬移效果
function this:NeedShowTeleport()
    local protectCharacter = self.fightAction:GetProtectCharacter();
    if(protectCharacter)then
        return true;
    end

    if(not self:HasCustomCamera() and self.castStateData and self.castStateData.start_pos)then
        local x,y,z = self.fightAction:Calculate(self.castStateData.start_pos);      
        local x0,y0,z0 = self.character.GetPos();  
        if(math.abs(x - x0) > 0.2 or math.abs(z - z0) > 0.2)then
            return true;
        end
    end

    return false;
end

--初始化镜头
function this:InitCamera()
    if(self.character.IsSkipSkill())then
        return;
    end    

    --技能开始时初始镜头设置
    if(self.castStateData and self.castStateData.start_camera)then
        CameraMgr:ApplyAction(self.castStateData.start_camera,self.fightAction,self.character.gameObject,nil,true);
    end

    if(not self:HasCustomCamera())then--有专属镜头时，不会应用默认技能镜头
        if(self.castStateData and self.castStateData.feature and not self.castStateData.feature_camera_no_transform)then            
            if(self:NeedShowTeleport())then                
                FuncUtil:Call(self.InitFeatureCamera,self,self:GetCastDefaultCameraDelayTime());
            elseif(self.castStateData and self.castStateData.common_camera)then                  
                CameraMgr:ApplyCommonAction(self.fightAction,self.castStateData.common_camera);   
            else
                self:InitFeatureCamera();
            end
        else
            if(self:NeedShowTeleport())then                
                FuncUtil:Call(self.InitCastDefaultCamera,self,self:GetCastDefaultCameraDelayTime());
            elseif(self.castStateData and self.castStateData.common_camera)then                  
                CameraMgr:ApplyCommonAction(self.fightAction,self.castStateData.common_camera);   
            else
                local skillType = self.cfgSkill.type;  
                if(skillType ~= SkillType.Unite)then
                    self:InitCastDefaultCamera();
                end                
            end
        end        
    end
end

function this:GetCastDefaultCameraDelayTime()
    local fightSetting = FightClient:GetSetting();
    return fightSetting.cast_default_camera_delay or 0;
end

local key_cast_feature_0 = "cast_feature_0";
function this:InitFeatureCamera()
       
    CameraMgr:ApplyCommonAction(self.fightAction,key_cast_feature_0); 

    local cameraActionData = self:GetCameraAction(key_cast_feature_0);
    local time = cameraActionData.time or 200;
    local x,y,z =  self.character.GetPos();            
    if(self.castStateData and self.castStateData.start_pos)then
        x,y,z = self.fightAction:Calculate(self.castStateData.start_pos);           
    end
    local posRef = cameraActionData.pos_ref;
    local xOffset,zOffset = FightPosRefUtil:CalculateOffset(posRef,self.character.GetDir())

    local targetZ = z + zOffset;
    targetZ = math.max(targetZ,-0.5);
    targetZ = math.min(targetZ,0.5);
    CameraMgr:MoveTo(x + xOffset,posRef.offset_height * 0.01,targetZ,time);


    local featureTime = self.castStateData and self.castStateData.feature_time or 1500;
    FuncUtil:Call(self.InitCastFeatureCamera,self,featureTime);

    --self:InitCastFeatureCamera();
end

function this:GetCameraActionTime(key)
    local actionDatas = CameraMgr:GetCommonActions(key);   
    if(actionDatas)then
        return actionDatas[1].time;
    end
end
function this:GetCameraAction(key)
    local actionDatas = CameraMgr:GetCommonActions(key);   
    if(actionDatas)then
        return actionDatas[1];
    end
end


local key_cast_ready = "cast_ready";
--初始化技能默认镜头
function this:InitCastDefaultCamera(time)      
    local useCastDefaultCamera = not self.castStateData or not self.castStateData.no_cast_camera;     
    if(useCastDefaultCamera)then          
        CameraMgr:ApplyCommonAction(self.fightAction,key_cast_ready);   
    end

    local cameraActionData = self:GetCameraAction(key_cast_ready);
    local time = cameraActionData.time or 300;


    local x1 = 10;
    local x2 = -10;

    local targetZ = nil;
    local minTargetZ = 0;
    local skillCharacters = self.fightAction:GetAllCharacters();
    if(skillCharacters)then
        for _,character in pairs(skillCharacters)do
            local x,y,z =  character.GetPos();            
            
             if(character == self.character)then
                if(self.castStateData and self.castStateData.start_pos)then
                    local x0,y0,z0 = self.fightAction:Calculate(self.castStateData.start_pos);   
                    x = x0;     
                    targetZ = z0;
                end
            end
            x1 = math.min(x1,x);
            x2 = math.max(x2,x);            
            minTargetZ = math.min(minTargetZ,z);
        end
    end


    local fightSetting = FightClient:GetSetting();
    local range = (fightSetting.camera_range_x or 300) * 0.01;
   
    local xPos = (x1 + x2) * 0.5;
    xPos = math.max(xPos,-range);
    xPos = math.min(xPos,range);

    if(not targetZ)then
        if(minTargetZ < 0)then
            targetZ = -1;
        else
            targetZ = 0;
        end
    end

    local posRef = cameraActionData.pos_ref;
    targetZ = math.max(targetZ,-0.5);
    targetZ = math.min(targetZ,0.5);
    CameraMgr:MoveTo(xPos,posRef.offset_height * 0.01,targetZ,time);    
    --local disFix = minTargetZ < 0 and 100 or 0;
    --self:FixZoom(x1,x2,time);
end

local key_cast_feature = "cast_feature";
--初始化技能默认镜头
function this:InitCastFeatureCamera(time)           
    CameraMgr:ApplyCommonAction(self.fightAction,"cast_feature");   
    if(not time)then
        time = self:GetCameraActionTime(key_cast_feature);        
    end
    time = time or 300;

    local x1 = 0;
    local x2 = 0;

    local targetZ = nil;
    local minTargetZ = 0;
    local skillCharacters = self.fightAction:GetAllCharacters();
    if(skillCharacters)then
        for _,character in pairs(skillCharacters)do
            local x,y,z =  character.GetPos();            
            
             if(character == self.character)then
                if(self.castStateData and self.castStateData.start_pos)then
                    local x0,y0,z0 = self.fightAction:Calculate(self.castStateData.start_pos);   
                    x = x0;     
                    targetZ = z0;
                end
            end

            x1 = math.min(x1,x);
            x2 = math.max(x2,x);            

            minTargetZ = math.min(minTargetZ,z);
        end
    end
    local fightSetting = FightClient:GetSetting();
    local range = (fightSetting.camera_range_x or 300) * 0.01;
   
    local xPos = (x1 + x2) * 0.5;
    xPos = math.max(xPos,-range);
    xPos = math.min(xPos,range);
   
    if(not targetZ)then
        if(minTargetZ < 0)then
            targetZ = -1;
        else
            targetZ = 0;
        end
    end
    targetZ = math.max(targetZ,-0.5);
    targetZ = math.min(targetZ,0.5);
    CameraMgr:MoveTo(xPos,1,targetZ,time);  

    --local disFix = minTargetZ < 0 and 100 or 0;
    --self:FixZoom(x1,x2,time);
end

function this:FixZoom(x1,x2,time)
    
    local delta = math.abs(x1 - x2);
    local zoomFix = 0;
--    if(delta > 4 and disFix)then
--       zoomFix = math.floor((delta / 5) * disFix);
--    end

    --LogError("x1:" .. x1 .. ",x2:" .. x2  .. ",disFix:" .. disFix .. ",delta:" .. delta .. ",zoomFix:" .. zoomFix );

    if(delta > 12)then   
        local add = math.min(300, math.floor((delta - 11) * 30));
        CameraMgr:ZoomInTime(950 + add + zoomFix,time);
    elseif(delta > 11)then    
        CameraMgr:ZoomInTime(875 + zoomFix,time);
    elseif(delta > 10)then    
        CameraMgr:ZoomInTime(800 + zoomFix,time);
    elseif(delta > 9)then    
        CameraMgr:ZoomInTime(750 + zoomFix,time);
    elseif(delta >= 8)then    
        CameraMgr:ZoomInTime(700 + zoomFix,time);
    else
        if(zoomFix > 0)then 
            CameraMgr:ZoomInTime(700 + zoomFix,time);
        end
    end
end

--初始化技能时ui显示
function this:InitCastView()
    EventMgr.Dispatch(EventType.Input_Target_Changed);
    EventMgr.Dispatch(EventType.Fight_Img_Update,self.character);
    
    EventMgr.Dispatch(EventType.Character_FightInfo_Show,false); 
     --启动伤害统计
    EventMgr.Dispatch(EventType.Fight_Damage_Show_State,true);
end


--开始技能表演
function this:CastStart()   
    self:ApplyCameraEffs();
    self:ApplyCameraShakes();
    self:ApplyHideSetting();
    self:ApplyShadowState(false);--中低配影子隐藏状态

    --技能类型
    local skillType = self.cfgSkill.type;  
    --LogError(self.cfgSkill);
    local playTime = self.castStateData and self.castStateData.play_time or -1;
    local withoutReviveShow = skillType == SkillType.Revive and (StringUtil:IsEmpty(self.castName) or playTime <= 0);
    if(skillType == SkillType.Unite)then  
        --合体   
        FuncUtil:Call(self.ActionTimeOver,self,0);
    elseif(withoutReviveShow)then  
        --复活    
        FuncUtil:Call(self.ActionTimeOver,self,700);
    else
        if(self.fightAction:IsHelp())then
            --该技能时协战
            self.character.SetShowState(true);
            self:InitStartPos();            
            if(self.fightAction.feature)then
                self:SetFeature();
            end
        end

        self:StartAction();
    end
   
end

--镜头效果
function this:ApplyCameraEffs()
    --镜头效果
    local cameraEffs = self.castStateData and self.castStateData.camera_effs;
    if(cameraEffs)then
        local arr = nil;
        for _,cameraEff in ipairs(cameraEffs)do
            if(not cameraEff.ignore_help or not self.fightAction:IsHelp())then
                arr = arr or {};
                table.insert(arr,cameraEff);
            end
        end

        local xluaCamera = CameraMgr:GetXLuaCamera();
        if(arr and xluaCamera)then
            xluaCamera.CreateCameraEffs(arr);
        end
    end
    
--    if(self.fightAction:IsOverLoadSkill())then
--        CameraMgr:CreateCameraEffs({{res="overload/ui_camera_overload"}});          
--    end

    --场景黑色遮罩
--    if(self.castStateData and self.castStateData.hide_scene)then       
--        EventMgr.Dispatch(EventType.Scene_Mask_Changed,true);
--    end
end


function this:ApplyCameraShakes()
    local cameraShakes = self.castStateData and self.castStateData.camera_shakes;
    if(not cameraShakes)then
        return;
    end
   
    for _,shakeData in ipairs(cameraShakes)do
        local delay = shakeData.delay or 0;
        FuncUtil:Call(self.ApplyShake,self,delay,shakeData);
    end
end
function this:ApplyShake(shakeData)
    local decayValue = shakeData.decay_value;
    decayValue = decayValue and decayValue * 0.01 or 0.8;
    CameraMgr:ApplyShake(shakeData.time,shakeData.hz,shakeData.range,shakeData.range,shakeData.range,shakeData.shake_dir and gameObject,decayValue);
end

function this:ApplyShadowState(state)
    local delay = self.castStateData and self.castStateData.hide_shadow_delay;
    if(delay)then
        FuncUtil:Call(self.SetCharacterShadowState,self,delay,state);
    end
end

function this:SetCharacterShadowState(state)
    if(self.character)then
        self.character.SetShadowState(state);
    end
end

function this:ApplyHideSetting()
    if(self.character.IsSkipSkill())then
        return;
    end
    if(self.castStateData and self.castStateData.showDatas)then
        for _,showData in ipairs(self.castStateData.showDatas)do            
            FuncUtil:Call(self.SetTargetsShowState,self,showData.delay,showData);
        end
    end
end
function this:SetTargetsShowState(showData)
    local skillCharacters = self.fightAction:GetAllCharacters();
    if(skillCharacters)then
      
        for _,character in pairs(skillCharacters)do
            if(character ~= self.character or showData.includeSelf)then
                if(showData.isFriend)then
                    if(self.character.GetTeam() == character.GetTeam())then
                        character.SetShowState(showData.showState ~= nil);
                    end
                elseif(showData.isEnemy)then
                    if(self.character.GetTeam() ~= character.GetTeam())then
                        character.SetShowState(showData.showState ~= nil);
                    end
                else 
                    character.SetShowState(showData.showState ~= nil);                   
                end
            end
        end
    end
end


--开始行动
function this:StartAction()   
    self:ApplyFaceDatas();

    if(self.castStateData)then
        --最后一段伤害调用
        if(self.castStateData.last_hit)then
            FuncUtil:Call(self.OnLastHit,self,self.castStateData.last_hit);
        end

        --buff处理
        if(self.castStateData.hide_buff)then
            self.character.SetBuffEffShowState(false);
        end
    end

    
    if(self.cfgSkill.type == SkillType.Summon)then
        --召唤
        self.fightAction:PlaySummon();
        if(not self.character.IsSkipSkill())then
            if(not g_FightMgr or not IsPvpSceneType(g_FightMgr.type))then
                FightClient:SetPlaySpeed(1,true);--1倍数，保证音画同步
            end
            commonSummonEff = ResUtil:CreateEffectImmediately("common/common_summon");
        end
--    elseif(self.cfgSkill.type == SkillType.Unite)then
--        self:SetSceneMaskState(true);
    elseif(self.cfgSkill.type == SkillType.Transform)then
        --变身
        self.fightAction:PlayTransform();
    else    
        --开始放招
        if(self.character.IsSkipSkill())then
            self.character.OnStateEnter(CSAPI.StringToHash(self.castName));
            self:ShowHitEffs();
            local castNameSkip = self.castName and (self.castName .. "_skip");
            if(castNameSkip)then
                self.character.EnterState(castNameSkip);
            end
        else
            --LogError(self.castName .. "========================");
            --LogError(self.fightAction.data);
            --LogError(self.castStateData);
            self.character.ApplyCast(self.castName);  
        end
        local backDelay = self.castStateData and self.castStateData.back_delay;
        if(backDelay)then
            FuncUtil:Call(self.TeleportCustom,self,backDelay); 
        end
    end    
       
    local helpFightActions = self.fightAction:GetHelps();
    if(helpFightActions)then   
         --有协战者
        for _,helpFightAction in ipairs(helpFightActions)do
            EventMgr.Dispatch(EventType.Fight_Trigger_Event_Update,{ character = helpFightAction:GetActorCharacter(),typeIndex = 1});      
        end    
    else
        local customPlayTime = self.fightAction:GetCustomPlayTime();

        local playTime = customPlayTime or (self.castStateData and self.castStateData.play_time);
        if(playTime == nil)then
            --LogError("虽然不是错误，但是还是要设置下技能表演时间。角色=" .. self.character.GetModelName() .. "，技能=" .. self.cfgSkill.cast);
            playTime = self.cfgSkill.action_time or 1000;
        end      
       
        playTime = self.character.IsSkipSkill() and 1000 or playTime;

        FuncUtil:Call(self.ActionTimeOver,self,playTime);
    end   
end

function this:ActionTimeOver()
    --LogError("时间完成");
    self.timerComplete = true;
    self:ApplyComplete();
end


--表情
function this:ApplyFaceDatas()   
    local faceData = self:GetFaceData(1);
    if(faceData)then
        --FuncUtil:Call(self.SetFace,self,faceData.delay,faceData.name or "");
        FuncUtil:Call(self.SetFace,self,faceData.delay,1);       
    end
end

function this:GetFaceData(index)
    local  faceDatas = self.castStateData and self.castStateData.faceDatas;   
    return faceDatas and faceDatas[index];
end

function this:SetFace(index)
    local faceData = self:GetFaceData(index);
    if(faceData)then
        self.character.SetFace(faceData.name or "");

        local nextFaceData = self:GetFaceData(index + 1);
        if(nextFaceData)then
            FuncUtil:Call(self.SetFace,self,nextFaceData.delay - faceData.delay,index + 1);   
        end
    end
end
--播放完成
function this:ApplyComplete()     
    if(self.timerComplete)then        
      
         --协战者无权利控制镜头
        if(self.fightAction:IsHelp())then           
            self.fightAction:Complete();    
            self.character.SetFace("");   
            self.isPlaying = false;

            --协战技能
            if(self.isTeleport and self.character)then
                self.character.SetShowState(false,nil,true);
            end
        else   
             
            local protectCharacter = self.fightAction:GetProtectCharacter(); 
            local hasCamera = self:HasCustomCamera();
            local isModelOffset = nil;
            if(not self.isTeleport and not self.isTeleportBack and not hasCamera)then  
                          
                if(self.castStateData and self.castStateData.start_pos)then
                    isModelOffset = self.character.IsModelOffset();
                end
            end

            

            if(self.isTeleport or protectCharacter or isModelOffset)then
                --需要瞬移效果，自己先消失
                if((self.isTeleport or isModelOffset) and not self.isTeleportBack)then
                    local backType = self.castStateData.back_type or 0;
                    if(backType == 1)then
                        local originPos = self.character.GetOriginPos();
                        local x,y,z = originPos[1],originPos[2],originPos[3];
                        CSAPI.MoveTo(self.character.gameObject,nil,x,y,z,nil,0.3);
                    else     
                        local effData = self.castStateData.go_eff and {eff = self.castStateData.go_eff,action = self.castStateData.go_action};
                              
                        self.character.SetShowState(false,nil,true,nil,effData);
                    end
                end 
                                
                --保护角色传送回原来位置
                if(protectCharacter)then
                    local targetCharacter = self.fightAction:GetTargetCharacter() or self.fightAction:GetDebuffCharacter();
                    local originPos = targetCharacter.GetOriginPos();
                    local x,y,z = originPos[1],originPos[2],originPos[3];
                    self:TransferCharacter(targetCharacter,x,y,z);  
                end                   
               
                
                local fightSetting = FightClient:GetSetting();
                local cast_transfer_show_delay = fightSetting.cast_transfer_show_delay or 600;
                self:ResetDefaultCamera();
                FuncUtil:Call(self.CastComplete,self,cast_transfer_show_delay);
            else
                self:CastComplete();

                local skillType = self.cfgSkill.type;  
                if(skillType ~= SkillType.Unite)then
                    self:ResetDefaultCamera();
                end
            end                              
        end
    end   
end

function this:RecoverFeature()
    if(self.castStateData and self.castStateData.feature)then
        CameraMgr:BlackMask(0,1.5);
        FuncUtil:Call(self.RecoverLayer,self,380);
    end        
end

function this:RecoverLayer()
    local list = CharacterMgr:GetAll();    

    for _,character in pairs(list)do            
        if(character)then         
            character.SetLayer(0,30);   
            character.SetLayer(29,24);
        end
    end 
end


function this:CastComplete()
    if(self:HasCustomCamera() and not self.character.IsSkipSkill())then
        EventMgr.Dispatch(EventType.Fight_Skill_Skip,false); 

        local delayTime = 350;
        if(not self:HasRecoverSceneTime())then
            EventMgr.Dispatch(EventType.Fight_Mask); 
            --delayTime = FightClient:GetFightMaskDelayTime()
            --LogError("遮罩启动");
        end
        FuncUtil:Call(self.CastEnd,self,delayTime);
    else
        self:CastEnd();
    end
end

function this:ResetDefaultCamera()
    CameraMgr:ApplyCommonAction(nil,"to_default_camera");
end

function this:RecoverScene()    
    local skipState = FightActionMgr:TryStopSkip();
 
    EventMgr.Dispatch(EventType.Fight_Skill_Skip,false); 

    local delayTime = 0;
    if(not skipState)then       
        delayTime = 350
        EventMgr.Dispatch(EventType.Fight_Mask); 
    end
    
    FuncUtil:Call(self.DelayRecoverScene,self,delayTime);
end
function this:DelayRecoverScene()
    --local skipState = FightActionMgr:TryStopSkip();
    if(self:HasCustomCamera() and not self.character.IsSkipSkill())then
        CameraMgr:CloseAllCamera();  
        CameraMgr:ApplyCommonAction(nil,"default_camera");
    end
    self:SetSceneMaskState(false);
    FightClient:SetSkillSceneState(false);
    self:SetOverTurn(false);
    EventMgr.Dispatch(EventType.Fight_View_Mask,true);  
    --移除镜头效果
    local xluaCamera = CameraMgr:GetXLuaCamera();
    if(xluaCamera)then
        xluaCamera.RemoveCameraEffs();
    end 

    local characters = CharacterMgr:GetAll();
    if(characters)then
        for _,character in pairs(characters)do      
            if(character)then    
                character.ResetPlace(); 
                character.SetShowState(true,nil,true,character ~= self.character);   
                character.SetEffShowState(true);   
            end
        end
    end
end

function this:IsPlaying()
    return self.isPlaying;
end


--- 显示命中特效
function this:ShowHitEffs()
    local fa = self.fightAction;
    if(not fa)then
        return;
    end
    local targets = fa:GetTargetCharacters();
    if(targets)then
        for _,target in pairs(targets)do
            if(target)then
                local damageFloatDatas = target.GetFloatDatas();
                if(damageFloatDatas)then
                    local originPos = target.GetOriginPos();
                    local x,y,z = originPos[1],originPos[2],originPos[3];
                    ResUtil:CreateEffect("common_hit/common_hit1",x,0,z);
                    --FuncUtil:Call(ResUtil.CreateEffect,ResUtil,400,"common_hit/common_hit1",x,0,z);
                end
            end
        end
    end
end



function this:CastEnd()  
    self.isPlaying = false;
    self.character.SetFace("");    
    self.character.SetSkipSkill(false);
    self:SetCharacterShadowState(true);--还原中低配影子
    EventMgr.Dispatch(EventType.Character_HeadInfo_Scale_State,true);
    EventMgr.Dispatch(EventType.Fight_View_Mask,true); 

    if(self.partCharacter)then
        self.partCharacter.ShowParts();
        self.partCharacter = nil;
    end

    if(self.cfgSkill.type == SkillType.Summon)then
        --还原播放速度
        if(not g_FightMgr or not IsPvpSceneType(g_FightMgr.type))then
            FightClient:SetPlaySpeed();
        end
        if(commonSummonEff)then
            CSAPI.RemoveGO(commonSummonEff);
            commonSummonEff = nil;
        end
        --LogError("还原");
    end

    if(not self:HasRecoverSceneTime())then
        if(self:HasCustomCamera() and not self.character.IsSkipSkill())then
            self:SetOverTurn(false);
            FightPosRefUtil:SetOverTurn(false);
            FightClient:SetSkillSceneState(false);
            CameraMgr:CloseAllCamera();  
            CameraMgr:ApplyCommonAction(nil,"default_camera");

            --LogError("场景还原");
        end
    end

    if(self.fightAction:IsOverLoadSkill())then
        self.character.SetOverloadState(false);
    end

    self:RecoverFeature();

    self:ResetAllCharacters();     
    --自己身上的buff恢复
    if(self.castStateData and self.castStateData.hide_buff)then
        self.character.SetBuffEffShowState(true);
    end     
    --场景黑幕恢复
--    if(self.castStateData and self.castStateData.hide_scene)then
--        EventMgr.Dispatch(EventType.Scene_Mask_Changed,false);
--    end     
    if(not self:HasRecoverSceneTime())then   
        self:SetSceneMaskState(false);     
    end  

    --移除镜头效果
    local xluaCamera = CameraMgr:GetXLuaCamera();
    if(xluaCamera)then
        xluaCamera.RemoveCameraEffs();
    end   

    --移除特殊设置
    if(IsNil(self.goSpeSetting) == false)then
        CSAPI.RemoveGO(self.goSpeSetting);
        self.goSpeSetting = nil;
    end    

    EventMgr.Dispatch(EventType.Fight_Trigger_Event_Update,nil);
    EventMgr.Dispatch(EventType.Fight_Damage_Show_State,nil);      
    

    local skillType = self.cfgSkill.type;  
    if(skillType ~= SkillType.Unite)then
        EventMgr.Dispatch(EventType.Character_FightInfo_Show,true); 
    end

    FuncUtil:Call(self.OnComplete,self,500);  
end




--重置全部角色
function this:ResetAllCharacters()    
    local characters = CharacterMgr:GetAll();
    if(characters)then
        for _,character in pairs(characters)do      
            if(character)then   
                local initPos = self.castStateData and self.castStateData.start_pos;
                local hasCamera = self:HasCustomCamera();
                local fadeToIdle = not initPos and not hasCamera;
                character.ResetPlace(fadeToIdle); 

                local effData = self.castStateData and self.castStateData.back_eff and {eff = self.castStateData.back_eff,action = self.castStateData.back_action};                             
                character.SetShowState(true,nil,true,character ~= self.character,effData);   
                character.SetEffShowState(true);   
            end
        end
    end
end

function this:OnComplete()      
    self.fightAction:ApplySkillComplete();
    --LogError(CSAPI.GetTime());
end


--最后一段攻击结束，触发协战
function this:OnLastHit()
    self:StartHelp();
end

--启动协战
function this:StartHelp()
    local helpFightActions = self.fightAction:GetHelps();
    local count = helpFightActions and #helpFightActions or 0;

    if(helpFightActions)then
        for i,helpFightAction in ipairs(helpFightActions)do
            if(helpFightAction)then        
                if(self.fightAction:IsHelp())then
                    LogError("协战无法再次触发协战！");
                    LogError(a.b)
                    return;
                end

                local helpCharacter = helpFightAction:GetActorCharacter();
                if(helpCharacter == nil)then
                    LogError("协战FightAction出错，找不到协战角色，数据如下");
                    LogError(helpFightAction.data);
                end
                
                FuncUtil:Call(function()
                    if(i == count)then
                        helpFightAction:Play(self.HelpComplete,self);
                    else
                        helpFightAction:Play(self.HelpComplete1,self);
                    end
                end,nil,(i - 1) * 1000);                    
                
                if(self:HashFeature())then
                    helpFightAction:SetFeature();
                end
                if(i == 1)then
                    if(self.isTeleport or self.character.IsModelOffset())then
                        self.isTeleportBack = 1;
                        FuncUtil:Call(self.TeleportBack,self,300);            
                    end
                end

                --LogError("协战触发，有没进大招场景：" .. (self:HasCustomCamera() and "有" or "没"))        
            end   
        end
    end
end

function this:HelpComplete1(helpFightAction)
    FuncUtil:Call(function()
        if(helpFightAction)then
            local character = helpFightAction:GetActorCharacter();            
            character.ResetPlace();
            character.ApplyIdle();
            character.SetShowState(true,nil,true);
            --character.SetShowState(false,nil,true);
        end        
    end,nil,100);
    
end

function this:TeleportCustom()
    if(self.isTeleport or self.character.IsModelOffset())then
        self.isTeleportBack = 1;
        self.character.SetShowState(false,nil,true);        
        FuncUtil:Call(self.TeleportBack1,self,600);      
    end
end
     
function this:TeleportBack()   
    --LogError("dd");
    self.character.SetShowState(false,nil,true);
    FuncUtil:Call(self.TeleportBack1,self,600);            
end

function this:TeleportBack1()   
    self.character.ResetPlace();
    self.character.SetShowState(false,nil,false);
    self.character.SetShowState(true,nil,true);
end

function this:SetFeature()
    if(self.character)then     
        self.character.SetLayer(30,0);  
    end
end

function this:HelpComplete()
    self:ActionTimeOver();
    self.fightAction:ClearHelps();--清理协战
end

return this;