local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleCardServer = require("Battle.DbgEngine.Card.BattleCardServer")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local bc = require("Battle.BattleConst")
local BEAddStateParent, _ = System.NewClass("BEAddStateParent", BattleEffectServer)

function BEAddStateParent:__ShowTips(targetUid, stateId)
  local args = {stateId = stateId}
  self.battleEngine.recordMgr:OnFloatingText(targetUid, "Battle_Tips_Immune", bc.FloatingTextType.PositiveTextAndIcon, args)
end

function BEAddStateParent:CheckImmue(target, stateId)
  local DT = self.battleEngine.battleDT
  local stateCfg = DT.State[stateId]
  local immueBuff = target:GetProperty(bc.BattleProperty.immue_buff)
  local immueDebuff = target:GetProperty(bc.BattleProperty.immue_debuff)
  local immueBoth = target:GetProperty(bc.BattleProperty.immue_both_buff)
  if immueBoth and immueBoth > 0 and stateCfg.IsBuff ~= bc.BuffType.None then
    self:__ShowTips(target.uid)
    return true
  end
  if immueBuff and immueBuff > 0 and stateCfg.IsBuff == bc.BuffType.Buff then
    self:__ShowTips(target.uid)
    return true
  end
  if immueDebuff and immueDebuff > 0 and stateCfg.IsBuff == bc.BuffType.Debuff then
    self:__ShowTips(target.uid)
    return true
  end
  for _, propertyName in pairs(bc.PropertyImmueState) do
    local apiCfg = DT.BattleApi[propertyName]
    local immueStateIds = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
    for _, immueStateId in ipairs(immueStateIds) do
      local property = target:GetProperty(propertyName) or 0
      if stateId == immueStateId and property > 0 then
        self:__ShowTips(target.uid, stateId)
        return true
      end
    end
  end
  return false
end

function BEAddStateParent:FixStateLayerByStateId(stateId, layer)
  local stateIds = self.battleEngine.battleDT:GetOriginalConstant("DimensionStateList")
  for _, v in ipairs(stateIds or {}) do
    if v == stateId then
      local oldLayer = layer
      layer = self:CalFinalVal(layer)
    end
  end
  return layer
end

function BEAddStateParent:IsStateTriggerAdd()
  local cmdServer = self.cmdServer
  return cmdServer and cmdServer.cmdCtorData and cmdServer.cmdCtorData.isTrigger
end

function BEAddStateParent:IsUltiSkill()
  local cmdServer = self.cmdServer
  if not cmdServer then
    return false
  end
  local skillTypes = cmdServer:GetSkillType() or {}
  for _, skillType in ipairs(skillTypes) do
    if skillType == bc.SkillType.Ulti_Skill then
      return true
    end
  end
  return false
end

function BEAddStateParent:__CalcStateLayer(layer, stateId, target)
  layer = math.ceil(tonumber(layer) or 1)
  local DT = self.battleEngine.battleDT
  local skipCasterStateLayerPer = self.effectConfig and self.effectConfig.skipCasterStateLayerPerAfterFormula
  if not skipCasterStateLayerPer then
    layer = self:ApplyCasterStateLayerPer(layer, stateId)
    if not self:IsStateTriggerAdd() then
      layer = self:ApplyUltiStateLayerPer(layer, stateId)
      layer = self:ApplyCmdCardStateLayerPer(layer, stateId)
      layer = self:ApplyCardStateLayerPer(layer, stateId)
    end
  end
  layer = self:ApplyTargetStateLayerPer(layer, stateId, target, DT)
  layer = self:__CalcDirectCmdStateLayer(layer, stateId, target)
  layer = self:FixStateLayerByStateId(stateId, layer)
  do return math.ceil end
  return math.ceil, layer, stateId, layer, target, DT
end

