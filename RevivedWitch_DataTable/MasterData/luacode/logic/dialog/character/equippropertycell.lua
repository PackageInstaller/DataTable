-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/equippropertycell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local EquipPropertyCell = class("EquipPropertyCell", Dialog)
EquipPropertyCell.AssetBundleName = "ui/layouts.basecharacterinfo"
EquipPropertyCell.AssetName = "BaseCharacterInfoEquipPropertyCell"
EquipPropertyCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipPropertyCell
  ((EquipPropertyCell.super).Ctor)(self, ...)
end

EquipPropertyCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("PropertyName")
  self._num = self:GetChild("PropertyNum")
end

EquipPropertyCell.RefreshCell = function(self, data)
  -- function num : 0_2 , upvalues : CAttrNameTable, _ENV
  local record = CAttrNameTable:GetRecorder(data.attrKey)
  ;
  (self._name):SetText((TextManager.GetText)(record.classnameTextID))
  if record.isDecimal == 1 then
    (self._num):SetText(tostring(data.value / 10) .. "%")
  else
    ;
    (self._num):SetText(data.value)
  end
end

return EquipPropertyCell

