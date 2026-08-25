local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BELastEffect, Super = System.NewClass("BELastEffect", BattleEffectServer)

function BELastEffect:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BELastEffect:Dispose()
  Super.Dispose(self)
end

function BELastEffect:DoEffect()
  Super.DoEffect(self)
  local executeCount = self.params[1] or 1
  if not self.cmdServer then
    return false
  end
  local lastEffectUid = self.cmdServer:GetLastEffect()
  if not lastEffectUid then
    return false
  end
  local lastEffect = self.battleEngine:GetObj(lastEffectUid)
  if not lastEffect then
    return false
  end
  for index = 1, executeCount do
    local effectObj = self.cmdServer:GenerateEffectObj(lastEffect.effectConfig.cmdCfg, nil, nil, index)
    if effectObj then
      effectObj:PreTrigger(self.cmdServer.triggerData)
    end
  end
  return true
end

return BELastEffect
