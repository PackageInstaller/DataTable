-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/diythemedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BagTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.bagtypes")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 2
local DiyThemeDialog = class("DiyThemeDialog", Dialog)
DiyThemeDialog.AssetBundleName = "ui/layouts.yard"
DiyThemeDialog.AssetName = "HouseThemeDIY"
DiyThemeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DiyThemeDialog
  ((DiyThemeDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._themeDataList = {}
  self._allRoomUsedFurnitures = {}
  self._canUseItemIdList = {}
  self._canUseItemPosList = {}
end

DiyThemeDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame, _ENV
  self._title = self:GetChild("Back/Top/Title")
  self._comfortIcon = self:GetChild("Back/Top/Comfortable/Image")
  self._comfortNumTxt = self:GetChild("Back/Top/Comfortable/Num")
  self._panel = self:GetChild("Back/Frame")
  self._themePanel = self:GetChild("Back/Frame2")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._useBtn = self:GetChild("Back/UseBtn")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (self._frame):SetMargin(20, 20)
  self._themeFrame = (TableFrame.Create)(self._themePanel, self, false, true)
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._useBtn):Subscribe_PointerClickEvent(self.OnUseBtnClicked, self)
  self._width = (self._panel):GetRectSize()
  self:LoadLocalData()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDIYThemeNameChanged, Common.n_DIYThemeNameChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDIYThemeDelete, Common.n_DIYThemeDelete, nil)
end

DiyThemeDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
  ;
  (self._themeFrame):Destroy()
end

DiyThemeDialog.OnDIYThemeNameChanged = function(self, notification)
  -- function num : 0_3 , upvalues : _ENV
  for i,v in ipairs(self._diyThemeList) do
    if v.key == (notification.userInfo).key then
      v.name = (notification.userInfo).name
      break
    end
  end
  do
    ;
    (self._themeFrame):FireEvent("ThemeNameChanged", notification.userInfo)
  end
end

DiyThemeDialog.OnDIYThemeDelete = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
  local index = nil
  for i,v in ipairs(self._diyThemeList) do
    if v.key == (notification.userInfo).key then
      index = i
      break
    end
  end
  do
    if index then
      (table.remove)(self._diyThemeList, index)
      ;
      (self._themeFrame):RemoveCellsAtIndex({index})
    end
    local length = #self._diyThemeList
    if (notification.userInfo).key == (self._themeInfo).key and length > 0 then
      self:RefreshThemeInfo((self._diyThemeList)[1])
      ;
      (self._themeFrame):ReloadAllCell()
    else
      if length <= 0 then
        self:Destroy()
      end
    end
  end
end

DiyThemeDialog.LoadLocalData = function(self)
  -- function num : 0_5 , upvalues : _ENV, BagTypeEnum
  self._dialog = (DialogManager.GetDialog)("courtcabin.interactmodaldialog")
  local roomId = (self._dialog):GetSelectRoomId()
  self._furnitureItemList = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListWithBagType(BagTypeEnum.FURNITURE_BAG)
  self._allRoomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetAllRoomInfo()
  for k,v in pairs(self._allRoomInfo) do
    if k ~= roomId then
      for furnitureItemKey,furnitureInfo in pairs(v.furnitures) do
        -- DECOMPILER ERROR at PC32: Confused about usage of register: R12 in 'UnsetPending'

        (self._allRoomUsedFurnitures)[furnitureItemKey] = true
      end
    end
  end
end

DiyThemeDialog.RefreshName = function(self, protocol)
  -- function num : 0_6
  if protocol.key == (self._themeInfo).key then
    (self._title):SetText(protocol.name)
  end
end

DiyThemeDialog.Init = function(self, themeInfo)
  -- function num : 0_7 , upvalues : _ENV
  self:RefreshThemeInfo(themeInfo)
  self._diyThemeList = ((NekoData.BehaviorManager).BM_Cabin):GetThemeList()
  ;
  (self._themeFrame):ReloadAllCell()
end

