local IndefiniteDaysSignCellHelper = require("logic.dialog.welfare.indefinitedaysignactivity.indefinitedayssigncellhelper")
local FourteenDaysSignCell = class("FourteenDaysSignCell", Dialog)
FourteenDaysSignCell.AssetBundleName = "ui/layouts.welfare"
FourteenDaysSignCell.AssetName = "WelfareMain14DayCell"

function FourteenDaysSignCell:Ctor(...)
  FourteenDaysSignCell.super.Ctor(self, ...)
end

function FourteenDaysSignCell:OnCreate()
  self._rootElement = self:GetRootWindow()
  self._indefiniteDaysSignCellHelper = IndefiniteDaysSignCellHelper.Create(self._rootElement)
  self._imageput = self:GetChild("Imageput")
end

function FourteenDaysSignCell:OnDestroy()
  if self._indefiniteDaysSignCellHelper then
    self._indefiniteDaysSignCellHelper:OnDestroy()
  end
end

function FourteenDaysSignCell:RefreshCell(data)
  self._data = data
  if self._indefiniteDaysSignCellHelper then
    self._indefiniteDaysSignCellHelper:RefreshCell(self._delegate, data)
  end
end

function FourteenDaysSignCell:OnEvent(eventName, arg)
  if self._indefiniteDaysSignCellHelper then
    self._indefiniteDaysSignCellHelper:OnEvent(eventName, arg)
  end
end

return FourteenDaysSignCell
