-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/settingcommunitycell2.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SettingCommunityCell2 = class("SettingCommunityCell2", Dialog)
SettingCommunityCell2.AssetBundleName = "ui/layouts.setting"
SettingCommunityCell2.AssetName = "SettingCommunityCell2"
SettingCommunityCell2.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SettingCommunityCell2
  ((SettingCommunityCell2.super).Ctor)(self, ...)
end

SettingCommunityCell2.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("Btn")
  ;
  (self._btn):Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

SettingCommunityCell2.OnDestroy = function(self, ...)
  -- function num : 0_2
end

SettingCommunityCell2.RefreshCell = function(self)
  -- function num : 0_3
end

SettingCommunityCell2.OnBtnClick = function(self)
  -- function num : 0_4
  (self._delegate):OnCell2BtnClick()
end

return SettingCommunityCell2

