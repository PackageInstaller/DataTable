local bc = {}
bc.ApiType = {
  CMD = "指令",
  CMD_MEMBER = "指令变量",
  TARGET = "目标",
  FORMULA = "公式",
  CARD = "卡牌",
  CARD_DECK = "牌堆",
  STASTICS = "战斗统计",
  STR_VALUE = "标记",
  GLOBAL_VALUE = "参数",
  GLOBAL_FUNC = "全局函数",
  FUNC = "函数",
  CARD_TRIGGER = "卡牌监听",
  ROLE_TRIGGER = "角色监听",
  FLOW_TRIGGER = "流程监听",
  KEEPER_SKILL = "钥令",
  FUNC_ATTR = "功能属性",
  ATTR = "角色属性",
  AWAKER_ATTR = "唤醒体属性",
  STATS_ATTR = "统计属性",
  CARD_ATTR = "卡牌属性"
}
bc.SkillType = {
  Card_Skill = "Card_Skill",
  Card_Strike = "Card_Strike",
  Card_Defend = "Card_Defend",
  Card_Awake = "Card_Awake",
  Ulti_Skill = "Ulti_Skill",
  Card_Curse = "Card_Curse",
  Card_State = "Card_State",
  Card_Potion = "Card_Potion",
  Keeper_Skill = "Keeper_Skill",
  Card_Weapon = "Card_Weapon",
  Card_KeeperSkill = "Card_KeeperSkill",
  Card_Extend = "Card_Extend",
  Card_AttachPost = "Card_AttachPost"
}
bc.DefaultSkillAIUseOrder = {
  CardSkill = 1,
  KeeperSkill = 2,
  AwakerSkill = 3
}
bc.TimelineDir = {LEFT = 0, RIGHT = 1}
bc.AwakerFaceDir = {LEFT = 1, RIGHT = -1}
bc.SpawnPointDir = {LEFT = 1, RIGHT = 2}
bc.MonsterClass = {
  Common = "Common",
  Elite = "Elite",
  Boss = "Boss"
}
bc.BattleEffectType = {
  BEBattleFlow = "BEBattleFlow",
  BETentacleAttack = "BETentacleAttack",
  BETentacleDamage = "BETentacleDamage",
  BESpawnWaveMonster = "BESpawnWaveMonster",
  BESendEvent = "BESendEvent",
  BERoleDie = "BERoleDie",
  BEBoutLimitConfirm = "BEBoutLimitConfirm",
  BERoleDeadlyDamage = "BERoleDeadlyDamage",
  BERoot = "BERoot",
  BEBattleEnd = "BEBattleEnd",
  BEBattleBegin = "BEBattleBegin",
  BEPlayDrama = "BEPlayDrama",
  BEMonsterChangePhase = "BEMonsterChangePhase",
  BECreateSkillPhase = "BECreateSkillPhase",
  BESwapActor = "BESwapActor",
  BERespawn = "BERespawn",
  BEBeforeMonsterAction = "BEBeforeMonsterAction",
  BEAfterMonsterAction = "BEAfterMonsterAction",
  BEBeforeUseCard = "BEBeforeUseCard",
  BEAfterUseCard = "BEAfterUseCard",
  BEGenerateTargets = "BEGenerateTargets",
  BEUseKeeperSkill = "BEUseKeeperSkill",
  BEUseDimensionSkill = "BEUseDimensionSkill",
  BEUseSilverKeyAwake = "BEUseSilverKeyAwake",
  BEAfterUseBloodRecoverSkill = "BEAfterUseBloodRecoverSkill",
  BEAfterUseSpecialDimension = "BEAfterUseSpecialDimension",
  BEActiveDamage = "BEActiveDamage",
  BEChangeAttr = "BEChangeAttr",
  BEMoveCard = "BEMoveCard",
  BEGainBlock = "BEGainBlock",
  BEAddState = "BEAddState",
  BEGainUltiEnergy = "BEGainUltiEnergy",
  BEHeal = "BEHeal",
  BECreateCard = "BECreateCard",
  BEDestroyCard = "BEDestroyCard",
  BELaunchSwallow = "BELaunchSwallow",
  BEChangeMaxTentacleCount = "BEChangeMaxTentacleCount",
  BERebirthStage = "BERebirthStage",
  BEBeforeUseUlti = "BEBeforeUseUlti",
  BEAfterUseUlti = "BEAfterUseUlti",
  BEAfterUseKeeperSkill = "BEAfterUseKeeperSkill",
  BEAfterUseDimensionSkill = "BEAfterUseDimensionSkill",
  BEAfterUseSilverKeyAwake = "BEAfterUseSilverKeyAwake",
  BEBeforeUseOtherSkill = "BEBeforeUseOtherSkill",
  BEAfterUseOtherSkill = "BEAfterUseOtherSkill",
  BEGainRelicById = "BEGainRelicById",
  BERemoveRelic = "BERemoveRelic",
  BEFunctionEffect = "BEFunctionEffect",
  BEExecuteCmd = "BEExecuteCmd",
  BEForceExecSkill = "BEForceExecSkill",
  BEForceExecCard = "BEForceExecCard"
}
bc.SkipParserParamEffect = {
  BERunTimeline = "BERunTimeline",
  BETargetRunTimeline = "BETargetRunTimeline",
  BEActiveDeathResist = "BEActiveDeathResist"
}
bc.SchoolCnID = {
  CHAOS = "职业@混沌",
  DEEP_SEA = "职业@深海",
  BLOOD = "职业@血肉",
  DIMENSION = "职业@超维"
}
bc.SchoolID = {
  CHAOS = 1,
  BLOOD = 2,
  DIMENSION = 3,
  DEEP_SEA = 4
}
bc.STR_BOOL = {TRUE = true, FALSE = false}
bc.DamageTriggerType = {
  None = nil,
  Unblocked = "Unblocked",
  CritDamage = "CritDamage",
  AttachPostAction = "AttachPostAction"
}
bc.AttachPostActionPerformType = {
  None = 0,
  ActorPainting = 1,
  CardFace = 2
}
bc.StateShowType = {
  Hide = "Hide",
  Normal = "Normal",
  Affix = "Affix",
  Describe = "Describe",
  WeaponIconAndDesc = "WeaponIconAndDesc",
  HideFloatText = "HideFloatText",
  AwakerAffix = "AwakerAffix"
}
bc.StateHideMap = {
  [bc.StateShowType.Hide] = true,
  [bc.StateShowType.Affix] = true,
  [bc.StateShowType.Describe] = true,
  [bc.StateShowType.WeaponIconAndDesc] = true
}
bc.IsPrintCmd = false
bc.TotalMonsterPos = 15
bc.MaxHistory = 10
bc.ShowHistoryNum = 5
bc.BattlePhase = {
  None = 0,
  Ready = 1,
  Battle = 2,
  Finish = 3
}
bc.BoutPhase = {
  None = 0,
  Begin = 1,
  Action = 2,
  End = 3
}
bc.CardDeck = {
  NoneDeck = "NoneDeck",
  DrawDeck = "DrawDeck",
  HandDeck = "HandDeck",
  HideDeck = "HideDeck",
  GraveyardDeck = "GraveyardDeck",
  ConsumedDeck = "ConsumedDeck",
  UsingDeck = "UsingDeck",
  AwakeDeck = "AwakeDeck",
  SwallowDeck = "SwallowDeck",
  DimensionDeck = "DimensionDeck",
  MonsterDimensionDeck = "MonsterDimensionDeck",
  SelectInitDeck = "SelectInitDeck",
  Activity24Deck = "Activity24Deck",
  BrainDeck = "BrainDeck",
  TempDeck1 = "TempDeck1",
  TempDeck2 = "TempDeck2",
  TempDeck3 = "TempDeck3",
  TempDeck4 = "TempDeck4",
  TempDeck5 = "TempDeck5",
  TempDeck6 = "TempDeck6",
  TempDeck7 = "TempDeck7",
  TempDeck8 = "TempDeck8",
  TempDeck9 = "TempDeck9",
  TempDeck10 = "TempDeck10",
  TempDeck11 = "TempDeck11",
  TempDeck12 = "TempDeck12",
  TempDeck13 = "TempDeck13",
  TempDeck14 = "TempDeck14",
  TempDeck15 = "TempDeck15",
  TempDeck16 = "TempDeck16",
  TempDeck17 = "TempDeck17",
  TempDeck18 = "TempDeck18",
  TempDeck19 = "TempDeck19",
  TempDeck20 = "TempDeck20"
}
bc.CardDeckReason = {
  Discard = 1,
  Use = 2,
  Draw = 3,
  BattleEffect = 4,
  Shuffle = 5,
  Init = 6,
  ExtraBout = 7,
  TimesRunOut = 8,
  SelectInit = 9,
  NewCard = 10
}
bc.StateType = {
  Role = 1,
  Awaker = 2,
  Card = 3
}
bc.StatsKey = {
  BattleResult = "BattleResult",
  DiscardedCardCount = "DiscardedCardCount",
  DrawCardCount = "DrawCardCount",
  ExtraDrawCardCount = "ExtraDrawCardCount",
  EndBoutDiscardCount = "EndBoutDiscardCount",
  ConsumeEnergy = "ConsumeEnergy",
  BoutMaxConsumeEnergy = "BoutMaxConsumeEnergy",
  ConsumeMoney = "ConsumeMoney",
  EmojiCount = "EmojiCount",
  StrikeCardUsedCount = "StrikeCardUsedCount",
  DefenceCardUsedCount = "DefenceCardUsedCount",
  SkillCardUsedCount = "SkillCardUsedCount",
  AwakeCardUsedCount = "AwakeCardUsedCount",
  OtherCardUsedCount = "OtherCardUsedCount",
  CurseCardUsedCount = "CurseCardUsedCount",
  StateCardUsedCount = "StateCardUsedCount",
  UsedCardCount = "UsedCardCount",
  UsedCardCountByConfigId = "UsedCardCountByConfigId",
  UsedKeeperSkillCount = "UsedKeeperSkillCount",
  GainCardCount = "GainCardCount",
  DrawDeckResetCount = "DrawDeckResetCount",
  UltiSkillCount = "UltiSkillCount",
  BoutMaxUltiSkillCount = "BoutMaxUltiSkillCount",
  DimensionBoutCount = "DimensionBoutCount",
  SwallowedCardCount = "SwallowedCardCount",
  ConsumedScaletBloodCount = "ConsumedScaletBloodCount",
  PlayerDoDamage = "PlayerDoDamage",
  PlayerDoRealDamage = "PlayerDoRealDamage",
  PlayerDoBlockDamage = "PlayerDoBlockDamage",
  PlayerGotRealDamage = "PlayerGotRealDamage",
  PlayerGotBlockDamage = "PlayerGotBlockDamage",
  MonsterBeDamage = "MonsterBeDamage",
  BoutMaxMonsterBeDamage = "BoutMaxMonsterBeDamage",
  PlayerDoHeal = "PlayerDoHeal",
  PlayerDoBlock = "PlayerDoBlock",
  DeathResistCount = "DeathResistCount",
  KillCount = "KillCount",
  PlayerDeathCount = "PlayerDeathCount",
  OverFlowEnergy = "OverFlowEnergy",
  BattleFightBackKill = "BattleFightBackKill",
  CritKill = "CritKill",
  BoutCount = "BoutCount",
  PlayerActionCount = "PlayerActionCount",
  BoutMaxPlayerDoDamage = "BoutMaxPlayerDoDamage",
  MaxPlayerDoDamage = "MaxPlayerDoDamage",
  BoutMaxPlayerBlock = "BoutMaxPlayerBlock",
  BoutMaxPlayerBlockPer = "BoutMaxPlayerBlockPer",
  SurplusBlock = "SurplusBlock",
  BoutMaxSwallow = "BoutMaxSwallow",
  BoutMaxJump = "BoutMaxJump",
  BoutMaxTentacleAttack = "BoutMaxTentacleAttack",
  TentacleAttackCount = "TentacleAttackCount",
  BoutMaxUseTypeCardCount = "BoutMaxUseTypeCardCount",
  BoutMaxUseCardCount = "BoutMaxUseCardCount",
  BoutMinUseCardCount = "BoutMinUseCardCount",
  BoutMaxDrawCardCount = "BoutMaxDrawCardCount",
  BoutMaxExtraDrawCardCount = "BoutMaxExtraDrawCardCount",
  BoutMaxEnergy = "BoutMaxEnergy",
  BoutMaxExtraEnergy = "BoutMaxExtraEnergy",
  BoutMaxKill = "BoutMaxKill",
  UseUltiSkillBoutCount = "UseUltiSkillBoutCount",
  UseUltiSkillMaxBoutCount = "UseUltiSkillMaxBoutCount",
  BoutDamagePer2Boss = "BoutDamagePer2Boss",
  BoutDamagePer2Elite = "BoutDamagePer2Elite",
  BoutDamagePer2Common = "BoutDamagePer2Common",
  StateLayerNum = "StateLayerNum",
  EnemyStateLayerNum = "EnemyStateLayerNum",
  TypeCardNumOnCopyEnd = "TypeCardNumOnCopyEnd",
  RelicOnCopyEnd = "RelicOnCopyEnd",
  BoutUseCardOrder = "BoutUseCardOrder",
  MaxStrength = "MaxStrength",
  MaxTentacleDamage = "MaxTentacleDamage",
  AwakerDoDamage = "AwakerDoDamage",
  AwakerDoHeal = "AwakerDoHeal",
  AwakerDoBlock = "AwakerDoBlock",
  AwakerHp = "AwakerHp",
  AwakerCmdCardUsedCount = "AwakerCmdCardUsedCount",
  AwakerConsumeEnergy = "AwakerConsumeEnergy",
  AwakerConsumeUltiEnergy = "AwakerConsumeUltiEnergy",
  NonCmdCardUsedCount = "NonCmdCardUsedCount",
  NonCmdConsumeEnergy = "NonCmdConsumeEnergy",
  ConsumeKeeperEnergy = "ConsumeKeeperEnergy",
  AutoAwakerCmdCardUsedCount = "AutoAwakerCmdCardUsedCount",
  AutoAwakerConsumeEnergy = "AutoAwakerConsumeEnergy",
  AutoAwakerConsumeUltiEnergy = "AutoAwakerConsumeUltiEnergy",
  AutoNonCmdCardUsedCount = "AutoNonCmdCardUsedCount",
  AutoNonCmdConsumeEnergy = "AutoNonCmdConsumeEnergy",
  AutoConsumeKeeperEnergy = "AutoConsumeKeeperEnergy"
}
bc.FavorStatsCmdCardTypes = {
  bc.SkillType.Card_Strike,
  bc.SkillType.Card_Defend,
  bc.SkillType.Card_Skill,
  bc.SkillType.Card_Awake
}
bc.RecordStageStatsKeys2OrmField = {
  [bc.StatsKey.AwakerDoDamage] = "AwakerDoDamage",
  [bc.StatsKey.AwakerDoHeal] = "AwakerDoHeal",
  [bc.StatsKey.AwakerDoBlock] = "AwakerDoBlock"
}

