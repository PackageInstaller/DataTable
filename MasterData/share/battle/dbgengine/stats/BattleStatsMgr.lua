local System = require("System.System")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleActionStatsUtil = require("Battle.DbgEngine.Stats.BattleActionStatsUtil")
local BattleStatPackMgr = require("Battle.DbgEngine.Stats.BattleStatPackMgr")
local BattleFavorStatsMgr = require("Battle.DbgEngine.Stats.BattleFavorStatsMgr")
local BattleStatsMgr, Super = System.NewClass("BattleStatsMgr", BattleEngineComponent)

function BattleStatsMgr:ctor(battleEngine, svrGlobalStats)
  Super.ctor(self, battleEngine)
  self.globalStats = {}
  self.battleStats = {}
  self.curBoutStats = {}
  self.lastBoutStats = {}
  self.battleStatPackMgr = BattleStatPackMgr(battleEngine)
  if svrGlobalStats and type(svrGlobalStats) == "table" then
    self.globalStats = table.deepclone(svrGlobalStats)
  end
  self.strengthStatTids = {}
  self:InitTypeToStats()
  self.favorStatsMgr = BattleFavorStatsMgr(battleEngine, self)
  self.favorStatsMgr:RegisterCallbacks()
end

function BattleStatsMgr:InitTypeToStats()
  self.typeToStats = {
    BattleStats = self.battleStats,
    CurBoutStats = self.curBoutStats,
    LastBoutStats = self.lastBoutStats,
    GlobalStats = self.globalStats
  }
end

function BattleStatsMgr:UnregisterCallbacks()
  Super.UnregisterCallbacks(self)
  if self.favorStatsMgr then
    self.favorStatsMgr:UnregisterCallbacks()
  end
end

function BattleStatsMgr:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.LaunchJump, self.OnLaunchJump, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.TentacleAttack, self.OnTentacleAttack, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBeforeBoutBegin, self.OnBFBeforeBoutBegin, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBattleEnd, self.OnBFBeforeBattleEnd, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFBeforeBoutEnd, self.OnBFBeforeBoutEnd, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.ConsumeEnergy, self.OnConsumeEnergy, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardDeckChange, self.OnCardDeckChanged, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFAfterDiscardCards, self.OnAfterDiscardCards, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.CardOnDraw, self.OnCardOnDraw, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterUseCard, self.OnAfterUseCard, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterUseUltiSkill, self.OnAfterUseUltiSkill, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.ConsumeScarletBlood, self.OnConsumeScarletBlood, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.DoDamage, self.OnDoDamage, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.DoTentacleDamage, self.OnDoDamage, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.DoHeal, self.OnDoHeal, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.DoBlock, self.OnDoBlock, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BEChangeAttrHp, self.OnBEChangeAttrHp, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BEChangeAttrBlock, self.OnBEChangeAttrBlock, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.RoleAfterDeathResist, self.OnDeathResist, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.RoleAfterDeath, self.OnRoleDeath, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.ShuffleCards, self.OnShuffleCards, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.GainEnergy, self.OnGainEnergy, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.FightBackKill, self.OnFightBackKill, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.CritKill, self.OnCritKill, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.StateOnAdd, self.OnStateOnAdd, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BlockChange, self.OnBlockChange, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.AfterUseKeeperSkill, self.OnAfterUseKeeperSkill, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.OceanModeChange, self.OnOceanModeChange, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.ModifyHp, self.OnModifyHp, self)
end

function BattleStatsMgr:OnCalcRelicDescData()
  local battleCmdParser = require("Battle.DbgEngine.Cmd.BattleCmdParser")(self.battleEngine, {})
  local relicList = self.battleEngine:GetRelicList()
  for _, v in pairs(relicList or {}) do
    local descArgs = {}
    if v.isCalcDescArgs then
      local cfg = self.battleEngine.battleDT("RelicConfig")
      if cfg and cfg.StatePara and #cfg.StatePara > 0 then
        for i, str in pairs(cfg.StatePara) do
          descArgs[i] = battleCmdParser:GetValueByCmd(str)
        end
      end
    end
    if #descArgs > 0 then
      self.battleEngine:WorldRpc("Relic", "SyncRelicDataByInBattle", v.tid, descArgs)
    end
  end
end

function BattleStatsMgr:GetBattleFinishStats(winCamp)
  self.battleStats[bc.StatsKey.BattleResult] = winCamp
  local GlobalStats = table.deepclone(self.globalStats)
  local BattleStats = table.deepclone(self.battleStats)
  BattleStats.BattleStatPack = self.battleStatPackMgr:GetBattleStatPackCompressedString()
  return {GlobalStats = GlobalStats, BattleStats = BattleStats}
end

function BattleStatsMgr:Serialize()
  return {
    globalStats = self.globalStats,
    battleStats = self.battleStats,
    curBoutStats = self.curBoutStats,
    lastBoutStats = self.lastBoutStats,
    strengthStatTids = self.strengthStatTids,
    battleStatPackMgr = self.battleStatPackMgr:Serialize()
  }
end

function BattleStatsMgr:OnSnapShot()
  return {
    globalStats = self.globalStats,
    battleStats = self.battleStats,
    curBoutStats = self.curBoutStats,
    lastBoutStats = self.lastBoutStats,
    strengthStatTids = self.strengthStatTids,
    battleStatPackMgr = self.battleStatPackMgr:Serialize()
  }
end

function BattleStatsMgr:OnRecover(statsData)
  self.globalStats = statsData.globalStats or {}
  self.battleStats = statsData.battleStats or {}
  self.curBoutStats = statsData.curBoutStats or {}
  self.lastBoutStats = statsData.lastBoutStats or {}
  self.strengthStatTids = statsData.strengthStatTids or {}
  self.battleStatPackMgr:OnRecover(statsData.battleStatPackMgr or {})
  self:InitTypeToStats()
end

function BattleStatsMgr:GetBattleStats(key)
  return self.battleStats[key]
end

function BattleStatsMgr:GetCurBoutStats(key)
  return self.curBoutStats[key]
end

local function addDimensionBoutToStats(stats)
  local value = stats[bc.StatsKey.DimensionBoutCount] or 0
  value = value + 1
  stats[bc.StatsKey.DimensionBoutCount] = value
end

local function addBoutToStats(stats)
  local value = stats[bc.StatsKey.BoutCount] or 0
  value = value + 1
  stats[bc.StatsKey.BoutCount] = value
end

