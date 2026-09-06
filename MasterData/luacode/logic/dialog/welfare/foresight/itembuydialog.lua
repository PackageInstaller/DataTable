local UIManager = CS.PixelNeko.UI.UIManager
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local ItemBuyDialog = class("ItemBuyDialog", Dialog)
ItemBuyDialog.AssetBundleName = "ui/layouts.welfare"
ItemBuyDialog.AssetName = "ActivityForesightAward"

function ItemBuyDialog:Ctor(...)
  ItemBuyDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._itemData = {}
end

function ItemBuyDialog:OnCreate()
  self._itemName = self:GetChild("Back/ItemName")
  self._itemIcon = self:GetChild("Back/MonthCardImg")
  self._itemPanel = self:GetChild("Back/Frame")
  self._itemFrame = TableFrame.Create(self._itemPanel, self, true, true, true)
  self._priceNormalImage = self:GetChild("Back/Price/Image")
  self._priceNormalNow = self:GetChild("Back/Price/Num")
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

function ItemBuyDialog:OnDestroy()
  if self._itemFrame then
    self._itemFrame:Destroy()
  end
end

function ItemBuyDialog:SetData(data)
  self._data = data
  self._dm = NekoData.DataManager.DM_Foresight
  self._bm = NekoData.BehaviorManager.BM_Foresight
  self._itemName:SetText(TextManager.GetText(self._data.goodName))
  local imageRecord = CImagePathTable:GetRecorder(self._data.pictureId) or DataCommon.DefaultImageAsset
  self._itemIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._moneyItem = Item.Create(self._data.moneyType)
  imageRecord = self._moneyItem:GetIcon()
  self._priceNormalImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._priceNormalNow:SetText(NumberManager.GetShowNumber(self._data.price))
  for i, v in ipairs(self._data.itemId) do
    table.insert(self._itemData, {
      id = v,
      count = self._data.itemSum[i]
    })
  end
  self._itemFrame:ReloadAllCell()
  self._itemFrame:MoveToTop()
end

function ItemBuyDialog:OnBuyBtnClicked()
  if not self._bm:GetIsOpen() then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100477)
  elseif self._data.isUnlock and not self._data.isGet then
    local hadCurrencyNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._data.moneyType)
    if hadCurrencyNum >= self._data.price then
      self._bm:SendCBuyForesightGift(self._data.goodId)
    else
      if self._data.moneyType == DataCommon.DiamodID then
        NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(15, nil, function()
          NekoData.BehaviorManager.BM_Shop:TryOpenShopWithID(4)
        end, {}, nil, {})
      else
        NekoData.BehaviorManager.BM_Message:SendMessageById(100032, {
          Item.Create(self._data.moneyType):GetName()
        })
      end
      self:Destroy()
      return
    end
  end
  self:Destroy()
end

function ItemBuyDialog:OnDialogClicked(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function ItemBuyDialog:OnBackBtnClicked()
  if DialogManager.GetDialog("bag.itemtipsdialog") or DialogManager.GetDialog("equip.equiptipspreviewdialog") then
    return
  end
  self:Destroy()
end

function ItemBuyDialog:NumberOfCell(frame)
  return #self._itemData
end

function ItemBuyDialog:CellAtIndex(frame, index)
  return "welfare.foresight.shopitembuycell"
end

function ItemBuyDialog:DataAtIndex(frame, index)
  return self._itemData[index]
end

return ItemBuyDialog
