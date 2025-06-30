if ReduceHpData == nil then
    ReduceHpData = DataClass("ReduceHpData", {
        Hp = 0,
        DamageType = nil,
    
        __init = function(self, hp, damageType)
            self.Hp = hp or 0
            self.DamageType = damageType
        end
    })
end

if DamageData == nil then
    DamageData = DataClass("DamageData", {
        Damage = 0,
        DamageType = nil,
        IsCri = false,
        IsPry = false,
        HasSecKill = false,
    
        __init = function(self, damage, damageType, isCri, isPry, hasSecKill)
            self.Damage = damage or 0
            self.DamageType = damageType
            self.IsCri = isCri or false
            self.IsPry = isPry or false
            self.HasSecKill = hasSecKill or false
        end,

    })
    function DamageData.CreateFromActiveSkillResult(activeSkillResult)
        return DamageData.New(activeSkillResult.FinalDamage, activeSkillResult.FeixiaoDamage.Type, 
                activeSkillResult.IsCri, activeSkillResult.IsPry, activeSkillResult.HasSecKill)
    end
end