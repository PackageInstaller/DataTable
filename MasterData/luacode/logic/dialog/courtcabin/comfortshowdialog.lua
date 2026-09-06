local TableFrame = require("framework.ui.frame.table.tableframe")
local BagTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.bagtypes")
local CDormComfortLv = BeanManager.GetTableByName("courtyard.cdormcomfortlv")
local CDormComfortRate = BeanManager.GetTableByName("courtyard.cdormcomfortrate")
local Rate = CDormComfortRate:GetRecorder(1).rate
local TopToBottom = 3
local ComfortMaxLv = #CDormComfortLv:GetAllIds()
local ComfortShowDialog = class("ComfortShowDialog", Dialog)
ComfortShowDialog.AssetBundleName = "ui/layouts.yard"
ComfortShowDialog.AssetName = "HouseComfortable"

function ComfortShowDialog:Ctor(...)
  ComfortShowDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._comfortLvRecorderList = {}
  self._comfortLv = 0
  self._furnitureDataList = {}
end

function ComfortShowDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._curComfortTxt = self:GetChild("Back/Top/Detail/Back/Num")
  self._curEnergySpeedTxt = self:GetChild("Back/Top/Detail/Recover/Num")
  self._curAddRelationTxt = self:GetChild("Back/Top/Detail/Relation/Num")
  self._comfortLvProgress = self:GetChild("Back/Top/Progress/Line")
  self._comfortLvProgressGrey = self:GetChild("Back/Top/Progress/LineGrey")
  self._comfortLvDots = {}
  for i = 1, ComfortMaxLv do
    self._comfortLvDots[i] = {}
    self._comfortLvDots[i].dot = self:GetChild("Back/Top/Progress/Dot" .. i)
    self._comfortLvDots[i].num = self:GetChild("Back/Top/Progress/Dot" .. i .. "/Num")
    self._comfortLvDots[i].grey = self:GetChild("Back/Top/Progress/Dot" .. i .. "/DotGrey")
    self._comfortLvDots[i].bright = self:GetChild("Back/Top/Progress/Dot" .. i .. "/Dot")
    self._comfortLvDots[i].select = self:GetChild("Back/Top/Progress/Dot" .. i .. "/Select")
    self._comfortLvDots[i].selectNum = self:GetChild("Back/Top/Progress/Dot" .. i .. "/NumSelect")
    self._comfortLvDots[i].dot:Subscribe_PointerClickEvent(function()
      self:OnDotClicked(i)
    end)
  end
  self._scrollBar = self:GetChild("Back/Down/Scrollbar")
  self._scrollBar:SetScrollDirection(TopToBottom)
  self._panel = self:GetChild("Back/Down/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._back:Subscribe_PointerClickEvent(self.OnBackClicked, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._width, self._height = self._panel:GetRectSize()
  local allIds = CDormComfortLv:GetAllIds()
  for i = 1, #allIds do
    local recorder = CDormComfortLv:GetRecorder(allIds[i])
    table.insert(self._comfortLvRecorderList, recorder)
  end
end

function ComfortShowDialog:OnDestroy()
  self._frame:Destroy()
end

function ComfortShowDialog:Init(roomId, curRoomUsedFurnitures)
  self._roomInfo = NekoData.BehaviorManager.BM_Cabin:GetRoomInfoById(roomId)
  if curRoomUsedFurnitures then
    local totalComfort = 0
    local furnitureItemList = {}
    for k, v in pairs(curRoomUsedFurnitures) do
      if v then
        local item = NekoData.BehaviorManager.BM_BagInfo:GetItemWithBagType(BagTypeEnum.FURNITURE_BAG, k)
        totalComfort = totalComfort + item:GetComfort()
        table.insert(self._furnitureDataList, item)
      end
    end
    self._curComfortTxt:SetText(totalComfort)
    self._comfortLvProgress:SetFillAmount(totalComfort / self._comfortLvRecorderList[#self._comfortLvRecorderList].confort)
    local level = 0
    for i, v in ipairs(self._comfortLvRecorderList) do
      if totalComfort >= v.confort then
        level = v.id
      else
        break
      end
    end
    self._comfortLv = level
  else
    self._curComfortTxt:SetText(self._roomInfo.comfort)
    self._comfortLvProgress:SetFillAmount(self._roomInfo.comfort / self._comfortLvRecorderList[#self._comfortLvRecorderList].confort)
    for k, v in pairs(self._roomInfo.furnitures) do
      table.insert(self._furnitureDataList, NekoData.BehaviorManager.BM_BagInfo:GetItemWithBagType(BagTypeEnum.FURNITURE_BAG, v.key))
    end
    self._comfortLv = self._roomInfo.comfortLv
  end
  for i, v in ipairs(self._comfortLvDots) do
    v.bright:SetActive(i <= self._comfortLv)
    v.grey:SetActive(i > self._comfortLv)
    v.num:SetText(self._comfortLvRecorderList[i].confort)
    v.selectNum:SetText(self._comfortLvRecorderList[i].confort)
  end
  self:RefreshUpPanel()
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function ComfortShowDialog:RefreshUpPanel()
  for i, v in ipairs(self._comfortLvDots) do
    v.select:SetActive(i == self._comfortLv)
    v.selectNum:SetActive(i == self._comfortLv)
    v.num:SetActive(i ~= self._comfortLv)
  end
  local recorder = self._comfortLvRecorderList[self._comfortLv]
  local energySpeed = recorder.emotion * 60 / Rate / DataCommon.RoleEnergyRatio
  local relationSpeed = recorder.likability * 60 / Rate
  local integer, decimal = math.modf(energySpeed)
  if decimal <= 0.0 then
    self._curEnergySpeedTxt:SetText("+" .. integer)
  else
    self._curEnergySpeedTxt:SetText("+" .. energySpeed)
  end
  integer, decimal = math.modf(relationSpeed)
  if decimal <= 0.0 then
    self._curAddRelationTxt:SetText("+" .. integer)
  else
    self._curAddRelationTxt:SetText("+" .. relationSpeed)
  end
end

function ComfortShowDialog:OnDotClicked(lv)
  if self._comfortLv ~= lv then
    self._comfortLv = lv
    self:RefreshUpPanel()
  end
end

function ComfortShowDialog:OnBackClicked()
end

function ComfortShowDialog:OnBackBtnClicked()
  self:Destroy()
end

function ComfortShowDialog:OnCurPosChange(frame, proportion)
  local total = self._frame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function ComfortShowDialog:NumberOfCell(frame)
  return #self._furnitureDataList
end

function ComfortShowDialog:CellAtIndex(frame, index)
  return "courtcabin.furniturecomfortcell"
end

function ComfortShowDialog:DataAtIndex(frame, index)
  return self._furnitureDataList[index]
end

return ComfortShowDialog
