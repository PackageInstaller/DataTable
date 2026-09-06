local CFavourPresentType = BeanManager.GetTableByName("role.cfavourpresenttype")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local GiveGiftItemCell = class("GiveGiftItemCell", Dialog)
GiveGiftItemCell.AssetBundleName = "ui/layouts.tujian"
GiveGiftItemCell.AssetName = "FavourGiveItemCell"

function GiveGiftItemCell:Ctor(...)
  GiveGiftItemCell.super.Ctor(self, ...)
end

function GiveGiftItemCell:OnCreate()
  self._icon = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._select = self:GetChild("Panel/ItemCell/_BackGround/Select")
  self._count = self:GetChild("Panel/ItemCell/_Count")
  self._hearts = {}
  for i = 1, 3 do
    table.insert(self._hearts, self:GetChild("Heart" .. i))
  end
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function GiveGiftItemCell:OnDestroy()
end

function GiveGiftItemCell:RefreshCell(data)
  self._data = data.data
  self._index = data.index
  local imageRecord = self._data:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local favourPresentTypeRecord = CFavourPresentType:GetRecorder(self._data:GetID())
  if favourPresentTypeRecord.presenttype == self._delegate._favourGiftType then
    imageRecord = CImagePathTable:GetRecorder(12429) or DataCommon.DefaultImageAsset
    local heartEffectNum = favourPresentTypeRecord.presentuplevel
    for i, v in ipairs(self._hearts) do
      v:SetActive(i <= heartEffectNum)
    end
  else
    imageRecord = self._data:GetPinJiImage()
    for _, v in ipairs(self._hearts) do
      v:SetActive(false)
    end
  end
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._count:SetText(NumberManager.GetShowNumber(NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(self._data:GetID())))
  self._select:SetActive(self._delegate._selectItem:GetID() == self._data:GetID())
end

function GiveGiftItemCell:OnCellClicked()
  self._delegate:SetSelectItem(self._data, self._index)
end

function GiveGiftItemCell:OnEvent(eventName, args)
  if eventName == "SetSelectItem" then
    self._select:SetActive(args == self._data:GetID())
  end
end

return GiveGiftItemCell
