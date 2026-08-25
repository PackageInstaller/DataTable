local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEChangeMonsterName, Super = System.NewClass("BEChangeMonsterName", BattleEffectServer)

function BEChangeMonsterName:DoEffect()
  Super.DoEffect(self)
  local key = self.params[1]
  local targets = self.targets
  for _, target in ipairs(targets) do
    target:ChangeName(key)
  end
  return true
end

return BEChangeMonsterName
