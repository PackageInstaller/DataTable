local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)

function monster._init(monster, npc)
  monster.npc = npc
  monster.wander = {
    minDis = 1.5,
    maxDis = 5,
    minTime = 1,
    maxTime = 2,
    type = "walk"
  }
  monster.born = 2010090108
  local skills = {
    skill01 = {
      2010090101,
      5,
      0,
      0,
      3,
      -45,
      45
    },
    skill02 = {
      2010090109,
      10,
      0,
      0,
      6,
      -45,
      45
    },
    skill03 = {
      2010090110,
      12,
      0,
      3,
      5,
      -45,
      45
    },
    skill04 = {
      2010090112,
      12,
      0,
      0,
      3,
      -45,
      45
    },
    dive = {
      2010090102,
      25,
      7,
      2,
      10
    },
    undergrand = {
      2010090103,
      0,
      0,
      0,
      99
    },
    undershoot_delay = {
      2010090107,
      0,
      0,
      1.2,
      99
    },
    undershoot = {
      2010090104,
      0,
      0,
      0,
      99
    },
    undershoot_up = {
      2010090105,
      0,
      0,
      0,
      99
    },
    screaming = {
      2010090106,
      0,
      0,
      0,
      99
    },
    counter_skill02 = {
      2010090109,
      0,
      0,
      0,
      4,
      nil,
      nil,
      nil,
      5,
      1
    }
  }
  local nodes = {"Dive", "Out"}
  monstBase._init(monster, skills, nil, nodes)
  monster.dive_timer = 0
  monster.diving_out_time = 0
  monster.diving_swtich = false
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.skill02, _ENV.skill01)
    _ENV.rangedAtk(_ENV.Dive)
    _ENV.Dive(_ENV.dive(_ENV.undergrand), _ENV.undershoot_delay(_ENV.undershoot(_ENV.undershoot_up)))
    _ENV.meleeCounter(_ENV.counter_skill02)
  end
  do
    local undergrand = monster.states.undergrand
    local Dive = monster.states.dive
    local undershoot_delay = monster.states.undershoot_delay
    
    function Dive.isReady(Dive)
      if 1 ~= monster:getGroupNpcNum() then
        return Dive.monster.states.dive.base.isReady(Dive.monster.states.dive)
      end
    end
    
    function Dive.start(Dive)
      local self = Dive.monster
      if self.target and not check_npc_distance(self.npc, self.target, 7, true) then
        self.diving_out_time = get_npc_time(self.npc) + 2
      else
        self.diving_out_time = get_npc_time(self.npc) + 4
      end
      Dive.base.start(Dive)
    end
    
    function undergrand.start(undergrand)
      local self = undergrand.monster
      undergrand.startTime = get_npc_time(monster.npc) + 6
      enable_shadow(self.npc, false)
      set_skill_end_to_idle(self.npc, true)
      undergrand.base.start(undergrand)
    end
    
    function undergrand.tick(undergrand)
      local self = undergrand.monster
      local now_time = get_npc_time(self.npc)
      if now_time > self.dive_timer and self.target then
        local pos1 = get_npc_offset_position(self.npc, get_npc_pos(self.target), 30, 16)
        switch_move_type(self.npc, 1)
        move_to_pos(self.npc, pos1)
        self.dive_timer = now_time + 0.6
        if get_npc_time(self.npc) > self.diving_out_time then
          switch_move_type(self.npc, 1)
          moveto_npc(self.npc, self.target)
        end
      end
      undergrand.base.tick(undergrand)
    end
    
    function undergrand.tickTrans(undergrand)
      local self = undergrand.monster
      if get_npc_time(self.npc) > self.diving_out_time and get_npc_distance(self.npc, 1, self.target, true) <= 2 or get_npc_time(monster.npc) > undergrand.startTime then
        self.diving_swtich = true
        return self.states.undershoot_delay
      end
    end
    
    function undershoot_delay.isReady(undershoot_delay)
      local self = undershoot_delay.monster
      if self.diving_swtich == true then
        self.diving_swtich = false
        return true
      end
    end
    
    function undershoot_delay.finish(undershoot_delay)
      local self = undershoot_delay.monster
      enable_shadow(self.npc, true)
    end
  end
end

function monster.on_self_magic_begin(monster, target, magic_id, magic_level, magic_kind, magic_type)
  if 201009024 == magic_id then
    set_can_searched(monster.npc, false)
    cast_magic(monster.npc, monster.npc, 201009026)
  end
  if 201009025 == magic_id then
    set_can_searched(monster.npc, true)
    abort_magic_by_id(monster.npc, 201009026, 1)
  end
end

return monster
