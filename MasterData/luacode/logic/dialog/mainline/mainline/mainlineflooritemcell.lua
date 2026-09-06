local ItemTable = BeanManager.GetTableByName("item.citemattr")
local PinJiTable = BeanManager.GetTableByName("item.citempinji")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local MainLineFloorItemCell = class("MainLineFloorItemCell", Dialog)
MainLineFloorItemCell.AssetBundleName = "ui/layouts.mainline"
MainLineFloorItemCell.AssetName = "MainLineItemCell"

function MainLineFloorItemCell:Ctor(...)
  MainLineFloorItemCell.super.Ctor(self, ...)
end

function MainLineFloorItemCell:OnCreate()
  self._image = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._select:SetActive(false)
  self._count = self:GetChild("ItemCell/_Count")
  self._count:SetActive(false)
  self._check = self:GetChild("Check")
  self._check:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function MainLineFloorItemCell:OnDestroy()
end

function MainLineFloorItemCell:RefreshCell(data)
  if data.get then
    self._check:SetActive(true)
  else
    self._check:SetActive(false)
  end
  if data.item then
    self._data = data.item
  else
    self._data = data
  end
  local image = self._data:GetIcon()
  self._image:SetSprite(image.assetBundle, image.assetName)
  image = self._data:GetPinJiImage()
  self._frame:SetSprite(image.assetBundle, image.assetName)
end

function MainLineFloorItemCell:OnCellClick(args)
  local width, height = self:GetRootWindow():GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._data
    })
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return MainLineFloorItemCell
