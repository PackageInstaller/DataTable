
BATTLE_ACT_VALUE_MAX = tonumber(Z_Misc["BATTLE_ACT_VALUE_MAX"].Value[1])
BATTLE_STANDARD_SPEED = tonumber(Z_Misc["BATTLE_STANDARD_SPEED"].Value[1])
BATTLE_TURN_DURATION = tonumber(Z_Misc["BATTLE_TURN_DURATION"].Value[1])
BATTLE_RANDOM_SPEED_MIN = tonumber(Z_Misc["BATTLE_RANDOM_SPEED"].Value[1])
BATTLE_RANDOM_SPEED_MAX = tonumber(Z_Misc["BATTLE_RANDOM_SPEED"].Value[2])


BattleDamageType = 
{
	Physical = 1,
	Magic = 2,
	Real = 3,
	Universal = 4,	-- 万能伤害，只会被万能护盾抵消
}

BattleDispelType = 
{
	Buff = 1,
	Debuff = 2,
	All = 3,
}

BattleIncBuffTurnType = 
{
	AllBuff = 1,
	AllDebuff = 2,
	One = 3,
}

TargetType = 
{
	SkillTargetEnemy = 1,
	SkillTargetFriend = 2,
	Self = 3,
}

BattleEffectType = 
{
	Damage = 1,				-- 造成伤害: 攻击力* 伤害系数 + 额外属性* 额外系数, 参数[伤害类型, 额外属性类型(可以不填)], 技能参数索引[伤害系数, 额外伤害系数]
	DamageAttrDiff = 2,		-- 根据属性差造成伤害, 参数[伤害类型, 差异属性], 技能参数索引[基础系数, 属性差系数]
	Addbuff = 3,			-- 添加buff, 参数[buffId], 技能参数索引[回合数]
	IncActValue = 4,		-- 增加行动值, 参数[], 技能参数索引[行动值]
	Dispel = 5,				-- 随机驱散buff, 参数[驱散类型, buff数量], 技能参数索引[]
	HealHp = 6,				-- 治疗, 参数[关联属性], 技能参数索引[治疗系数]
	RefreshCd = 7,			-- 刷新技能cd, 参数[刷新类型], 技能参数索引[]
	Revive = 8,				-- 复活, 参数[关联属性], 技能参数索引[治疗系数]
	Action = 9,				-- 立刻行动, 参数[], 技能参数索引[]
	IncBuffTurn = 10,		-- 增加buff持续, 参数[是否duff(1 不是, 2 是)], 技能参数索引[回合数]
	LifeSteal = 11,			-- 吸血, 参数[], 技能参数索引[吸血系数]
	ExtraCriDamage = 12,	-- 额外爆伤, 参数[], 技能参数索引[伤害值]
	ExtraDamage = 13,		-- 额外伤害, 参数[计算类型], 技能参数索引[计算类型参数...]
	AddShieldBuff = 14,		-- 添加护盾, 护盾血量: 关联属性1* 关联属性1系数 + 关联属性2* 关联属性2系数 + ..., 参数[护盾buffid, 关联属性...], 技能参数索引[回合数, 关联属性系数...]
	ExtraIgnoreDef = 15,	-- 额外无视防御, 参数[计算类型], 技能参数索引[计算类型参数...]
	DecActValue = 16,		-- 减少行动值, 参数[], 技能参数索引[行动值]
}

-- 技能cd刷新类型
BattleEffectRefreshCdType = 
{
	GeneralAtk = 1,		-- 普攻
	Skill1 = 2,			-- 技能1
	Skill2 = 3,			-- 技能2
	All = 4,			-- 所有技能
	CurrentSkill = 5,	-- 当前技能
}

-- 额外伤害计算类型
BattleEffectExtraDamageCalcType = 
{
	DamageValue = 1,		-- 直接填写伤害值, 参数[伤害值]
	HpLose = 2,				-- 生命值损失幅度* 系数, 参数[系数]
	ActionValue = 3,		-- 行动条位置* 系数, 参数[系数]
}

-- 无视防御数值的计算类型
BattleEffectIgnoreDefType = 
{
	IgnoreValue = 1,		-- 直接填写数值, 参数[无视的数值]
	HpLose = 2,				-- 生命值损失幅度* 系数, 参数[系数]
}

-- 防御数值类型
BattleFeffectDefType = 
{
	Def = 1,
	MagicDef = 2,
	Both = 3,
}

BattleEffectTypeScript = 
{
	[BattleEffectType.Damage] = "EffectDamage",
	[BattleEffectType.DamageAttrDiff] = "EffectDamageAttrDiff",
	[BattleEffectType.Addbuff] = "EffectAddBuff",
	[BattleEffectType.IncActValue] = "EffectIncActValue",
	[BattleEffectType.Dispel] = "EffectDispel",
	[BattleEffectType.HealHp] = "EffectHealHp",
	[BattleEffectType.RefreshCd] = "EffectRefreshCd",
	[BattleEffectType.Revive] = "EffectRevive",
	[BattleEffectType.Action] = "EffectAction",
	[BattleEffectType.IncBuffTurn] = "EffectIncBuffTurn",
	[BattleEffectType.LifeSteal] = "EffectLifeSteal",
	[BattleEffectType.ExtraCriDamage] = "EffectExtraCriDamage",
	[BattleEffectType.ExtraDamage] = "EffectExtraDamage",
	[BattleEffectType.AddShieldBuff] = "EffectAddShieldBuff",
	[BattleEffectType.ExtraIgnoreDef] = "EffectExtraIgnoreDef",
	[BattleEffectType.DecActValue] = "EffectDecActValue",
}

