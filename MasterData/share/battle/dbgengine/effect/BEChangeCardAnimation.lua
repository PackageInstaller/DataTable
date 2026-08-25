local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BEChangeCardAnimation, Super = System.NewClass("BEChangeCardAnimation", BattleEffectServer)

function BEChangeCardAnimation:DoEffect()
  Super.DoEffect(self)
  if next(self.targets) == nil then
    return false
  end
  local performSkillId = self.params[1]
  for _, changeCard in ipairs(self.targets) do
    changeCard.data.performSkillId = performSkillId
  end
  return true
end

return BEChangeCardAnimation
