local CDormFurnitureGroup = BeanManager.GetTableByName("courtyard.cdormfurnituregroup")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local TableFrame = require("framework.ui.frame.table.tableframe")
local UIManager = CS.PixelNeko.UI.UIManager
local BottomToTop = 4
local BuyThemeDialog = class("BuyThemeDialog", Dialog)
BuyThemeDialog.AssetBundleName = "ui/layouts.yard"
BuyThemeDialog.AssetName = "FurnitureThemeBuy"

function BuyThemeDialog:Ctor(...)
  BuyThemeDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._buyNum = 1
  self._stock = 0
  self._furnitureList = {}
  self._haveFurnitureType = 10000
end

function BuyThemeDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._icon = self:GetChild("Back/Theme/Item")
  self._name = self:GetChild("Back/Theme/NameBack/Name")
  self._comfortIcon = self:GetChild("Back/Theme/Comfortable/ComfortableImg")
  self._comfortNum = self:GetChild("Back/Theme/Comfortable/ComfortableNum")
  self._num = self:GetChild("Back/Theme/Num/Num")
  self._themeNum = self:GetChild("Back/TxtBack/Txt")
  self._description = self:GetChild("Back/Detail")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._panel = self:GetChild("Back/Frame")
  self._width, self._height = self._panel:GetRectSize()
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._buyNumText = self:GetChild("Back/Num/Num")
  self._reduceBtn = self:GetChild("Back/Num/MinusBtn")
  self._addBtn = self:GetChild("Back/Num/AddBtn")
  self._minBtn = self:GetChild("Back/Num/MinBtn")
  self._maxBtn = self:GetChild("Back/Num/MaxBtn")
  self._costCurrencyIcon = self:GetChild("Back/PriceAll/Image")
  self._costCurrencyNum = self:GetChild("Back/PriceAll/Num")
  self._buyBtn = self:GetChild("Back/BuyBtn")
  self._reduceBtn:Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  self._minBtn:Subscribe_PointerClickEvent(self.OnMinBtnClicked, self)
  self._maxBtn:Subscribe_PointerClickEvent(self.OnMaxBtnClicked, self)
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  self._rootWindow:Subscribe_PointerClickEvent(self.OnRootWindowClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

function BuyThemeDialog:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function BuyThemeDialog:SetData(themeId)
  self._themeInfo = NekoData.BehaviorManager.BM_Shop:GetThemeInfoById(themeId)
  local record = CDormFurnitureGroup:GetRecorder(themeId)
  local imageRecord = CImagePathTable:GetRecorder(record.imageBigBuy)
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._name:SetText(TextManager.GetText(record.nameTextID))
  self._description:SetText(TextManager.GetText(record.descriptiontxtID))
  imageRecord = NekoData.BehaviorManager.BM_Cabin:GetComfortImageRecord()
  self._comfortIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._comfortNum:SetText(self._themeInfo.comfort)
  self._num:SetText(self._themeInfo.haveFurnitureNum .. "/" .. self._themeInfo.totalFurnitureNum)
  self._themeNum:SetText(self._themeInfo.haveNum .. "/" .. self._themeInfo.upperLimit)
  local costCurrencyItem = Item.Create(DataCommon.ThemeCostCurrencyId)
  imageRecord = costCurrencyItem:GetIcon()
  self._costCurrencyIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._stock = self._themeInfo.stock
  self._furnitures = NekoData.BehaviorManager.BM_Shop:GetFurnitures()
  local map = {}
  if self._themeInfo.haveFurnitureNum > 0 then
    map[self._haveFurnitureType] = {}
  end
  for furnitureId, num in pairs(self._themeInfo.furnitures) do
    local furnitureItem = FurnitureItem.Create(furnitureId)
    local haveNum = NekoData.BehaviorManager.BM_BagInfo:GetFurnitureCountById(furnitureId) - self._themeInfo.haveNum * num
    if 0 < haveNum then
      table.insert(map[self._haveFurnitureType], {furnitureItem = furnitureItem})
    end
    if num > haveNum then
      local type = furnitureItem:GetType()
      if not map[type] then
        map[type] = {}
      end
      table.insert(map[type], {furnitureItem = furnitureItem})
    end
  end
  for k, v in pairs(map) do
    table.insert(self._furnitureList, {type = k, data = v})
  end
  table.sort(self._furnitureList, function(a, b)
    return a.type < b.type
  end)
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
  self:RefreshRightBuyPanel(true)
end

function BuyThemeDialog:RefreshRightBuyPanel(init)
  if not init then
    while self._furnitureList[#self._furnitureList] do
      table.remove(self._furnitureList, #self._furnitureList)
    end
    local map = {}
    if self._themeInfo.haveFurnitureNum > 0 then
      map[self._haveFurnitureType] = {}
    end
    for furnitureId, num in pairs(self._themeInfo.furnitures) do
      local furnitureItem = FurnitureItem.Create(furnitureId)
      local haveNum = NekoData.BehaviorManager.BM_BagInfo:GetFurnitureCountById(furnitureId) - self._themeInfo.haveNum * num
      if 0 < haveNum then
        table.insert(map[self._haveFurnitureType], {furnitureItem = furnitureItem})
      end
      if haveNum < self._buyNum * num then
        local type = furnitureItem:GetType()
        if not map[type] then
          map[type] = {}
        end
        table.insert(map[type], {furnitureItem = furnitureItem})
      end
    end
    for k, v in pairs(map) do
      table.insert(self._furnitureList, {type = k, data = v})
    end
    table.sort(self._furnitureList, function(a, b)
      return a.type < b.type
    end)
    self._frame:ReloadAllCell()
    self._frame:MoveToTop()
  end
  self._buyNumText:SetText(self._buyNum)
  local trueCost = 0
  for furnitureId, num in pairs(self._themeInfo.furnitures) do
    if self._furnitures[furnitureId] then
      local furnitureServerData = self._furnitures[furnitureId].serverData
      local haveNum = NekoData.BehaviorManager.BM_BagInfo:GetFurnitureCountById(furnitureId) - self._themeInfo.haveNum * num
      if haveNum < self._buyNum * num then
        trueCost = trueCost + (self._buyNum * num - haveNum) * furnitureServerData.discountPrice
      end
    end
  end
  self._trueCost = trueCost
  self._costCurrencyNum:SetText(trueCost)
end

function BuyThemeDialog:OnReduceBtnClicked()
  if self._buyNum > 1 then
    self._buyNum = self._buyNum - 1
    self:RefreshRightBuyPanel()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100235)
  end
end

function BuyThemeDialog:OnAddBtnClicked()
  if self._buyNum < self._stock then
    self._buyNum = self._buyNum + 1
    self:RefreshRightBuyPanel()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100236)
  end
end

function BuyThemeDialog:OnMinBtnClicked()
  if self._buyNum ~= 1 then
    self._buyNum = 1
    self:RefreshRightBuyPanel()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100235)
  end
