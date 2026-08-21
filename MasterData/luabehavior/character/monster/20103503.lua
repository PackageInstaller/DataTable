local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1,
    maxDis = 5,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    skill01 = {
      2010350301,
      5,
      3,
      2,
      7,
      -60,
      60
    },
    skill02 = {
      2010350302,
      5,
      3,
      0,
      3,
      -45,
      45
    },
    counterskill01 = {
      2010350301,
      0,
      0,
      0,
      3,
      nil,
      nil,
      nil,
      3,
      1
    }
  }
  monstBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.skill02)
    _ENV.rangedAtk(_ENV.skill01)
    _ENV.meleeCounter(_ENV.counterskill01)
  end
  monster.states.skill02(monster.states.skill01)
  do
    local root = monster.states.root
    
    function root.start(root)
      local self = root.monster
      set_npc_controller(self.npc, 2)
      cast_magic(self.npc, self.npc, 20103503011, 0)
    end
  end
end

function monster.go_mad(monster)
  monster.base.go_mad(monster)
  monster.states.skill02.cd = 2
  monster.states.skill01.cd = 3
  monster.wander.maxDis = 3
  monster.wander.minDis = 0.5
  monster.states.attack.interval = 1
end

return monster
