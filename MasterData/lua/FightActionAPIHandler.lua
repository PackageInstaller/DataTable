--API处理
local this = {};
FightActionAPIHandler = this;

---------------------------------------------------------
--处理Eff操作
function this:Handle(effEventData)
    --LogError("执行API：" .. table.tostring(effEventData));

    if(self.effFuncArr == nil)then
        self.effFuncArr = {};

        self.effFuncArr[APIType.Buff] = self.HandleBuff;
        self.effFuncArr[APIType.UpdateBuff] = self.HandleBuff;
        self.effFuncArr[APIType.DelBuff] = self.HandleDelBuff;
        self.effFuncArr[APIType.DeleteShield] = self.HandleDeleteShield;

        self.effFuncArr[APIType.AddHp] = self.EffAction_AddHp;
        self.effFuncArr[APIType.SetHP] = self.EffAction_SetHp;    
        self.effFuncArr[APIType.RestoreHP] = self.EffAction_SetHp;    
        self.effFuncArr[APIType.AddNP] = self.EffAction_AddNP;
        self.effFuncArr[APIType.AddSP] = self.EffAction_AddSP;
        self.effFuncArr[APIType.AddXP] = self.EffAction_AddXP;
        self.effFuncArr[APIType.Sneer] = self.EffAction_Sneer;
        self.effFuncArr[APIType.Silence] = self.EffAction_Silence;        
        self.effFuncArr[APIType.AddAttrPercent] = self.EffAction_AddAttrPercent;    
        self.effFuncArr[APIType.AddAttr] = self.EffAction_AddAttr;            
        self.effFuncArr[APIType.AddShield] = self.EffAction_AddShield;      
        self.effFuncArr[APIType.UpdateProgress] = self.EffAction_UpdateProgress;
        self.effFuncArr[APIType.UpdateSkill] = self.EffAction_UpdateSkill;  
        self.effFuncArr[APIType.ChangeSkill] = self.EffAction_ChangeSkill;                
        self.effFuncArr[APIType.AddProgress] = self.EffAction_AddProgress;      
        self.effFuncArr[APIType.BuffCure] = self.EffAction_BuffCure;
        self.effFuncArr[APIType.BuffDamage] = self.EffAction_BuffDamage;  
        self.effFuncArr[APIType.ForceDeath] = self.EffAction_ForceDeath;  
        self.effFuncArr[APIType.Piaozi] = self.EffAction_Piaozi;  
        self.effFuncArr[APIType.ShowTips] = self.EffAction_ShowTips;  
        self.effFuncArr[APIType.SetInvincible] = self.EffAction_SetInvincible;  
        self.effFuncArr[APIType.UpdateDamage] = self.EffAction_UpdateDamage;  
        self.effFuncArr[APIType.SetFury] = self.EffAction_UpdateFury;  
        self.effFuncArr[APIType.UpdateFury] = self.EffAction_UpdateFury;  
        self.effFuncArr[APIType.AddOwnerEquipSkill] = self.EffAction_AddOwnerEquipSkill;   


        self.effFuncArr[APIType.UpdateValue] = self.EffAction_UpdateValue;  
        self.effFuncArr[APIType.DelValue] = self.EffAction_DelValue;  

        self.effFuncArr[APIType.Custom] = self.EffAction_Custom;  
        

        --暂时不处理的API
        self.effFuncArr[APIType.APIs] = self.EffAction_Nothing;  
        self.effFuncArr[APIType.OnAddBuff] = self.EffAction_Nothing;  
        self.effFuncArr[APIType.OnDelBuff] = self.EffAction_Nothing;  
        self.effFuncArr[APIType.OnRemoveBuff] = self.EffAction_Nothing;  
        self.effFuncArr[APIType.OnTransform] = self.EffAction_Nothing;  
        
        self.effFuncArr[APIType.MissBuff] = self.EffAction_Nothing;  

        self.effFuncArr[APIType.OnBorn] = self.EffAction_Nothing;  
       
        self.effFuncArr[APIType.OnRoundBegin] = self.EffAction_Nothing; 
        self.effFuncArr[APIType.OnRoundOver] = self.EffAction_Nothing;  

        self.effFuncArr[APIType.OnActionBegin] = self.EffAction_Nothing;  
        self.effFuncArr[APIType.OnActionOver] = self.EffAction_Nothing;  

        self.effFuncArr[APIType.OnAttackBegin] = self.EffAction_Nothing;   
        self.effFuncArr[APIType.OnAttackOver] = self.EffAction_Nothing;   
        self.effFuncArr[APIType.OnAttackOver2] = self.EffAction_Nothing;   

        self.effFuncArr[APIType.OnDeath] = self.EffAction_Nothing;   
        self.effFuncArr[APIType.OnCure] = self.EffAction_Nothing;   
        
        self.effFuncArr[APIType.AddLightShield] = self.EffAction_Nothing;   
        self.effFuncArr[APIType.AddPhysicsShield] = self.EffAction_Nothing;   

        self.effFuncArr[APIType.AddCage] = self.EffAction_Nothing;   
        self.effFuncArr[APIType.UpdateCage] = self.EffAction_Nothing;   
        self.effFuncArr[APIType.DelCage] = self.EffAction_Nothing;   

        self.effFuncArr[APIType.OnChangeStage] = self.EffAction_Nothing;   
        self.effFuncArr[APIType.ExtraRound] = self.EffAction_Nothing;           
        self.effFuncArr[APIType.OnResolve] = self.EffAction_Nothing;        
        self.effFuncArr[APIType.ClosingBuff] = self.EffAction_Nothing;   
           
        self.effFuncArr[APIType.OnAddProgress] = self.EffAction_Nothing;        
        self.effFuncArr[APIType.OnReduceProgress] = self.EffAction_Nothing; 
    end
   
    if(effEventData.abnormalities == nil)then

        local func = self.effFuncArr[effEventData.api];   
   
        if(func)then
            func(self,effEventData);
        else
            LogError("暂未支持的API操作，数据如下：");
            LogError(effEventData);
        end
    end
    
    self:HandleFloatFont(effEventData);
