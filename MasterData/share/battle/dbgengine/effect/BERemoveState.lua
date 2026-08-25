local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BERemoveState, Super = System.NewClass("BERemoveState", BattleEffectServer)

function BERemoveState:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BERemoveState:Dispose()
  Super.Dispose(self)
end

function BERemoveState:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local stateId = self.params[1]
  local param2 = self.params[2] or 0
  local showText = 0 ~= param2
  if not targets or not stateId then
    return false
  end
  local stateMgr = self.battleEngine.stateMgr
  for _, target in ipairs(targets) do
    local state = stateMgr:GetState(target, stateId)
    if not state or state.isDeleted then
    else
      stateMgr:RemoveState(state, showText)
    end
  end
  return true
end

return BERemoveState
