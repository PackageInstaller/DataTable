local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CFurnitureSortSingle = BeanManager.GetTableByName("recharge.cfurnituresortsingle")
local Item = require("logic.manager.experimental.types.item")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local UIManager = CS.PixelNeko.UI.UIManager
local Cabin = require("logic.fsm.yardfsm.cabin")
local BottomToTop = 3
local SORT_TYPE = {
  NEW = 1,
  COMFORT = 2,
  PRICE = 3
}
local FurnitureTabCell = class("FurnitureTabCell", Dialog)
FurnitureTabCell.AssetBundleName = "ui/layouts.yard"
FurnitureTabCell.AssetName = "FurnitureItem"

function FurnitureTabCell:Ctor(...)
  FurnitureTabCell.super.Ctor(self, ...)
  self._furnitureList = {}
  self._sort = Cabin.NormalFurniture
  self._showOtherChoose = false
  self._sortChooseData = {}
end

function FurnitureTabCell:OnCreate()
  self._scrollBar = self:GetChild("Panel/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._furniturePanel = self:GetChild("Panel/Frame")
  self._furnitureFrame = GridFrame.Create(self._furniturePanel, self, true, 2)
  self._sortBtn = self:GetChild("Panel/Panel/SortBtn")
  self._sortBtn_text = self:GetChild("Panel/Panel/SortBtn/Txt")
  self._sortBtn_up = self:GetChild("Panel/Panel/SortBtn/UpImg")
  self._sortBtn_down = self:GetChild("Panel/Panel/SortBtn/DownImg")
  self._sortPanel = self:GetChild("Panel/Panel/SortBtn/List/Frame")
  self._chooseBtn = self:GetChild("Panel/Panel/FliterBtn")
  self._chooseBtn_text = self:GetChild("Panel/Panel/FliterBtn/Txt")
  self._choosePanel = self:GetChild("Panel/Panel/FliterBtn/List/Frame")
  local _
  self._width, _ = self._choosePanel:GetDeltaSize()
  self._chooseFrame = TableFrame.Create(self._choosePanel, self, true, false, true)
  self._empty = self:GetChild("Panel/EmptyTxt")
  self._empty:SetText(TextManager.GetText(800325))
  self._empty:SetActive(false)
  self._inputField = self:GetChild("Panel/Panel/Search/FriendsInputField")
  self._inputField:SetGenerateOutOfBounds(true)
  self._searchBtn = self:GetChild("Panel/Panel/Search/SearchBtn")
  self._sortBtn:Subscribe_PointerClickEvent(self.OnSortBtnClick, self)
  self._chooseBtn:Subscribe_PointerClickEvent(self.OnChooseBtnClick, self)
  self._searchBtn:Subscribe_PointerClickEvent(self.OnSearchBtnClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnMouseClick, Common.n_GlobalPointerWillDown, nil)
  LuaNotificationCenter.AddObserver(self, self.OnMouseClick, Common.n_NoTargetWindowClick, nil)
  LuaNotificationCenter.AddObserver(self, self.OnGoodsChecked, Common.n_GoodsChecked, nil)
end

function FurnitureTabCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._chooseFrame:Destroy()
  self._furnitureFrame:Destroy()
end

function FurnitureTabCell:OnGoodsChecked(notification)
  local data = notification.userInfo
  if data.strTag == DataCommon.CabinGoodsType.Furniture then
    self._furnitureFrame:FireEvent("FurnitureChecked", data.goodId)
  end
end

function FurnitureTabCell:RefreshTabCell(notChangePos, refreshData)
  local lastPos = self._furnitureFrame:GetCurrentPosition()
  self._furnitureListInit = self._delegate._furnitureMap[self._delegate._selectTabId]
  if not self._init or refreshData then
    if not self._init then
      self._init = true
    end
    self:RefreshSortPanel()
    self:RefreshFurnitureList()
  end
  if notChangePos then
    if lastPos then
      self._furnitureFrame:MoveToAssignedPos(lastPos)
    end
  else
    self._furnitureFrame:MoveToTop()
  end
end

function FurnitureTabCell:RefreshSortPanel()
  local record = CFurnitureSortSingle:GetRecorder(self._sort.sortId)
  self._chooseBtn_text:SetText(TextManager.GetText(record.nameid))
  if self._showOtherChoose then
    self._choosePanel:SetActive(true)
    while self._sortChooseData[#self._sortChooseData] do
      table.remove(self._sortChooseData, #self._sortChooseData)
    end
    local allIds = CFurnitureSortSingle:GetAllIds()
    for i = 1, #allIds do
      local recorder = CFurnitureSortSingle:GetRecorder(allIds[i])
      if recorder.id ~= self._sort.sortId then
        table.insert(self._sortChooseData, recorder)
      end
    end
    self._chooseFrame:ReloadAllCell()
    self._chooseFrame:MoveToTop()
    self._choosePanel:SetDeltaSize(self._width, self._chooseFrame:GetTotalLength())
  else
    self._choosePanel:SetActive(false)
  end
  if self._sort.rise then
    self._sortBtn_text:SetText(TextManager.GetText(800188))
    self._sortBtn_up:SetActive(true)
    self._sortBtn_down:SetActive(false)
  else
    self._sortBtn_text:SetText(TextManager.GetText(800189))
    self._sortBtn_up:SetActive(false)
    self._sortBtn_down:SetActive(true)
  end
end

function FurnitureTabCell:RefreshFurnitureList(bySearch)
  local furnitureList = {}
  local keyword = self._inputField:GetText()
  if keyword ~= "" then
    for i, v in ipairs(self._furnitureListInit) do
      local furniture = FurnitureItem.Create(v.serverData.itemId)
      if string.find(furniture:GetName(), keyword) then
        table.insert(furnitureList, v)
      end
    end
    if bySearch and #furnitureList == 0 then
      self._empty:SetActive(true)
    end
  else
    furnitureList = self._furnitureListInit
  end
  if keyword == "" or 0 < #furnitureList then
    self._empty:SetActive(false)
  end
  table.sort(furnitureList, function(a, b)
    local a_value, b_value
    local a_id, b_id = a.serverData.itemId, b.serverData.itemId
    if self._sort.sortId == SORT_TYPE.NEW then
      a_value, b_value = a.serverData.sortId, b.serverData.sortId
    elseif self._sort.sortId == SORT_TYPE.COMFORT then
      local a_furniture = FurnitureItem.Create(a_id)
      local b_furniture = FurnitureItem.Create(b_id)
      a_value, b_value = a_furniture:GetComfort(), b_furniture:GetComfort()
    elseif self._sort.sortId == SORT_TYPE.PRICE then
      a_value, b_value = a.serverData.discountPrice, b.serverData.discountPrice
    end
    if a_value == b_value then
      if self._sort.rise then
        return a_id < b_id
      else
        return a_id > b_id
      end
    elseif self._sort.rise then
      return a_value < b_value
    else
      return a_value > b_value
    end
  end)
  local soldOutList = {}
  local notSoldOutList = {}
  for i, v in ipairs(furnitureList) do
    if 0 >= v.serverData.goodRemain then
      table.insert(soldOutList, v)
    else
      table.insert(notSoldOutList, v)
    end
  end
  while self._furnitureList[#self._furnitureList] do
    table.remove(self._furnitureList, #self._furnitureList)
  end
  for i, v in ipairs(notSoldOutList) do
    table.insert(self._furnitureList, v)
  end
  for i, v in ipairs(soldOutList) do
    table.insert(self._furnitureList, v)
  end
  self._furnitureFrame:ReloadAllCell()
end

function FurnitureTabCell:OnSortBtnClick()
  self._sort.rise = not self._sort.rise
  self:RefreshSortPanel()
  self:RefreshFurnitureList()
end

function FurnitureTabCell:OnChooseBtnClick()
  self._showOtherChoose = not self._showOtherChoose
  self:RefreshSortPanel()
end

function FurnitureTabCell:OnSearchBtnClick()
  local text = self._inputField:GetText()
  if not self._lastInputFieldText and text ~= "" or self._lastInputFieldText and self._lastInputFieldText ~= text then
    self:RefreshFurnitureList(true)
    self._lastInputFieldText = text
  end
end

function FurnitureTabCell:OnMouseClick(args)
  if not UIManager.RectangleContainsScreenPoint(self._chooseBtn._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) and self._showOtherChoose and not UIManager.RectangleContainsScreenPoint(self._choosePanel._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self._showOtherChoose = false
    self:RefreshSortPanel()
  end
end

function FurnitureTabCell:SetSortId(sortId)
  self._sort.sortId = sortId
  self._showOtherChoose = false
  self:RefreshSortPanel()
  self:RefreshFurnitureList()
end

function FurnitureTabCell:OnCurPosChange(frame, proportion)
  if frame == self._furnitureFrame then
    local width, height = self._furniturePanel:GetRectSize()
    local total = self._furnitureFrame:GetTotalLength()
    if height < total then
      self._scrollBar:SetScrollSize(height / total)
      self._scrollBar:SetScrollValue(proportion)
    else
      self._scrollBar:SetScrollSize(1)
      self._scrollBar:SetScrollValue(proportion)
    end
  end
end

function FurnitureTabCell:NumberOfCell(frame)
  if frame == self._furnitureFrame then
    return #self._furnitureList
  elseif frame == self._chooseFrame then
    return #self._sortChooseData
  end
end

function FurnitureTabCell:CellAtIndex(frame, index)
  if frame == self._furnitureFrame then
    return "courtcabin.shop.furniturecell"
  elseif frame == self._chooseFrame then
    return "courtcabin.shop.sortchoosecell"
  end
end

function FurnitureTabCell:DataAtIndex(frame, index)
  if frame == self._furnitureFrame then
    return self._furnitureList[index]
  elseif frame == self._chooseFrame then
    return self._sortChooseData[index]
  end
end

return FurnitureTabCell
