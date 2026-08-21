local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster:_init(npc)
  self.npc = npc
  self.search = {}
  set_can_searched(self.npc, false)
  self.shoot_min_cooldown = 1
  self.shoot_max_cooldown = 2
  local room_id = get_cur_room_id()
  if 800501 == room_id then
    self.shoot_min_cooldown = 15
    self.shoot_max_cooldown = 20
  elseif 800502 == room_id then
    self.shoot_min_cooldown = 10
    self.shoot_max_cooldown = 20
  elseif 800503 == room_id then
    self.shoot_min_cooldown = 10
    self.shoot_max_cooldown = 20
  elseif 800504 == room_id then
    self.shoot_min_cooldown = 6
    self.shoot_max_cooldown = 12
  end
  local actSkills = {
    wait = {300109501},
    shoot = {300109502}
  }
  local actMoves = {}
  local nodes = {}
  monstBase._init(self, actSkills, actMoves, nodes)
  local states = self.states
  do
    local _ENV = states
    _ENV.root(_ENV.wait, _ENV.shoot, _ENV.decisionFailed)
  end
  states.wait.shoot = states.shoot
  
  function states.wait.start(wait)
    wait.base.start(wait)
    wait.timer = math.random(self.shoot_min_cooldown, self.shoot_max_cooldown) / 10
  end
  
  function states.wait.tickTrans(wait)
    wait.timer = wait.timer - 0.05
    if wait.timer <= 0 then
      return wait.shoot
    end
  end
  
  function states.wait.finTrans(wait)
    return wait.shoot
  end
  
  states.shoot.wait = states.wait
  
  function states.shoot.start(shoot)
    shoot.base.start(shoot)
  end
  
  function states.shoot.finTrans(shoot)
    return shoot.wait
  end
end

return monster