function BattleStatsMgr:OnBFBeforeBoutBegin(isExtraBout)
  local boutMgr = self.battleEngine.boutMgr
  local curCamp = boutMgr:GetCurCamp()
  if curCamp == bc.BattleCamp.Camp1 then
    if isExtraBout then
      addDimensionBoutToStats(self.globalStats)
      addDimensionBoutToStats(self.battleStats)
    else
      addBoutToStats(self.globalStats)
      addBoutToStats(self.battleStats)
    end
    self.lastBoutStats = self.curBoutStats
    self.curBoutStats = {}
    self.typeToStats.LastBoutStats = self.lastBoutStats
    self.typeToStats.CurBoutStats = self.curBoutStats
    local player = self.battleEngine.roleMgr:GetPlayer()
    self:StatMaxTentacleDamage(player)
  end
end

function BattleStatsMgr:OnBFBeforeBattleEnd()
  local boutMgr = self.battleEngine.boutMgr
  local isExtraBout = boutMgr:GetIsExtraBout()
  self:__CalcBoutMaxStats(isExtraBout)
end

function BattleStatsMgr:OnBFBeforeBoutEnd()
  local function statBoutUseCardCount(stats, count)
    local key = bc.StatsKey.BoutMaxUseCardCount
    
    if not stats[key] or count > stats[key] then
      stats[key] = count
    end
    key = bc.StatsKey.BoutMinUseCardCount
    if not stats[key] or count < stats[key] then
      stats[key] = count
    end
  end
  
  local boutMgr = self.battleEngine.boutMgr
  local curCamp = boutMgr:GetCurCamp()
  if curCamp == bc.BattleCamp.Camp1 then
    statBoutUseCardCount(self.globalStats, self.curBoutStats[bc.StatsKey.UsedCardCount] or 0)
    statBoutUseCardCount(self.battleStats, self.curBoutStats[bc.StatsKey.UsedCardCount] or 0)
  end
  local isExtraBout = boutMgr:GetIsExtraBout()
  self:__CalcBoutMaxStats(isExtraBout)
end

function BattleStatsMgr:__CalcBoutMaxStats(isExtraBout)
  local boutMgr = self.battleEngine.boutMgr
  local curCamp = boutMgr:GetCurCamp()
  if curCamp == bc.BattleCamp.Camp1 and not isExtraBout then
    local player = self.battleEngine.roleMgr:GetPlayer(curCamp)
    local awakerList = player:GetAwakerList()
    local totalTimes = 0
    for _, awaker in pairs(awakerList) do
      totalTimes = totalTimes + awaker:GetData("boutSkillTimes")
    end
    local battleStats = self.battleStats
    local globalStats = self.globalStats
    if 0 == totalTimes then
      battleStats[bc.StatsKey.UseUltiSkillBoutCount] = 0
    else
      battleStats[bc.StatsKey.UseUltiSkillBoutCount] = (battleStats[bc.StatsKey.UseUltiSkillBoutCount] or 0) + 1
    end
    local boutCount = battleStats[bc.StatsKey.UseUltiSkillBoutCount]
    if boutCount > (battleStats[bc.StatsKey.UseUltiSkillMaxBoutCount] or 0) then
      battleStats[bc.StatsKey.UseUltiSkillMaxBoutCount] = boutCount
    end
    if boutCount > (globalStats[bc.StatsKey.UseUltiSkillMaxBoutCount] or 0) then
      globalStats[bc.StatsKey.UseUltiSkillMaxBoutCount] = boutCount
    end
  end
end

local function addEnergyToStats(stats, e)
  local value = stats[bc.StatsKey.ConsumeEnergy] or 0
  value = value + e
  stats[bc.StatsKey.ConsumeEnergy] = value
end

function BattleStatsMgr:OnConsumeEnergy(eventData)
  local energy = eventData.realCost
  addEnergyToStats(self.globalStats, energy)
  addEnergyToStats(self.battleStats, energy)
  addEnergyToStats(self.curBoutStats, energy)
  local battleMax = self.battleStats[bc.StatsKey.BoutMaxConsumeEnergy] or 0
  if battleMax < self.curBoutStats[bc.StatsKey.ConsumeEnergy] then
    self.battleStats[bc.StatsKey.BoutMaxConsumeEnergy] = self.curBoutStats[bc.StatsKey.ConsumeEnergy]
  end
  local globalMax = self.globalStats[bc.StatsKey.BoutMaxConsumeEnergy] or 0
  if globalMax < self.curBoutStats[bc.StatsKey.ConsumeEnergy] then
    self.globalStats[bc.StatsKey.BoutMaxConsumeEnergy] = self.curBoutStats[bc.StatsKey.ConsumeEnergy]
  end
end

function BattleStatsMgr:OnGainEnergy(eventData)
  local function changeMaxEnergy(stats)
    local max = stats[bc.StatsKey.BoutMaxEnergy] or 0
    
    if max < eventData.curValue then
      stats[bc.StatsKey.BoutMaxEnergy] = eventData.curValue
    end
  end
  
  changeMaxEnergy(self.globalStats)
  changeMaxEnergy(self.battleStats)
  local maxExtra = self.curBoutStats[bc.StatsKey.BoutMaxExtraEnergy] or 0
  if not eventData.isBoutBegin then
    self.curBoutStats[bc.StatsKey.BoutMaxExtraEnergy] = maxExtra + eventData.castValue
    for _, stats in ipairs({
      self.globalStats,
      self.battleStats
    }) do
      if not stats[bc.StatsKey.BoutMaxExtraEnergy] or stats[bc.StatsKey.BoutMaxExtraEnergy] < self.curBoutStats[bc.StatsKey.BoutMaxExtraEnergy] then
        stats[bc.StatsKey.BoutMaxExtraEnergy] = self.curBoutStats[bc.StatsKey.BoutMaxExtraEnergy]
      end
    end
  end
end

function BattleStatsMgr:OnFightBackKill()
  self.battleStats[bc.StatsKey.BattleFightBackKill] = (self.battleStats[bc.StatsKey.BattleFightBackKill] or 0) + 1
end

function BattleStatsMgr:OnCritKill()
  self.battleStats[bc.StatsKey.CritKill] = (self.battleStats[bc.StatsKey.CritKill] or 0) + 1
end

