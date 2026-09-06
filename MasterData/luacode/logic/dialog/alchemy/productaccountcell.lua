local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local ProductAccountCell = class("ProductAccountCell", Dialog)
ProductAccountCell.AssetBundleName = "ui/layouts.yard"
ProductAccountCell.AssetName = "AlchemyRewardItemCell"

function ProductAccountCell:Ctor(...)
  ProductAccountCell.super.Ctor(self, ...)
end

function ProductAccountCell:OnCreate()
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  self._extraImage = self:GetChild("Image")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:GetRootWindow():SetUserData(self)
  self._select:SetActive(false)
end

function ProductAccountCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ProductAccountCell:RefreshCell(data)
  local imageRecord = data.item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data.item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.num then
    self._count:SetNumber(data.num)
  else
    self._count:SetNumber(data.item:GetCount())
  end
  self._extraImage:SetActive(data.extra)
end

function ProductAccountCell:OnCellClicked(args)
  self._select:SetActive(true)
  self._delegate:SetSelectedID(self:GetRootWindow():GetUserData())
  local tipsDialog
  local width, height = self:GetRootWindow():GetRectSize()
  if self._cellData.item:GetItemType() == ItemTypeEnum.EQUIP then
    if self._cellData.item:IsGained() then
      tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
      if tipsDialog then
        tipsDialog:Init(self._cellData.item:GetKey())
        tipsDialog:SetTipsParmFunc(function()
          local width, height = self:GetRootWindow():GetRectSize()
          local pos = self:GetRootWindow():GetLocalPointInUiRootPanel()
          return {
            width = width,
            height = height,
            posX = pos.x,
            posY = pos.y
          }
        end)
      end
    else
      tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipspreviewdialog")
      if tipsDialog then
        tipsDialog:Init(self._cellData.item:GetID())
        tipsDialog:SetTipsParmFunc(function()
          local width, height = self:GetRootWindow():GetRectSize()
          local pos = self:GetRootWindow():GetLocalPointInUiRootPanel()
          return {
            width = width,
            height = height,
            posX = pos.x,
            posY = pos.y
          }
        end)
      end
    end
  else
    tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init(self._cellData)
      tipsDialog:SetTipsPosition(width, height, self:GetRootWindow():GetLocalPointInUiRootPanel())
    end
  end
end

function ProductAccountCell:OnEvent(eventName, arg)
  if eventName == "SetItemSelectedState" then
    self._select:SetActive(self:GetRootWindow():GetUserData() == arg)
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
end

function ProductAccountCell:ChangeCellSelected(notification)
  if notification.userInfo.eventName == "SetItemSelectedState" then
    self._select:SetActive(self:GetRootWindow():GetUserData() == notification.userInfo.arg)
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
end

return ProductAccountCell
