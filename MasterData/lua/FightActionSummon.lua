--召唤角色
FightActionSummon = oo.class(FightActionBase);
local this = FightActionSummon;


--设置父FightAction
function this:SetParent(fightAction)
    self.fightAction = fightAction;
    FightActionBase.SetParent(self,fightAction);
    self.master = fightAction:GetActorCharacter();
end

function this:SetData(fightActionData)
    FightActionBase.SetData(self,fightActionData);
    self:Preload(fightActionData.datas);

    if(fightActionData.datas)then
        for _,data in pairs(fightActionData.datas)do
            local modelId = data.characterData.model;
            local cfgModel = Cfgs.character:GetByID(modelId);
            if(cfgModel and cfgModel.robotBgm_enter)then
                local skipSettingVal = SettingMgr:GetValue(s_fight_action_key);
                if(skipSettingVal == SettingFightActionType.Close)then
                    CSAPI.PlayBGM(cfgModel.robotBgm, 1000);
                else
                    CSAPI.PlayBGM(cfgModel.robotBgm_enter, 1000);
                    if(cfgModel.robotBgm_enter_time)then
                        FuncUtil:Call(CSAPI.PlayBGM,nil,cfgModel.robotBgm_enter_time,cfgModel.robotBgm,1000);
                    end
                end                
            end
        end
    end
end
--预加载角色
function this:Preload(datas)   
    CharacterMgr:PreloadCharacters(datas,self.OnPreloadCallBack,self)
end
--预加载完成回调
function this:OnPreloadCallBack()
    self.isPreloaded = 1;
    self:ApplyCreate();
end

function this:OnPlay()   
    --LogError("@@@@@@@@@@@@@@@@@@@@@@@@@@@@"); 
    --LogError(self.data); 
    self.isPlayed = 1;
    self:ApplyCreate();


    if(not self:IsSkip())then
        EventMgr.Dispatch(EventType.Character_FightInfo_Show,false); 
        EventMgr.Dispatch(EventType.Scene_Mask_Changed,true);
    end
end

function this:ReplaceSummonCastState()
    local replaceCastStates = self:GetReplaceCastStates();--替换机神技能状态 
    if(self.summons)then
        for _,character in ipairs(self.summons)do         
            if(replaceCastStates)then                
                local oldCastState = replaceCastStates[1];
                local newCastState = replaceCastStates[2];

                if(oldCastState and newCastState)then
                    character.SetReplaceCastState(oldCastState,newCastState);
                end
            end
        end
    end
end

function this:OnClean()
    self.isSummonShow = nil;
    self.isSummonCreated = nil;
    self.isPreloaded = nil;
    self.isPlayed = nil;


    if(self.summons)then
        for _,character in ipairs(self.summons)do
            character.SetSummonState(false);
            character.SetOverTurn(false);
        end
    end
    if(self.master)then
        self.master.SetOverTurn(false);
    end

    self.summons = nil;
    self.master = nil;

    EventMgr.Dispatch(EventType.Scene_Mask_Changed,false);
end

function this:GetReplaceCastStates()
    local cfgModel = self.master and self.master.GetCfgModel();
    --LogError(cfgModel);
    return cfgModel and cfgModel.replace_state;    
end

function this:IsSkip()
    local character = self:GetActorCharacter();

    return character and character.IsSkipSkill();
end

--移除机神
function this:TryRemoveSummons()
    local summoner = self:GetActorCharacter();
    local target = FightGroundMgr:GetSummonCharacter(summoner.GetTeam());
    if(target)then
        target.PutOut(); 
        target.Remove();
    end
end

function this:ApplyCreate()
    if(not self.isPreloaded or not self.isPlayed)then
        return;
    end
    
    --self:TryRemoveSummons();
    self.summons = CharacterMgr:CreateCharacters(self.data.datas);  
    self:ReplaceSummonCastState();
    self.isSummonCreated = 1;

    if(self:IsSkip())then
        self:ShowSummonCharacter();
        return;
    end
    local aniName,aniSound = self:GetEnterAni();    
    if(aniName)then
        local enterAniPlayDelay = self:GetEnterAniPlayDelay();
        FuncUtil:Call(self.PlayEnterAni,self,enterAniPlayDelay or 0);
        --self:PlayEnterAni();
    else
        self:SetSummonsShowState(false);
        self:MasterShow();
        --self:ApplySummonShow();  
    end
      
end