function BattleStatsMgr:OnStateOnAdd(eventData)
  local stateType = eventData.createArgs.stateType
  if stateType ~= bc.StateType.Role then
    return
  end
  local stateId = eventData.createArgs.stateId
  local state = self.battleEngine:GetObj(eventData.stateUid)
  if not state then
    self.battleEngine:Error("状态施加时统计有误，找不到状态", eventData.stateUid)
    return
  end
  local statKey = bc.GetStateLayerKey(state.owner.camp)
  if not self.battleStats[statKey] then
    self.battleStats[statKey] = {}
  end
  self.battleStats[statKey][stateId] = math.max(self.battleStats[statKey][stateId] or 0, state.data.layer)
  if not self.globalStats[statKey] then
    self.globalStats[statKey] = {}
  end
  self.globalStats[statKey][stateId] = math.max(self.globalStats[statKey][stateId] or 0, state.data.layer)
  local player = self.battleEngine.roleMgr:GetPlayer(state.owner.camp)
  if player then
    self:StatMaxStrength(player, stateId)
    self:StatMaxTentacleDamage(player)
  end
end

local function addDrawCardToStats(stats)
  stats[bc.StatsKey.DrawCardCount] = (stats[bc.StatsKey.DrawCardCount] or 0) + 1
end

local function changeMaxDraw(stats, curCount)
  if not stats[bc.StatsKey.BoutMaxDrawCardCount] or curCount > stats[bc.StatsKey.BoutMaxDrawCardCount] then
    stats[bc.StatsKey.BoutMaxDrawCardCount] = curCount
  end
end

local function addDiscardCardToStats(stats, data)
  stats[bc.StatsKey.DiscardedCardCount] = (stats[bc.StatsKey.DiscardedCardCount] or 0) + 1
end

local function addSwallowCardToStats(stats, data)
  stats[bc.StatsKey.SwallowedCardCount] = (stats[bc.StatsKey.SwallowedCardCount] or 0) + 1
end

function BattleStatsMgr:OnCardDeckChanged(data)
  if data.oldDeck == bc.CardDeck.HandDeck and data.newDeck == bc.CardDeck.GraveyardDeck then
    addDiscardCardToStats(self.globalStats, data)
    addDiscardCardToStats(self.battleStats, data)
    addDiscardCardToStats(self.curBoutStats, data)
  end
  if data.oldDeck ~= bc.CardDeck.DrawDeck and data.newDeck == bc.CardDeck.HandDeck then
    if not self.globalStats[bc.StatsKey.GainCardCount] then
      self.globalStats[bc.StatsKey.GainCardCount] = {}
    end
    local globalCardCount = self.globalStats[bc.StatsKey.GainCardCount]
    local card = self.battleEngine:GetObj(data.cardUid)
    if card then
      globalCardCount[card.tid] = (globalCardCount[card.tid] or 0) + 1
    end
    addDrawCardToStats(self.globalStats)
    addDrawCardToStats(self.battleStats)
    addDrawCardToStats(self.curBoutStats)
    changeMaxDraw(self.globalStats, self.curBoutStats[bc.StatsKey.DrawCardCount] or 0)
    changeMaxDraw(self.battleStats, self.curBoutStats[bc.StatsKey.DrawCardCount] or 0)
    for _, stats in ipairs({
      self.globalStats,
      self.battleStats,
      self.curBoutStats
    }) do
      stats[bc.StatsKey.ExtraDrawCardCount] = (stats[bc.StatsKey.ExtraDrawCardCount] or 0) + 1
    end
    local curExtraCount = self.curBoutStats[bc.StatsKey.ExtraDrawCardCount] or 0
    for _, stats in ipairs({
      self.globalStats,
      self.battleStats
    }) do
      if not stats[bc.StatsKey.BoutMaxExtraDrawCardCount] or curExtraCount > stats[bc.StatsKey.BoutMaxExtraDrawCardCount] then
        stats[bc.StatsKey.BoutMaxExtraDrawCardCount] = curExtraCount
      end
    end
  end
  if data.newDeck == bc.CardDeck.SwallowDeck then
    addSwallowCardToStats(self.globalStats, data)
    addSwallowCardToStats(self.battleStats, data)
    addSwallowCardToStats(self.curBoutStats, data)
    local curBoutMaxSwallow = self.battleStats[bc.StatsKey.BoutMaxSwallow] or 0
    if curBoutMaxSwallow < self.curBoutStats[bc.StatsKey.SwallowedCardCount] then
      self.battleStats[bc.StatsKey.BoutMaxSwallow] = self.curBoutStats[bc.StatsKey.SwallowedCardCount]
    end
  end
end

local function addStatsDiscardCards(stats, discardCount)
  stats[bc.StatsKey.EndBoutDiscardCount] = (stats[bc.StatsKey.EndBoutDiscardCount] or 0) + discardCount
end

function BattleStatsMgr:OnAfterDiscardCards()
  local discardCount = self.battleEngine.cardMgr.discardCount or 0
  addStatsDiscardCards(self.globalStats, discardCount)
  addStatsDiscardCards(self.battleStats, discardCount)
  addStatsDiscardCards(self.curBoutStats, discardCount)
end

function BattleStatsMgr:OnCardOnDraw(data)
  addDrawCardToStats(self.globalStats)
  addDrawCardToStats(self.battleStats)
  addDrawCardToStats(self.curBoutStats)
  changeMaxDraw(self.globalStats, self.curBoutStats[bc.StatsKey.DrawCardCount])
  changeMaxDraw(self.battleStats, self.curBoutStats[bc.StatsKey.DrawCardCount])
  if data.changeReason ~= bc.CardDeckReason.Draw then
    for _, stats in ipairs({
      self.globalStats,
      self.battleStats,
      self.curBoutStats
    }) do
      stats[bc.StatsKey.ExtraDrawCardCount] = (stats[bc.StatsKey.ExtraDrawCardCount] or 0) + 1
    end
    local curCount = self.curBoutStats[bc.StatsKey.ExtraDrawCardCount]
    for _, stats in ipairs({
      self.globalStats,
      self.battleStats
    }) do
      if not stats[bc.StatsKey.BoutMaxExtraDrawCardCount] or curCount > stats[bc.StatsKey.BoutMaxExtraDrawCardCount] then
        stats[bc.StatsKey.BoutMaxExtraDrawCardCount] = curCount
      end
    end
  end
end

