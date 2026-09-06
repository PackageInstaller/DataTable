local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local GrowGiftCell = class("GrowGiftCell", Dialog)
GrowGiftCell.AssetBundleName = "ui/layouts.welfare"
GrowGiftCell.AssetName = "GrowGiftCell"

function GrowGiftCell:Ctor(...)
  GrowGiftCell.super.Ctor(self, ...)
end

function GrowGiftCell:OnCreate()
  self._icon = self:GetChild("Panel/Item")
  self._lock = self:GetChild("Panel/Lock")
  self._getPanel = self:GetChild("Panel/GetBack")
  self._getPanel_btn = self:GetChild("Panel/GetBack/GetBtn")
  self._levelLimitTxt = self:GetChild("Panel/Text1")
  self._received = self:GetChild("Panel/Grey")
  self._numTxt = self:GetChild("Panel/Num/Num")
  self._icon:Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self._getPanel_btn:Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
end

function GrowGiftCell:OnDestroy()
end

function GrowGiftCell:RefreshCell(data)
  self._item = Item.Create(data.record.itemID[1])
  local imageRecord = self._item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._numTxt:SetText(data.record.ItemNum[1])
  if data.status == self._delegate.cellStatus.Lock then
    self._lock:SetActive(true)
    self._getPanel:SetActive(true)
    self._getPanel_btn:SetInteractable(false)
    self._received:SetActive(false)
  elseif data.status == self._delegate.cellStatus.CanNotReceive then
    self._lock:SetActive(false)
    self._getPanel:SetActive(true)
    self._getPanel_btn:SetInteractable(false)
    self._received:SetActive(false)
  elseif data.status == self._delegate.cellStatus.Available then
    self._lock:SetActive(false)
    self._getPanel:SetActive(true)
    self._getPanel_btn:SetInteractable(true)
    self._received:SetActive(false)
  elseif data.status == self._delegate.cellStatus.Received then
    self._lock:SetActive(false)
    self._getPanel:SetActive(false)
    self._received:SetActive(true)
  end
  self._levelLimitTxt:SetText(data.record.level)
end

function GrowGiftCell:OnGetBtnClick()
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.creceivelevelupreward")
  if protocol then
    protocol.id = self._cellData.record.id
    protocol:Send()
  end
end

function GrowGiftCell:OnCellClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return GrowGiftCell
