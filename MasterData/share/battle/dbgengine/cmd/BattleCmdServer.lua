local System = require("System.System")
local BattleComponent = require("Battle.Ecs.BattleComponent")
local BattleCmdParser = require("Battle.DbgEngine.Cmd.BattleCmdParser")
local bc = require("Battle.BattleConst")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local HUNDRED = 100
local BP = bc.BattleProperty
local BattleCmdServer, Super = System.NewClass("BattleCmdServer", BattleComponent)

function BattleCmdServer:ctor(battleEngine, cmdCtorData)
  Super.ctor(self)
  self.battleEngine = battleEngine
  self.executeCmdIdList = {}
  self.parentCmdServer = nil
  self.cmdCtorData = cmdCtorData
  self.stats = {}
  self.cmdId = cmdCtorData.cmdId
  self.castRoleUid = cmdCtorData.castRoleUid
  self.isPreCmd = cmdCtorData.isPreCmd
  self.cardUid = cmdCtorData.cardUid
  self.skillConfigId = cmdCtorData.skillConfigId
  self.skillLevel = cmdCtorData.skillLevel or 1
  self.configPara = cmdCtorData.configPara
  self.createCardArgs = cmdCtorData.createCardArgs or {}
  self.stateUid = cmdCtorData.stateUid
  self.stateId = cmdCtorData.stateId
  self.isDeleted = false
  self.uid = self.battleEngine:GenObjUid(self)
  self.lastEffectUid = nil
  self:InitCmdParser(cmdCtorData)
end

function BattleCmdServer:InitCmdParser(cmdCtorData)
  local ctorData = {}
  ctorData.cmdServerUid = self.uid
  ctorData.configPara = cmdCtorData.configPara
  ctorData.castRoleUid = cmdCtorData.castRoleUid
  ctorData.cardUid = cmdCtorData.cardUid
  ctorData.skillConfigId = cmdCtorData.skillConfigId
  ctorData.skillLevel = cmdCtorData.skillLevel or 1
  ctorData.stateUid = cmdCtorData.stateUid
  ctorData.stateId = cmdCtorData.stateId
  self.cmdParser = BattleCmdParser(self.battleEngine, ctorData)
  self:SetMemberValue("SkillLevel", self.skillLevel)
end

function BattleCmdServer:UpdateCasterRoleUid(castRoleUid)
  if self.castRoleUid == castRoleUid then
    return
  end
  self.castRoleUid = castRoleUid
  self.cmdParser:UpdateCasterRoleUid(castRoleUid)
end

function BattleCmdServer:TriggerCmd(triggerData, skipPhase)
  if not self.isPreCmd then
    self.battleEngine.boutMgr:IncreaseActionIndex()
  end
  local skillCfg = self.battleEngine.battleDT.Skill[self.skillConfigId]
  local cmdCfg = self.battleEngine.battleDT.Cmd[self.cmdId]
  local stateCfg = self.battleEngine.battleDT.State[self.stateId]
  local str = "执行指令=" .. cmdCfg.CnID
  if skillCfg then
    str = str .. string.format(" 技能=%s （类型：%s）", skillCfg.CnID, self:GetSkillTypeStr())
  end
  if stateCfg then
    str = str .. string.format(" 状态=%s", stateCfg.CnID)
  end
  self.battleEngine:Info(str)
  triggerData = triggerData or {}
  self.triggerData = triggerData
  self.effectList = nil
  self.effectList = self:GenerateEffectList(nil, skipPhase)
  for _, effectObj in ipairs(self.effectList) do
    effectObj:PreTrigger(triggerData)
  end
end

function BattleCmdServer:GetSkillConfigTQList(colName)
  if not self.skillConfigId then
    return
  end
  local skillCfg = self.battleEngine.battleDT.Skill[self.skillConfigId]
  if bc.SkillFormatCondListField[colName] then
    do return BattleUtilServer.GetTrueConditionByCmd, self end
    return BattleUtilServer.GetTrueConditionByCmd, self, skillCfg[colName], nil, nil, nil, nil, nil
  end
  local tqList = skillCfg[colName]
  local breakSkillLevel, potencyLevel = 0, 0
  local awaker = self.battleEngine:GetObj(self.castRoleUid)
  if awaker:IsRoleType(bc.RoleType.Awaker) then
    breakSkillLevel, potencyLevel = awaker:GetBreakSkillAndPotencyLevel()
  end
  local list = BattleUtilServer.GetTQList(tqList, breakSkillLevel, potencyLevel)
  return list
end

function BattleCmdServer:GetSkillConfigTQText(colName)
  if not self.skillConfigId then
    return
  end
  local skillCfg = self.battleEngine.battleDT.Skill[self.skillConfigId]
  local condList = skillCfg["temp" .. colName]
  if condList then
    do return BattleUtilServer.GetTrueConditionByCmd, self end
    return BattleUtilServer.GetTrueConditionByCmd, self, condList, nil, nil, nil, nil, nil
  end
  if skillCfg.IsPVP and bc.SkillCondListField[colName] then
    do return BattleUtilServer.GetTrueConditionByCmd, self end
    return BattleUtilServer.GetTrueConditionByCmd, self, skillCfg[colName], nil, nil, nil, nil, nil
  end
  local tqText = skillCfg[colName]
  if tqText then
    local breakSkillLevel, potencyLevel = 0, 0
    local awaker = self.battleEngine:GetObj(self.castRoleUid)
    if awaker:IsRoleType(bc.RoleType.Awaker) then
      breakSkillLevel, potencyLevel = awaker:GetBreakSkillAndPotencyLevel()
    end
    do return BattleUtilServer.GetTQText, tqText, breakSkillLevel end
    return BattleUtilServer.GetTQText, tqText, breakSkillLevel, potencyLevel
  end
end

function BattleCmdServer:__CalcBaseSkillArgs()
  local skillArgs = {}
  local configPara = self.configPara or self:GetSkillConfigTQText("Para")
  local skillCfg = self.battleEngine.battleDT.Skill[self.skillConfigId]
  if configPara and skillCfg then
    local formula = self:GetSkillConfigTQList("CoefficientTypelist")
    for i, f in ipairs(formula or {}) do
      local originalArgValue = 1
      local originalCoefficient = self:GetSkillConfigTQList("OriginalCoefficient")
      originalArgValue = originalCoefficient and originalCoefficient[i] or originalArgValue
      self:SetMemberValue("GrowArgValue", originalArgValue)
      local formulaValue = self:GetValueByCmd(f)
      self:SetMemberValue("GrowArgValue" .. i, formulaValue)
    end
    if type(configPara) == "table" then
      for _, str in ipairs(configPara) do
        table.insert(skillArgs, self:GetValueByCmd(str))
      end
    else
      skillArgs = self:GetValueListByCmd(configPara)
    end
  end
  return skillArgs
end

