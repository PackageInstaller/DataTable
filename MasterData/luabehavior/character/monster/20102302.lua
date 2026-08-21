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
  monster.search = {minDis = 100, maxDis = 100}
  local skills = {
    DoubleHit = {2010230201},
    FlyHit = {2010230202},
    Rotate = {2010230203},
    TailHit = {2010230204},
    Clap = {2010230205},
    DashOut = {2010230206},
    FlyCircle = {2010230207},
    Sniping = {2010230208},
    TrackingBall = {2010230209},
    Blink = {2010230210},
    TrackingMissile = {2010230211},
    DashAtk1 = {2010230212},
    Shoot = {2010230213},
    DoubleShoot = {2010230214}
  }
  local nodes = {}
  local actMoves = {"stand"}
  monstBase._init(monster, skills, actMoves, nodes)
  do
    local _ENV = monster.states
    _ENV.wander(_ENV.idle)
  end
  do
    local idle = monster.states.idle
    
    function idle.start(idle)
      lookat_npc(monster.npc, monster.target, false)
      stop_move(idle.monster.npc)
    end
  end
end

function monster.on_start(monster)
  monster.base.on_start(monster)
  change_follow_target_new(1, monster.npc, {
    10,
    10,
    {
      x = 0,
      y = 6,
      z = 3
    }
  })
end

function monster.on_magic_begin(monster, npc, target, magic_id, magic_level, magic_kind, magic_type)
  if 2010230101018 == magic_id then
    change_follow_target_new(0)
  end
end

return monster