function bc.GetStateLayerKey(camp)
  if camp == bc.BattleCamp.Camp1 then
    return bc.StatsKey.StateLayerNum
  else
    return bc.StatsKey.EnemyStateLayerNum
  end
end

bc.MonsterClass2StatsDmgPer = {
  [bc.MonsterClass.Boss] = bc.StatsKey.BoutDamagePer2Boss,
  [bc.MonsterClass.Elite] = bc.StatsKey.BoutDamagePer2Elite,
  [bc.MonsterClass.Common] = bc.StatsKey.BoutDamagePer2Common
}
bc.CardType = {
  Attack = "Attack",
  Defense = "Defense",
  Ability = "Ability",
  Condition = "Condition",
  Skill = "Skill",
  Curse = "Curse",
  Potion = "Potion",
  All = "All"
}
bc.PotionType = {Cure = "Cure", Embryo = "Embryo"}
bc.CardFailedReason = {
  NotInHand = 1,
  Useless = 2,
  NoSkill = 3,
  LimitUse = 4,
  NoEnergy = 5,
  Dead = 6,
  NoActor = 7,
  NoAwaker = 8,
  CardFailedReason = 9,
  TargetNotMatch = 10
}
bc.UltiFailedReason = {
  NotAwaker = 1,
  NoTimes = 2,
  NoEnergy = 3,
  Coma = 4,
  Seal = 5,
  Dead = 6,
  TargetNotMatch = 7,
  NoSkill = 8
}
bc.ForceConsumeMode = {
  IgnoreCost = 1,
  PartialPay = 2,
  FullPay = 3
}
bc.PropertyOwnerType = {
  Awaker = "Awaker",
  Role = "Role",
  Card = "Card"
}
bc.SkillPerformType = {Spine = "动作", Timeline = "Timeline"}
bc.SkillPerformName = {
  Attack = "Attack",
  Defence = "Defence",
  Exalt = "Exalt",
  ExSkill = "ExSkill",
  Skill1 = "Skill1",
  Skill2 = "Skill2"
}
bc.BattleGuardType = {
  Start = "Start",
  StartStory = "StartStory",
  StartStoryDone = "StartStoryDone",
  LoadScene = "LoadScene",
  LoadSceneDone = "LoadSceneDone",
  EnterScene = "EnterScene",
  EntranceAnimationEnd = "EntranceAnimationEnd",
  MoveCardToHand = "MoveCardToHand",
  InsertCard = "InsertCard",
  BattleEnd = "BattleEnd",
  PlayedRecord = "PlayedRecord"
}
bc.AwakerProperty = {}
setmetatable(bc.AwakerProperty, {
  __index = function(_, propertyName)
    return propertyName
  end
})
bc.RoleProperty = {}
setmetatable(bc.RoleProperty, {
  __index = function(_, propertyName)
    return propertyName
  end
})
bc.CardProperty = {}
setmetatable(bc.CardProperty, {
  __index = function(_, propertyName)
    return propertyName
  end
})
bc.BattleProperty = {}
setmetatable(bc.BattleProperty, {
  __index = function(_, propertyName)
    return propertyName
  end
})
bc.StateLayerLimit = {
  posion = bc.RoleProperty.be_state_layer_limit_posion
}
bc.StateLayerLimitTotal = {
  posion = bc.RoleProperty.be_state_layer_limit_posion_max,
  retaliate = bc.RoleProperty.be_state_layer_limit_retaliate_max
}
bc.StateLayerStatics = {
  posion = bc.RoleProperty.be_state_layer_statics_posion
}
bc.PropertyImmueState = {
  weak = bc.RoleProperty.immue_state_weak,
  vulnerable = bc.RoleProperty.immue_state_vulnerable,
  posion = bc.RoleProperty.immue_state_posion,
  frail = bc.RoleProperty.immue_state_frail
}
bc.CardTargetChange = {
  [bc.SkillType.Card_Strike] = {
    select_enemy_alive_only = bc.AwakerProperty.strike_card_target2select_enemy_alive_only,
    select_random_enemy = bc.AwakerProperty.strike_card_target2select_random_enemy,
    select_all_enemy_alive_only = bc.AwakerProperty.strike_card_target2select_all_enemy_alive_only,
    max_hp_enemy = bc.AwakerProperty.strike_card_target2max_hp_enemy,
    min_hp_enemy = bc.AwakerProperty.strike_card_target2min_hp_enemy,
    rear_enemy = bc.AwakerProperty.strike_card_target2rear_enemy
  }
}
bc.DamagePer2HasState = {
  weak = bc.AwakerProperty.damage_per2enemy_has_weak,
  vulnerable = bc.AwakerProperty.damage_per2enemy_has_vulnerable,
  posion = bc.AwakerProperty.damage_per2enemy_has_posion,
  frail = bc.AwakerProperty.damage_per2enemy_has_frail,
  petrify_resist = bc.AwakerProperty.damage_per2petrify_resist,
  sculptor = bc.AwakerProperty.damage_per2enemy_has_sculptor,
  mutated = bc.AwakerProperty.damage_per2enemy_has_mutated,
  snow = bc.AwakerProperty.damage_per2enemy_has_snow,
  blood = bc.AwakerProperty.damage_per2enemy_has_blood
}
bc.DamagePer2MonsterType = {
  boss = bc.AwakerProperty.damage_per2monster_boss,
  elite = bc.AwakerProperty.damage_per2monster_elite,
  normal = bc.AwakerProperty.damage_per2monster_normal,
  grade1 = bc.AwakerProperty.damage_per2monster_grade1,
  grade2 = bc.AwakerProperty.damage_per2monster_grade2
}
bc.StateLayerPer = {
  i_power = bc.AwakerProperty.i_state_layer_per_power,
  o_power = bc.AwakerProperty.o_state_layer_per_power,
  o_power_bycmd = bc.AwakerProperty.o_state_layer_per_power_bycmd,
  i_counterattack = bc.AwakerProperty.i_state_layer_per_counterattack,
  counterattack = bc.AwakerProperty.state_layer_per_counterattack,
  i_exhaustion = bc.AwakerProperty.i_state_layer_per_exhaustion,
  i_posion = bc.AwakerProperty.i_state_layer_per_posion,
  posion = bc.AwakerProperty.state_layer_per_posion,
  bleed = bc.AwakerProperty.state_layer_per_bleeding,
  i_bleed = bc.AwakerProperty.i_state_layer_per_bleeding,
  o_tentacle_dmg = bc.AwakerProperty.o_state_layer_per_tentacle_dmg,
  basic_state_layer_per_corrosion = bc.AwakerProperty.basic_state_layer_per_corrosion
}
bc.UltiStateLayerPer = {
  awaker_ulti_state_layer_per_power = bc.AwakerProperty.awaker_ulti_state_layer_per_power,
  awaker_ulti_state_layer_per_counterattack = bc.AwakerProperty.awaker_ulti_state_layer_per_counterattack,
  awaker_ulti_state_layer_per_exhaustion = bc.AwakerProperty.awaker_ulti_state_layer_per_exhaustion,
  awaker_ulti_state_layer_per_poison = bc.AwakerProperty.awaker_ulti_state_layer_per_poison,
  awaker_ulti_state_layer_per_TentaclePower = bc.AwakerProperty.awaker_ulti_state_layer_per_TentaclePower
}
bc.CmdCardStateLayerPer = {
  awaker_CmdCard_state_layer_per_exhaustion = bc.AwakerProperty.awaker_CmdCard_state_layer_per_exhaustion,
  awaker_CmdCard_state_layer_per_power = bc.AwakerProperty.awaker_CmdCard_state_layer_per_power,
  awaker_CmdCard_state_layer_per_TentaclePower = bc.AwakerProperty.awaker_CmdCard_state_layer_per_TentaclePower,
  awaker_CmdCard_state_layer_per_poison = bc.AwakerProperty.awaker_CmdCard_state_layer_per_poison,
  awaker_CmdCard_state_layer_per_counterattack = bc.AwakerProperty.awaker_CmdCard_state_layer_per_counterattack
}
bc.StateLayerPerByCard = {
  card_state_layer_per_exhaustion = bc.CardProperty.card_state_layer_per_exhaustion,
  card_state_layer_per_power = bc.CardProperty.card_state_layer_per_power,
  card_state_layer_per_counterattack = bc.CardProperty.card_state_layer_per_counterattack,
  card_state_layer_per_TentaclePower = bc.CardProperty.card_state_layer_per_TentaclePower,
  card_state_layer_per_poison = bc.CardProperty.card_state_layer_per_poison
}
bc.UltiFixedStateLayerPer = {
  awaker_ulti_fixed_state_layer_per_poison = bc.AwakerProperty.awaker_ulti_fixed_state_layer_per_poison,
  awaker_ulti_fixed_state_layer_per_counterattack = bc.AwakerProperty.awaker_ulti_fixed_state_layer_per_counterattack,
  awaker_ulti_fixed_state_layer_per_fatecut = bc.AwakerProperty.awaker_ulti_fixed_state_layer_per_fatecut
}
bc.CmdCardFixedStateLayerPer = {
  awaker_CmdCard_fixed_state_layer_per_poison = bc.AwakerProperty.awaker_CmdCard_fixed_state_layer_per_poison,
  awaker_CmdCard_fixed_state_layer_per_counterattack = bc.AwakerProperty.awaker_CmdCard_fixed_state_layer_per_counterattack,
  awaker_CmdCard_fixed_state_layer_per_fatecut = bc.AwakerProperty.awaker_CmdCard_fixed_state_layer_per_fatecut
}
bc.CardFixedStateLayerPer = {
  card_fixed_state_layer_per_poison = bc.CardProperty.card_fixed_state_layer_per_poison,
  card_fixed_state_layer_per_counterattack = bc.CardProperty.card_fixed_state_layer_per_counterattack,
  card_fixed_state_layer_per_fatecut = bc.CardProperty.card_fixed_state_layer_per_fatecut
}
bc.CardStateLayerPerWithAwakerN2 = {
  card_state_layer_per_exhaustion = bc.AwakerProperty.card_state_layer_per_exhaustion_n2,
  card_state_layer_per_power = bc.AwakerProperty.card_state_layer_per_power_n2,
  card_state_layer_per_TentaclePower = bc.AwakerProperty.card_state_layer_per_TentaclePower_n2
}
bc.CardFixedStateLayerPerWithAwakerN2 = {
  card_fixed_state_layer_per_poison = bc.AwakerProperty.card_fixed_state_layer_per_poison_n2,
  card_fixed_state_layer_per_counterattack = bc.AwakerProperty.card_fixed_state_layer_per_counterattack_n2,
  card_fixed_state_layer_per_fatecut = bc.AwakerProperty.card_fixed_state_layer_per_fatecut_n2
}
bc.BeStateLayerPer = {
  exhaustion = bc.RoleProperty.be_state_layer_per_exhaustion,
  bloodHp = bc.RoleProperty.be_state_layer_per_bloodHp,
  posion = bc.RoleProperty.be_state_layer_per_posion,
  power = bc.RoleProperty.be_state_layer_per_power
}
bc.DirectCmdStateLayerPer = {
  posion = bc.AwakerProperty.fix_state_layer_per_posion
}
bc.BeDirectCmdStateLayerPer = {
  posion = bc.AwakerProperty.be_fix_state_layer_per_posion
}
bc.StateSpecialProperty = {
  [bc.BattleProperty.weak_per] = bc.BattleProperty.do_weak_per,
  [bc.BattleProperty.frail_per] = bc.BattleProperty.do_frail_per,
  [bc.BattleProperty.vulnerable_per] = bc.BattleProperty.do_vulnerable_per
}
bc.SkillType2InsideDamagePer = {
  [bc.SkillType.Card_Strike] = bc.BattleProperty.i_damage_per_strikecard,
  [bc.SkillType.Card_Skill] = bc.BattleProperty.i_damage_per_skillcard,
  [bc.SkillType.Ulti_Skill] = bc.BattleProperty.i_damage_per_ulti,
  [bc.SkillType.Card_AttachPost] = bc.BattleProperty.i_damage_per_attachpost
}
bc.SkillType2OutsideDamagePer = {
  [bc.SkillType.Card_Strike] = bc.BattleProperty.o_damage_per_strikecard,
  [bc.SkillType.Card_Skill] = bc.BattleProperty.o_damage_per_skillcard,
  [bc.SkillType.Ulti_Skill] = bc.BattleProperty.o_damage_per_ulti,
  [bc.SkillType.Card_AttachPost] = bc.BattleProperty.o_damage_per_attachpost
}
bc.SkillType2DamagePer = {
  [bc.SkillType.Card_Strike] = bc.BattleProperty.damage_per_strikecard,
  [bc.SkillType.Card_Skill] = bc.BattleProperty.damage_per_skillcard,
  [bc.SkillType.Ulti_Skill] = bc.BattleProperty.damage_per_ulti,
  [bc.SkillType.Card_AttachPost] = bc.BattleProperty.damage_per_attachpost
}
bc.SkillType2HealPer = {
  [bc.SkillType.Card_Skill] = {
    bc.BattleProperty.heal_per_skillcard
  },
  [bc.SkillType.Ulti_Skill] = {
    bc.BattleProperty.heal_per_ulti,
    bc.BattleProperty.o_heal_per_ulti
  }
}
bc.SkillType2InsideHealPer = {
  [bc.SkillType.Ulti_Skill] = bc.BattleProperty.i_heal_per_ulti
}
bc.SkillType2Crit = {
  [bc.SkillType.Card_Strike] = bc.BattleProperty.crit_per_from_strikecard,
  [bc.SkillType.Ulti_Skill] = bc.BattleProperty.crit_per_from_ulti
}
bc.SkillType2CritDamage = {
  [bc.SkillType.Card_Strike] = bc.BattleProperty.crit_damage_from_strikecard,
  [bc.SkillType.Ulti_Skill] = bc.BattleProperty.crit_damage_from_ulti
}
bc.PropertyOfCritAdd = {
  [bc.BattleProperty.crit] = true,
  [bc.BattleProperty.crit_per_from_ulti] = true,
  [bc.BattleProperty.crit_per_from_strikecard] = true,
  [bc.BattleProperty.card_crit] = true
}
bc.PropertyOfCritDamageAdd = {
  [bc.BattleProperty.crit_damage] = true,
  [bc.BattleProperty.card_crit_damage] = true,
  [bc.BattleProperty.crit_damage_from_strikecard] = true,
  [bc.BattleProperty.crit_damage_from_ulti] = true
}
bc.PropertyOfMasterPerAdd = {
  [bc.BattleProperty.occupation_master] = true
}
bc.AwakerFsmState = {
  Idle = 1,
  Attack = 2,
  BeHit = 3,
  Dead = 4
}
bc.BattleSpineEventEnum = {
  [bc.AwakerFsmState.Idle] = "Idle_1",
  [bc.AwakerFsmState.Attack] = "Attack",
  [bc.AwakerFsmState.BeHit] = "Hit",
  [bc.AwakerFsmState.Dead] = "Die"
}
bc.HitDelay = 0.15
bc.DamageFloatInterval = 0.15
bc.MaxBoutWaitingTime = 2
bc.ReviveConfirmDelay = 2
bc.TentacleFsmState = {
  Idle = 1,
  Attack = 2,
  Enhance = 3,
  Dead = 4
}
bc.CardType2Fix = {
  [bc.SkillType.Card_Strike] = bc.AwakerProperty.cost_fix_strikecard,
  [bc.SkillType.Card_Skill] = bc.AwakerProperty.cost_fix_skillcard,
  [bc.SkillType.Card_Awake] = bc.AwakerProperty.cost_fix_awakecard,
  [bc.SkillType.Card_Defend] = bc.AwakerProperty.cost_fix_defendcard
}
bc.CardFixedCostKeys = {
  bc.BattleProperty.card_fixed_cost0,
  bc.BattleProperty.card_fixed_cost1,
  bc.BattleProperty.card_fixed_cost2,
  bc.BattleProperty.card_fixed_cost3,
  bc.BattleProperty.card_fixed_cost4,
  bc.BattleProperty.card_fixed_cost5
}

