-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/traincamp/trainlistdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local TrainStatus = (LuaNetManager.GetBeanDef)("protocol.yard.train")
local BottomToTop = 4
local TrainListDialog = class("TrainListDialog", Dialog)
TrainListDialog.AssetBundleName = "ui/layouts.yard"
TrainListDialog.AssetName = "TrainList"
TrainListDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TrainListDialog
  ((TrainListDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._trainList = {}
  self._roles = {}
end

TrainListDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame, _ENV
  self._scrollBar = self:GetChild("Panel/Scrollbar")
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._closeBtn = self:GetChild("Panel/CloseBtn")
  self._trainPanel = self:GetChild("Panel/Frame")
  self._trainFrame = (TableFrame.Create)(self._trainPanel, self, true, true, true)
  self._width = (self._trainPanel):GetRectSize()
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnStartTrainTask, Common.n_StartTrainTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnCompleteTrainTask, Common.n_CompleteTrainTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnStopTrainTask, Common.n_StopTrainTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshTrainTask, Common.n_RefreshTrainTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
end

TrainListDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._trainFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

TrainListDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._trainList = ((NekoData.BehaviorManager).BM_TrainCamp):GetAllTrainTaskInfo()
  for i,v in ipairs(self._trainList) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

    if v.trainTaskInfo then
      (self._roles)[(v.trainTaskInfo).index] = (v.trainTaskInfo).roleId
    end
  end
  ;
  (self._trainFrame):ReloadAllCell()
  ;
  (self._trainFrame):MoveToTop()
end

TrainListDialog.OnStartTrainTask = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = notification.userInfo
  local index = nil
  self._trainList = ((NekoData.BehaviorManager).BM_TrainCamp):GetAllTrainTaskInfo()
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._roles)[protocol.index] = (protocol.train).roleId
  ;
  (self._trainFrame):ReloadAllCell()
  ;
  (self._trainFrame):MoveToTop()
end

TrainListDialog.OnCompleteTrainTask = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  local protocol = notification.userInfo
  local index = nil
  self._trainList = ((NekoData.BehaviorManager).BM_TrainCamp):GetAllTrainTaskInfo()
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._roles)[protocol.index] = (protocol.train).roleId
  ;
  (self._trainFrame):ReloadAllCell()
  ;
  (self._trainFrame):MoveToTop()
end

TrainListDialog.OnStopTrainTask = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  local protocol = notification.userInfo
  local index = nil
  self._trainList = ((NekoData.BehaviorManager).BM_TrainCamp):GetAllTrainTaskInfo()
  ;
  (self._trainFrame):ReloadAllCell()
  ;
  (self._trainFrame):MoveToTop()
end

TrainListDialog.OnRefreshTrainTask = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV
  local protocol = notification.userInfo
  local index = nil
  self._trainList = ((NekoData.BehaviorManager).BM_TrainCamp):GetAllTrainTaskInfo()
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._roles)[protocol.index] = (protocol.train).roleId
  ;
  (self._trainFrame):ReloadAllCell()
  ;
  (self._trainFrame):MoveToTop()
end

TrainListDialog.OnRefreshCurrency = function(self)
  -- function num : 0_8
  (self._trainFrame):FireEvent("RefreshNotStartPanel")
end

TrainListDialog.SetRoleByChooseRoleDialog = function(self, taskIndex, roleId)
  -- function num : 0_9 , upvalues : _ENV
  if roleId and roleId ~= 0 then
    local existIndex = nil
    for k,v in pairs(self._roles) do
      if v == roleId then
        existIndex = k
        break
      end
    end
    do
      if existIndex then
        for i,v in ipairs(self._trainList) do
          -- DECOMPILER ERROR at PC29: Confused about usage of register: R9 in 'UnsetPending'

          if v.trainTaskInfo and (v.trainTaskInfo).index == existIndex then
            (self._roles)[existIndex] = 0
          end
        end
      end
      do
        -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (self._roles)[taskIndex] = roleId
        ;
        (self._trainFrame):FireEvent("SetRoleByChooseRoleDialog", taskIndex)
      end
    end
  end
end

TrainListDialog.NumberOfCell = function(self, frame)
  -- function num : 0_10
  return #self._trainList
end

TrainListDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_11
  return "traincamp.trainlistcell"
end

TrainListDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_12
  return (self._trainList)[index]
end

TrainListDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_13
  local total = (self._trainFrame):GetTotalLength()
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

TrainListDialog.OnBackBtnClicked = function(self)
  -- function num : 0_14
  self:Destroy()
end

return TrainListDialog

