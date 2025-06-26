-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/shop/themedetaildialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CDormFurnitureGroup = (BeanManager.GetTableByName)("courtyard.cdormfurnituregroup")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CFurnitureSortTheme = (BeanManager.GetTableByName)("recharge.cfurnituresorttheme")
local Item = require("logic.manager.experimental.types.item")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local UIManager = ((CS.PixelNeko).UI).UIManager
local Cabin = require("logic.fsm.yardfsm.cabin")
local BottomToTop = 3
local SORT_TYPE = {COMFORT = 1, PRICE = 2}
local ThemeDetailDialog = class("ThemeDetailDialog", Dialog)
ThemeDetailDialog.AssetBundleName = "ui/layouts.yard"
ThemeDetailDialog.AssetName = "FurnitureThemeDetail"
ThemeDetailDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ThemeDetailDialog, Cabin
  ((ThemeDetailDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._furnitureListInit = {}
  self._furnitureList = {}
  self._sort = Cabin.ThemeFurniture
  self._showOtherChoose = false
  self._sortChooseData = {}
end

ThemeDetailDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, GridFrame, TableFrame, _ENV
  self._themeIcon = self:GetChild("Panel/Detail/Theme/Item")
  self._themeName = self:GetChild("Panel/Detail/Theme/NameBack/Name")
  self._comfortIcon = self:GetChild("Panel/Detail/Theme/Comfortable/ComfortableImg")
  self._comfortNum = self:GetChild("Panel/Detail/Theme/Comfortable/ComfortableNum")
  self._furnitureNum = self:GetChild("Panel/Detail/Theme/Num/Num")
  self._soldOut = self:GetChild("Panel/Detail/Theme/SoldOut")
  self._leftArrow = self:GetChild("Panel/Detail/LeftArrow")
  self._rightArrow = self:GetChild("Panel/Detail/RightArrow")
  self._themeNum = self:GetChild("Panel/Detail/TxtBack/Txt")
  self._description = self:GetChild("Panel/Detail/Detail")
  self._costCurrencyIcon = self:GetChild("Panel/Detail/Icon")
  self._costCurrencyPrice = self:GetChild("Panel/Detail/Price")
  self._buyBtn = self:GetChild("Panel/Detail/BuyBtn")
  self._scrollBar = self:GetChild("Panel/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._furniturePanel = self:GetChild("Panel/Frame")
  self._furnitureFrame = (GridFrame.Create)(self._furniturePanel, self, true, 2)
  self._sortBtn = self:GetChild("Panel/Panel/SortBtn")
  self._sortBtn_text = self:GetChild("Panel/Panel/SortBtn/Txt")
  self._sortBtn_up = self:GetChild("Panel/Panel/SortBtn/UpImg")
  self._sortBtn_down = self:GetChild("Panel/Panel/SortBtn/DownImg")
  self._sortPanel = self:GetChild("Panel/Panel/SortBtn/List/Frame")
  self._chooseBtn = self:GetChild("Panel/Panel/FliterBtn")
  self._chooseBtn_text = self:GetChild("Panel/Panel/FliterBtn/Txt")
  self._choosePanel = self:GetChild("Panel/Panel/FliterBtn/List/Frame")
  local _ = nil
  self._width = (self._choosePanel):GetDeltaSize()
  self._chooseFrame = (TableFrame.Create)(self._choosePanel, self, true, false, true)
  self._empty = self:GetChild("Panel/EmptyTxt")
  ;
  (self._empty):SetText((TextManager.GetText)(800325))
  ;
  (self._empty):SetActive(false)
  self._inputField = self:GetChild("Panel/Panel/Search/FriendsInputField")
  ;
  (self._inputField):SetGenerateOutOfBounds(true)
  self._searchBtn = self:GetChild("Panel/Panel/Search/SearchBtn")
  self._backBtn = self:GetChild("Panel/BackBtn")
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnLeftArrowClick, self)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnRightArrowClick, self)
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClick, self)
  ;
  (self._sortBtn):Subscribe_PointerClickEvent(self.OnSortBtnClick, self)
  ;
  (self._chooseBtn):Subscribe_PointerClickEvent(self.OnChooseBtnClick, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClick, self)
  ;
  (self._searchBtn):Subscribe_PointerClickEvent(self.OnSearchBtnClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnMouseClick, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnMouseClick, Common.n_NoTargetWindowClick, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshGoodInfo, Common.n_BuyShopGood, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGoodsChecked, Common.n_GoodsChecked, nil)
