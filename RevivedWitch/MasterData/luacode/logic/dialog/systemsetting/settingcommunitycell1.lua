-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/settingcommunitycell1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SettingCommunityCell1 = class("SettingCommunityCell1", Dialog)
SettingCommunityCell1.AssetBundleName = "ui/layouts.setting"
SettingCommunityCell1.AssetName = "SettingCommunityCell1"
SettingCommunityCell1.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SettingCommunityCell1
  ((SettingCommunityCell1.super).Ctor)(self, ...)
end

SettingCommunityCell1.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("Btn")
  ;
  (self._btn):Subscribe_PointerClickEvent(self.OnBtnClick, self)
end

SettingCommunityCell1.OnDestroy = function(self, ...)
  -- function num : 0_2
end

SettingCommunityCell1.RefreshCell = function(self)
  -- function num : 0_3
end

SettingCommunityCell1.OnBtnClick = function(self)
  -- function num : 0_4
  (self._delegate):OnCell1BtnClick()
end

return SettingCommunityCell1

