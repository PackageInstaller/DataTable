local State = {
  Unlock = 1,
  PreconditionsNotMet = 2,
  Lock = 3
}
local SwimSuitBattleBtnCell = class("SwimSuitBattleBtnCell", Dialog)
SwimSuitBattleBtnCell.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitBattleBtnCell.AssetName = "ActivitySummebattlebtn"

function SwimSuitBattleBtnCell:Ctor(...)
  SwimSuitBattleBtnCell.super.Ctor(self, ...)
end

function SwimSuitBattleBtnCell:OnCreate()
  self._text = self:GetChild("_Text")
  self._num = self:GetChild("Num")
  self._image = self:GetChild("Image")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function SwimSuitBattleBtnCell:OnDestroy()
end

function SwimSuitBattleBtnCell:RefreshCell(data)
  self._num:SetText(data.index)
  self._image:SetActive(data.state == State.Lock)
end

function SwimSuitBattleBtnCell:OnCellClicked()
  self._delegate:OnButtonGroupClick(self._cellData.index)
end

function SwimSuitBattleBtnCell:OnEvent(eventName, arg)
  if eventName == "ChangedSelected" then
    self:GetRootWindow():SetSelected(self._cellData.index == arg)
  end
end

return SwimSuitBattleBtnCell
