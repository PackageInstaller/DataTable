local AssetBundleHelper = CS.PixelNeko.Common.AssetBundleHelper
local DebugCell = class("DebugCell", Dialog)
DebugCell.AssetBundleName = "ui/layouts"
DebugCell.AssetName = "DebugTxtCell"

function DebugCell:Ctor(...)
  DebugCell.super.Ctor(self, ...)
end

function DebugCell:OnCreate()
  self._num = self:GetChild("Num")
  self._text = self:GetChild("Text2")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function DebugCell:OnDestroy()
end

function DebugCell:RefreshCell(data)
  self._num:SetText(tostring(data.RefCount))
  self._text:SetText(tostring(data.AssetBundleName))
  self._abName = data.AssetBundleName
  self._handlers = data.Handers
  self._assestNames = data.AssetNames
end

function DebugCell:OnCellClick()
  if not self._handlers then
    return
  end
  for index, handler in pairs(self._handlers) do
    local path = AssetBundleHelper.GetObjectPathUseAB(handler, self._abName, self._assestNames[index])
    if path == "" then
      LogError(" abuse ", " AssetBundleName:" .. self._abName .. " AssetNames:" .. self._assestNames[index] .. " is not use in ui")
    else
      LogError(" abuse ", " AssetBundleName:" .. self._abName .. " AssetNames:" .. self._assestNames[index] .. " path:" .. path)
    end
  end
end

return DebugCell
