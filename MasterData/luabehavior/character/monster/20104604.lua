local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 3,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    ATK1 = {
      2010460401,
      7,
      0,
      0,
      8,
      -45,
      45
    },
    ZiBao = {
      2010460202,
      0,
      9999
    }
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.ATK1, _ENV.ZiBao)
  end
  local states = monster.states
  
  function states.ZiBao.isReady(ZiBao)
    if get_sync_var(ZiBao) == true then
      return true
    else
      return false
    end
  end
end

function monster.on_born_behavior(monster)
  monster.base.on_born_behavior(monster)
  if get_npc_group_id(monster.npc) == 10410221 then
    monster.search.minDis = 2
    monster.search.maxDis = 5
  end
  if get_sync_var("qian_night") == true then
    monster.search.minDis = 4
    monster.search.maxDis = 4
  end
  if true == get_sync_var("qian_dark") then
    monster.search.minDis = 4
    monster.search.maxDis = 4
  end
end

function monster.on_target_self_magic_begin(monster, target, magic_id, is_self, magic_level)
  monster.base.on_target_self_magic_begin(monster, target, magic_id, is_self, magic_level)
  if 40104404 == magic_id then
    monster.search.minDis = 8
    monster.search.maxDis = 30
  end
end

return monster
