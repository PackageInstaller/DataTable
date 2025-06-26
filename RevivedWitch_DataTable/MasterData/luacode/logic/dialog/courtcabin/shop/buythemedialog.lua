-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/shop/buythemedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CDormFurnitureGroup = (BeanManager.GetTableByName)("courtyard.cdormfurnituregroup")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = ((CS.PixelNeko).UI).UIManager
local BottomToTop = 4
local BuyThemeDialog = class("BuyThemeDialog", Dialog)
BuyThemeDialog.AssetBundleName = "ui/layouts.yard"
BuyThemeDialog.AssetName = "FurnitureThemeBuy"
BuyThemeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BuyThemeDialog
  ((BuyThemeDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._buyNum = 1
  self._stock = 0
  self._furnitureList = {}
  self._haveFurnitureType = 10000
end

BuyThemeDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame, _ENV
  self._back = self:GetChild("Back")
  self._icon = self:GetChild("Back/Theme/Item")
  self._name = self:GetChild("Back/Theme/NameBack/Name")
  self._comfortIcon = self:GetChild("Back/Theme/Comfortable/ComfortableImg")
  self._comfortNum = self:GetChild("Back/Theme/Comfortable/ComfortableNum")
  self._num = self:GetChild("Back/Theme/Num/Num")
  self._themeNum = self:GetChild("Back/TxtBack/Txt")
  self._description = self:GetChild("Back/Detail")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._panel = self:GetChild("Back/Frame")
  self._width = (self._panel):GetRectSize()
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._buyNumText = self:GetChild("Back/Num/Num")
  self._reduceBtn = self:GetChild("Back/Num/MinusBtn")
  self._addBtn = self:GetChild("Back/Num/AddBtn")
  self._minBtn = self:GetChild("Back/Num/MinBtn")
  self._maxBtn = self:GetChild("Back/Num/MaxBtn")
  self._costCurrencyIcon = self:GetChild("Back/PriceAll/Image")
  self._costCurrencyNum = self:GetChild("Back/PriceAll/Num")
  self._buyBtn = self:GetChild("Back/BuyBtn")
  ;
  (self._reduceBtn):Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  ;
  (self._minBtn):Subscribe_PointerClickEvent(self.OnMinBtnClicked, self)
  ;
  (self._maxBtn):Subscribe_PointerClickEvent(self.OnMaxBtnClicked, self)
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnRootWindowClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

BuyThemeDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

BuyThemeDialog.SetData = function(self, themeId)
  -- function num : 0_3 , upvalues : _ENV, CDormFurnitureGroup, CImagePathTable, Item, FurnitureItem
  self._themeInfo = ((NekoData.BehaviorManager).BM_Shop):GetThemeInfoById(themeId)
  local record = CDormFurnitureGroup:GetRecorder(themeId)
  local imageRecord = CImagePathTable:GetRecorder(record.imageBigBuy)
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((TextManager.GetText)(record.nameTextID))
  ;
  (self._description):SetText((TextManager.GetText)(record.descriptiontxtID))
  imageRecord = ((NekoData.BehaviorManager).BM_Cabin):GetComfortImageRecord()
  ;
  (self._comfortIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._comfortNum):SetText((self._themeInfo).comfort)
  ;
  (self._num):SetText((self._themeInfo).haveFurnitureNum .. "/" .. (self._themeInfo).totalFurnitureNum)
  ;
  (self._themeNum):SetText((self._themeInfo).haveNum .. "/" .. (self._themeInfo).upperLimit)
  local costCurrencyItem = (Item.Create)(DataCommon.ThemeCostCurrencyId)
  imageRecord = costCurrencyItem:GetIcon()
  ;
  (self._costCurrencyIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._stock = (self._themeInfo).stock
  self._furnitures = ((NekoData.BehaviorManager).BM_Shop):GetFurnitures()
  local map = {}
  if (self._themeInfo).haveFurnitureNum > 0 then
    map[self._haveFurnitureType] = {}
  end
  for furnitureId,num in pairs((self._themeInfo).furnitures) do
    local furnitureItem = (FurnitureItem.Create)(furnitureId)
    local haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetFurnitureCountById(furnitureId) - (self._themeInfo).haveNum * num
    if haveNum > 0 then
      (table.insert)(map[self._haveFurnitureType], {furnitureItem = furnitureItem})
    end
    if haveNum < num then
      local type = furnitureItem:GetType()
      if not map[type] then
        map[type] = {}
      end
      ;
      (table.insert)(map[type], {furnitureItem = furnitureItem})
    end
  end
  for k,v in pairs(map) do
    (table.insert)(self._furnitureList, {type = k, data = v})
  end
  ;
  (table.sort)(self._furnitureList, function(a, b)
    -- function num : 0_3_0
    do return a.type < b.type end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
  self:RefreshRightBuyPanel(true)
end

BuyThemeDialog.RefreshRightBuyPanel = function(self, init)
  -- function num : 0_4 , upvalues : _ENV, FurnitureItem
  while 1 do
    if not init then
      if (self._furnitureList)[#self._furnitureList] then
        (table.remove)(self._furnitureList, #self._furnitureList)
        -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_STMT

        -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  do
    local map = {}
    if (self._themeInfo).haveFurnitureNum > 0 then
      map[self._haveFurnitureType] = {}
    end
    for furnitureId,num in pairs((self._themeInfo).furnitures) do
      local furnitureItem = (FurnitureItem.Create)(furnitureId)
      local haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetFurnitureCountById(furnitureId) - (self._themeInfo).haveNum * num
      if haveNum > 0 then
        (table.insert)(map[self._haveFurnitureType], {furnitureItem = furnitureItem})
      end
      if haveNum < self._buyNum * num then
        local type = furnitureItem:GetType()
        if not map[type] then
          map[type] = {}
        end
        ;
        (table.insert)(map[type], {furnitureItem = furnitureItem})
      end
    end
    for k,v in pairs(map) do
      (table.insert)(self._furnitureList, {type = k, data = v})
    end
    ;
    (table.sort)(self._furnitureList, function(a, b)
    -- function num : 0_4_0
    do return a.type < b.type end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._frame):MoveToTop()
    ;
    (self._buyNumText):SetText(self._buyNum)
    local trueCost = 0
    for furnitureId,num in pairs((self._themeInfo).furnitures) do
      local furnitureServerData = ((self._furnitures)[furnitureId]).serverData
      local haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetFurnitureCountById(furnitureId) - (self._themeInfo).haveNum * num
      if haveNum < self._buyNum * num then
        trueCost = trueCost + (self._buyNum * num - haveNum) * furnitureServerData.discountPrice
      end
    end
    self._trueCost = trueCost
    ;
    (self._costCurrencyNum):SetText(trueCost)
  end
end

BuyThemeDialog.OnReduceBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._buyNum > 1 then
    self._buyNum = self._buyNum - 1
    self:RefreshRightBuyPanel()
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100235)
  end
end

BuyThemeDialog.OnAddBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self._buyNum < self._stock then
    self._buyNum = self._buyNum + 1
    self:RefreshRightBuyPanel()
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100236)
  end
end

BuyThemeDialog.OnMinBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self._buyNum ~= 1 then
    self._buyNum = 1
    self:RefreshRightBuyPanel()
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100235)
  end
end

BuyThemeDialog.OnMaxBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self._buyNum ~= self._stock then
    self._buyNum = self._stock
    self:RefreshRightBuyPanel()
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100236)
  end
end

BuyThemeDialog.OnRootWindowClicked = function(self)
  -- function num : 0_9
end

BuyThemeDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_10 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

BuyThemeDialog.OnBackBtnClicked = function(self)
  -- function num : 0_11
  self:Destroy()
end

BuyThemeDialog.OnBuyBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local haveNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.FurnitureCion)
  if self._trueCost <= haveNum then
    local map = {}
    for furnitureId,num in pairs((self._themeInfo).furnitures) do
      local furnitureServerData = ((self._furnitures)[furnitureId]).serverData
      local haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetFurnitureCountById(furnitureId) - (self._themeInfo).haveNum * num
      if haveNum < self._buyNum * num then
        local buyNum = self._buyNum * num - haveNum
        map[furnitureServerData.goodId] = buyNum
      end
    end
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cbuyshopgood")
    if protocol then
      protocol.shopId = DataCommon.FurnitureShopId
      protocol.goods = map
      protocol:Send()
    end
  else
    do
      ;
      ((NekoData.BehaviorManager).BM_Message):OpenCurrencyExchangeBuyDialog(1, self._trueCost - haveNum)
    end
  end
end

BuyThemeDialog.NumberOfCell = function(self, frame)
  -- function num : 0_13
  return #self._furnitureList
end

BuyThemeDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_14
  return "courtcabin.shop.themefurnituretypecell"
end

BuyThemeDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_15
  return (self._furnitureList)[index]
end

BuyThemeDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_16
  local total = (self._frame):GetTotalLength()
  if self._height < total then
    (self._scrollBar):SetActive(true)
    ;
    (self._scrollBar):SetScrollSize(self._height / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetActive(false)
  end
end

BuyThemeDialog.ShouldLengthChange = function(self)
  -- function num : 0_17
  return true
end

return BuyThemeDialog

