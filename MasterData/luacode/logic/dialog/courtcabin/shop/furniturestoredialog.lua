local TabFrame = require("framework.ui.frame.tab.tabframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CDormFurnitureType = BeanManager.GetTableByName("courtyard.cdormfurnituretype")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local ThemeBtnId = 0
local ColumnNums = 4
local FurnitureStoreDialog = class("FurnitureStoreDialog", Dialog)
FurnitureStoreDialog.AssetBundleName = "ui/layouts.yard"
FurnitureStoreDialog.AssetName = "FurnitureShop"

function FurnitureStoreDialog:Ctor(...)
  FurnitureStoreDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._show = true
  self._currencies = {
    [1] = DataCommon.FurnitureCion,
    [2] = DataCommon.DiamodID
  }
  self._tabBtnDataList = {}
  table.insert(self._tabBtnDataList, {
    recorder = {id = ThemeBtnId}
  })
  local allIds = CDormFurnitureType:GetAllIds()
  for i = 1, #allIds do
    table.insert(self._tabBtnDataList, {
      recorder = CDormFurnitureType:GetRecorder(allIds[i])
    })
  end
  self._selectTabId = ThemeBtnId
  self._furnitureMap = {}
end

function FurnitureStoreDialog:OnCreate()
  self._panel = self:GetChild("Panel")
  self._hideBtn = self:GetChild("HideBtn")
  self._backBtn = self:GetChild("Panel/BackBtn")
  self._menuBtn = self:GetChild("Panel/MenuBtn")
  self._currencyPanel = self:GetChild("Panel/TopGroup")
  self._upArrow = self:GetChild("Panel/UpBtn")
  self._downArrow = self:GetChild("Panel/DownBtn")
  self._tabBtnPanel = self:GetChild("Panel/BtnFrame")
  self._tabPanel = self:GetChild("Panel/Frame")
  self._currencyPanelWidth, self._currencyPanelHeight = self._currencyPanel:GetRectSize()
  self._currencyPanel:SetDeltaSize(self._currencyPanelWidth / 3 * #self._currencies, self._currencyPanelHeight)
  self._currencyFrame = TableFrame.Create(self._currencyPanel, self, false, false)
  self._tabBtnFrame = TableFrame.Create(self._tabBtnPanel, self, true, true, true)
  self._tabFrame = TabFrame.Create(self._tabPanel, self)
  self._hideBtn:Subscribe_PointerClickEvent(self.OnHideBtnClick, self)
  self._upArrow:Subscribe_PointerClickEvent(self.OnUpArrowClick, self)
  self._downArrow:Subscribe_PointerClickEvent(self.OnDownArrowClick, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClick, self)
  self:Init()
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrencyPanel, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshGoodInfo, Common.n_BuyShopGood, nil)
  local dialog = DialogManager.GetDialog("courtcabin.interactmodaldialog")
  if dialog then
    dialog:SetResponseMouse(false)
    LuaNotificationCenter.PostNotification(Common.n_EnterDressUpMode, self, nil)
  end
end

function FurnitureStoreDialog:OnDestroy()
  self._currencyFrame:Destroy()
  self._tabBtnFrame:Destroy()
  self._tabFrame:Destroy()
  DialogManager.DestroySingletonDialog("fastmenu.fastmenudialog")
  LuaNotificationCenter.RemoveObserver(self)
  local dialog = DialogManager.GetDialog("courtcabin.interactmodaldialog")
  if dialog then
    dialog:SetResponseMouse(true)
    LuaNotificationCenter.PostNotification(Common.n_ReturnInitState, self, nil)
    LuaNotificationCenter.PostNotification(Common.n_ExitDressUpMode, self, nil)
  end
end

function FurnitureStoreDialog:OnRefreshGoodInfo(notification)
  local protocol = notification.userInfo
  for i, v in ipairs(protocol.refresh) do
    local furnitureItemId = v.itemId
    local furnitureItem = FurnitureItem.Create(furnitureItemId)
    local type = furnitureItem:GetType()
    local list = self._furnitureMap[type]
    if list then
      for i, v in ipairs(list) do
        local goodId = v.goodId
        if v.serverData.goodId == goodId then
          list[i] = NekoData.BehaviorManager.BM_Shop:GetFurnitureInfo(goodId)
          break
        end
      end
    end
  end
  local tabCell = self._tabFrame:GetCellAtIndex(self._selectTabId)
  tabCell:RefreshTabCell(true, true)
end

function FurnitureStoreDialog:Init()
  self:RefreshCurrencyPanel()
  local value = #self._currencies <= ColumnNums
  self._tabBtnFrame:SetSlide(value)
  self._tabBtnFrame:ReloadAllCell()
  self._tabBtnFrame:MoveToTop()
  local furnitureList = NekoData.BehaviorManager.BM_Shop:GetFurnitureList()
  for i, v in ipairs(furnitureList) do
    local furnitureItem = FurnitureItem.Create(v.serverData.itemId)
    local type = furnitureItem:GetType()
    if not self._furnitureMap[type] then
      self._furnitureMap[type] = {}
    end
    table.insert(self._furnitureMap[type], v)
  end
  local tabCell = self._tabFrame:ToPage(self._selectTabId)
  tabCell:RefreshTabCell()
end

function FurnitureStoreDialog:RefreshCurrencyPanel()
  self._currencyFrame:ReloadAllCell()
end

function FurnitureStoreDialog:SetSelectTabId(id)
  if self._selectTabId ~= id then
    local lastSelectTabId = self._selectTabId
    self._selectTabId = id
    self._tabBtnFrame:FireEvent("SetSelectTabId")
    if self._selectTabId == ThemeBtnId then
      self._show = true
      self._hideBtn:SetActive(true)
    else
      self._show = false
      self._hideBtn:SetActive(false)
    end
    local tabCell = self._tabFrame:ToPage(self._selectTabId)
    if lastSelectTabId == ThemeBtnId then
      LuaNotificationCenter.PostNotification(Common.n_ReturnInitState, self, nil)
    elseif id == ThemeBtnId then
      tabCell._init = false
    end
    tabCell:RefreshTabCell(false, true)
  end
end

function FurnitureStoreDialog:NumberOfCell(frame, index)
  if frame == self._currencyFrame then
    return #self._currencies
  elseif frame == self._tabBtnFrame then
    return #self._tabBtnDataList
  end
end

function FurnitureStoreDialog:CellAtIndex(frame, index)
  if frame == self._currencyFrame then
    return "courtcabin.shop.furniturecurrencycell"
  elseif frame == self._tabBtnFrame then
    return "courtcabin.shop.furniturestoretabbtncell"
  elseif frame == self._tabFrame then
    if self._selectTabId == ThemeBtnId then
      return "courtcabin.shop.themetabcell"
    else
      return "courtcabin.shop.furnituretabcell"
    end
  end
end

function FurnitureStoreDialog:DataAtIndex(frame, index)
  if frame == self._currencyFrame then
    return self._currencies[index]
  elseif frame == self._tabBtnFrame then
    return self._tabBtnDataList[index]
  end
end

function FurnitureStoreDialog:GetIndexByTabId(tabId)
  for i, v in ipairs(self._tabBtnDataList) do
    if v.recorder.id == tabId then
      return i
    end
  end
end

function FurnitureStoreDialog:OnUpArrowClick()
  local leftIndex = self._tabBtnFrame:GetTopIndex()
  local rightIndex = self._tabBtnFrame:GetDownIndex()
  local curSelectThemeIndex = self:GetIndexByTabId(self._selectTabId)
  local nextThemeIndex = curSelectThemeIndex - 1
  local tag = false
  if nextThemeIndex <= 0 then
    nextThemeIndex = #self._tabBtnDataList
    tag = true
  end
  if leftIndex > nextThemeIndex or rightIndex < nextThemeIndex then
    if leftIndex > nextThemeIndex then
      self._tabBtnFrame:MoveTopToIndex(nextThemeIndex)
    elseif tag then
      self._tabBtnFrame:MoveDownToIndex(nextThemeIndex)
    else
      self._tabBtnFrame:MoveDownToIndex(curSelectThemeIndex)
    end
  end
  self:SetSelectTabId(self._tabBtnDataList[nextThemeIndex].recorder.id)
end

function FurnitureStoreDialog:OnDownArrowClick()
  local leftIndex = self._tabBtnFrame:GetTopIndex()
  local rightIndex = self._tabBtnFrame:GetDownIndex()
  local curSelectThemeIndex = self:GetIndexByTabId(self._selectTabId)
  local nextThemeIndex = curSelectThemeIndex + 1
  local tag = false
  if nextThemeIndex > #self._tabBtnDataList then
    nextThemeIndex = 1
    tag = true
  end
  if leftIndex > nextThemeIndex or rightIndex < nextThemeIndex then
    if leftIndex > nextThemeIndex then
      if tag then
        self._tabBtnFrame:MoveTopToIndex(1)
      else
        self._tabBtnFrame:MoveTopToIndex(curSelectThemeIndex)
      end
    else
      self._tabBtnFrame:MoveDownToIndex(nextThemeIndex)
    end
  end
  self:SetSelectTabId(self._tabBtnDataList[nextThemeIndex].recorder.id)
end

function FurnitureStoreDialog:OnHideBtnClick()
  self._show = not self._show
  self._panel:SetActive(self._show)
  self._hideBtn:SetSelected(not self._show)
end

function FurnitureStoreDialog:AddNewModal(dialog)
end

function FurnitureStoreDialog:OnBackBtnClicked()
  self:Destroy()
end

function FurnitureStoreDialog:OnMenuBtnClick()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return FurnitureStoreDialog
