--战斗技能

FightActionSkill = oo.class(FightActionBase);
local this = FightActionSkill;

function this:OnPlay()    
--    LogError("技能执行================，id = " .. self.data.id .. "，skill = " .. self.data.skillID);
--    LogError(self.data);
    --CSAPI.DisableInput(1000);    
    --[[ if(self:IsHelp())then
        LogError(string.format("协战触发%s%s",self:GetActorID(),table.tostring(self:GetData())));
    end ]]
    if(self.initSkill)then
        self.initSkill(self.initSkillCaller,self);
        self.initSkill = nil;
        self.initSkillCaller = nil;
    end

    if(self:IsOverLoadSkill())then
        self:PlayOverLoad();
        FuncUtil:Call(self.DelayPlay,self,300);
    else
        FuncUtil:Call(self.DelayPlay,self,10);             
    end
end

--初始化被保护的角色
function this:InitProtectCharacter()
    local protectCharacter = self:GetProtectCharacter();
    if(not protectCharacter)then
        return;
    end
    protectCharacter.SetShowState(true);
    local targetCharacter = self:GetTargetCharacter();
    if(targetCharacter == nil)then
        LogError("触发援护，但没找到被保护的目标，请把下一条数据截出来");
        LogError(self.data);
        return;
    end
    local dir = targetCharacter.GetDir();
    local x,y,z = targetCharacter.GetPos();
    x = x + dir * 2;
    protectCharacter.SetPos(x,y,z);

    EventMgr.Dispatch(EventType.Fight_Trigger_Event_Update,{ character = targetCharacter,protectCharacter = c,typeIndex = 4}); 
end

function this:IsOverLoadSkill()
    return SkillUtil:IsOverloadSkillId(self:GetSkillID());
end

function this:PlayOverLoad()
    local fightAction = FightActionMgr:Apply(FightActionType.OverLoadOn,self:GetData());   
    fightAction.queueType = QUEUE_TYPE.Green;
    FightActionMgr:Push(fightAction);
end

function this:DelayPlay()   
    local character = self:GetActorCharacter();
    if(character == nil)then
        LogError("技能FightAction出错，找不到角色,技能数据如下：");
        LogError(self.data);
        return;
    end

    --指挥官技能
    if(self:IsPlayerSkill())then               
        local cfgSkill = Cfgs.skill:GetByID(self:GetSkillID());
        CameraMgr:ApplyCommonAction(self,TeamUtil:IsEnemyCamp(cfgSkill.target_camp) and CameraActionMgr.sel_enemy_character or CameraActionMgr.sel_my_character);
        --FuncUtil:Call(self.ApplyPlayerSkill,self,500);   
        self:ApplyPlayerSkill();     
        return;
    end

    if(self:IsHelp() == false)then
        FightActionBase.PushSub(self,self:GetFABeforeDeathEvent(),4);
        FightActionBase.PushSub(self,FightActionMgr:Apply(FightActionType.DeadChecker),4);
        --LogError("技能：加死亡检测");
    --else
        --LogError("协战技能：不加死亡检测");
    end

    --处理技能开始前的API
    FightActionUtil:PlayFightActions(self.faPreArr);

    --角色开始执行技能
    character.PlayFightAction(self);    

    self:ShowFightEvent();

    if(not self:IsHelp() and self:GetActorCharacter().IsEnemy())then
        EventMgr.Dispatch(EventType.Fight_Flip,true);
    end
end


function this:ApplyPlayerSkill()
    --处理技能开始前的API
    FightActionUtil:PlayFightActions(self.faPreArr);
    FuncUtil:Call(self.Complete,self,1500);         
end

function this:ShowFightEvent()
    local eventDesc = nil;
    local typeIndex = nil;
    if(self.data.api == APIType.BeatAgain)then
        --eventDesc = StringConstant.fight_beat_again;
        typeIndex = 2;
    elseif(self.data.api == APIType.BeatBack)then
        --eventDesc = StringConstant.fight_beat_back;
        typeIndex = 3;
    elseif(self.data.api == APIType.CallSkill or self.data.api == APIType.Skill)then
        local cfgSkill = Cfgs.skill:GetByID(self:GetSkillID());
        local cfgSkillDesc = Cfgs.CfgSkillDesc:GetByID(cfgSkill.id);
        eventDesc = cfgSkillDesc and cfgSkillDesc.name;
        typeIndex = 5;
    end

    if(typeIndex)then
        EventMgr.Dispatch(EventType.Fight_Trigger_Event_Update,{ character = self:GetActorCharacter(),desc = eventDesc,typeIndex = typeIndex});
    end