function BattleCmdServer:GetSkillArgs()
  local skillArgs = self:__CalcBaseSkillArgs()
  local ap = {}
  for i, v in ipairs(skillArgs) do
    ap["Arg" .. i] = self.createCardArgs[i] or v
    if type(v) == "number" then
      v = math.ceil(v)
    end
    skillArgs[i] = v
  end
  for i, v in ipairs(self.createCardArgs) do
    skillArgs[i] = v
  end
  local descArgs = {
    curValues = {},
    baseValues = {}
  }
  if self.skillConfigId then
    local desc = self:GetSkillConfigTQText("Desc")
    local battleDesc = self:GetSkillConfigTQText("BattleDesc")
    local overLimitUtlSkillDesc = self:GetSkillConfigTQText("OverLimitUtlSkillDesc")
    desc = battleDesc or desc or ""
    if overLimitUtlSkillDesc then
      do
        local awaker = self.battleEngine:GetObj(self.castRoleUid)
        if awaker:IsRoleType(bc.RoleType.Awaker) and awaker:CanUseSuperUtlSkill() then
          desc = overLimitUtlSkillDesc
        end
      end
    end
    for valueStr in string.gmatch(desc, "%b[]") do
      valueStr = string.match(valueStr, "%[(.+)]")
      local subStrs = string.split(valueStr, ":")
      local tagStr = #subStrs > 1 and subStrs[1] or nil
      local argName = subStrs[#subStrs]
      local value = ap[argName] or 0
      local paraPlusName = string.gsub(argName, "Arg", "ParaPlus")
      if "Float" ~= tagStr then
        value = math.ceil(value)
      end
      local curValue, baseValue = value, value
      if "Damage" == tagStr then
        curValue, baseValue = self:__GetShowDamage(value, paraPlusName)
      elseif "Block" == tagStr then
        curValue, baseValue = self:__GetShowBlock(value, paraPlusName)
      elseif "Energy" == tagStr then
        curValue, baseValue = self:__GetShowUltiEnergy(value)
      elseif "Heal" == tagStr then
        curValue, baseValue = self:__GetShowHeal(value, paraPlusName)
      elseif "Blood" == tagStr then
        curValue, baseValue = self:GetShowScarletBlood(baseValue)
      elseif "AttackTimes" == tagStr then
        curValue, baseValue = self:__GetAttackTimes(value)
      elseif "Poison" == tagStr then
        curValue, baseValue = self:__GetShowPoison(value)
      elseif "Corrosion" == tagStr then
        curValue, baseValue = self:__GetShowCorrosion(value)
      elseif "Counterattack" == tagStr then
        curValue, baseValue = self:__GetShowCounterattack(value)
      elseif "FateCut" == tagStr then
        curValue, baseValue = self:__GetShowCut(value)
      elseif "Exhaustion" == tagStr then
        curValue, baseValue = self:__GetShowExhaustion(value)
      elseif "Power" == tagStr then
        curValue, baseValue = self:__GetShowPower(value)
      elseif "TentaclePower" == tagStr then
        curValue, baseValue = self:__GetShowTentacle(value)
      elseif "Bleed" == tagStr then
        curValue, baseValue = self:__GetShowBleed(value)
      end
      table.insert(descArgs.curValues, curValue)
      table.insert(descArgs.baseValues, baseValue)
    end
  end
  return skillArgs, descArgs
end

function BattleCmdServer:GetValueByCmd(cmdStr)
  do return self.cmdParser.GetValueByCmd, self.cmdParser end
  return self.cmdParser.GetValueByCmd, self.cmdParser, cmdStr
end

function BattleCmdServer:GetValueListByCmd(cmdStr)
  do return self.cmdParser.GetValueListByCmd, self.cmdParser end
  return self.cmdParser.GetValueListByCmd, self.cmdParser, cmdStr
end

function BattleCmdServer:GenerateTargetsExp(targetType, effectUid)
  do return self.cmdParser.GenerateTargetsExp, self.cmdParser, targetType end
  return self.cmdParser.GenerateTargetsExp, self.cmdParser, targetType, effectUid
end

function BattleCmdServer:SetUpperTargets(targets)
  self.cmdParser.upperTargets = targets
end

function BattleCmdServer:GetUpperTargets()
  return self.cmdParser.upperTargets
end

function BattleCmdServer:SetMemberValue(key, value)
  self.cmdParser:SetMemberValue(key, value)
end

function BattleCmdServer:GetMemberValue(key)
  do return self.cmdParser.GetMemberValue, self.cmdParser end
  return self.cmdParser.GetMemberValue, self.cmdParser, key
end

function BattleCmdServer:HasMemberValue(key)
  do return self.cmdParser.HasMemberValue, self.cmdParser end
  return self.cmdParser.HasMemberValue, self.cmdParser, key
end

function BattleCmdServer:CalcCrit(target)
  local cardCrit = self:__CalcCardCrit(target)
  if cardCrit then
    return cardCrit
  end
  local awakerCrit = self:__CalcAwakerCrit(target)
  if awakerCrit then
    return awakerCrit
  end
  local caster = self.battleEngine:GetObj(self.castRoleUid)
  local player = caster:GetPlayer()
  local playerCertainCrit = player:GetProperty(BP.certain_crit)
  if playerCertainCrit and playerCertainCrit > 0 then
    return true
  end
  local crit = 0
  local card = self.battleEngine:GetObj(self.cardUid)
  if card then
    crit = crit + (card:GetProperty(BP.crit) or 0)
  end
  crit = crit + caster:GetProperty(BP.crit)
  if caster:IsRoleType(bc.RoleType.Awaker) then
    crit = crit + player:GetProperty(BP.crit)
    if card then
      crit = crit + (caster:GetProperty(BP.card_crit) or 0)
    end
  end
  local skillTypes = self:GetSkillType()
  for _, skillType in ipairs(skillTypes) do
    if bc.SkillType2Crit[skillType] then
      crit = crit + caster:GetProperty(bc.SkillType2Crit[skillType])
    end
  end
  crit = crit * (100 + caster:GetProperty(BP.crit_per)) / 100
  if target then
    local anti_crit = target:GetProperty(BP.anti_crit) or 0
    crit = crit - anti_crit
  end
  crit = math.ceil(crit)
  local rand = self.battleEngine.rand:random(100)
  return crit >= rand
end

function BattleCmdServer:__CalcCardCrit(target)
  local card = self.battleEngine:GetObj(self.cardUid)
  if not card then
    return false
  end
  local block = target:GetProperty(BP.block)
  local crit2block = card:GetProperty(BP.card_crit2block)
  if block and block > 0 and crit2block and crit2block > 0 then
    return true
  end
  local certainCrit = card:GetProperty(BP.card_certain_crit)
  if certainCrit and certainCrit > 0 then
    return true
  end
  return false
end

function BattleCmdServer:__CalcAwakerCrit(target)
  local awaker = self.battleEngine:GetObj(self.castRoleUid)
  if not awaker:IsRoleType(bc.RoleType.Awaker) then
    return false
  end
  local certainCrit = awaker:GetProperty(BP.certain_crit)
  if certainCrit and certainCrit > 0 then
    return true
  end
  local skillTypes = self:GetSkillType()
  if table.contains(skillTypes, bc.SkillType.Card_Strike) then
    local c = awaker:GetProperty(BP.crit_from_strikecard)
    if c and c > 0 then
      return true
    end
  end
  if target:GetProperty(BP.block) > 0 then
    local c = awaker:GetProperty(BP.crit2block)
    if c and c > 0 then
      return true
    end
  end
  local p = awaker:GetProperty(BP.crit2gt_hp_per)
  local targetCurHp = target:GetProperty(BP.hp)
  local targetMaxHp = target:GetProperty(BP.max_hp)
  if p > 0 and p < targetCurHp / targetMaxHp then
    return true
  end
  p = awaker:GetProperty(BP.crit2lt_hp_per)
  if p > 0 and p > targetCurHp / targetMaxHp then
    return true
  end
  return false
end

function BattleCmdServer:GetSkillType()
  if not self.skillConfigId then
    return {}
  end
  if self.cardUid then
    local card = self.battleEngine:GetObj(self.cardUid)
    return card and card:GetType()
  end
  do return self.GetSkillConfigTQList, self end
  return self.GetSkillConfigTQList, self, "Type"
end

function BattleCmdServer:GetSkillTypeStr()
  local skillTypes = self:GetSkillType()
  local str = ""
  for _, t in ipairs(skillTypes) do
    str = str .. "+" .. t
  end
  return str
end

function BattleCmdServer:GetSkillArgsPlus(paraPlusName)
  local skillArgsPlus = 0
  local paraPlus = self:GetSkillConfigTQText("ParaPlus")
  if paraPlus and paraPlusName then
    local valueList = self:GetValueListByCmd(paraPlus)
    local idx = tonumber(string.sub(paraPlusName, 9)) or 0
    skillArgsPlus = valueList[idx] or skillArgsPlus
  end
  return skillArgsPlus
end

function BattleCmdServer:GetDimensionFixPer(caster)
  local value = 0
  caster = caster or self.battleEngine:GetObj(self.castRoleUid)
  if caster and caster.camp == bc.BattleCamp.Camp1 then
    local player = caster:GetPlayer()
    value = player and player:GetProperty(bc.BattleProperty.dimension_fix_per) or 0
  end
  return value
end

function BattleCmdServer:IsStateTriggerAdd()
  return self.cmdCtorData and self.cmdCtorData.isTrigger
end

function BattleCmdServer:IsNoDirectCmd()
  return self.cmdCtorData and self.cmdCtorData.noDirectCmd
end

function BattleCmdServer:IsKeeperSkill()
  local skillTypes = self:GetSkillType() or {}
  for _, skillType in ipairs(skillTypes) do
    if skillType == bc.SkillType.Keeper_Skill or skillType == bc.SkillType.Card_KeeperSkill then
      return true
    end
  end
  return false
end

function BattleCmdServer:GetTargetBeDmgPerMul(target, skillTypes, card)
  local multi = 1
  local keys = {
    BP.be_damage_per,
    BP.be_damage_per2,
    BP.be_damage_per3
  }
  for _, key in ipairs(keys) do
    multi = multi * (1 + target:GetProperty(key) / 100)
  end
  if self:IsStateTriggerAdd() then
    return multi
  end
  skillTypes = skillTypes or self:GetSkillType() or {}
  if table.contains(skillTypes, bc.SkillType.Ulti_Skill) then
    local per4 = target:GetProperty(BP.be_damage_per4)
    if 0 ~= per4 then
      multi = multi * (1 + per4 / 100)
      self.battleEngine:Debug("be_damage_per4 {per4} {multi}", per4, multi)
    end
  end
  if card and card:CardTypeMatch(bc.CardTypeInstruction) then
    local per5 = target:GetProperty(BP.be_damage_per5)
    if 0 ~= per5 then
      multi = multi * (1 + per5 / 100)
      self.battleEngine:Debug("be_damage_per5 {per5} {multi}", per5, multi)
    end
  end
  return multi
end

function BattleCmdServer:ShouldSkipNewChaosKeeperskillForStateTag()
  if self:IsStateTriggerAdd() or self:IsNoDirectCmd() then
    return true
  end
  return false
end

function BattleCmdServer:GetNewChaosKeeperskillParams()
  if not self:IsKeeperSkill() then
    return 0, 0, 0
  end
  local player = self.battleEngine.roleMgr:GetPlayer(self:GetCasterCamp())
  if not player then
    return 0, 0, 0
  end
  local is_chaos_type2 = player:GetProperty(BP.is_chaos_type2) or 0
  if 0 == is_chaos_type2 then
    return 0, 0, 0
  end
  local keeperskillAtkPer = player:GetProperty(BP.keeperskill_atk_per) or 0
  local keeperskillDefPer = player:GetProperty(BP.keeperskill_def_per) or 0
  return keeperskillAtkPer, keeperskillDefPer, is_chaos_type2
end

function BattleCmdServer:__GetShowDamage(value, paraPlusName, caster, formulaSubType)
  caster = caster or self.battleEngine:GetObj(self.castRoleUid)
  local player = self.battleEngine.roleMgr:GetPlayer(caster.camp)
  local card = self.battleEngine:GetObj(self.cardUid)
  local skillTypes = self:GetSkillType()
  local roleWeakPer = 0
  local basicDamagePer = 0
  local roleEnhancePer = 0
  local strength = 0
  local ignoreBonus = formulaSubType == bc.FormulaSubType.OnlyIncludeTarget
  if caster:IsRoleType(bc.RoleType.Awaker) and self.battleEngine:IsPVE() then
    roleWeakPer = player:GetProperty(BP.weak_per)
    basicDamagePer = player:GetProperty(BP.basic_damage_per)
    roleEnhancePer = player:GetProperty(BP.enhance_per)
    strength = player:GetProperty(BP.damage_plus)
  elseif not ignoreBonus then
    roleWeakPer = caster:GetProperty(BP.weak_per)
    roleEnhancePer = caster:GetProperty(BP.enhance_per)
    basicDamagePer = caster:GetProperty(BP.basic_damage_per)
  end
  local playerOutsideDamagePer = 0
  local playerInsideDamagePer = 0
  if not ignoreBonus and self.battleEngine:IsPVP() then
    playerOutsideDamagePer = player:GetProperty(BP.o_damage_per)
    playerInsideDamagePer = player:GetProperty(BP.i_damage_per)
  end
  local skillArgsPlus = self:GetSkillArgsPlus(paraPlusName)
  local awakerOutsideDamagePer = 0
  local awakerInsideBasicDamagePer = 0
  local awakerInsideDamagePer = 0
  local awakerInsideDamagePer1 = 0
  local awakerInsideDamagePer2 = 0
  local awakerInsideDamagePer3 = 0
  local awakerInsideDamagePer4 = 0
  local awakerInsideDamagePer5 = 0
  local awakerInsideDamagePer6 = 0
  local awakerInsideDamagePer7 = 0
  local awakerInsideDamagePer8 = 0
  local awakerStrengthMultiple = 0
  local awakerUltiBaseDmgFlat = 0
  local awakerPostActBaseDmgFlat = 0
  local skillTypeOutsideDmgPer = 1
  local skillTypeInsideDmgPer = 1
  local skillTypeDmgPer = 1
  local cardOutsideDmgPer = 0
  local cardInsideDmgPer = 0
  local ultiDamgePlus = 0
  local cardStrengthMultiple = 0
  local ultiStrengthMultiple = 0
  local strikecard_damage_plus = 0
  local awakerDamagePlus = 0
  local dimension_fix_per = self:GetDimensionFixPer(caster)
  local cardDamagePer2 = 0
  local cardDamagePer3 = 0
  local awaker_ulti_dmg_per = 0
  local awaker_CmdCard_dmg_per = 0
  local awakerDmgPowerPerScale = 0
  local spellboundDmgPer = 0
  local spellboundDmgPer2 = 0
  local spellboundDmgPer3 = 0
  local spellboundDmgPer4 = 0
  local spellboundDmgPer5 = 0
  if not ignoreBonus and caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    awakerOutsideDamagePer = caster:GetProperty(BP.o_damage_per)
    awakerInsideBasicDamagePer = caster:GetProperty(BP.i_basic_damage_per)
    awakerInsideDamagePer = caster:GetProperty(BP.i_damage_per)
    awakerInsideDamagePer1 = caster:GetProperty(BP.i_damage_per1)
    awakerInsideDamagePer2 = caster:GetProperty(BP.i_damage_per2)
    awakerInsideDamagePer3 = caster:GetProperty(BP.i_damage_per3)
    awakerInsideDamagePer4 = caster:GetProperty(BP.i_damage_per4)
    awakerInsideDamagePer5 = caster:GetProperty(BP.i_damage_per5)
    awakerInsideDamagePer6 = caster:GetProperty(BP.i_damage_per6)
    awakerInsideDamagePer7 = caster:GetProperty(BP.i_damage_per7)
    awakerInsideDamagePer8 = caster:GetProperty(BP.i_damage_per8)
    strength = strength + caster:GetProperty(BP.damage_plus)
    awakerStrengthMultiple = caster:GetProperty(BP.awaker_strength_multiple)
    awakerDamagePlus = caster:GetProperty(BP.only_damage_plus)
    awakerDmgPowerPerScale = caster:GetProperty(BP.awaker_dmg_power_per_scale)
    spellboundDmgPer = caster:GetProperty(BP.spellbound_dmg_per) or spellboundDmgPer
    spellboundDmgPer2 = caster:GetProperty(BP.spellbound_dmg_per2) or spellboundDmgPer2
    spellboundDmgPer3 = caster:GetProperty(BP.spellbound_dmg_per3) or spellboundDmgPer3
    spellboundDmgPer4 = caster:GetProperty(BP.spellbound_dmg_per4) or spellboundDmgPer4
    spellboundDmgPer5 = caster:GetProperty(BP.spellbound_dmg_per5) or spellboundDmgPer5
    if card and not table.contains(skillTypes, bc.SkillType.Card_Awake) then
      cardDamagePer2 = card:GetProperty(BP.card_damage_per2)
      cardInsideDmgPer = caster:GetProperty(BP.i_damage_per_card)
      cardOutsideDmgPer = caster:GetProperty(BP.o_damage_per_card)
      awaker_CmdCard_dmg_per = card:CardTypeMatch(bc.CardTypeInstruction) and caster:GetProperty(BP.awaker_CmdCard_dmg_per) or awaker_CmdCard_dmg_per
    end
    for _, skillType in ipairs(skillTypes) do
      skillTypeInsideDmgPer = skillTypeInsideDmgPer * (1 + caster:GetProperty(bc.SkillType2InsideDamagePer[skillType]) / 100)
      local p_damage_per = bc.SkillType2OutsideDamagePer[skillType]
      local damage_per = caster:GetProperty(p_damage_per)
      if p_damage_per == BP.o_damage_per_strikecard and card then
        local o_damage_per_strikecard_limit = card:GetProperty(BP.o_damage_per_strikecard_limit)
        damage_per = math.min(damage_per, o_damage_per_strikecard_limit > 0 and o_damage_per_strikecard_limit or damage_per)
      end
      skillTypeOutsideDmgPer = skillTypeOutsideDmgPer * (1 + damage_per / 100)
      skillTypeDmgPer = skillTypeDmgPer * (1 + caster:GetProperty(bc.SkillType2DamagePer[skillType]) / 100)
      if skillType == bc.SkillType.Ulti_Skill then
        ultiDamgePlus = caster:GetProperty(BP.ulti_damage_plus)
        ultiStrengthMultiple = ultiStrengthMultiple + caster:GetProperty(BP.ulti_strength_multiple)
        awakerUltiBaseDmgFlat = caster:GetProperty(BP.awaker_ulti_BaseDmg_flat)
        awaker_ulti_dmg_per = caster:GetProperty(BP.awaker_ulti_dmg_per)
      end
      if skillType == bc.SkillType.Card_Strike then
        strikecard_damage_plus = strikecard_damage_plus + caster:GetProperty(BP.strikecard_damage_plus)
      end
      if skillType == bc.SkillType.Card_AttachPost then
        awakerPostActBaseDmgFlat = caster:GetProperty(BP.awaker_PostAct_BaseDmg_flat)
      end
    end
  end
  local curCardDamagePer = 0
  local cardDamagePlus = 0
  local card_damage_per3_n2 = 0
  if card then
    local isInstructionCard = card:CardTypeMatch(bc.CardTypeInstruction)
    curCardDamagePer = card:GetProperty(BP.card_damage_per)
    cardDamagePlus = card:GetProperty(BP.card_damage_plus)
    cardStrengthMultiple = card:GetProperty(BP.card_strength_multiple)
    cardDamagePer3 = card:GetProperty(BP.card_damage_per3)
    if isInstructionCard then
      card_damage_per3_n2 = caster:GetProperty(BP.card_damage_per3_n2) or 0
    end
  end
  if strength > 0 then
    strength = strength * (1 + awakerStrengthMultiple / 100 + cardStrengthMultiple / 100 + ultiStrengthMultiple / 100) * (1 + awakerDmgPowerPerScale / 100)
  end
  if basicDamagePer > 0 then
    basicDamagePer = basicDamagePer + awakerUltiBaseDmgFlat + awakerPostActBaseDmgFlat
    self.battleEngine:Debug("-----after {basicDamagePer} {awakerUltiBaseDmgFlat} {awakerPostActBaseDmgFlat}", basicDamagePer, awakerUltiBaseDmgFlat, awakerPostActBaseDmgFlat)
  end
  if self:IsStateTriggerAdd() then
    cardDamagePer2 = 0
    cardDamagePer3 = 0
    card_damage_per3_n2 = 0
    awaker_ulti_dmg_per = 0
    awaker_CmdCard_dmg_per = 0
  end
  local data = {
    value = value,
    awakerOutsideDamagePer = awakerOutsideDamagePer,
    awakerInsideBasicDamagePer = awakerInsideBasicDamagePer,
    dimension_fix_per = dimension_fix_per,
    playerOutsideDamagePer = playerOutsideDamagePer,
    skillTypeOutsideDmgPer = skillTypeOutsideDmgPer,
    curCardDamagePer = curCardDamagePer,
    cardOutsideDmgPer = cardOutsideDmgPer,
    basicDamagePer = basicDamagePer,
    skillTypeDmgPer = skillTypeDmgPer,
    roleEnhancePer = roleEnhancePer,
    roleWeakPer = roleWeakPer,
    awakerInsideDamagePer = awakerInsideDamagePer,
    playerInsideDamagePer = playerInsideDamagePer,
    cardInsideDmgPer = cardInsideDmgPer,
    skillTypeInsideDmgPer = skillTypeInsideDmgPer,
    cardDamagePlus = cardDamagePlus,
    strength = strength,
    ultiDamgePlus = ultiDamgePlus,
    strikecard_damage_plus = strikecard_damage_plus,
    skillArgsPlus = skillArgsPlus,
    awakerInsideDamagePer1 = awakerInsideDamagePer1,
    awakerInsideDamagePer2 = awakerInsideDamagePer2,
    awakerInsideDamagePer3 = awakerInsideDamagePer3,
    awakerInsideDamagePer4 = awakerInsideDamagePer4,
    awakerInsideDamagePer5 = awakerInsideDamagePer5,
    awakerInsideDamagePer6 = awakerInsideDamagePer6,
    awakerInsideDamagePer7 = awakerInsideDamagePer7,
    awakerInsideDamagePer8 = awakerInsideDamagePer8,
    awakerDamagePlus = awakerDamagePlus,
    cardDamagePer2 = cardDamagePer2,
    cardDamagePer3 = cardDamagePer3,
    card_damage_per3_n2 = card_damage_per3_n2,
    awaker_ulti_dmg_per = awaker_ulti_dmg_per,
    awaker_CmdCard_dmg_per = awaker_CmdCard_dmg_per,
    spellboundDmgPer = spellboundDmgPer,
    spellboundDmgPer2 = spellboundDmgPer2,
    spellboundDmgPer3 = spellboundDmgPer3,
    spellboundDmgPer4 = spellboundDmgPer4,
    spellboundDmgPer5 = spellboundDmgPer5
  }
  local curDamage, baseDamage = BattleUtilServer.ShowDamageFormula(data)
  return curDamage, baseDamage
end

function BattleCmdServer:__GetFinalDamage(showDamage, target, isCrit, formulaSubType)
  local ownerAwaker = self.battleEngine:GetObj(self.castRoleUid)
  local awakerCritDamage = 0
  local awakerCardCritDamage = 0
  local enemyTypeDmgPer = 0
  local enemyStateDmgPer = 1
  local enemyBuffDmgPer = 0
  local enemyDebuffDmgPer = 0
  local enemyBlockDmgPer = 0
  local enemyBlockBarrierDmgPer = 0
  local onlyIncludeSelf = formulaSubType == bc.FormulaSubType.OnlyIncludeSelf
  local onlyIncludeTarget = formulaSubType == bc.FormulaSubType.OnlyIncludeTarget
  local skillTypes = self:GetSkillType()
  local skillTypeCritDamage = 0
  if ownerAwaker:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    if isCrit then
      awakerCritDamage = ownerAwaker:GetProperty(BP.crit_damage)
    end
    enemyTypeDmgPer = ownerAwaker:GetDamagePer2MonsterType(target)
    enemyStateDmgPer = ownerAwaker:GetDamagePer2HasState(target)
    enemyBuffDmgPer = ownerAwaker:GetDamagePer2BuffEnemy(target)
    enemyDebuffDmgPer = ownerAwaker:GetDamagePer2DebuffEnemy(target)
    enemyBlockDmgPer = ownerAwaker:GetDamagePer2Block(target)
    enemyBlockBarrierDmgPer = ownerAwaker:GetDamagePer2BlockBarrier(target)
    for _, skillType in ipairs(skillTypes) do
      if bc.SkillType2CritDamage[skillType] and isCrit then
        skillTypeCritDamage = skillTypeCritDamage + ownerAwaker:GetProperty(bc.SkillType2CritDamage[skillType])
      end
    end
  end
  local cardCritDamage = 0
  local cardBlockBarrierPer = 0
  local card = self.battleEngine:GetObj(self.cardUid)
  if card then
    if isCrit then
      cardCritDamage = card:GetProperty(BP.crit_damage)
      if ownerAwaker:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
        awakerCardCritDamage = ownerAwaker:GetProperty(BP.card_crit_damage)
      end
    end
    local propertyName = BP.card_damage_per2block_barrier
    local property = card:GetProperty(propertyName) or 0
    if target:GetProperty(BP.block) > 0 then
      cardBlockBarrierPer = property
    end
    local DT = self.battleEngine.battleDT
    local apiCfg = DT.BattleApi[propertyName]
    local stateList = table.pack(self.battleEngine:GetCmdFunc(apiCfg.Data, {})())
    if self.battleEngine.stateMgr:HasStateByStateIds(target.uid, stateList) then
      cardBlockBarrierPer = property
    end
  end
  local targetBeDmgPer = 1
  if not onlyIncludeSelf then
    targetBeDmgPer = self:GetTargetBeDmgPerMul(target, skillTypes, card)
  end
  local targetVulnPer = target:GetProperty(BP.vulnerable_per)
  local targetBeDmgPlus = target:GetProperty(BP.be_damage_plus)
  local critDamage = awakerCritDamage + cardCritDamage + skillTypeCritDamage + awakerCardCritDamage
  critDamage = critDamage * (1 + ownerAwaker:GetProperty(BP.crit_damage_per) / 100)
  local finalDamage = showDamage
  if not onlyIncludeTarget then
    finalDamage = finalDamage * (1 + critDamage / 100)
  end
  if not onlyIncludeSelf then
    finalDamage = finalDamage * targetBeDmgPer * (1 + targetVulnPer / 100) * (1 + enemyTypeDmgPer / 100) * (1 + enemyBuffDmgPer / 100) * (1 + enemyDebuffDmgPer / 100) * (1 + enemyBlockDmgPer / 100) * (1 + enemyBlockBarrierDmgPer / 100) * (1 + cardBlockBarrierPer / 100) * enemyStateDmgPer + targetBeDmgPlus
  end
  finalDamage = math.max(math.ceil(finalDamage), 1)
  return finalDamage
end

function BattleCmdServer:GetRealDmg(baseDamage, target, defaultIsCrit, paraPlusName, formulaSubType)
  baseDamage = baseDamage or 0
  formulaSubType = formulaSubType or bc.FormulaSubType.All
  local isCrit
  if nil == defaultIsCrit then
    isCrit = self:CalcCrit(target)
  else
    isCrit = defaultIsCrit
  end
  self:SetMemberValue("IsCrit", isCrit)
  local cardDmg = self:__GetShowDamage(baseDamage, paraPlusName, nil, formulaSubType)
  self.battleEngine:Debug("计算得到的卡面伤害为", cardDmg, isCrit)
  local realDmg = self:__GetFinalDamage(cardDmg, target, isCrit, formulaSubType)
  self.battleEngine:Debug("计算得到的打出伤害为", realDmg, isCrit)
  do return math.ceil end
  return math.ceil, realDmg, "计算得到的打出伤害为", realDmg, isCrit
end

function BattleCmdServer:GetRealScarletBlood(baseBlood)
  do return self.GetShowScarletBlood, self end
  return self.GetShowScarletBlood, self, baseBlood
end

function BattleCmdServer:__GetShowBlock(value, paraPlusName, caster, formulaSubType)
  caster = caster or self.battleEngine:GetObj(self.castRoleUid)
  local player = self.battleEngine.roleMgr:GetPlayer(self:GetCasterCamp())
  local ignoreBonus = formulaSubType == bc.FormulaSubType.OnlyIncludeTarget
  local awakerOutsideBlockPer = 0
  local playerOutsideBlockPer = 0
  local awakerInsideBlockPer = 0
  local playerInsideBlockPer = 0
  local skillTypeBlockPer = 1
  local skillTypeInsideBlockPer = 1
  local cardBlockPer = 0
  local curCardBlockPer = 0
  local cardBlockPlus = 0
  local cardBlockPer2 = 0
  local awakerFrailPer
  local awakerBlockPlus = 0
  local dimension_fix_per = self:GetDimensionFixPer(caster)
  local awaker_ulti_block_per = 0
  local awaker_CmdCard_block_per = 0
  local spellboundBlockPer = 0
  local spellboundBlockPer2 = 0
  local spellboundBlockPer3 = 0
  local spellboundBlockPer4 = 0
  local spellboundBlockPer5 = 0
  if caster:IsRoleType(bc.RoleType.Awaker) and self.battleEngine:IsPVE() then
    awakerFrailPer = player:GetProperty(BP.frail_per)
    awakerBlockPlus = player:GetProperty(BP.block_plus)
  elseif not ignoreBonus then
    awakerFrailPer = caster:GetProperty(BP.frail_per)
  end
  if not ignoreBonus and self.battleEngine:IsPVP() then
    playerInsideBlockPer = player:GetProperty(BP.i_block_per)
    playerOutsideBlockPer = player:GetProperty(BP.o_block_per)
  end
  local instructcardFinalBlockPer = 0
  local card = self.battleEngine:GetObj(self.cardUid)
  local skillTypes = self:GetSkillType()
  local isInstructionCard = card and card:CardTypeMatch(bc.CardTypeInstruction)
  if not ignoreBonus and caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    awakerOutsideBlockPer = caster:GetProperty(BP.o_block_per)
    awakerInsideBlockPer = caster:GetProperty(BP.i_block_per)
    awakerBlockPlus = awakerBlockPlus + caster:GetProperty(BP.block_plus)
    spellboundBlockPer = caster:GetProperty(BP.spellbound_block_per) or spellboundBlockPer
    spellboundBlockPer2 = caster:GetProperty(BP.spellbound_block_per2) or spellboundBlockPer2
    spellboundBlockPer3 = caster:GetProperty(BP.spellbound_block_per3) or spellboundBlockPer3
    spellboundBlockPer4 = caster:GetProperty(BP.spellbound_block_per4) or spellboundBlockPer4
    spellboundBlockPer5 = caster:GetProperty(BP.spellbound_block_per5) or spellboundBlockPer5
    if isInstructionCard then
      instructcardFinalBlockPer = caster:GetProperty(BP.instructcard_final_block_per) or 0
    end
    for _, skillType in ipairs(skillTypes) do
      for _, blockPer in ipairs(bc.SkillType2BlockPer[skillType] or {}) do
        skillTypeBlockPer = skillTypeBlockPer * (1 + caster:GetProperty(blockPer) / 100)
      end
      skillTypeInsideBlockPer = skillTypeInsideBlockPer * (1 + caster:GetProperty(bc.SkillType2InsideBlockPer[skillType]) / 100)
      awaker_ulti_block_per = skillType == bc.SkillType.Ulti_Skill and caster:GetProperty(BP.awaker_ulti_block_per) or awaker_ulti_block_per
    end
    if card and not table.contains(skillTypes, bc.SkillType.Card_Awake) then
      cardBlockPer = caster:GetProperty(BP.block_per_card)
      awaker_CmdCard_block_per = isInstructionCard and caster:GetProperty(BP.awaker_CmdCard_block_per) or awaker_CmdCard_block_per
    end
  end
  local card_block_per2_n2 = 0
  if card then
    curCardBlockPer = card:GetProperty(BP.card_block_per)
    cardBlockPer2 = card:GetProperty(BP.card_block_per2) or 0
    cardBlockPlus = card:GetProperty(BP.card_block_plus)
    if isInstructionCard then
      card_block_per2_n2 = caster:GetProperty(BP.card_block_per2_n2) or 0
    end
  end
  local skillArgsPlus = self:GetSkillArgsPlus(paraPlusName)
  if self:IsStateTriggerAdd() then
    cardBlockPer2 = 0
    card_block_per2_n2 = 0
    awaker_ulti_block_per = 0
    awaker_CmdCard_block_per = 0
  end
  local _, keeperskillDefPer, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local data = {
    value = value,
    awakerOutsideBlockPer = awakerOutsideBlockPer,
    playerOutsideBlockPer = playerOutsideBlockPer,
    awakerInsideBlockPer = awakerInsideBlockPer,
    playerInsideBlockPer = playerInsideBlockPer,
    skillTypeBlockPer = skillTypeBlockPer,
    cardBlockPer = cardBlockPer,
    curCardBlockPer = curCardBlockPer,
    cardBlockPlus = cardBlockPlus,
    awakerFrailPer = awakerFrailPer,
    awakerBlockPlus = awakerBlockPlus,
    skillArgsPlus = skillArgsPlus,
    skillTypeInsideBlockPer = skillTypeInsideBlockPer,
    dimension_fix_per = dimension_fix_per,
    instructcardFinalBlockPer = instructcardFinalBlockPer,
    cardBlockPer2 = cardBlockPer2,
    card_block_per2_n2 = card_block_per2_n2,
    awaker_ulti_block_per = awaker_ulti_block_per,
    awaker_CmdCard_block_per = awaker_CmdCard_block_per,
    spellboundBlockPer = spellboundBlockPer,
    spellboundBlockPer2 = spellboundBlockPer2,
    spellboundBlockPer3 = spellboundBlockPer3,
    spellboundBlockPer4 = spellboundBlockPer4,
    spellboundBlockPer5 = spellboundBlockPer5,
    keeperskill_def_per = keeperskillDefPer,
    is_chaos_type2 = is_chaos_type2
  }
  local curBlock, baseBlock = BattleUtilServer.ShowBlockFormula(data)
  return curBlock, baseBlock
end

function BattleCmdServer:__GetFinalBlock(showBlock, target, formulaSubType)
  local onlyIncludeSelf = formulaSubType == bc.FormulaSubType.OnlyIncludeSelf
  local finalBlock = showBlock
  if not onlyIncludeSelf then
    local beBlockPer = target:GetProperty(BP.gain_block_per)
    local beBlockPlus = target:GetProperty(BP.gain_block_plus)
    finalBlock = math.max(math.ceil(showBlock * (1 + beBlockPer / 100) + beBlockPlus), 1)
  end
  return finalBlock
end

function BattleCmdServer:GetRealBlock(baseBlock, target, paraPlusName, formulaSubType)
  self.battleEngine:Debug("传入的防护为", baseBlock)
  local cardBlock = self:__GetShowBlock(baseBlock, paraPlusName, nil, formulaSubType)
  self.battleEngine:Debug("计算得到的卡面防护为", cardBlock)
  local finalBlock = self:__GetFinalBlock(cardBlock, target, formulaSubType)
  self.battleEngine:Debug("计算得到的最终防护为", cardBlock)
  return finalBlock
end

function BattleCmdServer:GetShowScarletBlood(baseBlood)
  local dynamicScarletBlood = baseBlood or 0
  local caster = self.battleEngine:GetObj(self.castRoleUid)
  local iBloodChangePer = 0
  local oBloodChangePer = 0
  local instructcardBasicStateLayerPerBlood = 0
  if caster then
    iBloodChangePer = caster:GetProperty(BP.i_bloodchange_per) or 0
    oBloodChangePer = caster:GetProperty(BP.o_bloodchange_per) or 0
    local card = self.cardUid and self.battleEngine:GetObj(self.cardUid)
    if card and card:CardTypeMatch(bc.CardTypeInstruction) then
      instructcardBasicStateLayerPerBlood = caster:GetProperty(BP.instructcard_basic_state_layer_per_blood) or 0
    end
  end
  local curValue = math.ceil(dynamicScarletBlood * (1 + iBloodChangePer / HUNDRED) * (1 + oBloodChangePer / HUNDRED + instructcardBasicStateLayerPerBlood / HUNDRED))
  return curValue, dynamicScarletBlood
end

function BattleCmdServer:__GetShowHeal(value, paraPlusName, caster, formulaSubType)
  local ignoreBonus = formulaSubType == bc.FormulaSubType.OnlyIncludeTarget
  local awakerOutsideHealPer = 0
  local awakerInsideHealPer = 0
  local playerOutsideHealPer = 0
  local playerInsideHealPer = 0
  local awakerHealPlus = 0
  local curCardHealPer = 0
  local cardHealPlus = 0
  local cardHealPer2 = 0
  local skillTypeHealPer = 1
  local cardInsideHealPer = 0
  local cardOutsideHealPer = 0
  local dying_per = 0
  local dying_per2 = 0
  local skillTypeInsideHealPer = 1
  local player = self.battleEngine.roleMgr:GetPlayer(self:GetCasterCamp())
  if not ignoreBonus and self.battleEngine:IsPVP() then
    playerOutsideHealPer = player:GetProperty(BP.o_heal_per)
    playerInsideHealPer = player:GetProperty(BP.i_heal_per)
  end
  if not ignoreBonus and player and self:GetCasterCamp() == bc.BattleCamp.Camp1 then
    dying_per = player:GetProperty(BP.dying_per)
    dying_per2 = player:GetProperty(BP.dying_per2)
  end
  local dimension_fix_per = self:GetDimensionFixPer(caster)
  caster = caster or self.battleEngine:GetObj(self.castRoleUid)
  local allDealHealPer = caster:GetPlayer():GetProperty(BP.all_deal_heal_per)
  local awaker_ulti_heal_per = 0
  local awaker_CmdCard_heal_per = 0
  local spellboundHealPer = 0
  local spellboundHealPer2 = 0
  local spellboundHealPer3 = 0
  local spellboundHealPer4 = 0
  local spellboundHealPer5 = 0
  local card = self.battleEngine:GetObj(self.cardUid)
  local skillTypes = self:GetSkillType()
  if not ignoreBonus and caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    awakerOutsideHealPer = caster:GetProperty(BP.o_heal_per)
    awakerInsideHealPer = caster:GetProperty(BP.i_heal_per)
    awakerHealPlus = caster:GetProperty(BP.heal_plus)
    spellboundHealPer = caster:GetProperty(BP.spellbound_heal_per) or spellboundHealPer
    spellboundHealPer2 = caster:GetProperty(BP.spellbound_heal_per2) or spellboundHealPer2
    spellboundHealPer3 = caster:GetProperty(BP.spellbound_heal_per3) or spellboundHealPer3
    spellboundHealPer4 = caster:GetProperty(BP.spellbound_heal_per4) or spellboundHealPer4
    spellboundHealPer5 = caster:GetProperty(BP.spellbound_heal_per5) or spellboundHealPer5
    for _, skillType in ipairs(skillTypes) do
      for _, healPer in ipairs(bc.SkillType2HealPer[skillType] or {}) do
        skillTypeHealPer = skillTypeHealPer * (1 + caster:GetProperty(healPer) / 100)
      end
      skillTypeInsideHealPer = skillTypeInsideHealPer * (1 + caster:GetProperty(bc.SkillType2InsideHealPer[skillType]) / 100)
      awaker_ulti_heal_per = skillType == bc.SkillType.Ulti_Skill and caster:GetProperty(BP.awaker_ulti_heal_per) or awaker_ulti_heal_per
    end
    if card and skillTypes and not table.hasCross(skillTypes, {
      bc.SkillType.Ulti_Skill,
      bc.SkillType.Card_Awake
    }) then
      cardInsideHealPer = caster:GetProperty(BP.i_heal_per_card)
      cardOutsideHealPer = caster:GetProperty(BP.o_heal_per_card)
      awaker_CmdCard_heal_per = card:CardTypeMatch(bc.CardTypeInstruction) and caster:GetProperty(BP.awaker_CmdCard_heal_per) or awaker_CmdCard_heal_per
    end
  end
  local card_heal_per2_n2 = 0
  if card then
    local isInstructionCard = card:CardTypeMatch(bc.CardTypeInstruction)
    curCardHealPer = card:GetProperty(BP.card_heal_per)
    cardHealPer2 = card:GetProperty(BP.card_heal_per2) or 0
    cardHealPlus = card:GetProperty(BP.card_heal_plus)
    if isInstructionCard then
      card_heal_per2_n2 = caster:GetProperty(BP.card_heal_per2_n2) or 0
    end
  end
  local skillArgsPlus = self:GetSkillArgsPlus(paraPlusName)
  if self:IsStateTriggerAdd() then
    cardHealPer2 = 0
    card_heal_per2_n2 = 0
    awaker_ulti_heal_per = 0
    awaker_CmdCard_heal_per = 0
  end
  local _, keeperskillDefPer, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local data = {
    value = value,
    awakerOutsideHealPer = awakerOutsideHealPer,
    awakerInsideHealPer = awakerInsideHealPer,
    playerOutsideHealPer = playerOutsideHealPer,
    playerInsideHealPer = playerInsideHealPer,
    awakerHealPlus = awakerHealPlus,
    curCardHealPer = curCardHealPer,
    cardHealPlus = cardHealPlus,
    skillTypeHealPer = skillTypeHealPer,
    cardInsideHealPer = cardInsideHealPer,
    cardOutsideHealPer = cardOutsideHealPer,
    skillArgsPlus = skillArgsPlus,
    dimension_fix_per = dimension_fix_per,
    dying_per = dying_per,
    dying_per2 = dying_per2,
    skillTypeInsideHealPer = skillTypeInsideHealPer,
    allDealHealPer = allDealHealPer,
    cardHealPer2 = cardHealPer2,
    card_heal_per2_n2 = card_heal_per2_n2,
    awaker_ulti_heal_per = awaker_ulti_heal_per,
    awaker_CmdCard_heal_per = awaker_CmdCard_heal_per,
    spellboundHealPer = spellboundHealPer,
    spellboundHealPer2 = spellboundHealPer2,
    spellboundHealPer3 = spellboundHealPer3,
    spellboundHealPer4 = spellboundHealPer4,
    spellboundHealPer5 = spellboundHealPer5,
    keeperskill_def_per = keeperskillDefPer,
    is_chaos_type2 = is_chaos_type2
  }
  local curHeal, baseHeal = BattleUtilServer.ShowHealFormula(data)
  return curHeal, baseHeal
end

function BattleCmdServer:__GetFinalHeal(showHeal, target, formulaSubType)
  local onlyIncludeSelf = formulaSubType == bc.FormulaSubType.OnlyIncludeSelf
  local finalValue = showHeal
  if not onlyIncludeSelf then
    local beHealPer = target:GetProperty(BP.be_heal_per)
    local beHealPlus = target:GetProperty(BP.be_heal_plus)
    finalValue = math.max(math.ceil(showHeal * (1 + beHealPer / 100) + beHealPlus))
  end
  return finalValue
end

function BattleCmdServer:GetRealHeal(baseHeal, target, paraPlusName, formulaSubType)
  self.battleEngine:Debug("传入治疗为", baseHeal)
  local showHeal = self:__GetShowHeal(baseHeal, paraPlusName, nil, formulaSubType)
  self.battleEngine:Debug("卡面治疗为", showHeal)
  local finalHeal = self:__GetFinalHeal(showHeal, target, formulaSubType)
  self.battleEngine:Debug("最终治疗为", finalHeal)
  return finalHeal
end

function BattleCmdServer:__GetShowUltiEnergy(value, paraPlusName, caster, formulaSubType)
  local ignoreBonus = formulaSubType == bc.FormulaSubType.OnlyIncludeTarget
  local awakerUltiEnergyPer = 0
  local i_awakerUltiEnergyPer = 0
  local outUltiEnergyPer = 0
  local awakerUltiEnergyEff = 0
  local skillTypeEnergyPer = 1
  local awakerUltiEnergyPlus = 0
  local awakerUltiEnergyPlus2 = 0
  local curCardUltiEnergyPer = 0
  local cardUltiEnergyPlus = 0
  caster = caster or self.battleEngine:GetObj(self.castRoleUid)
  local card = self.battleEngine:GetObj(self.cardUid)
  if card then
    curCardUltiEnergyPer = card:GetProperty(BP.card_ulti_per)
    cardUltiEnergyPlus = card:GetProperty(BP.card_ulti_plus)
    if not ignoreBonus and caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) and card:CardTypeMatch({
      bc.SkillType.Card_Skill,
      bc.SkillType.Card_Defend,
      bc.SkillType.Card_Extend,
      bc.SkillType.Card_Strike
    }) then
      outUltiEnergyPer = caster:GetProperty(BP.o_ulti_energy_per)
    end
  end
  local skillTypes = self:GetSkillType()
  local dimension_fix_per = self:GetDimensionFixPer(caster)
  if not ignoreBonus and caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    awakerUltiEnergyPer = caster:GetProperty(BP.ulti_energy_per)
    i_awakerUltiEnergyPer = caster:GetProperty(BP.i_ulti_energy_per)
    awakerUltiEnergyEff = caster:GetProperty(BP.ulti_energy_efficiency)
    for _, skillType in ipairs(skillTypes) do
      local skillper = caster:GetProperty(bc.SkillType2UltiPer[skillType]) or 0
      skillTypeEnergyPer = skillTypeEnergyPer * (1 + skillper / 100)
    end
    awakerUltiEnergyPlus = caster:GetProperty(BP.ulti_energy_plus)
  end
  local skillArgsPlus = self:GetSkillArgsPlus(paraPlusName)
  local data = {
    value = value,
    i_awakerUltiEnergyPer = i_awakerUltiEnergyPer,
    awakerUltiEnergyPer = awakerUltiEnergyPer,
    outUltiEnergyPer = outUltiEnergyPer,
    awakerUltiEnergyEff = awakerUltiEnergyEff,
    skillTypeEnergyPer = skillTypeEnergyPer,
    awakerUltiEnergyPlus = awakerUltiEnergyPlus,
    awakerUltiEnergyPlus2 = awakerUltiEnergyPlus2,
    curCardUltiEnergyPer = curCardUltiEnergyPer,
    cardUltiEnergyPlus = cardUltiEnergyPlus,
    skillArgsPlus = skillArgsPlus,
    dimension_fix_per = dimension_fix_per
  }
  do return BattleUtilServer.ShowUltiEnergyFormula end
  return BattleUtilServer.ShowUltiEnergyFormula, data, bc.SkillType.Card_Strike, nil, 0, 1 + skillper / 100, bc.SkillType2UltiPer[skillType]
