local CardPool = BeanManager.GetTableByName("item.ccardpool")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local PoolCell = class("PoolCell", Dialog)
PoolCell.AssetBundleName = "ui/layouts.gacha"
PoolCell.AssetName = "GachaPoolCell"

function PoolCell:Ctor(...)
  PoolCell.super.Ctor(self, ...)
  self._item = nil
end

function PoolCell:OnCreate()
  self._back = self:GetChild("Panel/Back")
  self._name = self:GetChild("Panel/Name")
  self._timeInfo = self:GetChild("Panel/TimeInfo")
  self._selected = self:GetChild("Panel/Select")
  self._selected:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnMouseClick, self)
end

function PoolCell:OnDestroy()
end

function PoolCell:RefreshCell(data)
  local record = CardPool:GetRecorder(data.id)
  self._name:SetText(TextManager.GetText(record.poolNameTextID))
  local image = ImageTable:GetRecorder(record.CellImgID) or DataCommon.DefaultImageAsset
  self._back:SetSprite(image.assetBundle, image.assetName)
  if record.isshowTimeShow < 1 then
    self._timeInfo:SetActive(false)
  elseif record.isshowTimeShow == 1 then
    self._timeInfo:SetActive(true)
    self._timeInfo:SetText(record.timeText)
  else
    self._timeInfo:SetActive(true)
    self._timeInfo:SetText(TextManager.GetText(record.isshowTimeShow))
  end
  self._selected:SetActive(self._delegate._cardPoolList[self._delegate._selectedPoolIndex] and self._delegate._cardPoolList[self._delegate._selectedPoolIndex].id == data.id)
end

function PoolCell:OnMouseClick()
  self._delegate:OnPoolCellClick(self._cellData)
end

function PoolCell:OnEvent(name, args)
  if name == "select" then
    self._selected:SetActive(args == self._cellData.id)
  end
end

return PoolCell
