local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BESubStateLayer, Super = System.NewClass("BESubStateLayer", BattleEffectServer)

function BESubStateLayer:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BESubStateLayer:Dispose()
  Super.Dispose(self)
end

function BESubStateLayer:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local stateId = self.params[1]
  local subValue = math.ceil(math.abs(self.params[2] or 1))
  if not targets or not stateId then
    return false
  end
  local originState
  if self.cmdServer.stateUid then
    originState = self.battleEngine:GetObj(self.cmdServer.stateUid)
  end
  for _, target in ipairs(targets) do
    local targetState = self.battleEngine.stateMgr:GetState(target, stateId)
    if targetState then
      local casterLayer2SubValueList
      if originState and originState.uid ~= targetState.uid then
        casterLayer2SubValueList = originState.data.casterLayerList or {}
      end
      targetState:SubLayer(subValue, casterLayer2SubValueList)
    end
  end
  return true
end

return BESubStateLayer
