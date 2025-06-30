-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/debug/frameratedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FrameRateDialog = class("FrameRateDialog", Dialog)
FrameRateDialog.AssetBundleName = "ui/layouts"
FrameRateDialog.AssetName = "FrameRate"
FrameRateDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FrameRateDialog
  ((FrameRateDialog.super).Ctor)(self, ...)
  self._groupName = "ClickEffect"
end

FrameRateDialog.OnCreate = function(self)
  -- function num : 0_1
end

FrameRateDialog.OnDestroy = function(self)
  -- function num : 0_2
end

FrameRateDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return DataCommon.BackPressed_SkipResponse
end

return FrameRateDialog

