-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/magictree/chooseroleskillcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ChooseRoleSkillCell = class("ChooseRoleSkillCell", Dialog)
ChooseRoleSkillCell.AssetBundleName = "ui/layouts.yard"
ChooseRoleSkillCell.AssetName = "YardSendSkillCell"
ChooseRoleSkillCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChooseRoleSkillCell
  ((ChooseRoleSkillCell.super).Ctor)(self, ...)
end

ChooseRoleSkillCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Back")
  self._name = self:GetChild("Title")
  self._txt = self:GetChild("Txt")
end

ChooseRoleSkillCell.OnDestroy = function(self)
  -- function num : 0_2
end

ChooseRoleSkillCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable
  (self._name):SetText(data.name)
  ;
  (self._txt):SetText(data.desc)
  local imgRecord = CImagePathTable:GetRecorder(data.image)
  ;
  (self._icon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
end

return ChooseRoleSkillCell

