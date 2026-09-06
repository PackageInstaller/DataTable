local State = {
  Unlock = 1,
  PreconditionsNotMet = 2,
  Lock = 3
}
local LoverBattleBtnCell = class("LoverBattleBtnCell", Dialog)
LoverBattleBtnCell.AssetBundleName = "ui/layouts.activityvalentines"
LoverBattleBtnCell.AssetName = "ActivityValentinesbattlebtn"

function LoverBattleBtnCell:Ctor(...)
  LoverBattleBtnCell.super.Ctor(self, ...)
end

function LoverBattleBtnCell:OnCreate()
  self._text = self:GetChild("_Text")
  self._num = self:GetChild("Num")
  self._image = self:GetChild("Image")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function LoverBattleBtnCell:OnDestroy()
end

function LoverBattleBtnCell:RefreshCell(data)
  self._num:SetText(data.index)
  self._image:SetActive(data.state == State.Lock)
end

function LoverBattleBtnCell:OnCellClicked()
  self._delegate:OnButtonGroupClick(self._cellData.index)
end

function LoverBattleBtnCell:OnEvent(eventName, arg)
  if eventName == "ChangedSelected" then
    self:GetRootWindow():SetSelected(self._cellData.index == arg)
  end
end

return LoverBattleBtnCell