end

function BattleCmdServer:__GetFinalUltiEnergy(showValue, target, formulaSubType)
  local onlyIncludeSelf = formulaSubType == bc.FormulaSubType.OnlyIncludeSelf
  local finalValue = showValue
  if not onlyIncludeSelf then
    local beEnergyPer = target:GetProperty(BP.gain_ulti_energy_per)
    local beEnergyPlus = target:GetProperty(BP.gain_ulti_energy_plus)
    finalValue = math.max(math.ceil(showValue * (1 + beEnergyPer / 100) + beEnergyPlus))
  end
  return finalValue
end

function BattleCmdServer:GetRealUltiEnergy(baseValue, target, formulaSubType)
  self.battleEngine:Debug("传入狂气为", baseValue)
  local showValue = self:__GetShowUltiEnergy(baseValue, nil, nil, formulaSubType)
  self.battleEngine:Debug("卡面狂气为", showValue)
  local finalValue = self:__GetFinalUltiEnergy(showValue, target, formulaSubType)
  self.battleEngine:Debug("最终狂气为", finalValue)
  return finalValue
end

function BattleCmdServer:__GetShowKeeperEnergy(base)
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  local eff = player:GetProperty(BP.keeper_energy_eff)
  local dimension_fix_per = self:GetDimensionFixPer()
  local curValue = math.ceil(base * (eff / 100 + 1) * (dimension_fix_per / 100 + 1))
  local baseValue = math.ceil(base)
  return curValue, baseValue
