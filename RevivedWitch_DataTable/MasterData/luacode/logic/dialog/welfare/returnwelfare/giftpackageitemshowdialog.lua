-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/returnwelfare/giftpackageitemshowdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local CRoleItem = (BeanManager.GetTableByName)("item.croleitem")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local GiftPackageItemShowDialog = class("GiftPackageItemShowDialog", Dialog)
GiftPackageItemShowDialog.AssetBundleName = "ui/layouts.welfare"
GiftPackageItemShowDialog.AssetName = "ReturnGiftTips"
GiftPackageItemShowDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GiftPackageItemShowDialog
  ((GiftPackageItemShowDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

GiftPackageItemShowDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._itemImage = self:GetChild("Back/MonthCardImg")
  self._itemName = self:GetChild("Back/ItemName")
  self._timeText = self:GetChild("Back/Time")
  self._timeImage = self:GetChild("Back/TimeImg")
  self._saleImage = self:GetChild("Back/Sale")
  self._leftNum = self:GetChild("Back/Num/Num")
  self._leftBoard = self:GetChild("Back/Num")
  ;
  (self._leftBoard):SetActive(false)
  self._priceTypeImage = self:GetChild("Back/Price/Image")
  self._priceTypeText = self:GetChild("Back/Price/Text")
  self._priceNum = self:GetChild("Back/Price/Num")
  ;
  (self._priceTypeText):SetActive(false)
  ;
  (self._priceTypeImage):SetActive(false)
  ;
  (self._priceNum):SetActive(false)
  self._buyDetail = self:GetChild("Back/Frame")
  self._cellFrame = (TableFrame.Create)(self._buyDetail, self, true, true, true)
  ;
  (self._cellFrame):SetMargin(30, 0)
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._getBtn = self:GetChild("Back/GetBtn")
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

GiftPackageItemShowDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._cellFrame):Destroy()
end

GiftPackageItemShowDialog.SetData = function(self, iteminfo, rewardStatus)
  -- function num : 0_3 , upvalues : Item, _ENV
  self._itemInfo = iteminfo
  local item = (Item.Create)(iteminfo.giftPackId)
  local imageRecord = item:GetIcon()
  ;
  (self._itemImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemName):SetText(item:GetName())
  ;
  (self._saleImage):SetActive(false)
  if not (self._itemInfo).beginTime or not (self._itemInfo).endTime or (self._itemInfo).beginTime == 0 or (self._itemInfo).endTime == 0 then
    (self._timeText):SetActive(false)
    ;
    (self._timeImage):SetActive(false)
  else
    ;
    (self._timeImage):SetActive(true)
    ;
    (self._timeText):SetActive(true)
    ;
    (self._timeText):SetText(((NekoData.BehaviorManager).BM_Shop):GetRemainTimeStr((self._itemInfo).endTime))
  end
  ;
  (self._cellFrame):ReloadAllCell()
  ;
  (self._cellFrame):MoveToTop()
  local RewardStatusType = {CannotGet = 0, CanGet = 1, GetOver = 2}
  ;
  (self._buyBtn):SetActive(not rewardStatus or rewardStatus ~= RewardStatusType.GetOver)
  ;
  (self._buyBtn):SetInteractable(rewardStatus == RewardStatusType.CanGet)
  ;
  (self._getBtn):SetActive(not rewardStatus or rewardStatus == RewardStatusType.GetOver)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

GiftPackageItemShowDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #(self._itemInfo).itemId
end

GiftPackageItemShowDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "shop.dailygiftbuycell"
end

GiftPackageItemShowDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  local data = {}
  data.id = ((self._itemInfo).itemId)[index]
  data.count = ((self._itemInfo).itemNum)[index]
  return data
end

GiftPackageItemShowDialog.OnBuyBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cgetbacktaskreward")
  if protocol then
    protocol.goodId = (self._itemInfo).giftPackId
    protocol:Send()
  end
  self:Destroy()
end

GiftPackageItemShowDialog.OnDialogClicked = function(self, args)
  -- function num : 0_8 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

GiftPackageItemShowDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if (DialogManager.GetDialog)("bag.itemtipsdialog") then
    return 
  end
  self:Destroy()
end

return GiftPackageItemShowDialog

