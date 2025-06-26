-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/debug/debugcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AssetBundleHelper = ((CS.PixelNeko).Common).AssetBundleHelper
local DebugCell = class("DebugCell", Dialog)
DebugCell.AssetBundleName = "ui/layouts"
DebugCell.AssetName = "DebugTxtCell"
DebugCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DebugCell
  ((DebugCell.super).Ctor)(self, ...)
end

DebugCell.OnCreate = function(self)
  -- function num : 0_1
  self._num = self:GetChild("Num")
  self._text = self:GetChild("Text2")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

DebugCell.OnDestroy = function(self)
  -- function num : 0_2
end

DebugCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._num):SetText(tostring(data.RefCount))
  ;
  (self._text):SetText(tostring(data.AssetBundleName))
  self._abName = data.AssetBundleName
  self._handlers = data.Handers
  self._assestNames = data.AssetNames
end

DebugCell.OnCellClick = function(self)
  -- function num : 0_4 , upvalues : _ENV, AssetBundleHelper
  if not self._handlers then
    return 
  end
  for index,handler in pairs(self._handlers) do
    local path = (AssetBundleHelper.GetObjectPathUseAB)(handler, self._abName, (self._assestNames)[index])
    if path == "" then
      LogError(" abuse ", " AssetBundleName:" .. self._abName .. " AssetNames:" .. (self._assestNames)[index] .. " is not use in ui")
    else
      LogError(" abuse ", " AssetBundleName:" .. self._abName .. " AssetNames:" .. (self._assestNames)[index] .. " path:" .. path)
    end
  end
end

return DebugCell

