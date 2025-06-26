-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/shop/themetabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local ColumnNums = 6
local CDormFurnitureGroup = (BeanManager.GetTableByName)("courtyard.cdormfurnituregroup")
local ThemeTabCell = class("ThemeTabCell", Dialog)
ThemeTabCell.AssetBundleName = "ui/layouts.yard"
ThemeTabCell.AssetName = "FurnitureTheme"
ThemeTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ThemeTabCell
  ((ThemeTabCell.super).Ctor)(self, ...)
  self._themeList = {}
  self._selectThemeId = nil
end

ThemeTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._name = self:GetChild("Panel/Name")
  self._description = self:GetChild("Panel/Back/Detail")
  self._costCurrencyIcon = self:GetChild("Panel/Back/Image")
  self._costCurrencyPrice = self:GetChild("Panel/Back/Price")
  self._buyBtn = self:GetChild("Panel/BuyBtn")
  self._soldOutBtn = self:GetChild("Panel/BoughtBtn")
  self._leftArrow = self:GetChild("Panel/Down/Left")
  self._rightArrow = self:GetChild("Panel/Down/Right")
  self._panel = self:GetChild("Panel/Down/ThemeFrame")
  self._frame = (TableFrame.Create)(self._panel, self, false, true)
  self._inputField = self:GetChild("Panel/Search/FriendsInputField")
  ;
  (self._inputField):SetGenerateOutOfBounds(true)
  self._searchBtn = self:GetChild("Panel/Search/SearchBtn")
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnLeftArrowClick, self)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnRightArrowClick, self)
  ;
  (self._buyBtn):Subscribe_PointerClickEvent(self.OnBuyBtnClick, self)
  ;
  (self._searchBtn):Subscribe_PointerClickEvent(self.OnSearchBtnClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGoodsChecked, Common.n_GoodsChecked, nil)
end

ThemeTabCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

ThemeTabCell.OnGoodsChecked = function(self, notification)
  -- function num : 0_3 , upvalues : _ENV
  local data = notification.userInfo
  if data.strTag == (DataCommon.CabinGoodsType).Theme then
    (self._frame):FireEvent("ThemeChecked", data.goodId)
  end
end

