local System = require("System.System")
local BattleCmdBaseExpression = require("Battle.DbgEngine.Cmd.Expression.BattleCmdBaseExpression")
local bc = require("Battle.BattleConst")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local BP = bc.BattleProperty
local BattleCmdTargetsExp, Super = System.NewClass("BattleCmdTargetsExp", BattleCmdBaseExpression)

function BattleCmdTargetsExp:ctor(cmdParser, targets)
  Super.ctor(self)
  self.battleEngine = cmdParser.battleEngine
  self.cmdParser = cmdParser
  self.targets = targets or {}
  self:InitGetter(cmdParser.battleEngine.battleDT)
end

local function GetAvgAttr(target, attrType)
  if target.roleType ~= bc.RoleType.Player then
    return 0
  end
  local awakerList = target:GetAwakerList()
  local total = 0
  for _, awaker in ipairs(awakerList) do
    local num = awaker:GetProperty(attrType) or 0
    total = total + num
  end
  do return math.max, 0 end
  return math.max, 0, total / #awakerList, ipairs(awakerList)
end

local AttrFunc = {
  ID = function(target)
    if not target.GetID then
      return 0
    end
    do return target.GetID end
    return target.GetID, target
  end,
  uid = function(target)
    return target.uid
  end,
  UniqueID = function(target)
    return target.uid
  end,
  School = function(target)
    if not target.GetSchoolConfigId then
      return 0
    end
    do return target.GetSchoolConfigId end
    return target.GetSchoolConfigId, target
  end,
  AwakerType = function(target)
    if not target.GetAwakerType then
      return 0
    end
    do return target.GetAwakerType end
    return target.GetAwakerType, target
  end,
  IntentionType = function(target)
    if target.roleType ~= bc.RoleType.Monster then
      return 0
    end
    do return target.monsterBehaviorComp.GetIntentionType end
    return target.monsterBehaviorComp.GetIntentionType, target.monsterBehaviorComp
  end,
  Intention = function(target)
    if target.roleType ~= bc.RoleType.Monster then
      return 0
    end
    return target.monsterBehaviorComp:GetIntention() or 0
  end,
  CycleListIndex = function(target)
    if target.roleType ~= bc.RoleType.Monster then
      return 0
    end
    local skillListType = target.monsterBehaviorComp.skillListType
    local i = tonumber(string.replace(skillListType, "CycleSkillList", "", true))
    return i
  end,
  MonsterAttackTimes = function(target)
    if target.roleType ~= bc.RoleType.Monster then
      return 0
    end
    return target.monsterBehaviorComp.damageTimes or 0
  end,
  MonsterPos = function(target)
    if not target.GetBattleFieldPos then
      return 0
    end
    do return target.GetBattleFieldPos end
    return target.GetBattleFieldPos, target
  end,
  Level = function(target)
    return target.level
  end,
  Type = function(target)
    do return target.GetType end
    return target.GetType, target
  end,
  CurDeck = function(target)
    if not target.deck then
      return 0
    end
    return target.deck
  end,
  ConsumeEnergy = function(target)
    return target.realCost or 0
  end,
  card_cost = function(target)
    return target.GetUseCost and target:GetUseCost() or 0
  end,
  reverse_state_count = function(target)
    do return target.battleEngine.stateMgr.GetStateNum, target.battleEngine.stateMgr, target end
    return target.battleEngine.stateMgr.GetStateNum, target.battleEngine.stateMgr, target, bc.BuffType.Debuff
  end,
  positive_state_count = function(target)
    do return target.battleEngine.stateMgr.GetStateNum, target.battleEngine.stateMgr, target end
    return target.battleEngine.stateMgr.GetStateNum, target.battleEngine.stateMgr, target, bc.BuffType.Buff
  end,
  CurDeathResist = function(target)
    return target.GetCurDeathResist and target:GetCurDeathResist() or 0
  end,
  tentacle_dmg = function(target)
    if target.GetTentacleDamage then
      do return target.GetTentacleDamage end
      return target.GetTentacleDamage, target
    end
    return 0
  end,
  tentacle_dmg_show = function(target)
    if target.GetShowTentacleDamage then
      do return target.GetShowTentacleDamage end
      return target.GetShowTentacleDamage, target
    end
    return 0
  end,
  Camp = function(target)
    do return target.GetCamp end
    return target.GetCamp, target
  end,
  AvgCrit = function(target)
    do return GetAvgAttr, target end
    return GetAvgAttr, target, BP.crit
  end,
  AvgCritDamage = function(target)
    do return GetAvgAttr, target end
    return GetAvgAttr, target, BP.crit_damage
  end,
  AvgPhysique = function(target)
    do return GetAvgAttr, target end
    return GetAvgAttr, target, BP.physique
  end,
  AvgDefence = function(target)
    do return GetAvgAttr, target end
    return GetAvgAttr, target, BP.def
  end,
  TargetType = function(target)
    local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
    if target.is and target:is(BattleCardServer) then
      return bc.ObjType.TypeCard
    end
    local BattleUnitBase = require("Battle.DbgEngine.Role.BattleUnitBase")
    if target.is and target:is(BattleUnitBase) then
      do return target.GetTargetType end
      return target.GetTargetType, target, BattleUnitBase
    end
  end,
  MonsterType = function(target)
    if target:IsRoleType(bc.RoleType.Monster) then
      do return target.GetType end
      return target.GetType, target, bc.RoleType.Monster
    end
  end,
  MonsterCategory = function(target)
    if target:IsRoleType(bc.RoleType.Monster) then
      do return target.GetCfgCol, target end
      return target.GetCfgCol, target, "Category"
    end
  end,
  [BP.max_monster_hp_num] = function(target)
    if target:IsRoleType(bc.RoleType.Monster) then
      do return target.GetMaxHpNum end
      return target.GetMaxHpNum, target, bc.RoleType.Monster
    end
  end,
  [BP.monster_hp_num] = function(target)
    if target:IsRoleType(bc.RoleType.Monster) then
      do return target.GetHpNum end
      return target.GetHpNum, target, bc.RoleType.Monster
    end
  end,
  CardType = function(target)
    local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
    if target.is and target.is(BattleCardServer) then
      do return target.GetType end
      return target.GetType, target
    end
  end,
  [BP.tentacle_crit_dmg] = function(target)
    if not target.schoolCompPVE then
      return 0
    end
    do return target.schoolCompPVE.GetTentacleCritDmg end
    return target.schoolCompPVE.GetTentacleCritDmg, target.schoolCompPVE
  end,
  [BP.tentacle_crit] = function(target)
    if not target.schoolCompPVE then
      return 0
    end
    do return target.schoolCompPVE.GetTentacleCrit end
    return target.schoolCompPVE.GetTentacleCrit, target.schoolCompPVE
  end,
  CmdID = function(target)
    if not target.GetCmdID then
      return 0
    end
    do return target.GetCmdID end
    return target.GetCmdID, target
  end,
  slot = function(target)
    local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
    if not target.is or not target:is(BattleCardServer) then
      return 0
    end
    return target.configData.Slot
  end,
  MaxUltiEnergy = function(target)
    if not target.property then
      return 0
    end
    do return target.property.GetMaxUltiEnergy end
    return target.property.GetMaxUltiEnergy, target.property
  end,
  BasicKeeperEnergy = function(target)
    if not target.property then
      return 0
    end
    do return target.property.GetBasicKeeperEnergy end
    return target.property.GetBasicKeeperEnergy, target.property
  end,
  MaxKeeperEnergy = function(target)
    if not target.property then
      return 0
    end
    do return target.property.GetMaxKeeperEnergy end
    return target.property.GetMaxKeeperEnergy, target.property
  end,
  allowIgnoreCost = function(target)
    if not target.allowIgnoreCost then
      return 0
    end
    return target.allowIgnoreCost
  end,
  AtkForce = function(target)
    do return math.ceil end
    return math.ceil, target:GetProperty(BP.atk) * (1 + target:GetProperty(BP.atk_per) / 100), 1 + target:GetProperty(BP.atk_per) / 100, target, BP.atk_per
  end,
  DefForce = function(target)
    do return math.ceil end
    return math.ceil, target:GetProperty(BP.def) * (1 + target:GetProperty(BP.def_per) / 100), 1 + target:GetProperty(BP.def_per) / 100, target, BP.def_per
  end
}