function BEAddStateParent:ApplyTargetStateLayerPer(layer, stateId, target, DT)
  for _, propertyName in pairs(bc.BeStateLayerPer) do
    local apiCfg = DT.BattleApi[propertyName]
    if apiCfg and apiCfg.Data then
      local ids = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
      for _, id in ipairs(ids) do
        if stateId == id then
          local property = target:GetProperty(propertyName) or 0
          layer = layer * (1 + property / 100)
        end
      end
    end
  end
  return layer
end

function BEAddStateParent:ApplyCasterStateLayerPer(layer, stateId)
  local cmdServer = self.cmdServer
  local caster = cmdServer and cmdServer:GetCaster()
  if not caster then
    return layer
  end
  local DT = self.battleEngine.battleDT
  local card = self.battleEngine:GetCurCard()
  local isCardSkill = false
  if card and card:is(BattleCardServer) then
    isCardSkill = card:CardTypeMatch({
      bc.SkillType.Card_Skill,
      bc.SkillType.Card_Defend,
      bc.SkillType.Card_Extend,
      bc.SkillType.Card_Strike
    })
  end
  local isTrigger = cmdServer and cmdServer.cmdCtorData and cmdServer.cmdCtorData.isTrigger
  local isAwaker = caster:IsRoleType(bc.RoleType.Awaker)
  for _, propertyName in pairs(bc.StateLayerPer) do
    local apiCfg = DT.BattleApi[propertyName]
    if apiCfg and apiCfg.Data then
      local ids = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
      for _, id in ipairs(ids) do
        if stateId == id then
          local property = caster:GetProperty(propertyName) or 0
          if propertyName == bc.AwakerProperty.o_state_layer_per_power_bycmd then
            if not isTrigger and isCardSkill and isAwaker then
              layer = layer * (1 + property / 100)
            end
          else
            layer = layer * (1 + property / 100)
          end
        end
      end
    end
  end
  return layer
end

function BEAddStateParent:ApplyUltiStateLayerPer(layer, stateId)
  local cmdServer = self.cmdServer
  local caster = cmdServer and cmdServer:GetCaster()
  if not caster then
    return layer
  end
  local DT = self.battleEngine.battleDT
  if not self:IsUltiSkill() then
    return layer
  end
  for _, propertyName in pairs(bc.UltiStateLayerPer) do
    local apiCfg = DT.BattleApi[propertyName]
    if apiCfg and apiCfg.Data then
      local ids = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
      for _, id in ipairs(ids) do
        if stateId == id then
          local property = caster:GetProperty(propertyName) or 0
          layer = layer * (1 + property / 100)
        end
      end
    end
  end
  return layer
end

function BEAddStateParent:ApplyCmdCardStateLayerPer(layer, stateId)
  local cmdServer = self.cmdServer
  local caster = cmdServer and cmdServer:GetCaster()
  if not caster then
    return layer
  end
  local card = self.battleEngine:GetCurCard()
  if not card or not card:CardTypeMatch(bc.CardTypeInstruction) then
    return layer
  end
  local DT = self.battleEngine.battleDT
  for _, propertyName in pairs(bc.CmdCardStateLayerPer) do
    local apiCfg = DT.BattleApi[propertyName]
    if apiCfg and apiCfg.Data then
      local ids = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
      for _, id in ipairs(ids) do
        if stateId == id then
          local property = caster:GetProperty(propertyName) or 0
          layer = layer * (1 + property / 100)
        end
      end
    end
  end
  return layer
end

function BEAddStateParent:GetCardForStateLayerPer()
  local cmdServer = self.cmdServer
  if cmdServer and cmdServer.stateUid then
    local triggerState = self.battleEngine:GetObj(cmdServer.stateUid)
    if triggerState and triggerState.owner and triggerState.owner:is(BattleCardServer) then
      return triggerState.owner
    end
  end
  do return self.battleEngine.GetCurCard end
  return self.battleEngine.GetCurCard, self.battleEngine, triggerState.owner, BattleCardServer
