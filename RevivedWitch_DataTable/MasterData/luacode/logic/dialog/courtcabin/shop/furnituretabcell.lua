-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/shop/furnituretabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CFurnitureSortSingle = (BeanManager.GetTableByName)("recharge.cfurnituresortsingle")
local Item = require("logic.manager.experimental.types.item")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local UIManager = ((CS.PixelNeko).UI).UIManager
local Cabin = require("logic.fsm.yardfsm.cabin")
local BottomToTop = 3
local SORT_TYPE = {NEW = 1, COMFORT = 2, PRICE = 3}
local FurnitureTabCell = class("FurnitureTabCell", Dialog)
FurnitureTabCell.AssetBundleName = "ui/layouts.yard"
FurnitureTabCell.AssetName = "FurnitureItem"
FurnitureTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FurnitureTabCell, Cabin
  ((FurnitureTabCell.super).Ctor)(self, ...)
  self._furnitureList = {}
  self._sort = Cabin.NormalFurniture
  self._showOtherChoose = false
  self._sortChooseData = {}
end

FurnitureTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, GridFrame, TableFrame, _ENV
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
  ;
  (self._sortBtn):Subscribe_PointerClickEvent(self.OnSortBtnClick, self)
  ;
  (self._chooseBtn):Subscribe_PointerClickEvent(self.OnChooseBtnClick, self)
  ;
  (self._searchBtn):Subscribe_PointerClickEvent(self.OnSearchBtnClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnMouseClick, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnMouseClick, Common.n_NoTargetWindowClick, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGoodsChecked, Common.n_GoodsChecked, nil)
end

FurnitureTabCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._chooseFrame):Destroy()
  ;
  (self._furnitureFrame):Destroy()
end

FurnitureTabCell.OnGoodsChecked = function(self, notification)
  -- function num : 0_3 , upvalues : _ENV
  local data = notification.userInfo
  if data.strTag == (DataCommon.CabinGoodsType).Furniture then
    (self._furnitureFrame):FireEvent("FurnitureChecked", data.goodId)
  end
end

FurnitureTabCell.RefreshTabCell = function(self, notChangePos, refreshData)
  -- function num : 0_4
  local lastPos = (self._furnitureFrame):GetCurrentPosition()
  self._furnitureListInit = ((self._delegate)._furnitureMap)[(self._delegate)._selectTabId]
  if not self._init or refreshData then
    if not self._init then
      self._init = true
    end
    self:RefreshSortPanel()
    self:RefreshFurnitureList()
  end
  if notChangePos and lastPos then
    (self._furnitureFrame):MoveToAssignedPos(lastPos)
  end
  ;
  (self._furnitureFrame):MoveToTop()
end

FurnitureTabCell.RefreshSortPanel = function(self)
  -- function num : 0_5 , upvalues : CFurnitureSortSingle, _ENV
  local record = CFurnitureSortSingle:GetRecorder((self._sort).sortId)
  ;
  (self._chooseBtn_text):SetText((TextManager.GetText)(record.nameid))
  if self._showOtherChoose then
    (self._choosePanel):SetActive(true)
    while (self._sortChooseData)[#self._sortChooseData] do
      (table.remove)(self._sortChooseData, #self._sortChooseData)
    end
    local allIds = CFurnitureSortSingle:GetAllIds()
    for i = 1, #allIds do
      local recorder = CFurnitureSortSingle:GetRecorder(allIds[i])
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

FurnitureTabCell.RefreshFurnitureList = function(self, bySearch)
  -- function num : 0_6 , upvalues : _ENV, FurnitureItem, SORT_TYPE
  local furnitureList = {}
  local keyword = (self._inputField):GetText()
  if keyword ~= "" then
    for i,v in ipairs(self._furnitureListInit) do
      local furniture = (FurnitureItem.Create)((v.serverData).itemId)
      if (string.find)(furniture:GetName(), keyword) then
        (table.insert)(furnitureList, v)
      end
    end
    if bySearch and #furnitureList == 0 then
      (self._empty):SetActive(true)
    end
  else
    furnitureList = self._furnitureListInit
  end
  if keyword == "" or #furnitureList > 0 then
    (self._empty):SetActive(false)
  end
  ;
  (table.sort)(furnitureList, function(a, b)
    -- function num : 0_6_0 , upvalues : self, SORT_TYPE, FurnitureItem
    local a_value, b_value = nil, nil
    local a_id, b_id = (a.serverData).itemId, (b.serverData).itemId
    if (self._sort).sortId == SORT_TYPE.NEW then
      a_value = (a.serverData).sortId
    else
      if (self._sort).sortId == SORT_TYPE.COMFORT then
        local a_furniture = (FurnitureItem.Create)(a_id)
        local b_furniture = (FurnitureItem.Create)(b_id)
        -- DECOMPILER ERROR at PC31: Overwrote pending register: R3 in 'AssignReg'

        a_value = a_furniture:GetComfort()
      else
        do
          -- DECOMPILER ERROR at PC42: Overwrote pending register: R3 in 'AssignReg'

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
  end
)
  local soldOutList = {}
  local notSoldOutList = {}
  for i,v in ipairs(furnitureList) do
    if (v.serverData).goodRemain <= 0 then
      (table.insert)(soldOutList, v)
    else
      ;
      (table.insert)(notSoldOutList, v)
    end
  end
  do
    while (self._furnitureList)[#self._furnitureList] do
      (table.remove)(self._furnitureList, #self._furnitureList)
    end
    for i,v in ipairs(notSoldOutList) do
      (table.insert)(self._furnitureList, v)
    end
    for i,v in ipairs(soldOutList) do
      (table.insert)(self._furnitureList, v)
    end
    ;
    (self._furnitureFrame):ReloadAllCell()
  end
end

FurnitureTabCell.OnSortBtnClick = function(self)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  (self._sort).rise = not (self._sort).rise
  self:RefreshSortPanel()
  self:RefreshFurnitureList()
end

FurnitureTabCell.OnChooseBtnClick = function(self)
  -- function num : 0_8
  self._showOtherChoose = not self._showOtherChoose
  self:RefreshSortPanel()
end

FurnitureTabCell.OnSearchBtnClick = function(self)
  -- function num : 0_9
  local text = (self._inputField):GetText()
  if (not self._lastInputFieldText and text ~= "") or self._lastInputFieldText and self._lastInputFieldText ~= text then
    self:RefreshFurnitureList(true)
    self._lastInputFieldText = text
  end
end

FurnitureTabCell.OnMouseClick = function(self, args)
  -- function num : 0_10 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._chooseBtn)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) and self._showOtherChoose and not (UIManager.RectangleContainsScreenPoint)((self._choosePanel)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self._showOtherChoose = false
    self:RefreshSortPanel()
  end
end

FurnitureTabCell.SetSortId = function(self, sortId)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._sort).sortId = sortId
  self._showOtherChoose = false
  self:RefreshSortPanel()
  self:RefreshFurnitureList()
end

FurnitureTabCell.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_12
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

FurnitureTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_13
  if frame == self._furnitureFrame then
    return #self._furnitureList
  else
    if frame == self._chooseFrame then
      return #self._sortChooseData
    end
  end
end

FurnitureTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_14
  if frame == self._furnitureFrame then
    return "courtcabin.shop.furniturecell"
  else
    if frame == self._chooseFrame then
      return "courtcabin.shop.sortchoosecell"
    end
  end
end

FurnitureTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_15
  if frame == self._furnitureFrame then
    return (self._furnitureList)[index]
  else
    if frame == self._chooseFrame then
      return (self._sortChooseData)[index]
    end
  end
end

return FurnitureTabCell