function this:PlayEnterAni()
    local aniName,aniSound = self:GetEnterAni();      
    if(aniName and not FightActionMgr:IsSkiping())then
        local summonAni = ResUtil:PlayVideo(aniName); 
        if(aniSound)then
            CSAPI.PlaySound("fight/effect/" .. aniSound .. ".acb",aniSound);
        end  
        summonAni:AddCompleteEvent(function()           
            --EventMgr.Dispatch(EventType.Fight_Mask); 
            --FuncUtil:Call(self.OnVideoComplete,self,250);
            self:OnVideoComplete();
        end); 
        --return;
    end     
end

function this:OnVideoComplete()
    self:ShowSummonCharacter();
end

function this:GetEnterAniPlayDelay()
    local cfgSkill = Cfgs.skill:GetByID(self.fightAction and self.fightAction:GetSkillID()); 

    local summonCast = cfgSkill and cfgSkill.cast or "summon";
    local masterSummonData = self.master.GetCastStateData(summonCast); 
    local delay = masterSummonData and masterSummonData.enter_ani_delay or 0;
    return delay;
end

--- 机身自带入场视频，写在这里
function this:GetCustomPlayTime()
    local enterAniName,enterSound,enterTime = self:GetEnterAni();
    if(enterAniName)then
        local enterAniPlayDelay = self:GetEnterAniPlayDelay() or 0;
        return enterAniPlayDelay + (enterTime or 7000);--enterAniTimes[enterAniName];
    end

end

function this:GetEnterAni()
    local summonDatas = self.data and self.data.datas;
    if(not summonDatas)then
        return;
    end

    for _,summonData in ipairs(summonDatas)do
        local cfgModel = Cfgs.character:GetByID(summonData.characterData and summonData.characterData.model or 0);
        --LogError(summonData);
        local enterAniName = cfgModel and cfgModel.enter_ani;
        --LogError(cfgModel);
        --enterAniName = "summon_enter_80240"
        if(enterAniName)then
            return enterAniName,cfgModel.enter_sound,cfgModel.enter_time;
        end        
    end

    --return "summon_enter_80240";
end
    
function this:ShowSummonCharacter()   
    CharacterMgr:SetAllShowState(true);    
    FightActionMgr:TryStopSkip(); 
    EventMgr.Dispatch(EventType.Character_HeadInfo_Scale_State,true);      
    --EventMgr.Dispatch(EventType.Fight_Mask); 
end

function this:MasterShow()
    if(self.master == nil)then
       LogError("召唤失败！！！召唤师不见了！！！"); 
    end

    self.master.SetOverTurn(true);

    local cfgSkill = Cfgs.skill:GetByID(self.fightAction and self.fightAction:GetSkillID()); 

    local summonCast = cfgSkill and cfgSkill.cast or "summon";
    local masterSummonData = self.master.GetCastStateData(summonCast);  
    if(not masterSummonData)then
        LogError(self.master.GetModelName() .. " has not " .. tostring(summonCast) .. " data");
    end
    --召唤师施法
    self.master.ApplyCast(summonCast);
    --LogError(CSAPI.GetTime() .. ":" .. tostring(summonCast));
    self.master.ApplyCastPreFB(summonCast);  
    
    
    local delay = masterSummonData.summon_delay or 0;
    if(delay >= 0)then
        FuncUtil:Call(self.SummonEnter,self,delay);
    end

    local aniName,aniSound = self:GetEnterAni();
    local playTime = masterSummonData.play_time or 0;
    if(playTime >= 0 and StringUtil:IsEmpty(aniName))then
        local maskDelayTime = 80;--大招场景遮罩延迟时间
        FuncUtil:Call(self.Complete,self,playTime + maskDelayTime);
    end
end

function this:SetSummonsShowState(isShow)
    if(not self.summons)then
        return;
    end
    for _,character in ipairs(self.summons)do
        character.SetOverTurn(true);
        character.SetShowState(isShow);
    end
end
--召唤者进场
function this:SummonEnter()    
    self.isSummonShow = 1;
    --self.master.SetShowState(false);
    self:ApplySummonShow();

    EventMgr.Dispatch(EventType.Character_FightInfo_Show,false); 
end

function this:ApplySummonShow()
    if(self.isSummonShow and self.isSummonCreated)then        
        self:SummonShow();
    end
end

function this:SummonShow()
    local x,y,z = self.master.GetPos();

    self:SetSummonsShowState(true);
    for _,character in ipairs(self.summons)do
        character.ApplyCast("summon_enter");
        character.SetSummonState(true);
        character.ApplySummon();

        character.SetPos(x,y,z);
    end
end

return this;