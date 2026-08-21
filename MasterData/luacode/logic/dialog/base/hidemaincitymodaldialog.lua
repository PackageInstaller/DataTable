-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/base/hidemaincitymodaldialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local HideMainCityModalDialog = class("HideMainCityModalDialog", Dialog)
HideMainCityModalDialog.AssetBundleName = "ui/layouts.basemainhud"
HideMainCityModalDialog.AssetName = "HideMainCityModel"
HideMainCityModalDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HideMainCityModalDialog
  ((HideMainCityModalDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

HideMainCityModalDialog.OnCreate = function(self)
  -- function num : 0_1
end

HideMainCityModalDialog.OnDestroy = function(self)
  -- function num : 0_2
end

HideMainCityModalDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if not (DialogManager.GetDialog)("newbattle.battlenewmaindialog") then
    return DataCommon.BackPressed_NotResponse
  else
    return DataCommon.BackPressed_SkipResponse
  end
end

return HideMainCityModalDialog

