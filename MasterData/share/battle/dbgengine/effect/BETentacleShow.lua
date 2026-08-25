local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BETentacleShow, Super = System.NewClass("BETentacleShow", BattleEffectServer)

function BETentacleShow:ctor(battleEngine, effectConfig, effectArgs)
  Super.ctor(self, battleEngine, effectConfig, effectArgs)
end

function BETentacleShow:DoEffect()
  Super.DoEffect(self)
  local num = self.params[1] or 1
  local camp
  if self.cmdServer then
    camp = self.cmdServer:GetCasterCamp()
  else
    camp = self.battleEngine.boutMgr:GetCurCamp()
  end
  local player = self.battleEngine.roleMgr:GetPlayer(camp)
  self.battleEngine.recordMgr:OnTentacleAttack(player.uid, num, self:GetTargetUids())
  return true
end

return BETentacleShow