ThemeTabCell.RefreshTabCell = function(self, notChangePos, bySearch)
  -- function num : 0_4 , upvalues : _ENV, CDormFurnitureGroup, ColumnNums
  local lastPos = (self._frame):GetCurrentPosition()
  local themeListInit = ((NekoData.BehaviorManager).BM_Shop):GetThemeList()
  local themeList = {}
  local keyword = (self._inputField):GetText()
  if bySearch then
    if keyword ~= "" and bySearch == 2 then
      for i,v in ipairs(themeListInit) do
        local record = CDormFurnitureGroup:GetRecorder((v.serverData).goodId)
        if (string.find)((TextManager.GetText)(record.nameTextID), keyword) then
          (table.insert)(themeList, v)
        end
      end
      if #themeList == 0 then
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100265)
        return 
      else
        self._selectThemeId = nil
        self._init = false
      end
    else
      if bySearch == 2 then
        return 
      else
        themeList = themeListInit
      end
    end
  else
    themeList = themeListInit
  end
  while (self._themeList)[#self._themeList] do
    (table.remove)(self._themeList, #self._themeList)
  end
  local soldOutList = {}
  local notSoldOutList = {}
  for i,v in ipairs(themeList) do
    if v.stock <= 0 then
      (table.insert)(soldOutList, v)
    else
      ;
      (table.insert)(notSoldOutList, v)
    end
  end
  ;
  (table.sort)(notSoldOutList, function(a, b)
    -- function num : 0_4_0 , upvalues : _ENV
    local a_status = (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. (DataCommon.CabinGoodsType).Theme .. tostring((a.serverData).goodId), (DataCommon.CabinGoodsStatus).Default)
    local b_status = (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. (DataCommon.CabinGoodsType).Theme .. tostring((b.serverData).goodId), (DataCommon.CabinGoodsStatus).Default)
    if a_status == b_status then
      local a_sortId, b_sortId = (a.serverData).sortId, (b.serverData).sortId
      return b_sortId < a_sortId
    else
      return a_status < b_status
    end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
)
  ;
  (table.sort)(soldOutList, function(a, b)
    -- function num : 0_4_1
    local a_sortId, b_sortId = (a.serverData).sortId, (b.serverData).sortId
    do return b_sortId < a_sortId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i,v in ipairs(notSoldOutList) do
    (table.insert)(self._themeList, v)
  end
  for i,v in ipairs(soldOutList) do
    (table.insert)(self._themeList, v)
  end
  do
    if not notChangePos or not self._selectThemeId then
      self._selectThemeId = (((self._themeList)[1]).serverData).goodId
    end
    local value = ColumnNums < #self._themeList
    ;
    (self._frame):SetSlide(value)
    ;
    (self._frame):ReloadAllCell()
    if notChangePos and lastPos then
      (self._frame):MoveToAssignedPos(lastPos)
    end
    ;
    (self._frame):MoveToLeft()
    self:RefreshDescriptionPanel()
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

local GetItemIdAndPosList = function(self, record)
  -- function num : 0_5 , upvalues : _ENV
  local itemIdList = {}
  for i,v in ipairs(record.items) do
    (table.insert)(itemIdList, {id = v})
  end
  local positionList = {}
  for i,v in ipairs(record.location) do
    local tempList = (string.split)(v, ",")
    ;
    (table.insert)(positionList, {x = tonumber(tempList[1]), y = tonumber(tempList[2])})
  end
  return itemIdList, positionList
end

ThemeTabCell.RefreshDescriptionPanel = function(self, needRefreshFurnitureDressUp)
  -- function num : 0_6 , upvalues : _ENV, CDormFurnitureGroup, Item, GetItemIdAndPosList
  local themeInfo = ((NekoData.BehaviorManager).BM_Shop):GetThemeInfoById(self._selectThemeId)
  local record = CDormFurnitureGroup:GetRecorder(self._selectThemeId)
  ;
  (self._name):SetText((TextManager.GetText)(record.nameTextID))
  ;
  (self._description):SetText((TextManager.GetText)(record.descriptiontxtID))
  local costCurrencyItem = (Item.Create)(DataCommon.ThemeCostCurrencyId)
  local imageRecord = costCurrencyItem:GetIcon()
  ;
  (self._costCurrencyIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._costCurrencyPrice):SetText(themeInfo.price)
  local soldOut = themeInfo.stock == 0
  ;
  (self._buyBtn):SetActive(not soldOut)
  ;
  (self._soldOutBtn):SetActive(soldOut)
  if not self._init or needRefreshFurnitureDressUp then
    self._init = true
    local itemIdList, positionList = GetItemIdAndPosList(self, record)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_UseTheme, self, {tag = "Preview", itemIdList = itemIdList, positionList = positionList})
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

ThemeTabCell.SetSelectTheme = function(self, themeId)
  -- function num : 0_7
  if self._selectThemeId ~= themeId then
    self._selectThemeId = themeId
    self:RefreshDescriptionPanel(true)
    ;
    (self._frame):FireEvent("SetSelectTheme")
  end
end

ThemeTabCell.OnBuyBtnClick = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("courtcabin.shop.themedetaildialog")):SetData(self._selectThemeId)
end

ThemeTabCell.OnLeftArrowClick = function(self)
  -- function num : 0_9
  local leftIndex = (self._frame):GetLeftIndex()
  local rightIndex = (self._frame):GetRightIndex()
  local curSelectThemeIndex = self:GetIndexByThemeId(self._selectThemeId)
  local nextThemeIndex = curSelectThemeIndex - 1
  local tag = false
  if nextThemeIndex <= 0 then
    nextThemeIndex = #self._themeList
    tag = true
  end
  if nextThemeIndex < leftIndex or rightIndex < nextThemeIndex then
    if nextThemeIndex < leftIndex then
      (self._frame):MoveLeftToIndex(nextThemeIndex)
    else
      if tag then
        (self._frame):MoveRightToIndex(nextThemeIndex)
      else
        ;
        (self._frame):MoveRightToIndex(curSelectThemeIndex)
      end
    end
  end
  self:SetSelectTheme((((self._themeList)[nextThemeIndex]).serverData).goodId)
end

ThemeTabCell.OnRightArrowClick = function(self)
  -- function num : 0_10
  local leftIndex = (self._frame):GetLeftIndex()
  local rightIndex = (self._frame):GetRightIndex()
  local curSelectThemeIndex = self:GetIndexByThemeId(self._selectThemeId)
  local nextThemeIndex = curSelectThemeIndex + 1
  local tag = false
  if #self._themeList < nextThemeIndex then
    nextThemeIndex = 1
    tag = true
  end
  if nextThemeIndex < leftIndex or rightIndex < nextThemeIndex then
    if nextThemeIndex < leftIndex then
      if tag then
        (self._frame):MoveLeftToIndex(1)
      else
        ;
        (self._frame):MoveLeftToIndex(curSelectThemeIndex)
      end
    else
      ;
      (self._frame):MoveRightToIndex(nextThemeIndex)
    end
  end
  self:SetSelectTheme((((self._themeList)[nextThemeIndex]).serverData).goodId)
end

ThemeTabCell.OnSearchBtnClick = function(self)
  -- function num : 0_11
  local text = (self._inputField):GetText()
  if (not self._lastInputFieldText and text ~= "") or self._lastInputFieldText and self._lastInputFieldText ~= text then
    self:RefreshTabCell(false, 1)
    self._lastInputFieldText = text
  else
    self:RefreshTabCell(false, 2)
  end
end

ThemeTabCell.GetIndexByThemeId = function(self, themeId)
  -- function num : 0_12 , upvalues : _ENV
  for i,v in ipairs(self._themeList) do
    if (v.serverData).goodId == themeId then
      return i
    end
  end
end

ThemeTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_13
  return #self._themeList
end

ThemeTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_14
  return "courtcabin.shop.themecell"
end

ThemeTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_15
  return (self._themeList)[index]
end

return ThemeTabCell

