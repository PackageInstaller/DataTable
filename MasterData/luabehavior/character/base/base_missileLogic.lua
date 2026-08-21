local missileLogicBase = Util.create_class()

function missileLogicBase.new(base, unit, id, name)
  local result = setmetatable({}, base)
  result.base = base
  result.unit = unit
  result.tool = unit.tool
  result.id = id
  result.name = name
  result.cfg = ShareRes.create("skill.missile", id)
  return result
end

function missileLogicBase.insertFun(misLogic, funName, newFun)
  misLogic.tool.insert(misLogic, funName, newFun)
end

function missileLogicBase.removeFun(misLogic, funName, newFun)
  misLogic.tool.remove(misLogic, funName, newFun)
end

function missileLogicBase.onBegin(misLogic, misInst, caster, posX, posZ)
end

function missileLogicBase.befDamage(misLogic, misInst, caster, target, damageSign, damageType, targetCamp, changeTough, magicLv, magicId, skillId, misInst)
end

function missileLogicBase.onKill(misLogic, misInst, caster, target)
end

function missileLogicBase.onHit(misLogic, misInst, casterNpc, hitTarget, hitType, skill, partNpc)
end

function missileLogicBase.onEnd(misLogic, misInst, caster, posX, posZ)
end

function missileLogicBase.onCollideMis(misLogic, misInst, mis2, misCaster, mis2Caster)
end

function missileLogicBase.onCollideObs(misLogic, misInst, caster, obsType)
end

function missileLogicBase.onEnter(misLogic, misInst, caster, npc)
end

function missileLogicBase.onLeave(misLogic, misInst, caster, npc)
end

return missileLogicBase
