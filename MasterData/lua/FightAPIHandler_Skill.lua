--local skillEventKeys = {"PreSkill","DoSkill","AftSkill"};


local this = {};

--处理技能
function this:Handle(data)
--    DebugLog("====================================================","ffff00");
--    DebugLog("处理技能数据","ffff00");
--    DebugLog(data,"ff9977");
--    if(_G.TT)then
--        ShowTable(data);
--        LogError("****************************************");
--    end

    local subDatas = self:Resolve(data);
--    LogError(data);
--    if(subDatas)then
--        LogError(subDatas);
--    end
--    LogError("==============================");
--     if(_G.TT)then        
--        ShowTable(data);
--        LogError("****************************************");
--        ShowTable(subDatas);
--        _G.TT = nil;
--    end
    self:FixData(data);

    local fightAction = FightActionMgr:Apply(FightActionType.Skill,data);
   
--    FightActionUtil:HanderSubFightAction(fightAction,data.DoSkill);
--    self:FixDamageDatas(fightAction);
    if(fightAction)then
        fightAction.initSkill = self.InitSkill;
        fightAction.initSkillCaller = self;
    end

    if(data.api == APIType.OnHelp or data.api == APIType.Help)then
        return fightAction,subDatas;
    else
        FightActionMgr:Push(fightAction);
        if(subDatas)then
            FightActionUtil:PushServerDatas(subDatas);
        end
    end
--    FightActionMgr:Push(fightAction);
--    if(subDatas)then
--        FightActionUtil:PushServerDatas(subDatas);
--    end
    --return fightAction;
end

function this:Resolve(data)
    if(not data)then
        return;
    end
    local subDatas;
    local datas = data.DoSkill or data.datas or data.OnDeath or data.OnCreate;
    if(datas)then
        for k,v in ipairs(datas)do        
            if(type(v)=="table") then
                if(FightActionUtil:IsSubSkill(v))then
                    --内嵌的技能调用，拆开
                    subDatas = subDatas or {};                                         
                end

                if(subDatas)then
                    --协战、解体不能独立拆开
                    if(v.api ~= APIType.OnHelp and v.api ~= APIType.Help)then
                        table.insert(subDatas,v);   
                        datas[k] = {};
                    end
                end

                local tmpSubDatas = self:Resolve(v);
                if(tmpSubDatas)then
                    for _,tmpSubData in ipairs(tmpSubDatas)do
                        subDatas = subDatas or {};   
                        table.insert(subDatas,tmpSubData);
                    end
                end
            end
        end
    end
    return subDatas;
end

function this:InitSkill(fightAction)
    FightActionUtil:HanderSubFightAction(fightAction,fightAction:GetData().DoSkill);
    self:FixDamageDatas(fightAction);
end


--战术指挥官数据调整
function this:FixData(data)
    if(CharacterMgr:IsSpecialId(data.id))then
        data.playerSkill = 1;
        local teamId = TeamUtil:ToClient(data.id);
        local characters = CharacterMgr:GetAll();
        if(characters)then
            for id,character in pairs(characters)do
                if(character.GetTeam() == teamId)then
                    data.id = id;
                    break;
                end
            end
        end
    end
end

function this:FixDamageDatas(fightAction)
    if(fightAction == nil)then
        return;
    end

    local damageDatas = fightAction:GetDamageDatas();

    if(damageDatas == nil)then
        return;
    end

    local orderNums = {};
    
    for _,faArr in pairs(damageDatas)do
        local nums = {};
        for _,faDamage in ipairs(faArr)do           
            if(faDamage:GetType() == FightActionType.Damage)then
                local order = faDamage:GetDamageOrder();
                nums[order] = nums[order] or faDamage:GetDamageCount();
                --nums[order] = nums[order] + 1;
            end            
        end
        --LogError(nums);
        for orderIndex,num in pairs(nums)do
            if(orderNums[orderIndex])then
               orderNums[orderIndex] = math.max(orderNums[orderIndex],num); 
            else
                orderNums[orderIndex] = num;
            end
        end
    end
   
    local orderStartIndexs = {};
    if(orderNums)then
        for orderIndex,_ in pairs(orderNums)do
            local count = 0;
            for tmpIndex,tmpNum in pairs(orderNums)do
                if(tmpIndex < orderIndex)then
                    count = count + tmpNum;
                end
            end

            orderStartIndexs[orderIndex] = count + 1;
        end
    end
    --LogError(orderNums);
    --LogError(orderStartIndexs);
    --fightAction:SetDamageStartIndexs(orderStartIndexs);
    
    
    for _,faArr in pairs(damageDatas)do       
       
        for id,faDamage in ipairs(faArr)do                  
            if(faDamage:GetType() == FightActionType.Damage)then
                local damageOrder = faDamage:GetDamageOrder();                  
                local damageStartIndex = orderStartIndexs[damageOrder];
                faDamage:SetStartIndex(damageStartIndex);
            end
        end
    end


end

return this;