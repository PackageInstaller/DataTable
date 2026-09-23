-- 场景类型
SceneType = {}
SceneType.PVE			= 1 -- pve(主线/副本)
SceneType.PVP			= 2 -- pvp(实时)
SceneType.PVPMirror		= 3 -- pvp(镜像)
SceneType.BOSS			= 4 -- 世界BOSS
SceneType.SinglePVE		= 5 -- 单机pve(主线/副本)
SceneType.PVEBuild		= 6 -- pve(非副本)
SceneType.GuildBOSS		= 7 -- 工会BOSS
SceneType.TeamBOSS		= 7 -- 组队BOSS
SceneType.FieldBoss		= 8 -- 战场系统BOSS
SceneType.Rogue			= 9 -- 乱序演习
SceneType.RogueS		= 10 -- 战力派遣
SceneType.GlobalBoss	= 11 -- 新世界boss
SceneType.RogueT 		= 12 -- 能力测验
SceneType.BuffBattle	= 13 -- 积分战斗
SceneType.RogueMap		= 14 -- 小地图探索
SceneType.MultTeam		= 15 -- 多队玩法
SceneType.RogueMapSup	= 16 -- 小地图探索支援
SceneType.PVEFreeMatch	= 17 -- 自由军演(镜像) -- v 4.3
SceneType.TowerDeep		= 18 -- 新爬塔 -- v 4.4
SceneType.PVP3			= 19 -- pvp(实时) -- v 4.6
SceneType.PVEFreeMatch3	= 20 -- 自由军演(镜像) -- v 4.6
SceneType.ChainFront	= 21 -- 历战试炼-连锁战线 -- v 5.2
SceneType.PeriodicBoss  = 22 -- 周期BOSS -- v 6.0
SceneType.CrossBoss  	= 24 -- 虚数天灾 -- v 6.0

-- v 4.6
function IsPvpSceneType(sType)
	return sType == SceneType.PVP or sType == SceneType.PVEFreeMatch or sType == SceneType.PVP3 or sType == SceneType.PVEFreeMatch3
end
-- 包含镜像
function IsPvpSceneTypeEx(sType)
	return IsPvpSceneType(sType) or sType == SceneType.PVPMirror
end

-- 副本类型
eDuplicateType                 = {}
eDuplicateType.Comm            = 0 -- 服务器保存数据使用
eDuplicateType.MainNormal      = 1 -- 主线普通
eDuplicateType.MainElite       = 2 -- 主线精英
eDuplicateType.SubLine         = 3 -- 支线
eDuplicateType.Teaching		   = 4 --教程
eDuplicateType.Tower           = 5 -- 爬塔
eDuplicateType.BattleField     = 6 -- 战场
eDuplicateType.BattleFieldBoss = 7 -- 战场boss
eDuplicateType.TaoFa           = 8 -- 讨伐
eDuplicateType.Rogue9          = 9 -- 乱序演习
eDuplicateType.Rogue           = 10 -- 乱序演习		-- 客户端有用到，所以保留一个eDuplicateType.Rogue=10
eDuplicateType.Rogue10         = 10 -- 乱序演习
eDuplicateType.StarPalace      = 11 -- 十二星宫
eDuplicateType.RogueS	       = 12 -- 战力派遣
eDuplicateType.AbattoirSelect  = 13 -- 角斗场自选模式
eDuplicateType.AbattoirRand	   = 14 -- 角斗场随机模式
eDuplicateType.RogueT	       = 15 -- 能力测验
eDuplicateType.RogueMap	       = 16 -- 小地图探索
eDuplicateType.MultTeam	       = 17 -- 多队玩法
eDuplicateType.TowerDeep	   = 18 -- 深塔计划 v 4.4
eDuplicateType.NewTower        = 19 -- 异构空间
eDuplicateType.ChainFront      = 20 -- 历战试炼-连锁战线 -- v 5.2
eDuplicateType.EternalBattle   = 21 -- 永境战域 -- v 5.3
eDuplicateType.SkinPass   	   = 22 -- 皮肤通行证 -- v 5.3
eDuplicateType.CrossBoss       = 23 -- 虚数天灾 -- v 6.0
eDuplicateType.PeriodicBoss	   = 24 -- 周期BOSS -- v 6.0

eDuplicateType.Materials       = 101 -- 材料副本
eDuplicateType.Equip           = 102 -- 装备副本
eDuplicateType.Gold            = 103 -- 金币
eDuplicateType.Exp             = 104 -- 经验
eDuplicateType.Skill           = 105 -- 技能材料
eDuplicateType.StoryActive     = 106 -- 剧情活动
--eDuplicateType.Rogue           = 108 --乱序、战力派遣
--eDuplicateType.Colosseum       = 109 --角斗场
eDuplicateType.Building   	   = 110 -- 建造关卡 -- v 5.6

