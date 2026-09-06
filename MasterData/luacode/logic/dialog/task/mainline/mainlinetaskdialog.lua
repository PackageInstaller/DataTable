local TableFrame = require("framework.ui.frame.table.tableframe")
local AdventureMissionReward = BeanManager.GetTableByName("mission.cadventuremissionreward")
local WorldTable = BeanManager.GetTableByName("dungeonselect.cdungeonselectworld")
local MainLineTable = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local MainLineTaskStatus = LuaNetManager.CreateBean("protocol.task.mainlinerewardstatus")
local MainLineTaskDialog = class("MainLineTaskDialog", Dialog)
MainLineTaskDialog.AssetBundleName = "ui/layouts.basetasklist"
MainLineTaskDialog.AssetName = "AdventureMain"

function MainLineTaskDialog:Ctor(...)
  MainLineTaskDialog.super.Ctor(self, ...)
  self._taskList = {}
  self._userlevel = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userlevel
  self._dungeonProgress = NekoData.BehaviorManager.BM_Game:GetMainLineProgress()
  self._totalZones = #MainLineTable:GetAllIds()
end

function MainLineTaskDialog:OnCreate()
  self._taskPanel = self:GetChild("Frame")
  self._taskFrame = TableFrame.Create(self._taskPanel, self, true, true, true)
  self._chapter = self:GetChild("LevelBack/ChaptersTxt")
  self._chapterName = self:GetChild("LevelBack/LevelTitle")
  self._curRegion = self:GetChild("LevelBack/NowLevel")
  self._curRegionName = self:GetChild("LevelBack/LevelName")
  self._progress = self:GetChild("LevelBack/ImageLine")
  self._progressNum = self:GetChild("LevelBack/ImageLine/levelNum")
  self:Init()
  LuaNotificationCenter.AddObserver(self, self.OnRefreshTaskStatus, Common.n_RefreshMainLineTaskStatus, nil)
  self:GetChild("Title"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1764))
  self:GetChild("LevelBack/TrogressTxt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1849))
  self:GetChild("LevelBack/NowLevelTxt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1850))
end

function MainLineTaskDialog:OnDestroy()
  self._taskFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function MainLineTaskDialog:OnRefreshTaskStatus()
  self:RefreshTaskList()
  local lastPos = self._taskFrame:GetCurrentPosition()
  self._taskFrame:ReloadAllCell()
  if lastPos then
    self._taskFrame:MoveToAssignedPos(lastPos)
  end
end

function MainLineTaskDialog:RefreshTaskList()
  self._dungeonList = NekoData.BehaviorManager.BM_Game:GetDungeonList()
  while self._taskList[#self._taskList] do
    table.remove(self._taskList, #self._taskList)
  end
  local taskList = NekoData.BehaviorManager.BM_Task:GetMainLineTaskList()
  local getList = {}
  local ingList = {}
  local receivedList = {}
  for i, v in ipairs(taskList) do
    local record = AdventureMissionReward:GetRecorder(v.mainLineId)
    if record then
      local data = {record = record, data = v}
      if v.taskState == MainLineTaskStatus.AVAILABLE then
        table.insert(getList, data)
      elseif v.taskState == MainLineTaskStatus.RECEIVED then
        table.insert(receivedList, data)
      else
        table.insert(ingList, data)
      end
    else
      LogErrorFormat("MainLineTaskDialog", "record with id %s is not exist in cadventuremissionreward", v.mainLineId)
    end
  end
  table.sort(getList, function(a, b)
    return a.record.id < b.record.id
  end)
  table.sort(ingList, function(a, b)
    return a.record.id < b.record.id
  end)
  table.sort(receivedList, function(a, b)
    return a.record.id < b.record.id
  end)
  for i, v in ipairs(getList) do
    table.insert(self._taskList, v)
  end
  for i, v in ipairs(ingList) do
    table.insert(self._taskList, v)
  end
  for i, v in ipairs(receivedList) do
    table.insert(self._taskList, v)
  end
end

function MainLineTaskDialog:Init()
  self:RefreshTaskList()
  self._taskFrame:ReloadAllCell()
  self._taskFrame:MoveToTop()
  local chapterRecord = WorldTable:GetRecorder(self._dungeonProgress.world)
  self._chapter:SetText(TextManager.GetText(chapterRecord.chapterTextID))
  self._chapterName:SetText(TextManager.GetText(chapterRecord.worldTextID))
  local regionRecord = MainLineTable:GetRecorder(self._dungeonProgress.floor)
  self._curRegion:SetText(regionRecord.floor)
  self._curRegionName:SetText(TextManager.GetText(regionRecord.nameTextID))
  local clearZones = 0
  for i, v in ipairs(self._dungeonList) do
    clearZones = clearZones + v.clearZones
  end
  self._progress:SetFillAmount(clearZones / self._totalZones)
  self._progressNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(1851, {
    clearZones,
    self._totalZones
  }))
end

function MainLineTaskDialog:GetChapterInfo(chapterId)
  for i, worldTemp in ipairs(self._dungeonList) do
    if worldTemp.worldId == chapterId then
      return worldTemp
    end
  end
end

function MainLineTaskDialog:NumberOfCell(frame)
  return #self._taskList
end

function MainLineTaskDialog:CellAtIndex(frame)
  return "task.mainline.mainlinetaskcell"
end

function MainLineTaskDialog:DataAtIndex(frame, index)
  return self._taskList[index]
end

return MainLineTaskDialog