end
function this:ApplySkillComplete()
    FightActionMgr:TryStopSkip(); 

    self.skillComplete = 1;
    self:Complete();
end
function this:IsSkillComplete()
    return self.skillComplete;
end
--function this:Complete()       
--    FightActionBase.Complete(self);   

--    if(self.isComplete)then
--       -- LogError("技能完成，重置位置");
--        self:ResetCharacterPlace();
----         LogError("技能完成================，id = " .. self.data.id .. "，skill = " .. self.data.skillID);
----         LogError(self.data);        
--    end 
--end

--恢复角色位置
function this:ResetCharacterPlace()
    if(self.isResetedPlace)then
        return;
    end
    self.isResetedPlace = 1;
    
    if(not self:IsHelp())then
        local allCharacters = self:GetAllCharacters();
        if(allCharacters)then
            for _,character in pairs(allCharacters)do
                if(character ~= nil)then
                    character.ResetPlace();
                end
            end
        end
    end
end

function this:OnComplete()
    self:CheckLeftData();  

    if(self.data["AfterCallSkill"])then
        FightActionUtil:PlayAPIsByOrder(self.data["AfterCallSkill"]);
    end 
end
function this:OnClean()      
        
    --self:CleanFightActionArr(self.faDamageArr);
    self.faDamageArr = nil;
    --self:CleanFightActionArr(self.faCureArr);
    self.faCureArr = nil;
    self.faBuffArr = nil;
    self.faDebuffArr = nil;
    self.faArrCurr = nil;    
    self.faBlockCurr = nil;

    self.enemys = nil;
    self.cures = nil;
    self.buffs = nil;
    self.debuffs = nil;
    self.allCharacters = nil;

    --技能前直接处理的FightAction
    self.faPreArr = nil;
    --技能后处理列表（分三组，我方、敌方、不区分）
    self.faAfts = nil;
    self.faAfts_1 = nil;
    --技能伤害后扣血展示
    self.faHitResult = nil;
    --死亡事件
    self.faBeforeDeathEvent = nil;
    --协战
    if(self.faHelps)then
        --LogError("清理协战数据" .. table.tostring(self.faHelp.data));
        --FightActionMgr:Recycle(self.faHelp);
        --self.tt = nil;
        self:ClearHelps();
    end
    self.faHelp = nil;
    self.faHelpCaller = nil;

    --记录第n次攻击
    self.attackIndexs = nil;

    self.funcsActionTarget = nil;

    --召唤
    self.faSummon = nil;
    --变身
    self.faTransform = nil;
    --合体
    self.faCombo = nil;
    self.isResetedPlace = nil;

    self.feature = nil;
    self.skillComplete = nil;
end

function this:CleanFightActionArr(arr)
    if(arr)then
        for _,fa in pairs(arr)do
            --LogError(fa);
            FightActionMgr:Recycle(fa);
        end
    end
    arr = nil;
end

function this:GetProtectCharacter()
--     --测试保护角色    
--     local characters = CharacterMgr:GetAll();
--     for _,c in pairs(characters)do
--       if(c.IsEnemy() and c.GetID() ~= self:GetTargetCharacter().GetID())then
--           return c;
--       end
--     end

    local protectId = self.data and self.data.protectId;
    if(not protectId)then
        return;
    end

    local protectCharacter = CharacterMgr:Get(self.data.protectId);
    return protectCharacter;
end

--获取目标
function this:GetTargetCharacter()
    if(self.enemys ~= nil)then
        return self.enemys[1];
    end
    return nil;
end


--技能目标
function this:IsSkillTargetFightAction(fightAction)
    if(not fightAction)then
        return false;
    end
    if(not fightAction.IsPlayInSkill or fightAction:IsPlayInSkill() == false)then
        return;
    end

    local fightActionType = fightAction:GetType();

    if(fightActionType == FightActionType.AddBuff or fightActionType == FightActionType.MissBuff )then
        return true;
    end
    if(fightActionType == FightActionType.API)then                   
        return FightActionUtil:IsSkillTargetAPI(fightAction.data);
    end
    
     return false;