end

function BattleCmdServer:GetRealKeeperEnergy(baseValue)
  self.battleEngine:Debug("传入钥能为", baseValue)
  local showValue = self:__GetShowKeeperEnergy(baseValue)
  self.battleEngine:Debug("卡面钥能为", showValue)
  return showValue
end

function BattleCmdServer:CreateChildCmdServer(childArgs)
  local childCmdServer = BattleCmdServer(self.battleEngine, self.cmdCtorData)
  if childArgs and #childArgs > 0 then
    childCmdServer.createCardArgs = childArgs
  end
  childCmdServer.parentCmdServer = self
  childCmdServer:SetUpperTargets(self:GetUpperTargets())
  return childCmdServer
end

function BattleCmdServer:GenerateEffectList(executeCmdId, skipPhase)
  if self:CheckLoopCall(executeCmdId) then
    return
  end
  if not executeCmdId then
    self.executeCmdIdList = {}
  end
  local skillArgs, _ = self:GetSkillArgs()
  self.cmdParser:UpdateSkillArgs(skillArgs)
  local cmdId = executeCmdId or self.cmdId
  local cmdCfg = self.battleEngine.battleDT.Cmd[cmdId]
  local skillCfg = self.battleEngine.battleDT.Skill[self.skillConfigId]
  local cmdDataList = cmdCfg.data_list
  local effectList = {}
  local effectDelayTimes = self:GetEffectDelayTimes(cmdDataList, executeCmdId)
  for index, cmdData in ipairs(cmdDataList or {}) do
    local delay = effectDelayTimes[index]
    if skipPhase and (not skillCfg.NotAwakerCardPerform or next(skillCfg.NotAwakerCardPerform) == nil) then
      delay = 0
    end
    local effectObj = self:GenerateEffectObj(cmdData, delay, skipPhase, index)
    if effectObj then
      table.insert(effectList, effectObj)
    end
  end
  return effectList