function BattleCmdTargetsExp:GetAttr(attrName)
  local target = self.targets and self.targets[1]
  if "TargetCmdOwner" == attrName then
    if not target then
      local exp = BattleCmdTargetsExp(self.cmdParser, {})
      return exp
    end
    local owner
    local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
    if target:is(BattleCardServer) then
      owner = target:GetOwner()
    else
      self.battleEngine:Warn("仅卡牌可以访问所属角色")
    end
    local exp = BattleCmdTargetsExp(self.cmdParser, {owner})
    return exp
  end
  if "OriginalTargetCmdOwner" == attrName then
    if not target then
      local exp = BattleCmdTargetsExp(self.cmdParser, {})
      return exp
    end
    local owner
    local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
    if target:is(BattleCardServer) then
      owner = target:GetOriginOwner()
    else
      self.battleEngine:Warn("仅卡牌可以访问所属角色")
    end
    local exp = BattleCmdTargetsExp(self.cmdParser, {owner})
    return exp
  end
  if not target then
    return 0
  end
  if "TargetCount" == attrName then
    return #self.targets
  end
  local attrFunc = AttrFunc[attrName]
  if attrFunc then
    do return attrFunc, target end
    return attrFunc, target, self, {owner}, owner
  elseif target.GetProperty then
    do return target.GetProperty, target end
    return target.GetProperty, target, attrName, {owner}, owner
  else
    self.battleEngine:Error("找不到对应的属性" .. attrName)
    return 0
  end