local function addCardToStats(stats, card)
  local isCmdCard = false
  if card:CardTypeMatch(bc.SkillType.Card_Strike) then
    stats[bc.StatsKey.StrikeCardUsedCount] = (stats[bc.StatsKey.StrikeCardUsedCount] or 0) + 1
    isCmdCard = true
  end
  if card:CardTypeMatch(bc.SkillType.Card_Defend) then
    stats[bc.StatsKey.DefenceCardUsedCount] = (stats[bc.StatsKey.DefenceCardUsedCount] or 0) + 1
    isCmdCard = true
  end
  if card:CardTypeMatch(bc.SkillType.Card_Skill) then
    stats[bc.StatsKey.SkillCardUsedCount] = (stats[bc.StatsKey.SkillCardUsedCount] or 0) + 1
    isCmdCard = true
  end
  if card:CardTypeMatch(bc.SkillType.Card_Awake) then
    stats[bc.StatsKey.AwakeCardUsedCount] = (stats[bc.StatsKey.AwakeCardUsedCount] or 0) + 1
    isCmdCard = true
  end
  if card:CardTypeMatch(bc.SkillType.Card_Extend) then
    isCmdCard = true
  end
  if card:CardTypeMatch(bc.SkillType.Card_Curse) then
    stats[bc.StatsKey.CurseCardUsedCount] = (stats[bc.StatsKey.CurseCardUsedCount] or 0) + 1
  end
  if card:CardTypeMatch(bc.SkillType.Card_State) then
    stats[bc.StatsKey.StateCardUsedCount] = (stats[bc.StatsKey.StateCardUsedCount] or 0) + 1
  end
  if not isCmdCard then
    stats[bc.StatsKey.OtherCardUsedCount] = (stats[bc.StatsKey.OtherCardUsedCount] or 0) + 1
  end
  stats[bc.StatsKey.UsedCardCount] = (stats[bc.StatsKey.UsedCardCount] or 0) + 1
  local cardConfigId = card.tid
  local usedCardStats = stats[bc.StatsKey.UsedCardCountByConfigId] or {}
  usedCardStats[cardConfigId] = (usedCardStats[cardConfigId] or 0) + 1
  stats[bc.StatsKey.UsedCardCountByConfigId] = usedCardStats
  stats[bc.StatsKey.PlayerActionCount] = (stats[bc.StatsKey.PlayerActionCount] or 0) + 1
end

function BattleStatsMgr:OnAfterUseCard(data)
  local card = self.battleEngine:GetObj(data.cardUid)
  if not card then
    self.battleEngine:Error("使用卡牌后统计有误，找不到卡牌", data.cardUid)
    return
  end
  addCardToStats(self.globalStats, card)
  addCardToStats(self.battleStats, card)
  addCardToStats(self.curBoutStats, card)
  self:CalBoutMaxCardCount(card)
  self:StatUseCardOrder(self.battleStats, card)
end

function BattleStatsMgr:OnAfterUseKeeperSkill(data)
  self.globalStats[bc.StatsKey.UsedKeeperSkillCount] = (self.globalStats[bc.StatsKey.UsedKeeperSkillCount] or 0) + 1
end

function BattleStatsMgr:OnOceanModeChange()
  local player = self.battleEngine.roleMgr:GetPlayer()
  self:StatMaxTentacleDamage(player)
end

function BattleStatsMgr:StatMaxStrength(player, stateTid)
  if not player then
    return
  end
  local DT = self.battleEngine.battleDT
  local stateCfg = DT.State[stateTid]
  if not stateCfg then
    return
  end
  local strengthTid = DT.GetConstant("PowerCount")
  if stateCfg.MergeStateDisplay ~= strengthTid then
    return
  end
  self.strengthStatTids[stateTid] = true
  local stateMgr = self.battleEngine.stateMgr
  local statKey = bc.StatsKey.MaxStrength
  local strength = 0
  for tid, _ in pairs(self.strengthStatTids) do
    local state = stateMgr:GetState(player, tid)
    if state then
      strength = strength + state:GetLayer()
    end
  end
  self.battleStats[statKey] = math.max(self.battleStats[statKey] or 0, strength)
  self.globalStats[statKey] = math.max(self.globalStats[statKey] or 0, strength)
end

function BattleStatsMgr:StatMaxTentacleDamage(player)
  if player and player.schoolCompPVE and player.schoolCompPVE:IsSchoolID(bc.SchoolID.DEEP_SEA) then
    local statKey = bc.StatsKey.MaxTentacleDamage
    local tentacleDamage = player:GetTentacleDamage()
    self.battleStats[statKey] = math.max(self.battleStats[statKey] or 0, tentacleDamage)
    self.globalStats[statKey] = math.max(self.globalStats[statKey] or 0, tentacleDamage)
  end
end

function BattleStatsMgr:StatUseCardOrder(stats, card)
  local boutNum = self.battleEngine.boutMgr:GetBoutNum()
  local camp = self.battleEngine.boutMgr:GetCurCamp()
  local key = self:GetUseCardOrderKey(boutNum, camp)
  if not stats[key] then
    stats[key] = {}
  end
  table.insert(stats[key], card.uid)
end

function BattleStatsMgr:GetUseCardOrderKey(boutNum, camp)
  return bc.StatsKey.BoutUseCardOrder .. boutNum .. "Camp" .. camp
end

function BattleStatsMgr:CalBoutMaxCardCount(card)
  if not self.curBoutStats[bc.StatsKey.BoutMaxUseTypeCardCount] then
    self.curBoutStats[bc.StatsKey.BoutMaxUseTypeCardCount] = {}
  end
  local boutType2MaxCount = self.curBoutStats[bc.StatsKey.BoutMaxUseTypeCardCount]
  local cardTypes = card:GetType()
  for _, cardType in ipairs(cardTypes) do
    boutType2MaxCount[cardType] = (boutType2MaxCount[cardType] or 0) + 1
    if not self.battleStats[bc.StatsKey.BoutMaxUseTypeCardCount] then
      self.battleStats[bc.StatsKey.BoutMaxUseTypeCardCount] = {}
    end
    local battleType2MaxCount = self.battleStats[bc.StatsKey.BoutMaxUseTypeCardCount]
    if not battleType2MaxCount[cardType] or battleType2MaxCount[cardType] < boutType2MaxCount[cardType] then
      battleType2MaxCount[cardType] = boutType2MaxCount[cardType]
    end
  end
end

local function addStatsUseUltiSkill(stats)
  stats[bc.StatsKey.PlayerActionCount] = (stats[bc.StatsKey.PlayerActionCount] or 0) + 1
  stats[bc.StatsKey.UltiSkillCount] = (stats[bc.StatsKey.UltiSkillCount] or 0) + 1
end

