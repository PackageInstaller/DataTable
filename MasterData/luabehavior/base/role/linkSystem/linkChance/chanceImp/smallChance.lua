local chanceBase = import("base.role.linkSystem.linkChance.linkChance")
local smallChance = Util.create_child_mt(chanceBase)

function smallChance.setUp(smallChance)
  return chanceBase._setUp(smallChance)
end

function smallChance.consumeQte(chance, linkQte)
  chance.isQteEnable = false
  chance.chanceBase.consumeQte(chance, linkQte)
  local mgr = chance.linkMgr
  mgr:disableQteUi()
  return mgr:updateQteUi()
end

return smallChance
