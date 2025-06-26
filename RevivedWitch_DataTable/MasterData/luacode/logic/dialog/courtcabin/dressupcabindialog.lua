-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/dressupcabindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local TabFrame = require("framework.ui.frame.tab.tabframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CDormFurnitureType = (BeanManager.GetTableByName)("courtyard.cdormfurnituretype")
local CFurnitureItem = (BeanManager.GetTableByName)("item.cfurnitureitem")
local CDormFurnitureGroup = (BeanManager.GetTableByName)("courtyard.cdormfurnituregroup")
local CDormComfortLv = (BeanManager.GetTableByName)("courtyard.cdormcomfortlv")
local CDormComfortRate = (BeanManager.GetTableByName)("courtyard.cdormcomfortrate")
local Rate = (CDormComfortRate:GetRecorder(1)).rate
local BagTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.bagtypes")
local DIYThemeMaxNum = 10
local BtnChangeOffset = 105
local DressUpCabinDialog = class("DressUpCabinDialog", Dialog)
DressUpCabinDialog.AssetBundleName = "ui/layouts.yard"
DressUpCabinDialog.AssetName = "HouseDecorate"
DressUpCabinDialog.SpecialTabType = {Theme = -1, All = 0}
local specialTabType = DressUpCabinDialog.SpecialTabType
DressUpCabinDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DressUpCabinDialog
  ((DressUpCabinDialog.super).Ctor)(self, ...)
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

DressUpCabinDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, TabFrame, _ENV, CDormComfortLv
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._selectPanel = self:GetChild("Panel")
  self._select = self:GetChild("Panel/Select")
  self._yesBtn = self:GetChild("Panel/Select/YesBtn")
  self._noBtn = self:GetChild("Panel/Select/NoBtn")
  self._anchorX = (self._select):GetSize()
  self._yesBtn_anchorY = (self._yesBtn):GetYPosition()
  self._noBtn_anchorY = (self._noBtn):GetYPosition()
  ;
  (self._selectPanel):SetActive(false)
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
  self._tabBtnFrame = (TableFrame.Create)(self._tabBtnPanel, self, R4_PC27, true)
  self._tabFrame = (TabFrame.Create)(self._tabPanel, self)
  -- DECOMPILER ERROR at PC108: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, R4_PC27)
  -- DECOMPILER ERROR at PC113: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClick, R4_PC27)
  -- DECOMPILER ERROR at PC118: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._comfortShowBtn):Subscribe_PointerClickEvent(self.OnComfortShowBtnClick, R4_PC27)
  -- DECOMPILER ERROR at PC123: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._clearBtn):Subscribe_PointerClickEvent(self.OnClearBtnClick, R4_PC27)
  -- DECOMPILER ERROR at PC128: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._cancleBtn):Subscribe_PointerClickEvent(self.OnCancleBtnClick, R4_PC27)
  -- DECOMPILER ERROR at PC133: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._saveBtn):Subscribe_PointerClickEvent(self.OnSaveBtnClick, R4_PC27)
  -- DECOMPILER ERROR at PC138: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._yesBtn):Subscribe_PointerClickEvent(self.OnYesBtnClick, R4_PC27)
  -- DECOMPILER ERROR at PC143: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._noBtn):Subscribe_PointerClickEvent(self.OnNoBtnClick, R4_PC27)
  -- DECOMPILER ERROR at PC148: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self._storeBtn):Subscribe_PointerClickEvent(self.OnStoreBtnClick, R4_PC27)
  -- DECOMPILER ERROR at PC154: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC155: Overwrote pending register: R4 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnItemAdd, R4_PC27, nil)
  -- DECOMPILER ERROR at PC162: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC163: Overwrote pending register: R4 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCabin, R4_PC27, nil)
  -- DECOMPILER ERROR at PC170: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC171: Overwrote pending register: R4 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCabin, R4_PC27, nil)
  -- DECOMPILER ERROR at PC178: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC179: Overwrote pending register: R4 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAddDIYTheme, R4_PC27, nil)
  -- DECOMPILER ERROR at PC186: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC187: Overwrote pending register: R4 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDIYThemeNameChanged, R4_PC27, nil)
  -- DECOMPILER ERROR at PC194: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC195: Overwrote pending register: R4 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDIYThemeDelete, R4_PC27, nil)
  -- DECOMPILER ERROR at PC202: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC203: Overwrote pending register: R4 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUseTheme, R4_PC27, nil)
  -- DECOMPILER ERROR at PC210: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC211: Overwrote pending register: R4 in 'AssignReg'

  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSelectFurniture, R4_PC27, nil)
  ;
  (self:GetRootWindow()):PlayAnimation("HouseDecorateShow")
  -- DECOMPILER ERROR at PC223: Overwrote pending register: R4 in 'AssignReg'

  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnStateExit, R4_PC27)
  local imgRecord = ((NekoData.BehaviorManager).BM_Cabin):GetComfortImageRecord()
  -- DECOMPILER ERROR at PC234: Overwrote pending register: R4 in 'AssignReg'

  if imgRecord then
    (self._comfortIcon):SetSprite(R4_PC27, imgRecord.assetName)
  else
    LogError("comfort imgRecord is nil.")
  end
  self._comfortLvRecorderList = {}
  local allIds = CDormComfortLv:GetAllIds()
  -- DECOMPILER ERROR at PC247: Overwrote pending register: R4 in 'AssignReg'

  for i = 1, R4_PC27 do
    local recorder = CDormComfortLv:GetRecorder(allIds[i])
    ;
    (table.insert)(self._comfortLvRecorderList, recorder)
  end