function BattleStatsMgr:OnAfterUseUltiSkill(data)
  addStatsUseUltiSkill(self.globalStats)
  addStatsUseUltiSkill(self.battleStats)
  addStatsUseUltiSkill(self.curBoutStats)
  local ultiSkillCountMax = self.battleStats[bc.StatsKey.BoutMaxUltiSkillCount] or 0
  local curCount = self.curBoutStats[bc.StatsKey.UltiSkillCount] or 0
  if ultiSkillCountMax < curCount then
    self.battleStats[bc.StatsKey.BoutMaxUltiSkillCount] = curCount
  end
  self.battleEngine:Debug("-----------OnAfterUseUltiSkill: ", ultiSkillCountMax, curCount, self.battleStats[bc.StatsKey.BoutMaxUltiSkillCount])
end

local function addScarletBloodToStats(stats, v)
  stats[bc.StatsKey.ConsumedScaletBloodCount] = (stats[bc.StatsKey.ConsumedScaletBloodCount] or 0) + v
end

function BattleStatsMgr:OnConsumeScarletBlood(eventData)
  local value = eventData.changedValue
  addScarletBloodToStats(self.globalStats, value)
  addScarletBloodToStats(self.battleStats, value)
  addScarletBloodToStats(self.curBoutStats, value)
end

function BattleStatsMgr:OnDoDamage(beHitConfig)
  if beHitConfig.ignoreStats then
    return
  end
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  local player = self.battleEngine.roleMgr:GetPlayer(curCamp)
  local caster = self.battleEngine:GetObj(beHitConfig.castRoleUid)
  local castPlayer = caster:GetPlayer()
  for _, stat in ipairs({
    self.globalStats,
    self.battleStats,
    self.curBoutStats
  }) do
    if player.uid == castPlayer.uid then
      stat[bc.StatsKey.PlayerDoDamage] = (stat[bc.StatsKey.PlayerDoDamage] or 0) + (beHitConfig.castDamage or 0)
      stat[bc.StatsKey.PlayerDoRealDamage] = (stat[bc.StatsKey.PlayerDoRealDamage] or 0) + (beHitConfig.realDamage or 0)
      stat[bc.StatsKey.PlayerDoBlockDamage] = (stat[bc.StatsKey.PlayerDoBlockDamage] or 0) + (beHitConfig.blockLose or 0)
      local maxDamage = stat[bc.StatsKey.MaxPlayerDoDamage] or 0
      if beHitConfig.castDamage and beHitConfig.castDamage > 0 and maxDamage < beHitConfig.castDamage then
        stat[bc.StatsKey.MaxPlayerDoDamage] = beHitConfig.castDamage or 0
      end
    end
    if player.uid == beHitConfig.targetRoleUid then
      stat[bc.StatsKey.PlayerGotRealDamage] = (stat[bc.StatsKey.PlayerGotRealDamage] or 0) + (beHitConfig.realDamage or 0)
      stat[bc.StatsKey.PlayerGotBlockDamage] = (stat[bc.StatsKey.PlayerGotBlockDamage] or 0) + (beHitConfig.blockLose or 0)
    end
  end
  self:__UpdateBoutMaxPlayerDoDamage()
  self:OnDoDamageCurCmd(beHitConfig)
  local castDamage = beHitConfig.castDamage or 0
  local target = self.battleEngine:GetObj(beHitConfig.targetRoleUid)
  if target and target:GetCamp() ~= bc.BattleCamp.Camp1 then
    BattleActionStatsUtil.RecordActionStats_Battle(self.battleEngine, bc.RecordActionStats_Battle.ValueCategory.Battle, bc.RecordActionStats_Battle.ValueSubCategory.Damage, castDamage, beHitConfig.fromCmdServerUid, beHitConfig.targetRoleUid)
    self:ProcessRoleStats(beHitConfig.fromCmdServerUid, bc.StatsKey.AwakerDoDamage, castDamage)
  end
  local boutMaxMonsterBeDamage = self.battleStats[bc.StatsKey.BoutMaxMonsterBeDamage] or 0
  self:CalcDamagePer2MonsterClass(beHitConfig, boutMaxMonsterBeDamage)
end

function BattleStatsMgr:CalcDamagePer2MonsterClass(beHitConfig, boutMaxDamage)
  local target = self.battleEngine:GetObj(beHitConfig.targetRoleUid)
  if not target or not target.monsterBehaviorComp then
    return
  end
  local monsterClassMaxHp = self.battleEngine.roleMgr:GetMonsterClassMaxHp()
  local monsterClass = target.monsterBehaviorComp:GetMonsterClass()
  local max = monsterClassMaxHp[monsterClass]
  if not max then
    return
  end
  local statsKey = bc.MonsterClass2StatsDmgPer[monsterClass]
  if not statsKey then
    return
  end
  local per = boutMaxDamage / max
  local curVal = self.battleStats[statsKey]
  if not curVal or per > curVal then
    self.battleStats[statsKey] = per
  end
  local curGlobalVal = self.globalStats[statsKey]
  if not curGlobalVal or per > curGlobalVal then
    self.globalStats[statsKey] = per
  end
end

function BattleStatsMgr:OnDoDamageCurCmd(beHitConfig)
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  local player = self.battleEngine.roleMgr:GetPlayer(curCamp)
  local cmdServer = self.battleEngine:GetObj(beHitConfig.cmdServerUid or beHitConfig.fromCmdServerUid)
  if cmdServer then
    local caster = self.battleEngine:GetObj(beHitConfig.castRoleUid)
    local castPlayer = caster:GetPlayer()
    if castPlayer.uid == player.uid then
      cmdServer:AddStats(bc.StatsKey.PlayerDoDamage, beHitConfig.castDamage or 0)
      cmdServer:AddStats(bc.StatsKey.PlayerDoRealDamage, beHitConfig.realDamage or 0)
      cmdServer:AddStats(bc.StatsKey.PlayerDoBlockDamage, beHitConfig.blockLose or 0)
    end
  end
  if cmdServer and player.uid == beHitConfig.targetRoleUid then
    cmdServer:AddStats(bc.StatsKey.PlayerGotRealDamage, beHitConfig.realDamage or 0)
    cmdServer:AddStats(bc.StatsKey.PlayerGotBlockDamage, beHitConfig.blockLose or 0)
  end
end

