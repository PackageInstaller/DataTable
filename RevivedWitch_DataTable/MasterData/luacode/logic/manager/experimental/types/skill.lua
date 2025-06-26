-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/skill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillItemTable = (BeanManager.GetTableByName)("item.cskillitem")
local CSkillTable = (BeanManager.GetTableByName)("skill.cskill")
local CSkillTypeTable = (BeanManager.GetTableByName)("skill.cskillmaptype")
local CCostSkillTable = (BeanManager.GetTableByName)("skill.ccostskill")
local CSkillShow_Role = (BeanManager.GetTableByName)("skill.cskillshow_role")
local CSkillShow_Soul = (BeanManager.GetTableByName)("skill.cskillshow_soul")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local Item = require("logic.manager.experimental.types.item")
local Skill = strictclass("Skill", Item)
Skill.Type = {Active = 1, Charging = 2, Passive = 3, Attribute = 4}
Skill.Ctor = function(self, id, isSKill_itemId)
  -- function num : 0_0 , upvalues : CSkillItemTable, _ENV, CSkillTable, CSkillTypeTable, CSkillShow_Soul, CSkillShow_Role, Skill
  local itemId = nil
  if not isSKill_itemId then
    itemId = id
    self._isItem = true
    self._skillItemRecord = CSkillItemTable:GetRecorder(itemId)
    if not self._skillItemRecord then
      LogErrorFormat("Skill", "skillItem with id %s is not exist in cskillitem", itemId)
    end
    self._skillId = ((self._skillItemRecord).skillID)[1]
    self._supportSkillId = ((self._skillItemRecord).assistskillID)[1]
  else
    itemId = isSKill_itemId
    self._skillId = id
  end
  self._skillRecord = CSkillTable:GetRecorder(self._skillId)
  if not self._skillRecord then
    LogErrorFormat("Skill", "skill with id %s is not exist in cskill", self._skillId)
  else
    if not self._skillItemRecord then
      self._skillItemRecord = CSkillItemTable:GetRecorder(itemId)
      if self._skillItemRecord then
        self._supportSkillId = ((self._skillItemRecord).assistskillID)[(self._skillRecord).skillLevel]
      end
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
    ;
    ((Skill.super).Ctor)(self, itemId)
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
      ;
      ((Skill.super).Ctor)(self, itemId)
    end
  end
end

Skill.InitWithFull = function(self, iteminfo)
  -- function num : 0_1 , upvalues : Skill
  if iteminfo then
    ((Skill.super).InitWithFull)(self, iteminfo)
  end
end

Skill.SetLevel = function(self, level)
  -- function num : 0_2 , upvalues : CSkillTable, _ENV, CSkillTypeTable, CSkillShow_Soul, CSkillShow_Role
  self._isItem = false
  self._skillId = ((self._skillItemRecord).skillID)[level]
  self._supportSkillId = ((self._skillItemRecord).assistskillID)[level]
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

Skill.Clone = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return clone(self)
end

Skill.GetSkillId = function(self)
  -- function num : 0_4
  return self._skillId
end

Skill.GetType = function(self)
  -- function num : 0_5
  return (self._skillTypeRecord).skillMapType
end

Skill.IsPassive = function(self)
  -- function num : 0_6 , upvalues : Skill
  local type = self:GetType()
  do return type == (Skill.Type).Passive or type == (Skill.Type).Attribute end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Skill.GetTypeTxt = function(self)
  -- function num : 0_7 , upvalues : _ENV
  return (TextManager.GetText)((self._skillShowRecord).typeTextID)
end

Skill.GetRangeTxt = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if not self:IsPassive() then
    return (TextManager.GetText)((self._skillShowRecord).rangeTextID)
  end
end

Skill.GetYellowCost = function(self)
  -- function num : 0_9 , upvalues : CCostSkillTable, _ENV
  local skillCostRecord = CCostSkillTable:GetRecorder(self._skillId)
  if skillCostRecord.pureCost ~= "" then
    local rec = (string.split)(skillCostRecord.pureCost, ";")
    local func1, func1para = self:GetFunction(rec[1])
    if func1para == "orderpwr" then
      return tonumber(func1(0))
    else
      if func1para == "chaoscostreduce" then
        return tonumber(func1(0))
      else
        if func1para == "ordercostreduce" then
          return tonumber(func1(0))
        else
          return tonumber(rec[1])
        end
      end
    end
  else
    do
      do return skillCostRecord.OrderCost end
    end
  end
end