end

function BuyThemeDialog:OnMaxBtnClicked()
  if self._buyNum ~= self._stock then
    self._buyNum = self._stock
    self:RefreshRightBuyPanel()
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100236)
  end
end

function BuyThemeDialog:OnRootWindowClicked()
end

function BuyThemeDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function BuyThemeDialog:OnBackBtnClicked()
  self:Destroy()
end

function BuyThemeDialog:OnBuyBtnClicked()
  if self._trueCost then
    local haveNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.FurnitureCion)
    if haveNum >= self._trueCost then
      local map = {}
      for furnitureId, num in pairs(self._themeInfo.furnitures) do
        local furnitureServerData = self._furnitures[furnitureId].serverData
        local haveNum = NekoData.BehaviorManager.BM_BagInfo:GetFurnitureCountById(furnitureId) - self._themeInfo.haveNum * num
        if haveNum < self._buyNum * num then
          local buyNum = self._buyNum * num - haveNum
          map[furnitureServerData.goodId] = buyNum
        end
      end
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.cbuyshopgood")
      if protocol then
        protocol.shopId = DataCommon.FurnitureShopId
        protocol.goods = map
        protocol:Send()
      end
    else
      NekoData.BehaviorManager.BM_Message:OpenCurrencyExchangeBuyDialog(1, self._trueCost - haveNum)
    end
  else
    local a = 1
  end
end

function BuyThemeDialog:NumberOfCell(frame)
  return #self._furnitureList
end

function BuyThemeDialog:CellAtIndex(frame, index)
  return "courtcabin.shop.themefurnituretypecell"
end

function BuyThemeDialog:DataAtIndex(frame, index)
  return self._furnitureList[index]
end

function BuyThemeDialog:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function BuyThemeDialog:ShouldLengthChange()
  return true
end

return BuyThemeDialog
