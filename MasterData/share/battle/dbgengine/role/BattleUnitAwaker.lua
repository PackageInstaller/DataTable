local System = require("System.System")
local BattleUnitBase = require("Battle.DbgEngine.Role.BattleUnitBase")
local PathUtils = require("Battle.Util.PathUtils")
local BattleConst = require("Battle.BattleConst")
local BP = BattleConst.BattleProperty
local BattleUnitAwaker, Super = System.NewClass("BattleUnitAwaker", BattleUnitBase)

function BattleUnitAwaker:OnInit()
  local DT = self.battleEngine.battleDT
  self.configData = DT.AwakerConfig[self.tid]
  if self.battleEngine:IsPVP() then
    self.animationId = self.configData.PVPAnimationID
    self.animationConfig = DT.PVPAnimationConfig[self.animationId]
  else
    self.animationId = self.configData.AnimationID
    self.animationConfig = DT.AnimationConfig[self.animationId]
  end
  local spineName = PathUtils.GetBaseName(self.animationConfig.spineName)
  self.spineFileName = spineName
  self.prefabName = spineName
  self.roleType = BattleConst.RoleType.Awaker
  self.schoolConfigId = self.configData.School
  self.data.skillId, self.data.skillLevel = self:GetSkillIdAndLevel()
end

function BattleUnitAwaker:OnAfterInit_PVE()
  local DT = self.battleEngine.battleDT
  local timesLimit = tonumber(DT.GetConstant("BoutUltiSkillTimes"))
  self:AddProperty(BP.bout_ulti_times, timesLimit, {})
  self.data.boutSkillTimes = 0
  self.tagManager:InitTagState()
  local configData = self.configData
  if configData and configData.Tag then
    for _, tag in ipairs(configData.Tag) do
      self.tagManager:AddTag(tag)
    end
  end
end

function BattleUnitAwaker:OnAfterInit_PVP()
end

function BattleUnitAwaker:HasHpBar()
  do return self.battleEngine.IsPVP end
  return self.battleEngine.IsPVP, self.battleEngine
end

function BattleUnitAwaker:GetBattleLogName()
  local cfg = self.battleEngine.battleDT.AwakerConfig[self.tid]
  local name = cfg.Name:match("%|(.*)")
  do return string.format, "[阵营%s-%s(%s)]", self.camp, cfg.CnID end
  return string.format, "[阵营%s-%s(%s)]", self.camp, cfg.CnID, name
end

function BattleUnitAwaker:GetSkillIdAndLevel()
  local slotData = self.data.slots and #self.data.slots > 0 and self.data.slots[1]
  local ultiSkillId = slotData and slotData.tid
  local ultiSkillLevel = slotData and slotData.level
  return ultiSkillId, ultiSkillLevel
end

function BattleUnitAwaker:GetBeforeSkillEffectType()
  return BattleConst.BattleEffectType.BEBeforeUseUlti
end

function BattleUnitAwaker:GetAfterSkillEffectType()
  return BattleConst.BattleEffectType.BEAfterUseUlti
end

function BattleUnitAwaker:GainPassiveUltiEnergy()
  local player = self.battleEngine.roleMgr:GetPlayer(self.camp)
  local passUltiEnergy = self:GetProperty(BP.ulti_energy_passive)
  local extraData = {
    castRoleUid = player.uid
  }
  do return self.GainUltiEnergy, self, passUltiEnergy end
  return self.GainUltiEnergy, self, passUltiEnergy, extraData
end

function BattleUnitAwaker:GetUltiCost()
  local baseCost
  if self.battleEngine:IsPVP() then
    baseCost = BattleConst.UltiEnergyPerSkill
  else
    baseCost = self.configData and self.configData.ulti_energy_max or BattleConst.UltiEnergyPerSkill
  end
  local costPer = self:GetProperty(BP.ulti_energy_cost_per) or 0
  local costFlat = self:GetProperty(BP.ulti_energy_cost_flat) or 0
  local cost = baseCost * (1 + costPer / 100) + costFlat
  do return math.floor end
  return math.floor, cost + 0.5
end

