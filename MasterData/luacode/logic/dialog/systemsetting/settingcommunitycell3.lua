-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/settingcommunitycell3.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SettingCommunityCell3 = class("SettingCommunityCell3", Dialog)
SettingCommunityCell3.AssetBundleName = "ui/layouts.setting"
SettingCommunityCell3.AssetName = "SettingCommunityCell3"
SettingCommunityCell3.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SettingCommunityCell3
  ((SettingCommunityCell3.super).Ctor)(self, ...)
end

SettingCommunityCell3.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("Btn")
  ;
  (self._btn):Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

SettingCommunityCell3.OnDestroy = function(self, ...)
  -- function num : 0_2
end

SettingCommunityCell3.RefreshCell = function(self)
  -- function num : 0_3
end

SettingCommunityCell3.OnBtnClick = function(self)
  -- function num : 0_4
  (self._delegate):OnCell3BtnClick()
end

return SettingCommunityCell3

