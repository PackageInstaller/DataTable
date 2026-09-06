local DM_Puzzle = class("DM_Puzzle")
local TasksProtocolDef = LuaNetManager.GetProtocolDef("protocol.task.cactivitytasks")

function DM_Puzzle:Ctor()
  self._puzzles = NekoData.Data.activities.puzzle
  self._allTaskList = NekoData.Data.activityTasks.allTaskList
  self._finishedTaskList = NekoData.Data.activityTasks.finishedTaskList
end

function DM_Puzzle:Clear()
  for k, v in pairs(self._puzzles) do
    self._puzzles[k] = nil
  end
end

function DM_Puzzle:OnSOpenPuzzle(protocol)
  self:RemoveTask(protocol.actId)
  if protocol.leftTime > 0 then
    self._puzzles[protocol.actId] = {
      actId = protocol.actId,
      endTime = protocol.deadLine,
      leftTime = protocol.leftTime,
      puzzleNum = protocol.puzzleNum,
      puzzleInfo = protocol.puzzleInfo,
      progressReward = protocol.progressReward,
      gameTimerId = ServerGameTimer.AddTask(math.floor(protocol.leftTime / 1000), -1, function()
        LogInfoFormat("DM_Puzzle", "EndPuzzle:%s", protocol.actId)
        if self._puzzles[protocol.actId] then
          self._puzzles[protocol.actId] = nil
        end
        self._allTaskList[2] = {}
        self._finishedTaskList[2] = {}
        LuaNotificationCenter.PostNotification(Common.n_RefreshActivityRewards, nil, nil)
      end)
    }
  end
end

function DM_Puzzle:OnSUnlockPuzzle(protocol)
  if not self._puzzles[protocol.activityId] then
    LogErrorFormat("DM_Puzzle", " No exist activityID:%s", protocol.activityId)
    return
  end
  for k, v in ipairs(self._puzzles[protocol.activityId].puzzleInfo) do
    if k == protocol.puzzleId then
      if v == 1 then
        LogErrorFormat("DM_Puzzle", " Puzzle:%s.%s are unlocked repeatedly ", protocol.activityId, protocol.puzzleId)
      else
        self._puzzles[protocol.activityId].puzzleInfo[protocol.puzzleId] = 1
        self._puzzles[protocol.activityId].puzzleNum = protocol.puzzleNum
        LuaNotificationCenter.PostNotification(Common.n_OnGetNewPuzzle, nil, protocol)
      end
    end
  end
end

function DM_Puzzle:OnSGetProgressReward(protocol)
  if not self._puzzles[protocol.activityId] then
    LogErrorFormat("DM_Puzzle", "No exist activityID:%s", protocol.activityId)
    return
  end
  self._puzzles[protocol.activityId].progressReward = protocol.progressReward
end

function DM_Puzzle:RemoveTask(actid)
  if self._puzzles[actid] and self._puzzles[actid].gameTimerId ~= nil then
    ServerGameTimer.RemoveTask(self._puzzles[actid].gameTimerId)
  end
end

return DM_Puzzle
