--战斗伤害
     
--伤害事件
local DamageEvent =
{
    "OnAttack",
    "OnCrit",
    "OnAfterHurt",
    "OnDeath"
}


FightActionDamage = oo.class(FightActionBase);
local this = FightActionDamage;


function this:OnClean()
    --LogError("清理回收damage fight action");
    self.startIndex = nil;
end

--获取伤害顺序号
function this:GetDamageOrder()
    return self.data.order;
end
--获取伤害段数
function this:GetDamageCount()
    return self.data and self.data.datas and #self.data.datas or 0;
end
--设置伤害开始索引（第n次攻击后开始生效）
function this:SetStartIndex(startIndex)
    self.startIndex = startIndex;
end
function this:GetStartIndex()
    return self.startIndex;
end

function this:IsAttackValid(attackIndex)
    if(self.startIndex and attackIndex < self.startIndex)then
        --未满足攻击次数限制    
        return false;
    end
    return true;
end

--attackIndex：攻击次数
function this:Apply(attackIndex,isFake,workDelay)   
    --攻击次数检测       
    if(not self:IsAttackValid(attackIndex))then
        --未满足攻击次数限制
        --LogError("未满足攻击次数限制" .. attackIndex);
        --LogError(self);
        return false;
    end

    if(isFake)then
        return true;
    end


    local damageDatas = self.data.datas;
    if(damageDatas == nil or #damageDatas == 0)then
        LogError("伤害数据为空");
        return true;
    end
    local applyState = true;
    for index,damageData in ipairs(damageDatas)do
        if(damageData.isApplyed == nil)then
            damageData.isApplyed = 1;
            damageData.type = self.data.type;
            
            local character = self:GetActorCharacter();

            --伤害前数据
            local befourHurtData = damageData["OnBefourHurt"];
            if(befourHurtData)then
                self.faParent:PlayAPIs(befourHurtData);
            end

            if(character)then
                damageData.death = self:IsDead();
                
                if(workDelay)then
                    FuncUtil:Call(self.ApplyHitData,self,workDelay,character,damageData);
                else
                    self:ApplyHitData(character,damageData);
                end
                
            end

            for _,damageEvent in ipairs(DamageEvent)do
                self.faParent:PlayAPIs(damageData[damageEvent]);
                --FightActionUtil:PlayAPIsByOrder(damageData[damageEvent]);
            end

            if(index < #damageDatas)then
                applyState = false;
            end
            break;
        end
    end

    if(applyState)then
        local deathData = self.data and self.data["OnDeath"];
        if(deathData and not deathData.isApplyed)then      
            deathData.isApplyed = 1;      
            self.faParent:PlayAPIs(deathData);
            --FightActionUtil:PlayAPIsByOrder(deathData);
        end
    end

    return applyState;
end

function this:ApplyHitData(character,damageData)   
    character.ApplyHitData(damageData);     
    EventMgr.Dispatch(EventType.Fight_Damage_Update,(damageData.hpDamage or 0) + (damageData.shieldDamage or 0));
end


return this;
