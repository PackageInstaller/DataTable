local TableFrame = require("framework.ui.frame.table.tableframe")
local TrainStatus = LuaNetManager.GetBeanDef("protocol.yard.train")
local BottomToTop = 4
local TrainListDialog = class("TrainListDialog", Dialog)
TrainListDialog.AssetBundleName = "ui/layouts.yard"
TrainListDialog.AssetName = "TrainList"

function TrainListDialog:Ctor(...)
  TrainListDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._trainList = {}
  self._roles = {}
end

function TrainListDialog:OnCreate()
  self._scrollBar = self:GetChild("Panel/Scrollbar")
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._closeBtn = self:GetChild("Panel/CloseBtn")
  self._trainPanel = self:GetChild("Panel/Frame")
  self._trainFrame = TableFrame.Create(self._trainPanel, self, true, true, true)
  self._width, self._height = self._trainPanel:GetRectSize()
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
  LuaNotificationCenter.AddObserver(self, self.OnStartTrainTask, Common.n_StartTrainTask, nil)
  LuaNotificationCenter.AddObserver(self, self.OnCompleteTrainTask, Common.n_CompleteTrainTask, nil)
  LuaNotificationCenter.AddObserver(self, self.OnStopTrainTask, Common.n_StopTrainTask, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshTrainTask, Common.n_RefreshTrainTask, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
end

function TrainListDialog:OnDestroy()
  self._trainFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TrainListDialog:Init()
  self._trainList = NekoData.BehaviorManager.BM_TrainCamp:GetAllTrainTaskInfo()
  for i, v in ipairs(self._trainList) do
    if v.trainTaskInfo then
      self._roles[v.trainTaskInfo.index] = v.trainTaskInfo.roleId
    end
  end
  self._trainFrame:ReloadAllCell()
  self._trainFrame:MoveToTop()
end

function TrainListDialog:OnStartTrainTask(notification)
  local protocol = notification.userInfo
  local index
  self._trainList = NekoData.BehaviorManager.BM_TrainCamp:GetAllTrainTaskInfo()
  self._roles[protocol.index] = protocol.train.roleId
  self._trainFrame:ReloadAllCell()
  self._trainFrame:MoveToTop()
end

function TrainListDialog:OnCompleteTrainTask(notification)
  local protocol = notification.userInfo
  local index
  self._trainList = NekoData.BehaviorManager.BM_TrainCamp:GetAllTrainTaskInfo()
  self._roles[protocol.index] = protocol.train.roleId
  self._trainFrame:ReloadAllCell()
  self._trainFrame:MoveToTop()
end

function TrainListDialog:OnStopTrainTask(notification)
  local protocol = notification.userInfo
  local index
  self._trainList = NekoData.BehaviorManager.BM_TrainCamp:GetAllTrainTaskInfo()
  self._trainFrame:ReloadAllCell()
  self._trainFrame:MoveToTop()
end

function TrainListDialog:OnRefreshTrainTask(notification)
  local protocol = notification.userInfo
  local index
  self._trainList = NekoData.BehaviorManager.BM_TrainCamp:GetAllTrainTaskInfo()
  self._roles[protocol.index] = protocol.train.roleId
  self._trainFrame:ReloadAllCell()
  self._trainFrame:MoveToTop()
end

function TrainListDialog:OnRefreshCurrency()
  self._trainFrame:FireEvent("RefreshNotStartPanel")
end

function TrainListDialog:SetRoleByChooseRoleDialog(taskIndex, roleId)
  if roleId and roleId ~= 0 then
    local existIndex
    for k, v in pairs(self._roles) do
      if v == roleId then
        existIndex = k
        break
      end
    end
    if existIndex then
      for i, v in ipairs(self._trainList) do
        if v.trainTaskInfo and v.trainTaskInfo.index == existIndex then
          self._roles[existIndex] = 0
        end
      end
    end
  end
  self._roles[taskIndex] = roleId
  self._trainFrame:FireEvent("SetRoleByChooseRoleDialog", taskIndex)
end

function TrainListDialog:NumberOfCell(frame)
  return #self._trainList
end

function TrainListDialog:CellAtIndex(frame, index)
  return "traincamp.trainlistcell"
end

function TrainListDialog:DataAtIndex(frame, index)
  return self._trainList[index]
end

function TrainListDialog:OnCurPosChange(frame, proportion)
  local total = self._trainFrame:GetTotalLength()
  if total > self._height then
    self._scrollBar:SetActive(true)
    self._scrollBar:SetScrollSize(self._height / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetActive(false)
  end
end

function TrainListDialog:OnBackBtnClicked()
  self:Destroy()
end

return TrainListDialog
