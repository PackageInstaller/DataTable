local CentryConfig = BeanManager.GetTableByName("dungeonselect.centryconfig")
local UndecidedRoadEditCell = class("UndecidedRoadEditCell", Dialog)
UndecidedRoadEditCell.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadEditCell.AssetName = "ActivityRoadEditCell"

function UndecidedRoadEditCell:Ctor(...)
  UndecidedRoadEditCell.super.Ctor(self, ...)
end

function UndecidedRoadEditCell:OnCreate()
  self._btn = self:GetChild("Btn")
  self._txt1 = self:GetChild("Btn/Txt1")
  self._txt2 = self:GetChild("Btn/Txt2")
  self._noBtn = self:GetChild("Btn/No")
  self._yesBtn = self:GetChild("Btn/Yes")
  self._btn:Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function UndecidedRoadEditCell:OnDestroy()
end

function UndecidedRoadEditCell:RefreshCell(data)
  self._btn:SetSelected(data.state == 1)
  self._yesBtn:SetActive(data.state == 1)
  self._noBtn:SetActive(data.state == 2)
  self._txt1:SetText(TextManager.GetText(data.textID))
  self._txt2:SetText(data.bonusPoints)
end

function UndecidedRoadEditCell:OnCellClicked()
  self._delegate:OnVerticalCellClicked(self._cellData.id)
end

function UndecidedRoadEditCell:OnEvent(eventName, args)
  if eventName == "CancelSelection" then
    if args.entrytype == self._cellData.entrytype then
      self._btn:SetSelected(false)
      self._yesBtn:SetActive(false)
      self._noBtn:SetActive(false)
    end
  elseif eventName == "Selection" and args.entrytype == self._cellData.entrytype then
    if tonumber(args.id) == tonumber(self._cellData.entryId) then
      self._btn:SetSelected(true)
      self._yesBtn:SetActive(true)
      self._noBtn:SetActive(false)
    else
      self._btn:SetSelected(false)
      self._yesBtn:SetActive(false)
      self._noBtn:SetActive(true)
    end
  end
end

return UndecidedRoadEditCell
