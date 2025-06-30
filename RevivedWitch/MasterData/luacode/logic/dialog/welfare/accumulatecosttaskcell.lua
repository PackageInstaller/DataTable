-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/accumulatecosttaskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CommonAwardsSatus = (LuaNetManager.GetBeanDef)("protocol.common.commonawardstatus")
local CAccumulatedCost = (BeanManager.GetTableByName)("welfare.caccumulatedcost")
local AccumulateCostTaskCell = class("AccumulateCostTaskCell", Dialog)
AccumulateCostTaskCell.AssetBundleName = "ui/layouts.welfare"
AccumulateCostTaskCell.AssetName = "ActivityConsumptionCell"
AccumulateCostTaskCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AccumulateCostTaskCell
  ((AccumulateCostTaskCell.super).Ctor)(self, ...)
end

AccumulateCostTaskCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._title = self:GetChild("Title")
  self._txt = self:GetChild("Content")
  self._gotBtn = self:GetChild("DoneBtn")
  self._goBtn = self:GetChild("GoBtn")
  self._getBtn = self:GetChild("GetBtn")
  self._redDot = self:GetChild("RedDot")
  self._itemPanel = self:GetChild("Frame")
  self._itemFrame = (TableFrame.Create)(self._itemPanel, self, false, false)
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClicked, self)
  ;
  (self:GetChild("DoneBtn/_Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2200))
  ;
  (self:GetChild("GoBtn/_Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2202))
  ;
  (self:GetChild("GetBtn/_Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2201))
end

AccumulateCostTaskCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._itemFrame):Destroy()
end

AccumulateCostTaskCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAccumulatedCost, _ENV, CommonAwardsSatus, Item
  local record = CAccumulatedCost:GetRecorder(data.id)
  if not record then
    LogErrorFormat("AccumulateCostTaskCell", "record with id %s is not exist in caccumulatedcost", data.id)
  end
  ;
  (self._title):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2198, {record.costNum}))
  local cost = ((self._delegate)._accumulateCost).consumption
  local need = 0
  if cost < record.costNum then
    need = record.costNum - cost
  end
  ;
  (self._txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2199, {need}))
  if data.status == CommonAwardsSatus.LOCKED then
    (self._goBtn):SetActive(true)
    ;
    (self._getBtn):SetActive(false)
    ;
    (self._gotBtn):SetActive(false)
  else
    if data.status == CommonAwardsSatus.UNLOCKED then
      (self._goBtn):SetActive(false)
      ;
      (self._getBtn):SetActive(true)
      ;
      (self._gotBtn):SetActive(false)
    else
      if data.status == CommonAwardsSatus.FETCHED then
        (self._goBtn):SetActive(false)
        ;
        (self._getBtn):SetActive(false)
        ;
        (self._gotBtn):SetActive(true)
      end
    end
  end
  ;
  (self._redDot):SetActive(data.status == CommonAwardsSatus.UNLOCKED)
  local tempFun = function(a, b)
    -- function num : 0_3_0
    if b:GetPinJiID() < a:GetPinJiID() then
      return true
    else
      if a:GetPinJiID() == b:GetPinJiID() and a:GetID() < b:GetID() then
        return true
      end
    end
    return false
  end

  ;
  (table.sort)((self._cellData).awards, function(a, b)
    -- function num : 0_3_1 , upvalues : tempFun, Item
    return tempFun((Item.Create)(a.itemId), (Item.Create)(b.itemId))
  end
)
  ;
  (self._itemFrame):ReloadAllCell()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

AccumulateCostTaskCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #(self._cellData).awards
end

AccumulateCostTaskCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "welfare.accumulatecosttaskitemcell"
end

AccumulateCostTaskCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return ((self._cellData).awards)[index]
end

AccumulateCostTaskCell.OnGetBtnClicked = function(self)
  -- function num : 0_7 , upvalues : _ENV, CommonAwardsSatus
  if (self._delegate)._activityClose then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100498)
    return 
  end
  if (self._cellData).status == CommonAwardsSatus.UNLOCKED then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cfetchconsumptionaward")
    protocol.taskId = (self._cellData).id
    protocol:Send()
  end
end

AccumulateCostTaskCell.OnGoBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if (self._delegate)._activityClose then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100498)
    return 
  end
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
  if protocol then
    protocol:Send()
  end
end

return AccumulateCostTaskCell

