-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_offlinesweep.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_OfflineSweep = class("DM_OfflineSweep")
local CNotice = (BeanManager.GetTableByName)("notice.cnotice")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local CResourceDungeonStage = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstage")
local CStarrymirrorlevel = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel")
local CSRFunction = (BeanManager.GetTableByName)("activity.csrfunction")
local CSRResourceDungeonStage = (BeanManager.GetTableByName)("activity.csrresourcedungeonstage")
local GetCurrent = function(lefttime, interval, totalNum)
  -- function num : 0_0 , upvalues : _ENV
  if lefttime > 0 then
    return totalNum - (math.ceil)(lefttime / interval)
  end
  return totalNum
end

local GetIntervalTime = function(id, battleType)
  -- function num : 0_1 , upvalues : CResourceDungeonStage, CBattleStartProtocol, CStarrymirrorlevel, CSRFunction, CSRResourceDungeonStage, _ENV
  local recorder = CResourceDungeonStage:GetRecorder(id)
  if battleType == CBattleStartProtocol.STARRY_MIRROR then
    recorder = CStarrymirrorlevel:GetRecorder(id)
  end
  do
    if battleType == CBattleStartProtocol.SUMMER_ECHO then
      local tempRecord = CSRFunction:GetRecorder(id)
      recorder = CSRResourceDungeonStage:GetRecorder(tempRecord.levelID)
    end
    if recorder then
      return recorder.mopupTime
    else
      LogErrorFormat("DM_OfflineSweep", "GetIntervalTime(I%s)", id)
      return 0
    end
  end
end

local SetProcess = function(self, protocol)
  -- function num : 0_2 , upvalues : GetIntervalTime, GetCurrent, _ENV
  if protocol.status == 1 then
    local process = {}
    process.id = protocol.id
    process.battleType = protocol.battleType
    process.leftTime = protocol.leftTime
    process.interval = GetIntervalTime(process.id, protocol.battleType)
    process.currentTime = GetCurrent(protocol.leftTime, process.interval * 1000, protocol.totalNum)
    process.totalNum = protocol.totalNum
    process.receivedNum = protocol.receivedNum
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

    if process.interval ~= 0 then
      (self._data).process = process
    else
      LogErrorFormat("DM_OfflineSweep", " process[%s].interval == 0", protocol.id)
    end
  else
    do
      if protocol.status == 2 then
        local process = {}
        process.id = protocol.id
        process.battleType = protocol.battleType
        process.currentTime = protocol.totalNum
        process.totalNum = protocol.totalNum
        process.receivedNum = protocol.receivedNum
        -- DECOMPILER ERROR at PC53: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (self._data).process = process
      else
        do
          if protocol.status == 0 then
            for k,v in ipairs((self._data).process) do
              -- DECOMPILER ERROR at PC65: Confused about usage of register: R7 in 'UnsetPending'

              ((self._data).process)[k] = nil
            end
          end
        end
      end
    end
  end
end

DM_OfflineSweep.Ctor = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._data = (NekoData.Data).offlineSweep
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).process = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).status = 0
  self._timeCheck = 1
  self._timeCount = 0
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).leftNum = 0
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

DM_OfflineSweep.OnUpdate = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV, GetCurrent
  if (self._data).status ~= 1 or next((self._data).process) == nil then
    return 
  end
  self._timeCount = self._timeCount + (notification.userInfo).unscaledDeltaTime
  if self._timeCount < self._timeCheck then
    return 
  end
  local check = self._timeCheck
  if self._timeCheck < (notification.userInfo).unscaledDeltaTime then
    check = (math.ceil)(self._timeCount)
  end
  self._timeCount = self._timeCount - check
  local process = (self._data).process
  process.leftTime = process.leftTime - check * 1000
  local currentTime = GetCurrent(process.leftTime, process.interval * 1000, process.totalNum)
  if currentTime ~= process.currentTime then
    process.currentTime = currentTime
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

    if currentTime == process.totalNum then
      (self._data).status = 2
    end
  end
end

DM_OfflineSweep.Clear = function(self)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).status = 0
  for k,v in ipairs((self._data).process) do
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

    ((self._data).process)[k] = nil
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._data).leftNum = 0
end

DM_OfflineSweep.OnSOfflineSweepInfo = function(self, protocol)
  -- function num : 0_6 , upvalues : SetProcess
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).leftNum = protocol.leftNum
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).status = protocol.status
  SetProcess(self, protocol)
  self:CheckClientPush()
end

DM_OfflineSweep.OnSSweepResult = function(self, protocol)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  (self._data).playerExp = protocol.playerExp
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).awardList = protocol.itemList
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).currency = protocol.money
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).roleExp = protocol.roleExp
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).roleGoodExp = protocol.roleGoodExp
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).rolesIndex = protocol.rolesIndex
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._data).restituteReward = protocol.restituteReward
end

DM_OfflineSweep.CheckClientPush = function(self)
  -- function num : 0_8 , upvalues : _ENV, CNotice
  local needNotification = ((NekoData.BehaviorManager).BM_Game):GetIfNeedOfflineSweepNotification()
  if (self._data).status ~= 1 or ((self._data).process).leftTime == nil or ((self._data).process).leftTime <= 0 then
    do
      local canTimeWorker = not needNotification
      if canTimeWorker then
        local spiritNoticeRecorder = CNotice:GetRecorder(4)
        if spiritNoticeRecorder then
          ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).CancelSchedulingWorkerByType)("offlinesweep")
          LogInfoFormat("DM_OfflineSweep", "open the notification : scheduling activity offlinesweep worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "offlinesweep", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), ((self._data).process).leftTime / 1000)
          ;
          ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).SetPushNotification)(spiritNoticeRecorder.id, "offlinesweep", (TextManager.GetText)(spiritNoticeRecorder.titleID), (TextManager.GetText)(spiritNoticeRecorder.detailsID), ((self._data).process).leftTime / 1000, (TextManager.GetText)(spiritNoticeRecorder.titleID))
        end
      else
        ((((CS.PixelNeko).Lua).SchedulingPushStaticFunctions).CancelSchedulingWorkerByType)("offlinesweep")
      end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
end

return DM_OfflineSweep