function BattleStatsMgr:OnDoHeal(healConfig)
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local caster = self.battleEngine:GetObj(healConfig.castRoleUid)
  local castPlayer = caster:GetPlayer()
  for _, stat in ipairs({
    self.globalStats,
    self.battleStats,
    self.curBoutStats
  }) do
    if player.uid == castPlayer.uid then
      stat[bc.StatsKey.PlayerDoHeal] = (stat[bc.StatsKey.PlayerDoHeal] or 0) + (healConfig.heal or 0)
    end
  end
  local cmdServer = self.battleEngine:GetObj(healConfig.cmdServerUid)
  if cmdServer and player.uid == castPlayer.uid then
    cmdServer:AddStats(bc.StatsKey.PlayerDoHeal, healConfig.heal or 0)
  end
  local heal = healConfig.heal or 0
  BattleActionStatsUtil.RecordActionStats_Battle(self.battleEngine, bc.RecordActionStats_Battle.ValueCategory.Battle, bc.RecordActionStats_Battle.ValueSubCategory.Heal, heal, healConfig.cmdServerUid, healConfig.targetRoleUid)
  self:ProcessRoleStats(healConfig.cmdServerUid, bc.StatsKey.AwakerDoHeal, heal)
end

function BattleStatsMgr:OnBlockChange(eventData)
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local caster = self.battleEngine:GetObj(eventData.castRoleUid)
  local castPlayer = caster:GetPlayer()
  if castPlayer.uid ~= player.uid then
    return
  end
  
  local function statMaxBlock(stats, curBlock)
    local boutMaxBlock = stats[bc.StatsKey.BoutMaxPlayerBlock] or 0
    if curBlock > 0 and curBlock > boutMaxBlock then
      stats[bc.StatsKey.BoutMaxPlayerBlock] = curBlock
    end
    local maxHp = player:GetProperty("max_hp")
    local boutMaxBlockPer = stats[bc.StatsKey.BoutMaxPlayerBlockPer] or 0
    if boutMaxBlockPer < curBlock / maxHp then
      stats[bc.StatsKey.BoutMaxPlayerBlockPer] = curBlock / maxHp
    end
  end
  
  statMaxBlock(self.battleStats, eventData.curValue)
  statMaxBlock(self.globalStats, eventData.curValue)
end

function BattleStatsMgr:OnDoBlock(blockConfig)
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local caster = self.battleEngine:GetObj(blockConfig.castRoleUid)
  local castPlayer = caster:GetPlayer()
  for _, stat in ipairs({
    self.globalStats,
    self.battleStats,
    self.curBoutStats
  }) do
    if player.uid == castPlayer.uid then
      stat[bc.StatsKey.PlayerDoBlock] = (stat[bc.StatsKey.PlayerDoBlock] or 0) + (blockConfig.castValue or 0)
    end
  end
  local cmdServer = self.battleEngine:GetObj(blockConfig.cmdServerUid)
  if cmdServer and player.uid == castPlayer.uid then
    cmdServer:AddStats(bc.StatsKey.PlayerDoBlock, blockConfig.castValue or 0)
  end
  local castValue = blockConfig.castValue or 0
  BattleActionStatsUtil.RecordActionStats_Battle(self.battleEngine, bc.RecordActionStats_Battle.ValueCategory.Battle, bc.RecordActionStats_Battle.ValueSubCategory.Shield, castValue, blockConfig.cmdServerUid, blockConfig.targetRoleUid)
  self:ProcessRoleStats(blockConfig.cmdServerUid, bc.StatsKey.AwakerDoBlock, castValue)
end

function BattleStatsMgr:OnDeathResist(eventData)
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  for _, stat in ipairs({
    self.globalStats,
    self.battleStats,
    self.curBoutStats
  }) do
    if player.uid == eventData.targetRoleUid then
      stat[bc.StatsKey.DeathResistCount] = (stat[bc.StatsKey.DeathResistCount] or 0) + 1
    end
  end
  local cmdServer = self.battleEngine:GetObj(eventData.cmdServerUid)
  if cmdServer and player.uid == eventData.targetRoleUid then
    cmdServer:AddStats(bc.StatsKey.DeathResistCount, 1)
  end
end

local function changeMaxKill(stats, killCount)
  if not stats[bc.StatsKey.BoutMaxKill] or killCount > stats[bc.StatsKey.BoutMaxKill] then
    stats[bc.StatsKey.BoutMaxKill] = killCount
  end
end

function BattleStatsMgr:OnRoleDeath(eventData)
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local caster = self.battleEngine:GetObj(eventData.castRoleUid)
  local castPlayer = caster:GetPlayer()
  for _, stat in ipairs({
    self.globalStats,
    self.battleStats,
    self.curBoutStats
  }) do
    if player.uid == eventData.targetRoleUid then
      stat[bc.StatsKey.PlayerDeathCount] = (stat[bc.StatsKey.PlayerDeathCount] or 0) + 1
    elseif player.uid == castPlayer.uid or eventData.fromCmdServerUid and eventData.fromCmdServerUid == player.uid then
      stat[bc.StatsKey.KillCount] = (stat[bc.StatsKey.KillCount] or 0) + 1
    elseif eventData.hpChangeReason == bc.PropertyChangeReason.Damage then
      stat[bc.StatsKey.KillCount] = (stat[bc.StatsKey.KillCount] or 0) + 1
    end
  end
  local cmdServer = self.battleEngine:GetObj(eventData.cmdServerUid)
  if cmdServer and player.uid == castPlayer.uid then
    cmdServer:AddStats(bc.StatsKey.KillCount, 1)
  end
  local killCount = self.curBoutStats[bc.StatsKey.KillCount] or 0
  changeMaxKill(self.globalStats, killCount)
  changeMaxKill(self.battleStats, killCount)
end

function BattleStatsMgr:SetOverFlowEnergy(value)
  for _, stat in ipairs({
    self.globalStats,
    self.battleStats,
    self.curBoutStats
  }) do
    stat[bc.StatsKey.OverFlowEnergy] = value
  end
end

function BattleStatsMgr:OnShuffleCards(eventData)
  for _, stat in ipairs({
    self.globalStats,
    self.battleStats,
    self.curBoutStats
  }) do
    stat[bc.StatsKey.DrawDeckResetCount] = (stat[bc.StatsKey.DrawDeckResetCount] or 0) + 1
  end
end

function BattleStatsMgr:OnLaunchJump(eventData)
  if eventData.isExtraBout then
    self.curBoutStats[bc.StatsKey.BoutMaxJump] = (self.curBoutStats[bc.StatsKey.BoutMaxJump] or 0) + 1
    local battleMax = self.battleStats[bc.StatsKey.BoutMaxJump] or 0
    if battleMax < self.curBoutStats[bc.StatsKey.BoutMaxJump] then
      self.battleStats[bc.StatsKey.BoutMaxJump] = self.curBoutStats[bc.StatsKey.BoutMaxJump]
    end
  end
end

