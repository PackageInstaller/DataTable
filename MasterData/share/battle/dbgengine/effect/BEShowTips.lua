local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEShowTips, Super = System.NewClass("BEShowTips", BattleEffectServer)

function BEShowTips:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEShowTips:Dispose()
  Super.Dispose(self)
end

function BEShowTips:DoEffect()
  Super.DoEffect(self)
  local tipsId = self.params[1]
  local showTime = self.params[2] or 1000
  if not tipsId then
    return false
  end
  self.battleEngine.recordMgr:OnShowTips(tipsId, showTime)
  return true
end

return BEShowTips
