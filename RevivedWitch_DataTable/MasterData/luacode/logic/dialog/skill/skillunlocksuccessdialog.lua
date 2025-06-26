-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/skill/skillunlocksuccessdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Skill = require("logic.manager.experimental.types.skill")
local SkillUnLockSuccessDialog = class("SkillUnLockSuccessDialog", Dialog)
SkillUnLockSuccessDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
SkillUnLockSuccessDialog.AssetName = "SkillUnlockSuccess"
SkillUnLockSuccessDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SkillUnLockSuccessDialog
  ((SkillUnLockSuccessDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._skillDetails = {}
end

SkillUnLockSuccessDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : Skill, _ENV, TableFrame
  self._activePanel = self:GetChild("ActiveSkill")
  self._activePanel_skillName = self:GetChild("ActiveSkill/SkillName")
  self._activePanel_level = self:GetChild("ActiveSkill/Level/Txt3")
  self._activePanel_yellowCost = self:GetChild("ActiveSkill/Cost/Num1")
  self._activePanel_purpleCost = self:GetChild("ActiveSkill/Cost/Num2")
  self._activePanel_type = self:GetChild("ActiveSkill/Type/Num")
  self._activePanel_range = self:GetChild("ActiveSkill/Range/Num")
  self._activePanel_detail = self:GetChild("ActiveSkill/Frame/Detail")
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._skillDetails)[(Skill.Type).Active] = {}
  local map = (self._skillDetails)[(Skill.Type).Active]
  map.txt = self._activePanel_detail
  map.txtFrame = self:GetChild("ActiveSkill/Frame")
  map.skillCell = (DialogManager.CreateDialog)("skill.skillcell", (self:GetChild("ActiveSkill/Skill"))._uiObject)
  self._chargingPanel = self:GetChild("EnergySkill")
  self._chargingPanel_skillName = self:GetChild("EnergySkill/SkillName")
  self._chargingPanel_level = self:GetChild("EnergySkill/Level/Txt3")
  self._chargingPanel_markPanel = self:GetChild("EnergySkill/Cost/SkillMarkFrame")
  self._chargingPanel_markIBtn = self:GetChild("EnergySkill/Cost/Ibtn")
  self._chargingPanel_type = self:GetChild("EnergySkill/Type/Num")
  self._chargingPanel_range = self:GetChild("EnergySkill/Range/Num")
  self._chargingPanel_detail = self:GetChild("EnergySkill/Frame/Detail")
  -- DECOMPILER ERROR at PC92: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._skillDetails)[(Skill.Type).Charging] = {}
  local map = (self._skillDetails)[(Skill.Type).Charging]
  map.txt = self._chargingPanel_detail
  map.txtFrame = self:GetChild("EnergySkill/Frame")
  map.skillCell = (DialogManager.CreateDialog)("skill.skillcell", (self:GetChild("EnergySkill/Skill"))._uiObject)
  self._chargingPanel_markFrame = (TableFrame.Create)(self._chargingPanel_markPanel, self, false, false)
  ;
  (self._chargingPanel_markIBtn):Subscribe_PointerClickEvent(self.OnChargingIBtnClicked, self)
  self._passivePanel = self:GetChild("PassiveSkill")
  self._passivePanel_skillName = self:GetChild("PassiveSkill/SkillName")
  self._passivePanel_level = self:GetChild("PassiveSkill/Level/Txt3")
  self._passivePanel_type = self:GetChild("PassiveSkill/Type/Num")
  self._passivePanel_detail = self:GetChild("PassiveSkill/Frame/Detail")
  -- DECOMPILER ERROR at PC148: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._skillDetails)[(Skill.Type).Passive] = {}
  local map = (self._skillDetails)[(Skill.Type).Passive]
  map.txt = self._passivePanel_detail
  map.txtFrame = self:GetChild("PassiveSkill/Frame")
  map.skillCell = (DialogManager.CreateDialog)("skill.skillcell", (self:GetChild("PassiveSkill/Skill"))._uiObject)
  self._attrPanel = self:GetChild("PropSkill")
  self._attrPanel_detail = self:GetChild("PropSkill/Frame/Detail")
  -- DECOMPILER ERROR at PC180: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._skillDetails)[(Skill.Type).Attribute] = {}
  local map = (self._skillDetails)[(Skill.Type).Attribute]
  map.txt = self._attrPanel_detail
  map.txtFrame = self:GetChild("PropSkill/Frame")
  map.skillCell = (DialogManager.CreateDialog)("skill.skillcell", (self:GetChild("PropSkill/Skill"))._uiObject)
  for k,map in pairs(self._skillDetails) do
    map.width = (map.txt):GetDeltaSize()
    map.txtFrameWidth = (map.txtFrame):GetDeltaSize()
    map.txtFrameAnchoredx = (map.txtFrame):GetAnchoredPosition()
    ;
    (map.skillCell):HideFromCharacterSkillDialog()
  end
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

SkillUnLockSuccessDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._chargingPanel_markFrame):Destroy()
end

SkillUnLockSuccessDialog.SetData = function(self, skillId, skillItemId, roleId)
  -- function num : 0_3 , upvalues : Skill
  local skill = (Skill.Create)(skillId, skillItemId or true)
  local type = skill:GetType()
  local level = skill:GetSkillLevel()
  local name = skill:GetSkillName()
  local typeTxt = skill:GetTypeTxt()
  local detail = skill:GetDescribeTxt()
  if type == (Skill.Type).Active then
    (self._activePanel):SetActive(true)
    ;
    (self._chargingPanel):SetActive(false)
    ;
    (self._passivePanel):SetActive(false)
    ;
    (self._attrPanel):SetActive(false)
    ;
    (self._activePanel_skillName):SetText(name)
    ;
    (self._activePanel_level):SetText(level)
    ;
    (self._activePanel_yellowCost):SetText(skill:GetYellowCost())
    ;
    (self._activePanel_purpleCost):SetText(skill:GetPurpleCost())
    ;
    (self._activePanel_type):SetText(typeTxt)
    ;
    (self._activePanel_range):SetText(skill:GetRangeTxt())
    local maxlevel = skill:GetSkillMaxLevel()
  else
    do
      if maxlevel <= level then
        if type == (Skill.Type).Charging then
          (self._activePanel):SetActive(false)
          ;
          (self._chargingPanel):SetActive(true)
          ;
          (self._passivePanel):SetActive(false)
          ;
          (self._attrPanel):SetActive(false)
          ;
          (self._chargingPanel_skillName):SetText(name)
          ;
          (self._chargingPanel_level):SetText(level)
          ;
          (self._chargingPanel_type):SetText(typeTxt)
          ;
          (self._chargingPanel_range):SetText(skill:GetRangeTxt())
          self.chargingMarkNum = skill:GetChargingNumByRoleId(roleId)
          ;
          (self._chargingPanel_markFrame):ReloadAllCell()
          local maxlevel = skill:GetSkillMaxLevel()
        else
          do
            if maxlevel <= level then
              if type == (Skill.Type).Passive then
                (self._activePanel):SetActive(false)
                ;
                (self._chargingPanel):SetActive(false)
                ;
                (self._passivePanel):SetActive(true)
                ;
                (self._attrPanel):SetActive(false)
                ;
                (self._passivePanel_skillName):SetText(name)
                ;
                (self._passivePanel_level):SetText(level)
                ;
                (self._passivePanel_type):SetText(typeTxt)
                local maxlevel = skill:GetSkillMaxLevel()
              else
                do
                  if maxlevel <= level and type == (Skill.Type).Attribute then
                    (self._activePanel):SetActive(false)
                    ;
                    (self._chargingPanel):SetActive(false)
                    ;
                    (self._passivePanel):SetActive(false)
                    ;
                    (self._attrPanel):SetActive(true)
                  end
                  local map = (self._skillDetails)[type]
                  if map then
                    (map.txt):SetText(detail)
                    local _, textHeight = (map.txt):GetPreferredSize()
                    if map.height < textHeight then
                      (map.txtFrame):SetDeltaSize(map.txtFrameWidth, map.txtFrameHeight + (textHeight - map.height))
                      ;
                      (map.txtFrame):SetAnchoredPosition(map.txtFrameAnchoredx, map.txtFrameAnchoredy - (textHeight - map.height) / 2)
                      ;
                      (map.txt):SetDeltaSize(map.width, textHeight)
                    end
                    ;
                    (map.skillCell):Init(skill)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

SkillUnLockSuccessDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_4
  if frame == self._chargingPanel_markFrame then
    return self.chargingMarkNum
  end
end

SkillUnLockSuccessDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if frame == self._chargingPanel_markFrame then
    return "character.chargingmarkcell"
  end
end

SkillUnLockSuccessDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if frame == self._chargingPanel_markFrame then
    return true
  end
end

SkillUnLockSuccessDialog.OnChargingIBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("skill.chargingskillusageruledialog")
end

SkillUnLockSuccessDialog.OnBackBtnClicked = function(self, args)
  -- function num : 0_8
  self:Destroy()
end

return SkillUnLockSuccessDialog

