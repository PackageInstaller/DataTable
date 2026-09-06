local WorldInfoTable = BeanManager.GetTableByName("dungeonselect.cdungeonselectworld")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local NewMainLineDialogCell = class("NewMainLineDialogCell", Dialog)
NewMainLineDialogCell.AssetBundleName = "ui/layouts.mainline"
NewMainLineDialogCell.AssetName = "MainLineWorldPanel"

function NewMainLineDialogCell:Ctor(...)
  NewMainLineDialogCell.super.Ctor(self, ...)
end

function NewMainLineDialogCell:OnCreate()
  self._field = self:GetChild("Frame")
  self._leftArrow = self:GetChild("CanSlide/LeftArrow")
  self._rightArrow = self:GetChild("CanSlide/RightArrow")
  self._frame = TableFrame.Create(self._field, self, false)
  self._frame:SetMargin(40, 0)
  self._leftArrow:Subscribe_PointerClickEvent(self.OnLeftArrowClicked, self)
  self._rightArrow:Subscribe_PointerClickEvent(self.OnRightArrowClicked, self)
end

function NewMainLineDialogCell:OnDestroy()
  self._frame:Destroy()
end

function NewMainLineDialogCell:RefreshCell(data)
  self._data = {}
  local chapter = {}
  self._currentWordIndex = nil
  local mainLineProgress = NekoData.BehaviorManager.BM_Game:GetMainLineProgress()
  for index, v in ipairs(data) do
    local recorder = WorldInfoTable:GetRecorder(v.worldId)
    if recorder then
      v.selectchapter = recorder.selectchapter
      v.selecttype = recorder.selecttype
      v.index = index
      v.unlockLv = NekoData.BehaviorManager.BM_Game:GetUnlockWorldPlayerLevelWithWorldId(v.worldId)
      if mainLineProgress.world == v.worldId then
        self._currentWordIndex = recorder.chapternum
      end
      if not chapter[v.selectchapter] then
        chapter[v.selectchapter] = {}
      end
      table.insert(chapter[v.selectchapter], v)
    else
      LogErrorFormat("NewMainLineDialogCell", "worldid %s is not in cdungeonselectworld", v.worldId)
    end
  end
  for _, id in ipairs(WorldInfoTable:GetAllIds()) do
    local flag = false
    for _, v in ipairs(data) do
      if v.worldId == id then
        flag = true
        break
      end
    end
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
        table.insert(chapter[temp.selectchapter], temp)
      else
        LogErrorFormat("NewMainLineDialogCell", "worldid %s is not in cdungeonselectworld", id)
      end
    end
  end
  for k, v in pairs(chapter) do
    table.insert(self._data, v)
  end
  table.sort(self._data, function(a, b)
    return a[1].selectchapter < b[1].selectchapter
  end)
  self._frame:ReloadAllCell()
  self._frame:RefreshUIParticleClipper()
  local width = self._field:GetRectSize()
  if width >= self._frame:GetTotalLength() then
    self._leftArrow:SetActive(false)
    self._rightArrow:SetActive(false)
  else
    self._leftArrow:SetActive(false)
    self._rightArrow:SetActive(true)
  end
end

function NewMainLineDialogCell:NumberOfCell(frame)
  return #self._data
end

function NewMainLineDialogCell:CellAtIndex(frame, index)
  return "mainline.mainline.newmainlinedialogcellcell"
end

function NewMainLineDialogCell:DataAtIndex(frame, index)
  return self._data[index]
end

function NewMainLineDialogCell:OnLeftArrowClicked()
  local rightIndex = self._frame:GetRightIndex()
  self._frame:MoveRightToIndex(rightIndex - 1, true)
end

function NewMainLineDialogCell:OnRightArrowClicked()
  local leftIndex = self._frame:GetLeftIndex()
  self._frame:MoveLeftToIndex(leftIndex + 1, true)
end

function NewMainLineDialogCell:MoveToCurrentWordIndex()
  local time = tonumber(CVarConfig:GetRecorder(58).Value)
  if self._currentWordIndex then
    self._frame:MoveIndexToCentreInTime(self._currentWordIndex, time)
  end
end

function NewMainLineDialogCell:OnCurPosChange(frame, tag)
  local width = self._field:GetRectSize()
  if width < self._frame:GetTotalLength() and frame == self._frame then
    self._leftArrow:SetActive(tag ~= 0)
    self._rightArrow:SetActive(tag ~= 1)
  end
end

function NewMainLineDialogCell:OnWorldIClicked(i)
  local thisFrameDataIndex
  for index, d in ipairs(self._data) do
    local flag = false
    for _, v in ipairs(d) do
      if v.index == i then
        flag = true
        thisFrameDataIndex = index
        break
      end
    end
    if flag then
      break
    end
  end
  local logicCell = self._frame:GetLogicCell(thisFrameDataIndex)
  if not logicCell._cell then
    self._frame:GetCellDialog(logicCell)
    logicCell._cell._delegate = self._delegate
    logicCell._cell._cellData = logicCell._data
    logicCell._cell:RefreshCell(logicCell._data)
  end
  for _, d in ipairs(logicCell._data) do
    if d.index == i then
      logicCell._cell:OnCellClicked(d.selecttype)
      break
    end
  end
end

function NewMainLineDialogCell:OnEvent(eventName, arg)
  if eventName == "MoveToCurrentWordIndex" then
    self:MoveToCurrentWordIndex()
  else
    self._frame:FireEvent(eventName)
  end
end

return NewMainLineDialogCell
