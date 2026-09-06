local Item = require("logic.manager.experimental.types.item")
local CharResolveShopSoldCell = class("CharResolveShopSoldCell", Dialog)
CharResolveShopSoldCell.AssetBundleName = "ui/layouts.baseshop"
CharResolveShopSoldCell.AssetName = "CharResolveShopSoldCell"

function CharResolveShopSoldCell:Ctor(...)
  CharResolveShopSoldCell.super.Ctor(self, ...)
end

function CharResolveShopSoldCell:OnCreate()
  self._img = self:GetChild("ItemCell/_BackGround/Icon")
  self._num = self:GetChild("ItemCell/_Count")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function CharResolveShopSoldCell:OnDestroy()
end

function CharResolveShopSoldCell:RefreshCell(data)
  self._item = Item.Create(data.itemid)
  local imageRecord = self._item:GetIcon()
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._num:SetText(NumberManager.GetShowNumber(data.num))
end

function CharResolveShopSoldCell:OnCellClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    local width, height = self:GetRootWindow():GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
  end
end

return CharResolveShopSoldCell
