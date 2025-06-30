-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/anniversary/dailytaskdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CAnniversaryMission = (BeanManager.GetTableByName)("dungeonselect.canniversarymission")
local CAnniversaryMissionAward = (BeanManager.GetTableByName)("dungeonselect.canniversarymissionaward")
local TaskFinishProgress = (LuaNetManager.GetBeanDef)("protocol.activity.taskfinishprogress")
local DailyTaskDialog = class("DailyTaskDialog", Dialog)
DailyTaskDialog.AssetBundleName = "ui/layouts.activity1yearanniversary"
DailyTaskDialog.AssetName = "Activity1YearAnniversaryAccount"
DailyTaskDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DailyTaskDialog
  ((DailyTaskDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
  self._list = nil
end

DailyTaskDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  (self:GetChild("BackImage/Reward")):SetActive(true)
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  self._items = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

      (self._items)[i] = {itemCell = self:GetChild("BackImage/Reward/ItemCell" .. i), itemCell_frame = self:GetChild("BackImage/Reward/ItemCell" .. i .. "/_BackGround/Frame"), itemCell_icon = self:GetChild("BackImage/Reward/ItemCell" .. i .. "/_BackGround/Icon"), itemCell_count = self:GetChild("BackImage/Reward/ItemCell" .. i .. "/_Count")}
      ;
      (((self._items)[i]).itemCell):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnItemCellClicked(i)
  end
)
    end
  end
  self._getBtn = self:GetChild("BackImage/Reward/GetBtn")
  self._getBtn_txt = self:GetChild("BackImage/Reward/GetBtn/_Text")
  self._progressPanel = self:GetChild("BackImage/Reward/ProgressBack")
  self._progressPanel_txt = self:GetChild("BackImage/Reward/ProgressBack/ProgressTxt")
  self._panel = self:GetChild("BackImage/Frame")
  self._frame = (TableFrame.Create)(self._panel, self, true, false, true)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._getBtn):Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
  self:Init()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSActivityTasks, Common.n_RefreshAnniversaryDailyTaskList, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSActivityTasks, Common.n_OnSRefreshActivityTask, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshAnniversaryCumulativeTask, Common.n_RefreshAnniversaryCumulativeTask, nil)
  ;
  (self:GetChild("BackImage/Title")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1999))
  ;
  (self:GetChild("BackImage/Tips")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2003))
  ;
  (self:GetChild("BackImage/TimeTxt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2005))
  ;
  (self:GetChild("BackImage/Reward/Txt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2012))
end

DailyTaskDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._frame):Destroy()
end

DailyTaskDialog.OnSActivityTasks = function(self)
  -- function num : 0_3
  self:RefreshTaskList()
end

DailyTaskDialog.OnRefreshAnniversaryCumulativeTask = function(self)
  -- function num : 0_4
  self:RefreshAwardPanel()
end

DailyTaskDialog.Init = function(self)
  -- function num : 0_5
  self:RefreshAwardPanel()
  self:RefreshTaskList()
end

DailyTaskDialog.RefreshAwardPanel = function(self)
  -- function num : 0_6 , upvalues : _ENV, CAnniversaryMissionAward, Item, TaskFinishProgress
  self._cumulativeTaskData = ((NekoData.BehaviorManager).BM_Anniversary):GetCumulativeTaskData()
  local record = CAnniversaryMissionAward:GetRecorder((self._cumulativeTaskData).taskId)
  local count = 0
  for i,v in ipairs(record.Items) do
    count = count + 1
    local node = (self._items)[i]
    if node then
      (node.itemCell):SetActive(true)
      node.item = (Item.Create)(v)
      local imageRecord = (node.item):GetIcon()
      ;
      (node.itemCell_icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = (node.item):GetPinJiImage()
      ;
      (node.itemCell_frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (node.itemCell_count):SetText((record.ItemNums)[i])
    else
      do
        do
          LogError("lack node!")
          -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for i = count + 1, 3 do
    (((self._items)[i]).itemCell):SetActive(false)
  end
  if (self._cumulativeTaskData).status == TaskFinishProgress.UNLOCKED then
    (self._progressPanel):SetActive(false)
    ;
    (self._getBtn):SetActive(true)
    ;
    (self._getBtn):SetInteractable(true)
    ;
    (self._getBtn_txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1899))
  else
    if (self._cumulativeTaskData).status == TaskFinishProgress.LOCKED then
      (self._progressPanel):SetActive(true)
      ;
      (self._progressPanel_txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(2013, {(self._cumulativeTaskData).num, record.count}))
      ;
      (self._getBtn):SetActive(false)
    else
      if (self._cumulativeTaskData).status == TaskFinishProgress.FETCHED then
        (self._progressPanel):SetActive(false)
        ;
        (self._getBtn):SetActive(true)
        ;
        (self._getBtn):SetInteractable(false)
        ;
        (self._getBtn_txt):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1900))
      end
    end
  end
end

DailyTaskDialog.RefreshTaskList = function(self)
  -- function num : 0_7 , upvalues : _ENV, CAnniversaryMission
  self._list = ((NekoData.BehaviorManager).BM_Anniversary):GetDailyTaskList()
  for i,v in ipairs(self._list) do
    v.record = CAnniversaryMission:GetRecorder(v.taskId)
  end
  ;
  (table.sort)(self._list, function(a, b)
    -- function num : 0_7_0
    if (a.record).missiontype >= (b.record).missiontype then
      do return (a.record).missiontype == (b.record).missiontype end
      do return a.id < b.id end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

DailyTaskDialog.OnGetBtnClick = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cfetchtaskfinishaward")
  protocol.id = (self._cumulativeTaskData).taskId
  protocol:Send()
end

DailyTaskDialog.OnItemCellClicked = function(self, index)
  -- function num : 0_9 , upvalues : _ENV
  if ((self._items)[index]).item then
    local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({item = ((self._items)[index]).item})
      local width, height = (((self._items)[index]).itemCell):GetRectSize()
      tipsDialog:SetTipsPosition(width, height, (((self._items)[index]).itemCell):GetLocalPointInUiRootPanel())
    end
  end
end

DailyTaskDialog.OnBackBtnClicked = function(self)
  -- function num : 0_10
  self:Destroy()
end

DailyTaskDialog.NumberOfCell = function(self, frame)
  -- function num : 0_11
  return #self._list
end

DailyTaskDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_12
  return "activity.anniversary.dailytaskcell"
end

DailyTaskDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_13
  return (self._list)[index]
end

return DailyTaskDialog

