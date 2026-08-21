-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/collaborativesskillbeancell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CollaborativesSkillBeanCell = class("CollaborativesSkillBeanCell", Dialog)
CollaborativesSkillBeanCell.AssetBundleName = "ui/layouts.battle"
CollaborativesSkillBeanCell.AssetName = "HPCellSkillMark"
CollaborativesSkillBeanCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CollaborativesSkillBeanCell
  ((CollaborativesSkillBeanCell.super).Ctor)(self, ...)
end

CollaborativesSkillBeanCell.OnCreate = function(self)
  -- function num : 0_1
  self._mark0 = self:GetChild("Mark0")
  self._mark1 = self:GetChild("Mark1")
  self._mark2 = self:GetChild("Mark2")
end

CollaborativesSkillBeanCell.OnDestroy = function(self)
  -- function num : 0_2
end

CollaborativesSkillBeanCell.RefreshCell = function(self, data)
  -- function num : 0_3
  if (self._delegate):IsFullBean() then
    (self._mark0):SetActive(false)
    ;
    (self._mark1):SetActive(false)
    ;
    (self._mark2):SetActive(true)
  else
    if (self._delegate):IsFilledBean((self._cellData).id) then
      (self._mark0):SetActive(false)
      ;
      (self._mark1):SetActive(true)
      ;
      (self._mark2):SetActive(false)
    else
      ;
      (self._mark0):SetActive(true)
      ;
      (self._mark1):SetActive(false)
      ;
      (self._mark2):SetActive(false)
    end
  end
end

return CollaborativesSkillBeanCell

