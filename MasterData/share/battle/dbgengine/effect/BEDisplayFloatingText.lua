local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEDisplayFloatingText, Super = System.NewClass("BEDisplayFloatingText", BattleEffectServer)

function BEDisplayFloatingText:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEDisplayFloatingText:Dispose()
  Super.Dispose(self)
end

function BEDisplayFloatingText:DoEffect()
  Super.DoEffect(self)
  local tipsId = self.params[1]
  for _, target in ipairs(self.targets) do
    self.battleEngine.recordMgr:OnFloatingText(target.uid, tipsId, bc.FloatingTextType.PositiveTextAndIcon, self.params[2] and {
      color = self.params[2]
    })
  end
  return true
end

return BEDisplayFloatingText
