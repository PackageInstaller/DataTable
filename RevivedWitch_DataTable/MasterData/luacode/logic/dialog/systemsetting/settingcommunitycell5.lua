-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/settingcommunitycell5.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SettingCommunityCell5 = class("SettingCommunityCell5", Dialog)
SettingCommunityCell5.AssetBundleName = "ui/layouts.setting"
SettingCommunityCell5.AssetName = "SettingCommunityCell5"
SettingCommunityCell5.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SettingCommunityCell5
  ((SettingCommunityCell5.super).Ctor)(self, ...)
end

SettingCommunityCell5.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("Btn")
  ;
  (self._btn):Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

SettingCommunityCell5.OnDestroy = function(self, ...)
  -- function num : 0_2
end

SettingCommunityCell5.RefreshCell = function(self)
  -- function num : 0_3
end

SettingCommunityCell5.OnBtnClick = function(self)
  -- function num : 0_4
  (self._delegate):OnCell5BtnClick()
end

return SettingCommunityCell5

