local IndefiniteDaysSignTabHelper = require("logic.dialog.welfare.indefinitedaysignactivity.indefinitedayssigntabhelper")
local FourteenDaysSignTab = class("FourteenDaysSignTab", Dialog)
FourteenDaysSignTab.AssetBundleName = "ui/layouts.welfare"
FourteenDaysSignTab.AssetName = "WelfareMain14Day"

function FourteenDaysSignTab:Ctor(...)
  FourteenDaysSignTab.super.Ctor(self, ...)
end

function FourteenDaysSignTab:OnCreate()
  self._rootElement = self:GetRootWindow()
  self._indefiniteDaysSignTabHelper = IndefiniteDaysSignTabHelper.Create(self, self._rootElement, 5, true)
  self._downArrow = self:GetChild("Image")
  self._downArrow:Subscribe_PointerClickEvent(self.OnDownArrowClick, self)
end

function FourteenDaysSignTab:OnDestroy()
  if self._indefiniteDaysSignTabHelper then
    self._indefiniteDaysSignTabHelper:OnDestroy()
  end
end

function FourteenDaysSignTab:RefreshTabCell(activityId, refresh, refreshByProtocol)
  if self._indefiniteDaysSignTabHelper then
    self._indefiniteDaysSignTabHelper:RefreshTabCell(self._delegate, activityId, refresh, refreshByProtocol)
  end
end

function FourteenDaysSignTab:CellAtIndex(frame, index)
  if self._indefiniteDaysSignTabHelper._totalCellShow then
    local extraData = string.split(self._indefiniteDaysSignTabHelper._totalCellShow.reward[index], ";")
    local iconKind = tonumber(extraData[2])
    if iconKind == -1 then
      return "welfare.indefinitedaysignactivity.fourteendayssigncell"
    else
      return "welfare.indefinitedaysignactivity.fourteendayssigncell2"
    end
  end
  return "welfare.indefinitedaysignactivity.fourteendayssigncell"
end

function FourteenDaysSignTab:OnCurPosChange(frame, proportion)
  if proportion <= 0.5 then
    self._downArrow:SetActive(true)
  else
    self._downArrow:SetActive(false)
  end
end

function FourteenDaysSignTab:OnDownArrowClick()
  self._indefiniteDaysSignTabHelper._cellFrame:MoveToBottom()
  self._downArrow:SetActive(false)
end

return FourteenDaysSignTab
