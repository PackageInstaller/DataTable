local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 1,
    minTime = 0.5,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    Turn_Back = {
      2010510101,
      0,
      0,
      0,
      99
    },
    Split = {
      2010510102,
      9,
      3,
      0,
      3,
      -60,
      60
    },
    Stab = {
      2010510103,
      0,
      0,
      0,
      4
    },
    Turn_Hit = {
      2010510104,
      0,
      0,
      0,
      4
    },
    Atk = {
      2010510105,
      5,
      0,
      0,
      3,
      -60,
      60
    },
    born_end = {
      2010510107,
      math.huge,
      0,
      0,
      0
    }
  }
  local nodes = {}
  local actMoves = {"Stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.attack, _ENV.Turn_Back, _ENV.wander)
    _ENV.meleeAtk(_ENV.Split(_ENV.Stab, _ENV.Turn_Hit))
    _ENV.rangedAtk(_ENV.Atk)
    _ENV.wander(_ENV.forward, _ENV.Stand)
  end
  do
    local Turn_Back = monster.states.Turn_Back
    local Stand = monster.states.Stand
    local wander = monster.states.wander
    
    function Turn_Back.isReady(Turn_Back)
      if not Turn_Back.monster.target then
        return false
      end
      local AngleToPlayer = get_target_angel(Turn_Back.monster.npc, Turn_Back.monster.target, true)
      if AngleToPlayer > 90 or AngleToPlayer < -90 then
        return true
      end
    end
    
    function Turn_Back.finTrans(Turn_Back)
      return monster.states.wander
    end
    
    function Stand.start(Stand)
      stop_move(Stand.monster.npc)
      lookat_npc(Stand.monster.npc, Stand.monster.target)
    end
    
    function Stand.tickTrans(Stand)
      local Turn_Back = Stand.monster.states.Turn_Back
      if Turn_Back.isReady(Turn_Back) then
        return Turn_Back
      end
      if get_npc_distance(monster.npc, 1, monster.target, true) > monster.wander.maxDis then
        return monster.states.wander
      end
    end
    
    function wander.tickTrans(wander)
      local monster = wander.monster
      local states = monster.states
      if not monster.target then
        return states.noTarget
      end
      if Turn_Back.isReady(Turn_Back) then
        return Turn_Back
      end
      if states.attack then
        return monster.tree:chooseChildAction(states.attack)
      end
    end
  end
  do
    local Stab = monster.states.Stab
    local Turn_Hit = monster.states.Turn_Hit
    
    function Turn_Hit.isReady(Turn_Hit)
      if not monster.target then
        return false
      end
      local AngleToPlayer = get_target_angel(Turn_Hit.monster.npc, Turn_Hit.monster.target, true)
      if AngleToPlayer > 90 or AngleToPlayer < -90 then
        return Turn_Hit.base.isReady(Turn_Hit)
      end
      return false
    end
    
    function Stab.isReady(Stab)
      if not monster.target then
        return false
      end
      local AngleToPlayer = get_target_angel(Stab.monster.npc, Stab.monster.target, true)
      if AngleToPlayer <= 90 and AngleToPlayer >= -90 then
        return Stab.base.isReady(Stab)
      end
      return false
    end
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  if is_cast_skill_time(monster.npc, 2010510106, 1) then
    monster.born_hit = true
  end
  if 300106301 == skill_id then
    cast_magic(monster.npc, monster.npc, 201051010207, 1)
  end
end

function monster.on_born_behavior(monster)
  monster.base.on_born_behavior(monster)
  if get_sync_var("qian_dark") == true then
    monster.search.minDis = 4
    monster.search.maxDis = 4
  end
end

return monster
