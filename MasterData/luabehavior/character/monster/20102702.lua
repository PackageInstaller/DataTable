local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1,
    maxDis = 8,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    skill02 = {
      2010270102,
      0,
      1,
      0,
      999
    }
  }
  local actMoves = {"Blink"}
  monstBase._init(monster, skills, actMoves, nil)
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.attack, _ENV.wander)
    _ENV.freeAtk(_ENV.skill02)
  end
end

function monster.on_self_magic_end(monster, target, magic_id)
  if 20102701009 == magic_id then
    abort_magic_by_id(monster.npc, Const.LOCK_MASK, 1)
    abort_magic_by_id(monster.npc, 100104, 1)
    abort_magic_by_id(monster.npc, 20102701007, 1)
    abort_magic_by_id(monster.npc, 20102701006, 1)
    abort_magic_by_id(monster.npc, 20102701005, 1)
  end
  if 20102701008 == magic_id then
    enable_shadow(monster.npc, true)
    set_npc_hp_visible(monster.npc, true)
  end
end

return monster
