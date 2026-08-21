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
      2020510101,
      0,
      0,
      0,
      99
    },
    Split = {
      2020510102,
      5,
      2 + 5 * math.random(),
      0,
      3,
      -60,
      60
    },
    Stab = {
      2020510103,
      0,
      0,
      0,
      4
    },
    Turn_Hit = {
      2020510104,
      0,
      0,
      0,
      4
    },
    Atk = {
      2020510105,
      12,
      0,
      0,
      3,
      -60,
      60
    },
    born_end = {
      2020510107,
      math.huge,
      0,
      0,
      2
    }
  }
  local nodes = {}
  local actMoves = {"Stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.gotTarget(_ENV.attack, _ENV.Turn_Back, _ENV.wander)
    _ENV.meleeAtk(_ENV.Split)
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
    
    local forward = monster.states.forward
    
    function forward.isReady(self_node)
      local monster = self_node.monster
      local distance = get_npc_distance(monster.npc, 1, monster.target, true)
      if monster.states.Atk.timer <= get_npc_time(monster.npc) or monster.states.Split.timer <= get_npc_time(monster.npc) then
        return distance > monster.wander.maxDis
      end
    end
  end
end

function monster.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  monster.base.on_target_self_skill_hit(monster, skill_id, caster, hit_type, missile_cfg, missile)
  if is_cast_skill_time(monster.npc, 2020510106, 1) then
    monster.born_hit = true
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
