local System = require("System.System")
local BattleEngineComponent = require("Battle.Ecs.BattleEngineComponent")
local BattleCommand = require("Battle.DbgEngine.Event.BattleCommand")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BattleAIMgrServerPVP, Super = System.NewClass("BattleAIMgrServerPVP", BattleEngineComponent)
local AI_INTERVAL = 0.5

function BattleAIMgrServerPVP:ctor(battleEngine)
  Super.ctor(self, battleEngine)
  self.cache = {}
end

function BattleAIMgrServerPVP:RegisterCallbacks()
  self.battleEngine:RegisterEvent(BattleLogicEvent.BFAfterBoutEnd, self.OnBoutEnd, self)
end

function BattleAIMgrServerPVP:StartAI(camp)
  self:AddNeedWaitTime(2)
  local timer = self.battleEngine:GetTimer()
  timer:AddRepeatTimer("AITimer", AI_INTERVAL, function()
    self:AIAction(camp)
  end)
end

function BattleAIMgrServerPVP:GetRandomWaitTime()
  local list = self.battleEngine.battleDT.GetOriginalConstant("PVPAIDiscardInterval")
  local t = 1
  if list and #list > 0 then
    t = list[math.random(#list)]
  end
  return t
end

function BattleAIMgrServerPVP:AddNeedWaitTime(t)
  self.cache.needWaitTime = (self.cache.needWaitTime or 0) + t
end

function BattleAIMgrServerPVP:AIAction(camp)
  self.cache.needWaitTime = self.cache.needWaitTime or 0
  self.cache.needWaitTime = self.cache.needWaitTime - AI_INTERVAL
  if self.cache.needWaitTime <= 0 then
    self.cache.needWaitTime = 0
    self:AddNeedWaitTime(self:GetRandomWaitTime())
    local player = self.battleEngine.roleMgr:GetPlayer(camp)
    self.battleEngine:OnReceiveCommand(BattleCommand.lg_RobotAction, {
      playerId = player:GetData("playerId")
    })
  end
end

function BattleAIMgrServerPVP:OnBoutEnd()
  local timer = self.battleEngine:GetTimer()
  timer:RemoveTimer("AITimer")
  self.cache = {}
end

return BattleAIMgrServerPVP
