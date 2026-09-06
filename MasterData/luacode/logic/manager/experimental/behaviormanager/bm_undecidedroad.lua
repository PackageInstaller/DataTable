local BattleType = LuaNetManager.CreateBean("protocol.activity.challengerecord")
local CWeidingexertion = BeanManager.GetTableByName("dungeonselect.cweidingexertion")
local BM_UndecidedRoad = class("BM_UndecidedRoad")

function BM_UndecidedRoad:Ctor()
  self._undecidedroad = NekoData.Data.undecidedroad
end

function BM_UndecidedRoad:GetSeasonIsOpen()
  return self._undecidedroad.isSeasonOpen
end

function BM_UndecidedRoad:GetReceiveIsOpen()
  return self._undecidedroad.endTime and self._undecidedroad.endTime > 0
end

function BM_UndecidedRoad:GetSeasonData()
  return self._undecidedroad.seasonData or {}
end

function BM_UndecidedRoad:GetSeasonId()
  return self._undecidedroad.seasonData.seasonId or 0
end

function BM_UndecidedRoad:GetTotalScore()
  return self._undecidedroad.totalScore or 0
end

function BM_UndecidedRoad:CheckChallengeRecord(battleType, battleId)
  local csend = LuaNetManager.CreateProtocol("protocol.activity.ccheckchallengerecord")
  csend.battleType = battleType
  if battleType ~= BattleType.SEASON then
    csend.battleId = battleId
  end
  csend:Send()
end

function BM_UndecidedRoad:GetRewardList()
  local CWeidingcollect = BeanManager.GetTableByName("dungeonselect.cweidingcollect")
  local allIds = CWeidingcollect:GetAllIds()
  local dataList = {}
  local curNum = self._undecidedroad.totalScore or 0
  for i, j in pairs(allIds) do
    local status = 0
    local record = CWeidingcollect:GetRecorder(j)
    if curNum >= record.collectrequirenum then
      status = 1
    end
    if j <= self._undecidedroad.maxContinueId or table.indexof(self._undecidedroad.receiveAward, j) then
      status = 2
    end
    local temp = {stageId = j, status = status}
    table.insert(dataList, temp)
  end
  return dataList
end

function BM_UndecidedRoad:HasDiscount(battletype)
  if battletype == BattleType.TRAIN then
    return false
  end
  local challenge = self._undecidedroad.seasonData.challengeInfo or {}
  for k, v in pairs(challenge) do
    if k == battletype then
      if battletype == BattleType.WEEK and CWeidingexertion:GetRecorder(1).weekfreetime > v.battleTimes then
        return true
      end
      if battletype == BattleType.DAILY and CWeidingexertion:GetRecorder(1).dayfreetime > v.battleTimes then
        return true
      end
    end
  end
  return false
end

function BM_UndecidedRoad:GetCostNum(battletype)
  if battletype == BattleType.TRAIN then
    return 0
  end
  if not self:HasDiscount(battletype) then
    if battletype == BattleType.WEEK then
      return CWeidingexertion:GetRecorder(1).weekPhysical
    end
    if battletype == BattleType.DAILY then
      return CWeidingexertion:GetRecorder(1).dayPhysical
    end
  end
  return 0
end

function BM_UndecidedRoad:HaveAvailable()
  local dataList = self:GetRewardList()
  for i, j in ipairs(dataList) do
    if j.status == 1 then
      return true
    end
  end
  return false
end

function BM_UndecidedRoad:GetAwardEndTime()
  if self._undecidedroad.endTime == 0 then
    return ""
  end
  return os.date("%Y-%m-%d %H:%M:%S", self._undecidedroad.endTime // 1000)
end

function BM_UndecidedRoad:GetCurDay()
  return self._undecidedroad.seasonData.curday or 0
end

function BM_UndecidedRoad:GetTrainData()
  return self._undecidedroad.trainData or {}
end

function BM_UndecidedRoad:GetBossInfo()
  local battleIds = self._undecidedroad.seasonData.battleIds
  if not battleIds or next(battleIds) == nil then
    LogError("BM_UndecidedRoad", "BattleIds is Not Exist")
    return 0
  end
  local CWeidingSort = BeanManager.GetTableByName("dungeonselect.cweidingsort")
  local result = {}
  if self:GetSeasonId() == 0 then
    return result
  end
  local weekdata = {
    id = 1,
    type = 100,
    cfg = CWeidingSort:GetRecorder(battleIds[100])
  }
  table.insert(result, weekdata)
  local curday = self:GetCurDay()
  for i = 1, curday do
    local temp = {
      id = i + 1,
      type = i,
      cfg = CWeidingSort:GetRecorder(battleIds[i + 1])
    }
    result[#result + 1] = temp
  end
  return result
end

function BM_UndecidedRoad:GetBattleId(rankId)
  local battleIds = self._undecidedroad.seasonData.battleIds
  if not battleIds or next(battleIds) == nil then
    LogError("BM_UndecidedRoad", "BattleIds is Not Exist")
    return 0
  end
  if rankId == 1 then
    return battleIds[100]
  else
    return battleIds[rankId]
  end
end

function BM_UndecidedRoad:GetRankId(rankId)
  local id = 0
  if rankId == 1 then
    id = 100
  else
    id = rankId
  end
  return tostring(self:GetSeasonId()) .. "|" .. tostring(id)
end

return BM_UndecidedRoad
