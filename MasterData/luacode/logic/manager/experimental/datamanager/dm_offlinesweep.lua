local DM_OfflineSweep = class("DM_OfflineSweep")
local CNotice = BeanManager.GetTableByName("notice.cnotice")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local CResourceDungeonStage = BeanManager.GetTableByName("dungeonselect.cresourcedungeonstage")
local CStarrymirrorlevel = BeanManager.GetTableByName("dungeonselect.cstarrymirrorlevel")
local CSRFunction = BeanManager.GetTableByName("activity.csrfunction")
local CSRResourceDungeonStage = BeanManager.GetTableByName("activity.csrresourcedungeonstage")

local function GetCurrent(lefttime, interval, totalNum)
  if 0 < lefttime then
    return totalNum - math.ceil(lefttime / interval)
  end
  return totalNum
end

local function GetIntervalTime(id, battleType)
  local recorder = CResourceDungeonStage:GetRecorder(id)
  if battleType == CBattleStartProtocol.STARRY_MIRROR then
    recorder = CStarrymirrorlevel:GetRecorder(id)
  end
  if battleType == CBattleStartProtocol.SUMMER_ECHO then
    local tempRecord = CSRFunction:GetRecorder(id)
    recorder = CSRResourceDungeonStage:GetRecorder(tempRecord.levelID)
  end
  if battleType == CBattleStartProtocol.CHRISTMAS then
    return 1
  end
  if battleType == CBattleStartProtocol.LOVER then
    return 1
  end
  if recorder then
    return recorder.mopupTime
  else
    LogErrorFormat("DM_OfflineSweep", "GetIntervalTime(I%s)", id)
    return 0
  end
end

local function SetProcess(self, protocol)
  if protocol.status == 1 then
    local process = {}
    process.id = protocol.id
    process.battleType = protocol.battleType
    process.leftTime = protocol.leftTime
    process.interval = GetIntervalTime(process.id, protocol.battleType)
    process.currentTime = GetCurrent(protocol.leftTime, process.interval * 1000, protocol.totalNum)
    process.totalNum = protocol.totalNum
    process.receivedNum = protocol.receivedNum
    if process.interval ~= 0 then
      self._data.process = process
    else
      LogErrorFormat("DM_OfflineSweep", " process[%s].interval == 0", protocol.id)
    end
  elseif protocol.status == 2 then
    local process = {}
    process.id = protocol.id
    process.battleType = protocol.battleType
    process.currentTime = protocol.totalNum
    process.totalNum = protocol.totalNum
    process.receivedNum = protocol.receivedNum
    self._data.process = process
  elseif protocol.status == 0 then
    for k, v in ipairs(self._data.process) do
      self._data.process[k] = nil
    end
  end
end

function DM_OfflineSweep:Ctor()
  self._data = NekoData.Data.offlineSweep
  self._data.process = {}
  self._data.status = 0
  self._timeCheck = 1
  self._timeCount = 0
  self._data.leftNum = 0
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function DM_OfflineSweep:OnUpdate(notification)
  if self._data.status ~= 1 or next(self._data.process) == nil then
    return
  end
  self._timeCount = self._timeCount + notification.userInfo.unscaledDeltaTime
  if self._timeCount < self._timeCheck then
    return
  end
  local check = self._timeCheck
  if notification.userInfo.unscaledDeltaTime > self._timeCheck then
    check = math.ceil(self._timeCount)
  end
  self._timeCount = self._timeCount - check
  local process = self._data.process
  process.leftTime = process.leftTime - check * 1000
  local currentTime = GetCurrent(process.leftTime, process.interval * 1000, process.totalNum)
  if currentTime ~= process.currentTime then
    process.currentTime = currentTime
    if currentTime == process.totalNum then
      self._data.status = 2
    end
  end
end

function DM_OfflineSweep:Clear()
  self._data.status = 0
  for k, v in ipairs(self._data.process) do
    self._data.process[k] = nil
  end
  self._data.leftNum = 0
end

function DM_OfflineSweep:OnSOfflineSweepInfo(protocol)
  self._data.leftNum = protocol.leftNum
  self._data.status = protocol.status
  SetProcess(self, protocol)
  self:CheckClientPush()
end

function DM_OfflineSweep:OnSSweepResult(protocol)
  self._data.playerExp = protocol.playerExp
  self._data.awardList = protocol.itemList
  self._data.currency = protocol.money
  self._data.roleExp = protocol.roleExp
  self._data.roleGoodExp = protocol.roleGoodExp
  self._data.rolesIndex = protocol.rolesIndex
  self._data.restituteReward = protocol.restituteReward
end

function DM_OfflineSweep:CheckClientPush()
  local needNotification = NekoData.BehaviorManager.BM_Game:GetIfNeedOfflineSweepNotification()
  if needNotification then
    local canTimeWorker = self._data.status == 1 and self._data.process.leftTime ~= nil and self._data.process.leftTime > 0
    if canTimeWorker then
      local spiritNoticeRecorder = CNotice:GetRecorder(4)
      if spiritNoticeRecorder then
        CS.PixelNeko.Lua.SchedulingPushStaticFunctions.CancelSchedulingWorkerByType("offlinesweep")
        LogInfoFormat("DM_OfflineSweep", "open the notification : scheduling activity offlinesweep worker messageid %s type %s title %s content %s time %s", spiritNoticeRecorder.id, "offlinesweep", TextManager.GetText(spiritNoticeRecorder.titleID), TextManager.GetText(spiritNoticeRecorder.detailsID), self._data.process.leftTime / 1000)
        CS.PixelNeko.Lua.SchedulingPushStaticFunctions.SetPushNotification(spiritNoticeRecorder.id, "offlinesweep", TextManager.GetText(spiritNoticeRecorder.titleID), TextManager.GetText(spiritNoticeRecorder.detailsID), self._data.process.leftTime / 1000, TextManager.GetText(spiritNoticeRecorder.titleID))
      end
    else
      CS.PixelNeko.Lua.SchedulingPushStaticFunctions.CancelSchedulingWorkerByType("offlinesweep")
    end
  end
end

return DM_OfflineSweep
