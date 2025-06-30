-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/recommendthemedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CDormFurnitureGroup = (BeanManager.GetTableByName)("courtyard.cdormfurnituregroup")
local BagTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.bagtypes")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 2
local RecommendThemeDialog = class("RecommendThemeDialog", Dialog)
RecommendThemeDialog.AssetBundleName = "ui/layouts.yard"
RecommendThemeDialog.AssetName = "HouseThemeRecommend"
RecommendThemeDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RecommendThemeDialog
  ((RecommendThemeDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._themeDataList = {}
  self._allRoomUsedFurnitures = {}
  self._canUseItemIdList = {}
  self._canUseItemPosList = {}
end

RecommendThemeDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame
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
end

RecommendThemeDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
  ;
  (self._themeFrame):Destroy()
end

RecommendThemeDialog.LoadLocalData = function(self)
  -- function num : 0_3 , upvalues : _ENV, BagTypeEnum
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

RecommendThemeDialog.Init = function(self, themeId)
  -- function num : 0_4 , upvalues : _ENV
  self:RefreshThemeInfo(themeId)
  self._recommendThemeList = ((NekoData.BehaviorManager).BM_Cabin):GetCanUsedRecommendThemeList()
  ;
  (self._themeFrame):ReloadAllCell()
end

RecommendThemeDialog.RefreshThemeInfo = function(self, themeId)
  -- function num : 0_5 , upvalues : _ENV, CDormFurnitureGroup, FurnitureItem
  if not self._themeId or self._themeId ~= themeId then
    self._themeId = themeId
    while (self._canUseItemIdList)[#self._canUseItemIdList] do
      (table.remove)(self._canUseItemIdList, #self._canUseItemIdList)
    end
    while (self._canUseItemPosList)[#self._canUseItemPosList] do
      (table.remove)(self._canUseItemPosList, #self._canUseItemPosList)
    end
    while (self._themeDataList)[#self._themeDataList] do
      (table.remove)(self._themeDataList, #self._themeDataList)
    end
    local themeDataMap = {}
    local recorder = CDormFurnitureGroup:GetRecorder(themeId)
    self._recorder = recorder
    ;
    (self._title):SetText((TextManager.GetText)(recorder.nameTextID))
    local notUsedMap, usedNum = self:GetNotUsedFurnituresAndUsedNum()
    local comfort = 0
    for i,v in ipairs(recorder.items) do
      local furniture = (FurnitureItem.Create)(v)
      local type = furniture:GetType()
      if not themeDataMap[type] then
        themeDataMap[type] = {type = type, 
furnitureList = {}
}
      end
      comfort = comfort + furniture:GetComfort()
      local num = 0
      if notUsedMap[v] then
        num = #notUsedMap[v]
      end
      local maxNum = furniture:GetLimitNum()
      local disable = false
      if num == 0 then
        disable = true
      else
        ;
        (table.remove)(notUsedMap[v], #notUsedMap[v])
        ;
        (table.insert)(self._canUseItemIdList, v)
        local list = (string.split)((recorder.location)[i], ",")
        ;
        (table.insert)(self._canUseItemPosList, {x = tonumber(list[1]), y = tonumber(list[2])})
      end
      do
        do
          ;
          (table.insert)((themeDataMap[type]).furnitureList, {item = furniture, disable = disable})
          -- DECOMPILER ERROR at PC133: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
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
    -- function num : 0_5_0
    do return a.type < b.type end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    ;
    (self._frame):ReloadAllCell()
    ;
    (self._frame):MoveToTop()
  end
end

RecommendThemeDialog.GetNotUsedFurnituresAndUsedNum = function(self)
  -- function num : 0_6 , upvalues : _ENV
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

RecommendThemeDialog.GetUsedMaxNum = function(self, type)
  -- function num : 0_7
  return ((self._cdormFurnitureTypeCfg)[type]).num
end

RecommendThemeDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

RecommendThemeDialog.OnUseBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_UseTheme, self, {tag = "Recommend", id = (self._recorder).id, itemIdList = self:GetCanUseFurnitureKeyList(), positionList = self._canUseItemPosList})
  self:Destroy()
end

RecommendThemeDialog.GetCanUseFurnitureKeyList = function(self)
  -- function num : 0_10 , upvalues : _ENV
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

RecommendThemeDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_11
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

RecommendThemeDialog.NumberOfCell = function(self, frame)
  -- function num : 0_12
  if frame == self._frame then
    return #self._themeDataList
  else
    return #self._recommendThemeList
  end
end

RecommendThemeDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_13
  if frame == self._frame then
    return "courtcabin.recommendthemeframecell"
  else
    return "courtcabin.recommendthemecell"
  end
end

RecommendThemeDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_14
  if frame == self._frame then
    return (self._themeDataList)[index]
  else
    return (self._recommendThemeList)[index]
  end
end

RecommendThemeDialog.SelectTheme = function(self, themeId)
  -- function num : 0_15
  self:RefreshThemeInfo(themeId)
  ;
  (self._themeFrame):FireEvent("SelectTheme", themeId)
end

return RecommendThemeDialog