end

function BattleCmdServer:GetEffectDelayTimes(cmdDataList, executeCmdId)
  local effectDelayRealTimes = {}
  local totalDelayTime = 0
  local isUsedCastTime = false
  for index, cmdData in ipairs(cmdDataList) do
    local cfgDelayTime = cmdData.DelayTime
    if not cfgDelayTime then
      if not isUsedCastTime then
        cfgDelayTime = "cast"
      else
        cfgDelayTime = 0
      end
    end
    if not tonumber(cfgDelayTime) then
      isUsedCastTime = true
    end
    if tonumber(cfgDelayTime) then
      totalDelayTime = totalDelayTime + tonumber(cfgDelayTime) / 1000
    elseif not self.isPreCmd and not executeCmdId then
      do
        local delayTime = self:GetSkillCastTime(cfgDelayTime)
        totalDelayTime = delayTime or totalDelayTime
      end
    end
    effectDelayRealTimes[index] = totalDelayTime
    for i, time in ipairs(effectDelayRealTimes) do
      if time > totalDelayTime then
        effectDelayRealTimes[i] = totalDelayTime
      end
    end
  end
  local effectDelayDeltaTimes = {}
  for i = 1, #effectDelayRealTimes do
    effectDelayDeltaTimes[i] = effectDelayRealTimes[i] - (effectDelayRealTimes[i - 1] or 0)
  end
  return effectDelayDeltaTimes
end

function BattleCmdServer:CheckLoopCall(executeCmdId)
  if nil ~= executeCmdId then
    local executeCmdIdList = self.executeCmdIdList
    for _, cmdId in ipairs(executeCmdIdList) do
      if cmdId == executeCmdId then
        local cmdCfg = self.battleEngine.battleDT.Cmd[cmdId]
        local errMsg = string.format("执行指令包含嵌套: %s 嵌套列表", cmdCfg.CnID)
        self.battleEngine:Error(errMsg)
        return true
      end
    end
    table.insert(executeCmdIdList, executeCmdId)
  end
end

