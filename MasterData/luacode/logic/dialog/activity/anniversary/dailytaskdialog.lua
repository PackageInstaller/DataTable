local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CAnniversaryMission = BeanManager.GetTableByName("dungeonselect.canniversarymission")
local CAnniversaryMissionAward = BeanManager.GetTableByName("dungeonselect.canniversarymissionaward")
local TaskFinishProgress = LuaNetManager.GetBeanDef("protocol.activity.taskfinishprogress")
local DailyTaskDialog = class("DailyTaskDialog", Dialog)
DailyTaskDialog.AssetBundleName = "ui/layouts.activity1yearanniversary"
DailyTaskDialog.AssetName = "Activity1YearAnniversaryAccount"

function DailyTaskDialog:Ctor(...)
  DailyTaskDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
  self._list = nil
end

function DailyTaskDialog:OnCreate()
  self:GetChild("BackImage/Reward"):SetActive(true)
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  self._items = {}
  for i = 1, 3 do
    self._items[i] = {
      itemCell = self:GetChild("BackImage/Reward/ItemCell" .. i),
      itemCell_frame = self:GetChild("BackImage/Reward/ItemCell" .. i .. "/_BackGround/Frame"),
      itemCell_icon = self:GetChild("BackImage/Reward/ItemCell" .. i .. "/_BackGround/Icon"),
      itemCell_count = self:GetChild("BackImage/Reward/ItemCell" .. i .. "/_Count")
    }
    self._items[i].itemCell:Subscribe_PointerClickEvent(function()
      self:OnItemCellClicked(i)
    end)
  end
  self._getBtn = self:GetChild("BackImage/Reward/GetBtn")
  self._getBtn_txt = self:GetChild("BackImage/Reward/GetBtn/_Text")
  self._progressPanel = self:GetChild("BackImage/Reward/ProgressBack")
  self._progressPanel_txt = self:GetChild("BackImage/Reward/ProgressBack/ProgressTxt")
  self._panel = self:GetChild("BackImage/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, false, true)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._getBtn:Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
  self:Init()
  LuaNotificationCenter.AddObserver(self, self.OnSActivityTasks, Common.n_RefreshAnniversaryDailyTaskList, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSActivityTasks, Common.n_OnSRefreshActivityTask, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshAnniversaryCumulativeTask, Common.n_RefreshAnniversaryCumulativeTask, nil)
  self:GetChild("BackImage/Title"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1999))
  self:GetChild("BackImage/Tips"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2003))
  self:GetChild("BackImage/TimeTxt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2005))
  self:GetChild("BackImage/Reward/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2012))
end

function DailyTaskDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._frame:Destroy()
end

function DailyTaskDialog:OnSActivityTasks()
  self:RefreshTaskList()
end

function DailyTaskDialog:OnRefreshAnniversaryCumulativeTask()
  self:RefreshAwardPanel()
end

function DailyTaskDialog:Init()
  self:RefreshAwardPanel()
  self:RefreshTaskList()
end

function DailyTaskDialog:RefreshAwardPanel()
  self._cumulativeTaskData = NekoData.BehaviorManager.BM_Anniversary:GetCumulativeTaskData()
  local record = CAnniversaryMissionAward:GetRecorder(self._cumulativeTaskData.taskId)
  local count = 0
  for i, v in ipairs(record.Items) do
    count = count + 1
    local node = self._items[i]
    if node then
      node.itemCell:SetActive(true)
      node.item = Item.Create(v)
      local imageRecord = node.item:GetIcon()
      node.itemCell_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = node.item:GetPinJiImage()
      node.itemCell_frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      node.itemCell_count:SetText(record.ItemNums[i])
    else
      LogError("lack node!")
    end
  end
  for i = count + 1, 3 do
    self._items[i].itemCell:SetActive(false)
  end
  if self._cumulativeTaskData.status == TaskFinishProgress.UNLOCKED then
    self._progressPanel:SetActive(false)
    self._getBtn:SetActive(true)
    self._getBtn:SetInteractable(true)
    self._getBtn_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1899))
  elseif self._cumulativeTaskData.status == TaskFinishProgress.LOCKED then
    self._progressPanel:SetActive(true)
    self._progressPanel_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2013, {
      self._cumulativeTaskData.num,
      record.count
    }))
    self._getBtn:SetActive(false)
  elseif self._cumulativeTaskData.status == TaskFinishProgress.FETCHED then
    self._progressPanel:SetActive(false)
    self._getBtn:SetActive(true)
    self._getBtn:SetInteractable(false)
    self._getBtn_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1900))
  end
end

function DailyTaskDialog:RefreshTaskList()
  self._list = NekoData.BehaviorManager.BM_Anniversary:GetDailyTaskList()
  for i, v in ipairs(self._list) do
    v.record = CAnniversaryMission:GetRecorder(v.taskId)
  end
  table.sort(self._list, function(a, b)
    if a.record.missiontype ~= b.record.missiontype then
      return a.record.missiontype < b.record.missiontype
    else
      return a.id < b.id
    end
  end)
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function DailyTaskDialog:OnGetBtnClick()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cfetchtaskfinishaward")
  protocol.id = self._cumulativeTaskData.taskId
  protocol:Send()
end

function DailyTaskDialog:OnItemCellClicked(index)
  if self._items[index].item then
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._items[index].item
      })
      local width, height = self._items[index].itemCell:GetRectSize()
      tipsDialog:SetTipsPosition(width, height, self._items[index].itemCell:GetLocalPointInUiRootPanel())
    end
  end
end

function DailyTaskDialog:OnBackBtnClicked()
  self:Destroy()
end

function DailyTaskDialog:NumberOfCell(frame)
  return #self._list
end

function DailyTaskDialog:CellAtIndex(frame, index)
  return "activity.anniversary.dailytaskcell"
end

function DailyTaskDialog:DataAtIndex(frame, index)
  return self._list[index]
end

return DailyTaskDialog