end

function BEAddStateParent:ApplyCardStateLayerPer(layer, stateId)
  local card = self:GetCardForStateLayerPer()
  if not card then
    return layer
  end
  local isInstructionCard = card:CardTypeMatch(bc.CardTypeInstruction)
  local caster = self.cmdServer and self.cmdServer:GetCaster()
  local DT = self.battleEngine.battleDT
  for _, propertyName in pairs(bc.StateLayerPerByCard) do
    local apiCfg = DT.BattleApi[propertyName]
    if apiCfg and apiCfg.Data then
      local ids = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
      for _, id in ipairs(ids) do
        if stateId == id then
          local property = card:GetProperty(propertyName) or 0
          local n2Prop = bc.CardStateLayerPerWithAwakerN2[propertyName]
          local n2Per = 0
          if n2Prop and caster and isInstructionCard then
            n2Per = caster:GetProperty(n2Prop) or 0
          end
          layer = layer * (1 + property / 100 + n2Per / 100)
        end
      end
    end
  end
  return layer
end

function BEAddStateParent:ApplyUltiFixedStateLayerPer(layer, stateId)
  local cmdServer = self.cmdServer
  local caster = cmdServer and cmdServer:GetCaster()
  if not caster then
    return layer
  end
  local DT = self.battleEngine.battleDT
  if not self:IsUltiSkill() then
    return layer
  end
  for _, propertyName in pairs(bc.UltiFixedStateLayerPer) do
    local apiCfg = DT.BattleApi[propertyName]
    if apiCfg and apiCfg.Data then
      local ids = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
      for _, id in ipairs(ids) do
        if stateId == id then
          local property = caster:GetProperty(propertyName) or 0
          layer = layer * (1 + property / 100)
        end
      end
    end
  end
  return layer
end

function BEAddStateParent:ApplyCmdCardFixedStateLayerPer(layer, stateId)
  local cmdServer = self.cmdServer
  local caster = cmdServer and cmdServer:GetCaster()
  if not caster then
    return layer
  end
  local card = self.battleEngine:GetCurCard()
  if not card or not card:CardTypeMatch(bc.CardTypeInstruction) then
    return layer
  end
  local DT = self.battleEngine.battleDT
  for _, propertyName in pairs(bc.CmdCardFixedStateLayerPer) do
    local apiCfg = DT.BattleApi[propertyName]
    if apiCfg and apiCfg.Data then
      local ids = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
      for _, id in ipairs(ids) do
        if stateId == id then
          local property = caster:GetProperty(propertyName) or 0
          layer = layer * (1 + property / 100)
        end
      end
    end
  end
  return layer
end

function BEAddStateParent:ApplyCardFixedStateLayerPer(layer, stateId)
  local card = self:GetCardForStateLayerPer()
  if not card then
    return layer
  end
  local isInstructionCard = card:CardTypeMatch(bc.CardTypeInstruction)
  local caster = self.cmdServer and self.cmdServer:GetCaster()
  local DT = self.battleEngine.battleDT
  for _, propertyName in pairs(bc.CardFixedStateLayerPer) do
    local apiCfg = DT.BattleApi[propertyName]
    if apiCfg and apiCfg.Data then
      local ids = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
      for _, id in ipairs(ids) do
        if stateId == id then
          local property = card:GetProperty(propertyName) or 0
          local n2Prop = bc.CardFixedStateLayerPerWithAwakerN2[propertyName]
          local n2Per = 0
          if n2Prop and caster and isInstructionCard then
            n2Per = caster:GetProperty(n2Prop) or 0
          end
          layer = layer * (1 + property / 100 + n2Per / 100)
        end
      end
    end
  end
  return layer
end

