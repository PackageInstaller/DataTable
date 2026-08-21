local chanceBase = import("base.role.linkSystem.linkChance.linkChance")
local bigChance = Util.create_child_mt(chanceBase)

function bigChance.setUp(bigChance)
  chanceBase._setUp(bigChance)
  local bigChance = bigChance
  bigChance.castRecord = {}
  bigChance.isFirstQte = true
end

function bigChance.isReady(chance, linkQte)
  if not chance.chanceBase.isReady(chance, linkQte) then
    return false
  end
  return not chance.castRecord[linkQte.role.npc]
end

function bigChance.consumeQte(chance, linkQte)
  if chance.isFirstQte then
    chance.isFirstQte = false
    chance.chanceBase.consumeQte(chance, linkQte)
  end
  chance.castRecord[linkQte.role.npc] = true
  local mgr = chance.linkMgr
  mgr:disableQteUi(linkQte.role)
  return mgr:updateQteUi()
end

function bigChance.disable(chance)
  UtilTable.clear_map(chance.castRecord)
  chance.isFirstQte = false
  return chance.chanceBase.disable(chance)
end

function bigChance.enable(chance)
  UtilTable.clear_map(chance.castRecord)
  chance.isFirstQte = true
  return chance.chanceBase.enable(chance)
end

return bigChance
