--类型
FireBallType = FireBallType or
{
    --特效
    Effect = 0,
    --攻击
    Attack = 1,
    --治疗
    Cure = 2,
    --Buff
    Buff = 3,
    --Debuff
    DeBuff = 4,
}


--创建者角色
local character;
--战斗行为数据
local fightAction;
--配置
local cfg;


--初始化
--originCharacter：创建者
--fbFireBall：FightAction数据
--cfgFireBall：配置
function Init(originCharacter,fbFireBall,cfgFireBall)
    if(originCharacter == nil or IsNil(originCharacter.gameObject))then
        Remove();
        return;
    end

    fightAction = fbFireBall;
    cfg = cfgFireBall;
    character = originCharacter;

    --初始化翻转
    InitFlip();  
    --初始化角度
    InitAngle();    
    --创建特效
    CreateEffect(); 
    --播放声音
    PlaySound();
    --启动自毁
    ApplyDestroyByTime();

    --目标处理，攻击或者回血
    ApplyHits();
end

function GetCfg()
    return cfg;
end
function GetFightAction()
    return fightAction;
end

--自毁
function ApplyDestroyByTime()
    
    if(cfg and cfg.time)then
        FuncUtil:Call(Remove,nil,cfg.time);
    else
        LogError("FireBall未设置时长");
        LogError(cfg);
    end
end

function InitFlip()    
    local xScale = character and character.GetFlipScale() or 1;
    if(cfg and cfg.effect_no_flip)then
       xScale = 1;
    end
    CSAPI.SetScale(gameObject,xScale,1,1);
end
--初始化角度，与攻击者同向
function InitAngle()
--    if(cfg and cfg.effect_no_rotate)then
--        CSAPI.SetWorldAngle(gameObject,0,0,0);
--        return;
--    end

    local x,y,z = CSAPI.GetWorldAngle(character.gameObject);

    if(y > 0)then
        CSAPI.SetWorldAngle(gameObject,0,y,0);
    end
    --local teamId = character.GetTeam();
    --local yAngle = TeamUtil:IsEnemy(teamId) and 180 or 0;
    --CSAPI.SetAngle(gameObject,0,yAngle,0);
end

function SetAngle(x,y,z)
    CSAPI.SetWorldAngle(gameObject,x,y,z);
end

--创建特效
function CreateEffect()
    if(no_fb_eff)then
        return;
    end

    --if(IsSkip() and not DontRemoveWhenSkip())then
    --    return;
    --end
    if(IsSkip())then
        return;
    end
    
    local res = cfg and cfg.effect;

    if(res == nil)then
        return;
    end  
    local packName = cfg.effect_pack or character.GetModelName();
    res = packName .. "/" .. res;
    ResUtil:CreateEffect(res,0,0,0,gameObject,OnEffCreated);
end

function OnEffCreated(go)
    if(IsNil(gameObject))then
        CSAPI.RemoveGO(go);
        return;
    end
    effGO = go;

    if(cfg and (cfg.path_index or cfg.path_target))then
        local lua = ComUtil.GetLuaTable(go);
        if(lua)then            
            lua.Init(this);
        end
    end
end

function DontRemoveWhenSkip()
    return cfg and cfg.dont_remove_when_skip;
end

function IsSkip()
    return FightActionMgr:IsSkiping() or FightActionMgr:GetAutoSkipNext() or character.IsSkipSkill();
end