end

DressUpCabinDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._tabBtnFrame):Destroy()
  ;
  (self._tabFrame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("fastmenu.fastmenudialog")
  ;
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  ;
  (DialogManager.DestroySingletonDialog)("courtcabin.comfortshowdialog")
  ;
  (DialogManager.DestroySingletonDialog)("courtcabin.adddiythemedialog")
  ;
  (DialogManager.DestroySingletonDialog)("courtcabin.recommendthemedialog")
  ;
  (DialogManager.DestroySingletonDialog)("courtcabin.diythemedialog")
end

DressUpCabinDialog.OnRefreshCabin = function(self)
  -- function num : 0_3 , upvalues : _ENV, BagTypeEnum
  self._furnitureItemList = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListWithBagType(BagTypeEnum.FURNITURE_BAG)
  self._allRoomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetAllRoomInfo()
  self._roomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetRoomInfoById(self._roomId)
  for k,v in pairs(self._allRoomUsedFurnitures) do
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

    (self._allRoomUsedFurnitures)[k] = nil
  end
  for k,v in pairs(self._curRoomUsedFurnitures) do
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R6 in 'UnsetPending'

    (self._curRoomUsedFurnitures)[k] = nil
  end
  for k,v in pairs(self._allRoomInfo) do
    for furnitureItemKey,furnitureInfo in pairs(v.furnitures) do
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R11 in 'UnsetPending'

      (self._allRoomUsedFurnitures)[furnitureItemKey] = true
    end
  end
  for k,v in pairs((self._roomInfo).furnitures) do
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R6 in 'UnsetPending'

    (self._curRoomUsedFurnitures)[k] = true
  end
  self:RefreshTabDataMap()
end

DressUpCabinDialog.OnAddDIYTheme = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV, specialTabType, DIYThemeMaxNum
  (table.insert)((self._tabDataMap)[specialTabType.Theme], #(self._tabDataMap)[specialTabType.Theme], {tag = "DIY", themeInfo = (notification.userInfo).theme})
  if DIYThemeMaxNum <= #(self._tabDataMap)[specialTabType.Theme] - 1 then
    (table.remove)((self._tabDataMap)[specialTabType.Theme], #(self._tabDataMap)[specialTabType.Theme])
  end
  local tabCell = (self._tabFrame):GetCellAtIndex(specialTabType.Theme)
  tabCell:RefreshTabCell({data = (self._tabDataMap)[specialTabType.Theme], tabId = specialTabType.Theme}, true)
end

DressUpCabinDialog.OnDIYThemeNameChanged = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV, specialTabType
  for i,v in ipairs((self._tabDataMap)[specialTabType.Theme]) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

    if v.themeInfo and (v.themeInfo).key == (notification.userInfo).key then
      (v.themeInfo).name = (notification.userInfo).name
      break
    end
  end
  do
    local tabCell = (self._tabFrame):GetCellAtIndex(specialTabType.Theme)
    tabCell:RefreshTabCell({data = (self._tabDataMap)[specialTabType.Theme], tabId = specialTabType.Theme}, true)
  end
end

DressUpCabinDialog.OnDIYThemeDelete = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV, specialTabType
  local index = nil
  for i,v in ipairs((self._tabDataMap)[specialTabType.Theme]) do
    if v.themeInfo and (v.themeInfo).key == (notification.userInfo).key then
      index = i
      break
    end
  end
  do
    if index then
      (table.remove)((self._tabDataMap)[specialTabType.Theme], index)
      if not (((self._tabDataMap)[specialTabType.Theme])[#(self._tabDataMap)[specialTabType.Theme]]).addDiyThemeBtn then
        (table.insert)((self._tabDataMap)[0], {addDiyThemeBtn = true})
      end
      local tabCell = (self._tabFrame):GetCellAtIndex(specialTabType.Theme)
      tabCell:RefreshTabCell({data = (self._tabDataMap)[specialTabType.Theme], tabId = specialTabType.Theme}, true)
    end
  end
end

DressUpCabinDialog.OnUseTheme = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV
  for k,v in pairs(self._curRoomUsedFurnitures) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R7 in 'UnsetPending'

    (self._curRoomUsedFurnitures)[k] = nil
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._allRoomUsedFurnitures)[k] = nil
  end
  for i,v in ipairs((notification.userInfo).itemIdList) do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R7 in 'UnsetPending'

    (self._curRoomUsedFurnitures)[v.key] = true
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._allRoomUsedFurnitures)[v.key] = true
  end
  self:RefreshTabDataMap()
  local hasFurnitures = false
  hasFurnitures = not (notification.userInfo).itemIdList or #(notification.userInfo).itemIdList > 0
  ;
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(hasFurnitures and 100198 or 100197)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

DressUpCabinDialog.Init = function(self, sceneController)
  -- function num : 0_8 , upvalues : _ENV, BagTypeEnum
  self._cabinSceneController = sceneController
  self._furnitureItemList = ((NekoData.BehaviorManager).BM_BagInfo):GetItemListWithBagType(BagTypeEnum.FURNITURE_BAG)
  self._allRoomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetAllRoomInfo()
  self._roomId = ((self._cabinSceneController)._interactDialog):GetSelectRoomId()
  self._roomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetRoomInfoById(self._roomId)
  for k,v in pairs(self._allRoomInfo) do
    for furnitureItemKey,furnitureInfo in pairs(v.furnitures) do
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R12 in 'UnsetPending'

      (self._allRoomUsedFurnitures)[furnitureItemKey] = true
    end
  end
  for k,v in pairs((self._roomInfo).furnitures) do
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R7 in 'UnsetPending'

    (self._curRoomUsedFurnitures)[k] = true
  end
  self:LoadLocalData()
end

DressUpCabinDialog.LoadLocalData = function(self)
  -- function num : 0_9 , upvalues : _ENV, specialTabType, CDormFurnitureType, CDormFurnitureGroup, DIYThemeMaxNum
  (table.insert)(self._tabBtnDataList, {
recorder = {id = specialTabType.Theme}
})
  ;
  (table.insert)(self._tabBtnDataList, {
recorder = {id = specialTabType.All}
})
  local tabBtnDataMap = {}
  local allIds = CDormFurnitureType:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDormFurnitureType:GetRecorder(allIds[i])
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self._cdormFurnitureTypeCfg)[recorder.id] = recorder
    tabBtnDataMap[recorder.id] = {recorder = recorder, usedNum = 0}
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self._tabDataMap)[recorder.id] = {}
  end
  local notUsedMap, usedNum = self:GetNotUsedFurnituresAndUsedNum()
  local statistics = {}
  local tempMap = {}
  for i,v in ipairs(self._furnitureItemList) do
    local itemKey = v:GetKey()
    local itemId = v:GetID()
    local type = v:GetType()
    if not tempMap[type] then
      tempMap[type] = {}
    end
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R15 in 'UnsetPending'

    if not (tempMap[type])[itemId] then
      (tempMap[type])[itemId] = {}
    end
    if (self._curRoomUsedFurnitures)[itemKey] then
      (table.insert)((tempMap[type])[itemId], 1, {item = v, using = true, key = itemKey})
    end
    local notUsedList = notUsedMap[itemId]
    if not statistics[itemId] then
      statistics[itemId] = true
      local num = #notUsedList
      local num1 = usedNum[type]
      local maxNum = self:GetUsedMaxNum(type)
      -- DECOMPILER ERROR at PC94: Confused about usage of register: R19 in 'UnsetPending'

      ;
      (tabBtnDataMap[type]).usedNum = num1
      -- DECOMPILER ERROR at PC108: Unhandled construct in 'MakeBoolean' P1

      if num1 < maxNum and num > 0 then
        (table.insert)((tempMap[type])[itemId], {item = notUsedList[num], enable = true, num = num})
      end
    end
    ;
    (table.insert)((tempMap[type])[itemId], {item = v, reachLimit = true, num = num})
  end
  -- DECOMPILER ERROR at PC124: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self._tabDataMap)[specialTabType.Theme] = {}
  allIds = CDormFurnitureGroup:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDormFurnitureGroup:GetRecorder(allIds[i])
    if recorder.showornot == 1 then
      (table.insert)((self._tabDataMap)[specialTabType.Theme], {tag = "Recommend", recorder = recorder})
    end
  end
  local diyThemeList = ((NekoData.BehaviorManager).BM_Cabin):GetThemeList()
  for i,v in ipairs(diyThemeList) do
    (table.insert)((self._tabDataMap)[specialTabType.Theme], {tag = "DIY", themeInfo = v})
  end
  if #(self._tabDataMap)[specialTabType.Theme] < DIYThemeMaxNum then
    (table.insert)((self._tabDataMap)[specialTabType.Theme], {addDiyThemeBtn = true})
  end
  local usingFurnitureList = {}
  local enableFurnitureList = {}
  local reachLimitFurnitureList = {}
  local list = {}
  for type,itemIdInfo in pairs(tempMap) do
    list[type] = {}
    for itemId,info in pairs(itemIdInfo) do
      if info[1] then
        (table.insert)(list[type], {comfort = ((info[1]).item):GetComfort(), id = itemId, list = info})
      end
    end
  end
  for type,info in pairs(list) do
    (table.sort)(info, function(a, b)
    -- function num : 0_9_0
    local _a = a.comfort
    local _b = b.comfort
    if _b < _a then
      return true
    else
      if b.id >= a.id then
        do return _a ~= _b end
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
)
  end
  local map = {}
  local reachLimitMap = {}
  for type,info in pairs(list) do
    for i,v in ipairs(info) do
      for index,itemInfo in ipairs(v.list) do
        if itemInfo.using then
          if not map[type] then
            map[type] = {}
          end
          ;
          (table.insert)(map[type], itemInfo)
          ;
          (table.insert)(usingFurnitureList, itemInfo)
        else
          -- DECOMPILER ERROR at PC272: Unhandled construct in 'MakeBoolean' P1

          if itemInfo.reachLimit and itemInfo.num > 0 then
            if not reachLimitMap[type] then
              reachLimitMap[type] = {}
            end
            ;
            (table.insert)(reachLimitMap[type], itemInfo)
            ;
            (table.insert)(reachLimitFurnitureList, itemInfo)
          end
        end
        ;
        (table.insert)((self._tabDataMap)[type], itemInfo)
        if itemInfo.enable then
          (table.insert)(enableFurnitureList, itemInfo)
        end
      end
    end
  end
  for k,v in pairs(map) do
    for i,itemInfo in ipairs(v) do
      (table.insert)((self._tabDataMap)[k], itemInfo)
    end
  end
  for k,v in pairs(reachLimitMap) do
    for i,itemInfo in ipairs(v) do
      (table.insert)((self._tabDataMap)[k], itemInfo)
    end
  end
  for k,v in pairs(tabBtnDataMap) do
    (table.insert)(self._tabBtnDataList, v)
  end
  ;
  (table.sort)(usingFurnitureList, function(a, b)
    -- function num : 0_9_1
    do return (b.item):GetID() < (a.item):GetID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(enableFurnitureList, function(a, b)
    -- function num : 0_9_2
    do return (b.item):GetID() < (a.item):GetID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC364: Confused about usage of register: R14 in 'UnsetPending'

  ;
  (self._tabDataMap)[specialTabType.All] = {}
  for i,v in ipairs(usingFurnitureList) do
    (table.insert)((self._tabDataMap)[specialTabType.All], v)
  end
  for i,v in ipairs(enableFurnitureList) do
    (table.insert)((self._tabDataMap)[specialTabType.All], v)
  end
  for i,v in ipairs(reachLimitFurnitureList) do
    (table.insert)((self._tabDataMap)[specialTabType.All], v)
  end
  ;
  (self._tabBtnFrame):ReloadAllCell()
  self:SetSelectTab((((self._tabBtnDataList)[2]).recorder).id)
  self:RefreshComfortAndRelation()
end

DressUpCabinDialog.RefreshComfortAndRelation = function(self)
  -- function num : 0_10 , upvalues : _ENV, BagTypeEnum, Rate
  local totalComfort = 0
  local furnitureItemList = {}
  for k,v in pairs(self._curRoomUsedFurnitures) do
    if v then
      local item = ((NekoData.BehaviorManager).BM_BagInfo):GetItemWithBagType(BagTypeEnum.FURNITURE_BAG, k)
      totalComfort = totalComfort + item:GetComfort()
    end
  end
  ;
  (self._comfortTxt):SetText(totalComfort)
  local level = 0
  for i,v in ipairs(self._comfortLvRecorderList) do
    if v.confort <= totalComfort then
      level = v.id
    else
      break
    end
  end
  do
    local recorder = (self._comfortLvRecorderList)[level]
    local energySpeed = recorder.emotion / DataCommon.RoleEnergyRatio * (60 / Rate)
    local integer, decimal = (math.modf)(energySpeed)
    if decimal <= 0 then
      (self._energySpeedTxt):SetText(integer .. "/h")
    else
      ;
      (self._energySpeedTxt):SetText("+" .. energySpeed .. "/h")
    end
    integer = (math.modf)(recorder.likability * (60 / Rate))
    if decimal <= 0 then
      (self._addRelationTxt):SetText(integer .. "/h")
    else
      ;
      (self._addRelationTxt):SetText(recorder.likability * (60 / Rate) .. "/h")
    end
  end
end

DressUpCabinDialog.GetUsedMaxNum = function(self, type)
  -- function num : 0_11
  return ((self._cdormFurnitureTypeCfg)[type]).num
end

DressUpCabinDialog.GetNotUsedFurnituresAndUsedNum = function(self)
  -- function num : 0_12 , upvalues : _ENV
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
      (table.insert)(notUsedMap[itemId], v)
    end
    if not usedNum[type] then
      usedNum[type] = 0
    end
    if (self._curRoomUsedFurnitures)[itemKey] then
      usedNum[type] = usedNum[type] + 1
    end
  end
  return notUsedMap, usedNum
end

DressUpCabinDialog.OnItemAdd = function(self, notification)
  -- function num : 0_13 , upvalues : BagTypeEnum
  if (notification.userInfo).bagType == BagTypeEnum.FURNITURE_BAG then
  end
end

DressUpCabinDialog.RefreshSelectState = function(self, posMin, posMax, pos, arriveTop)
  -- function num : 0_14 , upvalues : UIManager, _ENV, BtnChangeOffset
  local posX1, posY1 = (UIManager.ScreenPointToLocalPointInRectangle)((self._selectPanel)._uiObject, (UIManager.WorldToScreenPointInMargin)("DormMain", posMin.x, posMin.y, posMin.z))
  local posX2, posY2 = (UIManager.ScreenPointToLocalPointInRectangle)((self._selectPanel)._uiObject, (UIManager.WorldToScreenPointInMargin)("DormMain", posMax.x, posMax.y, posMax.z))
  local width = (math.abs)(posX2 - posX1)
  local height = (math.abs)(posY2 - posY1)
  local posX, posY = (UIManager.ScreenPointToLocalPointInRectangle)((self._selectPanel)._uiObject, (UIManager.WorldToScreenPointInMargin)("DormMain", pos.x, pos.y, pos.z))
  ;
  (self._select):SetSize(self._anchorX, width, self._anchorY, height)
  ;
  (self._select):SetAnchoredPosition(posX, posY)
  if self._lastArriveTop ~= arriveTop then
    if arriveTop then
      (self._yesBtn):SetYPosition(self._yesBtn_anchorY, self._yesBtn_offsetY - BtnChangeOffset)
      ;
      (self._noBtn):SetYPosition(self._noBtn_anchorY, self._noBtn_offsetY - BtnChangeOffset)
    else
      ;
      (self._yesBtn):SetYPosition(self._yesBtn_anchorY, self._yesBtn_offsetY)
      ;
      (self._noBtn):SetYPosition(self._noBtn_anchorY, self._noBtn_offsetY)
    end
  end
end

DressUpCabinDialog.OnSelectFurniture = function(self, notification)
  -- function num : 0_15 , upvalues : _ENV, BagTypeEnum
  if (notification.userInfo).layerId == 0 then
    (self._selectPanel):SetActive(false)
    self._selectFurnitureItem = nil
  else
    ;
    (self._selectPanel):SetActive(true)
    self._selectFurnitureItem = ((NekoData.BehaviorManager).BM_BagInfo):GetItemWithBagType(BagTypeEnum.FURNITURE_BAG, (notification.userInfo).key)
  end
end

DressUpCabinDialog.SetSelectTab = function(self, type)
  -- function num : 0_16
  if self._selectTabId ~= type then
    self._selectTabId = type
    ;
    (self._tabBtnFrame):FireEvent("SetSelectTab", self._selectTabId)
    local tabCell = (self._tabFrame):ToPage(self._selectTabId)
    tabCell:RefreshTabCell({data = (self._tabDataMap)[self._selectTabId], tabId = self._selectTabId}, false, true)
  end
end

DressUpCabinDialog.UseFurniture = function(self, data)
  -- function num : 0_17 , upvalues : _ENV
  local type = (data.item):GetType()
  local id = (data.item):GetID()
  local list = (self._tabDataMap)[type]
  local useFurniture = nil
  for i,v in ipairs(list) do
    if v.enable and (v.item):GetID() == id then
      local key = (v.item):GetKey()
      useFurniture = v
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (self._allRoomUsedFurnitures)[key] = true
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (self._curRoomUsedFurnitures)[key] = true
      break
    end
  end
  do
    self:RefreshTabDataMap()
    if useFurniture then
      local layerId = (useFurniture.item):GetLayerId()
      local key = (useFurniture.item):GetKey()
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_LoadFurniture, self, {layerId = layerId, key = key, id = (useFurniture.item):GetID()})
      if type ~= 1 and type ~= 2 then
        (LuaNotificationCenter.PostNotification)(Common.n_SelectFurniture, self, {layerId = layerId, key = key})
      end
    end
  end
end

DressUpCabinDialog.UnloadFurniture = function(self, data)
  -- function num : 0_18 , upvalues : _ENV
  local key = (data.item):GetKey()
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._allRoomUsedFurnitures)[key] = false
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._curRoomUsedFurnitures)[key] = false
  self:RefreshTabDataMap()
  if self._selectFurnitureItem and key == (self._selectFurnitureItem):GetKey() then
    (LuaNotificationCenter.PostNotification)(Common.n_SelectFurniture, self, {layerId = 0, key = 0})
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_UnLoadFurniture, self, {layerId = (data.item):GetLayerId(), key = key})
end

