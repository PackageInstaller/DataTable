local System = require("System.System")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local bc = require("Battle.BattleConst")
local BattleComponent = require("Battle.Ecs.BattleComponent")
local BattleActionStatsUtil = require("Battle.DbgEngine.Stats.BattleActionStatsUtil")
local BP = bc.BattleProperty
local BattleStatsMgrPVP, Super = System.NewClass("BattleStatsMgrPVP", BattleComponent)

function BattleStatsMgrPVP:ctor(entity, battleEngine)
  Super.ctor(self, entity)
  self.entity = entity
  self.battleEngine = battleEngine
  self.data = self:ctorData()
  self.typeToStats = {
    BattleStats = self.data.battleStats,
    CurBoutStats = self.data.curBoutStats,
    LastBoutStats = self.data.lastBoutStats,
    GlobalStats = self.data.globalStats
  }
  self:RegisterCallbacks()
end

function BattleStatsMgrPVP:ctorData()
  local data = Super.ctorData(self)
  data.globalStats = {}
  data.battleStats = {}
  data.curBoutStats = {}
  data.lastBoutStats = {}
  return data
end

function BattleStatsMgrPVP:RegisterCallbacks()
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
  self.battleEngine:RegisterEvent(BattleLogicEvent.RoleAfterDeathResist, self.OnDeathResist, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.RoleAfterDeath, self.OnRoleDeath, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.ShuffleCards, self.OnShuffleCards, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.GainEnergy, self.OnGainEnergy, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.FightBackKill, self.OnFightBackKill, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.CritKill, self.OnCritKill, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.StateOnAdd, self.OnStateOnAdd, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BlockChange, self.OnBlockChange, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.SendEmoji, self.OnSendEmoji, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BEChangeAttrHp, self.OnBEChangeAttrHp, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.ModifyHp, self.OnModifyHp, self)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BEChangeAttrBlock, self.OnBEChangeAttrBlock, self)
end

function BattleStatsMgrPVP:IsCampMatch()
  return self.entity:GetCamp() == self.battleEngine.boutMgr:GetCurCamp()
end

function BattleStatsMgrPVP:StatsAwakerHp(comp)
  local awakerList = self.battleEngine.roleMgr:GetRoleTypeListByCamp(comp, bc.RoleType.Awaker)
  for _, awaker in pairs(awakerList) do
    if not self.data.battleStats[bc.StatsKey.AwakerHp] then
      self.data.battleStats[bc.StatsKey.AwakerHp] = {}
    end
    local awakerHpList = self.data.battleStats[bc.StatsKey.AwakerHp]
    awakerHpList[awaker.tid] = awaker.property:GetProperty(BP.hp)
  end
end

function BattleStatsMgrPVP:GetBattleFinishStats()
  self:StatsAwakerHp(self.entity:GetCamp())
  return {
    GlobalStats = table.deepclone(self.data.globalStats),
    BattleStats = table.deepclone(self.data.battleStats)
  }
end

function BattleStatsMgrPVP:Serialize()
  return {
    globalStats = self.data.globalStats,
    battleStats = self.data.battleStats,
    curBoutStats = self.data.curBoutStats,
    lastBoutStats = self.data.lastBoutStats
  }
end

function BattleStatsMgrPVP:OnRecover(statsData)
  self.data.globalStats = statsData.globalStats
  self.data.battleStats = statsData.battleStats
  self.data.curBoutStats = statsData.curBoutStats
  self.data.lastBoutStats = statsData.lastBoutStats
end

function BattleStatsMgrPVP:GetBattleStats(key)
  return self.data.battleStats[key]
end

function BattleStatsMgrPVP:GetCurBoutStats(key)
  return self.data.curBoutStats[key]
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

function BattleStatsMgrPVP:OnBFBeforeBoutBegin(isExtraBout)
  if not self:IsCampMatch() then
    return
  end
  local boutMgr = self.battleEngine.boutMgr
  local curCamp = boutMgr:GetCurCamp()
  if curCamp == bc.BattleCamp.Camp1 then
    if isExtraBout then
      addDimensionBoutToStats(self.data.globalStats)
      addDimensionBoutToStats(self.data.battleStats)
    end
    addBoutToStats(self.data.globalStats)
    addBoutToStats(self.data.battleStats)
    self.data.lastBoutStats = self.data.curBoutStats
    self.data.curBoutStats = {}
    self.typeToStats.LastBoutStats = self.data.lastBoutStats
    self.typeToStats.CurBoutStats = self.data.curBoutStats
  end
  self:__CalcBoutMaxStats()
