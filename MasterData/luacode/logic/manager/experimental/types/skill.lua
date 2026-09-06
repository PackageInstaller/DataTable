local CSkillItemTable = BeanManager.GetTableByName("item.cskillitem")
local CSkillTable = BeanManager.GetTableByName("skill.cskill")
local CSkillTypeTable = BeanManager.GetTableByName("skill.cskillmaptype")
local CCostSkillTable = BeanManager.GetTableByName("skill.ccostskill")
local CSkillShow_Role = BeanManager.GetTableByName("skill.cskillshow_role")
local CSkillShow_Soul = BeanManager.GetTableByName("skill.cskillshow_soul")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local Item = require("logic.manager.experimental.types.item")
local Skill = strictclass("Skill", Item)
Skill.Type = {
  Active = 1,
  Charging = 2,
  Passive = 3,
  Attribute = 4
}

function Skill:Ctor(id, isSKill_itemId)
  local itemId
  if not isSKill_itemId then
    itemId = id
    self._isItem = true
    self._skillItemRecord = CSkillItemTable:GetRecorder(itemId)
    if not self._skillItemRecord then
      LogErrorFormat("Skill", "skillItem with id %s is not exist in cskillitem", itemId)
    end
    self._skillId = self._skillItemRecord.skillID[1]
    self._supportSkillId = self._skillItemRecord.assistskillID[1]
  else
    itemId = isSKill_itemId
    self._skillId = id
  end
  self._skillRecord = CSkillTable:GetRecorder(self._skillId)
  if not self._skillRecord then
    LogErrorFormat("Skill", "skill with id %s is not exist in cskill", self._skillId)
  elseif not self._skillItemRecord then
    self._skillItemRecord = CSkillItemTable:GetRecorder(itemId)
    if self._skillItemRecord then
      self._supportSkillId = self._skillItemRecord.assistskillID[self._skillRecord.skillLevel]
    end
  end
  self._skillTypeRecord = CSkillTypeTable:GetRecorder(self._skillId)
  if not self._skillTypeRecord then
    LogErrorFormat("Skill", "skill with id %s is not exist in cskillmaptype", self._skillId)
  end
  if self:IsPassive() then
    self._skillShowRecord = CSkillShow_Soul:GetRecorder(self._skillId)
    if not self._skillShowRecord then
      LogErrorFormat("Skill", "no id %s in cskillshow_soul", self._skillId)
    end
  else
    self._skillShowRecord = CSkillShow_Role:GetRecorder(self._skillId)
    if not self._skillShowRecord then
      LogErrorFormat("Skill", "no id %s in cskillshow_role", self._skillId)
    end
    Skill.super.Ctor(self, itemId)
  end
  if self._supportSkillId then
    self._supportSkillRecord = CSkillTable:GetRecorder(self._supportSkillId)
    if not self._supportSkillRecord then
      LogErrorFormat("Skill", "skill with id %s is not exist in cskill", self._supportSkillId)
    end
    self._supportSkillTypeRecord = CSkillTypeTable:GetRecorder(self._supportSkillId)
    if not self._supportSkillTypeRecord then
      LogErrorFormat("Skill", "skill with id %s is not exist in cskillmaptype", self._supportSkillId)
    end
    if self:IsPassive() then
      self._supportSkillShowRecord = CSkillShow_Soul:GetRecorder(self._supportSkillId)
      if not self._supportSkillShowRecord then
        LogErrorFormat("Skill", "no id %s in cskillshow_soul", self._supportSkillId)
      end
    else
      self._supportSkillShowRecord = CSkillShow_Role:GetRecorder(self._supportSkillId)
      if not self._supportSkillShowRecord then
        LogErrorFormat("Skill", "no id %s in cskillshow_role", self._supportSkillId)
      end
      Skill.super.Ctor(self, itemId)
    end
  end
end

function Skill:InitWithFull(iteminfo)
  if iteminfo then
    Skill.super.InitWithFull(self, iteminfo)
  end
end

function Skill:SetLevel(level)
  self._isItem = false
  self._skillId = self._skillItemRecord.skillID[level]
  self._supportSkillId = self._skillItemRecord.assistskillID[level]
  self._skillRecord = CSkillTable:GetRecorder(self._skillId)
  if not self._skillRecord then
    LogErrorFormat("Skill", "skill with id %s is not exist in cskill", self._skillId)
  end
  self._skillTypeRecord = CSkillTypeTable:GetRecorder(self._skillId)
  if not self._skillTypeRecord then
    LogErrorFormat("Skill", "skill with id %s is not exist in cskillmaptype", self._skillId)
  end
  if self:IsPassive() then
    self._skillShowRecord = CSkillShow_Soul:GetRecorder(self._skillId)
    if not self._skillShowRecord then
      LogErrorFormat("Skill", "no id %s in cskillshow_soul", self._skillId)
    end
  else
    self._skillShowRecord = CSkillShow_Role:GetRecorder(self._skillId)
    if not self._skillShowRecord then
      LogErrorFormat("Skill", "no id %s in cskillshow_role", self._skillId)
    end
  end
  if self._supportSkillId then
    self._supportSkillRecord = CSkillTable:GetRecorder(self._supportSkillId)
    if not self._supportSkillRecord then
      LogErrorFormat("Skill", "skill with id %s is not exist in cskill", self._supportSkillId)
    end
    self._supportSkillTypeRecord = CSkillTypeTable:GetRecorder(self._supportSkillId)
    if not self._supportSkillTypeRecord then
      LogErrorFormat("Skill", "skill with id %s is not exist in cskillmaptype", self._supportSkillId)
    end
    if self:IsPassive() then
      self._supportSkillShowRecord = CSkillShow_Soul:GetRecorder(self._supportSkillId)
      if not self._supportSkillShowRecord then
        LogErrorFormat("Skill", "no id %s in cskillshow_soul", self._supportSkillId)
      end
    else
      self._supportSkillShowRecord = CSkillShow_Role:GetRecorder(self._supportSkillId)
      if not self._supportSkillShowRecord then
        LogErrorFormat("Skill", "no id %s in cskillshow_role", self._supportSkillId)
      end
    end
  end
