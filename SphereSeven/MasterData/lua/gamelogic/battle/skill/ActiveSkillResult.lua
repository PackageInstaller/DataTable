---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/4/18 21:52
---
local ActiveSkillResult = {
    MultistageNum = 1, -- 攻击段数
    
    Damages = {},
    FeixiaoDamage = {
        Type = nil,
        Value = 0,
    },
    FeixiaoDispel = {
        Type = nil,
        Count = 0
    },
    FeixiaoIncBuffTurn = {
        Type = nil,
        Id = 0,
        Turn = 0,
    },
    FeixiaoLifeSteal = {
        Value = 0,
    },

    ActChange = 0, -- 速攻值变化

    Buffs = {},
    RemoveBuffs = {},
    IsRevive = false,--复活
    HealHp = 0,--大于0表示加血技能，数值为基础加血量
    ReduceHp = 0, --自残
    
    IsSuckHp = false,--吸血效果
    IsSecKill = false,--即死效果，秒杀
    IsDispel = false,--驱散效果
    IsPurify = false,--净除效果
    IsIgnoreDef = false,--破甲效果，无视防御
    IsIgnoreShield = false,--贯通效果，无视防护罩
    IsDevastate = false,--毁灭效果
    IsDemoralize = false,--挫志效果
    IsUnableCac = false,--无法反击
    IsMustCri = false,--会心效果，必定暴击
    IsSuoLife = false, --索命效果,对下次行动的敌人普通攻击
    IsMustHit = false, --锁定效果 必定命中（无视直觉效果）
    
    ------------------------------------
    CanHurtByGAtk = true, -- 普通攻击有效
    CanHurtBySkill = true, -- 技能有效
    IsPry = false, -- 闪避了
    IsCri = false, -- 暴击了
    HasIgnoreDef = false, -- 无视防御了
    HasIgnoreShield = false, -- 无视防护罩了
    IsFinalHit = false, -- 绝杀了
    IsFrenzy = false, -- 狂怒了
    IsBlock = false, -- 格挡了
    HasSecKill = false, -- 秒杀了
    FinalDamage = 0, -- 最终的伤害(单次)
    TotalDamage = 0, -- 总伤害
    SuckHp = 0, -- 吸血了
    SuckHpScale = 0,
    ReflectHp = 0, -- 反伤了
    HasDemoralize = false, -- 挫志了
    HasDamage = true, -- 伤害有效

    ExtraAtkPct = 0, -- 额外攻击
    ExtraDamage = 0,
    ExtraFinalDamagePct = 0, -- 额外最终伤害
    ExtraCri = 0, -- 额外暴击率
    ExtraCriDamage = 0, -- 额外暴击伤害
    ExtraDefPct = 0, -- 额外防御
    ExtraMagicDefPct = 0, -- 额外魔防
    ExtraEAcc = 0, -- 额外效果命中
    ExtraIgnoreDef = 0, -- 无视防御系数
    ExtraIgnoreMagicDef = 0, -- 无视魔法防御系数

    HitScale = 1,
    CriScale = 1,
    UltimateScale = 1,

    RealHpDamages = {}, -- 真正扣除的血量(每一击都记录), AfterAllHurt, AfterOneTargetAllHit, OnAtk事件以及之后有效
    TotalRealHpDamage = 0, -- 真正扣除的总血量, AfterAllHurt, AfterOneTargetAllHit, OnAtk事件以及之后有效
}

return DataClass("ActiveSkillResult",ActiveSkillResult)