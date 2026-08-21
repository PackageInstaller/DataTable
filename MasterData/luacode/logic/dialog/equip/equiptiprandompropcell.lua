-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equiptiprandompropcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CAttrEffectidNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CRandomAbilityTable = (BeanManager.GetTableByName)("equip.crandomability")
local Cequipbreakcfg = (BeanManager.GetTableByName)("equip.cequipbreakcfg")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CWordColor = (BeanManager.GetTableByName)("message.cwordcolor")
local EquipTipRandomPropCell = class("EquipTipRandomPropCell", Dialog)
local ReplacePercent = function(str)
  -- function num : 0_0 , upvalues : _ENV
  str = (string.gsub)(str, "%%", "%%%%")
  return str
end

EquipTipRandomPropCell.AssetBundleName = "ui/layouts.equip"
EquipTipRandomPropCell.AssetName = "EquipTipsNewCell1"
EquipTipRandomPropCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : EquipTipRandomPropCell
  ((EquipTipRandomPropCell.super).Ctor)(self, ...)
end

EquipTipRandomPropCell.OnCreate = function(self)
  -- function num : 0_2
  self._image = self:GetChild("Image")
  self._name = self:GetChild("Txt")
  self._lock = self:GetChild("Lock")
  self._num = self:GetChild("Num")
end

EquipTipRandomPropCell.OnDestroy = function(self)
  -- function num : 0_3
end

EquipTipRandomPropCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, CAttrEffectidNameTable, CImagePathTable, CWordColor, CStringRes, ReplacePercent
  local attrId = data.attrId - (math.fmod)(tonumber(data.attrId), 10)
  local attrRecord = (CAttrEffectidNameTable:GetRecorder(attrId))
  -- DECOMPILER ERROR at PC13: Overwrote pending register: R4 in 'AssignReg'

  local imageRecord, color = .end, nil
  if data.kind == 3 then
    if not CImagePathTable:GetRecorder(12124) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    color = (CWordColor:GetRecorder(33)).wordcolor
  else
    if not CImagePathTable:GetRecorder(11469) then
      imageRecord = DataCommon.DefaultImageAsset
    end
    color = (CWordColor:GetRecorder(32)).wordcolor
  end
  ;
  (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local attrValue = nil
  if attrRecord.isDecimal == 1 then
    attrValue = data.value / 1000 * 100
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1286)).msgTextID)
    attrValue = (string.gsub)(str, "%$parameter1%$", tostring(attrValue))
  else
    do
      attrValue = data.value
      local numText = (TextManager.GetText)((CStringRes:GetRecorder(1079)).msgTextID)
      numText = (string.gsub)(numText, "%$parameter1%$", ReplacePercent(attrValue))
      ;
      (self._name):SetText("<color=#" .. color .. ">" .. (TextManager.GetText)(attrRecord.classnameTextID) .. "</color>")
      ;
      (self._num):SetText("<color=#" .. color .. ">" .. numText .. "</color>")
    end
  end
end

return EquipTipRandomPropCell

