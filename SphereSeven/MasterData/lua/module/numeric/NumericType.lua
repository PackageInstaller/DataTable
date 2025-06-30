---@class NumericType
NumericType = {
    Max = 10000,
}

NumericType.Speed = 1000 ---速度
NumericType.SpeedBase = NumericType.Speed * 10 + 1
NumericType.SpeedAdd = NumericType.Speed * 10 + 2
NumericType.SpeedPct = NumericType.Speed * 10 + 3
NumericType.SpeedFinalAdd = NumericType.Speed * 10 + 4
NumericType.SpeedFinalPct = NumericType.Speed * 10 + 5

NumericType.Hp = 1001 ---体力，气血
NumericType.HpBase = NumericType.Hp * 10 + 1

NumericType.MaxHp = 1002 ---气血上限
NumericType.MaxHpBase = NumericType.MaxHp * 10 + 1
NumericType.MaxHpAdd = NumericType.MaxHp * 10 + 2
NumericType.MaxHpPct = NumericType.MaxHp * 10 + 3
NumericType.MaxHpFinalAdd = NumericType.MaxHp * 10 + 4
NumericType.MaxHpFinalPct = NumericType.MaxHp * 10 + 5

NumericType.Atk = 1003 ---攻击
NumericType.AtkBase = NumericType.Atk * 10 + 1
NumericType.AtkAdd = NumericType.Atk * 10 + 2
NumericType.AtkPct = NumericType.Atk * 10 + 3
NumericType.AtkFinalAdd = NumericType.Atk * 10 + 4
NumericType.AtkFinalPct = NumericType.Atk * 10 + 5

NumericType.Def = 1004 ---防御
NumericType.DefBase = NumericType.Def * 10 + 1
NumericType.DefAdd = NumericType.Def * 10 + 2
NumericType.DefPct = NumericType.Def * 10 + 3
NumericType.DefFinalAdd = NumericType.Def * 10 + 4
NumericType.DefFinalPct = NumericType.Def * 10 + 5

NumericType.Hit = 1005 ---命中（率）
NumericType.HitBase = NumericType.Hit * 10 + 1
NumericType.HitAdd = NumericType.Hit * 10 + 2
NumericType.HitPct = NumericType.Hit * 10 + 3

NumericType.Pry = 1006 ---回避（率)
NumericType.PryBase = NumericType.Pry * 10 + 1
NumericType.PryAdd = NumericType.Pry * 10 + 2
NumericType.PryPct = NumericType.Pry * 10 + 3

NumericType.Blk = 1007 ---格挡（率）
NumericType.BlkBase = NumericType.Blk * 10 + 1
NumericType.BlkAdd = NumericType.Blk * 10 + 2
NumericType.BlkPct = NumericType.Blk * 10 + 3

NumericType.Stm = 1008 ---耐性
NumericType.StmBase = NumericType.Stm * 10 + 1
NumericType.StmAdd = NumericType.Stm * 10 + 2
NumericType.StmPct = NumericType.Stm * 10 + 3

NumericType.Cri = 1009 ---暴击（率)
NumericType.CriBase = NumericType.Cri * 10 + 1
NumericType.CriAdd = NumericType.Cri * 10 + 2
NumericType.CriPct = NumericType.Cri * 10 + 3

NumericType.Cac = 1010 ---反击（率)
NumericType.CacBase = NumericType.Cac * 10 + 1
NumericType.CacAdd = NumericType.Cac * 10 + 2
NumericType.CacPct = NumericType.Cac * 10 + 3

NumericType.PhysicDamage = 1011 ---物理伤害加成
NumericType.PhysicDamageBase = NumericType.PhysicDamage * 10 + 1
NumericType.PhysicDamageAdd = NumericType.PhysicDamage * 10 + 2

NumericType.PhysicHurt = 1012 ---物理伤害减免
NumericType.PhysicHurtBase = NumericType.PhysicHurt * 10 + 1
NumericType.PhysicHurtAdd = NumericType.PhysicHurt * 10 + 2

NumericType.MagicDamage = 1013 ---魔法伤害加成
NumericType.MagicDamageBase = NumericType.MagicDamage * 10 + 1
NumericType.MagicDamageAdd = NumericType.MagicDamage * 10 + 2

NumericType.MagicHurt = 1014 ---魔法伤害减免
NumericType.MagicHurtBase = NumericType.MagicHurt * 10 + 1
NumericType.MagicHurtAdd = NumericType.MagicHurt * 10 + 2

NumericType.FinalDamage = 1031 ---最终伤害加成
NumericType.FinalDamageBase = NumericType.FinalDamage * 10 + 1
NumericType.FinalDamageAdd = NumericType.FinalDamage * 10 + 2
NumericType.FinalDamageAddPct = NumericType.FinalDamage * 10 + 3

NumericType.FinalHurt = 1032 ---最终伤害减免
NumericType.FinalHurtBase = NumericType.FinalHurt * 10 + 1
NumericType.FinalHurtAdd = NumericType.FinalHurt * 10 + 2

NumericType.GAtkFinalDamage = 1033 ---普攻时最终伤害加成
NumericType.GAtkFinalDamageBase = NumericType.GAtkFinalDamage * 10 + 1
NumericType.GAtkFinalDamageAdd = NumericType.GAtkFinalDamage * 10 + 2

NumericType.GAtkFinalHurt = 1034 ---普攻时最终伤害减免
NumericType.GAtkFinalHurtBase = NumericType.GAtkFinalHurt * 10 + 1
NumericType.GAtkFinalHurtAdd = NumericType.GAtkFinalHurt * 10 + 2