end

--啥也不做
function this:EffAction_Nothing(effEventData) 
end

--处理Buff
function this:HandleBuff(data,delays,deads)  
    ClientBuffMgr:UpdateBuff(data);  

    self:HandleBuffEvents(data); 
end
--移除Buff
function this:HandleDelBuff(data)
    --LogError("移除buff" .. tostring(data.uuid));

    ClientBuffMgr:RemoveBuff(data.uuid);

    self:HandleBuffEvents(data);
end
function this:HandleDeleteShield(data)
    --local
end

--处理buff事件
function this:HandleBuffEvents(data)
    if(data.OnCreate)then
        FightActionUtil:PlayAPIsByOrder(data.OnCreate);
    end
    if(data.OnRemoveBuff)then
        FightActionUtil:PlayAPIsByOrder(data.OnRemoveBuff);
    end
end


--加血、扣血
function this:EffAction_AddHp(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
    if(targetCharacter ~= nil and effEventData.add)then
        if(effEventData.add < 0 or effEventData.death)then
            --targetCharacter.ApplyHit(0);
            local hitData = {hpDamage = -effEventData.add,hp = effEventData.hp,death = effEventData.death,isReal = effEventData.isReal}
            if(effEventData.effectID and effEventData.effectID == 0)then
                hitData.dont_play_sound = 1;
            end
            
            targetCharacter.ApplyHitData(hitData);

            if(effEventData.effectID)then
                apiSetting = Cfgs.APISetting:GetByID(effEventData.effectID);
                if(apiSetting and apiSetting.flag == "hit")then
                    targetCharacter.ApplyHit();
                end
            end


            --判断是否加入伤害统计
            local fa = FightActionMgr.curr;
            if(fa and fa:GetType() == FightActionType.Skill)then
                local character = fa:GetActorCharacter();
                if(character.GetTeam() ~= targetCharacter.GetTeam())then
                    EventMgr.Dispatch(EventType.Fight_Damage_Update,-effEventData.add);
                end
            end

            
        else           
            targetCharacter.ApplyCureData(effEventData);
        end
    end
end
--加血、扣血
function this:EffAction_SetHp(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
    if(targetCharacter ~= nil)then
       targetCharacter.UpdateHp(effEventData.hp,nil,true);
       targetCharacter.SetDeadState(effEventData.death);
    end
end

--加NP
function this:EffAction_AddNP(effEventData)
--    LogError("NP变化");
--    LogError(effEventData);
    EventMgr.Dispatch(EventType.Fight_Info_Update,{ npData = effEventData });
end
--加SP
function this:EffAction_AddSP(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
    if(targetCharacter ~= nil)then
        local targetSP = targetCharacter.GetSpInfo();
        if(targetSP and effEventData.add)then
            if((effEventData.sp > targetSP and effEventData.add < 0) or 
            (effEventData.sp < targetSP and effEventData.add > 0))then
                return;
            end            
        end
        targetCharacter.UpdateSp(effEventData.sp,effEventData.maxsp,true);
--    else
--        LogError("add sp fail!" .. table.tostring(effEventData));
    end
end
--加XP
function this:EffAction_AddXP(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
    if(targetCharacter ~= nil)then
        targetCharacter.UpdateXp(effEventData.xp,effEventData.maxxp,true);
    end
end

--嘲讽
function this:EffAction_Sneer(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
--    LogError("嘲讽数据");
--    LogError(effEventData);
    if(targetCharacter ~= nil)then
       
    end
end
--沉默
function this:EffAction_Silence(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
    if(targetCharacter ~= nil)then
       
    end
end


--属性变化
function this:EffAction_AddAttrPercent(effEventData) 
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId); 
    
    if(targetCharacter ~= nil)then
        if(effEventData.attr == "maxhp")then
            targetCharacter.UpdateHp(effEventData.hp,effEventData.maxhp);
        end
    end
end
--属性变化
function this:EffAction_AddAttr(effEventData) 
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId); 

    if(targetCharacter ~= nil)then
        
    end
end
--属性变化
function this:EffAction_AddShield(effEventData) 
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId); 
--    DebugLog("加盾====================");
--    DebugLog(effEventData);
    
    if(targetCharacter ~= nil)then
        
    end
end
--拉条
function this:EffAction_AddProgress(effEventData) 
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId); 

    if(targetCharacter ~= nil)then
        
    end
end
--更新时间条
function this:EffAction_UpdateProgress(effEventData) 
    FightClient:SetTimeLineDatas(effEventData.datas);
    EventMgr.Dispatch(EventType.Fight_Time_Line_Update,effEventData.datas);
end
--更新技能
function this:EffAction_UpdateSkill(effEventData) 
    local targetId = effEventData.id;         
    local targetCharacter = CharacterMgr:Get(targetId); 

    if(targetCharacter ~= nil)then
        if(effEventData.attr == "np" or effEventData.attr == "sp")then
            targetCharacter.UpdateSkill(effEventData);
        end
    end
end
--改变技能
function this:EffAction_ChangeSkill(effEventData)    
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId); 

    if(targetCharacter ~= nil)then
        targetCharacter.ChangeSkill(effEventData);
    end    
end

--Buff持续治疗
function this:EffAction_BuffCure(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
    if(targetCharacter ~= nil)then
        targetCharacter.ApplyCureData(effEventData);       
    end
end
--Buff持续伤害
function this:EffAction_BuffDamage(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
    if(targetCharacter ~= nil)then
        local add = effEventData.add;
        if(add and add ~= 0)then
            targetCharacter.ApplyHit(0);
            targetCharacter.ApplyHitData({hpDamage = add,hp = effEventData.hp,death = effEventData.death,isReal = effEventData.isReal});      
            EventMgr.Dispatch(EventType.Fight_Damage_Update,add);
        end
    end
end
--强制死亡
function this:EffAction_ForceDeath(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
    if(targetCharacter ~= nil)then
        targetCharacter.SetDeadState(true);      
    end
end

function this:EffAction_Piaozi(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
    local cfgFloatFont = Cfgs.FloatFont:GetByID(effEventData.floatID);
    if(targetCharacter and cfgFloatFont)then        
        targetCharacter.CreateFloatFont(cfgFloatFont.key);   
    end
end
function this:EffAction_ShowTips(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
    if(targetCharacter)then   
        local content = effEventData.content;
        if(effEventData.id)then
            local cfgFloatFont = Cfgs.FloatFont:GetByID(effEventData.id);
            content = cfgFloatFont.show;
        end
        if(effEventData.type == 1)then
            targetCharacter.CreateFloatFont(nil,nil,nil,content);   
        else     
            EventMgr.Dispatch(EventType.Fight_Trigger_Event_Update,{ character = targetCharacter,desc = content});
        end
    end
end
function this:EffAction_SetInvincible(effEventData)
    EventMgr.Dispatch(EventType.Fight_Activity_SetInvincible,effEventData);
end
function this:EffAction_UpdateDamage(effEventData)
    EventMgr.Dispatch(EventType.Fight_Activity_UpdateDamage,effEventData);
end

function this:EffAction_UpdateFury(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
    if(targetCharacter)then        
        targetCharacter.UpdateFury(effEventData.fury,effEventData.max);
    end
end

--添加装备技能
function this:EffAction_AddOwnerEquipSkill(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
    if(targetCharacter)then        
        --处理装备技能
        targetCharacter.SetEquipSkills(effEventData.equipSkills);
    end
end



function this:EffAction_UpdateValue(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
    if(targetCharacter)then        
        targetCharacter.UpdateFlag(effEventData);
    end
end

function this:EffAction_DelValue(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
    if(targetCharacter)then        
        targetCharacter.DelFlag(effEventData);
    end
end

function this:EffAction_Custom(effEventData)
    local targetId = effEventData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId);
    if(targetCharacter)then        
        if(effEventData.action == "play_ani")then
            local stateName = effEventData.param.name;
            targetCharacter.EnterState(stateName);
--        elseif(effEventData.action == "play_plot")then 
--            local plotId = effEventData.param.id;
--            PlotMgr:TryPlay(plotId,nil,nil,true);
        end
    end
end



--API飘字
local FloatFontAttrKeys = {[APIType.AddAttrPercent] = 1,[APIType.AddAttr] = 1,[APIType.AddProgress] = 1,[APIType.AddXP] = 1};
function this:HandleFloatFont(effData)    
--    LogError("飘字处理");
--    LogError(effData);
    local targetId = effData.targetID;         
    local targetCharacter = CharacterMgr:Get(targetId); 

    if(targetCharacter == nil)then
        return;
    end

    local key = nil;
    
 
    if(effData.abnormalities)then
        key = effData.abnormalities;
    else
        key = effData.api;
        if(FloatFontAttrKeys[key])then
            if(effData.add and effData.add ~= 0)then
                key = key .. "_" ..  effData.attr .. (effData.add > 0 and "_up" or "_down");     
            end 
        end   
    end
    if(key)then
        local value = nil;  
        local floatFontRes = nil;

--        LogError("飘字处理");
--        LogError(effData);
--        LogError(tostring(key))

        if(key == APIType.AddSP)then
            value = effData.add;
            floatFontRes = "Common/FloatFontItem_1";
        elseif(key == APIType.MissBuff and effData.notHit)then
            key = "NotHit";
        end      
        targetCharacter.CreateFloatFont(key,value,floatFontRes);
    end

    --来源飘字
--   eBufferAddType.Spread   = 1 -- 扩散
--   eBufferAddType.Reflect  = 2 -- 反射
--   eBufferAddType.Transfer = 3 -- 转移
    if(effData.addType and effData.id)then        
        local originCharacter = CharacterMgr:Get(effData.id); 
        if(originCharacter)then
            originCharacter.CreateFloatFont( "buff_add_type" .. effData.addType);
        end
    end

end

return this;