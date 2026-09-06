local BagTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.bagtypes")
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BottomToTop = 2
local DiyThemeDialog = class("DiyThemeDialog", Dialog)
DiyThemeDialog.AssetBundleName = "ui/layouts.yard"
DiyThemeDialog.AssetName = "HouseThemeDIY"

function DiyThemeDialog:Ctor(...)
  DiyThemeDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._themeDataList = {}
  self._allRoomUsedFurnitures = {}
  self._canUseItemIdList = {}
  self._canUseItemPosList = {}
end

function DiyThemeDialog:OnCreate()
  self._title = self:GetChild("Back/Top/Title")
  self._comfortIcon = self:GetChild("Back/Top/Comfortable/Image")
  self._comfortNumTxt = self:GetChild("Back/Top/Comfortable/Num")
  self._panel = self:GetChild("Back/Frame")
  self._themePanel = self:GetChild("Back/Frame2")
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._cancelBtn = self:GetChild("Back/CancelBtn")
  self._useBtn = self:GetChild("Back/UseBtn")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._frame:SetMargin(20, 20)
  self._themeFrame = TableFrame.Create(self._themePanel, self, false, true)
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._useBtn:Subscribe_PointerClickEvent(self.OnUseBtnClicked, self)
  self._width, self._height = self._panel:GetRectSize()
  self:LoadLocalData()
  LuaNotificationCenter.AddObserver(self, self.OnDIYThemeNameChanged, Common.n_DIYThemeNameChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDIYThemeDelete, Common.n_DIYThemeDelete, nil)
end

function DiyThemeDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
  self._themeFrame:Destroy()
end

function DiyThemeDialog:OnDIYThemeNameChanged(notification)
  for i, v in ipairs(self._diyThemeList) do
    if v.key == notification.userInfo.key then
      v.name = notification.userInfo.name
      break
    end
  end
  self._themeFrame:FireEvent("ThemeNameChanged", notification.userInfo)
end

function DiyThemeDialog:OnDIYThemeDelete(notification)
  local index
  for i, v in ipairs(self._diyThemeList) do
    if v.key == notification.userInfo.key then
      index = i
      break
    end
  end
  if index then
    table.remove(self._diyThemeList, index)
    self._themeFrame:RemoveCellsAtIndex({index})
  end
  local length = #self._diyThemeList
  if notification.userInfo.key == self._themeInfo.key and 0 < length then
    self:RefreshThemeInfo(self._diyThemeList[1])
    self._themeFrame:ReloadAllCell()
  elseif length <= 0 then
    self:Destroy()
  end
end

function DiyThemeDialog:LoadLocalData()
  self._dialog = DialogManager.GetDialog("courtcabin.interactmodaldialog")
  local roomId = self._dialog:GetSelectRoomId()
  self._furnitureItemList = NekoData.BehaviorManager.BM_BagInfo:GetItemListWithBagType(BagTypeEnum.FURNITURE_BAG)
  self._allRoomInfo = NekoData.BehaviorManager.BM_Cabin:GetAllRoomInfo()
  for k, v in pairs(self._allRoomInfo) do
    if k ~= roomId then
      for furnitureItemKey, furnitureInfo in pairs(v.furnitures) do
        self._allRoomUsedFurnitures[furnitureItemKey] = true
      end
    end
  end
end

function DiyThemeDialog:RefreshName(protocol)
  if protocol.key == self._themeInfo.key then
    self._title:SetText(protocol.name)
  end
end

function DiyThemeDialog:Init(themeInfo)
  self:RefreshThemeInfo(themeInfo)
  self._diyThemeList = NekoData.BehaviorManager.BM_Cabin:GetThemeList()
  self._themeFrame:ReloadAllCell()
end

