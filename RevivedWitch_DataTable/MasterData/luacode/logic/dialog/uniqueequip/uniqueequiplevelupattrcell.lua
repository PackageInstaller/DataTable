-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/uniqueequip/uniqueequiplevelupattrcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local UniqueEquipLevelUpAttrCell = class("UniqueEquipLevelUpAttrCell", Dialog)
UniqueEquipLevelUpAttrCell.AssetBundleName = "ui/layouts.basecharacterinfo"
UniqueEquipLevelUpAttrCell.AssetName = "CharEquipQHPropCell"
UniqueEquipLevelUpAttrCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UniqueEquipLevelUpAttrCell
  ((UniqueEquipLevelUpAttrCell.super).Ctor)(self, ...)
end

UniqueEquipLevelUpAttrCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("LeftPanel/Txt")
  self._lastNum = self:GetChild("LeftPanel/Num")
  self._curNum = self:GetChild("RightPanel/Num")
end

UniqueEquipLevelUpAttrCell.OnDestroy = function(self)
  -- function num : 0_2
end

UniqueEquipLevelUpAttrCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAttrNameTable, _ENV
  local record = CAttrNameTable:GetRecorder(data.attrId)
  ;
  (self._name):SetText((TextManager.GetText)(record.classnameTextID))
  if record.isDecimal == 1 then
    local str = data.lastValue / 1000 * 100
    ;
    (self._lastNum):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1286, {str}))
    str = data.curValue / 1000 * 100
    ;
    (self._curNum):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1286, {str}))
  else
    do
      ;
      (self._lastNum):SetText(data.lastValue)
      ;
      (self._curNum):SetText(data.curValue)
    end
  end
end

return UniqueEquipLevelUpAttrCell

