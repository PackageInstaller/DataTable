local DetailSlotItemCell = class("DetailSlotItemCell", Dialog)
DetailSlotItemCell.AssetBundleName = "ui/layouts.yard"
DetailSlotItemCell.AssetName = "YardExploreTaskItemCell"

function DetailSlotItemCell:Ctor(...)
  DetailSlotItemCell.super.Ctor(self, ...)
end

function DetailSlotItemCell:OnCreate()
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._count = self:GetChild("ItemCell/_Count")
  self._itemCell = self:GetChild("ItemCell")
  self._mainItemBlack = self:GetChild("Black")
  self._mainItemTxt = self:GetChild("First")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function DetailSlotItemCell:OnDestroy()
end

function DetailSlotItemCell:RefreshCell(data)
  local item = data.item
  local imageRecord = item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local count = item:GetCount()
  if 0 < count then
    self._count:SetActive(true)
    self._icon:SetAlpha(1)
    self._frame:SetAlpha(1)
    self._count:SetNumber(count)
    self._mainItemBlack:SetActive(false)
    self._mainItemTxt:SetActive(false)
  else
    self._count:SetActive(false)
    self._icon:SetAlpha(1)
    self._frame:SetAlpha(1)
    if data.isMainItem then
      self._mainItemBlack:SetActive(true)
      self._mainItemTxt:SetActive(true)
    else
      self._mainItemBlack:SetActive(false)
      self._mainItemTxt:SetActive(false)
      if self._delegate._dialogName == "explore.detailworkingcell" then
        self._icon:SetAlpha(0.3)
        self._frame:SetAlpha(0.25)
      end
    end
  end
end

function DetailSlotItemCell:OnCellClicked()
  local width, height = self._itemCell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._cellData.item
    })
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return DetailSlotItemCell
