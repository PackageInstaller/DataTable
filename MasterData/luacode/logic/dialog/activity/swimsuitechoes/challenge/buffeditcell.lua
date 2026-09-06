local CentryConfig = BeanManager.GetTableByName("dungeonselect.centryconfig")
local BuffEditCell = class("BuffEditCell", Dialog)
BuffEditCell.AssetBundleName = "ui/layouts.activitysummer2"
BuffEditCell.AssetName = "ActivitySummer2ChallengeBuffCell"

function BuffEditCell:Ctor(...)
  BuffEditCell.super.Ctor(self, ...)
end

function BuffEditCell:OnCreate()
  self._unlockTxt = self:GetChild("Lock/Black/Txt")
  self._nomalbackImg = self:GetChild("Normal/Back/BackImg2")
  self._backImg2 = self:GetChild("Normal/Back/BackImg")
  self._lockNode = self:GetChild("Lock")
  self._buffTxt = self:GetChild("Normal/Text/BuffTxt")
  self._select = self:GetChild("Select")
  self._nomalbackImg:Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function BuffEditCell:OnDestroy()
end

function BuffEditCell:RefreshCell(data)
  self._buffTxt:SetText(TextManager.GetText(data.cfg.nameID))
  self._lockNode:SetActive(not data.isUnlock)
  self._unlockTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2179, {
    data.cfg.unlockCondition
  }))
  self._backImg2:SetActive(data.state ~= -1)
  self._select:SetActive(data.state == 1)
end

function BuffEditCell:OnCellClicked()
  if self._cellData.isUnlock then
    self._delegate:OnCellClicked(self._cellData.id)
  end
end

function BuffEditCell:OnEvent(eventName, args)
  if eventName == "CancelSelection" then
    if args.entrytype == self._cellData.cfg.typeID then
      self._backImg2:SetActive(true)
      self._select:SetActive(false)
    end
  elseif eventName == "Selection" and args.entrytype == self._cellData.cfg.typeID then
    if tonumber(args.id) == tonumber(self._cellData.cfg.id) then
      self._select:SetActive(true)
      self._backImg2:SetActive(true)
    else
      self._select:SetActive(false)
      self._backImg2:SetActive(false)
    end
  end
end

return BuffEditCell
