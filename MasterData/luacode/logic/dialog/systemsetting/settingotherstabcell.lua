local TableFrame = require("framework.ui.frame.table.tableframe")
local SettingOthersTabCell = class("SettingOthersTabCell", Dialog)
SettingOthersTabCell.AssetBundleName = "ui/layouts.setting"
SettingOthersTabCell.AssetName = "SettingOthers"

function SettingOthersTabCell:Ctor(...)
  SettingOthersTabCell.super.Ctor(self, ...)
end

function SettingOthersTabCell:OnCreate()
  self._scrollbar = self:GetChild("Frame/Scrollbar")
  self._panel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self:RefreshTabCell()
end

function SettingOthersTabCell:OnDestroy()
  self._frame:Destroy()
end

function SettingOthersTabCell:RefreshTabCell()
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function SettingOthersTabCell:OnCurPosChange(frame, proportion)
  local width, height = self._panel:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollbar:SetScrollSize(height / total)
    self._scrollbar:SetScrollValue(1 - proportion)
  else
    self._scrollbar:SetScrollSize(1)
    self._scrollbar:SetScrollValue(proportion)
  end
end

function SettingOthersTabCell:NumberOfCell(frame)
  return 2
end

function SettingOthersTabCell:CellAtIndex(frame, index)
  if index == 1 then
    return "systemsetting.identitycell"
  elseif index == 2 then
    return "systemsetting.messagecell"
  end
end

function SettingOthersTabCell:DataAtIndex(frame, index)
end

return SettingOthersTabCell