function bc.GetActiveCardFixedCost(getPropertyFunc)
  for fixedCostIndex, propertyName in ipairs(bc.CardFixedCostKeys) do
    local switchValue = getPropertyFunc(propertyName)
    if switchValue and switchValue > 0 then
      return fixedCostIndex - 1
    end
  end
  return nil
end

function bc.IsCardFixedCostProperty(propertyName)
  for _, fixedCostKey in ipairs(bc.CardFixedCostKeys) do
    if fixedCostKey == propertyName then
      return true
    end
  end
  return false
end

function bc.IsCardCostAffectProperty(propertyName)
  if propertyName == bc.BattleProperty.card_cost then
    return true
  end
  do return bc.IsCardFixedCostProperty end
  return bc.IsCardFixedCostProperty, propertyName
end

bc.VariableCostMode = {
  None = 0,
  BurnAll = 1,
  Limit = 2
}
bc.VariableCostSentinel = -1
bc.SkillType2UltiPer = {
  [bc.SkillType.Card_Strike] = bc.AwakerProperty.ulti_per_strikecard,
  [bc.SkillType.Card_Skill] = bc.AwakerProperty.ulti_per_skillcard,
  [bc.SkillType.Ulti_Skill] = bc.AwakerProperty.ulti_per_ultiskill,
  [bc.SkillType.Card_Defend] = bc.AwakerProperty.ulti_per_defendcard
}
bc.SkillType2BlockPer = {
  [bc.SkillType.Card_Defend] = {
    bc.AwakerProperty.block_per_defendcard
  },
  [bc.SkillType.Card_Skill] = {
    bc.AwakerProperty.block_per_skillcard
  },
  [bc.SkillType.Ulti_Skill] = {
    bc.AwakerProperty.block_per_ulti,
    bc.AwakerProperty.o_block_per_ulti
  }
}
bc.SkillType2InsideBlockPer = {
  [bc.SkillType.Card_Defend] = bc.AwakerProperty.i_block_per_defendcard,
  [bc.SkillType.Card_Skill] = bc.AwakerProperty.i_block_per_skillcard,
  [bc.SkillType.Ulti_Skill] = bc.AwakerProperty.i_block_per_ulti
}
bc.SkillPhase = {
  Ready = 1,
  Before = 2,
  Cast = 3,
  After = 4,
  Finish = 5
}
bc.StateChange = {
  Add = "Add",
  Replace = "Replace",
  Delete = "Delete",
  ChangeLayer = "ChangeLayer"
}
bc.BaseIntention = {
  None = "None",
  Attack = "Attack",
  Debuff = "Debuff",
  Buff = "Buff",
  Defence = "Defence",
  Dizzy = "Dizzy",
  Unknow = "Unknow"
}
bc.BattleCamp = {
  None = 0,
  Camp1 = 1,
  Camp2 = 2,
  toString = function(self, val)
    if val == self.None then
      return "None"
    elseif val == self.Camp1 then
      return "Camp1"
    elseif val == self.Camp2 then
      return "Camp2"
    end
  end,
  GetEnemyCamp = function(self, camp)
    if camp == self.Camp1 then
      return self.Camp2
    elseif camp == self.Camp2 then
      return self.Camp1
    end
  end
}
bc.BattleGameplayType = {
  PVE = 1,
  PVP = 2,
  PVP_TRAIN = 3
}
bc.PVPGameplayType = {Match = 1, Friend = 2}
bc.BattleRecordPlayState = {
  Stop = 1,
  Play = 2,
  Pause = 3
}
bc.BattleRecordQueueType = {
  None = 0,
  OneCut = 1,
  UseCard = 2
}
bc.BattleAttrConst = {
  Energy = 5,
  DrawCardNum = 5,
  HandCardMax = 10,
  BlockMax = 999999,
  MaxKeeperEnergy = 1000
}
bc.BattleCardDeckPos = {
  TOP = "TOP",
  BOTTOM = "BOTTOM",
  RANDOM = "RANDOM",
  RANDOMENCHANT = "RANDOMENCHANT",
  RANDOMNOENCHANT = "RANDOMNOENCHANT",
  RANDOM_COSTNOT0 = "RANDOM_COSTNOT0",
  RANDOM_NOT_ENCHANT = "RANDOM_NOT_ENCHANT"
}

