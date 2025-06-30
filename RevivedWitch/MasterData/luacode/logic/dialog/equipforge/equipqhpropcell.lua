-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipqhpropcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local EquipQHPropCell = class("EquipQHPropCell", Dialog)
EquipQHPropCell.AssetBundleName = "ui/layouts.equip"
EquipQHPropCell.AssetName = "EquipQHProp"
EquipQHPropCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipQHPropCell
  ((EquipQHPropCell.super).Ctor)(self, ...)
end

EquipQHPropCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("Back")
  self._name = self:GetChild("Txt1")
  self._num = self:GetChild("Num")
  self._addNum = self:GetChild("Txt2")
  ;
  (self._addNum):SetText("")
end

EquipQHPropCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipQHPropCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAttrNameTable, _ENV, CStringRes
  if data.noData then
    (self._name):SetActive(false)
    ;
    (self._num):SetActive(false)
    ;
    (self._back):SetActive(false)
    return 
  else
    ;
    (self._name):SetActive(true)
    ;
    (self._num):SetActive(true)
    ;
    (self._back):SetActive(true)
  end
  local record = CAttrNameTable:GetRecorder(data.attrId)
  ;
  (self._name):SetText((TextManager.GetText)(record.classnameTextID))
  if data.addValue and data.addValue > 0 then
    local addValue = data.addValue * (self._delegate).addLv
    addValue = (math.ceil)(addValue)
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1079)).msgTextID)
    str = (string.gsub)(str, "%$parameter1%$", tostring(addValue))
    ;
    (self._addNum):SetText(str)
  else
    do
      ;
      (self._addNum):SetText("")
      local num = data.value
      ;
      (self._num):SetText((math.ceil)(num))
    end
  end
end

return EquipQHPropCell

