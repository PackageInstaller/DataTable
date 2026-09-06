local UIManager = CS.PixelNeko.UI.UIManager
local TabFrame = require("framework.ui.frame.tab.tabframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CDormFurnitureType = BeanManager.GetTableByName("courtyard.cdormfurnituretype")
local CFurnitureItem = BeanManager.GetTableByName("item.cfurnitureitem")
local CDormFurnitureGroup = BeanManager.GetTableByName("courtyard.cdormfurnituregroup")
local CDormComfortLv = BeanManager.GetTableByName("courtyard.cdormcomfortlv")
local CDormComfortRate = BeanManager.GetTableByName("courtyard.cdormcomfortrate")
local Rate = CDormComfortRate:GetRecorder(1).rate
local BagTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.bagtypes")
local DIYThemeMaxNum = 10
local BtnChangeOffset = 105
local DressUpCabinDialog = class("DressUpCabinDialog", Dialog)
DressUpCabinDialog.AssetBundleName = "ui/layouts.yard"
DressUpCabinDialog.AssetName = "HouseDecorate"
DressUpCabinDialog.SpecialTabType = {Theme = -1, All = 0}
local specialTabType = DressUpCabinDialog.SpecialTabType

function DressUpCabinDialog:Ctor(...)
  DressUpCabinDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._cabinSceneController = nil
  self._cdormFurnitureTypeCfg = {}
  self._tabBtnDataList = {}
  self._tabDataMap = {}
  self._selectTabId = nil
  self._furnitureItemList = nil
  self._allRoomUsedFurnitures = {}
  self._curRoomUsedFurnitures = {}
end

function DressUpCabinDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._selectPanel = self:GetChild("Panel")
  self._select = self:GetChild("Panel/Select")
  self._yesBtn = self:GetChild("Panel/Select/YesBtn")
  self._noBtn = self:GetChild("Panel/Select/NoBtn")
  self._anchorX, self._offsetX, self._anchorY, self._offsetY = self._select:GetSize()
  self._yesBtn_anchorY, self._yesBtn_offsetY = self._yesBtn:GetYPosition()
  self._noBtn_anchorY, self._noBtn_offsetY = self._noBtn:GetYPosition()
  self._selectPanel:SetActive(false)
  self._comfortIcon = self:GetChild("Top/Comfortable/Image")
  self._comfortTxt = self:GetChild("Top/Comfortable/Num")
  self._comfortShowBtn = self:GetChild("Top/Comfortable/Ibtn")
  self._energyIcon = self:GetChild("Top/Mood/Mood")
  self._energySpeedTxt = self:GetChild("Top/Mood/Num")
  self._addRelationTxt = self:GetChild("Top/Relation/Num")
  self._clearBtn = self:GetChild("DeleteBtn")
  self._cancleBtn = self:GetChild("RefreshBtn")
  self._saveBtn = self:GetChild("SaveBtn")
  self._storeBtn = self:GetChild("Down/ShopBtn")
  self._tabBtnPanel = self:GetChild("Down/BtnFrame")
  self._tabPanel = self:GetChild("Down/ItemFrame")
  self._tabBtnFrame = TableFrame.Create(self._tabBtnPanel, self, false, true)
  self._tabFrame = TabFrame.Create(self._tabPanel, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClick, self)
  self._comfortShowBtn:Subscribe_PointerClickEvent(self.OnComfortShowBtnClick, self)
  self._clearBtn:Subscribe_PointerClickEvent(self.OnClearBtnClick, self)
  self._cancleBtn:Subscribe_PointerClickEvent(self.OnCancleBtnClick, self)
  self._saveBtn:Subscribe_PointerClickEvent(self.OnSaveBtnClick, self)
  self._yesBtn:Subscribe_PointerClickEvent(self.OnYesBtnClick, self)
  self._noBtn:Subscribe_PointerClickEvent(self.OnNoBtnClick, self)
  self._storeBtn:Subscribe_PointerClickEvent(self.OnStoreBtnClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnItemAdd, Common.n_ItemAdd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCabin, Common.n_RefreshCabin, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCabin, Common.n_RefreshRoomFurnitures, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAddDIYTheme, Common.n_AddDIYTheme, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDIYThemeNameChanged, Common.n_DIYThemeNameChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDIYThemeDelete, Common.n_DIYThemeDelete, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUseTheme, Common.n_UseTheme, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSelectFurniture, Common.n_SelectFurniture, nil)
  self:GetRootWindow():PlayAnimation("HouseDecorateShow")
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnStateExit, self)
  local imgRecord = NekoData.BehaviorManager.BM_Cabin:GetComfortImageRecord()
  if imgRecord then
    self._comfortIcon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  else
    LogError("comfort imgRecord is nil.")
  end
  self._comfortLvRecorderList = {}
  local allIds = CDormComfortLv:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDormComfortLv:GetRecorder(allIds[i])
    table.insert(self._comfortLvRecorderList, recorder)
  end
