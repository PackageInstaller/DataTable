local System = require("System.System")
local bc = require("Battle.BattleConst")
local BP = bc.BattleProperty
local BattleCommand = require("Battle.DbgEngine.Event.BattleCommand")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleSnapshotMgr, Super = System.NewClass("BattleSnapshotMgr", BattleEngineComponent)

function BattleSnapshotMgr:ctor(battleEngine)
  Super.ctor(self, battleEngine)
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFSaveSnapshot, self.OnSaveSnapshot, self)
  local battleData = battleEngine.initData
  self.battleReview = {
    battleData = battleData,
    records = {},
    recordZips = {},
    resourceRecords = battleEngine.resourceCache and battleEngine.resourceCache.records or {},
    startTime = os.time(),
    boutMaxVersionMap = {}
  }
end

function BattleSnapshotMgr:OnSaveSnapshot()
  if self.battleEngine.data.needReview then
    local boutMgr = self.battleEngine.boutMgr
    local currentBoutNumber = boutMgr:GetBoutNum()
    self:FlushReviewRecord(currentBoutNumber - 1)
  end
  if self.battleEngine:ShouldSaveBoutSnapshot() then
    self.battleEngine:Debug("OnSaveSnapshot begin 1111111111111111111111")
    self.battleEngine:SaveSnapShot()
    self.battleEngine:Debug("OnSaveSnapshot end 1111111111111111111111")
  end
end

function BattleSnapshotMgr:ctorData()
  if not self.battleEngine.data[self.__name] then
    self.battleEngine.data[self.__name] = {
      boutNumberToSnapshot = {},
      snapshotBoutList = {}
    }
  end
  return self.battleEngine.data[self.__name]
end

function BattleSnapshotMgr:TakeAtBoutStart(snapshot)
  if not snapshot or not snapshot.boutMgr then
    self.battleEngine:Error("TakeAtBoutStart 失败: snapshot 或 boutMgr 为空")
    return
  end
  local boutNumber = snapshot.boutMgr.boutNumber
  if not boutNumber then
    self.battleEngine:Error("TakeAtBoutStart 失败: boutNumber 为空")
    return
  end
  if snapshot.boutMgr.isExtraBout then
    self.battleEngine:Debug("TakeAtBoutStart 跳过超维回合快照: 回合 %s", boutNumber)
    return
  end
  local maxBacktrackRounds = self.battleEngine.battleDT.GetConstant("MaxBacktrackRounds", 25)
  if boutNumber > maxBacktrackRounds then
    self.battleEngine:Info("TakeAtBoutStart 跳过超出回溯回合数: 回合 %s", boutNumber)
    return
  end
  local isNewBout = self.data.boutNumberToSnapshot[boutNumber] == nil
  self.data.boutNumberToSnapshot[boutNumber] = snapshot
  if isNewBout then
    table.insert(self.data.snapshotBoutList, boutNumber)
  end
  local maxRewindBout = self:GetMaxRewindBout()
  local player = self.battleEngine.roleMgr:GetPlayer(bc.BattleCamp.Camp1)
  if player then
    player:SetProperty(BP.rewind_bout, maxRewindBout, {
      reason = bc.PropertyChangeReason.AttrSet
    })
  end
  self.battleEngine:Info("TakeAtBoutStart 快照已保存: 回合 %s (最大可回溯: %s)", boutNumber, maxRewindBout)
end

function BattleSnapshotMgr:Has(boutNumber)
  return self.data.boutNumberToSnapshot[boutNumber] ~= nil
end

function BattleSnapshotMgr:Get(boutNumber)
  return self.data.boutNumberToSnapshot[boutNumber]
end

function BattleSnapshotMgr:GetAvailableBouts()
  do return table.deepclone end
  return table.deepclone, self.data.snapshotBoutList
end

function BattleSnapshotMgr:GetSnapshotCount()
  return #self.data.snapshotBoutList
end

function BattleSnapshotMgr:GetMaxRewindBout()
  local maxBout = 0
  for boutNumber in pairs(self.data.boutNumberToSnapshot) do
    if boutNumber > maxBout then
      maxBout = boutNumber
    end
  end
  return maxBout
end

function BattleSnapshotMgr:ClearAll()
  self.data.boutNumberToSnapshot = {}
  self.data.snapshotBoutList = {}
  self.battleEngine:Info("所有快照已清空")
end

