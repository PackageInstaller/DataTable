-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/shop/furniturestoredialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TabFrame = require("framework.ui.frame.tab.tabframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CDormFurnitureType = (BeanManager.GetTableByName)("courtyard.cdormfurnituretype")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local ThemeBtnId = 0
local ColumnNums = 4
local FurnitureStoreDialog = class("FurnitureStoreDialog", Dialog)
FurnitureStoreDialog.AssetBundleName = "ui/layouts.yard"
FurnitureStoreDialog.AssetName = "FurnitureShop"
FurnitureStoreDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FurnitureStoreDialog, _ENV, ThemeBtnId, CDormFurnitureType
  ((FurnitureStoreDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._show = true
  self._currencies = {[1] = DataCommon.FurnitureCion, [2] = DataCommon.DiamodID}
  self._tabBtnDataList = {}
  ;
  (table.insert)(self._tabBtnDataList, {
recorder = {id = ThemeBtnId}
})
  local allIds = CDormFurnitureType:GetAllIds()
  for i = 1, #allIds do
    (table.insert)(self._tabBtnDataList, {recorder = CDormFurnitureType:GetRecorder(allIds[i])})
  end
  self._selectTabId = ThemeBtnId
  self._furnitureMap = {}
end

FurnitureStoreDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, TabFrame, _ENV
  self._panel = self:GetChild("Panel")
  self._hideBtn = self:GetChild("HideBtn")
  self._backBtn = self:GetChild("Panel/BackBtn")
  self._menuBtn = self:GetChild("Panel/MenuBtn")
  self._currencyPanel = self:GetChild("Panel/TopGroup")
  self._upArrow = self:GetChild("Panel/UpBtn")
  self._downArrow = self:GetChild("Panel/DownBtn")
  self._tabBtnPanel = self:GetChild("Panel/BtnFrame")
  self._tabPanel = self:GetChild("Panel/Frame")
  self._currencyPanelWidth = (self._currencyPanel):GetRectSize()
  ;
  (self._currencyPanel):SetDeltaSize(self._currencyPanelWidth / 3 * #self._currencies, self._currencyPanelHeight)
  self._currencyFrame = (TableFrame.Create)(self._currencyPanel, self, false, false)
  self._tabBtnFrame = (TableFrame.Create)(self._tabBtnPanel, self, true, true, true)
  self._tabFrame = (TabFrame.Create)(self._tabPanel, self)
  ;
  (self._hideBtn):Subscribe_PointerClickEvent(self.OnHideBtnClick, self)
  ;
  (self._upArrow):Subscribe_PointerClickEvent(self.OnUpArrowClick, self)
  ;
  (self._downArrow):Subscribe_PointerClickEvent(self.OnDownArrowClick, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClick, self)
  self:Init()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrencyPanel, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshGoodInfo, Common.n_BuyShopGood, nil)
  local dialog = (DialogManager.GetDialog)("courtcabin.interactmodaldialog")
  if dialog then
    dialog:SetResponseMouse(false)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_EnterDressUpMode, self, nil)
  end
end

FurnitureStoreDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._currencyFrame):Destroy()
  ;
  (self._tabBtnFrame):Destroy()
  ;
  (self._tabFrame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("fastmenu.fastmenudialog")
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  local dialog = (DialogManager.GetDialog)("courtcabin.interactmodaldialog")
  if dialog then
    dialog:SetResponseMouse(true)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_ReturnInitState, self, nil)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_ExitDressUpMode, self, nil)
  end
end

FurnitureStoreDialog.OnRefreshGoodInfo = function(self, notification)
  -- function num : 0_3 , upvalues : _ENV, FurnitureItem
  local protocol = notification.userInfo
  for i,v in ipairs(protocol.refresh) do
    local furnitureItemId = v.itemId
    local furnitureItem = (FurnitureItem.Create)(furnitureItemId)
    local type = furnitureItem:GetType()
    local list = (self._furnitureMap)[type]
    if list then
      for i,v in ipairs(list) do
        local goodId = v.goodId
        if (v.serverData).goodId == goodId then
          list[i] = ((NekoData.BehaviorManager).BM_Shop):GetFurnitureInfo(goodId)
          break
        end
      end
    end
  end
  local tabCell = (self._tabFrame):GetCellAtIndex(self._selectTabId)
  tabCell:RefreshTabCell(true, true)
end

FurnitureStoreDialog.Init = function(self)
  -- function num : 0_4 , upvalues : ColumnNums, _ENV, FurnitureItem
  self:RefreshCurrencyPanel()
  local value = #self._currencies <= ColumnNums
  ;
  (self._tabBtnFrame):SetSlide(value)
  ;
  (self._tabBtnFrame):ReloadAllCell()
  ;
  (self._tabBtnFrame):MoveToTop()
  local furnitureList = ((NekoData.BehaviorManager).BM_Shop):GetFurnitureList()
  for i,v in ipairs(furnitureList) do
    local furnitureItem = (FurnitureItem.Create)((v.serverData).itemId)
    local type = furnitureItem:GetType()
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R10 in 'UnsetPending'

    if not (self._furnitureMap)[type] then
      (self._furnitureMap)[type] = {}
    end
    ;
    (table.insert)((self._furnitureMap)[type], v)
  end
  local tabCell = (self._tabFrame):ToPage(self._selectTabId)
  tabCell:RefreshTabCell()
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