GenEnumNameByVal('eDuplicateTypeName', eDuplicateType)

eDuplicateTypeChName                 = {}
eDuplicateTypeChName.MainNormal      ="主线普通"
eDuplicateTypeChName.MainElite       ="主线精英"
eDuplicateTypeChName.SubLine         ="支线"
eDuplicateTypeChName.Teaching		 ="教程"
eDuplicateTypeChName.Tower           ="爬塔"
eDuplicateTypeChName.BattleField     ="战场"
eDuplicateTypeChName.BattleFieldBoss ="战场boss"
eDuplicateTypeChName.TaoFa           ="讨伐"
eDuplicateTypeChName.CrossBoss       ="全服boss"
eDuplicateTypeChName.Materials       ="材料副本"
eDuplicateTypeChName.Equip           ="装备副本"
eDuplicateTypeChName.Gold            ="金币"
eDuplicateTypeChName.Exp             ="经验"
eDuplicateTypeChName.Skill           ="技能材料"
eDuplicateTypeChName.StoryActive     ="剧情活动"



-- 副本关卡副类型
eDupSubType = {}
eDupSubType.Story	= 1 -- 剧情

-- 正在进行的副本战斗下标类型
eDupIdxType = {}
eDupIdxType.Normal	= 1 -- 普通战斗，以关卡ID为key
eDupIdxType.Rogue	= 2 -- 乱序演习，
eDupIdxType.RogueT	= 3 -- 限制肉鸽爬塔
eDupIdxType.RogueMap= 4 -- 小地图探索
eDupIdxType.MultTeam= 5 -- 多队玩法
eDupIdxType.ChainFront= 6 -- 连锁战线
eDupIdxType.CrossBoss	= 7 -- 虚数天灾


-- 卡牌类型
CardType = {}
CardType.Character	= 1 -- 主角
CardType.Card		= 2 -- 玩家卡牌
CardType.Monster	= 3 -- npc
CardType.Boss		= 4 -- boss
CardType.Summon		= 5 -- 召唤
CardType.Unite		= 6 -- 合体
CardType.Mirror		= 7 -- 玩家镜像
CardType.WorldBoss	= 8 -- 世界boss

-- 卡牌移动类型
eMoveType = {}
eMoveType.Land		= 1 -- 陆行单位：移动时会受到地形及部分障碍的影响；
eMoveType.Fly		= 2 -- 飞行单位：移动时，不会受到地形及部分障碍的影响；
eMoveType.Water		= 3 -- 水中单位：在地面时，移动方式和陆行单位一致，但在海上会有加成；
eMoveType.Teleport	= 4 -- 瞬移单位：移动时，不受地形及障碍的影响；
eMoveType.Float		= 5 -- 浮游单位：移动时，会受到地形的影响，但不会受到地面障碍的影响；

-- 技能类型
SkillType = {}
SkillType.Normon	= 1 -- 普通
SkillType.Skill		= 2 -- 技能
SkillType.Summon	= 3 -- 召唤
SkillType.Unite		= 4 -- 合体
SkillType.Passive	= 5 -- 被动
SkillType.Revive	= 6 -- 复活
SkillType.Equip		= 7 -- 装备技能
SkillType.Transform	= 8 -- 变身
-- SkillType.OverLoad	= 9 -- OverLoad

-- 战斗命令
CMD_TYPE = {}
CMD_TYPE.InitData		= 1 -- 初始化数据
CMD_TYPE.AddCard		= 2 -- 添加卡牌数据
CMD_TYPE.DelCard		= 3 -- 删除卡牌
CMD_TYPE.Start			= 4 -- 战斗开始
CMD_TYPE.ChangeStage	= 5 -- 切换周目
CMD_TYPE.Turn			= 6 -- 轮到我方回合
CMD_TYPE.Skill			= 7 -- 释放技能
CMD_TYPE.End			= 8 -- 战斗结束
CMD_TYPE.UpdateProgress	= 9 -- 更新进度条
CMD_TYPE.UpdateInfo 	= 10 -- 更新信息
CMD_TYPE.Dead			= 11 -- 角色死亡
CMD_TYPE.Summon			= 12 -- 召唤
CMD_TYPE.Combo			= 13 -- 合体
CMD_TYPE.ComboBreak		= 14 -- 合体解除
CMD_TYPE.OverLoad		= 15 -- OverLoad
CMD_TYPE.Eff		    = 16 -- Buff
CMD_TYPE.HitResult		= 17 -- 战斗结果延迟显示
CMD_TYPE.Revive		    = 18 -- 复活
CMD_TYPE.Auto		    = 19 -- 自动战斗
CMD_TYPE.Commander		= 20 -- 指挥官技能


