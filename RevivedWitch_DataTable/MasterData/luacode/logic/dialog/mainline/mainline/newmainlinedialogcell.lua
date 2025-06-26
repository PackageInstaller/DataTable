-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/mainline/newmainlinedialogcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local WorldInfoTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectworld")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local NewMainLineDialogCell = class("NewMainLineDialogCell", Dialog)
NewMainLineDialogCell.AssetBundleName = "ui/layouts.mainline"
NewMainLineDialogCell.AssetName = "MainLineWorldPanel"
NewMainLineDialogCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewMainLineDialogCell
  ((NewMainLineDialogCell.super).Ctor)(self, ...)
end

NewMainLineDialogCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._field = self:GetChild("Frame")
  self._leftArrow = self:GetChild("CanSlide/LeftArrow")
  self._rightArrow = self:GetChild("CanSlide/RightArrow")
  self._frame = (TableFrame.Create)(self._field, self, false)
  ;
  (self._frame):SetMargin(40, 0)
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnLeftArrowClicked, self)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnRightArrowClicked, self)
end

NewMainLineDialogCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

NewMainLineDialogCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, WorldInfoTable
  self._data = {}
  local chapter = {}
  self._currentWordIndex = nil
  local mainLineProgress = ((NekoData.BehaviorManager).BM_Game):GetMainLineProgress()
  for index,v in ipairs(data) do
    local recorder = WorldInfoTable:GetRecorder(v.worldId)
    if recorder then
      v.selectchapter = recorder.selectchapter
      v.selecttype = recorder.selecttype
      v.index = index
      v.unlockLv = ((NekoData.BehaviorManager).BM_Game):GetUnlockWorldPlayerLevelWithWorldId(v.worldId)
      if mainLineProgress.world == v.worldId then
        self._currentWordIndex = recorder.chapternum
      end
      if not chapter[v.selectchapter] then
        chapter[v.selectchapter] = {}
      end
      ;
      (table.insert)(chapter[v.selectchapter], v)
    else
      LogErrorFormat("NewMainLineDialogCell", "worldid %s is not in cdungeonselectworld", v.worldId)
    end
  end
  for _,id in ipairs(WorldInfoTable:GetAllIds()) do
    local flag = false
    for _,v in ipairs(data) do
      if v.worldId == id then
        flag = true
        break
      end
    end
    do
      if not flag then
        local temp = {}
        local recorder = WorldInfoTable:GetRecorder(id)
        if recorder then
          temp.selectchapter = recorder.selectchapter
          temp.selecttype = recorder.selecttype
          temp.worldId = id
          temp.lock = true
          if not chapter[temp.selectchapter] then
            chapter[temp.selectchapter] = {}
          end
          ;
          (table.insert)(chapter[temp.selectchapter], temp)
        else
          LogErrorFormat("NewMainLineDialogCell", "worldid %s is not in cdungeonselectworld", id)
        end
      end
      do
        -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  for k,v in pairs(chapter) do
    (table.insert)(self._data, v)
  end
  ;
  (table.sort)(self._data, function(a, b)
    -- function num : 0_3_0
    do return (a[1]).selectchapter < (b[1]).selectchapter end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):RefreshUIParticleClipper()
  local width = (self._field):GetRectSize()
  if (self._frame):GetTotalLength() <= width then
    (self._leftArrow):SetActive(false)
    ;
    (self._rightArrow):SetActive(false)
  else
    ;
    (self._leftArrow):SetActive(false)
    ;
    (self._rightArrow):SetActive(true)
  end
end

NewMainLineDialogCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

NewMainLineDialogCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "mainline.mainline.newmainlinedialogcellcell"
end

NewMainLineDialogCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

NewMainLineDialogCell.OnLeftArrowClicked = function(self)
  -- function num : 0_7
  local rightIndex = (self._frame):GetRightIndex()
  ;
  (self._frame):MoveRightToIndex(rightIndex - 1, true)
end

NewMainLineDialogCell.OnRightArrowClicked = function(self)
  -- function num : 0_8
  local leftIndex = (self._frame):GetLeftIndex()
  ;
  (self._frame):MoveLeftToIndex(leftIndex + 1, true)
end

NewMainLineDialogCell.MoveToCurrentWordIndex = function(self)
  -- function num : 0_9 , upvalues : _ENV, CVarConfig
  local time = tonumber((CVarConfig:GetRecorder(58)).Value)
  if self._currentWordIndex then
    (self._frame):MoveIndexToCentreInTime(self._currentWordIndex, time)
  end
end

NewMainLineDialogCell.OnCurPosChange = function(self, frame, tag)
  -- function num : 0_10
  local width = (self._field):GetRectSize()
  if tag == 0 then
    (self._leftArrow):SetActive(width >= (self._frame):GetTotalLength() or frame ~= self._frame)
    ;
    (self._rightArrow):SetActive(tag ~= 1)
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

NewMainLineDialogCell.OnWorldIClicked = function(self, i)
  -- function num : 0_11 , upvalues : _ENV
  local thisFrameDataIndex = nil
  for index,d in ipairs(self._data) do
    local flag = false
    for _,v in ipairs(d) do
      if v.index == i then
        flag = true
        thisFrameDataIndex = index
        break
      end
    end
  end
  do
    if not flag then
      local logicCell = (self._frame):GetLogicCell(thisFrameDataIndex)
      if not logicCell._cell then
        (self._frame):GetCellDialog(logicCell)
        -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (logicCell._cell)._delegate = self._delegate
        -- DECOMPILER ERROR at PC38: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (logicCell._cell)._cellData = logicCell._data
        ;
        (logicCell._cell):RefreshCell(logicCell._data)
      end
      for _,d in ipairs(logicCell._data) do
        if d.index == i then
          (logicCell._cell):OnCellClicked(d.selecttype)
          break
        end
      end
    end
  end
end

NewMainLineDialogCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_12
  if eventName == "MoveToCurrentWordIndex" then
    self:MoveToCurrentWordIndex()
  else
    ;
    (self._frame):FireEvent(eventName)
  end
end

return NewMainLineDialogCell

