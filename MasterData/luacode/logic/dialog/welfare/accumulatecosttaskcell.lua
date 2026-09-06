local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CommonAwardsSatus = LuaNetManager.GetBeanDef("protocol.common.commonawardstatus")
local CAccumulatedCost = BeanManager.GetTableByName("welfare.caccumulatedcost")
local AccumulateCostTaskCell = class("AccumulateCostTaskCell", Dialog)
AccumulateCostTaskCell.AssetBundleName = "ui/layouts.welfare"
AccumulateCostTaskCell.AssetName = "ActivityConsumptionCell"

function AccumulateCostTaskCell:Ctor(...)
  AccumulateCostTaskCell.super.Ctor(self, ...)
end

function AccumulateCostTaskCell:OnCreate()
  self._title = self:GetChild("Title")
  self._txt = self:GetChild("Content")
  self._gotBtn = self:GetChild("DoneBtn")
  self._goBtn = self:GetChild("GoBtn")
  self._getBtn = self:GetChild("GetBtn")
  self._redDot = self:GetChild("RedDot")
  self._itemPanel = self:GetChild("Frame")
  self._itemFrame = TableFrame.Create(self._itemPanel, self, false, false)
  self._goBtn:Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  self:GetChild("DoneBtn/_Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2200))
  self:GetChild("GoBtn/_Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2202))
  self:GetChild("GetBtn/_Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2201))
end

function AccumulateCostTaskCell:OnDestroy()
  self._itemFrame:Destroy()
end

function AccumulateCostTaskCell:RefreshCell(data)
  local record = CAccumulatedCost:GetRecorder(data.id)
  if not record then
    LogErrorFormat("AccumulateCostTaskCell", "record with id %s is not exist in caccumulatedcost", data.id)
  end
  self._title:SetText(NekoData.BehaviorManager.BM_Message:GetString(2198, {
    record.costNum
  }))
  local cost = self._delegate._accumulateCost.consumption
  local need = 0
  if cost < record.costNum then
    need = record.costNum - cost
  end
  self._txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2199, {need}))
  if data.status == CommonAwardsSatus.LOCKED then
    self._goBtn:SetActive(true)
    self._getBtn:SetActive(false)
    self._gotBtn:SetActive(false)
  elseif data.status == CommonAwardsSatus.UNLOCKED then
    self._goBtn:SetActive(false)
    self._getBtn:SetActive(true)
    self._gotBtn:SetActive(false)
  elseif data.status == CommonAwardsSatus.FETCHED then
    self._goBtn:SetActive(false)
    self._getBtn:SetActive(false)
    self._gotBtn:SetActive(true)
  end
  self._redDot:SetActive(data.status == CommonAwardsSatus.UNLOCKED)
  
  local function tempFun(a, b)
    if a:GetPinJiID() > b:GetPinJiID() then
      return true
    elseif a:GetPinJiID() == b:GetPinJiID() and a:GetID() < b:GetID() then
      return true
    end
    return false
  end
  
  table.sort(self._cellData.awards, function(a, b)
    return tempFun(Item.Create(a.itemId), Item.Create(b.itemId))
  end)
  self._itemFrame:ReloadAllCell()
end

function AccumulateCostTaskCell:NumberOfCell(frame)
  return #self._cellData.awards
end

function AccumulateCostTaskCell:CellAtIndex(frame, index)
  return "welfare.accumulatecosttaskitemcell"
end

function AccumulateCostTaskCell:DataAtIndex(frame, index)
  return self._cellData.awards[index]
end

function AccumulateCostTaskCell:OnGetBtnClicked()
  if self._delegate._activityClose then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100498)
    return
  end
  if self._cellData.status == CommonAwardsSatus.UNLOCKED then
    local protocol = LuaNetManager.CreateProtocol("protocol.activity.cfetchconsumptionaward")
    protocol.taskId = self._cellData.id
    protocol:Send()
  end
end

function AccumulateCostTaskCell:OnGoBtnClicked()
  if self._delegate._activityClose then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100498)
    return
  end
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
  if protocol then
    protocol:Send()
  end
end

return AccumulateCostTaskCell
