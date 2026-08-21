-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/newpassiveskilltipscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillShow_Soul = (BeanManager.GetTableByName)("skill.cskillshow_soul")
local CSKIllTable = (BeanManager.GetTableByName)("skill.cskill")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local NewPassiveSkillTipsCell = class("NewPassiveSkillTipsCell", Dialog)
NewPassiveSkillTipsCell.AssetBundleName = "ui/layouts.basecharacterinfo"
NewPassiveSkillTipsCell.AssetName = "TalentDetailCell"
NewPassiveSkillTipsCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewPassiveSkillTipsCell
  ((NewPassiveSkillTipsCell.super).Ctor)(self, ...)
end

NewPassiveSkillTipsCell.OnCreate = function(self)
  -- function num : 0_1
  self._skillNameBack = self:GetChild("NameBack")
  self._skillName = self:GetChild("Name")
  self._skillDescribe = self:GetChild("Txt2")
  self._unlockCondition = self:GetChild("Txt1")
  self._rootX = (self:GetRootWindow()):GetSize()
  self._skillNameRectX = (self._skillName):GetRectSize()
  self._skillNameBackX = (self._skillNameBack):GetSize()
  self._skillNameX = (self._skillName):GetSize()
  self._skillDescribeRectX = (self._skillDescribe):GetRectSize()
  self._unlockConditionX = (self._unlockCondition):GetPosition()
  self._desWidth = (self._skillDescribe):GetRectSize()
end

NewPassiveSkillTipsCell.OnDestroy = function(self)
  -- function num : 0_2
end

local SetCondition = function(self, total, index)
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P3

  if (total == 1 and index == 1) or total ~= 2 or total == 3 and index == 3 then
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1075)).msgTextID)
    ;
    (self._unlockCondition):SetText(str)
  else
    do
      if (total == 2 and index == 1) or total == 3 and index == 2 then
        local str = (TextManager.GetText)((CStringRes:GetRecorder(1073)).msgTextID)
        ;
        (self._unlockCondition):SetText(str)
      else
        do
          if total == 3 and index == 1 then
            local str = (TextManager.GetText)((CStringRes:GetRecorder(1072)).msgTextID)
            ;
            (self._unlockCondition):SetText(str)
          end
        end
      end
    end
  end
end

NewPassiveSkillTipsCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : SetCondition, CSKIllTable, CSkillShow_Soul, _ENV
  if not data.unlock then
    (self._unlockCondition):SetActive(true)
    SetCondition(self, data.count, data.index)
  else
    ;
    (self._unlockCondition):SetActive(false)
  end
  local cSkillTable = CSKIllTable:GetRecorder(data.id)
  local show = CSkillShow_Soul:GetRecorder(cSkillTable.id)
  if show then
    (self._skillName):SetText(tostring((TextManager.GetText)(show.nameTextID)))
    local size = (self._skillName):GetPreferredSize()
    if self._skillNameRectX < size then
      local delta = size - self._skillNameRectX
      ;
      (self._skillNameBack):SetSize(self._skillNameBackX, self._skillNameBackOX + delta, self._skillNameBackY, self._skillNameBackOY)
      ;
      (self._skillName):SetSize(self._skillNameX, size, self._skillNameY, self._skillNameOY)
      ;
      (self._unlockCondition):SetPosition(self._unlockConditionX, self._unlockConditionOX + delta, self._unlockConditionY, self._unlockConditionOY)
    else
      do
        ;
        (self._skillNameBack):SetSize(self._skillNameBackX, self._skillNameBackOX, self._skillNameBackY, self._skillNameBackOY)
        ;
        (self._skillName):SetSize(self._skillNameX, self._skillNameOX, self._skillNameY, self._skillNameOY)
        ;
        (self._unlockCondition):SetPosition(self._unlockConditionX, self._unlockConditionOX, self._unlockConditionY, self._unlockConditionOY)
        ;
        (self._skillDescribe):SetText(tostring((TextManager.GetText)(show.exDiscribeTextID)))
        local _, height = (self._skillDescribe):GetPreferredSize()
        ;
        (self._skillDescribe):SetDeltaSize(self._desWidth, height)
        if self._skillDescribeRectY < height then
          local delta = height - self._skillDescribeRectY
          ;
          (self:GetRootWindow()):SetSize(self._rootX, self._rootOX, self._rootY, self._rootOY + delta)
        else
          do
            do
              ;
              (self:GetRootWindow()):SetSize(self._rootX, self._rootOX, self._rootY, self._rootOY)
              LogErrorFormat("NewPassiveSkillTipsCell", "skill id %s in cskill has no corresponding record in cskillshow_soul", cSkillTable.id)
            end
          end
        end
      end
    end
  end
end

return NewPassiveSkillTipsCell

