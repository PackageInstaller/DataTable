-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equipchangebasepropcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CAttrEffectidNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local EquipChangeBasePropCell = class("EquipChangeBasePropCell", Dialog)
local ReplacePercent = function(str)
  -- function num : 0_0 , upvalues : _ENV
  str = (string.gsub)(str, "%%", "%%%%")
  return str
end

EquipChangeBasePropCell.AssetBundleName = "ui/layouts.equip"
EquipChangeBasePropCell.AssetName = "EquipPopPropCell"
EquipChangeBasePropCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : EquipChangeBasePropCell
  ((EquipChangeBasePropCell.super).Ctor)(self, ...)
end

EquipChangeBasePropCell.OnCreate = function(self)
  -- function num : 0_2
  self._image = self:GetChild("Image")
  self._name = self:GetChild("Name")
  self._num = self:GetChild("Num")
end

EquipChangeBasePropCell.OnDestroy = function(self)
  -- function num : 0_3
end

EquipChangeBasePropCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, CAttrEffectidNameTable, CStringRes
  local attrId = data.attrId - (math.fmod)(tonumber(data.attrId), 10)
  local attrRecord = (CAttrEffectidNameTable:GetRecorder(attrId))
  local attrValue = nil
  if attrRecord.isDecimal == 1 then
    attrValue = data.value / 1000 * 100
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1286)).msgTextID)
    attrValue = (string.gsub)(str, "%$parameter1%$", tostring(attrValue))
  else
    do
      attrValue = data.value
      ;
      (self._name):SetText((TextManager.GetText)(attrRecord.classnameTextID))
      ;
      (self._num):SetText((math.ceil)(attrValue))
    end
  end
end

return EquipChangeBasePropCell

