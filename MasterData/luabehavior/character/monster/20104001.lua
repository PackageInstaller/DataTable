local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local counter_move = {
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  5,
  5,
  5,
  5,
  5,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1
}

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.5,
    maxDis = 8,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  local skills = {
    skill01 = {
      2010400101,
      8,
      math.random(2, 6),
      0,
      8
    },
    skill02 = {
      2010400102,
      20,
      math.random(2, 10),
      0,
      8
    },
    skill03 = {
      2010400103,
      5,
      3,
      0,
      2,
      -60,
      60
    },
    Counterskill03 = {
      2010400103,
      0,
      0,
      0,
      4,
      nil,
      nil,
      nil,
      1,
      counter_move
    }
  }
  local actMoves = {"Blink"}
  monstBase._init(monster, skills, nil, actMoves, nil)
  do
    local _ENV = monster.states
    _ENV.rangedAtk(_ENV.skill01)
    _ENV.meleeAtk(_ENV.skill03)
    _ENV.meleeCounter(_ENV.Counterskill03)
  end
  do
    local skill01 = monster.states.skill01
    local skill02 = monster.states.skill02
    
    function skill01.start(skill)
      local function missile()
        local self = skill.monster
        
        cast_missile(self.npc, nil, get_npc_pos(get_come_on_hero()).x, get_npc_pos(get_come_on_hero()).z, 201040010408, 0)
        cast_missile(self.npc, self.npc, nil, nil, 201040010407, 0)
      end
      
      monster:doAfter(missile, 1)
      skill.base.start(skill01)
    end
  end
end

function monster.go_mad(monster)
  monster.base.go_mad(monster)
  monster.states.skill01.cd = 4
  monster.states.skill03.cd = 2
  monster.wander.maxDis = 2.5
  monster.wander.minDis = 0.5
  monster.states.attack.interval = 1
end

return monster