end

function BattleCmdTargetsExp:GetStateLayer(stateName)
  local target = self.targets and self.targets[1]
  if not target then
    return 0
  end
  local state = target.battleEngine.stateMgr:GetState(target, stateName)
  if not state or state.isDeleted then
    return 0
  end
  return state.data.layer
end

function BattleCmdTargetsExp:GetMonsterDamage()
  local totalDamage = 0
  for _, target in ipairs(self.targets or {}) do
    if not target.monsterBehaviorComp then
    else
      local damageInfo = target.monsterBehaviorComp:GetDamageInfoValue()
      totalDamage = totalDamage + (damageInfo and damageInfo[1] or 0)
    end
  end
  return totalDamage
end

function BattleCmdTargetsExp:GetMonsterDamagePerHit()
  local target = self.targets and self.targets[1]
  if not target or not target.monsterBehaviorComp then
    return 0
  end
  local damageInfo = target.monsterBehaviorComp:GetDamageInfo()
  return damageInfo[1] or 0
end

function BattleCmdTargetsExp:GetStateParam(stateTid, index)
  local target = self.targets and self.targets[1]
  if not target then
    return 0
  end
  local state = target.battleEngine.stateMgr:GetState(target, stateTid)
  if not state or state.isDeleted then
    return 0
  end
  return state.stateParams[index] or 0
end