FurnitureStoreDialog.RefreshCurrencyPanel = function(self)
  -- function num : 0_5
  (self._currencyFrame):ReloadAllCell()
end

FurnitureStoreDialog.SetSelectTabId = function(self, id)
  -- function num : 0_6 , upvalues : ThemeBtnId, _ENV
  if self._selectTabId ~= id then
    local lastSelectTabId = self._selectTabId
    self._selectTabId = id
    ;
    (self._tabBtnFrame):FireEvent("SetSelectTabId")
    if self._selectTabId == ThemeBtnId then
      self._show = true
      ;
      (self._hideBtn):SetActive(true)
    else
      self._show = false
      ;
      (self._hideBtn):SetActive(false)
    end
    local tabCell = (self._tabFrame):ToPage(self._selectTabId)
    if lastSelectTabId == ThemeBtnId then
      (LuaNotificationCenter.PostNotification)(Common.n_ReturnInitState, self, nil)
    else
      if id == ThemeBtnId then
        tabCell._init = false
      end
    end
    tabCell:RefreshTabCell(false, true)
  end
end

FurnitureStoreDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_7
  if frame == self._currencyFrame then
    return #self._currencies
  else
    if frame == self._tabBtnFrame then
      return #self._tabBtnDataList
    end
  end
end

FurnitureStoreDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8 , upvalues : ThemeBtnId
  if frame == self._currencyFrame then
    return "courtcabin.shop.furniturecurrencycell"
  else
    if frame == self._tabBtnFrame then
      return "courtcabin.shop.furniturestoretabbtncell"
    else
      if frame == self._tabFrame then
        if self._selectTabId == ThemeBtnId then
          return "courtcabin.shop.themetabcell"
        else
          return "courtcabin.shop.furnituretabcell"
        end
      end
    end
  end
end

FurnitureStoreDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._currencyFrame then
    return (self._currencies)[index]
  else
    if frame == self._tabBtnFrame then
      return (self._tabBtnDataList)[index]
    end
  end
end

FurnitureStoreDialog.GetIndexByTabId = function(self, tabId)
  -- function num : 0_10 , upvalues : _ENV
  for i,v in ipairs(self._tabBtnDataList) do
    if (v.recorder).id == tabId then
      return i
    end
  end
end

FurnitureStoreDialog.OnUpArrowClick = function(self)
  -- function num : 0_11
  local leftIndex = (self._tabBtnFrame):GetTopIndex()
  local rightIndex = (self._tabBtnFrame):GetDownIndex()
  local curSelectThemeIndex = self:GetIndexByTabId(self._selectTabId)
  local nextThemeIndex = curSelectThemeIndex - 1
  local tag = false
  if nextThemeIndex <= 0 then
    nextThemeIndex = #self._tabBtnDataList
    tag = true
  end
  if nextThemeIndex < leftIndex or rightIndex < nextThemeIndex then
    if nextThemeIndex < leftIndex then
      (self._tabBtnFrame):MoveTopToIndex(nextThemeIndex)
    else
      if tag then
        (self._tabBtnFrame):MoveDownToIndex(nextThemeIndex)
      else
        ;
        (self._tabBtnFrame):MoveDownToIndex(curSelectThemeIndex)
      end
    end
  end
  self:SetSelectTabId((((self._tabBtnDataList)[nextThemeIndex]).recorder).id)
end

FurnitureStoreDialog.OnDownArrowClick = function(self)
  -- function num : 0_12
  local leftIndex = (self._tabBtnFrame):GetTopIndex()
  local rightIndex = (self._tabBtnFrame):GetDownIndex()
  local curSelectThemeIndex = self:GetIndexByTabId(self._selectTabId)
  local nextThemeIndex = curSelectThemeIndex + 1
  local tag = false
  if #self._tabBtnDataList < nextThemeIndex then
    nextThemeIndex = 1
    tag = true
  end
  if nextThemeIndex < leftIndex or rightIndex < nextThemeIndex then
    if nextThemeIndex < leftIndex then
      if tag then
        (self._tabBtnFrame):MoveTopToIndex(1)
      else
        ;
        (self._tabBtnFrame):MoveTopToIndex(curSelectThemeIndex)
      end
    else
      ;
      (self._tabBtnFrame):MoveDownToIndex(nextThemeIndex)
    end
  end
  self:SetSelectTabId((((self._tabBtnDataList)[nextThemeIndex]).recorder).id)
end

FurnitureStoreDialog.OnHideBtnClick = function(self)
  -- function num : 0_13
  self._show = not self._show
  ;
  (self._panel):SetActive(self._show)
  ;
  (self._hideBtn):SetSelected(not self._show)
end

FurnitureStoreDialog.AddNewModal = function(self, dialog)
  -- function num : 0_14
end

FurnitureStoreDialog.OnBackBtnClicked = function(self)
  -- function num : 0_15
  self:Destroy()
end

FurnitureStoreDialog.OnMenuBtnClick = function(self)
  -- function num : 0_16 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return FurnitureStoreDialog

