-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/newcharskillchangecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Skill = require("logic.manager.experimental.types.skill")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSkillTable = (BeanManager.GetTableByName)("skill.cskill")
local NewCharSkillChangeCell = class("NewCharSkillChangeCell", Dialog)
NewCharSkillChangeCell.AssetBundleName = "ui/layouts.basecharacterinfo"
NewCharSkillChangeCell.AssetName = "CharSkillChangeCell"
local needSkillNum = 2
NewCharSkillChangeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewCharSkillChangeCell
  ((NewCharSkillChangeCell.super).Ctor)(self, ...)
end

NewCharSkillChangeCell.OnCreate = function(self)
  -- function num : 0_1
  self._skillIcon = self:GetChild("SkillBack/Skill")
  self._skillName = self:GetChild("TitleBack/Num")
  self._skillLv = self:GetChild("Level/Num")
  self._yellowCost = self:GetChild("Num1")
  self._purpleCost = self:GetChild("Num2")
  self._detail = self:GetChild("Detail")
  self._toggle = self:GetChild("_Toggle_0")
  ;
  (self._toggle):Subscribe_PointerClickEvent(self.OnValueChanged, self)
end

NewCharSkillChangeCell.OnDestroy = function(self)
  -- function num : 0_2
end

NewCharSkillChangeCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Skill, _ENV, needSkillNum
  local skill = (Skill.Create)(data.skillId, data.skillItemId)
  local imgRecord = skill:GetSkillIcon()
  ;
  (self._skillIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  ;
  (self._skillName):SetText(skill:GetSkillName())
  ;
  (self._skillLv):SetText(skill:GetSkillLevel())
  ;
  (self._yellowCost):SetText(skill:GetYellowCost())
  ;
  (self._purpleCost):SetText(skill:GetPurpleCost())
  ;
  (self._detail):SetText(skill:GetDescribeTxt())
  local selectSkillList = ((self._delegate):GetCheckSkillList())
  local tag = nil
  for i,v in ipairs(selectSkillList) do
    if v == data.skillItemId then
      tag = true
      break
    end
  end
  do
    if tag then
      (self._toggle):SetIsOnType(true)
      ;
      (self._toggle):SetInteractable(true)
    else
      ;
      (self._toggle):SetIsOnType(false)
      if #selectSkillList == needSkillNum then
        (self._toggle):SetInteractable(false)
      else
        ;
        (self._toggle):SetInteractable(true)
      end
    end
  end
end

NewCharSkillChangeCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_4 , upvalues : _ENV, needSkillNum
  if eventName == "InteractiveState" then
    if arg then
      (self._toggle):SetInteractable(true)
    else
      local selectSkillList = ((self._delegate):GetCheckSkillList())
      local tag = nil
      for i,v in ipairs(selectSkillList) do
        if v == (self._cellData).skillItemId then
          tag = true
          break
        end
      end
      do
        if tag then
          (self._toggle):SetInteractable(true)
        else
          if #selectSkillList == needSkillNum then
            (self._toggle):SetInteractable(false)
          else
            ;
            (self._toggle):SetInteractable(true)
          end
        end
      end
    end
  end
end

NewCharSkillChangeCell.OnValueChanged = function(self)
  -- function num : 0_5
  (self._delegate):OnSkillCheck((self._cellData).skillItemId, (self._toggle):GetIsOnType())
end

return NewCharSkillChangeCell