function BattleCmdTargetsExp:GetCardBySlot(slots, num, levelType)
  levelType = levelType or bc.GetCardByIDType.CastSkillLevel
  local level
  if levelType == bc.GetCardByIDType.CastSkillLevel then
    level = self.cmdParser:GetSkillLevel()
  end
  if type(slots) ~= "table" then
    slots = {slots}
  end
  local target = self.targets and self.targets[1]
  if not target then
    return {}
  end
  if not target.GetSlotCards then
    self.battleEngine:Error(string.format("找不到对应卡槽 %s 的卡牌 , 目标没有方法:%s", slot, target.__name))
    return {}
  end
  local targetSlotCards = target:GetSlotCards()
  if not targetSlotCards then
    return {}
  end
  local slotCards = {}
  for _, slot in ipairs(slots) do
    local slotCard = targetSlotCards[slot]
    if slotCard then
      if levelType == bc.GetCardByIDType.SlotCardLevel then
        level = slotCard.level
      end
      table.insert(slotCards, {
        tid = slotCard.tid,
        num = 1,
        level = level,
        camp = target:GetCamp()
      })
    else
      self.battleEngine:Warn("找不到对应卡槽 " .. slot .. " 的卡牌 ")
    end
  end
  BattleUtilServer.Shuffle(self.battleEngine, slotCards)
  local retCards = {}
  for i = 1, num or 1 do
    if slotCards[i] then
      table.insert(retCards, slotCards[i])
    end
  end
  do return target.battleEngine.cardMgr.CreateCardsByID, target.battleEngine.cardMgr, retCards end
  return target.battleEngine.cardMgr.CreateCardsByID, target.battleEngine.cardMgr, retCards, self.cmdParser, table.insert, retCards, slotCards[i], self.battleEngine, "找不到对应卡槽 " .. slot .. " 的卡牌 ", slot, " 的卡牌 "
end

function BattleCmdTargetsExp:IsInDeck(deck)
  local target = self.targets and self.targets[1]
  if not target then
    return 0
  end
  local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
  if not target:is(BattleCardServer) then
    return 0
  end
  return target.deck == deck:_GetDeckName() and 1 or 0
end

function BattleCmdTargetsExp:GetBreakLevel()
  local target = self.targets and self.targets[1]
  if not target then
    return 0
  end
  if not target:IsRoleType(bc.RoleType.Awaker) then
    return 0
  end
  local breakSkillLevel, _ = target:GetBreakSkillAndPotencyLevel()
  return breakSkillLevel
end

function BattleCmdTargetsExp:GetPotencyLevel()
  local target = self.targets and self.targets[1]
  if not target then
    return 0
  end
  if not target:IsRoleType(bc.RoleType.Awaker) then
    return 0
  end
  local _, potencyLevel = target:GetBreakSkillAndPotencyLevel()
  return potencyLevel
end

function BattleCmdTargetsExp:GetAwakerSkillMultiplier()
  local target = self.targets and self.targets[1]
  if not target then
    return 0
  end
  if not target:IsRoleType(bc.RoleType.Awaker) then
    self.battleEngine:Error("仅唤醒体可以访问‘技能倍率’")
    return 0
  end
  return target.battleEngine.battleDT.AwakerUpgrade[target.level].SkillMultiplier or 0
end

function BattleCmdTargetsExp:GetAwakerLevelPower()
  local target = self.targets and self.targets[1]
  if not target then
    return 0
  end
  if not target:IsRoleType(bc.RoleType.Awaker) then
    self.battleEngine:Error("仅唤醒体可以访问‘等级强度’")
    return 0
  end
  return target.battleEngine.battleDT.AwakerUpgrade[target.level].AwakerLevelPower or 0
end

function BattleCmdTargetsExp:HasBuff()
  local target = self.targets and self.targets[1]
  if not target then
    return false
  end
  do return self.battleEngine.stateMgr.HasStateByType, self.battleEngine.stateMgr, target.uid end
  return self.battleEngine.stateMgr.HasStateByType, self.battleEngine.stateMgr, target.uid, bc.BuffType.Buff
end

function BattleCmdTargetsExp:HasDebuff()
  local target = self.targets and self.targets[1]
  if not target then
    return false
  end
  do return self.battleEngine.stateMgr.HasStateByType, self.battleEngine.stateMgr, target.uid end
  return self.battleEngine.stateMgr.HasStateByType, self.battleEngine.stateMgr, target.uid, bc.BuffType.Debuff