-- 被动时机
ePassiveTiming = {}
ePassiveTiming.OnStart           = 1  -- 战斗开始
ePassiveTiming.OnBorn            = 2  -- 入场时
ePassiveTiming.OnRoundBegin      = 3  -- 回合开始时
ePassiveTiming.OnRoundOver       = 4  -- 回合结束时
ePassiveTiming.OnActionBegin     = 5  -- 行动开始
ePassiveTiming.OnActionOver      = 6  -- 行动结束
ePassiveTiming.OnAttackBegin     = 7  -- 攻击开始
ePassiveTiming.OnAttackOver      = 8  -- 攻击结束
ePassiveTiming.OnBefourHurt      = 9  -- 伤害前
ePassiveTiming.OnAfterHurt       = 10 -- 伤害后
ePassiveTiming.OnDeath           = 11 -- 死亡时
ePassiveTiming.OnKill            = 12 -- 击杀时
ePassiveTiming.OnCure            = 13 -- 治疗时
ePassiveTiming.OnAddBuff         = 14 -- 加buff时
ePassiveTiming.OnDelBuff         = 15 -- 驱散buff时
ePassiveTiming.OnRemoveBuff      = 16 -- 移除buff时
ePassiveTiming.OnCrit            = 17 -- 暴击
ePassiveTiming.OnChangeStage     = 18 -- 切换周目
ePassiveTiming.AfterCallSkill    = 19 -- 调用技能后
ePassiveTiming.OnBornSpecial     = 20 -- 特殊入场时(复活，召唤，合体)
ePassiveTiming.OnAfterRoundBegin = 21 -- 回合开始处理完成后
ePassiveTiming.OnActionOver2     = 22 -- 行动结束2
ePassiveTiming.OnResolve         = 23 -- 解体
ePassiveTiming.OnBefourCritHurt  = 24  -- 暴击伤害前(OnBefourHurt之前)
ePassiveTiming.OnAttackOver2     = 25  -- 攻击结束2
ePassiveTiming.OnAddProgress     = 26  -- 拉条
ePassiveTiming.OnReduceProgress  = 27  -- 退条
ePassiveTiming.OnTransform       = 28  -- 变身


-- 被动时机(数组)
arrPassiveTiming = {}
for k,v in pairs(ePassiveTiming) do
	arrPassiveTiming[v] = k
end


-- 攻击类型
eDamageType = {}
eDamageType.Physics	= 1 -- 物理攻击
eDamageType.Light	= 2 -- 光束攻击
eDamageType.Extra	= 3 -- 额外伤害
eDamageType.Damage	= 4 -- 通用伤害
eDamageType.Special	= 5 -- 特殊攻击

eDamageTypeString = {"DamagePhysics","DamageLight","ExtraDamage","Damage", "Special"}


-- 职业护甲
eCareer = {}
eCareer.Physics	= 1 -- 物理
eCareer.Light	= 2 -- 光束
eCareer.Special	= 3 -- 特殊(水/雷等)

-- buff类型
BuffGroup = {}
BuffGroup.Ctrl			= 1 -- 控制类
-- 效果强化
-- 效果弱化
-- 场效
-- 标志
-- 免疫

-- buff效果类型
BuffEffectType = {}
-- BuffEffectType.Attr    = 1 -- 属性类
BuffEffectType.Motionless = 2 -- 无法行动
-- BuffEffectType.Sneer   = 3 -- 嘲讽
BuffEffectType.Palsy      = 5 -- 麻痹

-- 无法行动类型
eMotionlessType = {}
eMotionlessType.Common = 1 -- 通用
eMotionlessType.Palsy  = 2 -- 麻痹
eMotionlessType.Cage   = 3 -- 牢笼

-- 无视光束盾物理盾攻击
eIgnoreShield = {}
eIgnoreShield.Physics = 1 -- 物理攻击
eIgnoreShield.Light   = 2 -- 光束攻击
eIgnoreShield.All     = 3 -- 物理和光束攻击
eIgnoreShield.Special = 4 -- 特殊攻击

eBufferAddType = {}
eBufferAddType.Spread   = 1 -- 扩散
eBufferAddType.Reflect  = 2 -- 反射
eBufferAddType.Transfer = 3 -- 转移

---------------------------------------------
-- 世界boss

-- 世界boss状态
eBossState = {}
eBossState.Apply    = 1 -- 报名阶段
eBossState.Fighting = 2 -- 战斗阶段
eBossState.Over     = 3 -- 结束阶段
eBossState.Reward   = 4 -- 颁奖阶段
eBossState.Delete   = 5 -- 删除阶段

---------------------------------------------
-- 表情展示时机
eEmoteState = {}
eEmoteState.Start	 	= 1		-- 战斗开始
eEmoteState.Win 		= 2		-- 赢
eEmoteState.Lose	 	= 3		-- 输