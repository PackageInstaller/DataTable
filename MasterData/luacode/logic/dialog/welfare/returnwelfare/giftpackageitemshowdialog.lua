local UIManager = CS.PixelNeko.UI.UIManager
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local GiftPackageItemShowDialog = class("GiftPackageItemShowDialog", Dialog)
GiftPackageItemShowDialog.AssetBundleName = "ui/layouts.welfare"
GiftPackageItemShowDialog.AssetName = "ReturnGiftTips"

function GiftPackageItemShowDialog:Ctor(...)
  GiftPackageItemShowDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function GiftPackageItemShowDialog:OnCreate()
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemName = self:GetChild("Back/ItemName")
  self._timeText = self:GetChild("Back/Time")
  self._timeImage = self:GetChild("Back/TimeImg")
  self._saleImage = self:GetChild("Back/Sale")
  self._leftNum = self:GetChild("Back/Num/Num")
  self._leftBoard = self:GetChild("Back/Num")
  self._leftBoard:SetActive(false)
  self._priceTypeImage = self:GetChild("Back/Price/Image")
  self._priceTypeText = self:GetChild("Back/Price/Text")
  self._priceNum = self:GetChild("Back/Price/Num")
  self._priceTypeText:SetActive(false)
  self._priceTypeImage:SetActive(false)
  self._priceNum:SetActive(false)
  self._buyDetail = self:GetChild("Back/Frame")
  self._cellFrame = TableFrame.Create(self._buyDetail, self, true, true, true)
  self._cellFrame:SetMargin(30, 0)
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._getBtn = self:GetChild("Back/GetBtn")
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

function GiftPackageItemShowDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._cellFrame:Destroy()
end

function GiftPackageItemShowDialog:SetData(iteminfo, rewardStatus)
  self._itemInfo = iteminfo
  local item = Item.Create(iteminfo.giftPackId)
  local imageRecord = item:GetIcon()
  self._itemImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemName:SetText(item:GetName())
  self._saleImage:SetActive(false)
  if not (self._itemInfo.beginTime and self._itemInfo.endTime) or self._itemInfo.beginTime == 0 or self._itemInfo.endTime == 0 then
    self._timeText:SetActive(false)
    self._timeImage:SetActive(false)
  else
    self._timeImage:SetActive(true)
    self._timeText:SetActive(true)
    self._timeText:SetText(NekoData.BehaviorManager.BM_Shop:GetRemainTimeStr(self._itemInfo.endTime))
  end
  self._cellFrame:ReloadAllCell()
  self._cellFrame:MoveToTop()
  local RewardStatusType = {
    CannotGet = 0,
    CanGet = 1,
    GetOver = 2
  }
  self._buyBtn:SetActive(rewardStatus and rewardStatus ~= RewardStatusType.GetOver)
  self._buyBtn:SetInteractable(rewardStatus == RewardStatusType.CanGet)
  self._getBtn:SetActive(rewardStatus and rewardStatus == RewardStatusType.GetOver)
end

function GiftPackageItemShowDialog:NumberOfCell(frame)
  return #self._itemInfo.itemId
end

function GiftPackageItemShowDialog:CellAtIndex(frame, index)
  return "shop.dailygiftbuycell"
end

function GiftPackageItemShowDialog:DataAtIndex(frame, index)
  local data = {}
  data.id = self._itemInfo.itemId[index]
  data.count = self._itemInfo.itemNum[index]
  return data
end

function GiftPackageItemShowDialog:OnBuyBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cgetbacktaskreward")
  if protocol then
    protocol.goodId = self._itemInfo.giftPackId
    protocol:Send()
  end
  self:Destroy()
end

function GiftPackageItemShowDialog:OnDialogClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function GiftPackageItemShowDialog:OnBackBtnClicked()
  if DialogManager.GetDialog("bag.itemtipsdialog") then
    return
  end
  self:Destroy()
end

return GiftPackageItemShowDialog