Skill.GetPurpleCost = function(self)
  -- function num : 0_10 , upvalues : CCostSkillTable, _ENV
  local skillCostRecord = CCostSkillTable:GetRecorder(self._skillId)
  if skillCostRecord.pureCost ~= "" then
    local rec = (string.split)(skillCostRecord.pureCost, ";")
    local func2, func2para = self:GetFunction(rec[2])
    if func2para == "chaospwr" then
      return tonumber(func2(0))
    else
      if func2para == "chaoscostreduce" then
        return tonumber(func2(0))
      else
        if func2para == "ordercostreduce" then
          return tonumber(func2(0))
        else
          return tonumber(rec[2])
        end
      end
    end
  else
    do
      do return skillCostRecord.ChaosCost end
    end
  end
end

Skill.GetFunction = function(self, funcStr)
  -- function num : 0_11 , upvalues : _ENV
  if (string.find)(funcStr, "orderpwr") then
    local str = "return function(orderpwr) return " .. funcStr .. " end"
    return (assert(load(str)))(), "orderpwr"
  else
    do
      if (string.find)(funcStr, "chaospwr") then
        local str = "return function(chaospwr) return " .. funcStr .. " end"
        return (assert(load(str)))(), "chaospwr"
      else
        do
          if (string.find)(funcStr, "chaoscostreduce") then
            local str = "return function(chaoscostreduce) return " .. funcStr .. " end"
            return (assert(load(str)))(), "chaoscostreduce"
          else
            do
              if (string.find)(funcStr, "ordercostreduce") then
                local str = "return function(ordercostreduce) return " .. funcStr .. " end"
                return (assert(load(str)))(), "ordercostreduce"
              end
            end
          end
        end
      end
    end
  end
end

Skill.GetDescribeTxt = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local str = (TextManager.GetText)((self._skillShowRecord).exDiscribeTextID)
  if #(self._skillShowRecord).attr > 0 then
    for i,v in ipairs((self._skillShowRecord).attr) do
      str = (string.gsub)(str, "%$parameter" .. i .. "%$", v)
    end
  end
  do
    return str
  end
end

Skill.GetSkillLevel = function(self)
  -- function num : 0_13
  return (self._skillRecord).skillLevel
end

Skill.GetSkillMaxLevel = function(self)
  -- function num : 0_14
  return (self._skillTypeRecord).maxLevel
end

Skill.GetSkillName = function(self)
  -- function num : 0_15 , upvalues : _ENV
  return (TextManager.GetText)((self._skillShowRecord).nameTextID)
end

Skill.GetSkillIcon = function(self)
  -- function num : 0_16 , upvalues : CImagePathTable, CSkillTable, _ENV
  if not CImagePathTable:GetRecorder((CSkillTable:GetRecorder(self._skillId)).icon) then
    return DataCommon.DefaultImageAsset
  end
end

Skill.GetChargingNumByRoleId = function(self, roleId)
  -- function num : 0_17 , upvalues : Skill, RoleConfigTable
  if self:GetType() == (Skill.Type).Charging then
    local roleConfigRecord = RoleConfigTable:GetRecorder(roleId)
    local skillItemId = self:GetID()
    if skillItemId == roleConfigRecord.contractskillid then
      return roleConfigRecord.comborate1
    else
      if skillItemId == roleConfigRecord.contractskillid2 then
        return roleConfigRecord.comborate2
      end
    end
  end
end

Skill.GetSupportSkillName = function(self)
  -- function num : 0_18 , upvalues : _ENV
  return (TextManager.GetText)((self._supportSkillShowRecord).nameTextID)
end

Skill.GetSupportSkillIcon = function(self)
  -- function num : 0_19 , upvalues : CImagePathTable, CSkillTable, _ENV
  if not CImagePathTable:GetRecorder((CSkillTable:GetRecorder(self._supportSkillId)).icon) then
    return DataCommon.DefaultImageAsset
  end
end

Skill.GetSupportSkillLevel = function(self)
  -- function num : 0_20
  return (self._supportSkillRecord).skillLevel
end

Skill.GetSupportSkillDescribeTxt = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local str = (TextManager.GetText)((self._supportSkillShowRecord).exDiscribeTextID)
  if #(self._supportSkillShowRecord).attr > 0 then
    for i,v in ipairs((self._supportSkillShowRecord).attr) do
      str = (string.gsub)(str, "%$parameter" .. i .. "%$", v)
    end
  end
  do
    return str
  end
end

return Skill