DressUpCabinDialog.RefreshTabDataMap = function(self)
  -- function num : 0_19 , upvalues : _ENV, specialTabType
  while (self._tabBtnDataList)[#self._tabBtnDataList] do
    (table.remove)(self._tabBtnDataList, #self._tabBtnDataList)
  end
  for k,v in pairs(self._tabDataMap) do
    while k ~= specialTabType.Theme and v[#v] do
      (table.remove)(v, #v)
    end
  end
  ;
  (table.insert)(self._tabBtnDataList, {
recorder = {id = specialTabType.Theme}
})
  ;
  (table.insert)(self._tabBtnDataList, {
recorder = {id = specialTabType.All}
})
  local tabBtnDataMap = {}
  for k,v in pairs(self._cdormFurnitureTypeCfg) do
    tabBtnDataMap[v.id] = {recorder = v, usedNum = 0}
  end
  local notUsedMap, usedNum = self:GetNotUsedFurnituresAndUsedNum()
  local statistics = {}
  local tempMap = {}
  for i,v in ipairs(self._furnitureItemList) do
    local itemKey = v:GetKey()
    local itemId = v:GetID()
    local type = v:GetType()
    if not tempMap[type] then
      tempMap[type] = {}
    end
    -- DECOMPILER ERROR at PC87: Confused about usage of register: R14 in 'UnsetPending'

    if not (tempMap[type])[itemId] then
      (tempMap[type])[itemId] = {}
    end
    if (self._curRoomUsedFurnitures)[itemKey] then
      (table.insert)((tempMap[type])[itemId], 1, {item = v, using = true, key = itemKey})
    end
    local notUsedList = notUsedMap[itemId]
    if not statistics[itemId] then
      statistics[itemId] = true
      local num = #notUsedList
      local num1 = usedNum[type]
      local maxNum = self:GetUsedMaxNum(type)
      -- DECOMPILER ERROR at PC113: Confused about usage of register: R18 in 'UnsetPending'

      ;
      (tabBtnDataMap[type]).usedNum = num1
      -- DECOMPILER ERROR at PC127: Unhandled construct in 'MakeBoolean' P1

      if num1 < maxNum and num > 0 then
        (table.insert)((tempMap[type])[itemId], {item = notUsedList[num], enable = true, num = num})
      end
    end
    ;
    (table.insert)((tempMap[type])[itemId], {item = v, reachLimit = true, num = num})
  end
  local usingFurnitureList = {}
  local enableFurnitureList = {}
  local reachLimitFurnitureList = {}
  local list = {}
  for type,itemIdInfo in pairs(tempMap) do
    list[type] = {}
    for itemId,info in pairs(itemIdInfo) do
      if info[1] then
        (table.insert)(list[type], {comfort = ((info[1]).item):GetComfort(), id = itemId, list = info})
      end
    end
  end
  for type,info in pairs(list) do
    (table.sort)(info, function(a, b)
    -- function num : 0_19_0
    local _a = a.comfort
    local _b = b.comfort
    if _b < _a then
      return true
    else
      if b.id >= a.id then
        do return _a ~= _b end
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
)
  end
  local map = {}
  local reachLimitMap = {}
  for type,info in pairs(list) do
    for i,v in ipairs(info) do
      for index,itemInfo in ipairs(v.list) do
        if itemInfo.using then
          if not map[type] then
            map[type] = {}
          end
          ;
          (table.insert)(map[type], itemInfo)
          ;
          (table.insert)(usingFurnitureList, itemInfo)
        else
          -- DECOMPILER ERROR at PC227: Unhandled construct in 'MakeBoolean' P1

          if itemInfo.reachLimit and itemInfo.num > 0 then
            if not reachLimitMap[type] then
              reachLimitMap[type] = {}
            end
            ;
            (table.insert)(reachLimitMap[type], itemInfo)
            ;
            (table.insert)(reachLimitFurnitureList, itemInfo)
          end
        end
        ;
        (table.insert)((self._tabDataMap)[type], itemInfo)
        if itemInfo.enable then
          (table.insert)(enableFurnitureList, itemInfo)
        end
      end
    end
  end
  for k,v in pairs(map) do
    for i,itemInfo in ipairs(v) do
      (table.insert)((self._tabDataMap)[k], itemInfo)
    end
  end
  for k,v in pairs(reachLimitMap) do
    for i,itemInfo in ipairs(v) do
      (table.insert)((self._tabDataMap)[k], itemInfo)
    end
  end
  for k,v in pairs(tabBtnDataMap) do
    (table.insert)(self._tabBtnDataList, v)
  end
  ;
  (table.sort)(usingFurnitureList, function(a, b)
    -- function num : 0_19_1
    do return (b.item):GetID() < (a.item):GetID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(enableFurnitureList, function(a, b)
    -- function num : 0_19_2
    do return (b.item):GetID() < (a.item):GetID() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC319: Confused about usage of register: R12 in 'UnsetPending'

  ;
  (self._tabDataMap)[specialTabType.All] = {}
  for i,v in ipairs(usingFurnitureList) do
    (table.insert)((self._tabDataMap)[specialTabType.All], v)
  end
  for i,v in ipairs(enableFurnitureList) do
    (table.insert)((self._tabDataMap)[specialTabType.All], v)
  end
  for i,v in ipairs(reachLimitFurnitureList) do
    (table.insert)((self._tabDataMap)[specialTabType.All], v)
  end
  ;
  (self._tabBtnFrame):ReloadAllCell()
  for k,v in pairs(self._tabDataMap) do
    local tabCell = (self._tabFrame):GetCellAtIndex(k)
    tabCell:RefreshTabCell({data = (self._tabDataMap)[k], tabId = k}, true)
  end
  self:RefreshComfortAndRelation()
end

DressUpCabinDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_20
  if frame == self._tabBtnFrame then
    return #self._tabBtnDataList
  end
end

DressUpCabinDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_21
  if frame == self._tabBtnFrame then
    return "courtcabin.tabbtncell"
  else
    return "courtcabin.furnituretabcell"
  end
end

DressUpCabinDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_22
  if frame == self._tabBtnFrame then
    return (self._tabBtnDataList)[index]
  end
end

DressUpCabinDialog.OnComfortShowBtnClick = function(self)
  -- function num : 0_23 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("courtcabin.comfortshowdialog")):Init(self._roomId, self._curRoomUsedFurnitures)
end

DressUpCabinDialog.OnClearBtnClick = function(self)
  -- function num : 0_24 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(43, nil, function()
    -- function num : 0_24_0 , upvalues : _ENV, self
    for k,v in pairs(self._curRoomUsedFurnitures) do
      -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

      (self._allRoomUsedFurnitures)[k] = false
      -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._curRoomUsedFurnitures)[k] = false
    end
    self:RefreshTabDataMap()
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_ClearAllFurnitures, self, nil)
  end
, {}, nil, {})
end

DressUpCabinDialog.OnCancleBtnClick = function(self)
  -- function num : 0_25 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(44, nil, function()
    -- function num : 0_25_0 , upvalues : _ENV, self
    for k,v in pairs(self._allRoomUsedFurnitures) do
      -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

      (self._allRoomUsedFurnitures)[k] = false
    end
    for k,v in pairs(self._curRoomUsedFurnitures) do
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R5 in 'UnsetPending'

      (self._curRoomUsedFurnitures)[k] = false
    end
    for k,v in pairs(self._allRoomInfo) do
      for furnitureItemKey,furnitureInfo in pairs(v.furnitures) do
        -- DECOMPILER ERROR at PC25: Confused about usage of register: R10 in 'UnsetPending'

        (self._allRoomUsedFurnitures)[furnitureItemKey] = true
      end
    end
    for k,v in pairs((self._roomInfo).furnitures) do
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'

      (self._curRoomUsedFurnitures)[k] = true
    end
    self:RefreshTabDataMap()
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_ReturnInitState, self, nil)
  end
, {}, nil, {})
end

DressUpCabinDialog.OnSaveBtnClick = function(self)
  -- function num : 0_26 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(45, nil, function()
    -- function num : 0_26_0 , upvalues : self, _ENV
    local overlap = false
    local map = ((self._cabinSceneController)._furnitures)[self._roomId]
    for k,v in pairs(map) do
      if (self._cabinSceneController):CheckOverlap(k) then
        overlap = true
        break
      end
    end
    do
      if overlap then
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100170)
      else
        local cplaceFurniture = (LuaNetManager.CreateProtocol)("protocol.yard.cplacefurniture")
        local list = {}
        cplaceFurniture.floorId = self._roomId
        local map = ((self._cabinSceneController)._furnitures)[self._roomId]
        for k,v in pairs(map) do
          for key,furniture in pairs(v) do
            local pos = furniture:GetLeftDownGridPos()
            local furnitureBean = (LuaNetManager.CreateBean)("protocol.yard.furniture")
            furnitureBean.key = (furniture:GetItem()):GetKey()
            local pointBean = (LuaNetManager.CreateBean)("protocol.yard.point")
            pointBean.x = pos.x
            pointBean.y = pos.y
            furnitureBean.point = pointBean
            ;
            (table.insert)(list, furnitureBean)
          end
        end
        cplaceFurniture.furniture = list
        cplaceFurniture:Send()
        ;
        (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
      end
    end
  end
, {}, nil, {})
end

DressUpCabinDialog.OnYesBtnClick = function(self)
  -- function num : 0_27 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_SelectFurniture, self, {layerId = 0, key = 0})
end

DressUpCabinDialog.OnNoBtnClick = function(self)
  -- function num : 0_28
  self:UnloadFurniture({item = self._selectFurnitureItem})
end

DressUpCabinDialog.OnStoreBtnClick = function(self)
  -- function num : 0_29
end

DressUpCabinDialog.OnBackBtnClicked = function(self)
  -- function num : 0_30 , upvalues : _ENV
  if (self._cabinSceneController):IsModify() then
    ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(45, nil, function()
    -- function num : 0_30_0 , upvalues : self, _ENV
    local overlap = false
    local map = ((self._cabinSceneController)._furnitures)[self._roomId]
    for k,v in pairs(map) do
      if (self._cabinSceneController):CheckOverlap(k) then
        overlap = true
        break
      end
    end
    do
      if overlap then
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100170)
      else
        local cplaceFurniture = (LuaNetManager.CreateProtocol)("protocol.yard.cplacefurniture")
        local list = {}
        cplaceFurniture.floorId = self._roomId
        local map = ((self._cabinSceneController)._furnitures)[self._roomId]
        for k,v in pairs(map) do
          for key,furniture in pairs(v) do
            local pos = furniture:GetLeftDownGridPos()
            local furnitureBean = (LuaNetManager.CreateBean)("protocol.yard.furniture")
            furnitureBean.key = (furniture:GetItem()):GetKey()
            local pointBean = (LuaNetManager.CreateBean)("protocol.yard.point")
            pointBean.x = pos.x
            pointBean.y = pos.y
            furnitureBean.point = pointBean
            ;
            (table.insert)(list, furnitureBean)
          end
        end
        cplaceFurniture.furniture = list
        cplaceFurniture:Send()
        ;
        (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
        self._willBack = true
      end
    end
  end
, {}, function()
    -- function num : 0_30_1 , upvalues : _ENV, self
    (LuaNotificationCenter.PostNotification)(Common.n_ReturnInitState, self, nil)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_ExitDressUpMode, self, nil)
    self:PlayExitAnimation()
  end
, {})
  else
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_ReturnInitState, self, nil)
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_ExitDressUpMode, self, nil)
    self:PlayExitAnimation()
  end
end

DressUpCabinDialog.PlayExitAnimation = function(self)
  -- function num : 0_31 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
  ;
  (self:GetRootWindow()):PlayAnimation("HouseDecorateHide")
end

DressUpCabinDialog.OnStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_32
  if stateName == "HouseDecorateHide" then
    self:Destroy()
  end
end

DressUpCabinDialog.OnMenuBtnClick = function(self)
  -- function num : 0_33 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return DressUpCabinDialog