function BattleStatsMgr:OnTentacleAttack(eventData)
  self.curBoutStats[bc.StatsKey.BoutMaxTentacleAttack] = (self.curBoutStats[bc.StatsKey.BoutMaxTentacleAttack] or 0) + 1
  local battleMax = self.battleStats[bc.StatsKey.BoutMaxTentacleAttack] or 0
  if battleMax < self.curBoutStats[bc.StatsKey.BoutMaxTentacleAttack] then
    self.battleStats[bc.StatsKey.BoutMaxTentacleAttack] = self.curBoutStats[bc.StatsKey.BoutMaxTentacleAttack]
  end
  self.globalStats[bc.StatsKey.TentacleAttackCount] = (self.globalStats[bc.StatsKey.TentacleAttackCount] or 0) + 1
end

function BattleStatsMgr:GetStats(type, attr)
  local stats = self.typeToStats[type]
  return stats[attr] or 0
end

function BattleStatsMgr:GetUsedCountOfCardByConfigId(type, cardConfigId)
  local stats = self.typeToStats[type]
  local usedCardStats = stats[bc.StatsKey.UsedCardCountByConfigId]
  if nil == usedCardStats then
    return 0
  end
  return usedCardStats[cardConfigId] or 0
end

function BattleStatsMgr:RecordBlock(block)
  self.lastBoutStats[bc.StatsKey.SurplusBlock] = block
end

function BattleStatsMgr:UpdateStats()
  self.battleEngine.instantRecordMgr:OnUpdateStats(bc.BattleCamp.Camp1, self:Serialize())
end

function BattleStatsMgr:ProcessRoleStats(cmdServerUid, statKey, value)
  if not self.battleEngine:IsPVE() then
    return
  end
  if not cmdServerUid then
    return
  end
  local cmdServer = self.battleEngine:GetObj(cmdServerUid)
  if not cmdServer then
    return
  end
  local castRoleUid = cmdServer.castRoleUid
  if not castRoleUid then
    return
  end
  local castRole = self.battleEngine:GetObj(castRoleUid)
  if not castRole then
    return
  end
  local isFromState = cmdServer.stateId or cmdServer.stateUid
  local isFromSkill = cmdServer.skillConfigId
  if isFromSkill then
    if castRole:GetCamp() ~= bc.BattleCamp.Camp1 then
      return
    end
    self:AddAwakerStats(cmdServer.castRoleUid, statKey, value)
    self.battleStatPackMgr:AddBattleStatPackSkillStats(cmdServer, statKey, value)
  elseif isFromState then
    self:ProcessStateStats(cmdServer, statKey, value)
  else
    self.battleEngine:DebugS("ProcessRoleStats未知事件来源类型 {cmdServerUid}", cmdServer.uid)
  end
end

function BattleStatsMgr:ProcessStateStats(cmdServer, statKey, value)
  local ownershipUidToValue = BattleActionStatsUtil.CalcStateOwnershipUidToValue(self.battleEngine, cmdServer, value)
  for castRoleUid, allocatedValue in pairs(ownershipUidToValue) do
    if allocatedValue <= 0 then
    else
      local castRole = self.battleEngine:GetObj(castRoleUid)
      if not castRole then
      elseif castRole:GetCamp() ~= bc.BattleCamp.Camp1 then
      else
        self:AddAwakerStats(castRoleUid, statKey, allocatedValue)
        self.battleStatPackMgr:AddBattleStatPackStateStats(castRoleUid, cmdServer, statKey, allocatedValue)
      end
    end
  end
end

function BattleStatsMgr:AddAwakerStats(roleUid, statKey, value)
  if not (roleUid and statKey and value) or 0 == value then
    return
  end
  local roleTid = BattleActionStatsUtil.GetStatsRoleId(self.battleEngine, roleUid)
  if not roleTid then
    return
  end
  local casterCamp = bc.BattleCamp.Camp1
  local roleStr = "玩家"
  if 0 ~= roleTid then
    local role = self.battleEngine:GetObj(roleUid)
    roleStr = role:GetBattleLogName()
    casterCamp = role:GetCamp()
  end
  local str = string.format("增加战斗统计：%s 造成 %s 值 %s", roleStr, statKey, value)
  self.battleEngine:LogBattleWithTab(str)
  local statsToUpdate = {
    self.globalStats,
    self.battleStats,
    self.curBoutStats
  }
  for _, stats in ipairs(statsToUpdate) do
    if not stats[statKey] then
      stats[statKey] = {}
    end
    if type(stats[statKey]) ~= "table" then
      stats[statKey] = {}
    end
    stats[statKey][roleTid] = (stats[statKey][roleTid] or 0) + value
  end
  if statKey == bc.StatsKey.AwakerDoDamage and casterCamp == bc.BattleCamp.Camp1 then
    self:__UpdateMonsterBeDamage(value)
  end
end

function BattleStatsMgr:OnBEChangeAttrHp(eventData)
  local castValue = eventData.castValue
  if not castValue or 0 == castValue then
    return
  end
  local caster = self.battleEngine:GetObj(eventData.castRoleUid)
  if not caster then
    return
  end
  local target = self.battleEngine:GetObj(eventData.targetRoleUid)
  if not target then
    return
  end
  if castValue < 0 then
    if target:GetCamp() == bc.BattleCamp.Camp1 then
      return
    end
    local damage = math.abs(castValue)
    BattleActionStatsUtil.RecordActionStats_Battle(self.battleEngine, bc.RecordActionStats_Battle.ValueCategory.Battle, bc.RecordActionStats_Battle.ValueSubCategory.Damage, damage, eventData.cmdServerUid, eventData.targetRoleUid)
    self:AddPlayerDoDamageByCmd(eventData.cmdServerUid, damage)
    self:ProcessRoleStats(eventData.cmdServerUid, bc.StatsKey.AwakerDoDamage, damage)
  elseif castValue > 0 then
    if target:GetCamp() ~= bc.BattleCamp.Camp1 then
      return
    end
    local heal = castValue
    BattleActionStatsUtil.RecordActionStats_Battle(self.battleEngine, bc.RecordActionStats_Battle.ValueCategory.Battle, bc.RecordActionStats_Battle.ValueSubCategory.Heal, heal, eventData.cmdServerUid, eventData.targetRoleUid)
    self:ProcessRoleStats(eventData.cmdServerUid, bc.StatsKey.AwakerDoHeal, heal)
  end
end

