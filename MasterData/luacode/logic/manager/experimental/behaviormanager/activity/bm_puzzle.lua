local BM_Puzzle = class("BM_Puzzle")
local CJigsawConfig = BeanManager.GetTableByName("activity.cjigsawconfig")
local CJigsawreSourceConfig = BeanManager.GetTableByName("activity.cjigsawresourceconfig")

function BM_Puzzle:Ctor()
  self._puzzles = NekoData.Data.activities.puzzle
end

local Limit = 12

function BM_Puzzle:GetPuzzleData(actId, currencyNum)
  local result = {}
  if not self._puzzles[actId] then
    LogErrorFormat("BM_Puzzle", "Puzzle ActivityID :%s is nil", actId)
    return result
  end
  local records = {}
  local allIds = CJigsawConfig:GetAllIds()
  for _, k in ipairs(allIds) do
    local record = CJigsawConfig:GetRecorder(k)
    if record.activity_id == actId then
      table.insert(records, record.sort_id, record)
    end
  end
  for k, v in pairs(self._puzzles[actId].puzzleInfo) do
    local state = 0
    local record = records[k]
    if currencyNum >= record.quantity then
      state = 1
    end
    if v == 1 then
      state = 2
    end
    result[k] = {
      state = state,
      quantity = record.quantity,
      popupID = record.PoPupID,
      image = record.quantity_id
    }
  end
  return result
end

function BM_Puzzle:GetPuzzleNum(actId)
  if not self._puzzles[actId] then
    LogErrorFormat("BM_Puzzle", "Puzzle ActivityID :%s is nil", actId)
    return 0
  end
  return self._puzzles[actId].puzzleNum or 0
end

function BM_Puzzle:GetPuzzleBoxsData(actId)
  if not self._puzzles[actId] then
    LogErrorFormat("BM_Puzzle", "Puzzle ActivityID :%s is nil", actId)
    return {}
  end
  if not self._puzzles[actId].progressReward then
    return {}
  end
  local result = {}
  for k, v in pairs(self._puzzles[actId].progressReward) do
    local state = 0
    if k <= self._puzzles[actId].puzzleNum then
      state = 1
    end
    if v == 1 then
      state = 2
    end
    result[k] = {state = state}
  end
  return result
end

function BM_Puzzle:IsActivityOpen(actId)
  for k, v in pairs(self._puzzles) do
    if k == actId then
      return true
    end
  end
  return false
end

function BM_Puzzle:ShowRedDot(actId)
  for k, v in pairs(self._puzzles) do
    if actId == k then
      local rewards = self:GetPuzzleBoxsData(k)
      for k, v in pairs(rewards) do
        if v.state == 1 then
          return true
        end
      end
      local num = self:GetPuzzleNum(k) or 0
      if num < Limit and NekoData.BehaviorManager.BM_ActivityTasks:PuzzleShowRedDot() then
        return true
      end
    end
  end
  return false
end

function BM_Puzzle:OpenActivityDialog(id)
  if id == 0 then
    return
  end
  if not self._puzzles[id] then
    local recorder = CJigsawreSourceConfig:GetRecorder(id)
    if recorder and 0 < recorder.PoPupID then
      NekoData.BehaviorManager.BM_Message:SendMessageById(recorder.PoPupID)
    end
    return
  end
  local num = self:GetPuzzleNum(id)
  if num < Limit then
    local dialog = DialogManager.CreateSingletonDialog("activity.puzzle.puzzlemaindialog")
    dialog:Init(id)
  else
    local dialog = DialogManager.CreateSingletonDialog("activity.puzzle.puzzlefinishdialog")
    dialog:Init(id)
  end
end

function BM_Puzzle:JumpToBook()
  local dialog = DialogManager.CreateSingletonDialog("handbook.handbookdialog")
  if dialog then
    dialog:OnGroupClick(4)
  end
end

return BM_Puzzle
