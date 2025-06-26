-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/settingcommunitycell4.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SettingCommunityCell4 = class("SettingCommunityCell4", Dialog)
SettingCommunityCell4.AssetBundleName = "ui/layouts.setting"
SettingCommunityCell4.AssetName = "SettingCommunityCell4"
SettingCommunityCell4.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SettingCommunityCell4
  ((SettingCommunityCell4.super).Ctor)(self, ...)
end

SettingCommunityCell4.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("Btn")
  ;
  (self._btn):Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

SettingCommunityCell4.OnDestroy = function(self, ...)
  -- function num : 0_2
end

SettingCommunityCell4.RefreshCell = function(self)
  -- function num : 0_3
end

SettingCommunityCell4.OnBtnClick = function(self)
  -- function num : 0_4
  (self._delegate):OnCell4BtnClick()
end

return SettingCommunityCell4

