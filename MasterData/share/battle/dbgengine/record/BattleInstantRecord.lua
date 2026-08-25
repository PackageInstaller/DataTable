local System = require("System.System")
local bc = require("Battle.BattleConst")
local BattleRenderEvent = require("Battle.DbgEngine.Event.BattleRenderEvent")
local BattleCommand = require("Battle.DbgEngine.Event.BattleCommand")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleInstantRecord, Super = System.NewClass("BattleInstantRecord", BattleEngineComponent)

function BattleInstantRecord:ctor(battleEngine)
  Super.ctor(self, battleEngine)
end

function BattleInstantRecord:Dispose()
  self.battleEngine = nil
end

function BattleInstantRecord:PushRecord(frameData)
  local recordData = {
    queueType = bc.BattleRecordQueueType.OneCut,
    frameList = {frameData}
  }
  self.battleEngine:SendCommand(BattleCommand.rd_BattleInstantCut, recordData)
end

function BattleInstantRecord:SendRecordList(frameList)
  table.insert(frameList, 1, {
    time = self.battleEngine:GetCurPassTime()
  })
  local recordData = {
    queueType = bc.BattleRecordQueueType.OneCut,
    frameList = frameList
  }
  self.battleEngine:SendCommand(BattleCommand.rd_BattleInstantCut, recordData)
end

function BattleInstantRecord:OnTurnCountDown(isShow, duration)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.TurnCountDown,
    data = {isShow = isShow, duration = duration}
  }
  self:PushRecord(frameData)
end

function BattleInstantRecord:OnFloatingText(roleUid, text, textType, args)
  local color
  if args then
    color = args.color
    args.color = nil
  end
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.FloatingText,
    data = {
      roleUid = roleUid,
      text = text,
      textType = textType,
      args = args,
      color = color
    }
  }
  self:PushRecord(frameData)
end

function BattleInstantRecord:OnUpdateStats(camp, statsData)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.UpdateStats,
    data = {camp = camp, statsData = statsData}
  }
  self:PushRecord(frameData)
end

function BattleInstantRecord:OnChangeDiePerform(roleUid, perform)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.ChangeDiePerform,
    data = {roleUid = roleUid, perform = perform}
  }
  self:PushRecord(frameData)
end

function BattleInstantRecord:OnPrivilegeLevelChanged(privilegeLevel)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.PrivilegeLevelChanged,
    data = {privilegeLevel = privilegeLevel}
  }
  self:PushRecord(frameData)
end

function BattleInstantRecord:OnSyncLives(lives)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SyncLives,
    data = {lives = lives}
  }
  self:PushRecord(frameData)
end

function BattleInstantRecord:OnSwitchTargetModel(playerUid, model)
  local frameData = {
    time = self.battleEngine:GetCurPassTime(),
    eventId = BattleRenderEvent.SwitchTargetModel,
    data = {playerUid = playerUid, model = model}
  }
  self:PushRecord(frameData)
end

return BattleInstantRecord