end


--添加子FightAction
function this:PushSub(fightAction,order) 
    local fightActionType = fightAction:GetType();

--    if(fightAction.data and fightAction.data.api == APIType.OnResolve)then
--        local data = self:GetData();   
--        if(not data.isShow)then
--            LogError("技能数据开始================================");
--            ShowTable(data);
--            LogError("技能数据结束================================");
--            data.isShow = "已显示";
--        end
--    end

--   LogError("================================");
--   LogError("类型：" .. FightActionTypeDesc[fightActionType] .. "\n" .. table.tostring(fightAction:GetData()));

   if(fightActionType == FightActionType.Damage)then
        --伤害
        self:PushDamage(fightAction);
        fightAction:SetParent(self);
        --LogError("伤害类型");
    elseif(fightActionType == FightActionType.Cure)then
        --治疗
        self:PushCure(fightAction);
        --LogError("治疗类型");
    elseif(fightActionType == FightActionType.Skill and fightAction:IsHelp())then
        --协战
        --LogError(string.format("ID=%s添加ID=%s协战%s",self:GetActorID(),fightAction:GetActorID(),table.tostring(fightAction:GetData())));
        self:AddHelp(fightAction);
    elseif(self:IsPlayAftSkill(fightAction))then
        --延后结算
        local pushVal = self:IsPlayAftSkill(fightAction);   
        --LogError("插入技能后处理，pushVal=" .. tostring(pushVal) ..   "\n" .. table.tostring(fightAction.data));     
        if(pushVal == 1)then
            self:PushAft(fightAction);
        else
            self:PushAftBeforeDeathEvent(fightAction);
        end
    elseif(fightActionType == FightActionType.Summon)then
        --召唤
        --fightAction.data.skillID = self.data.skillID;
        fightAction:SetParent(self);
        self.faSummon = fightAction;
        --FightActionBase.PushSub(self,fightAction);
    elseif(fightActionType == FightActionType.Transform)then
        --变身
        fightAction:SetParent(self);
        self.faTransform = fightAction;        
    elseif(fightActionType == FightActionType.Combo)then
        --合体
        FightActionBase.PushSub(self,fightAction,5);
        fightAction:SetParent(self);
        self.faCombo = fightAction;
    elseif(fightActionType == FightActionType.ComboBreak)then
        --解体
        FightActionBase.PushSub(self,fightAction,20);
        fightAction:SetParent(self);
    elseif(fightActionType == FightActionType.StartPlay)then
        --LogError(fightAction);
    elseif(self:IsSkillTargetFightAction(fightAction))then
        --触发型buff
        --LogError(table.tostring(fightAction:GetData()));
        local targetCharacter = fightAction:GetTargetCharacter();        
        if(targetCharacter == nil)then
            if(fightAction:GetAPIName() ~= APIType.AddNP)then
                LogError("API:AddBuff、UpdateBuff或者MissBuff操作失败，找不到目标角色，api数据如下");
                LogError(fightAction:GetData());
            else
                self:TryPushToTargetArr(fightAction);
            end
            return;
        end


        local targetTeam = targetCharacter.GetTeam();

        local actorCharacter = self:GetActorCharacter();
        local myTeam = actorCharacter and actorCharacter.GetTeam();

--        LogError(fightAction);
--        LogError("目标队伍：" .. tostring(targetTeam));
--        LogError("我的队伍：" .. tostring(myTeam));

        if(myTeam == targetTeam)then
            self:PushBuff(fightAction);
        else
            self:PushDebuff(fightAction);
        end
    else      
        if(self:TryPushToTargetArr(fightAction) == false)then
            if(self.faSummon)then--召唤之后处理
                self:PushAft(fightAction);
            else
                self.faPreArr = self.faPreArr or {};
                table.insert(self.faPreArr,fightAction);
            end
            --LogError("技能释放前处理============");
            --FightActionBase.PushSub(self,fightAction,order);
        else
        end

         --处理特殊API中的协战
         if(fightActionType == FightActionType.APISpecial)then
            local faHelp = fightAction:GetHelp();            
            if(faHelp)then
                self:PushSub(faHelp);
            end
         end
         --技能API
         if(fightActionType == FightActionType.SkillAPI)then
            fightAction:SetParent(self);
            local faHelps = fightAction:GetHelps();
            if(faHelps)then
                for _,faHelp in ipairs(faHelps)do
                    self:PushSub(faHelp);
                end
            end
         end
         --API
         if(fightActionType == FightActionType.API and fightAction:GetAPIName() == APIType.OnDeath)then
            fightAction:SetParent(self);
         end
    end            
