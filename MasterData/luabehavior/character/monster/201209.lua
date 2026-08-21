local monsterBase = import("character.base.monster_base")
local M = Util.create_child_mt(monsterBase)
local tool = import("common.monster_tool")

function M._init(monster)
  monster.wander = {
    minDis = 2,
    maxDis = 5,
    minTime = 0.5,
    maxTime = 2,
    type = "run"
  }
  monster.search = {minDis = 4, maxDis = 30}
  local skills = {
    atk1 = {
      30010040101,
      6.5,
      0,
      2,
      5,
      -60,
      60
    },
    atk2 = {
      30010040102,
      0,
      0,
      0,
      3,
      -60,
      60
    },
    atk3 = {
      30010040103,
      0,
      0,
      0,
      3,
      -60,
      60
    },
    atk4 = {
      30010040104,
      0,
      0,
      0,
      5,
      -60,
      60
    },
    split = {
      30010040105,
      5,
      0,
      3,
      8,
      -60,
      60
    },
    round = {
      30010040106,
      5,
      0,
      1,
      5
    },
    double = {
      30010040107,
      5,
      0,
      1,
      5,
      -60,
      60
    },
    ultimate = {
      30010040108,
      15,
      15,
      3,
      -52,
      60
    }
  }
  monsterBase._init(monster, skills)
  do
    local _ENV = monster.states
    _ENV.freeAtk(_ENV.ultimate, _ENV.round, _ENV.double, _ENV.split, _ENV.atk1(_ENV.atk2(_ENV.atk3(_ENV.atk4))))
  end
  do
    local states = monster.states
    states.attack.interval = 0
    
    local function randomBaseCheck(actSkill, possibility)
      return tool.randByTime(actSkill.monster, possibility) and actSkill.base.isReady(actSkill)
    end
    
    function states.ultimate.isReady(actSkill)
      return randomBaseCheck(actSkill, 0.2)
    end
    
    function states.round.isReady(actSkill)
      return randomBaseCheck(actSkill, 0.25)
    end
    
    function states.double.isReady(actSkill)
      return randomBaseCheck(actSkill, 0.3333333)
    end
    
    function states.split.isReady(actSkill)
      return randomBaseCheck(actSkill, 0.5)
    end
  end
end

function M.on_born_behavior(monster)
  monster.base.on_born_behavior(monster)
  set_npc_hp_visible(monster.npc, false)
end

return M