end

function BattleStatsMgrPVP:OnBFBeforeBattleEnd()
  if not self:IsCampMatch() then
    return
  end
  self:__CalcBoutMaxStats()
end

function BattleStatsMgrPVP:OnBFBeforeBoutEnd()
  if not self:IsCampMatch() then
    return
  end
  
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
    statBoutUseCardCount(self.data.globalStats, self.data.curBoutStats[bc.StatsKey.UsedCardCount] or 0)
    statBoutUseCardCount(self.data.battleStats, self.data.curBoutStats[bc.StatsKey.UsedCardCount] or 0)
  end
end

function BattleStatsMgrPVP:__CalcBoutMaxStats()
  local boutMgr = self.battleEngine.boutMgr
  local curCamp = boutMgr:GetCurCamp()
  if curCamp == bc.BattleCamp.Camp1 then
    local player = self.battleEngine.roleMgr:GetPlayer(curCamp)
    local awakerList = player:GetAwakerList()
    local totalTimes = 0
    for _, awaker in pairs(awakerList) do
      totalTimes = totalTimes + awaker:GetData("boutSkillTimes")
    end
    local battleStats = self.data.battleStats
    local globalStats = self.data.globalStats
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

function BattleStatsMgrPVP:OnConsumeEnergy(eventData)
  local energy = eventData.realCost
  addEnergyToStats(self.data.globalStats, energy)
  addEnergyToStats(self.data.battleStats, energy)
  addEnergyToStats(self.data.curBoutStats, energy)
  local battleMax = self.data.battleStats[bc.StatsKey.BoutMaxConsumeEnergy] or 0
  if battleMax < self.data.curBoutStats[bc.StatsKey.ConsumeEnergy] then
    self.data.battleStats[bc.StatsKey.BoutMaxConsumeEnergy] = self.data.curBoutStats[bc.StatsKey.ConsumeEnergy]
  end
end

function BattleStatsMgrPVP:OnGainEnergy(eventData)
  if not self:IsCampMatch() then
    return
  end
  
  local function changeMaxEnergy(stats)
    local max = stats[bc.StatsKey.BoutMaxEnergy] or 0
    if max < eventData.curValue then
      stats[bc.StatsKey.BoutMaxEnergy] = eventData.curValue
    end
  end
  
  changeMaxEnergy(self.data.globalStats)
  changeMaxEnergy(self.data.battleStats)
end

function BattleStatsMgrPVP:OnFightBackKill()
  if not self:IsCampMatch() then
    return
  end
  self.data.battleStats[bc.StatsKey.BattleFightBackKill] = (self.data.battleStats[bc.StatsKey.BattleFightBackKill] or 0) + 1
end

function BattleStatsMgrPVP:OnCritKill()
  if not self:IsCampMatch() then
    return
  end
  self.data.battleStats[bc.StatsKey.CritKill] = (self.data.battleStats[bc.StatsKey.CritKill] or 0) + 1
end

function BattleStatsMgrPVP:OnStateOnAdd(eventData)
  if not self:IsCampMatch() then
    return
  end
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
  if not self.data.battleStats[statKey] then
    self.data.battleStats[statKey] = {}
  end
  self.data.battleStats[statKey][stateId] = math.max(self.data.battleStats[statKey][stateId] or 0, state.data.layer)
end

local function addDiscardCardToStats(stats, data)
  stats[bc.StatsKey.DiscardedCardCount] = (stats[bc.StatsKey.DiscardedCardCount] or 0) + 1
end

local function addSwallowCardToStats(stats, data)
  stats[bc.StatsKey.SwallowedCardCount] = (stats[bc.StatsKey.SwallowedCardCount] or 0) + 1
end