function BEAddStateParent:__CalcDirectCmdStateLayer(layer, stateId, target)
  local DT = self.battleEngine.battleDT
  local cmdServer = self.cmdServer
  local isStateTriggerAdd = cmdServer and cmdServer.cmdCtorData and cmdServer.cmdCtorData.isTrigger
  if not self.effectConfig.noDirectCmd then
    for _, propertyName in pairs(bc.BeDirectCmdStateLayerPer) do
      local apiCfg = DT.BattleApi[propertyName]
      if apiCfg and apiCfg.Data then
        local ids = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
        for _, id in ipairs(ids) do
          if stateId == id then
            local property = target:GetProperty(propertyName) or 0
            layer = layer * (1 + property / 100)
          end
        end
      end
    end
  end
  if self.effectConfig.noDirectCmd or isStateTriggerAdd then
    return layer
  end
  layer = self:ApplyUltiFixedStateLayerPer(layer, stateId)
  layer = self:ApplyCmdCardFixedStateLayerPer(layer, stateId)
  layer = self:ApplyCardFixedStateLayerPer(layer, stateId)
  local caster = cmdServer:GetCaster()
  if caster then
    for _, propertyName in pairs(bc.DirectCmdStateLayerPer) do
      local apiCfg = DT.BattleApi[propertyName]
      if apiCfg and apiCfg.Data then
        local ids = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
        for _, id in ipairs(ids) do
          if stateId == id then
            local property = caster:GetProperty(propertyName) or 0
            layer = layer * (1 + property / 100)
          end
        end
      end
    end
  end
  return layer
end

function BEAddStateParent:AddState(target, stateId, layer, stateParams, minLayer)
  local skillLevel = self.cmdServer:GetSkillLevel()
  local targetRoleUid = target.uid
  local immue = self:CheckImmue(target, stateId)
  if immue then
    local cfg = self.battleEngine.battleDT.State[stateId]
    self.battleEngine:LogBattleWithTab("目标免疫，%s 状态添加失败", cfg.CnID)
    return
  end
  minLayer = minLayer or 0
  layer = self:__CalcStateLayer(layer, stateId, target)
  local newLayer = math.max(minLayer, layer)
  if target.CalcStateLayerLimit then
    newLayer = target:CalcStateLayerLimit(stateId, layer)
    if layer > 0 and newLayer <= 0 then
      local cfg = self.battleEngine.battleDT.State[stateId]
      self.battleEngine:LogBattleWithTab("本次添加状态层数超过上限，%s 状态添加失败", cfg.CnID)
      self:__ShowTips(target.uid, stateId)
      return
    end
  end
  if target.CalcStateLayerLimitTotal then
    newLayer = target:CalcStateLayerLimitTotal(stateId, layer)
    if layer > 0 and newLayer <= 0 then
      local cfg = self.battleEngine.battleDT.State[stateId]
      self.battleEngine:LogBattleWithTab("目标状态总层数到达上限，%s 状态添加失败", cfg.CnID)
      self:__ShowTips(target.uid, stateId)
      return
    end
  end
  local stateCfg = self.battleEngine.battleDT.State[stateId]
  local source = self.effectConfig.source
  if (not source or not source[1]) and target:is(BattleCardServer) and BattleUtilServer.IsForceExistState(stateCfg) then
    source = BattleUtilServer.BuildExistStateSource(target.data.tid, newLayer)
    self.battleEngine:InfoS("ForceExistAddState {cardTid} {cardUid} {stateId} {layer}", target.data.tid, target.uid, stateId, newLayer)
  end
  local createArgs = {
    stateId = stateId,
    layer = newLayer,
    castRoleUid = self.cmdServer.castRoleUid,
    targetUid = target.uid,
    targetRoleUid = targetRoleUid,
    targetCardUid = target:is(BattleCardServer) and target.uid,
    stateParams = stateParams,
    source = source,
    skillLevel = skillLevel,
    cmdServerUid = self.cmdServer and self.cmdServer.uid
  }
  self.battleEngine.stateMgr:CreateState(target, createArgs)
end

return BEAddStateParent