end

function Skill:Clone()
  return clone(self)
end

function Skill:GetSkillId()
  return self._skillId
end

function Skill:GetType()
  return self._skillTypeRecord.skillMapType
end

function Skill:IsPassive()
  local type = self:GetType()
  return type == Skill.Type.Passive or type == Skill.Type.Attribute
end

function Skill:GetTypeTxt()
  return TextManager.GetText(self._skillShowRecord.typeTextID)
end

function Skill:GetRangeTxt()
  if not self:IsPassive() then
    return TextManager.GetText(self._skillShowRecord.rangeTextID)
  end
end

function Skill:GetYellowCost()
  local skillCostRecord = CCostSkillTable:GetRecorder(self._skillId)
  if skillCostRecord.pureCost ~= "" then
    local rec = string.split(skillCostRecord.pureCost, ";")
    local func1, func1para = self:GetFunction(rec[1])
    if func1para == "orderpwr" then
      return tonumber(func1(0))
    elseif func1para == "chaoscostreduce" then
      return tonumber(func1(0))
    elseif func1para == "ordercostreduce" then
      return tonumber(func1(0))
    else
      return tonumber(rec[1])
    end
  else
    return skillCostRecord.OrderCost
  end
end

function Skill:GetPurpleCost()
  local skillCostRecord = CCostSkillTable:GetRecorder(self._skillId)
  if skillCostRecord.pureCost ~= "" then
    local rec = string.split(skillCostRecord.pureCost, ";")
    local func2, func2para = self:GetFunction(rec[2])
    if func2para == "chaospwr" then
      return tonumber(func2(0))
    elseif func2para == "chaoscostreduce" then
      return tonumber(func2(0))
    elseif func2para == "ordercostreduce" then
      return tonumber(func2(0))
    else
      return tonumber(rec[2])
    end
  else
    return skillCostRecord.ChaosCost
  end
end

function Skill:GetFunction(funcStr)
  if string.find(funcStr, "orderpwr") then
    local str = "return function(orderpwr) return " .. funcStr .. " end"
    return assert(load(str))(), "orderpwr"
  elseif string.find(funcStr, "chaospwr") then
    local str = "return function(chaospwr) return " .. funcStr .. " end"
    return assert(load(str))(), "chaospwr"
  elseif string.find(funcStr, "chaoscostreduce") then
    local str = "return function(chaoscostreduce) return " .. funcStr .. " end"
    return assert(load(str))(), "chaoscostreduce"
  elseif string.find(funcStr, "ordercostreduce") then
    local str = "return function(ordercostreduce) return " .. funcStr .. " end"
    return assert(load(str))(), "ordercostreduce"
  end
end

function Skill:GetDescribeTxt()
  local str = TextManager.GetText(self._skillShowRecord.exDiscribeTextID)
  if #self._skillShowRecord.attr > 0 then
    for i, v in ipairs(self._skillShowRecord.attr) do
      str = string.gsub(str, "%$parameter" .. i .. "%$", v)
    end
  end
  return str
end

function Skill:GetSkillLevel()
  return self._skillRecord.skillLevel
end

function Skill:GetSkillMaxLevel()
  return self._skillTypeRecord.maxLevel
end

function Skill:GetSkillName()
  return TextManager.GetText(self._skillShowRecord.nameTextID)
end

function Skill:GetSkillIcon()
  return CImagePathTable:GetRecorder(CSkillTable:GetRecorder(self._skillId).icon) or DataCommon.DefaultImageAsset
end

function Skill:GetChargingNumByRoleId(roleId)
  if self:GetType() == Skill.Type.Charging then
    local roleConfigRecord = RoleConfigTable:GetRecorder(roleId)
    local skillItemId = self:GetID()
    if skillItemId == roleConfigRecord.contractskillid then
      return roleConfigRecord.comborate1
    elseif skillItemId == roleConfigRecord.contractskillid2 then
      return roleConfigRecord.comborate2
    end
  end
end

function Skill:GetSupportSkillName()
  return TextManager.GetText(self._supportSkillShowRecord.nameTextID)
end

function Skill:GetSupportSkillIcon()
  return CImagePathTable:GetRecorder(CSkillTable:GetRecorder(self._supportSkillId).icon) or DataCommon.DefaultImageAsset
end

function Skill:GetSupportSkillLevel()
  return self._supportSkillRecord.skillLevel
end

function Skill:GetSupportSkillDescribeTxt()
  local str = TextManager.GetText(self._supportSkillShowRecord.exDiscribeTextID)
  if #self._supportSkillShowRecord.attr > 0 then
    for i, v in ipairs(self._supportSkillShowRecord.attr) do
      str = string.gsub(str, "%$parameter" .. i .. "%$", v)
    end
  end
  return str
end

return Skill
