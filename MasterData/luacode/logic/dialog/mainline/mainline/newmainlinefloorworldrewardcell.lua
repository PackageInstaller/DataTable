local NewMainlineFloorWorldRewardCell = class("NewMainlineFloorWorldRewardCell", Dialog)
NewMainlineFloorWorldRewardCell.AssetBundleName = "ui/layouts.mainline"
NewMainlineFloorWorldRewardCell.AssetName = "DungeonSelectWorldRewardItemCell"

function NewMainlineFloorWorldRewardCell:Ctor(...)
  NewMainlineFloorWorldRewardCell.super.Ctor(self, ...)
end

function NewMainlineFloorWorldRewardCell:OnCreate()
  self._img = self:GetChild("_BackGround/Icon")
  self._frame = self:GetChild("_BackGround/Frame")
  self._select = self:GetChild("_BackGround/Select")
  self._select:SetActive(false)
  self._count = self:GetChild("_Count")
  self._count:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function NewMainlineFloorWorldRewardCell:OnDestroy()
end

function NewMainlineFloorWorldRewardCell:RefreshCell(data)
  self._data = data.item
  local image = self._data:GetIcon()
  self._img:SetSprite(image.assetBundle, image.assetName)
  image = self._data:GetPinJiImage()
  self._frame:SetSprite(image.assetBundle, image.assetName)
  if data.num then
    self._count:SetActive(true)
    self._count:SetText(NumberManager.GetShowNumber(data.num))
  else
    self._count:SetActive(false)
  end
end

function NewMainlineFloorWorldRewardCell:OnCellClicked()
  local width, height = self:GetRootWindow():GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._data
    })
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return NewMainlineFloorWorldRewardCell