DiyThemeDialog.RefreshThemeInfo = function(self, themeInfo)
  -- function num : 0_8 , upvalues : _ENV, FurnitureItem
  while 1 do
    if not self._themeInfo or (self._themeInfo).key ~= themeInfo.key then
      if (self._canUseItemIdList)[#self._canUseItemIdList] then
        (table.remove)(self._canUseItemIdList, #self._canUseItemIdList)
        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  while (self._canUseItemPosList)[#self._canUseItemPosList] do
    (table.remove)(self._canUseItemPosList, #self._canUseItemPosList)
  end
  while (self._themeDataList)[#self._themeDataList] do
    (table.remove)(self._themeDataList, #self._themeDataList)
  end
  self._themeInfo = themeInfo
  ;
  (self._title):SetText(themeInfo.name)
  local notUsedMap, usedNum = self:GetNotUsedFurnituresAndUsedNum()
  local themeDataMap = {}
  local comfort = 0
  for i,v in ipairs(themeInfo.furniturePositions) do
    local furnitureItem = (FurnitureItem.Create)(v.itemId)
    local type = furnitureItem:GetType()
    if not themeDataMap[type] then
      themeDataMap[type] = {type = type, 
furnitureList = {}
}
    end
    comfort = comfort + furnitureItem:GetComfort()
    local num = 0
    if notUsedMap[v.itemId] then
      num = #notUsedMap[v.itemId]
    end
    local maxNum = furnitureItem:GetLimitNum()
    local disable = false
    if num == 0 then
      disable = true
    else
      ;
      (table.remove)(notUsedMap[v.itemId], #notUsedMap[v.itemId])
      ;
      (table.insert)(self._canUseItemIdList, v.itemId)
      ;
      (table.insert)(self._canUseItemPosList, v.point)
    end
    ;
    (table.insert)((themeDataMap[type]).furnitureList, {item = furnitureItem, disable = disable})
  end
  local imgRecord = ((NekoData.BehaviorManager).BM_Cabin):GetComfortImageRecord()
  if imgRecord then
    (self._comfortIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  else
    LogError("comfort imgRecord is nil.")
  end
  ;
  (self._comfortNumTxt):SetText(comfort)
  for k,v in pairs(themeDataMap) do
    (table.insert)(self._themeDataList, v)
  end
  ;
  (table.sort)(self._themeDataList, function(a, b)
    -- function num : 0_8_0
    do return a.type < b.type end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

DiyThemeDialog.GetNotUsedFurnituresAndUsedNum = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local usedNum = {}
  local notUsedMap = {}
  for i,v in ipairs(self._furnitureItemList) do
    local itemKey = v:GetKey()
    local type = v:GetType()
    local itemId = v:GetID()
    if not notUsedMap[itemId] then
      notUsedMap[itemId] = {}
    end
    if not (self._allRoomUsedFurnitures)[itemKey] then
      (table.insert)(notUsedMap[itemId], itemKey)
    end
    if not usedNum[type] then
      usedNum[type] = 1
    else
      usedNum[type] = usedNum[type] + 1
    end
  end
  return notUsedMap, usedNum
end

DiyThemeDialog.OnBackBtnClicked = function(self)
  -- function num : 0_10
  self:Destroy()
end

DiyThemeDialog.OnUseBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_UseTheme, self, {tag = "DIY", id = (self._themeInfo).key, itemIdList = self:GetCanUseFurnitureKeyList(), positionList = self._canUseItemPosList})
  self:Destroy()
end

DiyThemeDialog.GetCanUseFurnitureKeyList = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local keyList = {}
  local notUsedMap, usedNum = self:GetNotUsedFurnituresAndUsedNum()
  for i,v in ipairs(self._canUseItemIdList) do
    local key = (notUsedMap[v])[#notUsedMap[v]]
    if key then
      (table.remove)(notUsedMap[v], #notUsedMap[v])
      ;
      (table.insert)(keyList, {id = v, key = key})
    end
  end
  return keyList
end

DiyThemeDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_13
  if frame == self._frame then
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
end

DiyThemeDialog.NumberOfCell = function(self, frame)
  -- function num : 0_14
  if frame == self._frame then
    return #self._themeDataList
  else
    return #self._diyThemeList
  end
end

DiyThemeDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_15
  if frame == self._frame then
    return "courtcabin.recommendthemeframecell"
  else
    return "courtcabin.diythemecell"
  end
end

DiyThemeDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_16
  if frame == self._frame then
    return (self._themeDataList)[index]
  else
    return (self._diyThemeList)[index]
  end
end

DiyThemeDialog.SelectTheme = function(self, themeInfo)
  -- function num : 0_17
  self:RefreshThemeInfo(themeInfo)
  ;
  (self._themeFrame):FireEvent("SelectTheme", themeInfo.key)
end

return DiyThemeDialog