BattleConditionType = 
{
	Buff = 1,			-- 拥有buff, 每个目标对应一个buffId, 参数[buffId...]
	Status = 2,			-- 状态判断, 参数[状态类型, 状态参数...]
	Attribute = 3,		-- 没东西, 不知道是啥
	BuffTypeCount = 4,	-- buff数量, 参数[buff类型(1 buff， 2 debuff), 数量]
	AfterBuff = 5,		-- 攻击后拥有buff, 每个目标对应一个buffId, 参数[buffId...]
}

BattleConditionStatusType = 
{
	UnitStatus = 1,		-- 角色状态
	ActStatus = 2,		-- 角色行动状态
}

BattleConditionActStatusType = 
{
	IsCac = 1,		-- 反击中
}

BattleConditionTypeScript = 
{
	[BattleConditionType.Buff] = "ConditionBuff",
	[BattleConditionType.Status] = "ConditionStatus",
	[BattleConditionType.Attribute] = "ConditionAttribute",
	[BattleConditionType.BuffTypeCount] = "ConditionBuffTypeCount",
	[BattleConditionType.AfterBuff] = "ConditionAfterBuff",
}

TriggerEvent = 
{
	OnBattleStart = 1,
	OnBatchStart = 2,
	OnRoundStart = 3,
	OnActStart = 4,
	OnAtkStart = 5,
	OnUseActiveSkill = 6,
	BeforeHit = 7,
	OnHit = 8,
	OnCri = 9,
	AfterHurt = 10,
	AfterAllHurt = 11,
	AfterAllHurtByPry = 12,
	OnAtkEnd = 13,
	OnActEnd = 14,
	OnRoundEnd = 15,
	OnBattleEnd = 16,
	OnPassiveSkillEnabled = 17,
	OnPassiveSkill2EnemyEnabled = 18,
	OnPassiveSkillDisabled = 19,
	OnPrySuccess = 20,
	OnDead = 21,
	OnRevive = 22,
	OnHpChange = 23,
	OnNpChange = 24,
	OnKillEnemy = 25,
	OnUseAwaken = 26,
	OnFriendDead = 27,
	OnFriendRevive = 28,
	OnContinueDebuff = 29,
}

TriggerTypeScript = 
{
	
}

BattleEndConditionType = 
{
	KillAll = 1,
	Turn = 2,
	DeadCount = 3,
}

BATTLE_NUM_MAX = 99999999

BattleSkillType = 
{
	Damage = 1,
	Assist = 2,
	All = 3,
}

BattleBuffType =
{
	AtkIncrease = 10001,            --攻击提升
	AtkIncrease2 = 10002,           --攻击提升（大）
	DefIncrease = 10003,            --物防提升
	DefIncrease2 = 10004,           --物防提升（大）
	MagicDefIncrease = 10005,       --术防提升
	MagicDefIncrease2 = 10006,      --术防提升（大）
	SpeedIncrease = 10007,          --速度提升
	SpeedIncrease2 = 10008,         --速度提升（大）
	EAccIncrease = 10009,           --精准提升
	EResistIncrease = 10010,        --耐性提升
	CriIncrease = 10011,            --暴击提升
	CriDamageIncrease = 10012,      --暴击伤害提升
	CriResistIncrease = 10013,      --暴击抵抗提升
	HitIncrease = 10014,            --命中提升
	PryIncrease = 10015,            --回避提升
	PhyShield = 10016,              --物理护盾
	MagicShield = 10017,            --法术护盾
	UniversalShield = 10018,        --万能护盾
	ImmuneDeBuff = 10019,           --免疫
	Heal = 10020,                   --持续回复
	Cac = 10021,                    --反击
	Invincible = 10022,             --无敌
	Immortal = 10023,               --不死
	Revive = 10024,                 --复活
	CriInsight = 10025,             --识破
	ImmuneDamage = 10026,           --伤害无效
	Taunt = 10027,                  --挑衅
	Hide = 10028,                   --隐蔽
	Anger = 10029,                  --怒火
   
	DebuffStart = 20000,

	AtkDecrease = 20001,            --攻击降低
	DefDecrease = 20002,            --物防降低
	MagicDefDecrease = 20003,       --术防降低
	SpeedDecrease = 20004,          --速度降低
	EAccDecrease = 20005,           --精准降低
	EResistDecrease = 20006,        --耐性降低
	HitDecrease = 20007,            --命中降低
	HealDisable = 20008,            --回复禁止
	BuffDisable = 20009,            --强化禁止
	Taunted = 20010,                --嘲讽
	Silence = 20011,                --沉默
	PassiveDisable = 20012,         --遗忘
	Stunning = 20013,               --眩晕
	Sleeping = 20014,               --睡眠
	Poison = 20015,                 --中毒
	Vulnerable = 20016,             --标靶
	Fire = 20017,                   --灼烧
	Freeze = 20018,                 --冻结
	Petrification = 20019,          --石化
	Paralysis = 20020,              --麻痹
	Restraint = 20021,              --拘束

	DebuffEnd = 20022,
}