function BattleStatsMgrPVP:OnCardDeckChanged(data)
  if not self:IsCampMatch() then
    return
  end
  if data.oldDeck == bc.CardDeck.HandDeck and data.newDeck == bc.CardDeck.GraveyardDeck then
    addDiscardCardToStats(self.data.globalStats, data)
    addDiscardCardToStats(self.data.battleStats, data)
    addDiscardCardToStats(self.data.curBoutStats, data)
  end
  if data.newDeck == bc.CardDeck.SwallowDeck then
    addSwallowCardToStats(self.data.globalStats, data)
    addSwallowCardToStats(self.data.battleStats, data)
    addSwallowCardToStats(self.data.curBoutStats, data)
    local curBoutMaxSwallow = self.data.battleStats[bc.StatsKey.BoutMaxSwallow] or 0
    if curBoutMaxSwallow < self.data.curBoutStats[bc.StatsKey.SwallowedCardCount] then
      self.data.battleStats[bc.StatsKey.BoutMaxSwallow] = self.data.curBoutStats[bc.StatsKey.SwallowedCardCount]
    end
  end
end

local function addStatsDiscardCards(stats, discardCount)
  stats[bc.StatsKey.EndBoutDiscardCount] = (stats[bc.StatsKey.EndBoutDiscardCount] or 0) + discardCount
end

function BattleStatsMgrPVP:OnAfterDiscardCards()
  if not self:IsCampMatch() then
    return
  end
  local discardCount = self.battleEngine.cardMgr.discardCount or 0
  addStatsDiscardCards(self.data.globalStats, discardCount)
  addStatsDiscardCards(self.data.battleStats, discardCount)
  addStatsDiscardCards(self.data.curBoutStats, discardCount)
end

local function addDrawCardToStats(stats)
  stats[bc.StatsKey.DrawCardCount] = (stats[bc.StatsKey.DrawCardCount] or 0) + 1
end

local function changeMaxDraw(stats, curCount)
  if not stats[bc.StatsKey.BoutMaxDrawCardCount] or curCount > stats[bc.StatsKey.BoutMaxDrawCardCount] then
    stats[bc.StatsKey.BoutMaxDrawCardCount] = curCount
  end
end

function BattleStatsMgrPVP:OnCardOnDraw(data)
  if not self:IsCampMatch() then
    return
  end
  addDrawCardToStats(self.data.globalStats)
  addDrawCardToStats(self.data.battleStats)
  addDrawCardToStats(self.data.curBoutStats)
  changeMaxDraw(self.data.globalStats, self.data.curBoutStats[bc.StatsKey.DrawCardCount])
  changeMaxDraw(self.data.battleStats, self.data.curBoutStats[bc.StatsKey.DrawCardCount])
end

local function addCardToStats(stats, card)
  local cardTypes = card:GetType()
  local isKeeperSkillCard = false
  for _, cardType in ipairs(cardTypes) do
    if cardType == bc.SkillType.Card_Strike then
      stats[bc.StatsKey.StrikeCardUsedCount] = (stats[bc.StatsKey.StrikeCardUsedCount] or 0) + 1
    elseif cardType == bc.SkillType.Card_Defend then
      stats[bc.StatsKey.DefenceCardUsedCount] = (stats[bc.StatsKey.DefenceCardUsedCount] or 0) + 1
    elseif cardType == bc.SkillType.Card_Skill then
      stats[bc.StatsKey.SkillCardUsedCount] = (stats[bc.StatsKey.SkillCardUsedCount] or 0) + 1
    elseif cardType == bc.SkillType.Card_Awake then
      stats[bc.StatsKey.AwakeCardUsedCount] = (stats[bc.StatsKey.AwakeCardUsedCount] or 0) + 1
    elseif cardType == bc.SkillType.Card_KeeperSkill then
      isKeeperSkillCard = true
    else
      stats[bc.StatsKey.OtherCardUsedCount] = (stats[bc.StatsKey.OtherCardUsedCount] or 0) + 1
      if cardType == bc.SkillType.Card_Curse then
        stats[bc.StatsKey.CurseCardUsedCount] = (stats[bc.StatsKey.CurseCardUsedCount] or 0) + 1
      elseif cardType == bc.SkillType.Card_State then
        stats[bc.StatsKey.StateCardUsedCount] = (stats[bc.StatsKey.StateCardUsedCount] or 0) + 1
      end
    end
  end
  if isKeeperSkillCard then
    stats[bc.StatsKey.UsedKeeperSkillCount] = (stats[bc.StatsKey.UsedKeeperSkillCount] or 0) + 1
  end
  stats[bc.StatsKey.UsedCardCount] = (stats[bc.StatsKey.UsedCardCount] or 0) + 1
  local cardConfigId = card.tid
  local usedCardStats = stats[bc.StatsKey.UsedCardCountByConfigId] or {}
  usedCardStats[cardConfigId] = (usedCardStats[cardConfigId] or 0) + 1
  stats[bc.StatsKey.UsedCardCountByConfigId] = usedCardStats
  stats[bc.StatsKey.PlayerActionCount] = (stats[bc.StatsKey.PlayerActionCount] or 0) + 1