function BattleCmdServer:GenerateEffectObj(cmdData, effectDelayTime, skipPhase, index)
  local cmdName = cmdData.Type
  local DT = self.battleEngine.battleDT
  local effectObj
  local battleApiCfg = DT.BattleApi[cmdName]
  if battleApiCfg.ApiType == bc.ApiType.CMD then
    local params = string.split(cmdName, ".")
    local effectType, fixArg = params[1], params[2]
    if string.startswith(effectType, "BE") then
      local effectConfig = {
        effectType = effectType,
        fixArg = fixArg,
        cmdCfg = cmdData,
        cmdServer = self,
        cmdIndex = index,
        BeforeDelay = effectDelayTime,
        castRoleUid = self.castRoleUid,
        skipPhase = skipPhase,
        isFromCmd = true,
        interruptCmdCond = cmdData.InterruptCmdCond
      }
      local effectMgr = self.battleEngine.effectMgr
      effectObj = effectMgr:CreateEffect(effectConfig, true)
    else
      self.battleEngine:Warn("GenerateEffectObj Effect not found", effectType)
    end
  end
  return effectObj
end

function BattleCmdServer:CheckCondition(conditionCmd)
  local ret = self:GetValueByCmd(conditionCmd)
  local isOk = true == ret
  self.cmdParser.lastConditionRet = isOk
  self.battleEngine:LogBattleWithTab("检查条件：%s %s", conditionCmd, isOk)
  return isOk
end

function BattleCmdServer:GetSkillLoopTime()
  local animFile = self:GetAnimFileName()
  if not animFile then
    return 0
  end
  local _, castAnimation = self:GetPerformInfo()
  local DT = self.battleEngine.battleDT
  local timelineCfg = DT.TimelineEventData[animFile]
  local animationInfo = timelineCfg and timelineCfg[castAnimation]
  self.isTimeline = true
  if nil ~= animationInfo then
    return animationInfo.loopTime
  end
  return 0
end

function BattleCmdServer:GetAnimFileName()
  local performSkillId = self:GetPerformSkillId()
  if not performSkillId then
    return
  end
  local skillCfg = self.battleEngine.battleDT.Skill[performSkillId]
  if skillCfg.Type[1] == bc.SkillType.Keeper_Skill then
    return "BUnit_Keeper"
  end
  if skillCfg.NotAwakerCardPerform and next(skillCfg.NotAwakerCardPerform) then
    return skillCfg.NotAwakerCardPerform[1]
  end
  local role = self.battleEngine:GetObj(self.castRoleUid)
  do return role.GetSpineName end
  return role.GetSpineName, role
end

function BattleCmdServer:GetPerformSkillId()
  local card = self.battleEngine:GetObj(self.cardUid)
  if card and card.data.performSkillId then
    return card.data.performSkillId
  else
    return self.skillConfigId
  end
end

function BattleCmdServer:GetPerformInfo()
  local skillCfg = self.battleEngine.battleDT.Skill[self:GetPerformSkillId()]
  if not skillCfg then
    return
  end
  local performTypeList = skillCfg.PerformType or {}
  local performList = skillCfg.Perform or {}
  local idx = 1
  if skillCfg.PerformCond then
    for i, cond in ipairs(skillCfg.PerformCond) do
      local ret = self:GetValueByCmd(cond)
      if true == ret then
        idx = i
        break
      end
    end
  end
  return performTypeList[idx], performList[idx], idx
end

function BattleCmdServer:GetSkillDuration()
  local DT = self.battleEngine.battleDT
  local animFile = self:GetAnimFileName()
  if not animFile then
    return 0
  end
  local performType, castAnimation = self:GetPerformInfo()
  if performType == bc.SkillPerformType.Spine then
    if nil == castAnimation then
      return 0
    end
    local spineCfg = DT.SpineEventData[animFile]
    if not spineCfg then
      return 0
    end
    local animConfig = spineCfg[castAnimation]
    return animConfig and animConfig.duration or 0
  elseif performType == bc.SkillPerformType.Timeline then
    local timelineCfg = DT.TimelineEventData[animFile]
    local animationInfo = timelineCfg and timelineCfg[castAnimation]
    self.isTimeline = true
    return animationInfo and animationInfo.duration or 0
  end
end

function BattleCmdServer:GetSkillCastTime_Spine(castEvent)
  local DT = self.battleEngine.battleDT
  local animFile = self:GetAnimFileName()
  local skillCfg = DT.Skill[self.skillConfigId]
  if not skillCfg.Perform then
    return
  end
  local _, castAnimation = self:GetPerformInfo()
  local spineCfg = DT.SpineEventData[animFile]
  if not spineCfg then
    return
  end
  self.isTimeline = false
  local animConfig = spineCfg[castAnimation]
  if not animConfig then
    self.battleEngine:Error("GetSkillCastTime error: animationName wrong", animFile, castAnimation)
    return 1
  end
  if not (animConfig and animConfig.eventList) or next(animConfig.eventList) == nil then
    return
  end
  for _, eventData in ipairs(animConfig.eventList) do
    local eventName = eventData.name
    local eventTime = eventData.time
    if eventName:upper() == castEvent:upper() then
      return eventTime
    end
  end
  local defaultEvent = animConfig.eventList[1]
  if defaultEvent then
    return defaultEvent.time
  end
end

function BattleCmdServer:GetSkillCastTime_Timeline(castEvent)
  local animFile = self:GetAnimFileName()
  if not animFile then
    return
  end
  local _, castAnimation = self:GetPerformInfo()
  do return self.GetTimelineCastTime, self, animFile, castAnimation end
  return self.GetTimelineCastTime, self, animFile, castAnimation, castEvent
end

function BattleCmdServer:GetTimelineCastTime(spineName, castAnim, castEvent)
  local DT = self.battleEngine.battleDT
  local timelineCfg = DT.TimelineEventData[spineName]
  local animationInfo = timelineCfg and timelineCfg[castAnim]
  self.isTimeline = true
  if nil ~= animationInfo then
    if not castEvent or "cast" == castEvent then
      return animationInfo.castTime
    elseif "cast2" == castEvent then
      return animationInfo.castTime2 or animationInfo.castTime
    elseif "cast3" == castEvent then
      return animationInfo.castTime3 or animationInfo.castTime
    elseif "timeline_end" == castEvent then
      return animationInfo.duration
    end
  end
end

function BattleCmdServer:GetSkillCastTime(castEvent)
  castEvent = castEvent or "cast"
  local performType, _ = self:GetPerformInfo()
  if not performType then
    return
  end
  if performType == bc.SkillPerformType.Spine then
    do return self.GetSkillCastTime_Spine, self end
    return self.GetSkillCastTime_Spine, self, castEvent
  elseif performType == bc.SkillPerformType.Timeline then
    do return self.GetSkillCastTime_Timeline, self end
    return self.GetSkillCastTime_Timeline, self, castEvent
  end
end

function BattleCmdServer:SendNotAwakerTimeline(skipTimeline)
  if skipTimeline then
    return
  end
  local role = self.battleEngine.roleMgr:GetRoleByUid(self.castRoleUid)
  local skillId = self.cmdParser.skillConfigId
  if not skillId then
    return
  end
  local skillCfg = self.battleEngine.battleDT.Skill[skillId]
  if not skillCfg then
    return
  end
  if not role:IsRoleType(bc.RoleType.Player) then
    return
  end
  if not skillCfg.NotAwakerCardPerform then
    return
  end
  self.battleEngine.recordMgr:OnNotAwakerTimeline(self.castRoleUid, skillId)
end

function BattleCmdServer:OnEnterBeforePhase(upperTargets)
  local role = self.battleEngine.roleMgr:GetRoleByUid(self.castRoleUid)
  local skillId = self.cmdParser.skillConfigId
  local _, castAnimation, performIdx = self:GetPerformInfo()
  if not castAnimation then
    return
  end
  if role:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
    local firstTarget = upperTargets and upperTargets[1]
    local targetRoleUid = firstTarget and firstTarget.uid
    local config = {
      gameSpeed = self.battleEngine.gameSpeed,
      actionAwakerId = role.uid,
      skillConfigId = skillId,
      targetRoleUid = targetRoleUid,
      isExclusiveAction = true,
      animFile = role:GetSpineName(),
      performSkillId = self:GetPerformSkillId(),
      performIdx = performIdx,
      isTimeline = self.isTimeline,
      rootType = nil,
      rootConfigId = skillId
    }
    if 1 == self.cmdParser:IsSuperUtlSkill() then
      config.isSuperUtliSkill = true
    end
    role:ChangeFsmState(bc.AwakerFsmState.Attack, config)
  end
end

function BattleCmdServer:OnEnterCastPhase()
end

function BattleCmdServer:OnEnterFinishPhase()
  self:SetIsDeleted(true)
  self.upperTargets = {}
end

function BattleCmdServer:SetLastEffect(uid)
  self.cmdParser.lastEffectUid = uid
end

function BattleCmdServer:GetLastEffect()
  return self.cmdParser.lastEffectUid
end

function BattleCmdServer:GetStats(key)
  return self.stats[key]
end

function BattleCmdServer:AddStats(key, value)
  self.stats[key] = (self.stats[key] or 0) + value
  if self.parentCmdServer then
    self.parentCmdServer:AddStats(key, value)
  end
end

function BattleCmdServer:ClearStats()
  self.stats = {}
end

function BattleCmdServer:GetCardUltiPer()
  local skillCfg = self.battleEngine.battleDT.Skill[self.skillConfigId]
  local propertyName
  local awaker = self.battleEngine:GetObj(self.castRoleUid)
  if not awaker:IsRoleType(bc.RoleType.Awaker) then
    return 0
  end
  if self.cardUid then
    local card = self.battleEngine:GetObj(self.cardUid)
    if not card then
      return 0
    end
    local cardTypes = card:GetType()
    local v = 0
    for _, cardType in ipairs(cardTypes) do
      propertyName = bc.SkillType2UltiPer[cardType]
      v = v + (awaker:GetProperty(propertyName) or 0)
    end
    return v
  elseif skillCfg then
    local v = 0
    for _, skillType in ipairs(skillCfg.Type) do
      propertyName = bc.SkillType2UltiPer[skillCfg.Type]
      v = v + (awaker:GetProperty(propertyName) or 0)
    end
  end
  return 0
end

function BattleCmdServer:GetSkillLevel()
  do return self.cmdParser.GetSkillLevel end
  return self.cmdParser.GetSkillLevel, self.cmdParser
end

function BattleCmdServer:SetIsDeleted(deleted)
  self.isDeleted = deleted
end

function BattleCmdServer:GetCasterCamp()
  do return self.cmdParser.GetCasterCamp end
  return self.cmdParser.GetCasterCamp, self.cmdParser
end

function BattleCmdServer:GetCaster()
  do return self.battleEngine.GetObj, self.battleEngine end
  return self.battleEngine.GetObj, self.battleEngine, self.castRoleUid
end

function BattleCmdServer:__GetAttackTimes(value)
  local caster = self.battleEngine:GetObj(self.castRoleUid)
  if not caster then
    return value, value
  end
  local data = {
    value = value,
    damagetimes_plus = caster:GetProperty(BP.damagetimes_plus),
    damagetimes_per = caster:GetProperty(BP.damagetimes_per)
  }
  do return BattleUtilServer.AttackTimesFormula end
  return BattleUtilServer.AttackTimesFormula, data, BP.damagetimes_per
end

