-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/comfortshowdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local BagTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.bagtypes")
local CDormComfortLv = (BeanManager.GetTableByName)("courtyard.cdormcomfortlv")
local CDormComfortRate = (BeanManager.GetTableByName)("courtyard.cdormcomfortrate")
local Rate = (CDormComfortRate:GetRecorder(1)).rate
local TopToBottom = 3
local ComfortMaxLv = #CDormComfortLv:GetAllIds()
local ComfortShowDialog = class("ComfortShowDialog", Dialog)
ComfortShowDialog.AssetBundleName = "ui/layouts.yard"
ComfortShowDialog.AssetName = "HouseComfortable"
ComfortShowDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ComfortShowDialog
  ((ComfortShowDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._comfortLvRecorderList = {}
  self._comfortLv = 0
  self._furnitureDataList = {}
end

ComfortShowDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : ComfortMaxLv, TopToBottom, TableFrame, CDormComfortLv, _ENV
  self._back = self:GetChild("Back")
  self._curComfortTxt = self:GetChild("Back/Top/Detail/Back/Num")
  self._curEnergySpeedTxt = self:GetChild("Back/Top/Detail/Recover/Num")
  self._curAddRelationTxt = self:GetChild("Back/Top/Detail/Relation/Num")
  self._comfortLvProgress = self:GetChild("Back/Top/Progress/Line")
  self._comfortLvProgressGrey = self:GetChild("Back/Top/Progress/LineGrey")
  self._comfortLvDots = {}
  for i = 1, ComfortMaxLv do
    do
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

      (self._comfortLvDots)[i] = {}
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._comfortLvDots)[i]).dot = self:GetChild("Back/Top/Progress/Dot" .. i)
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._comfortLvDots)[i]).num = self:GetChild("Back/Top/Progress/Dot" .. i .. "/Num")
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._comfortLvDots)[i]).grey = self:GetChild("Back/Top/Progress/Dot" .. i .. "/DotGrey")
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._comfortLvDots)[i]).bright = self:GetChild("Back/Top/Progress/Dot" .. i .. "/Dot")
      -- DECOMPILER ERROR at PC76: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._comfortLvDots)[i]).select = self:GetChild("Back/Top/Progress/Dot" .. i .. "/Select")
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._comfortLvDots)[i]).selectNum = self:GetChild("Back/Top/Progress/Dot" .. i .. "/NumSelect")
      ;
      (((self._comfortLvDots)[i]).dot):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnDotClicked(i)
  end
)
    end
  end
  self._scrollBar = self:GetChild("Back/Down/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(TopToBottom)
  self._panel = self:GetChild("Back/Down/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnBackClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._width = (self._panel):GetRectSize()
  local allIds = CDormComfortLv:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDormComfortLv:GetRecorder(allIds[i])
    ;
    (table.insert)(self._comfortLvRecorderList, recorder)
  end
end

ComfortShowDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

ComfortShowDialog.Init = function(self, roomId, curRoomUsedFurnitures)
  -- function num : 0_3 , upvalues : _ENV, BagTypeEnum
  self._roomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetRoomInfoById(roomId)
  if curRoomUsedFurnitures then
    local totalComfort = 0
    local furnitureItemList = {}
    for k,v in pairs(curRoomUsedFurnitures) do
      if v then
        local item = ((NekoData.BehaviorManager).BM_BagInfo):GetItemWithBagType(BagTypeEnum.FURNITURE_BAG, k)
        totalComfort = totalComfort + item:GetComfort()
        ;
        (table.insert)(self._furnitureDataList, item)
      end
    end
    ;
    (self._curComfortTxt):SetText(totalComfort)
    ;
    (self._comfortLvProgress):SetFillAmount((totalComfort) / ((self._comfortLvRecorderList)[#self._comfortLvRecorderList]).confort)
    local level = 0
    for i,v in ipairs(self._comfortLvRecorderList) do
      if v.confort <= totalComfort then
        level = v.id
      else
        break
      end
    end
    do
      do
        self._comfortLv = level
        ;
        (self._curComfortTxt):SetText((self._roomInfo).comfort)
        ;
        (self._comfortLvProgress):SetFillAmount((self._roomInfo).comfort / ((self._comfortLvRecorderList)[#self._comfortLvRecorderList]).confort)
        for k,v in pairs((self._roomInfo).furnitures) do
          (table.insert)(self._furnitureDataList, ((NekoData.BehaviorManager).BM_BagInfo):GetItemWithBagType(BagTypeEnum.FURNITURE_BAG, v.key))
        end
        self._comfortLv = (self._roomInfo).comfortLv
        for i,v in ipairs(self._comfortLvDots) do
          (v.bright):SetActive(i <= self._comfortLv)
          ;
          (v.grey):SetActive(self._comfortLv < i)
          ;
          (v.num):SetText(((self._comfortLvRecorderList)[i]).confort)
          ;
          (v.selectNum):SetText(((self._comfortLvRecorderList)[i]).confort)
        end
        self:RefreshUpPanel()
        ;
        (self._frame):ReloadAllCell()
        ;
        (self._frame):MoveToTop()
        -- DECOMPILER ERROR: 3 unprocessed JMP targets
      end
    end
  end
end

ComfortShowDialog.RefreshUpPanel = function(self)
  -- function num : 0_4 , upvalues : _ENV, Rate
  for i,v in ipairs(self._comfortLvDots) do
    (v.select):SetActive(i == self._comfortLv)
    ;
    (v.selectNum):SetActive(i == self._comfortLv)
    ;
    (v.num):SetActive(i ~= self._comfortLv)
  end
  local recorder = (self._comfortLvRecorderList)[self._comfortLv]
  local energySpeed = recorder.emotion * 60 / Rate / DataCommon.RoleEnergyRatio
  local relationSpeed = recorder.likability * 60 / Rate
  local integer, decimal = (math.modf)(energySpeed)
  if decimal <= 0 then
    (self._curEnergySpeedTxt):SetText("+" .. integer)
  else
    (self._curEnergySpeedTxt):SetText("+" .. energySpeed)
  end
  integer = (math.modf)(relationSpeed)
  if decimal <= 0 then
    (self._curAddRelationTxt):SetText("+" .. integer)
  else
    (self._curAddRelationTxt):SetText("+" .. relationSpeed)
  end
  -- DECOMPILER ERROR: 8 unprocessed JMP targets
end

ComfortShowDialog.OnDotClicked = function(self, lv)
  -- function num : 0_5
  if self._comfortLv ~= lv then
    self._comfortLv = lv
    self:RefreshUpPanel()
  end
end

ComfortShowDialog.OnBackClicked = function(self)
  -- function num : 0_6
end

ComfortShowDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

ComfortShowDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_8
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

ComfortShowDialog.NumberOfCell = function(self, frame)
  -- function num : 0_9
  return #self._furnitureDataList
end

ComfortShowDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_10
  return "courtcabin.furniturecomfortcell"
end

ComfortShowDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  return (self._furnitureDataList)[index]
end

return ComfortShowDialog