end


--添加伤害FightAction
function this:PushDamage(fightAction)
    local id = fightAction:GetActorID();
    self.faDamageArr = self.faDamageArr or {};    
    self.faDamageArr[id] = self.faDamageArr[id] or {};
    table.insert(self.faDamageArr[id],fightAction);

    self.enemys = self.enemys or {};
    self:PushTargetToArr(self.enemys,id);

    self.faArrCurr = self.faDamageArr;
    self.faBlockCurr = self.faDamageArr[id];
    --LogError("切换faDamageArr" .. id)
end
--添加治疗FightAction
function this:PushCure(fightAction)
    local id = fightAction:GetActorID();
    self.faCureArr = self.faCureArr or {};    
    self.faCureArr[id] = self.faCureArr[id] or {};
    table.insert(self.faCureArr[id],fightAction);

    self.cures = self.cures or {};
    self:PushTargetToArr(self.cures,id);

    self.faArrCurr = self.faCureArr;
    self.faBlockCurr = self.faCureArr[id];
    --LogError("切换faCurefArr" .. id)
end
--添加Buff FightAction
function this:PushBuff(fightAction)
    local id = fightAction:GetTargetID();
    self.faBuffArr = self.faBuffArr or {};    
    self.faBuffArr[id] = self.faBuffArr[id] or {};
    table.insert(self.faBuffArr[id],fightAction);

    self.buffs = self.buffs or {};
    self:PushTargetToArr(self.buffs,id);

    self.faArrCurr = self.faBuffArr;
    self.faBlockCurr = self.faBuffArr[id];
    --LogError("切换faBuffArr" .. id)
end
--添加Debuff FightAction
function this:PushDebuff(fightAction)
--    LogError("debuff===");
--    LogError(fightAction);

    local id = fightAction:GetTargetID();
    self.faDebuffArr = self.faDebuffArr or {};    
    self.faDebuffArr[id] = self.faDebuffArr[id] or {};
    table.insert(self.faDebuffArr[id],fightAction);

    self.debuffs = self.debuffs or {};
    self:PushTargetToArr(self.debuffs,id);

    self.faArrCurr = self.faDebuffArr;
    self.faBlockCurr = self.faDebuffArr[id];
    --LogError("切换faDebuffArr" .. id)
end


--尝试添加目标FightAction到对应的列表中（每个目标都有一个伤害和治疗列表）
function this:TryPushToTargetArr(fightAction)
    

    if(self.faArrCurr)then
        local id = fightAction:GetTargetID();

        if(fightAction:GetAPIName() == APIType.OnDeath)then
            id = fightAction:GetActorID();
        end

        --local id = fightAction:GetTargetID();
        if(id and self.faArrCurr[id])then
            table.insert(self.faArrCurr[id],fightAction);
            --LogError("被前面数据阻塞" .. id);
            return true;     
        elseif(self.faBlockCurr)then
            --LogError("被前面数据阻塞（目标不同）");       
            table.insert(self.faBlockCurr,fightAction);
            return true;   
        end
    end
    if(self.faCombo)then
         FightActionBase.PushSub(self,fightAction,5);
         return true;
    end
    return false;
end

--添加目标角色到指定目标列表中
function this:PushTargetToArr(targetArr,id)
    for _,character in ipairs(targetArr)do
        if(character.GetID() == id)then
            return;
        end
    end

    table.insert(targetArr,CharacterMgr:Get(id));
end

--获取所有攻击目标角色
function this:GetTargetCharacters()         
    return self.enemys;
end

--获取所有治疗目标角色
function this:GetCureCharacters()         
    return self.cures;
end
function this:GetCureCharacter()         
    return self.cures and self.cures[1];
end
--获取所有Buff目标角色
function this:GetBuffCharacters()
    return self.buffs;