function BattleStatsMgr:OnModifyHp(eventData)
  if eventData.ignoreStats then
    return
  end
  local cmdServerUid = eventData.fromCmdServerUid
  if not cmdServerUid then
    return
  end
  local caster = self.battleEngine:GetObj(eventData.castRoleUid)
  if not caster then
    return
  end
  local target = self.battleEngine:GetObj(eventData.destRoleUid)
  if not target then
    return
  end
  local castValue = eventData.modifyVal
  if castValue < 0 then
    if target:GetCamp() == bc.BattleCamp.Camp1 then
      return
    end
    local damage = math.abs(castValue)
    BattleActionStatsUtil.RecordActionStats_Battle(self.battleEngine, bc.RecordActionStats_Battle.ValueCategory.Battle, bc.RecordActionStats_Battle.ValueSubCategory.Damage, damage, cmdServerUid, eventData.destRoleUid)
    self:AddPlayerDoDamageByCmd(cmdServerUid, damage)
    self:ProcessRoleStats(cmdServerUid, bc.StatsKey.AwakerDoDamage, damage)
  elseif castValue > 0 then
    if target:GetCamp() ~= bc.BattleCamp.Camp1 then
      return
    end
    local heal = castValue
    BattleActionStatsUtil.RecordActionStats_Battle(self.battleEngine, bc.RecordActionStats_Battle.ValueCategory.Battle, bc.RecordActionStats_Battle.ValueSubCategory.Heal, heal, cmdServerUid, eventData.destRoleUid)
    self:ProcessRoleStats(cmdServerUid, bc.StatsKey.AwakerDoHeal, heal)
  end
end

function BattleStatsMgr:OnBEChangeAttrBlock(eventData)
  local castValue = eventData.castValue
  if not castValue or castValue <= 0 then
    return
  end
  local caster = self.battleEngine:GetObj(eventData.castRoleUid)
  if not caster then
    return
  end
  local target = self.battleEngine:GetObj(eventData.targetRoleUid)
  if not target then
    return
  end
  if caster:GetCamp() ~= bc.BattleCamp.Camp1 then
    return
  end
  if caster:GetCamp() ~= target:GetCamp() then
    return
  end
  BattleActionStatsUtil.RecordActionStats_Battle(self.battleEngine, bc.RecordActionStats_Battle.ValueCategory.Battle, bc.RecordActionStats_Battle.ValueSubCategory.Shield, castValue, eventData.cmdServerUid, eventData.targetRoleUid)
  self:ProcessRoleStats(eventData.cmdServerUid, bc.StatsKey.AwakerDoBlock, castValue)
end

function BattleStatsMgr:__UpdateBoutMaxPlayerDoDamage()
  local boutMaxDamage = self.battleStats[bc.StatsKey.BoutMaxPlayerDoDamage] or 0
  local curBoutDamage = self.curBoutStats[bc.StatsKey.PlayerDoDamage] or 0
  if curBoutDamage > 0 and boutMaxDamage < curBoutDamage then
    self.battleStats[bc.StatsKey.BoutMaxPlayerDoDamage] = curBoutDamage
  end
  local globalMax = self.globalStats[bc.StatsKey.BoutMaxPlayerDoDamage] or 0
  if curBoutDamage > 0 and curBoutDamage > globalMax then
    self.globalStats[bc.StatsKey.BoutMaxPlayerDoDamage] = curBoutDamage
  end
end

function BattleStatsMgr:CalcCamp1PlayerDoDamage(cmdServerUid, damage)
  if not damage or damage <= 0 or not cmdServerUid then
    return 0
  end
  if not self.battleEngine:IsPVE() then
    return 0
  end
  local cmdServer = self.battleEngine:GetObj(cmdServerUid)
  if not cmdServer then
    return 0
  end
  local isFromSkill = cmdServer.skillConfigId
  local isFromState = cmdServer.stateId or cmdServer.stateUid
  if isFromSkill then
    local castRole = self.battleEngine:GetObj(cmdServer.castRoleUid)
    if castRole and castRole:GetCamp() == bc.BattleCamp.Camp1 then
      return damage
    end
  elseif isFromState then
    local camp1Damage = 0
    local ownershipUidToValue = BattleActionStatsUtil.CalcStateOwnershipUidToValue(self.battleEngine, cmdServer, damage)
    for castRoleUid, allocatedValue in pairs(ownershipUidToValue) do
      if allocatedValue > 0 then
        local castRole = self.battleEngine:GetObj(castRoleUid)
        if castRole and castRole:GetCamp() == bc.BattleCamp.Camp1 then
          camp1Damage = camp1Damage + allocatedValue
        end
      end
    end
    return camp1Damage
  end
  return 0
end

function BattleStatsMgr:AddPlayerDoDamageByCmd(cmdServerUid, damage)
  local camp1Damage = self:CalcCamp1PlayerDoDamage(cmdServerUid, damage)
  if camp1Damage <= 0 then
    return
  end
  for _, stat in ipairs({
    self.globalStats,
    self.battleStats,
    self.curBoutStats
  }) do
    stat[bc.StatsKey.PlayerDoDamage] = (stat[bc.StatsKey.PlayerDoDamage] or 0) + camp1Damage
    local maxDamage = stat[bc.StatsKey.MaxPlayerDoDamage] or 0
    if camp1Damage > maxDamage then
      stat[bc.StatsKey.MaxPlayerDoDamage] = camp1Damage
    end
  end
  self:__UpdateBoutMaxPlayerDoDamage()
end

function BattleStatsMgr:__UpdateMonsterBeDamage(damage)
  for _, stat in ipairs({
    self.globalStats,
    self.battleStats,
    self.curBoutStats
  }) do
    stat[bc.StatsKey.MonsterBeDamage] = (stat[bc.StatsKey.MonsterBeDamage] or 0) + (damage or 0)
  end
  local boutMaxMonsterBeDamage = self.battleStats[bc.StatsKey.BoutMaxMonsterBeDamage] or 0
  local curBoutMonsterBeDamage = self.curBoutStats[bc.StatsKey.MonsterBeDamage] or 0
  if curBoutMonsterBeDamage > 0 and boutMaxMonsterBeDamage < curBoutMonsterBeDamage then
    self.battleStats[bc.StatsKey.BoutMaxMonsterBeDamage] = curBoutMonsterBeDamage
  end
  local globalMonsterMax = self.globalStats[bc.StatsKey.BoutMaxMonsterBeDamage] or 0
  if curBoutMonsterBeDamage > 0 and curBoutMonsterBeDamage > globalMonsterMax then
    self.globalStats[bc.StatsKey.BoutMaxMonsterBeDamage] = curBoutMonsterBeDamage
  end
end

return BattleStatsMgr