end

function BattleStatsMgrPVP:OnAfterUseCard(data)
  if not self:IsCampMatch() then
    return
  end
  local card = self.battleEngine:GetObj(data.cardUid)
  if not card then
    self.battleEngine:Error("使用卡牌后统计有误，找不到卡牌", data.cardUid)
    return
  end
  addCardToStats(self.data.globalStats, card)
  addCardToStats(self.data.battleStats, card)
  addCardToStats(self.data.curBoutStats, card)
  self:CalBoutMaxCardCount(card)
  self:StatUseCardOrder(self.data.battleStats, card)
end

function BattleStatsMgrPVP:StatUseCardOrder(stats, card)
  local boutNum = self.battleEngine.boutMgr:GetBoutNum()
  local camp = self.battleEngine.boutMgr:GetCurCamp()
  local key = self:GetUseCardOrderKey(boutNum, camp)
  if not stats[key] then
    stats[key] = {}
  end
  table.insert(stats[key], card.uid)
end

function BattleStatsMgrPVP:GetUseCardOrderKey(boutNum, camp)
  return bc.StatsKey.BoutUseCardOrder .. boutNum .. "Camp" .. camp
end

function BattleStatsMgrPVP:CalBoutMaxCardCount(card)
  if not self.data.curBoutStats[bc.StatsKey.BoutMaxUseTypeCardCount] then
    self.data.curBoutStats[bc.StatsKey.BoutMaxUseTypeCardCount] = {}
  end
  local boutType2MaxCount = self.data.curBoutStats[bc.StatsKey.BoutMaxUseTypeCardCount]
  local cardTypes = card:GetType()
  for _, cardType in ipairs(cardTypes) do
    boutType2MaxCount[cardType] = (boutType2MaxCount[cardType] or 0) + 1
    if not self.data.battleStats[bc.StatsKey.BoutMaxUseTypeCardCount] then
      self.data.battleStats[bc.StatsKey.BoutMaxUseTypeCardCount] = {}
    end
    local battleType2MaxCount = self.data.battleStats[bc.StatsKey.BoutMaxUseTypeCardCount]
    if not battleType2MaxCount[cardType] or battleType2MaxCount[cardType] < boutType2MaxCount[cardType] then
      battleType2MaxCount[cardType] = boutType2MaxCount[cardType]
    end
  end
end

local function addStatsUseUltiSkill(stats)
  stats[bc.StatsKey.PlayerActionCount] = (stats[bc.StatsKey.PlayerActionCount] or 0) + 1
  stats[bc.StatsKey.UltiSkillCount] = (stats[bc.StatsKey.UltiSkillCount] or 0) + 1
end

function BattleStatsMgrPVP:OnAfterUseUltiSkill(data)
  if not self:IsCampMatch() then
    return
  end
  addStatsUseUltiSkill(self.data.globalStats)
  addStatsUseUltiSkill(self.data.battleStats)
  addStatsUseUltiSkill(self.data.curBoutStats)
  local ultiSkillCountMax = self.data.battleStats[bc.StatsKey.BoutMaxUltiSkillCount] or 0
  local curCount = self.data.curBoutStats[bc.StatsKey.UltiSkillCount] or 0
  if ultiSkillCountMax < curCount then
    self.data.battleStats[bc.StatsKey.BoutMaxUltiSkillCount] = curCount
  end
  self.battleEngine:Debug("-----------OnAfterUseUltiSkill: ", ultiSkillCountMax, curCount, self.data.battleStats[bc.StatsKey.BoutMaxUltiSkillCount])