end

ThemeDetailDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._chooseFrame):Destroy()
  ;
  (self._furnitureFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

ThemeDetailDialog.OnRefreshGoodInfo = function(self)
  -- function num : 0_3
  local lastPos = (self._furnitureFrame):GetCurrentPosition()
  self:SetData(((self._themeInfo).serverData).goodId)
  if lastPos then
    (self._furnitureFrame):MoveToAssignedPos(lastPos)
  end
end

ThemeDetailDialog.OnGoodsChecked = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
  local data = notification.userInfo
  if data.strTag == (DataCommon.CabinGoodsType).Furniture then
    (self._furnitureFrame):FireEvent("FurnitureChecked", data.goodId)
  end
end

ThemeDetailDialog.SetData = function(self, themeId)
  -- function num : 0_5 , upvalues : _ENV
  self._themeInfo = ((NekoData.BehaviorManager).BM_Shop):GetThemeInfoById(themeId)
  self._furnitureMap = ((NekoData.BehaviorManager).BM_Shop):GetFurnitures()
  self:RefreshLeftThemeDetail()
  local value = #((NekoData.BehaviorManager).BM_Shop):GetThemeList() > 1
  ;
  (self._leftArrow):SetActive(value)
  ;
  (self._rightArrow):SetActive(value)
  while (self._furnitureListInit)[#self._furnitureListInit] do
    (table.remove)(self._furnitureListInit, #self._furnitureListInit)
  end
  for k,v in pairs((self._themeInfo).furnitures) do
    (table.insert)(self._furnitureListInit, (self._furnitureMap)[k])
  end
  self:RefreshSortPanel()
  self:RefreshFurnitureList()
  ;
  ((NekoData.BehaviorManager).BM_Shop):SetChecked((DataCommon.CabinGoodsType).Theme, themeId)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

ThemeDetailDialog.RefreshSortPanel = function(self)
  -- function num : 0_6 , upvalues : CFurnitureSortTheme, _ENV
  local record = CFurnitureSortTheme:GetRecorder((self._sort).sortId)
  ;
  (self._chooseBtn_text):SetText((TextManager.GetText)(record.nameid))
  if self._showOtherChoose then
    (self._choosePanel):SetActive(true)
    while (self._sortChooseData)[#self._sortChooseData] do
      (table.remove)(self._sortChooseData, #self._sortChooseData)
    end
    local allIds = CFurnitureSortTheme:GetAllIds()
    for i = 1, #allIds do
      local recorder = CFurnitureSortTheme:GetRecorder(allIds[i])
      if recorder.id ~= (self._sort).sortId then
        (table.insert)(self._sortChooseData, recorder)
      end
    end
    ;
    (self._chooseFrame):ReloadAllCell()
    ;
    (self._chooseFrame):MoveToTop()
    ;
    (self._choosePanel):SetDeltaSize(self._width, (self._chooseFrame):GetTotalLength())
  else
    do
      ;
      (self._choosePanel):SetActive(false)
      if (self._sort).rise then
        (self._sortBtn_text):SetText((TextManager.GetText)(800188))
        ;
        (self._sortBtn_up):SetActive(true)
        ;
        (self._sortBtn_down):SetActive(false)
      else
        ;
        (self._sortBtn_text):SetText((TextManager.GetText)(800189))
        ;
        (self._sortBtn_up):SetActive(false)
        ;
        (self._sortBtn_down):SetActive(true)
      end
    end
  end
end

ThemeDetailDialog.RefreshLeftThemeDetail = function(self)
  -- function num : 0_7 , upvalues : CDormFurnitureGroup, CImagePathTable, _ENV, Item
  local record = CDormFurnitureGroup:GetRecorder(((self._themeInfo).serverData).goodId)
  local imgRecord = CImagePathTable:GetRecorder(record.imageBigBuy)
  ;
  (self._themeIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  ;
  (self._themeName):SetText((TextManager.GetText)(record.nameTextID))
  imgRecord = ((NekoData.BehaviorManager).BM_Cabin):GetComfortImageRecord()
  ;
  (self._comfortIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  ;
  (self._comfortNum):SetText((self._themeInfo).comfort)
  if (self._themeInfo).stock <= 0 then
    (self._soldOut):SetActive(true)
    ;
    (self._furnitureNum):SetText((self._themeInfo).totalFurnitureNum .. "/" .. (self._themeInfo).totalFurnitureNum)
  else
    ;
    (self._soldOut):SetActive(false)
    ;
    (self._furnitureNum):SetText((self._themeInfo).haveFurnitureNum .. "/" .. (self._themeInfo).totalFurnitureNum)
  end
  ;
  (self._themeNum):SetText((self._themeInfo).haveNum .. "/" .. (self._themeInfo).upperLimit)
  ;
  (self._description):SetText((TextManager.GetText)(record.timetxtID))
  local costCurrencyItem = (Item.Create)(DataCommon.ThemeCostCurrencyId)
  local imageRecord = costCurrencyItem:GetIcon()
  ;
  (self._costCurrencyIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._costCurrencyPrice):SetText((self._themeInfo).price)
  ;
  (self._buyBtn):SetInteractable((self._themeInfo).stock ~= 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ThemeDetailDialog.RefreshFurnitureList = function(self, bySearch)
  -- function num : 0_8 , upvalues : _ENV, FurnitureItem, SORT_TYPE
  while (self._furnitureList)[#self._furnitureList] do
    (table.remove)(self._furnitureList, #self._furnitureList)
  end
  local keyword = (self._inputField):GetText()
  if keyword ~= "" then
    for i,v in ipairs(self._furnitureListInit) do
      local furniture = (FurnitureItem.Create)((v.serverData).itemId)
      if (string.find)(furniture:GetName(), keyword) then
        (table.insert)(self._furnitureList, v)
      end
    end
    if bySearch and #self._furnitureList == 0 then
      (self._empty):SetActive(true)
    end
  else
    for i,v in ipairs(self._furnitureListInit) do
      (table.insert)(self._furnitureList, v)
    end
  end
  do
    if keyword == "" or #self._furnitureList > 0 then
      (self._empty):SetActive(false)
    end
    ;
    (table.sort)(self._furnitureList, function(a, b)
    -- function num : 0_8_0 , upvalues : self, SORT_TYPE, FurnitureItem
    local a_value, b_value = nil, nil
    local a_id, b_id = (a.serverData).itemId, (b.serverData).itemId
    if (self._sort).sortId == SORT_TYPE.COMFORT then
      local a_furniture = (FurnitureItem.Create)(a_id)
      local b_furniture = (FurnitureItem.Create)(b_id)
      a_value = a_furniture:GetComfort()
    else
      do
        -- DECOMPILER ERROR at PC31: Overwrote pending register: R3 in 'AssignReg'

        if (self._sort).sortId == SORT_TYPE.PRICE then
          a_value = (a.serverData).discountPrice
        end
        if (self._sort).rise then
          if a_id >= b_id then
            do return a_value ~= b_value end
            do return b_id < a_id end
            if a_value >= b_value then
              do return not (self._sort).rise end
              do return b_value < a_value end
              -- DECOMPILER ERROR: 8 unprocessed JMP targets
            end
          end
        end
      end
    end
  end
)
    ;
    (self._furnitureFrame):ReloadAllCell()
  end
end

ThemeDetailDialog.OnLeftArrowClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("courtcabin.shop.furniturestoredialog")
  if dialog and dialog._selectTabId == 0 then
    local themeTabCell = (dialog._tabFrame):GetCellAtIndex(dialog._selectTabId)
    themeTabCell:OnLeftArrowClick()
    ;
    (self._inputField):SetText("")
    self:SetData(themeTabCell._selectThemeId)
  end
end

ThemeDetailDialog.OnRightArrowClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("courtcabin.shop.furniturestoredialog")
  if dialog and dialog._selectTabId == 0 then
    local themeTabCell = (dialog._tabFrame):GetCellAtIndex(dialog._selectTabId)
    themeTabCell:OnRightArrowClick()
    ;
    (self._inputField):SetText("")
    self:SetData(themeTabCell._selectThemeId)
  end
end

ThemeDetailDialog.OnBuyBtnClick = function(self)
  -- function num : 0_11 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("courtcabin.shop.buythemedialog")):SetData(((self._themeInfo).serverData).goodId)
end

ThemeDetailDialog.OnSortBtnClick = function(self)
  -- function num : 0_12
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  (self._sort).rise = not (self._sort).rise
  self:RefreshSortPanel()
  self:RefreshFurnitureList()
end

ThemeDetailDialog.OnChooseBtnClick = function(self)
  -- function num : 0_13
  self._showOtherChoose = not self._showOtherChoose
  self:RefreshSortPanel()
end

ThemeDetailDialog.OnSearchBtnClick = function(self)
  -- function num : 0_14
  local text = (self._inputField):GetText()
  if (not self._lastInputFieldText and text ~= "") or self._lastInputFieldText and self._lastInputFieldText ~= text then
    self._lastInputFieldText = text
    self:RefreshFurnitureList(true)
  end
end

ThemeDetailDialog.OnMouseClick = function(self, args)
  -- function num : 0_15 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._chooseBtn)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) and self._showOtherChoose and not (UIManager.RectangleContainsScreenPoint)((self._choosePanel)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self._showOtherChoose = false
    self:RefreshSortPanel()
  end
end

ThemeDetailDialog.SetSortId = function(self, sortId)
  -- function num : 0_16
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._sort).sortId = sortId
  self._showOtherChoose = false
  self:RefreshSortPanel()
  self:RefreshFurnitureList()
end

ThemeDetailDialog.OnBackBtnClick = function(self)
  -- function num : 0_17
  self:Destroy()
end

ThemeDetailDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_18
  if frame == self._furnitureFrame then
    local width, height = (self._furniturePanel):GetRectSize()
    local total = (self._furnitureFrame):GetTotalLength()
    if height < total then
      (self._scrollBar):SetScrollSize(height / total)
      ;
      (self._scrollBar):SetScrollValue(proportion)
    else
      ;
      (self._scrollBar):SetScrollSize(1)
      ;
      (self._scrollBar):SetScrollValue(proportion)
    end
  end
end

ThemeDetailDialog.NumberOfCell = function(self, frame)
  -- function num : 0_19
  if frame == self._furnitureFrame then
    return #self._furnitureList
  else
    if frame == self._chooseFrame then
      return #self._sortChooseData
    end
  end
end

ThemeDetailDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_20
  if frame == self._furnitureFrame then
    return "courtcabin.shop.furniturecell"
  else
    if frame == self._chooseFrame then
      return "courtcabin.shop.sortchoosecell"
    end
  end
end

ThemeDetailDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_21
  if frame == self._furnitureFrame then
    return (self._furnitureList)[index]
  else
    if frame == self._chooseFrame then
      return (self._sortChooseData)[index]
    end
  end
end

ThemeDetailDialog.AddNewModal = function(self, dialog)
  -- function num : 0_22
end

return ThemeDetailDialog

