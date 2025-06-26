-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tujian/tujiancharacterinfoprofilecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CRoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local TuJianCharacterInfoProfileCell = class("TuJianCharacterInfoProfileCell", Dialog)
TuJianCharacterInfoProfileCell.AssetBundleName = "ui/layouts.tujian"
TuJianCharacterInfoProfileCell.AssetName = "TuJianCharInfoProfile"
TuJianCharacterInfoProfileCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TuJianCharacterInfoProfileCell
  ((TuJianCharacterInfoProfileCell.super).Ctor)(self, ...)
end

TuJianCharacterInfoProfileCell.OnCreate = function(self)
  -- function num : 0_1
  self._height = self:GetChild("Height/Num")
  self._weight = self:GetChild("Weight/Num")
  self._blood = self:GetChild("Boold/Num")
  self._hobby = self:GetChild("Hobby/Num")
  self._nature = self:GetChild("Nature/Num")
  self._sex = self:GetChild("Sex/Num")
end

TuJianCharacterInfoProfileCell.OnDestroy = function(self)
  -- function num : 0_2
end

TuJianCharacterInfoProfileCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CRoleConfigTable, _ENV
  local roleConfig = CRoleConfigTable:GetRecorder(data.id)
  ;
  (self._height):SetText(tostring(roleConfig.height))
  ;
  (self._weight):SetText(tostring(roleConfig.weight))
  ;
  (self._blood):SetText(tostring(roleConfig.bloodtype))
  ;
  (self._hobby):SetText(tostring(roleConfig.hobby))
  ;
  (self._nature):SetText(tostring(roleConfig.attribute))
  ;
  (self._sex):SetText((TextManager.GetText)(roleConfig.sex))
end

return TuJianCharacterInfoProfileCell