end

local function addScarletBloodToStats(stats, v)
  stats[bc.StatsKey.ConsumedScaletBloodCount] = (stats[bc.StatsKey.ConsumedScaletBloodCount] or 0) + v
end

function BattleStatsMgrPVP:OnConsumeScarletBlood(eventData)
  if not self:IsCampMatch() then
    return
  end
  local value = eventData.changedValue
  addScarletBloodToStats(self.data.globalStats, value)
  addScarletBloodToStats(self.data.battleStats, value)
  addScarletBloodToStats(self.data.curBoutStats, value)
end

function BattleStatsMgrPVP:OnDoDamage(beHitConfig)
  if beHitConfig.ignoreStats then
    return
  end
  local player = self.entity
  local caster = self.battleEngine:GetObj(beHitConfig.castRoleUid)
  local castTid = caster.tid or 0
  local castPlayer = caster:GetPlayer()
  for _, stat in ipairs({
    self.data.globalStats,
    self.data.battleStats,
    self.data.curBoutStats
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
    if player.uid ~= beHitConfig.destRoleUid then
      stat[bc.StatsKey.MonsterBeDamage] = (stat[bc.StatsKey.MonsterBeDamage] or 0) + (beHitConfig.castDamage or 0)
    end
  end
  local boutMaxDamage = self.data.battleStats[bc.StatsKey.BoutMaxPlayerDoDamage] or 0
  local curBoutDamage = self.data.battleStats[bc.StatsKey.PlayerDoDamage] or 0
  if curBoutDamage > 0 and boutMaxDamage < curBoutDamage then
    self.data.battleStats[bc.StatsKey.BoutMaxPlayerDoDamage] = curBoutDamage
  end
  self:ProcessRoleStats(beHitConfig.fromCmdServerUid, bc.StatsKey.AwakerDoDamage, beHitConfig.castDamage or 0)
end

function BattleStatsMgrPVP:OnDoHeal(healConfig)
  if not self:IsCampMatch() then
    return
  end
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local caster = self.battleEngine:GetObj(healConfig.castRoleUid)
  local castPlayer = caster:GetPlayer()
  for _, stat in ipairs({
    self.data.globalStats,
    self.data.battleStats,
    self.data.curBoutStats
  }) do
    if player.uid == castPlayer.uid then
      stat[bc.StatsKey.PlayerDoHeal] = (stat[bc.StatsKey.PlayerDoHeal] or 0) + (healConfig.heal or 0)
    end
  end
  self:ProcessRoleStats(healConfig.cmdServerUid, bc.StatsKey.AwakerDoHeal, healConfig.heal or 0)
end

function BattleStatsMgrPVP:OnBlockChange(eventData)
  if not self:IsCampMatch() then
    return
  end
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
  
  statMaxBlock(self.data.battleStats, eventData.curValue)
  statMaxBlock(self.data.globalStats, eventData.curValue)
end

function BattleStatsMgrPVP:OnDoBlock(blockConfig)
  if not self:IsCampMatch() then
    return
  end
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local caster = self.battleEngine:GetObj(blockConfig.castRoleUid)
  local castPlayer = caster:GetPlayer()
  for _, stat in ipairs({
    self.data.globalStats,
    self.data.battleStats,
    self.data.curBoutStats
  }) do
    if player.uid == castPlayer.uid then
      stat[bc.StatsKey.PlayerDoBlock] = (stat[bc.StatsKey.PlayerDoBlock] or 0) + (blockConfig.castValue or 0)
    end
  end
  self:ProcessRoleStats(blockConfig.cmdServerUid, bc.StatsKey.AwakerDoBlock, blockConfig.castValue or 0)
end

function BattleStatsMgrPVP:OnDeathResist(eventData)
  if not self:IsCampMatch() then
    return
  end
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  for _, stat in ipairs({
    self.data.globalStats,
    self.data.battleStats,
    self.data.curBoutStats
  }) do
    if player.uid == eventData.targetRoleUid then
      stat[bc.StatsKey.DeathResistCount] = (stat[bc.StatsKey.DeathResistCount] or 0) + 1
    end
  end
end

local function changeMaxKill(stats, killCount)
  if not stats[bc.StatsKey.BoutMaxKill] or killCount > stats[bc.StatsKey.BoutMaxKill] then
    stats[bc.StatsKey.BoutMaxKill] = killCount
  end
end

function BattleStatsMgrPVP:OnRoleDeath(eventData)
  if not self:IsCampMatch() then
    return
  end
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local caster = self.battleEngine:GetObj(eventData.castRoleUid)
  local castPlayer = caster:GetPlayer()
  for _, stat in ipairs({
    self.data.globalStats,
    self.data.battleStats,
    self.data.curBoutStats
  }) do
    if player.uid == castPlayer.uid then
      stat[bc.StatsKey.KillCount] = (stat[bc.StatsKey.KillCount] or 0) + 1
    end
    if player.uid == eventData.targetRoleUid then
      stat[bc.StatsKey.PlayerDeathCount] = (stat[bc.StatsKey.PlayerDeathCount] or 0) + 1
    end
  end
  local killCount = self.data.curBoutStats[bc.StatsKey.KillCount] or 0
  changeMaxKill(self.data.globalStats, killCount)
  changeMaxKill(self.data.battleStats, killCount)
end

function BattleStatsMgrPVP:SetOverFlowEnergy(value)
  for _, stat in ipairs({
    self.data.globalStats,
    self.data.battleStats,
    self.data.curBoutStats
  }) do
    stat[bc.StatsKey.OverFlowEnergy] = value
  end
end

function BattleStatsMgrPVP:OnShuffleCards(eventData)
  if not self:IsCampMatch() then
    return
  end
  for _, stat in ipairs({
    self.data.globalStats,
    self.data.battleStats,
    self.data.curBoutStats
  }) do
    stat[bc.StatsKey.DrawDeckResetCount] = (stat[bc.StatsKey.DrawDeckResetCount] or 0) + 1
  end
end

function BattleStatsMgrPVP:OnLaunchJump(eventData)
  if not self:IsCampMatch() then
    return
  end
  if eventData.isExtraBout then
    self.data.curBoutStats[bc.StatsKey.BoutMaxJump] = (self.data.curBoutStats[bc.StatsKey.BoutMaxJump] or 0) + 1
    local battleMax = self.data.battleStats[bc.StatsKey.BoutMaxJump] or 0
    if battleMax < self.data.curBoutStats[bc.StatsKey.BoutMaxJump] then
      self.data.battleStats[bc.StatsKey.BoutMaxJump] = self.data.curBoutStats[bc.StatsKey.BoutMaxJump]
    end
  end
end

function BattleStatsMgrPVP:OnTentacleAttack(eventData)
  if not self:IsCampMatch() then
    return
  end
  self.data.curBoutStats[bc.StatsKey.BoutMaxTentacleAttack] = (self.data.curBoutStats[bc.StatsKey.BoutMaxTentacleAttack] or 0) + 1
  local battleMax = self.data.battleStats[bc.StatsKey.BoutMaxTentacleAttack] or 0
  if battleMax < self.data.curBoutStats[bc.StatsKey.BoutMaxTentacleAttack] then
    self.data.battleStats[bc.StatsKey.BoutMaxTentacleAttack] = self.data.curBoutStats[bc.StatsKey.BoutMaxTentacleAttack]
  end
end

function BattleStatsMgrPVP:GetStats(type, attr)
  local stats = self.typeToStats[type]
  return stats[attr] or 0
end

function BattleStatsMgrPVP:GetUsedCountOfCardByConfigId(type, cardConfigId)
  local stats = self.typeToStats[type]
  local usedCardStats = stats[bc.StatsKey.UsedCardCountByConfigId]
  if nil == usedCardStats then
    return 0
  end
  return usedCardStats[cardConfigId] or 0
end

function BattleStatsMgrPVP:RecordBlock(block)
  self.data.lastBoutStats[bc.StatsKey.SurplusBlock] = block
end

function BattleStatsMgrPVP:OnSendEmoji(eventData)
  if eventData.playerId ~= self.entity.data.playerId then
    return
  end
  local globalStats = self.data.globalStats
  if not globalStats[bc.StatsKey.EmojiCount] then
    globalStats[bc.StatsKey.EmojiCount] = {}
  end
  globalStats[bc.StatsKey.EmojiCount][eventData.emoji] = (globalStats[bc.StatsKey.EmojiCount][eventData.emoji] or 0) + 1
end

function BattleStatsMgrPVP:UpdateStats()
  self.battleEngine.instantRecordMgr:OnUpdateStats(self.entity:GetCamp(), self:Serialize())
end

function BattleStatsMgrPVP:ProcessRoleStats(cmdServerUid, statKey, value)
  if not cmdServerUid then
    return
  end
  if not self:IsCampMatch() then
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
    self:AddAwakerStats(cmdServer.castRoleUid, statKey, value)
  elseif isFromState then
    self:ProcessStateStats(cmdServer, statKey, value)
  else
    self.battleEngine:DebugS("ProcessRoleStats未知事件来源类型 {cmdServerUid}", cmdServer.uid)
  end
end

function BattleStatsMgrPVP:ProcessStateStats(cmdServer, statKey, value)
  local ownershipUidToValue = BattleActionStatsUtil.CalcStateOwnershipUidToValue(self.battleEngine, cmdServer, value)
  for castRoleUid, allocatedValue in pairs(ownershipUidToValue) do
    if allocatedValue > 0 then
      self:AddAwakerStats(castRoleUid, statKey, allocatedValue)
    end
  end
end

function BattleStatsMgrPVP:AddAwakerStats(roleUid, statKey, value)
  if not (roleUid and statKey and value) or 0 == value then
    return
  end
  local role = self.battleEngine:GetObj(roleUid)
  if not role then
    return
  end
  local roleTid = role.tid or 0
  local roleStr = role:GetBattleLogName()
  local str = string.format("增加战斗统计：%s 造成 %s 值 %s", roleStr, statKey, value)
  self.battleEngine:LogBattleWithTab(str)
  local player = role:GetPlayer()
  local statsComp = player.battleStats
  local statsToUpdate = {
    statsComp.data.globalStats,
    statsComp.data.battleStats,
    statsComp.data.curBoutStats
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
end

function BattleStatsMgrPVP:OnBEChangeAttrHp(eventData)
  if not self:IsCampMatch() then
    return
  end
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
  local targetCamp = target:GetCamp()
  local selfCamp = self.entity:GetCamp()
  if castValue < 0 then
    if targetCamp ~= selfCamp then
      local damage = math.abs(castValue)
      self:ProcessRoleStats(eventData.cmdServerUid, bc.StatsKey.AwakerDoDamage, damage)
    end
  elseif castValue > 0 and targetCamp == selfCamp then
    local heal = castValue
    self:ProcessRoleStats(eventData.cmdServerUid, bc.StatsKey.AwakerDoHeal, heal)
  end
end

function BattleStatsMgrPVP:OnModifyHp(eventData)
  if eventData.ignoreStats then
    return
  end
  if not self:IsCampMatch() then
    return
  end
  local castValue = eventData.modifyVal
  if not castValue or 0 == castValue then
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
  local targetCamp = target:GetCamp()
  local selfCamp = self.entity:GetCamp()
  if castValue < 0 then
    if targetCamp ~= selfCamp then
      local damage = math.abs(castValue)
      self:ProcessRoleStats(eventData.fromCmdServerUid, bc.StatsKey.AwakerDoDamage, damage)
    end
  elseif castValue > 0 and targetCamp == selfCamp then
    local heal = castValue
    self:ProcessRoleStats(eventData.fromCmdServerUid, bc.StatsKey.AwakerDoHeal, heal)
  end
end

function BattleStatsMgrPVP:OnBEChangeAttrBlock(eventData)
  if not self:IsCampMatch() then
    return
  end
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
  if caster:GetCamp() ~= target:GetCamp() then
    return
  end
  self:ProcessRoleStats(eventData.cmdServerUid, bc.StatsKey.AwakerDoBlock, castValue)
end

return BattleStatsMgrPVP
