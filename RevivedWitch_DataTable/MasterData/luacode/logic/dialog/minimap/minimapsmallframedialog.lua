-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/minimap/minimapsmallframedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MiniMapSmallFrameDialog = class("MiniMapSmallFrameDialog", Dialog)
MiniMapSmallFrameDialog.AssetBundleName = "ui/layouts.minimap"
MiniMapSmallFrameDialog.AssetName = "DungeonMapArea"
MiniMapSmallFrameDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MiniMapSmallFrameDialog
  ((MiniMapSmallFrameDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
  self._frame = nil
  self._origin = nil
end

MiniMapSmallFrameDialog.OnCreate = function(self)
  -- function num : 0_1
  self._origin = self:GetChild("MiniMap")
  self._frame = self:GetRootWindow()
end

MiniMapSmallFrameDialog.GetOrigin = function(self)
  -- function num : 0_2
  return self._origin
end

return MiniMapSmallFrameDialog