function BattleUnitAwaker:GainUltiEnergy(value, extraData)
  local ultiEnergy = self:GetProperty(BP.ulti_energy)
  local afterUltiEnergy = math.floor(ultiEnergy + value)
  local maxUltiEnergy = self.property:GetMaxUltiEnergy()
  local addNum
  if afterUltiEnergy > maxUltiEnergy then
    addNum = maxUltiEnergy - ultiEnergy
  else
    addNum = value
  end
  addNum = math.ceil(addNum)
  if addNum <= 0 then
    return 0
  end
  ultiEnergy = self.property:ChangeProperty(BP.ulti_energy, addNum, extraData) or 0
  return ultiEnergy
end

function BattleUnitAwaker:RestoreFullUltiEnergy()
  local maxUltiEnergy = self.property:GetMaxUltiEnergy()
  local ultiEnergy = self:GetProperty(BP.ulti_energy)
  local player = self:GetPlayer()
  local extraData = {
    castRoleUid = player.uid
  }
  self:GainUltiEnergy(maxUltiEnergy - ultiEnergy, extraData)
end

function BattleUnitAwaker:OnBoutBegin_PVE()
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  if self.camp ~= curCamp then
    return
  end
  self.data.boutSkillTimes = 0
  self.battleEngine.recordMgr:OnSkillTimesChange(self.uid, 0)
end

function BattleUnitAwaker:OnBattleEnd_PVE()
  self:GainPassiveUltiEnergy()
end

function BattleUnitAwaker:OnBoutEnd_PVE()
  local curCamp = self.battleEngine.boutMgr:GetCurCamp()
  if self.camp ~= curCamp then
    return
  end
  self:GainPassiveUltiEnergy()
end

function BattleUnitAwaker:GetAwakerType()
  return self.configData.Type
end

function BattleUnitAwaker:GetID()
  return self.configData.ID
end

function BattleUnitAwaker:PreCheckDeathEvent()
  do return self.battleEngine.IsPVP end
  return self.battleEngine.IsPVP, self.battleEngine
end

function BattleUnitAwaker:NeedAfterPhase()
  do return self.battleEngine.IsPVP end
  return self.battleEngine.IsPVP, self.battleEngine
end

function BattleUnitAwaker:OnAfterCreateSkillPhase(eventData)
  if eventData.castRoleUid ~= self.uid then
    return
  end
  local card = self.battleEngine:GetObj(eventData.cardUid)
  if not card then
    return
  end
  if card:CardTypeMatch(BattleConst.SkillType.Card_Awake) then
    local extraData = {
      castRoleUid = self.uid,
      reason = BattleConst.PropertyChangeReason.AttrSet
    }
    self:SetProperty(BP.awaked, 1, extraData)
  end
end

function BattleUnitAwaker:GetTargetType()
  return BattleConst.ObjType.TypeAwaker
end

function BattleUnitAwaker:GetSpineName()
  return self.prefabName
end

function BattleUnitAwaker:CanUseUltiSkill(targetUids, replaceUids)
  if self:IsDead() or self:HpIs0() then
    return false, BattleConst.UltiFailedReason.Dead
  end
  local timesLimit = self:GetProperty(BP.bout_ulti_times)
  if timesLimit and 0 ~= timesLimit and timesLimit <= self.data.boutSkillTimes then
    return false, BattleConst.UltiFailedReason.NoTimes
  end
  local proName = BP.ulti_energy
  local ultiEnergy = self:GetProperty(proName)
  local skillId, skillLevel = self:GetSkillIdAndLevel()
  local skillCfg = self.battleEngine.battleDT.Skill[skillId]
  if not skillCfg then
    return false, BattleConst.UltiFailedReason.NoSkill
  end
  local cost = self:GetUltiCost()
  if ultiEnergy < cost then
    return false, BattleConst.UltiFailedReason.NoEnergy
  end
  local coma = self:GetProperty(BP.PVPComa)
  local immueComa = self:GetProperty(BP.PVPImmue_Coma)
  if coma and coma > 0 and (not immueComa or 0 == immueComa) then
    return false, BattleConst.UltiFailedReason.Coma
  end
  local sealUlti = self:GetProperty(BP.seal_ulti)
  local immueSealUlti = self:GetProperty(BP.immue_seal_ulti)
  if (not immueSealUlti or 0 == immueSealUlti) and sealUlti and sealUlti > 0 then
    return false, BattleConst.UltiFailedReason.Seal
  end
  if self.battleEngine:IsPVP() and targetUids and not replaceUids then
    local cmdServer = self:GetSkillCmd(skillId, skillLevel)
    local ret = cmdServer:CheckClientTargets(targetUids)
    if not ret then
      local player = self.battleEngine.roleMgr:GetPlayer(self:GetCamp())
      self.battleEngine.gameplay:SetTargetModel(player.uid, BattleConst.PVPTargetModel.Server)
      return ret, BattleConst.UltiFailedReason.TargetNotMatch
    end
  end
  return true