function bc.NumberToK(num)
  local _num = tonumber(num)
  if not _num then
    return num
  end
  _num = math.ceil(_num)
  if _num > 100000000000 then
    return _num // 1000000000 .. "B"
  elseif _num > 100000000 then
    return _num // 1000000 .. "M"
  elseif _num > 100000 then
    return _num // 1000 .. "K"
  end
  return _num
end

function bc.NumberToCompact(num)
  local _num = tonumber(num)
  if not _num then
    return num
  end
  _num = math.ceil(_num)
  if _num < 100000 then
    return _num
  end
  local units = {
    {1000, "K"},
    {1000000, "M"},
    {1000000000, "B"},
    {1000000000000, "T"}
  }
  for i = 1, #units do
    local value = _num // units[i][1]
    if value < 10000 then
      return value .. units[i][2]
    end
  end
  return _num // units[#units][1] .. units[#units][2]
end

bc.PropertyChangeReason = {
  Heal = 1,
  Damage = 2,
  AttrModify = 3,
  AttrSet = 4,
  DamageBlock = 5,
  DamageImmue = 6,
  DamageCrit = 7,
  BlockGain = 8,
  BlockLose = 9,
  BlockModify = 10,
  BlockReset = 11,
  HealCrit = 12
}
bc.BattleGMType = {
  NewHandCard = 1,
  BattleEnd = 2,
  CheckEnergy = 3,
  AttackAllEnermyToDie = 4,
  AttackAllEnermyToLive = 5,
  AddUtiEnergy = 6,
  ModifyHp = 7,
  PrintSnapShot = 8,
  AddKeeperEnergy = 9,
  SwitchTimer = 10,
  AddRelic = 11,
  RemoveRelic = 12,
  MoveAwaker = 13,
  ExeCmd = 14,
  RewindToBout = 15,
  SetAwakerAttr = 16,
  SetMonsterAttr = 17,
  SetHandCardAttr = 18,
  SetAwakerStateLayer = 19,
  SetMonsterStateLayer = 20,
  SetHandCardStateLayer = 21,
  PrintBattleStatPackDump = 22,
  SetPosRoleStateLayer = 23,
  SetPosRoleAttr = 24,
  SkipStuckEffect = 25
}
bc.DramaType = {Begin = 1, End = 2}
bc.EnemyType = {
  All = "All",
  Common = "Common",
  Elite = "Elite",
  Boss = "Boss"
}
bc.BattleCardMoveResult = {
  Sucess = 1,
  Failed = 2,
  Terminate = 3,
  NoCard = 4
}
bc.BattleType = {
  Common = "Common",
  Elite = "Elite",
  Boss = "Boss",
  PVP = "PVP",
  PVP_TRAIN = "PVP_TRAIN"
}
bc.BossPhase = {
  First = 1,
  Second = 2,
  Third = 3
}
bc.UltiEnergyPerSkill = 100
bc.KeeperEnergyPerSkill = bc.BattleAttrConst.MaxKeeperEnergy
bc.TargetSelectType = {
  Card = 1,
  Awaker = 2,
  KeeperSkill = 3,
  Relic = 4,
  CardDrop = 5,
  KeeperSkillDrop = 6
}
bc.ObjType = {
  TypeCard = "TypeCard",
  TypeAwaker = "TypeAwaker",
  TypeMonster = "TypeMonster",
  TypePlayer = "TypePlayer"
}
bc.PVPTargetTag = {
  AliveOnly = "AliveOnly",
  DeathOnly = "DeathOnly",
  DeadOrAlive = "DeadOrAlive",
  IncludeBlock = "IncludeBlock",
  NotIncludeBlock = "NotIncludeBlock",
  AllyAwaker = "AllyAwaker",
  EnemyAwaker = "EnemyAwaker"
}
bc.PVPTargetType = {
  SelectCmdCaster = "SelectCmdCaster",
  SelectFrontEnemy = "SelectFrontEnemy",
  SelectMaxHpEnemy = "SelectMaxHpEnemy",
  SelectMinHpEnemy = "SelectMinHpEnemy",
  SelectAlly = "SelectAlly",
  SelectEnemy = "SelectEnemy",
  SelectAwaker = "SelectAwaker",
  SelectRandomEnemy = "SelectRandomEnemy",
  SelectRandomAlly = "SelectRandomAlly",
  SelectAllAlly = "SelectAllAlly",
  SelectAllEnemy = "SelectAllEnemy",
  SelectAllOtherAwaker = "SelectAllOtherAwaker",
  SelectTarget = "SelectTarget"
}
bc.PVPTargetNum = {
  [bc.PVPTargetType.SelectCmdCaster] = 1,
  [bc.PVPTargetType.SelectFrontEnemy] = 1,
  [bc.PVPTargetType.SelectMaxHpEnemy] = 1,
  [bc.PVPTargetType.SelectMinHpEnemy] = 1,
  [bc.PVPTargetType.SelectAlly] = 1,
  [bc.PVPTargetType.SelectEnemy] = 1,
  [bc.PVPTargetType.SelectAwaker] = 1,
  [bc.PVPTargetType.SelectRandomEnemy] = 1,
  [bc.PVPTargetType.SelectRandomAlly] = 1,
  [bc.PVPTargetType.SelectAllAlly] = nil,
  [bc.PVPTargetType.SelectAllEnemy] = nil,
  [bc.PVPTargetType.SelectAllOtherAwaker] = 1,
  [bc.PVPTargetType.SelectTarget] = 1
}
bc.PerformTargetType = {
  Awaker = 1,
  Role = 2,
  Card = 3,
  Camp1FieldCenter = 4,
  Camp2FieldCenter = 5
}
bc.DamageType = {
  Active = 1,
  Passive = 2,
  Tentacle = 3,
  HpRemove = 4,
  Pure = 5,
  Fixed = 6
}
bc.BattleFactoryType = {
  BattleActorClient = "BattleActorClient",
  BattleSfx = "BattleSfx",
  BattleAwakerClient = "BattleAwakerClient"
}
bc.CameraAnimator = {
  BattleStart = "BattleStart",
  StartToPlayer = "StartToPlayer",
  StartToMonster = "StartToMonster",
  PlayerToMonster = "PlayerToMonster",
  PlayerShake01 = "PlayerShake01",
  PlayerShake02 = "PlayerShake02",
  MonsterShake01 = "MonsterShake01",
  MonsterShake02 = "MonsterShake02",
  MonsterToPlayer = "MonsterToPlayer"
}
bc.CameraShake = {
  Soft = 0,
  MiniShake = 1,
  MiddleShake = 2
}
bc.BattleSpineAnimEnum = {
  Idle = "Idle",
  Idle1 = "Idle_1",
  Idle2 = "Idle_2",
  Attack = "Attack",
  Buff = "Buff",
  Debuff = "Debuff",
  Hit = "Hit",
  Death = "Die",
  Showup = "Showup",
  MoveForward = "Move",
  MoveBack = "Back",
  Summon = "Summon"
}
bc.BattleSpineBoneEnum = {Body = "body"}
bc.TriggerValueType = {
  Times = "Times",
  Value = "Value",
  Args = "Args"
}
bc.RoleType = {
  Awaker = 1,
  Monster = 2,
  Player = 3
}
bc.SlotToAnimation = {
  Slot_Strike = "Attack",
  Slot_Defend = "Defence",
  Slot_Super = "Arrive",
  Slot_Awake = "Awake",
  Slot_Skill1 = "Skill1",
  Slot_Skill2 = "Skill2"
}
bc.SlotName = {
  Slot_Super = "Slot_Super",
  Slot_Strike = "Slot_Strike",
  Slot_Defend = "Slot_Defend",
  Slot_Awake = "Slot_Awake",
  Slot_Skill1 = "Slot_Skill1",
  Slot_Skill2 = "Slot_Skill2"
}
bc.SlotOrder = {
  Slot_Super = 1,
  Slot_Strike = 2,
  Slot_Defend = 3,
  Slot_Awake = 4,
  Slot_Skill1 = 5,
  Slot_Skill2 = 6,
  Slot_Extend1 = 7,
  Slot_Extend2 = 8,
  Slot_Extend3 = 9,
  Slot_Extend4 = 10,
  Slot_Extend5 = 11,
  Slot_Extend6 = 12,
  Slot_Extend7 = 13,
  Slot_Extend8 = 14,
  Slot_Extend9 = 15,
  Slot_Extend10 = 16,
  Slot_Extend11 = 17,
  Slot_Extend12 = 18,
  Slot_Extend13 = 19,
  Slot_Extend14 = 20,
  Slot_Extend15 = 21,
  Slot_Extend16 = 22,
  Slot_Extend17 = 23,
  Slot_Extend18 = 24,
  Slot_Extend19 = 25,
  Slot_Extend20 = 26,
  Slot_Extend21 = 27,
  Slot_Extend22 = 28,
  Slot_Extend23 = 29,
  Slot_Extend24 = 30,
  Slot_Extend25 = 31,
  Slot_Extend26 = 32,
  Slot_Extend27 = 33,
  Slot_Extend28 = 34,
  Slot_Extend29 = 35,
  Slot_Extend30 = 36,
  Slot_Extend31 = 37,
  Slot_Skill3 = 38
}
bc.TriggerChangeType = {None = 1, ActorId = 2}
bc.SwapActorDuration = 0.2
bc.ArriveAnimation = "ExSkill"
bc.ActorStepForwardDuration = 0.3
bc.ActorStepBackDuration = 0.3
bc.UtilPreDuration = 0.8
bc.DifferentAwakerOverlapDuration = 0.16
bc.BTNumChangeType = {
  Add = "Add",
  Sub = "Sub",
  All = "All"
}
bc.TriggerSwallowType = {None = "None", FromRole = "FromRole"}
bc.MonsterBodyWidth = {
  BodyWidth_Monster_Mini = "BodyWidth_Monster_Mini",
  BodyWidth_Monster_Middle = "BodyWidth_Monster_Middle",
  BodyWidth_Monster_Big = "BodyWidth_Monster_Big",
  BodyWidth_Monster_Huge = "BodyWidth_Monster_Huge"
}
bc.AffixClearTime = {
  Permanent = "Permanent",
  AfterUse = "AfterUse",
  Bout = "Bout",
  AfterBattle = "AfterBattle"
}
bc.AffixFrom = {
  InBattle = "InBattle",
  OutOfBattle = "OutOfBattle"
}
bc.AwakerStepForwardDuration = 0.25
bc.AwakerStepBackDuration = 0.25
bc.PreWithDrawDuration = 0.03333333333333333
bc.ICON_PATH_PERFIX = "Icon/Battle/"
bc.CardChangeType = {
  None = 0,
  KeepOrigin = 1,
  KeepNew = 2,
  Both = 3,
  KeepCurrentAndNew = 4,
  KeepOrigin_2 = 5,
  Both_2 = 6
}
bc.KeepStateFlags = {
  KeepNone = 0,
  KeepOriginExist = 1,
  KeepOriginExtral = 2,
  KeepOriginRune = 4,
  KeepNewExist = 8,
  KeepNewExtral = 16,
  KeepNewRune = 32,
  KeepOriginAll = 7,
  KeepNewAll = 56,
  KeepBothAll = 63,
  KeepOriginExcludeExist = 6,
  KeepNewExcludeExist = 48,
  KeepBothExcludeExist = 54
}
bc.CardChangeType2KeepStateFlags = {
  [bc.CardChangeType.None] = bc.KeepStateFlags.KeepNewExist | bc.KeepStateFlags.KeepNewRune,
  [bc.CardChangeType.KeepOrigin] = bc.KeepStateFlags.KeepOriginAll | bc.KeepStateFlags.KeepNewExist,
  [bc.CardChangeType.KeepNew] = bc.KeepStateFlags.KeepNewAll,
  [bc.CardChangeType.Both] = bc.KeepStateFlags.KeepOriginAll | bc.KeepStateFlags.KeepNewAll,
  [bc.CardChangeType.KeepCurrentAndNew] = bc.KeepStateFlags.KeepOriginAll | bc.KeepStateFlags.KeepNewAll,
  [bc.CardChangeType.KeepOrigin_2] = bc.KeepStateFlags.KeepOriginExcludeExist | bc.KeepStateFlags.KeepNewExist,
  [bc.CardChangeType.Both_2] = bc.KeepStateFlags.KeepOriginExcludeExist | bc.KeepStateFlags.KeepNewAll
}
bc.RuneKeepType = {
  None = 0,
  KeepOrigin = 1,
  KeepNew = 2,
  Both = 3
}
bc.CardEnternalType = {
  None = 0,
  Enternal_1 = 1,
  Enternal_2 = 2
}
bc.RevertType = {SavedOrigin = 0, KeepState = 1}
bc.AwakerVisible = {
  ShowAll = 0,
  HideEnemy = 1,
  HideFriend = 2,
  HideAll = 3
}
bc.BodySize = {
  Mini = "Mini",
  Middle = "Middle",
  Big = "Big",
  Huge = "Huge"
}
bc.BloodWidth = {
  Mini = 1,
  Middle = 2,
  Big = 3,
  Huge = 4
}
bc.BattleGameSpeedKey = "BATTLE_GAME_SPEED"
bc.ConfirmType = {Respawn = 1}
bc.ConfirmReason = {None = 0, BoutLimit = 1}
bc.CardCopyType = {
  Normal = 0,
  NoEnchant = 1,
  CopyOrigin = 2
}
bc.DispelType = {
  Debuff = 0,
  Buff = 1,
  Both = 2
}
bc.DispelPriority = {
  Random = 0,
  New = 1,
  Old = 2
}
bc.BuffType = {
  None = nil,
  Buff = "TRUE",
  Debuff = "FALSE"
}
bc.FloatingTextType = {
  Heal = "Heal",
  HealCrit = "HealCrit",
  Damage = "Damage",
  Block = "Block",
  Text = "Text",
  SlowText = "SlowText",
  DamageCrit = "DamageCrit",
  PositiveTextAndIcon = "PositiveTextAndIcon",
  NegativeTextAndIcon = "NegativeTextAndIcon",
  DamageRestrain = "DamageRestrain",
  DamageCritRestrain = "DamageCritRestrain",
  Skill = "Skill",
  UltiEnergy = "UltiEnergy",
  UltiEnergy2 = "UltiEnergy2",
  Shield_Break = "Shield_Break",
  Revive = "Revive",
  ShowTips = "ShowTips",
  BloodBall = "BloodBall"
}
bc.FloatRes = {
  [bc.FloatingTextType.Damage] = {
    prefab = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_Text_Normal_01.prefab",
    anim = "UI_Vx_Battle_Text_Normal_01",
    fastAnim = "UI_Vx_BattleCom_Text_Continue01",
    uiRes = "UI_Vx_Battle_Text_Normal_01Resource",
    dbgScale = 1
  },
  [bc.FloatingTextType.DamageCrit] = {
    prefab = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_Text_Crit_01.prefab",
    anim = "UI_Vx_Battle_Text_Crit_01",
    fastAnim = "UI_Vx_BattleCom_Text_Continue01",
    uiRes = "UI_Vx_Battle_Text_Crit_01Resource",
    dbgScale = 1
  },
  [bc.FloatingTextType.Block] = {
    prefab = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_Text_Defense.prefab",
    anim = "UI_Vx_Battle_Text_Defense",
    fastAnim = "UI_Vx_BattleCom_Text_Defense_Continue01",
    uiRes = "UI_Vx_Battle_Text_DefenseResource",
    dbgScale = 1
  },
  [bc.FloatingTextType.Text] = {
    prefab = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_Text_Defense.prefab",
    anim = "UI_Vx_Battle_Text_Parry01",
    uiRes = "UI_Vx_Battle_Text_DefenseResource"
  },
  [bc.FloatingTextType.SlowText] = {
    prefab = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Popup_Battle_Tips_Small.prefab",
    anim = "UI_Vx_Popup_Battle_Tips_Small",
    uiRes = "UI_Vx_Popup_Battle_Tips_SmallResource",
    dbgScale = 1
  },
  [bc.FloatingTextType.Heal] = {
    prefab = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_Text_Revert.prefab",
    anim = "UI_Vx_Battle_Text_Revert_01",
    uiRes = "UI_Vx_Battle_Text_RevertResource",
    dbgScale = 1
  },
  [bc.FloatingTextType.PositiveTextAndIcon] = {
    prefab = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Popup_Battle_Tips_Small.prefab",
    anim = "UI_Vx_Popup_Battle_Tips_Small",
    uiRes = "UI_Vx_Popup_Battle_Tips_SmallResource",
    dbgScale = 1
  },
  [bc.FloatingTextType.NegativeTextAndIcon] = {
    prefab = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Popup_Battle_Tips_Small.prefab",
    anim = "UI_Vx_Popup_Battle_Tips_Small",
    uiRes = "UI_Vx_Popup_Battle_Tips_SmallResource",
    dbgScale = 1
  },
  [bc.FloatingTextType.UltiEnergy] = {
    prefab = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_Text_UltiEnergy.prefab",
    anim = "UI_Vx_Battle_Text_UltiEnergy01",
    uiRes = "UI_Vx_Battle_Text_UltiEnergyResource",
    dbgScale = 1
  },
  [bc.FloatingTextType.UltiEnergy2] = {
    prefab = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_Text_UltiEnergy2.prefab",
    anim = "UI_Vx_Battle_Text_UltiEnergy01",
    uiRes = "UI_Vx_Battle_Text_UltiEnergy2Resource",
    dbgScale = 1
  },
  [bc.FloatingTextType.HealCrit] = {
    prefab = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_Text_Crit_01.prefab",
    anim = "UI_Vx_Battle_Text_Crit_01",
    fastAnim = "UI_Vx_BattleCom_Text_Continue01",
    uiRes = "UI_Vx_Battle_Text_Crit_01Resource",
    dbgScale = 1
  },
  [bc.FloatingTextType.BloodBall] = {
    prefab = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_Text_UltiEnergyBlood.prefab",
    anim = "UI_Vx_Battle_Text_UltiEnergy01",
    uiRes = "UI_Vx_Battle_Text_UltiEnergyResource",
    dbgScale = 1
  }
}
bc.YIELD_FLAG = "yield"
bc.BREAKTHROUGH_AND_POTENCY_CONST = 1000
bc.MonsterSkillChangeType = {
  Substitute = 0,
  Insert = 1,
  ReplaceNext = 2
}
bc.DamageSubType = {Normal = 0, Puncture = 1}
bc.DamageSubTypeMatch = {
  [bc.DamageSubType.Normal] = true,
  [bc.DamageSubType.Puncture] = true
}
bc.GetCardByIDType = {
  CastSkillLevel = "CastSkillLevel",
  SlotCardLevel = "SlotCardLevel"
}
bc.TentacleNameConvert = {
  [bc.BattleProperty.tentacle_count] = bc.BattleProperty.tentacle_count,
  [bc.BattleProperty.permanent_tentacle_count] = bc.BattleProperty.tentacle_count,
  [bc.BattleProperty.bout_tentacle_count] = bc.BattleProperty.tentacle_count,
  [bc.BattleProperty.battle_tentacle_count] = bc.BattleProperty.tentacle_count,
  [bc.BattleProperty.max_tentacle_count] = bc.BattleProperty.max_tentacle_count,
  [bc.BattleProperty.bout_max_tentacle_count] = bc.BattleProperty.max_tentacle_count,
  [bc.BattleProperty.battle_max_tentacle_count] = bc.BattleProperty.max_tentacle_count,
  [bc.BattleProperty.permanent_max_tentacle_count] = bc.BattleProperty.max_tentacle_count
}
bc.TentacleFrontPrefab = "TimelineRoot/ScenesAnimation/Tentacle/Tentacle_Front/Tentacle_Front.prefab"
bc.TentacleTimelineLittle = "TimelineRoot/ScenesAnimation/Tentacle/Tentacle_Attack01.prefab"
bc.TentacleTimelineMass = "TimelineRoot/ScenesAnimation/Tentacle/Tentacle_Attack02.prefab"
bc.TentacleTimelineAoe = "TimelineRoot/ScenesAnimation/Tentacle/Tentacle_Aoe.prefab"
bc.TombstonePrefab = "TimelineRoot/ScenesAnimation/Tombstone/Tombstone_spine/Tombstone.prefab"
bc.TombstoneTimeline = "TimelineRoot/ScenesAnimation/Tombstone/Tombstone_MarchIn.prefab"
bc.DeathEffectPrefab = "Effects/PEffects/Prefab/Common/PE_Co_Death.prefab"
bc.PVPRoleUIRootPrefab = "UI/UI_Battle/UI_Battle_Prefab/Func_Battle_Monster_UIRoot_Middle.prefab"
bc.ActionType = {
  MonsterAction = 1,
  UseCard = 2,
  UseUlti = 3,
  UseKeeperSkill = 4,
  UseSilverKeyAwake = 5
}
bc.CardArgsSyncDeck = {
  [bc.CardDeck.DrawDeck] = true,
  [bc.CardDeck.GraveyardDeck] = true,
  [bc.CardDeck.HandDeck] = true,
  [bc.CardDeck.DimensionDeck] = true,
  [bc.CardDeck.MonsterDimensionDeck] = true,
  [bc.CardDeck.HideDeck] = true,
  [bc.CardDeck.BrainDeck] = true,
  [bc.CardDeck.AwakeDeck] = true
}
bc.CardArgsSyncDeckPVP = {
  [bc.CardDeck.DrawDeck] = true,
  [bc.CardDeck.HandDeck] = true
}
bc.CardDeckApi = {
  DrawDeckAndGraveyardDeck = "DrawDeckAndGraveyardDeck",
  EnemyDrawDeckAndGraveyardDeck = "EnemyDrawDeckAndGraveyardDeck",
  EnemyNoneDeck = "EnemyNoneDeck",
  EnemyDrawDeck = "EnemyDrawDeck",
  EnemyHandDeck = "EnemyHandDeck",
  EnemyGraveyardDeck = "EnemyGraveyardDeck",
  EnemyConsumedDeck = "EnemyConsumedDeck",
  EnemyUsingDeck = "EnemyUsingDeck",
  EnemyAwakeDeck = "EnemyAwakeDeck",
  EnemySwallowDeck = "EnemySwallowDeck",
  EnemyDimensionDeck = "EnemyDimensionDeck"
}
bc.StateDeathHandling = {
  NonWipe_ProhibitTrigger = "NonWipe_ProhibitTrigger",
  NonWipe_AllowTrigger = "NonWipe_AllowTrigger",
  Wipe = "Wipe"
}
bc.StateTriggerType = {
  Life = "Life",
  Layer = "Layer",
  Effect = "Effect"
}
bc.TargetPosDir = {
  Forward = "Forward",
  Backward = "Backward",
  Motionless = "Motionless"
}
bc.TentacleChangeType = {
  Bout = 1,
  Battle = 2,
  Copy = 3
}
bc.ChangeType2PropertyName = {
  [bc.TentacleChangeType.Bout] = bc.BattleProperty.bout_tentacle_count,
  [bc.TentacleChangeType.Battle] = bc.BattleProperty.battle_tentacle_count,
  [bc.TentacleChangeType.Copy] = bc.BattleProperty.permanent_tentacle_count
}
bc.PVPTimeoutTimesLimit = 2
bc.BattleEndType = {
  Normal = 0,
  GiveUp = 1,
  Other = 2,
  BoutLimit = 3
}
bc.ServerBattleBoutLimit = 100
bc.PVP_FORCE_TIMEOUT = 1800
bc.HistoryType = {Origin = 1, Copy = 2}
bc.KeeperSkillChangeType = {
  Temp = 0,
  Battle = 1,
  Permanent = 2,
  Bout = 3
}
bc.OceanModel = {
  OceanModel1 = "OceanModel1",
  OceanModel2 = "OceanModel2",
  OceanModel3 = "OceanModel3"
}
bc.CardListSortType = {
  HandDeckSort = "HandDeckSort",
  UnorderedSort = "UnorderedSort",
  CreatetimeSort = "CreatetimeSort"
}
bc.CardListSortOrder = {
  PositiveSort = "PositiveSort",
  ReverseSort = "ReverseSort"
}
bc.GlobalVariableAffix = "__GlobalVariable"
bc.BoutBloodSkillMaxTimes = 1
bc.BanPVPWeaponAction = {Ban = 1, Release = 2}
bc.ComparisonOperator = {
  LT = "lt",
  GT = "gt",
  LTE = "lte",
  GTE = "gte",
  EQ = "eq",
  NE = "ne"
}
bc.TimelineRunType = {Caster = 1, Target = 2}
bc.PVPTargetModel = {Client = 1, Server = 2}
bc.SourceType = {Relic = "Relic"}
bc.RelicLife = {Battle = "Battle"}
bc.MoneyChangeSource = {
  InBattle = 1,
  BattleEnd = 2,
  InWorld = 3
}
bc.FormulaSubType = {
  All = 1,
  OnlyIncludeSelf = 2,
  OnlyIncludeTarget = 3
}
bc.SetOpsType = {
  Union = 1,
  Intersection = 2,
  Difference = 3,
  SymmetricDifference = 4
}
bc.TeamUniqueStateProperty = {
  [bc.BattleProperty.taunt] = true,
  [bc.BattleProperty.sneak] = true
}
bc.CardTypeInstruction = {
  bc.SkillType.Card_Skill,
  bc.SkillType.Card_Strike,
  bc.SkillType.Card_Defend,
  bc.SkillType.Card_Extend
}
bc.reviewPageSize = 300
bc.reviewBoutLimit = 25
bc.ThreatVisualDamageType = {PlayerState = -2, MonsterTentacle = -1}

