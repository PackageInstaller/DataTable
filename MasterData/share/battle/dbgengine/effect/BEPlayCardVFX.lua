local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local bc = require("Battle.BattleConst")
local BEPlayCardVFX, Super = System.NewClass("BEPlayCardVFX", BattleEffectServer)

function BEPlayCardVFX:DoEffect()
  Super.DoEffect(self)
  local vfx = self.params[1]
  local uids = {}
  for _, target in ipairs(self.targets) do
    table.insert(uids, target.uid)
  end
  self.battleEngine.recordMgr:OnPlayCardVFX(uids, vfx)
  return true
end

return BEPlayCardVFX
