-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/debuglog/debuglogdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DebugLogDialog = class("DebugLogDialog", Dialog)
DebugLogDialog.AssetBundleName = "ui/layouts"
DebugLogDialog.AssetName = "DebugLog"
DebugLogDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DebugLogDialog
  ((DebugLogDialog.super).Ctor)(self, ...)
  self._groupName = "Message"
end

DebugLogDialog.OnCreate = function(self)
  -- function num : 0_1
  self._logText = self:GetChild("Text")
  self._message = ""
end

DebugLogDialog.OnDestroy = function(self)
  -- function num : 0_2
end

DebugLogDialog.SetData = function(self, messsageStr)
  -- function num : 0_3
  (self._logText):SetText(messsageStr)
end

DebugLogDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  return DataCommon.BackPressed_SkipResponse
end

return DebugLogDialog