function DiyThemeDialog:RefreshThemeInfo(themeInfo)
  if not self._themeInfo or self._themeInfo.key ~= themeInfo.key then
    while self._canUseItemIdList[#self._canUseItemIdList] do
      table.remove(self._canUseItemIdList, #self._canUseItemIdList)
    end
    while self._canUseItemPosList[#self._canUseItemPosList] do
      table.remove(self._canUseItemPosList, #self._canUseItemPosList)
    end
    while self._themeDataList[#self._themeDataList] do
      table.remove(self._themeDataList, #self._themeDataList)
    end
    self._themeInfo = themeInfo
    self._title:SetText(themeInfo.name)
    local notUsedMap, usedNum = self:GetNotUsedFurnituresAndUsedNum()
    local themeDataMap = {}
    local comfort = 0
    for i, v in ipairs(themeInfo.furniturePositions) do
      local furnitureItem = FurnitureItem.Create(v.itemId)
      local type = furnitureItem:GetType()
      if not themeDataMap[type] then
        themeDataMap[type] = {
          type = type,
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
        table.remove(notUsedMap[v.itemId], #notUsedMap[v.itemId])
        table.insert(self._canUseItemIdList, v.itemId)
        table.insert(self._canUseItemPosList, v.point)
      end
      table.insert(themeDataMap[type].furnitureList, {item = furnitureItem, disable = disable})
    end
    local imgRecord = NekoData.BehaviorManager.BM_Cabin:GetComfortImageRecord()
    if imgRecord then
      self._comfortIcon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    else
      LogError("comfort imgRecord is nil.")
    end
    self._comfortNumTxt:SetText(comfort)
    for k, v in pairs(themeDataMap) do
      table.insert(self._themeDataList, v)
    end
    table.sort(self._themeDataList, function(a, b)
      return a.type < b.type
    end)
    self._frame:ReloadAllCell()
    self._frame:MoveToTop()
  end
end

function DiyThemeDialog:GetNotUsedFurnituresAndUsedNum()
  local usedNum = {}
  local notUsedMap = {}
  for i, v in ipairs(self._furnitureItemList) do
    local itemKey = v:GetKey()
    local type = v:GetType()
    local itemId = v:GetID()
    if not notUsedMap[itemId] then
      notUsedMap[itemId] = {}
    end
    if not self._allRoomUsedFurnitures[itemKey] then
      table.insert(notUsedMap[itemId], itemKey)
    end
    if not usedNum[type] then
      usedNum[type] = 1
    else
      usedNum[type] = usedNum[type] + 1
    end
  end
  return notUsedMap, usedNum
end

function DiyThemeDialog:OnBackBtnClicked()
  self:Destroy()
end

function DiyThemeDialog:OnUseBtnClicked()
  LuaNotificationCenter.PostNotification(Common.n_UseTheme, self, {
    tag = "DIY",
    id = self._themeInfo.key,
    itemIdList = self:GetCanUseFurnitureKeyList(),
    positionList = self._canUseItemPosList
  })
  self:Destroy()
end

function DiyThemeDialog:GetCanUseFurnitureKeyList()
  local keyList = {}
  local notUsedMap, usedNum = self:GetNotUsedFurnituresAndUsedNum()
  for i, v in ipairs(self._canUseItemIdList) do
    local key = notUsedMap[v][#notUsedMap[v]]
    if key then
      table.remove(notUsedMap[v], #notUsedMap[v])
      table.insert(keyList, {id = v, key = key})
    end
  end
  return keyList
end

function DiyThemeDialog:OnCurPosChange(frame, proportion)
  if frame == self._frame then
    local total = self._frame:GetTotalLength()
    if total > self._height then
      self._scrollBar:SetActive(true)
      self._scrollBar:SetScrollSize(self._height / total)
      self._scrollBar:SetScrollValue(proportion)
    else
      self._scrollBar:SetActive(false)
    end
  end
end

function DiyThemeDialog:NumberOfCell(frame)
  if frame == self._frame then
    return #self._themeDataList
  else
    return #self._diyThemeList
  end
end

function DiyThemeDialog:CellAtIndex(frame, index)
  if frame == self._frame then
    return "courtcabin.recommendthemeframecell"
  else
    return "courtcabin.diythemecell"
  end
end

function DiyThemeDialog:DataAtIndex(frame, index)
  if frame == self._frame then
    return self._themeDataList[index]
  else
    return self._diyThemeList[index]
  end
end

function DiyThemeDialog:SelectTheme(themeInfo)
  self:RefreshThemeInfo(themeInfo)
  self._themeFrame:FireEvent("SelectTheme", themeInfo.key)
end

return DiyThemeDialog
