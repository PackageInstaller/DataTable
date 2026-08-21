local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.5,
    maxDis = 4,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    skill01 = {
      2010350201,
      3,
      3,
      0,
      3,
      -60,
      60
    },
    skill02 = {
      2010350202,
      7,
      3,
      1,
      6,
      -45,
      45
    },
    counterskill02 = {
      2010350202,
      0,
      0,
      0,
      4,
      nil,
      nil,
      nil
    }
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.skill01)
    _ENV.rangedAtk(_ENV.skill02)
    _ENV.meleeCounter(_ENV.counterskill02)
  end
  do
    local root = monster.states.root
    
    function root.start(root)
      local self = root.monster
      set_npc_controller(self.npc, 1)
      cast_magic(self.npc, self.npc, 20103502011, 0)
    end
  end
end

function monster.go_mad(monster)
  monster.base.go_mad(monster)
  monster.states.skill01.cd = 2
  monster.states.skill02.cd = 5
  monster.wander.maxDis = 3
  monster.wander.minDis = 0.5
  monster.states.attack.interval = 1
end

return monster
