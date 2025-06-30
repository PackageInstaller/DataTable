-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/mainline/mainlinetaskdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local AdventureMissionReward = (BeanManager.GetTableByName)("mission.cadventuremissionreward")
local WorldTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectworld")
local MainLineTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local MainLineTaskStatus = (LuaNetManager.CreateBean)("protocol.task.mainlinerewardstatus")
local MainLineTaskDialog = class("MainLineTaskDialog", Dialog)
MainLineTaskDialog.AssetBundleName = "ui/layouts.basetasklist"
MainLineTaskDialog.AssetName = "AdventureMain"
MainLineTaskDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainLineTaskDialog, _ENV, MainLineTable
  ((MainLineTaskDialog.super).Ctor)(self, ...)
  self._taskList = {}
  self._userlevel = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userlevel
  self._dungeonProgress = ((NekoData.BehaviorManager).BM_Game):GetMainLineProgress()
  self._totalZones = #MainLineTable:GetAllIds()
end

MainLineTaskDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._taskPanel = self:GetChild("Frame")
  self._taskFrame = (TableFrame.Create)(self._taskPanel, self, true, true, true)
  self._chapter = self:GetChild("LevelBack/ChaptersTxt")
  self._chapterName = self:GetChild("LevelBack/LevelTitle")
  self._curRegion = self:GetChild("LevelBack/NowLevel")
  self._curRegionName = self:GetChild("LevelBack/LevelName")
  self._progress = self:GetChild("LevelBack/ImageLine")
  self._progressNum = self:GetChild("LevelBack/ImageLine/levelNum")
  self:Init()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshTaskStatus, Common.n_RefreshMainLineTaskStatus, nil)
  ;
  (self:GetChild("Title")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1764))
  ;
  (self:GetChild("LevelBack/TrogressTxt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1849))
  ;
  (self:GetChild("LevelBack/NowLevelTxt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1850))
end

MainLineTaskDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._taskFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

MainLineTaskDialog.OnRefreshTaskStatus = function(self)
  -- function num : 0_3
  self:RefreshTaskList()
  local lastPos = (self._taskFrame):GetCurrentPosition()
  ;
  (self._taskFrame):ReloadAllCell()
  if lastPos then
    (self._taskFrame):MoveToAssignedPos(lastPos)
  end
end

MainLineTaskDialog.RefreshTaskList = function(self)
  -- function num : 0_4 , upvalues : _ENV, AdventureMissionReward, MainLineTaskStatus
  self._dungeonList = ((NekoData.BehaviorManager).BM_Game):GetDungeonList()
  while (self._taskList)[#self._taskList] do
    (table.remove)(self._taskList, #self._taskList)
  end
  local taskList = ((NekoData.BehaviorManager).BM_Task):GetMainLineTaskList()
  local getList = {}
  local ingList = {}
  local receivedList = {}
  for i,v in ipairs(taskList) do
    local record = AdventureMissionReward:GetRecorder(v.mainLineId)
    if record then
      local data = {record = record, data = v}
      if v.taskState == MainLineTaskStatus.AVAILABLE then
        (table.insert)(getList, data)
      else
        if v.taskState == MainLineTaskStatus.RECEIVED then
          (table.insert)(receivedList, data)
        else
          ;
          (table.insert)(ingList, data)
        end
      end
    else
      do
        do
          LogErrorFormat("MainLineTaskDialog", "record with id %s is not exist in cadventuremissionreward", v.mainLineId)
          -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  ;
  (table.sort)(getList, function(a, b)
    -- function num : 0_4_0
    do return (a.record).id < (b.record).id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(ingList, function(a, b)
    -- function num : 0_4_1
    do return (a.record).id < (b.record).id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(receivedList, function(a, b)
    -- function num : 0_4_2
    do return (a.record).id < (b.record).id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i,v in ipairs(getList) do
    (table.insert)(self._taskList, v)
  end
  for i,v in ipairs(ingList) do
    (table.insert)(self._taskList, v)
  end
  for i,v in ipairs(receivedList) do
    (table.insert)(self._taskList, v)
  end
end

MainLineTaskDialog.Init = function(self)
  -- function num : 0_5 , upvalues : WorldTable, _ENV, MainLineTable
  self:RefreshTaskList()
  ;
  (self._taskFrame):ReloadAllCell()
  ;
  (self._taskFrame):MoveToTop()
  local chapterRecord = WorldTable:GetRecorder((self._dungeonProgress).world)
  ;
  (self._chapter):SetText((TextManager.GetText)(chapterRecord.chapterTextID))
  ;
  (self._chapterName):SetText((TextManager.GetText)(chapterRecord.worldTextID))
  local regionRecord = MainLineTable:GetRecorder((self._dungeonProgress).floor)
  ;
  (self._curRegion):SetText(regionRecord.floor)
  ;
  (self._curRegionName):SetText((TextManager.GetText)(regionRecord.nameTextID))
  local clearZones = 0
  for i,v in ipairs(self._dungeonList) do
    clearZones = clearZones + v.clearZones
  end
  ;
  (self._progress):SetFillAmount((clearZones) / self._totalZones)
  ;
  (self._progressNum):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1851, {clearZones, self._totalZones}))
end

MainLineTaskDialog.GetChapterInfo = function(self, chapterId)
  -- function num : 0_6 , upvalues : _ENV
  for i,worldTemp in ipairs(self._dungeonList) do
    if worldTemp.worldId == chapterId then
      return worldTemp
    end
  end
end

MainLineTaskDialog.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._taskList
end

MainLineTaskDialog.CellAtIndex = function(self, frame)
  -- function num : 0_8
  return "task.mainline.mainlinetaskcell"
end

MainLineTaskDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_9
  return (self._taskList)[index]
end

return MainLineTaskDialog

