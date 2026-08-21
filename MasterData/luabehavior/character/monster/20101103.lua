local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 0.5,
    maxDis = 5,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 2010110117
  monster.dash = 0
  local skills = {
    skill01 = {
      2010110101,
      3 + 3 * math.random(),
      2,
      0,
      3,
      -60,
      60
    },
    skill02 = {
      2010110102,
      0,
      0,
      0,
      99
    },
    skill03 = {
      2010110103,
      0,
      0,
      0,
      99
    },
    stab1 = {
      2010110104,
      13,
      5 + 8 * math.random(),
      0,
      99,
      -60,
      60
    },
    stab2 = {
      2010110105,
      0,
      0,
      0,
      999
    },
    stab3 = {2010110104},
    stab4 = {2010110105},
    dashOut = {
      2010110106,
      7,
      0,
      0,
      5,
      -60,
      60
    },
    Rage = {
      2010110107,
      18,
      10 + 8 * math.random(),
      0,
      4,
      -90,
      90
    },
    run_skill = {
      2010110118,
      0,
      2,
      3,
      99,
      -60,
      60
    }
  }
  local nodes = {
    "ATK",
    "lunge",
    "ATK2"
  }
  local actMoves = {"Run"}
  monstBase._init(monster, skills, actMoves, nodes)
  monster.states.attack.interval = 3
  do
    local _ENV = monster.states
    _ENV.attack(_ENV.groupAtk(_ENV.rangedAtk, _ENV.meleeAtk), _ENV.freeAtk)
    _ENV.freeAtk(_ENV.ATK)
    _ENV.gotTarget(_ENV.attack, _ENV.wander)
    _ENV.meleeAtk(_ENV.lunge, _ENV.ATK2)
    _ENV.lunge(_ENV.stab1(_ENV.stab2(_ENV.stab3(_ENV.stab4))))
    _ENV.ATK(_ENV.Run, _ENV.skill01(_ENV.skill02(_ENV.skill03)))
    _ENV.ATK2(_ENV.Rage)
    _ENV.freeCounter(_ENV.dashOut)
  end
  do
    local skill03 = monster.states.skill03
    local Rage = monster.states.Rage
    
    function Rage.moveScale(Rage)
      return monster.calculate_moveScale(monster)
    end
    
    function skill03.moveScale(skill03)
      return monster.calculate_moveScale(monster)
    end
    
    function skill03.isReady(skill)
      if not skill03.base.isReady(skill03) then
        return false
      end
      local monster = skill.monster
      local tool = monster.tool
      if not tool.randByTime(monster, 0.3) then
        return false
      end
      return true
    end
    
    function skill03.start(skill03)
      skill03.base.start(skill03)
      monster.calculatetarget = monster.target
    end
    
    function Rage.start(Rage)
      Rage.base.start(Rage)
      monster.calculatetarget = monster.target
    end
  end
  do
    local stab3 = monster.states.stab3
    local lunge = monster.states.lunge
    
    function lunge.start(lunge)
      lunge.base.start(lunge)
      if math.random() < 0.4 then
        monster.states.stab3.isReady = Const.FALSE_FUN
      else
        monster.states.stab3.isReady = Const.TURE_FUN
      end
    end
  end
  monster.states.Run.timer = 0
  monster.states.Run.time = 0
  do
    local active = monster.states.active
    local Run = monster.states.Run
    
    function active.start(active)
      active.monster:xRay()
    end
    
    function Run.isReady(Run)
      if monster.target and get_npc_time(monster.npc) > monster.states.skill01.timer then
        return not check_npc_distance(Run.monster.npc, Run.monster.target, 4, false)
      end
      return false
    end
    
    function Run.start(Run)
      local self = Run.monster
      switch_move_type(self.npc, 0)
      moveto_npc(self.npc, self.target)
      cast_magic(self.npc, self.npc, 201011010046, 1)
      cast_magic(self.npc, self.npc, 201011010049, 1)
      cast_magic(self.npc, self.npc, 201011010044, 1)
      cast_magic(self.npc, self.npc, 201011010047, 1)
      cast_magic(self.npc, self.npc, 201011010048, 1)
    end
    
    function Run.tickTrans(Run)
      local self = Run.monster
      local dis = self.states.skill01.maxDis
      if self.target ~= nil and check_npc_distance(self.npc, self.target, dis, false) then
        if self.states.skill01.isReady(self.states.skill01) then
          abort_magic_by_id(self.npc, 201011010046, 99)
          abort_magic_by_id(self.npc, 201011010048, 99)
          abort_magic_by_id(self.npc, 201011010049, 99)
          abort_magic_by_id(self.npc, 201011010044, 99)
          abort_magic_by_id(self.npc, 201011010047, 99)
          lookat_npc(monster.npc, monster.target, true)
          return self.states.skill01
        else
          abort_magic_by_id(self.npc, 201011010046, 99)
          abort_magic_by_id(self.npc, 201011010048, 99)
          abort_magic_by_id(self.npc, 201011010049, 99)
          abort_magic_by_id(self.npc, 201011010044, 99)
          abort_magic_by_id(self.npc, 201011010047, 99)
          return self.states.wander
        end
      end
    end
  end
end

function monster.calculate_moveScale(monster)
  local target = monster.calculatetarget
  local Distance = get_npc_distance(monster.npc, 1, target, false)
  local Scale = Distance / 3
  if Scale < 1.8 then
    return Scale
  else
    return 1.8
  end
end

function monster.go_mad(monster)
  cast_magic(monster.npc, monster.npc, 500100101, 1)
  cast_magic(monster.npc, monster.npc, 500100102, 1)
  cast_magic(monster.npc, monster.npc, 500100111, 1)
  monster.states.Rage.cd = 6
  monster.states.attack.interval = 1
  local _ENV = monster.states
  _ENV.attack(_ENV.Rage, _ENV.groupAtk(_ENV.rangedAtk, _ENV.meleeAtk), _ENV.freeAtk)
  _ENV.meleeAtk(_ENV.lunge)
end

return monster
