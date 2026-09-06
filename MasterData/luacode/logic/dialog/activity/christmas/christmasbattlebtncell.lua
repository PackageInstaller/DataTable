local State = {
  Unlock = 1,
  PreconditionsNotMet = 2,
  Lock = 3
}
local ChristmasBattleBtnCell = class("ChristmasBattleBtnCell", Dialog)
ChristmasBattleBtnCell.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasBattleBtnCell.AssetName = "ActivityChristmasbattlebtn"

function ChristmasBattleBtnCell:Ctor(...)
  ChristmasBattleBtnCell.super.Ctor(self, ...)
end

function ChristmasBattleBtnCell:OnCreate()
  self._text = self:GetChild("_Text")
  self._num = self:GetChild("Num")
  self._image = self:GetChild("Image")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function ChristmasBattleBtnCell:OnDestroy()
end

function ChristmasBattleBtnCell:RefreshCell(data)
  self._num:SetText(data.index)
  self._image:SetActive(data.state == State.Lock)
end

function ChristmasBattleBtnCell:OnCellClicked()
  self._delegate:OnButtonGroupClick(self._cellData.index)
end

function ChristmasBattleBtnCell:OnEvent(eventName, arg)
  if eventName == "ChangedSelected" then
    self:GetRootWindow():SetSelected(self._cellData.index == arg)
  end
end

return ChristmasBattleBtnCell
