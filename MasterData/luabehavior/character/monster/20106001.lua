local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0,
    maxDis = 2,
    minTime = 1.6,
    maxTime = 1.6,
    type = "walk"
  }
  local t = monster.create_skill_node_cfg
  local actSkills = {
    HeadButt = t(2010600101, 3, 0, 0, 3, -60, 60),
    Charge = t(2010600102, 15, 0, 0, 10, -60, 60)
  }
  local nodes = {"moveState"}
  local actMoves = {"stand"}
  monstBase._init(monster, actSkills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.Charge, _ENV.HeadButt)
    _ENV.wander(_ENV.moveState)
    _ENV.moveState(_ENV.forward, _ENV.backward, _ENV.stand)
  end
  do
    local moveState = monster.states.moveState
    local stand = monster.states.stand
    
    function moveState.isReady(moveState)
      return true
    end
    
    function stand.start(stand)
      stop_move(stand.monster.npc)
    end
    
    function stand.tick(stand)
      lookat_npc(monster.npc, monster.target, false)
    end
    
    function stand.tickTrans(stand)
      local forward = stand.monster.states.forward
      local backward = stand.monster.states.backward
      if forward.base.isReady(forward) then
        return forward
      end
      if backward.base.isReady(backward) then
        return backward
      end
    end
  end
end

function monster.on_self_missile_collide(monster, otherNpc, self_missile, other_missile, self_missile_cfg, other_missile_cfg)
  if missile_has_hurt_magic(other_missile) and self_missile_cfg.Id == 201060010203 then
    remove_missile(self_missile, true)
  end
end

return monster