end

function DressUpCabinDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._tabBtnFrame:Destroy()
  self._tabFrame:Destroy()
  DialogManager.DestroySingletonDialog("fastmenu.fastmenudialog")
  DialogManager.DestroySingletonDialog("guide.blockclickdialog")
  DialogManager.DestroySingletonDialog("courtcabin.comfortshowdialog")
  DialogManager.DestroySingletonDialog("courtcabin.adddiythemedialog")
  DialogManager.DestroySingletonDialog("courtcabin.recommendthemedialog")
  DialogManager.DestroySingletonDialog("courtcabin.diythemedialog")
end

function DressUpCabinDialog:OnRefreshCabin()
  self._furnitureItemList = NekoData.BehaviorManager.BM_BagInfo:GetItemListWithBagType(BagTypeEnum.FURNITURE_BAG)
  self._allRoomInfo = NekoData.BehaviorManager.BM_Cabin:GetAllRoomInfo()
  self._roomInfo = NekoData.BehaviorManager.BM_Cabin:GetRoomInfoById(self._roomId)
  for k, v in pairs(self._allRoomUsedFurnitures) do
    self._allRoomUsedFurnitures[k] = nil
  end
  for k, v in pairs(self._curRoomUsedFurnitures) do
    self._curRoomUsedFurnitures[k] = nil
  end
  for k, v in pairs(self._allRoomInfo) do
    for furnitureItemKey, furnitureInfo in pairs(v.furnitures) do
      self._allRoomUsedFurnitures[furnitureItemKey] = true
    end
  end
  for k, v in pairs(self._roomInfo.furnitures) do
    self._curRoomUsedFurnitures[k] = true
  end
  self:RefreshTabDataMap()
end

