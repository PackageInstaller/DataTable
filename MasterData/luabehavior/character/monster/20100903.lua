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
  monster.born = 2010090308
  local skills = {
    skill01 = {
      2010090301,
      4,
      0,
      0,
      3,
      -45,
      45
    },
    skill02 = {
      2010090309,
      8,
      0,
      0,
      6,
      -45,
      45
    },
    skill03 = {
      2010090310,
      15,
      0,
      3,
      5,
      -45,
      45
    },
    skill04 = {
      2010090312,
      15,
      4 + 8 * math.random(),
      0,
      3,
      -45,
      45
    },
    dive = {
      2010090302,
      20,
      7,
      2,
      10
    },
    undergrand = {
      2010090303,
      0,
      0,
      0,
      99
    },
    undershoot_delay = {
      2010090307,
      0,
      0,
      1.2,
      99
    },
    undershoot = {
      2010090304,
      0,
      0,
      0,
      99
    },
    undershoot_up = {
      2010090305,
      0,
      0,
      0,
      99
    },
    screaming = {
      2010090306,
      0,
      0,
      0,
      99
    }
  }
  local nodes = {"Dive"}
  monstBase._init(monster, skills, nil, nodes)
  monster.dive_timer = 0
  monster.diving_out_time = 0
  monster.diving_swtich = false
  monster.dive_is_hit = false
  do
    local _ENV = monster.states
    _ENV.meleeAtk(_ENV.skill04, _ENV.skill03, _ENV.skill02, _ENV.skill01)
    _ENV.rangedAtk(_ENV.Dive)
    _ENV.Dive(_ENV.dive(_ENV.undergrand), _ENV.undershoot_delay(_ENV.undershoot(_ENV.screaming, _ENV.undershoot_up)))
  end
  do
    local undergrand = monster.states.undergrand
    local Dive = monster.states.dive
    local undershoot_delay = monster.states.undershoot_delay
    local screaming = monster.states.screaming
    local undershoot_up = monster.states.undershoot_up
    
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
      self.dive_is_hit = false
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
    
    function undershoot_delay.start(undershoot_delay)
      undershoot_delay.base.start(undershoot_delay)
    end
    
    function undershoot_delay.finish(undershoot_delay)
      local self = undershoot_delay.monster
      enable_shadow(self.npc, true)
    end
    
    function screaming.isReady(screaming)
      if screaming.monster.dive_is_hit == true and not check_magic(screaming.monster.npc, 20100901602) then
        return true
      end
    end
    
    function undershoot_up.isReady(undershoot_up)
      if undershoot_up.monster.dive_is_hit == false then
        return true
      end
    end
  end
end

function monster:on_self_skill_hit(skill_id, hit_target, hit_type, missile_cfg, missile)
  self.base.on_self_skill_hit(self, skill_id, hit_target, hit_type, missile_cfg, missile)
  if 2010090304 == skill_id then
    self.dive_is_hit = true
  end
end

function monster.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  monster.base.on_target_self_magic_begin(monster, caster, magic_id, is_self, magic_level)
  if 1999223 == magic_id then
    cast_magic(monster.npc, monster.npc, 20100901204, 1)
  end
  if 20100901601 == magic_id then
    do
      local _ENV = monster.states
      _ENV.freeAtk(_ENV.skill03, _ENV.skill02, _ENV.skill01)
      _ENV.rangedAtk()
    end
    monster.states.attack.interval = 2
  end
end

function monster.on_target_self_magic_end(monster, caster, magic_id)
  monster.base.on_target_self_magic_end(monster, caster, magic_id)
  if 20100901601 == magic_id then
    abort_magic_by_id(monster.npc, 201050010117, 1)
    do
      local _ENV = monster.states
      _ENV.freeAtk()
      _ENV.rangedAtk(_ENV.Dive)
    end
    monster.states.attack.interval = 5
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