function BattleCmdServer:__GetShowPoison(value)
  local caster = self.battleEngine:GetObj(self.castRoleUid)
  if not caster then
    return value, value
  end
  local card = self.battleEngine:GetObj(self.cardUid)
  local card_state_layer_per_poison = 0
  local awaker_ulti_state_layer_per_poison = 0
  local awaker_CmdCard_state_layer_per_poison = 0
  local card_fixed_state_layer_per_poison = 0
  local awaker_ulti_fixed_state_layer_per_poison = 0
  local awaker_CmdCard_fixed_state_layer_per_poison = 0
  local card_fixed_state_layer_per_poison_n2 = 0
  local skipCardBehaviorPer = self:IsStateTriggerAdd()
  if not skipCardBehaviorPer then
    if card then
      local isInstructionCard = card:CardTypeMatch(bc.CardTypeInstruction)
      card_state_layer_per_poison = card:GetProperty(BP.card_state_layer_per_poison) or 0
      card_fixed_state_layer_per_poison = card:GetProperty(BP.card_fixed_state_layer_per_poison) or 0
      if isInstructionCard then
        card_fixed_state_layer_per_poison_n2 = caster:GetProperty(BP.card_fixed_state_layer_per_poison_n2) or 0
      end
    end
    if caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
      local skillTypes = self:GetSkillType()
      for _, skillType in ipairs(skillTypes) do
        if skillType == bc.SkillType.Ulti_Skill then
          awaker_ulti_state_layer_per_poison = caster:GetProperty(BP.awaker_ulti_state_layer_per_poison) or awaker_ulti_state_layer_per_poison
          awaker_ulti_fixed_state_layer_per_poison = caster:GetProperty(BP.awaker_ulti_fixed_state_layer_per_poison) or awaker_ulti_fixed_state_layer_per_poison
          break
        end
      end
    end
    if card and card:CardTypeMatch(bc.CardTypeInstruction) then
      awaker_CmdCard_state_layer_per_poison = caster:GetProperty(BP.awaker_CmdCard_state_layer_per_poison) or 0
      awaker_CmdCard_fixed_state_layer_per_poison = caster:GetProperty(BP.awaker_CmdCard_fixed_state_layer_per_poison) or 0
    end
  end
  local keeperskillAtkPer, _, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local skipNewChaosKeeperskill = self:ShouldSkipNewChaosKeeperskillForStateTag()
  local data = {
    value = value,
    card_state_layer_per_poison = card_state_layer_per_poison,
    awaker_ulti_state_layer_per_poison = awaker_ulti_state_layer_per_poison,
    awaker_CmdCard_state_layer_per_poison = awaker_CmdCard_state_layer_per_poison,
    card_fixed_state_layer_per_poison = card_fixed_state_layer_per_poison,
    card_fixed_state_layer_per_poison_n2 = card_fixed_state_layer_per_poison_n2,
    awaker_ulti_fixed_state_layer_per_poison = awaker_ulti_fixed_state_layer_per_poison,
    awaker_CmdCard_fixed_state_layer_per_poison = awaker_CmdCard_fixed_state_layer_per_poison,
    keeperskill_atk_per = keeperskillAtkPer,
    is_chaos_type2 = is_chaos_type2,
    skipNewChaosKeeperskill = skipNewChaosKeeperskill
  }
  local env = setmetatable(data, {
    __index = function(t, key)
      local v = caster:GetProperty(BP[key])
      t[key] = v
      return v
    end
  })
  local curPoison, basePoison = BattleUtilServer.PoisonFormula(env)
  return curPoison, basePoison
end

function BattleCmdServer:__GetShowCorrosion(value)
  local caster = self.battleEngine:GetObj(self.castRoleUid)
  if not caster then
    return value, value
  end
  local keeperskillAtkPer, _, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local skipNewChaosKeeperskill = self:ShouldSkipNewChaosKeeperskillForStateTag()
  local data = {
    value = value,
    keeperskill_atk_per = keeperskillAtkPer,
    is_chaos_type2 = is_chaos_type2,
    skipNewChaosKeeperskill = skipNewChaosKeeperskill
  }
  local env = setmetatable(data, {
    __index = function(t, key)
      local v = caster:GetProperty(BP[key])
      t[key] = v
      return v
    end
  })
  do return BattleUtilServer.CorrosionFormula end
  return BattleUtilServer.CorrosionFormula, env, function(t, key)
    local v = caster:GetProperty(BP[key])
    t[key] = v
    return v
  end
end

function BattleCmdServer:__GetShowCounterattack(value)
  local caster = self.battleEngine:GetObj(self.castRoleUid)
  if not caster then
    return value, value
  end
  local card = self.battleEngine:GetObj(self.cardUid)
  local card_state_layer_per_counterattack = 0
  local awaker_ulti_state_layer_per_counterattack = 0
  local awaker_CmdCard_state_layer_per_counterattack = 0
  local card_fixed_state_layer_per_counterattack = 0
  local awaker_ulti_fixed_state_layer_per_counterattack = 0
  local awaker_CmdCard_fixed_state_layer_per_counterattack = 0
  local card_fixed_state_layer_per_counterattack_n2 = 0
  local skipCardBehaviorPer = self:IsStateTriggerAdd()
  if not skipCardBehaviorPer then
    if card then
      local isInstructionCard = card:CardTypeMatch(bc.CardTypeInstruction)
      card_state_layer_per_counterattack = card:GetProperty(BP.card_state_layer_per_counterattack) or 0
      card_fixed_state_layer_per_counterattack = card:GetProperty(BP.card_fixed_state_layer_per_counterattack) or 0
      if isInstructionCard then
        card_fixed_state_layer_per_counterattack_n2 = caster:GetProperty(BP.card_fixed_state_layer_per_counterattack_n2) or 0
      end
    end
    if caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
      local skillTypes = self:GetSkillType()
      for _, skillType in ipairs(skillTypes) do
        if skillType == bc.SkillType.Ulti_Skill then
          awaker_ulti_state_layer_per_counterattack = caster:GetProperty(BP.awaker_ulti_state_layer_per_counterattack) or awaker_ulti_state_layer_per_counterattack
          awaker_ulti_fixed_state_layer_per_counterattack = caster:GetProperty(BP.awaker_ulti_fixed_state_layer_per_counterattack) or awaker_ulti_fixed_state_layer_per_counterattack
          break
        end
      end
    end
    if card and card:CardTypeMatch(bc.CardTypeInstruction) then
      awaker_CmdCard_state_layer_per_counterattack = caster:GetProperty(BP.awaker_CmdCard_state_layer_per_counterattack) or 0
      awaker_CmdCard_fixed_state_layer_per_counterattack = caster:GetProperty(BP.awaker_CmdCard_fixed_state_layer_per_counterattack) or 0
    end
  end
  local keeperskillAtkPer, _, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local skipNewChaosKeeperskill = self:ShouldSkipNewChaosKeeperskillForStateTag()
  local data = {
    value = value,
    card_state_layer_per_counterattack = card_state_layer_per_counterattack,
    awaker_ulti_state_layer_per_counterattack = awaker_ulti_state_layer_per_counterattack,
    awaker_CmdCard_state_layer_per_counterattack = awaker_CmdCard_state_layer_per_counterattack,
    card_fixed_state_layer_per_counterattack = card_fixed_state_layer_per_counterattack,
    card_fixed_state_layer_per_counterattack_n2 = card_fixed_state_layer_per_counterattack_n2,
    awaker_ulti_fixed_state_layer_per_counterattack = awaker_ulti_fixed_state_layer_per_counterattack,
    awaker_CmdCard_fixed_state_layer_per_counterattack = awaker_CmdCard_fixed_state_layer_per_counterattack,
    keeperskill_atk_per = keeperskillAtkPer,
    is_chaos_type2 = is_chaos_type2,
    skipNewChaosKeeperskill = skipNewChaosKeeperskill
  }
  local env = setmetatable(data, {
    __index = function(t, key)
      local v = caster:GetProperty(BP[key])
      t[key] = v
      return v
    end
  })
  local curCounterattack, baseCounterattack = BattleUtilServer.CounterattackFormula(env)
  return curCounterattack, baseCounterattack
end

function BattleCmdServer:__GetShowCut(value)
  local caster = self.battleEngine:GetObj(self.castRoleUid)
  if not caster then
    return value, value
  end
  local card = self.battleEngine:GetObj(self.cardUid)
  local card_fixed_state_layer_per_fatecut = 0
  local awaker_ulti_fixed_state_layer_per_fatecut = 0
  local awaker_CmdCard_fixed_state_layer_per_fatecut = 0
  local card_fixed_state_layer_per_fatecut_n2 = 0
  local skipCardBehaviorPer = self:IsStateTriggerAdd()
  if not skipCardBehaviorPer then
    if card then
      local isInstructionCard = card:CardTypeMatch(bc.CardTypeInstruction)
      card_fixed_state_layer_per_fatecut = card:GetProperty(BP.card_fixed_state_layer_per_fatecut) or 0
      if isInstructionCard then
        card_fixed_state_layer_per_fatecut_n2 = caster:GetProperty(BP.card_fixed_state_layer_per_fatecut_n2) or 0
      end
    end
    if caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
      local skillTypes = self:GetSkillType()
      for _, skillType in ipairs(skillTypes) do
        if skillType == bc.SkillType.Ulti_Skill then
          awaker_ulti_fixed_state_layer_per_fatecut = caster:GetProperty(BP.awaker_ulti_fixed_state_layer_per_fatecut) or awaker_ulti_fixed_state_layer_per_fatecut
          break
        end
      end
    end
    if card and card:CardTypeMatch(bc.CardTypeInstruction) then
      awaker_CmdCard_fixed_state_layer_per_fatecut = caster:GetProperty(BP.awaker_CmdCard_fixed_state_layer_per_fatecut) or 0
    end
  end
  local keeperskillAtkPer, _, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local skipNewChaosKeeperskill = self:ShouldSkipNewChaosKeeperskillForStateTag()
  local data = {
    value = value,
    card_fixed_state_layer_per_fatecut = card_fixed_state_layer_per_fatecut,
    card_fixed_state_layer_per_fatecut_n2 = card_fixed_state_layer_per_fatecut_n2,
    awaker_ulti_fixed_state_layer_per_fatecut = awaker_ulti_fixed_state_layer_per_fatecut,
    awaker_CmdCard_fixed_state_layer_per_fatecut = awaker_CmdCard_fixed_state_layer_per_fatecut,
    keeperskill_atk_per = keeperskillAtkPer,
    is_chaos_type2 = is_chaos_type2,
    skipNewChaosKeeperskill = skipNewChaosKeeperskill
  }
  local env = setmetatable(data, {
    __index = function(t, key)
      local v = caster:GetProperty(BP[key])
      t[key] = v
      return v
    end
  })
  do return BattleUtilServer.CutFormula end
  return BattleUtilServer.CutFormula, env, function(t, key)
    local v = caster:GetProperty(BP[key])
    t[key] = v
    return v
  end, BP.awaker_ulti_fixed_state_layer_per_fatecut, "awaker_ulti_fixed_state_layer_per_fatecut"
end

function BattleCmdServer:__GetShowExhaustion(value)
  local caster = self.battleEngine:GetObj(self.castRoleUid)
  if not caster then
    return value, value
  end
  local card = self.battleEngine:GetObj(self.cardUid)
  local card_state_layer_per_exhaustion = 0
  local awaker_ulti_state_layer_per_exhaustion = 0
  local card_state_layer_per_exhaustion_n2 = 0
  local skipCardBehaviorPer = self:IsStateTriggerAdd()
  if not skipCardBehaviorPer then
    if card then
      local isInstructionCard = card:CardTypeMatch(bc.CardTypeInstruction)
      card_state_layer_per_exhaustion = card:GetProperty(BP.card_state_layer_per_exhaustion) or 0
      if isInstructionCard then
        card_state_layer_per_exhaustion_n2 = caster:GetProperty(BP.card_state_layer_per_exhaustion_n2) or 0
      end
    end
    if caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) then
      local skillTypes = self:GetSkillType()
      for _, skillType in ipairs(skillTypes) do
        if skillType == bc.SkillType.Ulti_Skill then
          awaker_ulti_state_layer_per_exhaustion = caster:GetProperty(BP.awaker_ulti_state_layer_per_exhaustion) or awaker_ulti_state_layer_per_exhaustion
          break
        end
      end
    end
  end
  local _, keeperskillDefPer, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local data = {
    value = value,
    card_state_layer_per_exhaustion = card_state_layer_per_exhaustion,
    card_state_layer_per_exhaustion_n2 = card_state_layer_per_exhaustion_n2,
    awaker_ulti_state_layer_per_exhaustion = awaker_ulti_state_layer_per_exhaustion,
    keeperskill_def_per = keeperskillDefPer,
    is_chaos_type2 = is_chaos_type2
  }
  local env = setmetatable(data, {
    __index = function(t, key)
      local v = caster:GetProperty(BP[key])
      t[key] = v
      return v
    end
  })
  local curExhaustion, baseExhaustion = BattleUtilServer.ExhaustionFormula(env)
  return curExhaustion, baseExhaustion