function PlaySound()
    if(IsSkip())then
        return;
    end

    if(not StringUtil:IsEmpty(cfg.cue_sheet))then
        local cueName = cfg.cue_name;
        if(cfg.cue_names)then
            local index = CSAPI.RandomInt(1, #cfg.cue_names);
            cueName = cfg.cue_names[index];         
        end
        local volumeCoeff = cfg.volume_coeff;
        --LogError(CSAPI.GetTime() .. ":cue_sheet:" .. tostring(cfg.cue_sheet) .. ",cueName:" .. tostring(cueName));
        CSAPI.PlaySound(cfg.cue_sheet,cueName,false,true,cfg.cue_feature and "feature" or "",-1,nil,0,volumeCoeff);
        playedCueSheet = cfg.cue_sheet;
        playedCueName = cueName;
    end
end

function StopSound()
    if(playedCueSheet)then
        CSAPI.StopTargetSound(playedCueSheet, playedCueName);
    end
end

--摄像机震动
function ApplyCameraShake()
    if(IsSkip())then
        return;
    end


    local shakeData = cfg.camera_shake;
    if(shakeData == nil)then
        return;
    end

    
    CameraMgr:ApplyShake(shakeData.time,shakeData.hz,shakeData.range,shakeData.range1,shakeData.range2,shakeData.shake_dir and gameObject,shakeData.decay_value);
    --CameraMgr:ApplyShake(200,60,150,20,20,gameObject);

    --设备震动屏蔽
--    if(shakeData.vibrate)then
--        CSAPI.Vibrate2(0.5);
--    end
end


function ApplyHits()
    if(fightAction == nil)then
        return;
    end
    local hits = cfg.hits;
    
    if(hits == nil or #hits == 0)then
        return;
    end

    local targetType = cfg.type;

    local list = nil;
    local func = nil;
   
    if(targetType == FireBallType.Attack)then
        --攻击
        list = fightAction:GetTargetCharacters();
        func = ApplyDamage;
    elseif(targetType == FireBallType.Cure)then
        --治疗
        list = fightAction:GetCureCharacters();
        func = ApplyCure;
    elseif(targetType == FireBallType.Buff)then
        --Buff
        list = fightAction:GetBuffCharacters();
        func = ApplyBuff;
    elseif(targetType == FireBallType.DeBuff)then
        --Debuff
        list = fightAction:GetDebuffCharacters();
        func = ApplyDebuff;
    end    
    local hitDelayCoeff = cfg.hit_delay_coeff_dis;
    if(list)then
        for _,targetCharacter in pairs(list)do
            if(targetCharacter)then
                for _,hitDelay in ipairs(hits) do  
                    local delayAdd = 0;
                    if(hitDelayCoeff)then
                        local x1,y1,z1 = CSAPI.GetPos(gameObject);
                        local x2,y2,z2 = CSAPI.GetPos(targetCharacter.gameObject);
                        local dis = math.sqrt((x1 - x2)*(x1 - x2) +(z1 - z2) * (z1 - z2));
                        local hitDisOffset = (cfg.hit_dis_offset or 0) * 0.01;
                        dis = dis - hitDisOffset;
                        delayAdd = math.max(0,math.floor(dis * hitDelayCoeff));
                    end
                           
                    if(IsSkip())then   
                        func(targetCharacter);
                    else                        
                        FuncUtil:Call(func,nil,hitDelay + delayAdd,targetCharacter); 
                    end
                end
            end
        end
    end
end

--治疗
function ApplyCure(targetCharacter)  
    if(not cfg)then
        return;
    end
    local id = targetCharacter.GetID();   
    fightAction:ApplyCureData(id);      
    ApplyHitCreates(targetCharacter);     
end
--Buff
function ApplyBuff(targetCharacter)
    if(not cfg)then
        return;
    end
    local id = targetCharacter.GetID();   
    if(not cfg.is_fake)then   
        if(fightAction)then
            fightAction:ApplyBuffData(id,cfg.work_delay);   
        end
    end
    ApplyHitCreates(targetCharacter);
end
--Debuff
function ApplyDebuff(targetCharacter)
    if(not cfg)then
        return;
    end
    local id = targetCharacter.GetID();         
    fightAction:ApplyDebuffData(id,cfg.work_delay);   
    ApplyHitCreates(targetCharacter);
end

--伤害
function ApplyDamage(targetCharacter)
    if(not cfg)then
        return;
    end
    if(targetCharacter == nil)then
        LogError("命中目标不存在");
        return;
    end
    if(fightAction == nil)then
        LogError("命中目标，但找不到伤害数据");
        LogError(cfg);
        return;
    end    
    
    local id = targetCharacter.GetID();         
     
    if(cfg.is_fake)then
        --假攻击不造成真实伤害
        local validState = fightAction:IsAttackValid(id);   
        --LogError("id:" .. id .. ",state:" .. tostring(validState));
        if(validState)then
             ApplyHitCreates(targetCharacter); 

             if(cfg.fake_damage)then
                targetCharacter.ApplyHit(cfg.hit_type);
                ApplyCameraShake();
             end
        end      

        return;
    else
        local hitState = fightAction:ApplyHitData(id,false,cfg.work_delay);         
        if(hitState == false)then
            return;
        end
    end                    
              
    if(cfg.work_delay)then    
        FuncUtil:Call(ApplyHitCharacter,nil,cfg.work_delay,targetCharacter);
    else
        ApplyHitCharacter(targetCharacter)          
    end
                                      
    ApplyHitCreates(targetCharacter);  

    if(cfg.destroy_eff_when_hit)then
        RemoveEff();
    end
end

function ApplyHitCharacter(targetCharacter)
    if(not cfg)then
        return;
    end
    
    targetCharacter.ApplyHit(cfg.hit_type);
           
    --攻击反馈（定帧）
    --character.ApplyPause(cfg.time_feedback_attacker);
    --targetCharacter.ApplyPause(cfg.time_feedback_target);

    ApplyCameraShake();   
end

--申请击中创建物
function ApplyHitCreates(targetCharacter)
    if(cfg.hit_creates and #cfg.hit_creates > 0)then  
--        LogError("命中创建物");
--        LogError(cfg.hit_creates);
           
        CreateFireBalls(cfg.hit_creates,targetCharacter);   
    end 
end

function Remove()
    if(isRemoved)then
        return;
    end

    isRemoved = true;
    if(cfg and cfg.destroy_creates ~= nil and #cfg.destroy_creates > 0)then                
        CreateFireBalls(cfg.destroy_creates);   
    end

    RemoveEff();

    CSAPI.RemoveGO(gameObject);
end

function RemoveEff()
    if(effGO)then
        CSAPI.RemoveGO(effGO);
        effGO = nil;
    end
end

function CreateFireBalls(list,targetCharacter)
    if(list ~= nil)then    
        for _,v in pairs(list) do
            if(StringUtil:IsEmpty(v) == false)then                
                local cfgFireBall = character.GetFireBallDataByKey(v);
                if(targetCharacter == nil)then
                    targetCharacter = fightAction:GetActionTarget(cfgFireBall.pos_ref);
                end
                local x,y,z = FightPosRefUtil:Calculate(cfgFireBall.pos_ref,character,targetCharacter,fightAction);
                
                local fb = FireBallMgr:Create(x,y,z,character,fightAction,cfgFireBall,nil,targetCharacter);                        
           end            
       end
   end
end

--设置命中目标
function SetHitTarget(character)
    --LogError("设置命中目标：" .. (character and tostring(character.GetModelName()) or "空"));

    hitTargetCharacter = character;
end
function GetHitTarget()
   --LogError("获取命中目标：" .. (hitTargetCharacter and tostring(hitTargetCharacter.GetModelName()) or "空"));
   return hitTargetCharacter; 
end

--清理
function Clear()
    character = nil;
    fightAction = nil;
    cfg = nil;

    isRemoved = nil;
    SetHitTarget(nil);    

    playedCueSheet = nil;
    playedCueName = nil;
end