NumericType.SkillFinalDamage = 1035 ---技能时最终伤害加成
NumericType.SkillFinalDamageBase = NumericType.SkillFinalDamage * 10 + 1
NumericType.SkillFinalDamageAdd = NumericType.SkillFinalDamage * 10 + 2

NumericType.SkillFinalHurt = 1036 ---技能时最终伤害减免
NumericType.SkillFinalHurtBase = NumericType.SkillFinalHurt * 10 + 1
NumericType.SkillFinalHurtAdd = NumericType.SkillFinalHurt * 10 + 2

NumericType.CacFinalDamage = 1037 ---反击时最终伤害加成
NumericType.CacFinalDamageBase = NumericType.CacFinalDamage * 10 + 1
NumericType.CacFinalDamageAdd = NumericType.CacFinalDamage * 10 + 2

NumericType.CacFinalHurt = 1038 ---反击时最终伤害减免
NumericType.CacFinalHurtBase = NumericType.CacFinalHurt * 10 + 1
NumericType.CacFinalHurtAdd = NumericType.CacFinalHurt * 10 + 2

NumericType.CriFinalDamage = 1039 ---暴击时最终伤害加成
NumericType.CriFinalDamageBase = NumericType.CriFinalDamage * 10 + 1
NumericType.CriFinalDamageAdd = NumericType.CriFinalDamage * 10 + 2
NumericType.CriFinalDamageAddPct = NumericType.CriFinalDamage * 10 + 3

NumericType.CriFinalHurt = 1040 ---暴击时最终伤害减免
NumericType.CriFinalHurtBase = NumericType.CriFinalHurt * 10 + 1
NumericType.CriFinalHurtAdd = NumericType.CriFinalHurt * 10 + 2

NumericType.HealEffect = 1041 ---治疗效果
NumericType.HealEffectBase = NumericType.HealEffect * 10 + 1
NumericType.HealEffectAdd = NumericType.HealEffect * 10 + 2

NumericType.HealRecEffect = 1042 ---受疗效果、禁疗、增疗
NumericType.HealRecEffectBase = NumericType.HealRecEffect * 10 + 1
NumericType.HealRecEffectAdd = NumericType.HealRecEffect * 10 + 2

NumericType.CriHurt = 1043 ---所受暴击几率
NumericType.CriHurtBase = NumericType.CriHurt * 10 + 1
NumericType.CriHurtAdd = NumericType.CriHurt * 10 + 2

NumericType.UnableActRate = 1044 ---无法行动的几率
NumericType.UnableActRateBase = NumericType.UnableActRate * 10 + 1
NumericType.UnableActRatePct = NumericType.UnableActRate * 10 + 3

NumericType.DeBuffTurnIncrease = 1045 ---负面buff持续回合加成 对敌使用
NumericType.DeBuffTurnIncreaseBase = NumericType.DeBuffTurnIncrease * 10 + 1
NumericType.DeBuffTurnIncreaseAdd = NumericType.DeBuffTurnIncrease * 10 + 2

NumericType.DeBuffTurnReduce = 1046 ---负面buff持续回合减免 对自己使用
NumericType.DeBuffTurnReduceBase = NumericType.DeBuffTurnReduce * 10 + 1
NumericType.DeBuffTurnReduceAdd = NumericType.DeBuffTurnReduce * 10 + 2

NumericType.BuffTurnIncrease = 1047 ---增益buff持续回合数加成 对自己使用
NumericType.BuffTurnIncreaseBase = NumericType.BuffTurnIncrease * 10 + 1
NumericType.BuffTurnIncreaseAdd = NumericType.BuffTurnIncrease * 10 + 2

NumericType.CooldownTurn = 1048 ---技能最大冷却回合数加成
NumericType.CooldownTurnBase = NumericType.CooldownTurn * 10 + 1
NumericType.CooldownTurnAdd = NumericType.CooldownTurn * 10 + 2

NumericType.ReflectDamage = 1049 ---反伤比例
NumericType.ReflectDamageBase = NumericType.ReflectDamage * 10 + 1
NumericType.ReflectDamageAdd = NumericType.ReflectDamage * 10 + 2

NumericType.Acc = 1050 ---精确 
NumericType.AccBase = NumericType.Acc * 10 + 1
NumericType.AccAdd = NumericType.Acc * 10 + 2
NumericType.AccPct = NumericType.Acc * 10 + 3

NumericType.CriDamage = 1051 ---爆伤
NumericType.CriDamageBase = NumericType.CriDamage * 10 + 1
NumericType.CriDamageAdd = NumericType.CriDamage * 10 + 2

NumericType.AntiCri = 1052 ---抗暴
NumericType.AntiCriBase = NumericType.AntiCri * 10 + 1
NumericType.AntiCriAdd = NumericType.AntiCri * 10 + 2

NumericType.MagicDef = 1053 ---魔法防御
NumericType.MagicDefBase = NumericType.MagicDef * 10 + 1
NumericType.MagicDefAdd = NumericType.MagicDef * 10 + 2
NumericType.MagicDefPct = NumericType.MagicDef * 10 + 3
NumericType.MagicFinalAdd = NumericType.MagicDef * 10 + 4
NumericType.MagicFinalPct = NumericType.MagicDef * 10 + 5

NumericType.EAcc = 1054 ---效果命中
NumericType.EAccBase = NumericType.EAcc * 10 + 1
NumericType.EAccAdd = NumericType.EAcc * 10 + 2

NumericType.ERist = 1055 ---效果抗性
NumericType.ERistBase = NumericType.ERist * 10 + 1
NumericType.ERistAdd = NumericType.ERist * 10 + 2