local Item = require("logic.manager.experimental.types.item")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local ItemCell = class("ItemCell", Dialog)
ItemCell.AssetBundleName = "ui/layouts.bag"
ItemCell.AssetName = "ItemTipsSmall"

function ItemCell:Ctor(...)
  ItemCell.super.Ctor(self, ...)
end

function ItemCell:OnCreate()
  self._icon = self:GetChild("ItemCell/_BackGround/Icon")
  self._frame = self:GetChild("ItemCell/_BackGround/Frame")
  self._select = self:GetChild("ItemCell/_BackGround/Select")
  self._count = self:GetChild("ItemCell/_Count")
  self._name = self:GetChild("Text")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
  self:GetRootWindow():SetUserData(self)
  self._select:SetActive(false)
end

function ItemCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ItemCell:RefreshCell(data)
  local imageRecord = data.item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data.item:GetPinJiImage()
  self._frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if data.num then
    self._count:SetNumber(data.num)
  else
    self._count:SetNumber(data.item:GetCount())
  end
  if data.dontShowName then
    self._name:SetActive(false)
  else
    self._name:SetActive(true)
    local itemName = data.item:GetName()
    self._name:SetText(itemName)
  end
end

function ItemCell:OnCellClicked(args)
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

function ItemCell:OnEvent(eventName, arg)
  if eventName == "SetItemSelectedState" then
    self._select:SetActive(self:GetRootWindow():GetUserData() == arg)
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
end

function ItemCell:ChangeCellSelected(notification)
  if notification.userInfo.eventName == "SetItemSelectedState" then
    self._select:SetActive(self:GetRootWindow():GetUserData() == notification.userInfo.arg)
    DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  end
end

return ItemCell
