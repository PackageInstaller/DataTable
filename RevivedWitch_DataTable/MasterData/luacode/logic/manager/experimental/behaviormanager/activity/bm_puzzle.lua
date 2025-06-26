-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_puzzle.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_Puzzle = class("BM_Puzzle")
local CJigsawConfig = (BeanManager.GetTableByName)("activity.cjigsawconfig")
local CJigsawreSourceConfig = (BeanManager.GetTableByName)("activity.cjigsawresourceconfig")
BM_Puzzle.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._puzzles = ((NekoData.Data).activities).puzzle
end

local Limit = 12
BM_Puzzle.GetPuzzleData = function(self, actId, currencyNum)
  -- function num : 0_1 , upvalues : _ENV, CJigsawConfig
  local result = {}
  if not (self._puzzles)[actId] then
    LogErrorFormat("BM_Puzzle", "Puzzle ActivityID :%s is nil", actId)
    return result
  end
  local records = {}
  local allIds = CJigsawConfig:GetAllIds()
  for _,k in ipairs(allIds) do
    local record = CJigsawConfig:GetRecorder(k)
    if record.activity_id == actId then
      (table.insert)(records, record.sort_id, record)
    end
  end
  for k,v in pairs(((self._puzzles)[actId]).puzzleInfo) do
    local state = 0
    local record = records[k]
    if record.quantity <= currencyNum then
      state = 1
    end
    if v == 1 then
      state = 2
    end
    result[k] = {state = state, quantity = record.quantity, popupID = record.PoPupID, image = record.quantity_id}
  end
  return result
end

BM_Puzzle.GetPuzzleNum = function(self, actId)
  -- function num : 0_2 , upvalues : _ENV
  if not (self._puzzles)[actId] then
    LogErrorFormat("BM_Puzzle", "Puzzle ActivityID :%s is nil", actId)
    return 0
  end
  return ((self._puzzles)[actId]).puzzleNum or 0
end

BM_Puzzle.GetPuzzleBoxsData = function(self, actId)
  -- function num : 0_3 , upvalues : _ENV
  if not (self._puzzles)[actId] then
    LogErrorFormat("BM_Puzzle", "Puzzle ActivityID :%s is nil", actId)
    return {}
  end
  if not ((self._puzzles)[actId]).progressReward then
    return {}
  end
  local result = {}
  for k,v in pairs(((self._puzzles)[actId]).progressReward) do
    local state = 0
    if k <= ((self._puzzles)[actId]).puzzleNum then
      state = 1
    end
    if v == 1 then
      state = 2
    end
    result[k] = {state = state}
  end
  return result
end

BM_Puzzle.IsActivityOpen = function(self, actId)
  -- function num : 0_4 , upvalues : _ENV
  for k,v in pairs(self._puzzles) do
    if k == actId then
      return true
    end
  end
  return false
end

BM_Puzzle.ShowRedDot = function(self, actId)
  -- function num : 0_5 , upvalues : _ENV, Limit
  for k,v in pairs(self._puzzles) do
    if actId == k then
      local rewards = self:GetPuzzleBoxsData(k)
      for k,v in pairs(rewards) do
        if v.state == 1 then
          return true
        end
      end
      local num = self:GetPuzzleNum(k) or 0
      if num < Limit and ((NekoData.BehaviorManager).BM_ActivityTasks):PuzzleShowRedDot() then
        return true
      end
    end
  end
  return false
end

BM_Puzzle.OpenActivityDialog = function(self, id)
  -- function num : 0_6 , upvalues : CJigsawreSourceConfig, _ENV, Limit
  if id == 0 then
    return 
  end
  do
    if not (self._puzzles)[id] then
      local recorder = CJigsawreSourceConfig:GetRecorder(id)
      if recorder and recorder.PoPupID > 0 then
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(recorder.PoPupID)
      end
      return 
    end
    local num = self:GetPuzzleNum(id)
    if num < Limit then
      local dialog = (DialogManager.CreateSingletonDialog)("activity.puzzle.puzzlemaindialog")
      dialog:Init(id)
    else
      do
        local dialog = (DialogManager.CreateSingletonDialog)("activity.puzzle.puzzlefinishdialog")
        dialog:Init(id)
      end
    end
  end
end

BM_Puzzle.JumpToBook = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("handbook.handbookdialog")
  if dialog then
    dialog:OnGroupClick(4)
  end
end

return BM_Puzzle

