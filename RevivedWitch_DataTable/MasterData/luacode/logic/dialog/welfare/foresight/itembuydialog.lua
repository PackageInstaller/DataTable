-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/foresight/itembuydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local ItemBuyDialog = class("ItemBuyDialog", Dialog)
ItemBuyDialog.AssetBundleName = "ui/layouts.welfare"
ItemBuyDialog.AssetName = "ActivityForesightAward"
ItemBuyDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemBuyDialog
  ((ItemBuyDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._itemData = {}
end

ItemBuyDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._itemName = self:GetChild("Back/ItemName")
  self._itemIcon = self:GetChild("Back/MonthCardImg")
  self._itemPanel = self:GetChild("Back/Frame")
  self._itemFrame = (TableFrame.Create)(self._itemPanel, self, true, true, true)
  self._priceNormalImage = self:GetChild("Back/Price/Image")
  self._priceNormalNow = self:GetChild("Back/Price/Num")
  self._buyBtn = self:GetChild("Back/BuyBtn")
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogClicked, Common.n_GlobalPointerWillDown, nil)
end

ItemBuyDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._itemFrame then
    (self._itemFrame):Destroy()
  end
end

ItemBuyDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CImagePathTable, Item
  self._data = data
  self._dm = (NekoData.DataManager).DM_Foresight
  self._bm = (NekoData.BehaviorManager).BM_Foresight
  ;
  (self._itemName):SetText((TextManager.GetText)((self._data).goodName))
  if not CImagePathTable:GetRecorder((self._data).pictureId) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._itemIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._moneyItem = (Item.Create)((self._data).moneyType)
  imageRecord = (self._moneyItem):GetIcon()
  ;
  (self._priceNormalImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._priceNormalNow):SetText((NumberManager.GetShowNumber)((self._data).price))
  for i,v in ipairs((self._data).itemId) do
    (table.insert)(self._itemData, {id = v, count = ((self._data).itemSum)[i]})
  end
  ;
  (self._itemFrame):ReloadAllCell()
  ;
  (self._itemFrame):MoveToTop()
end

ItemBuyDialog.OnBuyBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, Item
  if not (self._bm):GetIsOpen() then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100477)
  else
    if (self._data).isUnlock and not (self._data).isGet then
      local hadCurrencyNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((self._data).moneyType)
      if (self._data).price <= hadCurrencyNum then
        (self._bm):SendCBuyForesightGift((self._data).goodId)
      else
        if (self._data).moneyType == DataCommon.DiamodID then
          ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(15, nil, function()
    -- function num : 0_4_0 , upvalues : _ENV
    ((NekoData.BehaviorManager).BM_Shop):TryOpenShopWithID(4)
  end
, {}, nil, {})
        else
          ;
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100032, {((Item.Create)((self._data).moneyType)):GetName()})
        end
        self:Destroy()
        return 
      end
    end
  end
  do
    self:Destroy()
  end
end

ItemBuyDialog.OnDialogClicked = function(self, args)
  -- function num : 0_5 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

ItemBuyDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if (DialogManager.GetDialog)("bag.itemtipsdialog") or (DialogManager.GetDialog)("equip.equiptipspreviewdialog") then
    return 
  end
  self:Destroy()
end

ItemBuyDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._itemData
end

ItemBuyDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "welfare.foresight.shopitembuycell"
end

ItemBuyDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._itemData)[index]
end

return ItemBuyDialog