end

function BattleCmdServer:__GetShowPower(value)
  local caster = self.battleEngine:GetObj(self.castRoleUid)
  if not caster then
    return value, value
  end
  local card = self.battleEngine:GetObj(self.cardUid)
  local o_state_layer_per_power_bycmd = 0
  local card_state_layer_per_power = 0
  local awaker_ulti_state_layer_per_power = 0
  local card_state_layer_per_power_n2 = 0
  local skillTypes = self:GetSkillType()
  local skipCardBehaviorPer = self:IsStateTriggerAdd()
  if not skipCardBehaviorPer then
    for _, skillType in ipairs(skillTypes) do
      if skillType == bc.SkillType.Ulti_Skill then
        awaker_ulti_state_layer_per_power = caster:GetProperty(BP.awaker_ulti_state_layer_per_power) or awaker_ulti_state_layer_per_power
        break
      end
    end
    if card then
      local isInstructionCard = card:CardTypeMatch(bc.CardTypeInstruction)
      if caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) and card:CardTypeMatch({
        bc.SkillType.Card_Skill,
        bc.SkillType.Card_Defend,
        bc.SkillType.Card_Extend,
        bc.SkillType.Card_Strike
      }) then
        o_state_layer_per_power_bycmd = caster:GetProperty(BP.o_state_layer_per_power_bycmd)
      end
      card_state_layer_per_power = card:GetProperty(BP.card_state_layer_per_power)
      if isInstructionCard then
        card_state_layer_per_power_n2 = caster:GetProperty(BP.card_state_layer_per_power_n2) or 0
      end
    end
  end
  local keeperskillAtkPer, _, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local data = {
    value = value,
    o_state_layer_per_power_bycmd = o_state_layer_per_power_bycmd,
    card_state_layer_per_power = card_state_layer_per_power,
    card_state_layer_per_power_n2 = card_state_layer_per_power_n2,
    awaker_ulti_state_layer_per_power = awaker_ulti_state_layer_per_power,
    keeperskill_atk_per = keeperskillAtkPer,
    is_chaos_type2 = is_chaos_type2
  }
  local env = setmetatable(data, {
    __index = function(t, key)
      local v = caster:GetProperty(BP[key])
      t[key] = v
      return v
    end
  })
  local curPower, basePower = BattleUtilServer.PowerFormula(env)
  return curPower, basePower
end

function BattleCmdServer:__GetShowTentacle(value)
  local caster = self.battleEngine:GetObj(self.castRoleUid)
  if not caster then
    return value, value
  end
  local card = self.battleEngine:GetObj(self.cardUid)
  local instructcard_basic_state_layer_per_tentacle_dmg = 0
  local ulti_basic_state_layer_per_tentacle_dmg = 0
  local card_basic_state_layer_per_tentacle_dmg = 0
  local instructcard_final_state_layer_per_tentacle_dmg = 0
  local ulti_final_state_layer_per_tentacle_dmg = 0
  local card_state_layer_per_tentacle_dmg = 0
  local card_state_layer_per_TentaclePower = 0
  local awaker_ulti_state_layer_per_TentaclePower = 0
  local card_state_layer_per_TentaclePower_n2 = 0
  local skillTypes = self:GetSkillType()
  local skipCardBehaviorPer = self:IsStateTriggerAdd()
  if not skipCardBehaviorPer then
    for _, skillType in ipairs(skillTypes) do
      if skillType == bc.SkillType.Ulti_Skill then
        awaker_ulti_state_layer_per_TentaclePower = caster:GetProperty(BP.awaker_ulti_state_layer_per_TentaclePower) or awaker_ulti_state_layer_per_TentaclePower
        break
      end
    end
    if card then
      local isInstructionCard = card:CardTypeMatch(bc.CardTypeInstruction)
      if caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) and card:CardTypeMatch({
        bc.SkillType.Card_Skill,
        bc.SkillType.Card_Defend,
        bc.SkillType.Card_Extend,
        bc.SkillType.Card_Strike
      }) then
        instructcard_basic_state_layer_per_tentacle_dmg = caster:GetProperty(BP.instructcard_basic_state_layer_per_tentacle_dmg)
        instructcard_final_state_layer_per_tentacle_dmg = caster:GetProperty(BP.instructcard_final_state_layer_per_tentacle_dmg)
        card_state_layer_per_tentacle_dmg = card:GetProperty(BP.card_state_layer_per_tentacle_dmg)
      end
      if caster:IsRoleType(bc.RoleType.Awaker, bc.RoleType.Monster) and card:CardTypeMatch({
        bc.SkillType.Ulti_Skill
      }) then
        ulti_basic_state_layer_per_tentacle_dmg = caster:GetProperty(BP.ulti_basic_state_layer_per_tentacle_dmg)
        card_basic_state_layer_per_tentacle_dmg = card:GetProperty(BP.card_basic_state_layer_per_tentacle_dmg)
        ulti_final_state_layer_per_tentacle_dmg = caster:GetProperty(BP.ulti_final_state_layer_per_tentacle_dmg)
      end
      card_state_layer_per_TentaclePower = card:GetProperty(BP.card_state_layer_per_TentaclePower) or 0
      if isInstructionCard then
        card_state_layer_per_TentaclePower_n2 = caster:GetProperty(BP.card_state_layer_per_TentaclePower_n2) or 0
      end
    end
  end
  local keeperskillAtkPer, _, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local data = {
    value = value,
    instructcard_basic_state_layer_per_tentacle_dmg = instructcard_basic_state_layer_per_tentacle_dmg,
    ulti_basic_state_layer_per_tentacle_dmg = ulti_basic_state_layer_per_tentacle_dmg,
    card_basic_state_layer_per_tentacle_dmg = card_basic_state_layer_per_tentacle_dmg,
    instructcard_final_state_layer_per_tentacle_dmg = instructcard_final_state_layer_per_tentacle_dmg,
    ulti_final_state_layer_per_tentacle_dmg = ulti_final_state_layer_per_tentacle_dmg,
    card_state_layer_per_tentacle_dmg = card_state_layer_per_tentacle_dmg,
    card_state_layer_per_TentaclePower = card_state_layer_per_TentaclePower,
    card_state_layer_per_TentaclePower_n2 = card_state_layer_per_TentaclePower_n2,
    awaker_ulti_state_layer_per_TentaclePower = awaker_ulti_state_layer_per_TentaclePower,
    keeperskill_atk_per = keeperskillAtkPer,
    is_chaos_type2 = is_chaos_type2
  }
  local env = setmetatable(data, {
    __index = function(t, key)
      local v = caster:GetProperty(BP[key])
      t[key] = v
      return v
    end
  })
  local curTentacle, baseTentacle = BattleUtilServer.TentacleShowFormula(env)
  return curTentacle, baseTentacle
end

function BattleCmdServer:__GetShowBleed(value)
  local caster = self.battleEngine:GetObj(self.castRoleUid)
  if not caster then
    return value, value
  end
  local keeperskillAtkPer, _, is_chaos_type2 = self:GetNewChaosKeeperskillParams()
  local skipNewChaosKeeperskill = self:ShouldSkipNewChaosKeeperskillForStateTag()
  local data = {
    value = value,
    keeperskill_atk_per = keeperskillAtkPer,
    is_chaos_type2 = is_chaos_type2,
    skipNewChaosKeeperskill = skipNewChaosKeeperskill
  }
  local env = setmetatable(data, {
    __index = function(t, key)
      local v = caster:GetProperty(BP[key])
      t[key] = v
      return v
    end
  })
  local curBleed, baseBleed = BattleUtilServer.BleedFormula(env)
  return curBleed, baseBleed
end

function BattleCmdServer:GetRealPoison(baseValue, target, paraPlusName, formulaSubType)
  self.battleEngine:Debug("传入中毒为", baseValue)
  local showPoison = self:__GetShowPoison(baseValue)
  self.battleEngine:Debug("卡面中毒为", showPoison)
  return showPoison
end

function BattleCmdServer:GetRealCounterattack(baseValue, target, paraPlusName, formulaSubType)
  self.battleEngine:Debug("传入反击为", baseValue)
  local showCounterattack = self:__GetShowCounterattack(baseValue)
  self.battleEngine:Debug("卡面反击为", showCounterattack)
  return showCounterattack
end

function BattleCmdServer:GetRealPower(baseValue, target, paraPlusName, formulaSubType)
  self.battleEngine:Debug("传入力量为", baseValue)
  local showPower = self:__GetShowPower(baseValue)
  self.battleEngine:Debug("卡面力量为", showPower)
  return showPower
end

function BattleCmdServer:GetRealTentaclePower(baseValue, target, paraPlusName, formulaSubType)
  self.battleEngine:Debug("传入触腕力量为", baseValue)
  local showTentacle = self:__GetShowTentacle(baseValue)
  self.battleEngine:Debug("卡面触腕力量为", showTentacle)
  return showTentacle
end

function BattleCmdServer:GetRealExhaustion(baseValue, target, paraPlusName, formulaSubType)
  self.battleEngine:Debug("传入衰竭为", baseValue)
  local showExhaustion = self:__GetShowExhaustion(baseValue)
  self.battleEngine:Debug("卡面衰竭为", showExhaustion)
  return showExhaustion
end

function BattleCmdServer:GetRealFateCut(baseValue, target, paraPlusName, formulaSubType)
  self.battleEngine:Debug("传入命运裁断为", baseValue)
  local showFateCut = self:__GetShowCut(baseValue)
  self.battleEngine:Debug("卡面命运裁断为", showFateCut)
  return showFateCut
end

function BattleCmdServer:GetRealCorrosion(baseValue, target, paraPlusName, formulaSubType)
  self.battleEngine:Debug("传入侵蚀为", baseValue)
  local showCorrosion = self:__GetShowCorrosion(baseValue)
  self.battleEngine:Debug("卡面侵蚀为", showCorrosion)
  return showCorrosion
end

function BattleCmdServer:GetTargetOnlyGenerate()
  if not self.battleEngine:IsPVP() then
    return true
  end
  if not self.skillConfigId then
    return false
  end
  local skillCfg = self.battleEngine.battleDT.Skill[self.skillConfigId]
  if not skillCfg then
    return false
  end
  self.battleEngine:SetTargetFlag(true)
  local caster = self.battleEngine:GetObj(self.castRoleUid)
  local breakSkillLevel, potencyLevel
  if caster and caster:IsRoleType(bc.RoleType.Awaker) then
    breakSkillLevel, potencyLevel = caster:GetBreakSkillAndPotencyLevel()
  end
  local cfgTarget = self.battleEngine:GetSkillTargetType(self.castRoleUid, self.skillConfigId, self.skillLevel, breakSkillLevel, potencyLevel)
  if self.cardUid then
    local card = self.battleEngine:GetObj(self.cardUid)
    cfgTarget = card:GetCmdTarget()
  end
  local _, data = self:GenerateTargetsExp(cfgTarget)
  self.battleEngine:SetTargetFlag(nil)
  return data
end

function BattleCmdServer:CheckClientTargets(targetUids)
  local data = self:GetTargetOnlyGenerate()
  print(" CheckClientTargets ", table.tostring(targetUids), table.tostring(data))
  if not data then
    return data
  end
  if data.replaceClientTarget then
    return true
  end
  if not data.targetUids or 0 == #data.targetUids then
    return false
  end
  if #targetUids ~= #data.targetUids and 1 ~= #targetUids then
    return false
  end
  for _, targetUid in ipairs(targetUids) do
    if not table.contains(data.targetUids, targetUid) then
      return false
    end
  end
  return true
end

function BattleCmdServer:IsTriggerBST()
  if not self:IsAttachPost() then
    return true
  end
  local isTriggerBST = self.attachPostParam.isTriggerBST
  return isTriggerBST
end

function BattleCmdServer:IsAttachPost()
  return self.attachPostParam ~= nil
end

return BattleCmdServer