end

function BattleCmdTargetsExp:HasStateIDList(...)
  local target = self.targets and self.targets[1]
  if not target then
    return false
  end
  local list = table.pack(...)
  do return self.battleEngine.stateMgr.HasStateByStateIds, self.battleEngine.stateMgr, target.uid end
  return self.battleEngine.stateMgr.HasStateByStateIds, self.battleEngine.stateMgr, target.uid, list
end

function BattleCmdTargetsExp:GetEquipWeapon()
  local cardDataList = {}
  local target = self.targets and self.targets[1]
  if target then
    local stateList = self.battleEngine.stateMgr:GetStateListByOwnerUid(target.uid)
    local DT = self.battleEngine.battleDT
    for _, state in ipairs(stateList) do
      local stateCfg = DT.State[state.stateId]
      local collectCfg = DT.PVPCollect[stateCfg.BelongWeapon]
      if not collectCfg then
      else
        local itemCfg = DT.Item[collectCfg.Item]
        if itemCfg and itemCfg.PVPSkill and itemCfg.PVPSkill[1] then
          local data = {
            tid = itemCfg.PVPSkill[1],
            num = 1,
            level = 1,
            camp = self.cmdParser:GetCasterCamp()
          }
          table.insert(cardDataList, data)
        end
      end
    end
  end
  do return target.battleEngine.cardMgr.CreateCardsByID, target.battleEngine.cardMgr, cardDataList end
  return target.battleEngine.cardMgr.CreateCardsByID, target.battleEngine.cardMgr, cardDataList, self.cmdParser, ipairs(stateList)
end

function BattleCmdTargetsExp:CardTypeMatch(...)
  local target = self.targets and self.targets[1]
  if not target then
    return 0
  end
  if not target.CardTypeMatch then
    return 0
  end
  local ret = target:CardTypeMatch({
    ...
  })
  if ret then
    return 1
  end
  return 0
end

function BattleCmdTargetsExp:IsAwaker()
  local target = self.targets and self.targets[1]
  if not target then
    return false
  end
  do return target.IsRoleType, target end
  return target.IsRoleType, target, bc.RoleType.Awaker
end

function BattleCmdTargetsExp:GetFirstTarget()
  local target = self.targets and self.targets[1]
  if not target then
    return
  end
  return target
end

function BattleCmdTargetsExp:GetTargetList()
  return self.targets
end

function BattleCmdTargetsExp:GetLikeLevel()
  local target = self.targets and self.targets[1]
  if not target then
    return 0
  end
  if not target:IsRoleType(bc.RoleType.Awaker) then
    return 0
  end
  do return target.GetLikeLevel end
  return target.GetLikeLevel, target, bc.RoleType.Awaker
end

function BattleCmdTargetsExp:RemoveByUniqueID(uid)
  local list = {}
  for _, target in ipairs(self.targets) do
    if target.uid ~= uid then
      table.insert(list, target)
    end
  end
  do return BattleCmdTargetsExp, self.cmdParser end
  return BattleCmdTargetsExp, self.cmdParser, list, ipairs(self.targets)
end

function BattleCmdTargetsExp:CardTagMatch(...)
  local target = self.targets and self.targets[1]
  if not target then
    return 0
  end
  if not target.CardTagMatch then
    return 0
  end
  local ret = target:CardTagMatch({
    ...
  })
  if ret then
    return 1
  end
  return 0
end

function BattleCmdTargetsExp:HasTag(tag)
  local target = self.targets and self.targets[1]
  local tagManager = target and target.tagManager
  if not tagManager then
    return false
  end
  do return tagManager.HasTag, tagManager end
  return tagManager.HasTag, tagManager, tag
end

return BattleCmdTargetsExp