function BattleSnapshotMgr:InsertReviewRecord(msgId, msgData)
  if not self.battleEngine.data.needReview then
    return
  end
  if self.battleEngine.recovering then
    return
  end
  if msgId == BattleCommand.rd_CommandResult or msgId == BattleCommand.lg_RewindToBout or msgId == BattleCommand.rd_RecoverBattle then
    return
  end
  local currentBoutNumber = self.battleEngine.boutMgr:GetBoutNum()
  if currentBoutNumber > bc.reviewBoutLimit then
    self.battleEngine.logger:DebugS("BattleSnapshotMgr:InsertReviewRecord, bout limit reached {cur}", currentBoutNumber)
    return
  end
  table.insert(self.battleReview.records, {
    time = os.time(),
    msgId = msgId,
    msgData = msgData
  })
end

function BattleSnapshotMgr:FlushReviewRecord(boutNumber)
  local boutMaxVersionMap = self.battleReview.boutMaxVersionMap
  local version = (boutMaxVersionMap[boutNumber] or 0) + 1
  boutMaxVersionMap[boutNumber] = version
  local preVersion = boutMaxVersionMap[boutNumber - 1] or 0
  local dataSize = 0
  local MsgPack = require("cmsgpack")
  local Lz4 = require("lz4")
  local records = self.battleReview.records
  local data = MsgPack.pack(records)
  local compressed = Lz4.compress(data)
  dataSize = #compressed
  local recordZips = self.battleReview.recordZips
  local oneRecord = {
    preVersion = preVersion,
    version = version,
    boutNumber = boutNumber,
    data = compressed
  }
  if not recordZips[boutNumber] then
    recordZips[boutNumber] = {}
  end
  recordZips[boutNumber][version] = oneRecord
  self.battleReview.records = {}
  self.battleEngine:Info(string.format("FlushReviewRecord 回合:%s 版本:%s 指令数:%s 数据大小:%s", boutNumber, version, #records, dataSize))
end

function BattleSnapshotMgr:OnRewind(currentBoutNumber, targetBoutNumber)
  local battleReview = self.battleReview
  battleReview.records = {}
  self.battleEngine:Info(string.format("OnRewind 从回合:%s 回溯到回合:%s, 最新版本:%s", currentBoutNumber, targetBoutNumber, battleReview.boutMaxVersionMap[targetBoutNumber]))
end

function BattleSnapshotMgr:GetVersionStamp(boutNumber)
  local boutMaxVersionMap = self.battleReview.boutMaxVersionMap
  return {
    version = (boutMaxVersionMap[boutNumber] or 0) + 1,
    preVersion = boutMaxVersionMap[boutNumber - 1] or 0
  }
end

function BattleSnapshotMgr:GetValidRecordZips(boutNumber)
  local battleReview = self.battleReview
  local recordZips = battleReview.recordZips
  local validRecordZips = {}
  local version = battleReview.boutMaxVersionMap[boutNumber]
  for i = boutNumber, 0, -1 do
    local record = recordZips[i][version]
    table.insert(validRecordZips, record.data)
    version = record.preVersion
  end
  local result = {}
  for i = #validRecordZips, 1, -1 do
    table.insert(result, validRecordZips[i])
  end
  return result
end

function BattleSnapshotMgr:SaveBattleReview()
  local svrBattleEntity = self.battleEngine:GetSvrBattleEntity()
  if not svrBattleEntity then
    return
  end
  local ServerUtil = require("ServerUtil")
  local reviewEnv = ServerUtil.GetEnv("battle_review")
  if not reviewEnv then
    return
  end
  if self._isSaveBattleReview then
    return
  end
  self._isSaveBattleReview = true
  if self.battleEngine.data.needReview then
    local finalBoutNumber = self.battleEngine.boutMgr:GetBoutNum()
    self:FlushReviewRecord(finalBoutNumber)
    local validRecordZips = self:GetValidRecordZips(finalBoutNumber)
    local finalBattleReview = {
      battleData = self.battleReview.battleData,
      recordZips = validRecordZips,
      resourceRecords = self.battleReview.resourceRecords,
      startTime = self.battleReview.startTime
    }
    self.battleEngine:Info(string.format("SaveBattleReview 总回合数:%s, 保存回合数:%s", finalBoutNumber, #validRecordZips))
    svrBattleEntity:SaveBattleReview(finalBattleReview)
  end
end

function BattleSnapshotMgr:Dispose()
  self:ClearAll()
  Super.Dispose(self)
end

return BattleSnapshotMgr
