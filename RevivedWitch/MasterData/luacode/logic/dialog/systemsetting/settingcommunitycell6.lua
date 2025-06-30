-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/settingcommunitycell6.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SettingCommunityCell6 = class("SettingCommunityCell6", Dialog)
SettingCommunityCell6.AssetBundleName = "ui/layouts.setting"
SettingCommunityCell6.AssetName = "SettingCommunityCell6"
SettingCommunityCell6.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SettingCommunityCell6
  ((SettingCommunityCell6.super).Ctor)(self, ...)
end

SettingCommunityCell6.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("Btn")
  ;
  (self._btn):Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

SettingCommunityCell6.OnDestroy = function(self, ...)
  -- function num : 0_2
end

SettingCommunityCell6.RefreshCell = function(self)
  -- function num : 0_3
end

SettingCommunityCell6.OnBtnClick = function(self)
  -- function num : 0_4
  (self._delegate):OnCell6BtnClick()
end

return SettingCommunityCell6