function bc.has_loop_reference(t)
  local visited = {}
  
  local function check(t, path)
    if type(t) ~= "table" then
      return false, nil
    end
    if t.__name then
      return true, path .. " -> " .. t.__name
    end
    if visited[t] then
      return true, path
    end
    if getmetatable(t) ~= nil then
      visited[t] = true
    end
    for k, v in pairs(t) do
      local ret, retPath = check(v, path .. "." .. k)
      if ret then
        return ret, retPath
      end
    end
    return false
  end
  
  do return check, t end
  return check, t, ""
end

bc.SkillCondListField = {
  CmdList = true,
  CmdTarget = true,
  Desc = true,
  BattleDesc = true,
  Name = true
}
bc.SkillFormatCondListField = {ExistState = true}
bc.RecordActionStats_Battle = {
  ValueCategory = {Battle = "战斗"},
  ValueSubCategory = {
    Damage = "伤害",
    Shield = "护盾",
    Heal = "治疗"
  },
  CsvHeader = {
    "bout|回合数",
    "actionIndex|操作编号",
    "version|版本",
    "preVersion|上一回合版本",
    "caster|根归属",
    "target|目标",
    "action|操作",
    "actionName|操作名称",
    "concept|概念大类",
    "conceptSub|概念小类",
    "effect|数值大类",
    "effectSub|数值小类",
    "value|统计值"
  },
  SourceType = {
    Skill = "skill",
    State = "state",
    UtilSkill = "utilSkill"
  },
  StatMainType = {
    BattleValue = "battleValue"
  }
}
return bc
