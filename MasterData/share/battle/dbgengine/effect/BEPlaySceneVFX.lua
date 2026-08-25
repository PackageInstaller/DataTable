local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEPlaySceneVFX, Super = System.NewClass("BEPlaySceneVFX", BattleEffectServer)

function BEPlaySceneVFX:DoEffect()
  Super.DoEffect(self)
  local sceneVfxId = self.params[1]
  self.battleEngine.recordMgr:OnPlaySceneVFX(sceneVfxId)
  return true
end

return BEPlaySceneVFX