function DressUpCabinDialog:OnAddDIYTheme(notification)
  table.insert(self._tabDataMap[specialTabType.Theme], #self._tabDataMap[specialTabType.Theme], {
    tag = "DIY",
    themeInfo = notification.userInfo.theme
  })
  if #self._tabDataMap[specialTabType.Theme] - 1 >= DIYThemeMaxNum then
    table.remove(self._tabDataMap[specialTabType.Theme], #self._tabDataMap[specialTabType.Theme])
  end
  local tabCell = self._tabFrame:GetCellAtIndex(specialTabType.Theme)
  tabCell:RefreshTabCell({
    data = self._tabDataMap[specialTabType.Theme],
    tabId = specialTabType.Theme
  }, true)
end

function DressUpCabinDialog:OnDIYThemeNameChanged(notification)
  for i, v in ipairs(self._tabDataMap[specialTabType.Theme]) do
    if v.themeInfo and v.themeInfo.key == notification.userInfo.key then
      v.themeInfo.name = notification.userInfo.name
      break
    end
  end
  local tabCell = self._tabFrame:GetCellAtIndex(specialTabType.Theme)
  tabCell:RefreshTabCell({
    data = self._tabDataMap[specialTabType.Theme],
    tabId = specialTabType.Theme
  }, true)
end

function DressUpCabinDialog:OnDIYThemeDelete(notification)
  local index
  for i, v in ipairs(self._tabDataMap[specialTabType.Theme]) do
    if v.themeInfo and v.themeInfo.key == notification.userInfo.key then
      index = i
      break
    end
  end
  if index then
    table.remove(self._tabDataMap[specialTabType.Theme], index)
    if not self._tabDataMap[specialTabType.Theme][#self._tabDataMap[specialTabType.Theme]].addDiyThemeBtn then
      table.insert(self._tabDataMap[0], {addDiyThemeBtn = true})
    end
    local tabCell = self._tabFrame:GetCellAtIndex(specialTabType.Theme)
    tabCell:RefreshTabCell({
      data = self._tabDataMap[specialTabType.Theme],
      tabId = specialTabType.Theme
    }, true)
  end
end

function DressUpCabinDialog:OnUseTheme(notification)
  for k, v in pairs(self._curRoomUsedFurnitures) do
    self._curRoomUsedFurnitures[k] = nil
    self._allRoomUsedFurnitures[k] = nil
  end
  for i, v in ipairs(notification.userInfo.itemIdList) do
    self._curRoomUsedFurnitures[v.key] = true
    self._allRoomUsedFurnitures[v.key] = true
  end
  self:RefreshTabDataMap()
  local hasFurnitures = false
  if notification.userInfo.itemIdList then
    hasFurnitures = #notification.userInfo.itemIdList > 0
  end
  NekoData.BehaviorManager.BM_Message:SendMessageById(hasFurnitures and 100198 or 100197)
end

function DressUpCabinDialog:Init(sceneController)
  self._cabinSceneController = sceneController
  self._furnitureItemList = NekoData.BehaviorManager.BM_BagInfo:GetItemListWithBagType(BagTypeEnum.FURNITURE_BAG)
  self._allRoomInfo = NekoData.BehaviorManager.BM_Cabin:GetAllRoomInfo()
  self._roomId = self._cabinSceneController._interactDialog:GetSelectRoomId()
  self._roomInfo = NekoData.BehaviorManager.BM_Cabin:GetRoomInfoById(self._roomId)
  for k, v in pairs(self._allRoomInfo) do
    for furnitureItemKey, furnitureInfo in pairs(v.furnitures) do
      self._allRoomUsedFurnitures[furnitureItemKey] = true
    end
  end
  for k, v in pairs(self._roomInfo.furnitures) do
    self._curRoomUsedFurnitures[k] = true
  end
  self:LoadLocalData()
end

function DressUpCabinDialog:LoadLocalData()
  table.insert(self._tabBtnDataList, {
    recorder = {
      id = specialTabType.Theme
    }
  })
  table.insert(self._tabBtnDataList, {
    recorder = {
      id = specialTabType.All
    }
  })
  local tabBtnDataMap = {}
  local allIds = CDormFurnitureType:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDormFurnitureType:GetRecorder(allIds[i])
    self._cdormFurnitureTypeCfg[recorder.id] = recorder
    tabBtnDataMap[recorder.id] = {recorder = recorder, usedNum = 0}
    self._tabDataMap[recorder.id] = {}
  end
  local notUsedMap, usedNum = self:GetNotUsedFurnituresAndUsedNum()
  local statistics = {}
  local tempMap = {}
  for i, v in ipairs(self._furnitureItemList) do
    local itemKey = v:GetKey()
    local itemId = v:GetID()
    local type = v:GetType()
    if not tempMap[type] then
      tempMap[type] = {}
    end
    if not tempMap[type][itemId] then
      tempMap[type][itemId] = {}
    end
    if self._curRoomUsedFurnitures[itemKey] then
      table.insert(tempMap[type][itemId], 1, {
        item = v,
        using = true,
        key = itemKey
      })
    end
    local notUsedList = notUsedMap[itemId]
    if not statistics[itemId] then
      statistics[itemId] = true
      local num = #notUsedList
      local num1 = usedNum[type]
      local maxNum = self:GetUsedMaxNum(type)
      tabBtnDataMap[type].usedNum = num1
      if num1 < maxNum then
        if 0 < num then
          table.insert(tempMap[type][itemId], {
            item = notUsedList[num],
            enable = true,
            num = num
          })
        end
      else
        table.insert(tempMap[type][itemId], {
          item = v,
          reachLimit = true,
          num = num
        })
      end
    end
  end
  self._tabDataMap[specialTabType.Theme] = {}
  allIds = CDormFurnitureGroup:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDormFurnitureGroup:GetRecorder(allIds[i])
    if recorder.showornot == 1 then
      table.insert(self._tabDataMap[specialTabType.Theme], {tag = "Recommend", recorder = recorder})
    end
  end
  local diyThemeList = NekoData.BehaviorManager.BM_Cabin:GetThemeList()
  for i, v in ipairs(diyThemeList) do
    table.insert(self._tabDataMap[specialTabType.Theme], {tag = "DIY", themeInfo = v})
  end
  if #self._tabDataMap[specialTabType.Theme] < DIYThemeMaxNum then
    table.insert(self._tabDataMap[specialTabType.Theme], {addDiyThemeBtn = true})
  end
  local usingFurnitureList = {}
  local enableFurnitureList = {}
  local reachLimitFurnitureList = {}
  local list = {}
  for type, itemIdInfo in pairs(tempMap) do
    list[type] = {}
    for itemId, info in pairs(itemIdInfo) do
      if info[1] then
        table.insert(list[type], {
          comfort = info[1].item:GetComfort(),
          id = itemId,
          list = info
        })
      end
    end
  end
  for type, info in pairs(list) do
    table.sort(info, function(a, b)
      local _a = a.comfort
      local _b = b.comfort
      if _a > _b then
        return true
      elseif _a == _b then
        return a.id > b.id
      end
    end)
  end
  local map = {}
  local reachLimitMap = {}
  for type, info in pairs(list) do
    for i, v in ipairs(info) do
      for index, itemInfo in ipairs(v.list) do
        if itemInfo.using then
          if not map[type] then
            map[type] = {}
          end
          table.insert(map[type], itemInfo)
          table.insert(usingFurnitureList, itemInfo)
        elseif itemInfo.reachLimit then
          if 0 < itemInfo.num then
            if not reachLimitMap[type] then
              reachLimitMap[type] = {}
            end
            table.insert(reachLimitMap[type], itemInfo)
            table.insert(reachLimitFurnitureList, itemInfo)
          end
        else
          table.insert(self._tabDataMap[type], itemInfo)
          if itemInfo.enable then
            table.insert(enableFurnitureList, itemInfo)
          end
        end
      end
    end
  end
  for k, v in pairs(map) do
    for i, itemInfo in ipairs(v) do
      table.insert(self._tabDataMap[k], itemInfo)
    end
  end
  for k, v in pairs(reachLimitMap) do
    for i, itemInfo in ipairs(v) do
      table.insert(self._tabDataMap[k], itemInfo)
    end
  end
  for k, v in pairs(tabBtnDataMap) do
    table.insert(self._tabBtnDataList, v)
  end
  table.sort(usingFurnitureList, function(a, b)
    return a.item:GetID() > b.item:GetID()
  end)
  table.sort(enableFurnitureList, function(a, b)
    return a.item:GetID() > b.item:GetID()
  end)
  self._tabDataMap[specialTabType.All] = {}
  for i, v in ipairs(usingFurnitureList) do
    table.insert(self._tabDataMap[specialTabType.All], v)
  end
  for i, v in ipairs(enableFurnitureList) do
    table.insert(self._tabDataMap[specialTabType.All], v)
  end
  for i, v in ipairs(reachLimitFurnitureList) do
    table.insert(self._tabDataMap[specialTabType.All], v)
  end
  self._tabBtnFrame:ReloadAllCell()
  self:SetSelectTab(self._tabBtnDataList[2].recorder.id)
  self:RefreshComfortAndRelation()
end

function DressUpCabinDialog:RefreshComfortAndRelation()
  local totalComfort = 0
  local furnitureItemList = {}
  for k, v in pairs(self._curRoomUsedFurnitures) do
    if v then
      local item = NekoData.BehaviorManager.BM_BagInfo:GetItemWithBagType(BagTypeEnum.FURNITURE_BAG, k)
      totalComfort = totalComfort + item:GetComfort()
    end
  end
  self._comfortTxt:SetText(totalComfort)
  local level = 0
  for i, v in ipairs(self._comfortLvRecorderList) do
    if totalComfort >= v.confort then
      level = v.id
    else
      break
    end
  end
  local recorder = self._comfortLvRecorderList[level]
  local energySpeed = recorder.emotion / DataCommon.RoleEnergyRatio * (60 / Rate)
  local integer, decimal = math.modf(energySpeed)
  if decimal <= 0.0 then
    self._energySpeedTxt:SetText(integer .. "/h")
  else
    self._energySpeedTxt:SetText("+" .. energySpeed .. "/h")
  end
  integer, decimal = math.modf(recorder.likability * (60 / Rate))
  if decimal <= 0.0 then
    self._addRelationTxt:SetText(integer .. "/h")
  else
    self._addRelationTxt:SetText(recorder.likability * (60 / Rate) .. "/h")
  end
end

function DressUpCabinDialog:GetUsedMaxNum(type)
  return self._cdormFurnitureTypeCfg[type].num
end

function DressUpCabinDialog:GetNotUsedFurnituresAndUsedNum()
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
      table.insert(notUsedMap[itemId], v)
    end
    if not usedNum[type] then
      usedNum[type] = 0
    end
    if self._curRoomUsedFurnitures[itemKey] then
      usedNum[type] = usedNum[type] + 1
    end
  end
  return notUsedMap, usedNum
end

function DressUpCabinDialog:OnItemAdd(notification)
  if notification.userInfo.bagType == BagTypeEnum.FURNITURE_BAG then
  end
end

function DressUpCabinDialog:RefreshSelectState(posMin, posMax, pos, arriveTop)
  local posX1, posY1 = UIManager.ScreenPointToLocalPointInRectangle(self._selectPanel._uiObject, UIManager.WorldToScreenPointInMargin("DormMain", posMin.x, posMin.y, posMin.z))
  local posX2, posY2 = UIManager.ScreenPointToLocalPointInRectangle(self._selectPanel._uiObject, UIManager.WorldToScreenPointInMargin("DormMain", posMax.x, posMax.y, posMax.z))
  local width = math.abs(posX2 - posX1)
  local height = math.abs(posY2 - posY1)
  local posX, posY = UIManager.ScreenPointToLocalPointInRectangle(self._selectPanel._uiObject, UIManager.WorldToScreenPointInMargin("DormMain", pos.x, pos.y, pos.z))
  self._select:SetSize(self._anchorX, width, self._anchorY, height)
  self._select:SetAnchoredPosition(posX, posY)
  if self._lastArriveTop ~= arriveTop then
    if arriveTop then
      self._yesBtn:SetYPosition(self._yesBtn_anchorY, self._yesBtn_offsetY - BtnChangeOffset)
      self._noBtn:SetYPosition(self._noBtn_anchorY, self._noBtn_offsetY - BtnChangeOffset)
    else
      self._yesBtn:SetYPosition(self._yesBtn_anchorY, self._yesBtn_offsetY)
      self._noBtn:SetYPosition(self._noBtn_anchorY, self._noBtn_offsetY)
    end
  end
end

function DressUpCabinDialog:OnSelectFurniture(notification)
  if notification.userInfo.layerId == 0 then
    self._selectPanel:SetActive(false)
    self._selectFurnitureItem = nil
  else
    self._selectPanel:SetActive(true)
    self._selectFurnitureItem = NekoData.BehaviorManager.BM_BagInfo:GetItemWithBagType(BagTypeEnum.FURNITURE_BAG, notification.userInfo.key)
  end
end

function DressUpCabinDialog:SetSelectTab(type)
  if self._selectTabId ~= type then
    self._selectTabId = type
    self._tabBtnFrame:FireEvent("SetSelectTab", self._selectTabId)
    local tabCell = self._tabFrame:ToPage(self._selectTabId)
    tabCell:RefreshTabCell({
      data = self._tabDataMap[self._selectTabId],
      tabId = self._selectTabId
    }, false, true)
  end
end

function DressUpCabinDialog:UseFurniture(data)
  local type = data.item:GetType()
  local id = data.item:GetID()
  local list = self._tabDataMap[type]
  local useFurniture
  for i, v in ipairs(list) do
    if v.enable and v.item:GetID() == id then
      local key = v.item:GetKey()
      useFurniture = v
      self._allRoomUsedFurnitures[key] = true
      self._curRoomUsedFurnitures[key] = true
      break
    end
  end
  self:RefreshTabDataMap()
  if useFurniture then
    local layerId = useFurniture.item:GetLayerId()
    local key = useFurniture.item:GetKey()
    LuaNotificationCenter.PostNotification(Common.n_LoadFurniture, self, {
      layerId = layerId,
      key = key,
      id = useFurniture.item:GetID()
    })
    if type ~= 1 and type ~= 2 then
      LuaNotificationCenter.PostNotification(Common.n_SelectFurniture, self, {layerId = layerId, key = key})
    end
  end
end

function DressUpCabinDialog:UnloadFurniture(data)
  local key = data.item:GetKey()
  self._allRoomUsedFurnitures[key] = false
  self._curRoomUsedFurnitures[key] = false
  self:RefreshTabDataMap()
  if self._selectFurnitureItem and key == self._selectFurnitureItem:GetKey() then
    LuaNotificationCenter.PostNotification(Common.n_SelectFurniture, self, {layerId = 0, key = 0})
  end
  LuaNotificationCenter.PostNotification(Common.n_UnLoadFurniture, self, {
    layerId = data.item:GetLayerId(),
    key = key
  })
end

function DressUpCabinDialog:RefreshTabDataMap()
  while self._tabBtnDataList[#self._tabBtnDataList] do
    table.remove(self._tabBtnDataList, #self._tabBtnDataList)
  end
  for k, v in pairs(self._tabDataMap) do
    if k ~= specialTabType.Theme then
      while v[#v] do
        table.remove(v, #v)
      end
    end
  end
  table.insert(self._tabBtnDataList, {
    recorder = {
      id = specialTabType.Theme
    }
  })
  table.insert(self._tabBtnDataList, {
    recorder = {
      id = specialTabType.All
    }
  })
  local tabBtnDataMap = {}
  for k, v in pairs(self._cdormFurnitureTypeCfg) do
    tabBtnDataMap[v.id] = {recorder = v, usedNum = 0}
  end
  local notUsedMap, usedNum = self:GetNotUsedFurnituresAndUsedNum()
  local statistics = {}
  local tempMap = {}
  for i, v in ipairs(self._furnitureItemList) do
    local itemKey = v:GetKey()
    local itemId = v:GetID()
    local type = v:GetType()
    if not tempMap[type] then
      tempMap[type] = {}
    end
    if not tempMap[type][itemId] then
      tempMap[type][itemId] = {}
    end
    if self._curRoomUsedFurnitures[itemKey] then
      table.insert(tempMap[type][itemId], 1, {
        item = v,
        using = true,
        key = itemKey
      })
    end
    local notUsedList = notUsedMap[itemId]
    if not statistics[itemId] then
      statistics[itemId] = true
      local num = #notUsedList
      local num1 = usedNum[type]
      local maxNum = self:GetUsedMaxNum(type)
      tabBtnDataMap[type].usedNum = num1
      if num1 < maxNum then
        if 0 < num then
          table.insert(tempMap[type][itemId], {
            item = notUsedList[num],
            enable = true,
            num = num
          })
        end
      else
        table.insert(tempMap[type][itemId], {
          item = v,
          reachLimit = true,
          num = num
        })
      end
    end
  end
  local usingFurnitureList = {}
  local enableFurnitureList = {}
  local reachLimitFurnitureList = {}
  local list = {}
  for type, itemIdInfo in pairs(tempMap) do
    list[type] = {}
    for itemId, info in pairs(itemIdInfo) do
      if info[1] then
        table.insert(list[type], {
          comfort = info[1].item:GetComfort(),
          id = itemId,
          list = info
        })
      end
    end
  end
  for type, info in pairs(list) do
    table.sort(info, function(a, b)
      local _a = a.comfort
      local _b = b.comfort
      if _a > _b then
        return true
      elseif _a == _b then
        return a.id > b.id
      end
    end)
  end
  local map = {}
  local reachLimitMap = {}
  for type, info in pairs(list) do
    for i, v in ipairs(info) do
      for index, itemInfo in ipairs(v.list) do
        if itemInfo.using then
          if not map[type] then
            map[type] = {}
          end
          table.insert(map[type], itemInfo)
          table.insert(usingFurnitureList, itemInfo)
        elseif itemInfo.reachLimit then
          if 0 < itemInfo.num then
            if not reachLimitMap[type] then
              reachLimitMap[type] = {}
            end
            table.insert(reachLimitMap[type], itemInfo)
            table.insert(reachLimitFurnitureList, itemInfo)
          end
        else
          table.insert(self._tabDataMap[type], itemInfo)
          if itemInfo.enable then
            table.insert(enableFurnitureList, itemInfo)
          end
        end
      end
    end
  end
  for k, v in pairs(map) do
    for i, itemInfo in ipairs(v) do
      table.insert(self._tabDataMap[k], itemInfo)
    end
  end
  for k, v in pairs(reachLimitMap) do
    for i, itemInfo in ipairs(v) do
      table.insert(self._tabDataMap[k], itemInfo)
    end
  end
  for k, v in pairs(tabBtnDataMap) do
    table.insert(self._tabBtnDataList, v)
  end
  table.sort(usingFurnitureList, function(a, b)
    return a.item:GetID() > b.item:GetID()
  end)
  table.sort(enableFurnitureList, function(a, b)
    return a.item:GetID() > b.item:GetID()
  end)
  self._tabDataMap[specialTabType.All] = {}
  for i, v in ipairs(usingFurnitureList) do
    table.insert(self._tabDataMap[specialTabType.All], v)
  end
  for i, v in ipairs(enableFurnitureList) do
    table.insert(self._tabDataMap[specialTabType.All], v)
  end
  for i, v in ipairs(reachLimitFurnitureList) do
    table.insert(self._tabDataMap[specialTabType.All], v)
  end
  self._tabBtnFrame:ReloadAllCell()
  for k, v in pairs(self._tabDataMap) do
    local tabCell = self._tabFrame:GetCellAtIndex(k)
    tabCell:RefreshTabCell({
      data = self._tabDataMap[k],
      tabId = k
    }, true)
  end
  self:RefreshComfortAndRelation()
end

function DressUpCabinDialog:NumberOfCell(frame, index)
  if frame == self._tabBtnFrame then
    return #self._tabBtnDataList
  end
end

function DressUpCabinDialog:CellAtIndex(frame, index)
  if frame == self._tabBtnFrame then
    return "courtcabin.tabbtncell"
  else
    return "courtcabin.furnituretabcell"
  end
end

function DressUpCabinDialog:DataAtIndex(frame, index)
  if frame == self._tabBtnFrame then
    return self._tabBtnDataList[index]
  end
end

function DressUpCabinDialog:OnComfortShowBtnClick()
  DialogManager.CreateSingletonDialog("courtcabin.comfortshowdialog"):Init(self._roomId, self._curRoomUsedFurnitures)
end

function DressUpCabinDialog:OnClearBtnClick()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(43, nil, function()
    for k, v in pairs(self._curRoomUsedFurnitures) do
      self._allRoomUsedFurnitures[k] = false
      self._curRoomUsedFurnitures[k] = false
    end
    self:RefreshTabDataMap()
    LuaNotificationCenter.PostNotification(Common.n_ClearAllFurnitures, self, nil)
  end, {}, nil, {})
end

function DressUpCabinDialog:OnCancleBtnClick()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(44, nil, function()
    for k, v in pairs(self._allRoomUsedFurnitures) do
      self._allRoomUsedFurnitures[k] = false
    end
    for k, v in pairs(self._curRoomUsedFurnitures) do
      self._curRoomUsedFurnitures[k] = false
    end
    for k, v in pairs(self._allRoomInfo) do
      for furnitureItemKey, furnitureInfo in pairs(v.furnitures) do
        self._allRoomUsedFurnitures[furnitureItemKey] = true
      end
    end
    for k, v in pairs(self._roomInfo.furnitures) do
      self._curRoomUsedFurnitures[k] = true
    end
    self:RefreshTabDataMap()
    LuaNotificationCenter.PostNotification(Common.n_ReturnInitState, self, nil)
  end, {}, nil, {})
end

function DressUpCabinDialog:OnSaveBtnClick()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(45, nil, function()
    local overlap = false
    local map = self._cabinSceneController._furnitures[self._roomId]
    for k, v in pairs(map) do
      if self._cabinSceneController:CheckOverlap(k) then
        overlap = true
        break
      end
    end
    if overlap then
      NekoData.BehaviorManager.BM_Message:SendMessageById(100170)
    else
      local cplaceFurniture = LuaNetManager.CreateProtocol("protocol.yard.cplacefurniture")
      local list = {}
      cplaceFurniture.floorId = self._roomId
      local map = self._cabinSceneController._furnitures[self._roomId]
      for k, v in pairs(map) do
        for key, furniture in pairs(v) do
          local pos = furniture:GetLeftDownGridPos()
          local furnitureBean = LuaNetManager.CreateBean("protocol.yard.furniture")
          furnitureBean.key = furniture:GetItem():GetKey()
          local pointBean = LuaNetManager.CreateBean("protocol.yard.point")
          pointBean.x = pos.x
          pointBean.y = pos.y
          furnitureBean.point = pointBean
          table.insert(list, furnitureBean)
        end
      end
      cplaceFurniture.furniture = list
      cplaceFurniture:Send()
      DialogManager.CreateSingletonDialog("guide.blockclickdialog")
    end
  end, {}, nil, {})
end

function DressUpCabinDialog:OnYesBtnClick()
  LuaNotificationCenter.PostNotification(Common.n_SelectFurniture, self, {layerId = 0, key = 0})
end

function DressUpCabinDialog:OnNoBtnClick()
  self:UnloadFurniture({
    item = self._selectFurnitureItem
  })
end

function DressUpCabinDialog:OnStoreBtnClick()
end

function DressUpCabinDialog:OnBackBtnClicked()
  if self._cabinSceneController:IsModify() then
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(45, nil, function()
      local overlap = false
      local map = self._cabinSceneController._furnitures[self._roomId]
      for k, v in pairs(map) do
        if self._cabinSceneController:CheckOverlap(k) then
          overlap = true
          break
        end
      end
      if overlap then
        NekoData.BehaviorManager.BM_Message:SendMessageById(100170)
      else
        local cplaceFurniture = LuaNetManager.CreateProtocol("protocol.yard.cplacefurniture")
        local list = {}
        cplaceFurniture.floorId = self._roomId
        local map = self._cabinSceneController._furnitures[self._roomId]
        for k, v in pairs(map) do
          for key, furniture in pairs(v) do
            local pos = furniture:GetLeftDownGridPos()
            local furnitureBean = LuaNetManager.CreateBean("protocol.yard.furniture")
            furnitureBean.key = furniture:GetItem():GetKey()
            local pointBean = LuaNetManager.CreateBean("protocol.yard.point")
            pointBean.x = pos.x
            pointBean.y = pos.y
            furnitureBean.point = pointBean
            table.insert(list, furnitureBean)
          end
        end
        cplaceFurniture.furniture = list
        cplaceFurniture:Send()
        DialogManager.CreateSingletonDialog("guide.blockclickdialog")
        self._willBack = true
      end
    end, {}, function()
      LuaNotificationCenter.PostNotification(Common.n_ReturnInitState, self, nil)
      LuaNotificationCenter.PostNotification(Common.n_ExitDressUpMode, self, nil)
      self:PlayExitAnimation()
    end, {})
  else
    LuaNotificationCenter.PostNotification(Common.n_ReturnInitState, self, nil)
    LuaNotificationCenter.PostNotification(Common.n_ExitDressUpMode, self, nil)
    self:PlayExitAnimation()
  end
end

function DressUpCabinDialog:PlayExitAnimation()
  DialogManager.CreateSingletonDialog("guide.blockclickdialog")
  self:GetRootWindow():PlayAnimation("HouseDecorateHide")
end

function DressUpCabinDialog:OnStateExit(handler, stateName, normalizedTime)
  if stateName == "HouseDecorateHide" then
    self:Destroy()
  end
end

function DressUpCabinDialog:OnMenuBtnClick()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return DressUpCabinDialog