end
function this:GetBuffCharacter()         
    return self.buffs and self.buffs[1];
end
--获取所有Debuff目标角色
function this:GetDebuffCharacters()
    return self.debuffs;
end
function this:GetDebuffCharacter()         
    return self.debuffs and self.debuffs[1];
end

--获取行为目标
function this:GetActionTarget(posRef)
    if(posRef == nil)then
        return nil;
    end
    if(self.funcsActionTarget == nil)then
        self.funcsActionTarget = {};

        self.funcsActionTarget[FightPosType.Actor] = self.GetActorCharacter;
        self.funcsActionTarget[FightPosType.Between_Actor_And_Target] = self.GetActorCharacter;

        self.funcsActionTarget[FightPosType.Target] = self.GetTargetCharacter;
        self.funcsActionTarget[FightPosType.Target_Front] = self.GetTargetCharacter;      
        self.funcsActionTarget[FightPosType.Target_Part] = self.GetTargetCharacter;        
         self.funcsActionTarget[FightPosType.Enemy_Ground_Front] = self.GetTargetCharacter;
        self.funcsActionTarget[FightPosType.Enemy_Ground_Center] = self.GetTargetCharacter;

        self.funcsActionTarget[FightPosType.CureTarget] = self.GetCureCharacter;
        self.funcsActionTarget[FightPosType.BuffTarget] = self.GetBuffCharacter;
        self.funcsActionTarget[FightPosType.DebuffTarget] = self.GetDebuffCharacter;
    end

    local func = self.funcsActionTarget[posRef.ref_type];
    if(func ~= nil)then
        return func(self);
    end

    return nil;
end

function this:GetSelGridData()
   local selGridData = self.data.grid;
   --LogError(self.data);
   if(selGridData)then
        return selGridData.row,selGridData.col;
    else
        LogError("技能数据中没有输入位置信息，可能导致位置错乱");
        LogError(self.data);

        return 1,1;
   end
end

--获取全部相关角色
function this:GetAllCharacters()
    if(self.allCharacters == nil)then
        self.allCharacters = {};
        local actorID = self:GetActorID();
        if(actorID)then
            self.allCharacters[actorID] = self:GetActorCharacter();          
        end

        self:PushCharactersToTargetArr(self:GetTargetCharacters(),self.allCharacters);
        self:PushCharactersToTargetArr(self:GetCureCharacters(),self.allCharacters);
        self:PushCharactersToTargetArr(self:GetBuffCharacters(),self.allCharacters);
        self:PushCharactersToTargetArr(self:GetDebuffCharacters(),self.allCharacters);

        --被保护者
        local protectCharacter = self:GetProtectCharacter();
        if(protectCharacter)then
            self.allCharacters[protectCharacter.GetID()] = protectCharacter;
        end
    end

    return self.allCharacters;
end

function this:PushCharactersToTargetArr(fromArr,toArr)
    if(fromArr)then
        for _,character in ipairs(fromArr)do
            local id = character.GetID();
            if(toArr[id] == nil)then
                toArr[id] = character;
            end
        end
    end
end

--开始处理
--function this:ApplyStart()
--    FightActionUtil:PlayFightActions(self.faPreArr);
--end

