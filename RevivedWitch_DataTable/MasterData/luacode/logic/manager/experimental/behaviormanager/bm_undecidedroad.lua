-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_undecidedroad.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleType = (LuaNetManager.CreateBean)("protocol.activity.challengerecord")
local CWeidingexertion = (BeanManager.GetTableByName)("dungeonselect.cweidingexertion")
local BM_UndecidedRoad = class("BM_UndecidedRoad")
BM_UndecidedRoad.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._undecidedroad = (NekoData.Data).undecidedroad
end

BM_UndecidedRoad.GetSeasonIsOpen = function(self)
  -- function num : 0_1
  return (self._undecidedroad).isSeasonOpen
end

BM_UndecidedRoad.GetReceiveIsOpen = function(self)
  -- function num : 0_2
  do return not (self._undecidedroad).endTime or (self._undecidedroad).endTime > 0 end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

BM_UndecidedRoad.GetSeasonData = function(self)
  -- function num : 0_3
  if not (self._undecidedroad).seasonData then
    return {}
  end
end

BM_UndecidedRoad.GetSeasonId = function(self)
  -- function num : 0_4
  return ((self._undecidedroad).seasonData).seasonId or 0
end

BM_UndecidedRoad.GetTotalScore = function(self)
  -- function num : 0_5
  return (self._undecidedroad).totalScore or 0
end

BM_UndecidedRoad.CheckChallengeRecord = function(self, battleType, battleId)
  -- function num : 0_6 , upvalues : _ENV, BattleType
  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.ccheckchallengerecord")
  csend.battleType = battleType
  if battleType ~= BattleType.SEASON then
    csend.battleId = battleId
  end
  csend:Send()
end

BM_UndecidedRoad.GetRewardList = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local CWeidingcollect = (BeanManager.GetTableByName)("dungeonselect.cweidingcollect")
  local allIds = CWeidingcollect:GetAllIds()
  local dataList = {}
  local curNum = (self._undecidedroad).totalScore or 0
  for i,j in pairs(allIds) do
    local status = 0
    local record = CWeidingcollect:GetRecorder(j)
    if record.collectrequirenum <= curNum then
      status = 1
    end
    if j <= (self._undecidedroad).maxContinueId or (table.indexof)((self._undecidedroad).receiveAward, j) then
      status = 2
    end
    local temp = {stageId = j, status = status}
    ;
    (table.insert)(dataList, temp)
  end
  return dataList
end

BM_UndecidedRoad.HasDiscount = function(self, battletype)
  -- function num : 0_8 , upvalues : BattleType, _ENV, CWeidingexertion
  if battletype == BattleType.TRAIN then
    return false
  end
  if not ((self._undecidedroad).seasonData).challengeInfo then
    local challenge = {}
  end
  for k,v in pairs(challenge) do
    if k == battletype then
      if battletype == BattleType.WEEK and v.battleTimes < (CWeidingexertion:GetRecorder(1)).weekfreetime then
        return true
      end
      if battletype == BattleType.DAILY and v.battleTimes < (CWeidingexertion:GetRecorder(1)).dayfreetime then
        return true
      end
    end
  end
  return false
end

BM_UndecidedRoad.GetCostNum = function(self, battletype)
  -- function num : 0_9 , upvalues : BattleType, CWeidingexertion
  if battletype == BattleType.TRAIN then
    return 0
  end
  if not self:HasDiscount(battletype) then
    if battletype == BattleType.WEEK then
      return (CWeidingexertion:GetRecorder(1)).weekPhysical
    end
    if battletype == BattleType.DAILY then
      return (CWeidingexertion:GetRecorder(1)).dayPhysical
    end
  end
  return 0
end

BM_UndecidedRoad.HaveAvailable = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dataList = self:GetRewardList()
  for i,j in ipairs(dataList) do
    if j.status == 1 then
      return true
    end
  end
  return false
end

BM_UndecidedRoad.GetAwardEndTime = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if (self._undecidedroad).endTime == 0 then
    return ""
  end
  return (os.date)("%Y-%m-%d %H:%M:%S", (self._undecidedroad).endTime // 1000)
end

BM_UndecidedRoad.GetCurDay = function(self)
  -- function num : 0_12
  return ((self._undecidedroad).seasonData).curday or 0
end

BM_UndecidedRoad.GetTrainData = function(self)
  -- function num : 0_13
  if not (self._undecidedroad).trainData then
    return {}
  end
end

BM_UndecidedRoad.GetBossInfo = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local battleIds = ((self._undecidedroad).seasonData).battleIds
  if not battleIds or next(battleIds) == nil then
    LogError("BM_UndecidedRoad", "BattleIds is Not Exist")
    return 0
  end
  local CWeidingSort = (BeanManager.GetTableByName)("dungeonselect.cweidingsort")
  local result = {}
  if self:GetSeasonId() == 0 then
    return result
  end
  local weekdata = {id = 1, type = 100, cfg = CWeidingSort:GetRecorder(battleIds[100])}
  ;
  (table.insert)(result, weekdata)
  local curday = self:GetCurDay()
  for i = 1, curday do
    local temp = {id = i + 1, type = i, cfg = CWeidingSort:GetRecorder(battleIds[i + 1])}
    result[#result + 1] = temp
  end
  return result
end

BM_UndecidedRoad.GetBattleId = function(self, rankId)
  -- function num : 0_15 , upvalues : _ENV
  local battleIds = ((self._undecidedroad).seasonData).battleIds
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

BM_UndecidedRoad.GetRankId = function(self, rankId)
  -- function num : 0_16 , upvalues : _ENV
  local id = 0
  if rankId == 1 then
    id = 100
  else
    id = rankId
  end
  return tostring(self:GetSeasonId()) .. "|" .. tostring(id)
end

return BM_UndecidedRoad

