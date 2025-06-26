-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipqhtips.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EquipQHTips = class("EquipQHTips", Dialog)
EquipQHTips.AssetBundleName = "ui/layouts.equip"
EquipQHTips.AssetName = "EquipQHTips"
EquipQHTips.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipQHTips
  ((EquipQHTips.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

EquipQHTips.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("BackImage/Txt")
  self._confirmBtn = self:GetChild("BackImage/ConfirmButton")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

EquipQHTips.Init = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._text):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1517))
end

EquipQHTips.OnBackBtnClicked = function(self)
  -- function num : 0_3
  self:Destroy()
end

return EquipQHTips