function this:IsAttackValid(characterId)
    local attackIndex = (self.attackIndexs and self.attackIndexs[characterId] or 0) + 1;
    local arr = self.faDamageArr and self.faDamageArr[characterId];
    if(not arr or #arr <= 0)then
        return false;
    end    
  
    local faDamag = arr[1];
    return faDamag:IsAttackValid(attackIndex);
end

--申请对目标角色应用一次伤害
function this:ApplyHitData(characterId,isFake,workDelay)
    if(characterId == nil)then
        LogError("技能FightAction：获取伤害数据失败，角色id无效！！！");
    end
    
    if(self.faDamageArr == nil or self.faDamageArr[characterId] == nil)then
        --不存在对目标的伤害数据        
        return false;
    end
    
    local arr = self.faDamageArr[characterId];
    if(#arr <= 0)then
        return false;
    end
    
    self.attackIndexs = self.attackIndexs or {};
    self.attackIndexs[characterId] = self.attackIndexs[characterId] or 0;

    if(not isFake)then
        self.attackIndexs[characterId] = self.attackIndexs[characterId] + 1;
    end
    local faDamag = arr[1];
   

   local attackIndex = self.attackIndexs[characterId];
   local isAttackValid = faDamag:IsAttackValid(attackIndex);

   local applyState = faDamag:Apply(attackIndex,isFake,workDelay);
    if(applyState)then
        if(not isFake)then
            table.remove(arr,1);
            faDamag:Complete();
            self:HandlerBlockFightAction(arr);            
        end    
    end
    return isAttackValid,applyState;
end
--申请对目标角色应用一次治疗
function this:ApplyCureData(characterId)
    if(characterId == nil)then
        LogError("技能FightAction：获取治疗数据失败，角色id无效！！！");
    end
    
    if(self.faCureArr == nil or self.faCureArr[characterId] == nil)then
        --不存在对目标的Buff数据        
        return false;
    end
    
    local arr = self.faCureArr[characterId];
    if(#arr <= 0)then
        return false;
    end

    local faCure = arr[1];
     
    if(faCure:Apply())then
        table.remove(arr,1);
        faCure:Complete();
        self:HandlerBlockFightAction(arr);
    end
    return true;
end

--申请对目标应用Buff
function this:ApplyBuffData(characterId,delay)
    if(characterId == nil)then
        LogError("技能FightAction：获取Buff数据失败，角色id无效！！！");
    end
    
    if(self.faBuffArr == nil or self.faBuffArr[characterId] == nil)then
        --不存在对目标的Buff数据        
        return false;
    end
    
    local arr = self.faBuffArr[characterId];
    if(#arr <= 0)then
        return false;
    end

     local faBuff = arr[1];
     table.remove(arr,1);
     faBuff.queueType = QUEUE_TYPE.Green;   
     --FightActionMgr:Push(faBuff);
     self:ApplyImpactFightAction(faBuff,delay)

     self:HandlerBlockFightAction(arr);
end

function this:ApplyImpactFightAction(fa,delay)
    if(delay)then        
        FuncUtil:Call(FightActionMgr.Push,FightActionMgr,delay,fa);
    else
        FightActionMgr:Push(fa);
    end
    
end

--申请对目标应用Debuff
function this:ApplyDebuffData(characterId)
    if(characterId == nil)then
        LogError("技能FightAction：获取Debuff数据失败，角色id无效！！！");
    end
    
    if(self.faDebuffArr == nil or self.faDebuffArr[characterId] == nil)then
        --不存在对目标的Deuff数据        
        return false;
    end
    
    local arr = self.faDebuffArr[characterId];
    if(#arr <= 0)then
        return false;
    end

     local faDebuff = arr[1];
     table.remove(arr,1);
     faDebuff.queueType = QUEUE_TYPE.Green;   
     --FightActionMgr:Push(faDebuff);
     self:ApplyImpactFightAction(faDebuff,delay)

     self:HandlerBlockFightAction(arr);
end


--获取伤害数据
function this:GetDamageDatas()
    return self.faDamageArr;
end

--处理目标列表的后续API
function this:HandlerBlockFightAction(arr)
    if(arr == nil or #arr <= 0)then
        return;
    end

    local list = nil;
    local count = #arr;
    for i = 1,count do        
        if(#arr == 0)then
            break;
        end

        if(self:IsBlockFightAction(arr[1]))then
            break;
        else
            list = list or {};
            local fa = table.remove(arr,1);
            table.insert(list,fa);
--            LogError("==============================");
--            LogError("处理类型：" .. FightActionTypeDesc[fa:GetType()] .. "\n" .. table.tostring(fa:GetData()));
        end
    end
    
    if(list)then      
        FightActionUtil:PlayFightActions(list);
    end
end

--是否阻塞型FightAction（伤害、治疗）
function this:IsBlockFightAction(fightAction)
    local type = fightAction:GetType();

--    LogError("FightActionType：" .. tostring(type));
--    LogError(fightAction:GetData());

    if(type == FightActionType.Damage or type == FightActionType.Cure)then
        return true;
    end
    --if((type == FightActionType.AddBuff or type == FightActionType.MissBuff) and fightAction:IsPlayInSkill())then
    if(fightAction.IsPlayInSkill and fightAction:IsPlayInSkill())then
        return true;
    end

    return false;
end

--获取技能ID
function this:GetSkillID()
    return self.data.skillID;    
end


---------------------------------------------------协战
--设置协助
function this:AddHelp(fightAction)
    if(fightAction)then
        fightAction:SetHelpCaller(self);
        self.faHelps = self.faHelps or {};
        table.insert(self.faHelps,fightAction); 
    end
end
--获取协助FightAction
function this:GetHelps()
    return self.faHelps;
end
function this:ClearHelps()
    self.faHelps = nil;
end
--设置协助发起者
function this:SetHelpCaller(callerFightAction)
    self.faHelpCaller = callerFightAction;
end
--获取协助发起者FightAction
function this:GetHelpCaller()
    return self.faHelpCaller;
end
--是否协助技能
function this:IsHelp()
    return self.data and self.data.api == APIType.OnHelp;    
end

--是否指挥官技能
function this:IsPlayerSkill()
    return self.data and self.data.playerSkill;    
end

function this:PlayAPIs(apiDatas,ignoreDelay)

    local arr = nil;
--    LogError("====================");
--    LogError(apiDatas);
    if(apiDatas)then
        for _,apiData in ipairs(apiDatas)do
            local apiSetting = nil;
            local apiId = apiData and apiData.effectID;
            if(apiId)then
                apiSetting = Cfgs.APISetting:GetByID(apiId);
            end
            if(not self:IsSkillComplete() and not ignoreDelay and apiSetting and apiSetting.play_aft_skill)then
                --LogError("延后处理：" .. table.tostring(apiData));
                local fa = FightActionUtil:HandleAPIData(apiData);
                if(fa)then
                    self:PushSub(fa);
                end
            elseif(apiData.api == APIType.Revive)then
                local fa = FightActionUtil:HandleAPIData(apiData);            
                if(fa)then
                    --self:PushAft(fa);
                    FightActionBase.PushSub(self,fa,6);
                end
            else              
                arr = arr or {};
                table.insert(arr,apiData);
            end
        end
    end

    if(arr)then
        FightActionUtil:PlayAPIsByOrder(arr);
    end
end

--是否在技能结束后处理
function this:IsPlayAftSkill(fightAction)  
    local apiSetting = fightAction:GetAPISetting();
    return apiSetting and apiSetting.play_aft_skill;
end
--添加到技能完成后处理（死亡事件后）
function this:PushAft(fightAction)
    --协战者事件插入到协战触发者事件中
    local helpCallerFightAction = self:GetHelpCaller();
    if(helpCallerFightAction)then
        helpCallerFightAction:PushAft(fightAction);
        return;
    end

    local teamId = 0;
    local targetCharacter = fightAction:GetTargetCharacter();
    if(targetCharacter)then
        teamId = targetCharacter.GetTeam();
    end

    self.faAfts = self.faAfts or {};
    local faAft = self.faAfts[teamId];
    if(faAft == nil)then
        local targetId = fightAction:GetTargetID();
        faAft = FightActionMgr:Apply(FightActionType.TeamEvent,{id = targetId});
        FightActionBase.PushSub(self,faAft,10);
        self.faAfts[teamId] = faAft;
    end   
    --LogError("技能结束后处理================================\n" .. table.tostring(fightAction.data));
    faAft:PushSub(fightAction);
end

function this:GetFABeforeDeathEvent()
     self.faBeforeDeathEvent = self.faBeforeDeathEvent or FightActionMgr:Apply(FightActionType.TeamEvent);
     return self.faBeforeDeathEvent;
end

function this:PushAftBeforeDeathEvent(fightAction)
    --协战者事件插入到协战触发者事件中
    local helpCallerFightAction = self:GetHelpCaller();
    if(helpCallerFightAction)then
        helpCallerFightAction:PushAftBeforeDeathEvent(fightAction);
        return;
    end


--    local teamId = 0;
--    local targetCharacter = fightAction:GetTargetCharacter();
--    if(targetCharacter)then
--        teamId = targetCharacter.GetTeam();
--    end

    local faAft = self:GetFABeforeDeathEvent();

--    self.faAfts_1 = self.faAfts_1 or {};
--    local faAft =  self.faAfts_1[teamId];    
--    if(faAft == nil)then
--        local targetId = fightAction:GetTargetID();
--        faAft = FightActionMgr:Apply(FightActionType.TeamEvent,{id = targetId});
--        FightActionBase.PushSub(self,faAft,3);
--        self.faAfts_1[teamId] = faAft;
--    end   
--    LogError("技能结束后处理================================");
--    LogError(fightAction.data);
    faAft:PushSub(fightAction);
end

--插入延迟结算
function this:PushHitResult(characterId)
     --协战者事件插入到协战触发者事件中
    local helpCallerFightAction = self:GetHelpCaller();
    if(helpCallerFightAction)then
        helpCallerFightAction:PushHitResult(characterId);
        return;
    end

    if(self.faHitResult == nil)then
        --检测是否取消延迟结算
--        if(self.skillId ~= nil)then
--            local cfgSkill = Cfgs.skill:GetByID(self.skillId);
--            if(cfgSkill ~= nil and cfgSkill.immediately_result)then
--                return;
--            end
--        end        

        local targetFightAction = FightActionMgr:Apply(FightActionType.HitResult,{ id = characterId });       
        FightActionBase.PushSub(self,targetFightAction,-1);
        self.faHitResult = targetFightAction;
    end
end


function this:GetCustomPlayTime()
    if(self.faSummon)then
        return self.faSummon:GetCustomPlayTime();
    end
end

--播放召唤
function this:PlaySummon()
    if(self.faSummon)then
        self.faSummon.queueType = QUEUE_TYPE.Green;   
        FightActionMgr:Push(self.faSummon);
    end
end
--播放变身
function this:PlayTransform()
    if(self.faTransform)then
        self.faTransform.queueType = QUEUE_TYPE.Green;   
        FightActionMgr:Push(self.faTransform);
    end
end

--检查遗漏数据
function this:CheckLeftData()
    local allCharacter = CharacterMgr:GetAll();
    
    if(allCharacter ~= nil)then
        for id,character in pairs(allCharacter)do
            local count = 0;
            for i = 1,100 do
                local isAttackIndexMatch,attackState = self:ApplyHitData(id);                
                if(isAttackIndexMatch)then
                    --LogError("有伤害遗漏=============================");                
                    count = count + 1;
                else
                    if(count > 0)then
                        LogError(string.format("对目标%s漏结算%s段伤害,%s",id,count,table.tostring(self:GetData())));
                    end
                    break;
                end
            end
            if(self:ApplyBuffData(id))then
                LogError("有Buff遗漏=============================");                
            end
            if(self:ApplyDebuffData(id))then
                LogWarning("有Debuff遗漏=============================");                
            end
        end        
    end
end


--计算位置
function this:Calculate(posData,targetCharacter)  
    local actionCharacter = self:GetActorCharacter();
    targetCharacter = targetCharacter or self:GetActionTarget(posData);   
    local x,y,z = FightPosRefUtil:Calculate(posData,actionCharacter,targetCharacter,self);    
    --LogError("x:" .. tostring(x) .. ",y:" .. tostring(y) .. "z:" .. tostring(z));
    return x,y,z;
end

--是否有伤害
function this:HasDamage()
    return self.faDamageArr ~= nil;
end

function this:GetDamageTargetByIndex(index)
    local damageDatas = self:GetDamageDatas();
    if(damageDatas == nil)then
        return;
    end

    local targets;
    local str = "";
    for _,faArr in pairs(damageDatas)do
        for _,faDamage in ipairs(faArr)do           
            if(faDamage:GetType() == FightActionType.Damage)then
                local startIndex = faDamage:GetStartIndex();
                local count = faDamage:GetDamageCount();

                if(startIndex <= index and startIndex + count > index)then
                    local targetCharacter = faDamage:GetActorCharacter();
                    targets = targets or {};
                    table.insert(targets,targetCharacter);
                    str = str .. "   " .. targetCharacter.GetID();
                end
            end            
        end
    end
    --LogError("第" .. index .. "次目标：" .. str);
    return targets;
end


--获取镜头增高
function this:GetCameraAddHeight(posRef)
    local character = self:GetActionTarget(posRef);
    if(character)then       
        return character.GetCameraAddHeight();
    end
    return 0;
end

function this:SetFeature()
    self.feature = 1;
end

return this;