end

function BattleUnitAwaker:UseUltiSkill(targetUids)
  local skillId, skillLevel = self:GetSkillIdAndLevel()
  local beforeEffType = self:GetBeforeSkillEffectType()
  local afterEffType = self:GetAfterSkillEffectType()
  self:UseSkill(skillId, skillLevel, beforeEffType, afterEffType, targetUids)
end

function BattleUnitAwaker:LoseUltiEnergy(value, extraData)
  local ultiEnergy = self:SubProperty(BP.ulti_energy, value, extraData)
  return ultiEnergy
end

function BattleUnitAwaker:CanUseSuperUtlSkill()
  if self:GetProperty(BP.ulti_skill_level_up) > 0 then
    return true
  end
  if not self.data.doubleUltiEnergy then
    return false
  end
  local ultiEnergy = self:GetProperty(BP.ulti_energy)
  local maxUltiEnergy = self.property:GetMaxUltiEnergy()
  if ultiEnergy >= maxUltiEnergy then
    return true
  end
  return false
end

function BattleUnitAwaker:GetSlotCards()
  local ret = {}
  local existSkills = {}
  for _, slot in ipairs(self.data.slots) do
    local tid = slot.tid
    local cfg = self.battleEngine.battleDT.Skill[tid]
    if cfg and cfg.Slot then
      ret[cfg.Slot] = slot
      existSkills[tid] = true
    end
  end
  local DT = require("System.DataTable")
  local awakerSkillListCfg = DT.Skill_AwakerSkill[self.tid]
  if awakerSkillListCfg then
    for _, skillId in ipairs(awakerSkillListCfg) do
      local cfg = DT.Skill[skillId]
      if not cfg.Slot then
      elseif not existSkills[skillId] and string.find(cfg.Slot, "Extend") and not ret[cfg.Slot] then
        ret[cfg.Slot] = {
          tid = skillId,
          level = 1,
          slot = BattleConst.SlotOrder[cfg.Slot]
        }
      end
    end
  end
  return ret
end

function BattleUnitAwaker:GetPotencyPower()
  local DT = self.battleEngine.battleDT
  local awakerPotencyPowerList = DT.GetOriginalConstant("AwakerLevelStrength")
  local awakerConfig = DT.AwakerConfig[self.tid]
  local addLevelKey = "AwakerUpgradeLevel_" .. awakerConfig.Quality
  local qualityAddLevel = DT.GetConstant(addLevelKey)
  local level = self.level + qualityAddLevel
  if level > #awakerPotencyPowerList then
    return 0
  end
  return awakerPotencyPowerList[level]
end

function BattleUnitAwaker:GetPlayer()
  do return self.battleEngine.roleMgr.GetPlayer, self.battleEngine.roleMgr end
  return self.battleEngine.roleMgr.GetPlayer, self.battleEngine.roleMgr, self.camp
end

function BattleUnitAwaker:GetBreakSkillAndPotencyLevel()
  return self.data.breakSkillLevel, self.data.potencyLevel
end

function BattleUnitAwaker:GetLikeLevel()
  return self.data.likeLevel or 0
end

function BattleUnitAwaker:OnSnapShot()
  do return Super.OnSnapShot end
  return Super.OnSnapShot, self
end

function BattleUnitAwaker:OnRecover(snapshotData)
  Super.OnRecover(self, snapshotData)
end

return BattleUnitAwaker
