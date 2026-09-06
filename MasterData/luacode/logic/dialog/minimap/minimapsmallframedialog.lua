local MiniMapSmallFrameDialog = class("MiniMapSmallFrameDialog", Dialog)
MiniMapSmallFrameDialog.AssetBundleName = "ui/layouts.minimap"
MiniMapSmallFrameDialog.AssetName = "DungeonMapArea"

function MiniMapSmallFrameDialog:Ctor(...)
  MiniMapSmallFrameDialog.super.Ctor(self, ...)
  self._groupName = "Default"
  self._frame = nil
  self._origin = nil
end

function MiniMapSmallFrameDialog:OnCreate()
  self._origin = self:GetChild("MiniMap")
  self._frame = self:GetRootWindow()
end

function MiniMapSmallFrameDialog:GetOrigin()
  return self._origin
end

return MiniMapSmallFrameDialog
