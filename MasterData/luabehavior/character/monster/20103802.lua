local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init(npc)
  self.wander_timer = get_time()
  
  local function monster_skill_cfg(self, skill_id, cd, count_timer, cast_dis_min, cast_dis_max, next_skill, can_cast, next_skill_no_interrupt)
    local skill_cfg = get_skill_cfg(skill_id)
    return {
      skill_id,
      cd,
      self.wander_timer + count_timer,
      cast_dis_min,
      cast_dis_max,
      skill_cfg.CastTime,
      skill_cfg.AfterTime,
      next_skill,
      can_cast,
      next_skill_no_interrupt
    }
  end
  
  enable_part_damage(npc, 1, false)
  enable_part_damage(npc, 2, false)
  enable_part_damage(npc, 3, true)
  Base._init(self)
  self.skill_double_punch = monster_skill_cfg(self, 2010380101, 25, 24, 0, 30, nil, true, false)
  self.skill_l_punch = monster_skill_cfg(self, 2010380102, 0, 5, 0, 30, nil, true, false)
  self.skill_r_punch = monster_skill_cfg(self, 2010380103, 0, 5, 0, 30, nil, true, false)
  self.skill_l_punch_mega = monster_skill_cfg(self, 2010380104, 0, 5, 0, 30, nil, true, false)
  self.skill_r_punch_mega = monster_skill_cfg(self, 2010380105, 0, 5, 0, 30, nil, true, false)
  self.skill_laser = monster_skill_cfg(self, 2010380106, 5, 5, 0, 30, nil, false, false)
  self.skill_laserbomb = monster_skill_cfg(self, 2010380107, 5, 5, 0, 30, nil, false, false)
  self.skill_mega_double_punch = monster_skill_cfg(self, 2010380108, 50, 0, 0, 30, nil, false, false)
  self.l_burst_end = monster_skill_cfg(self, 2010380112, 0, 0, 0, 30, nil, true, false)
  self.l_burst_loop = monster_skill_cfg(self, 2010380111, 0, 0, 0, 30, self.l_burst_end, true, true)
  self.l_burst_start = monster_skill_cfg(self, 2010380110, 120, 0, 0, 30, self.l_burst_loop, false, true)
  self.r_burst_end = monster_skill_cfg(self, 2010380115, 1, 0, 0, 15, nil, true, false)
  self.r_burst_loop = monster_skill_cfg(self, 2010380114, 0, 0, 0, 15, self.r_burst_end, true, true)
  self.r_burst_start = monster_skill_cfg(self, 2010380113, 0, 0, 0, 15, self.r_burst_loop, true, true)
  self.skill_by_distance = monster_skill_cfg(self, 2010380101, 0, 0, 0, 30, nil, false, false)
  self.aim_tag_skill = monster_skill_cfg(self, 2010380117, 0, 0, 0, 30, nil, true, false)
  self.sp_laserbomb = monster_skill_cfg(self, 2010380118, 0, 0, 0, 30, nil, true, false)
  self.begin_damage_end = monster_skill_cfg(self, 2010380122, 0, 0, 0, 30, nil, true, false)
  self.begin_damage_loop = monster_skill_cfg(self, 2010380121, 0, 0, 0, 30, self.begin_damage_end, true, true)
  self.begin_damage_start = monster_skill_cfg(self, 2010380120, 120, 0, 0, 30, self.begin_damage_loop, false, true)
  self.die = 2010380119
  self.mega_missile_1 = {
    201038010901,
    201038010902,
    201038010903
  }
  self.mega_missile_2 = {
    201038010905,
    201038010906,
    201038010907
  }
  self.skill_list = {
    self.aim_tag_skill,
    self.skill_mega_double_punch,
    self.sp_laserbomb,
    self.skill_by_distance,
    self.skill_laserbomb,
    self.skill_double_punch
  }
  self.target = nil
  self.wander_timer_skill_makeup = 0
  self.control = 3
  self.stun_state = 0
  self.born_state = true
  self.waiting = false
  self.play_story = false
  self.mega_stone = false
  self.mega_stone_timer = 0
  self.l_part_hit_count = 0
  self.r_part_hit_count = 0
  self.l_hand_burst = false
  self.r_hand_burst = false
  self.l_hand_state = 1
  self.r_hand_state = 1
  self.skill_count = 0
  self.ai_part = 1
  self.eye_follow = false
  self.eye_follow_swtich = true
  self.part_eye_npc = nil
  self.punch_pit_effect = false
  self.punch_pit_effect_timer = 0
  self.punch_pit_effect_list = {}
  self.punch_pit_effect_break = false
  self.burst_hide_magic = {
    20103801042,
    20103801043,
    20103801044,
    20103801045,
    20103801069,
    20103801070
  }
  self.burst_hide_timer = {
    1.45,
    1.2,
    0.1,
    0.1
  }
  self.burst_hide_cast_tag = {
    false,
    false,
    false,
    false
  }
  self.story_trigger_1 = true
  self.story_trigger_2 = true
  set_show_hit_effect_state(npc, false)
end

function M:set_waiting(v)
  self.waiting = v
end

function M:cast_skill(skill)
  local nowtime = get_time()
  if 4 == self.control then
    if 1 == self.stun_state then
      skill = self.l_burst_start
    elseif 2 == self.stun_state then
      skill = self.r_burst_start
    elseif 3 == self.stun_state then
      skill = self.begin_damage_start
    end
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, skill[1])
    self:wander_time(skill)
    self.skill_next = skill[8]
    if self.skill_next then
      self.control = 2
      set_skill_end_to_idle(self.npc, false)
    else
      self.control = 3
      set_skill_end_to_idle(self.npc, true)
    end
  end
  if 2 == self.control and nowtime > self.wander_timer then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, self.skill_next[1])
    self.skill_next[3] = nowtime + self.skill_next[2]
    self:wander_time(self.skill_next)
    self.skill_next = self.skill_next[8]
    if self.skill_next then
      self.control = 2
    else
      self.control = 3
      set_skill_end_to_idle(self.npc, true)
    end
    return true
  end
  if not (1 ~= self.control and check_npc_status(self.npc, 0)) or false == skill[9] then
    return false
  end
  if 3 == self.control and nowtime >= self.wander_timer then
    self.control = 0
  end
  if 0 == self.control then
    if nowtime >= skill[3] and nowtime > self.wander_timer then
      cast_skill(self.npc, self.npc, skill[1])
      skill[3] = nowtime + skill[2]
      self:wander_time(skill)
    else
      return false
    end
    self.skill_next = skill[8]
    if self.skill_next and self.skill_next[9] then
      self.control = 2
      if self.skill_next[10] then
        set_skill_end_to_idle(self.npc, false)
      end
    else
      self.control = 3
    end
    return true
  end
end

function M:skill_main_logic(skill)
  if not self.target or self.waiting then
    return
  end
  if 3 ~= self.ai_part then
    if self.skill_count < 3 then
      for i, skill in ipairs(self.skill_list) do
        if self:cast_skill(skill) then
          self.skill_count = self.skill_count + 1
          return
        end
      end
    end
  else
    for i, skill in ipairs(self.skill_list) do
      if self:cast_skill(skill) then
        return
      end
    end
  end
  local angle = get_target_angel(self.npc, self.target, true)
  if angle <= 0 then
    skill = self.skill_l_punch
  else
    skill = self.skill_r_punch
  end
  if not self.skill_l_punch[9] then
    skill = self.skill_r_punch
  elseif not self.skill_r_punch[9] then
    skill = self.skill_l_punch
  end
  if self:cast_skill(skill) then
    self.skill_count = 0
  end
end

function M:wander_time(skill)
  self.wander_timer_skill_makeup = skill[6] + skill[7]
  self.wander_timer = get_time() + self.wander_timer_skill_makeup
end

function M:born()
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 201038010908 or missile_cfg.Id == 201038010909 then
    table.insert(self.punch_pit_effect_list, missile)
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if missile_cfg.Id == 201038010908 or missile_cfg.Id == 201038010909 then
    local key
    for i, m in pairs(self.punch_pit_effect_list) do
      if m == missile then
        key = i
        break
      end
    end
    if key then
      table.remove(self.punch_pit_effect_list, key)
    end
  end
end

function M:on_part_damage(npc, target, part_id, cur_hp, is_crit, damage_val, magic_id)
  if target == self.npc then
    if 1 == part_id then
      local l_hand_hp_max = get_part_attr(self.npc, 1, 4)
      if cur_hp / l_hand_hp_max <= 0.8 and cur_hp / l_hand_hp_max > 0.6 and 2 ~= self.l_hand_state then
        cast_magic(self.npc, self.npc, 20103801002, 0)
        cast_magic(self.npc, self.npc, 20103801038, 0)
        cast_magic(self.npc, self.npc, 20103801029, 0)
        self.l_hand_state = 2
      elseif cur_hp / l_hand_hp_max <= 0.6 and 3 ~= self.l_hand_state then
        cast_magic(self.npc, self.npc, 20103801003, 0)
        cast_magic(self.npc, self.npc, 20103801038, 0)
        cast_magic(self.npc, self.npc, 20103801029, 0)
        self.l_hand_state = 3
      end
      if cur_hp / l_hand_hp_max <= 0.8 and not self.l_hand_burst then
        self.skill_mega_double_punch[8] = self.skill_l_punch_mega
        self.skill_mega_double_punch[9] = true
        self.skill_mega_double_punch[3] = get_time()
      end
      if cur_hp / l_hand_hp_max <= 0 and not self.l_hand_burst then
        self.skill_mega_double_punch[9] = false
        self.skill_mega_double_punch[8] = self.skill_r_punch_mega
        self.control = 4
        self.stun_state = 1
        cast_magic(self.npc, self.npc, 20103801052, 0)
        cast_magic(self.npc, self.part_l_npc, Const.LOCK_MASK, 0)
        remove_npc(self.part_l_npc)
      end
      if cur_hp <= 0 then
      end
    end
    if 2 == part_id then
      local r_hand_hp_max = get_part_attr(self.npc, 2, 4)
      if cur_hp / r_hand_hp_max <= 0.8 and cur_hp / r_hand_hp_max > 0.6 and 2 ~= self.r_hand_state then
        cast_magic(self.npc, self.npc, 20103801005, 0)
        cast_magic(self.npc, self.npc, 20103801039, 0)
        cast_magic(self.npc, self.npc, 20103801029, 0)
        self.r_hand_state = 2
      elseif cur_hp / r_hand_hp_max <= 0.6 and 3 ~= self.r_hand_state then
        cast_magic(self.npc, self.npc, 20103801006, 0)
        cast_magic(self.npc, self.npc, 20103801039, 0)
        cast_magic(self.npc, self.npc, 20103801029, 0)
        self.r_hand_state = 3
      end
      if cur_hp / r_hand_hp_max <= 0.8 and not self.r_hand_burst then
        self.skill_mega_double_punch[8] = self.skill_r_punch_mega
        self.skill_mega_double_punch[9] = true
        self.skill_mega_double_punch[3] = get_time()
      end
      if cur_hp / r_hand_hp_max <= 0 and not self.r_hand_burst then
        self.skill_mega_double_punch[9] = false
        self.skill_mega_double_punch[8] = self.skill_l_punch_mega
        self.control = 4
        self.stun_state = 2
        cast_magic(self.npc, self.npc, 20103801053, 0)
        cast_magic(self.npc, self.part_r_npc, Const.LOCK_MASK, 0)
        remove_npc(self.part_r_npc)
      end
    end
    if 3 == part_id then
      if self.l_hand_burst and self.r_hand_burst and 1001323 == magic_id then
        cast_magic(self.npc, self.npc, 2001053, 0)
      end
      if cur_hp <= 0 then
        cast_magic(self.npc, self.npc, 20103801061, 0)
        cast_magic(self.npc, self.npc, 20103801058, 0)
        cast_magic(self.npc, self.npc, 20103801028, 0)
        if self.part_eye_npc then
          remove_npc(self.part_eye_npc)
        end
      elseif 1001323 == magic_id then
        if self.play_story then
          cast_magic(self.npc, self.npc, 20103801067, 0)
          cast_magic(self.npc, self.npc, 20103801028, 0)
          abort_magic_by_id(self.npc, 20103801048)
          abort_skill(self.npc)
          self:set_waiting(false)
          self.control = 4
          self.stun_state = 3
          disable_DBM(6, 1)
          if self.part_eye_npc then
            remove_npc(self.part_eye_npc)
          end
          enable_part_damage(self.npc, 3, false)
        else
          cast_magic(self.npc, self.npc, 20103801060, 0)
          cast_magic(self.npc, self.npc, 20103801029, 0)
        end
      end
    end
  end
end

function M:state_change()
  local now_time = get_time()
  local now_npc_time = get_time(self.npc)
  if check_magic(self.npc, 20103801068) then
    abort_magic_by_id(self.npc, 20103801068)
    cast_magic(self.npc, self.target, 20103801068, 0)
  end
  if self.punch_pit_effect and self.punch_pit_effect_timer <= get_npc_time(self.npc) then
    self.punch_pit_effect = false
    if not self.l_hand_burst then
      cast_missile(self.npc, self.npc, nil, nil, 201038010908, 0)
    end
    if not self.r_hand_burst then
      cast_missile(self.npc, self.npc, nil, nil, 201038010909, 0)
    end
  end
  if self.punch_pit_effect_break and #self.punch_pit_effect_list > 0 then
    for i, v in pairs(self.punch_pit_effect_list) do
      stop_missile(v)
    end
    self.punch_pit_effect_break = false
  end
  if check_magic(self.npc, 20103801009) then
    self.eye_follow_swtich = true
    abort_magic_by_id(self.npc, 20103801009)
  end
  if false == self.mega_stone and check_magic(self.npc, 20103801001) then
    self.mega_stone = true
    self.mega_stone_timer = get_time()
  elseif true == self.mega_stone and not check_magic(self.npc, 20103801001) then
    self.mega_stone = false
  end
  if self.target and not self.eye_follow and self.eye_follow_swtich then
    lookat_by_npc_attach(self.npc, "Bone001", get_npc_pos(self.target, "Bip001 Chest"), 230, 130, 90, 45)
    self.eye_follow = true
  elseif not self.target or not self.eye_follow_swtich and self.eye_follow then
    close_npc_attach_lookat(self.npc)
    self.eye_follow = false
  end
  if self.eye_follow and self.eye_follow_swtich then
    update_lookat_pos(self.npc, get_npc_pos(self.target, "Bip001 Chest"))
  end
  if self.l_hand_burst then
    self.skill_l_punch[9] = false
    self.skill_l_punch_mega[9] = false
    if self.burst_hide_cast_tag[3] and now_npc_time >= self.burst_hide_timer[3] then
      cast_magic(self.npc, self.npc, self.burst_hide_magic[5], 0)
      self.burst_hide_cast_tag[3] = false
    end
    if self.burst_hide_cast_tag[1] and now_npc_time >= self.burst_hide_timer[1] then
      cast_magic(self.npc, self.npc, self.burst_hide_magic[1], 0)
      cast_magic(self.npc, self.npc, self.burst_hide_magic[2], 0)
      self.burst_hide_cast_tag[1] = false
    end
  end
  if self.r_hand_burst then
    self.skill_r_punch[9] = false
    self.skill_r_punch_mega[9] = false
    if self.burst_hide_cast_tag[4] and now_npc_time >= self.burst_hide_timer[4] then
      cast_magic(self.npc, self.npc, self.burst_hide_magic[6], 0)
      self.burst_hide_cast_tag[4] = false
    end
    if self.burst_hide_cast_tag[2] and now_npc_time >= self.burst_hide_timer[2] then
      cast_magic(self.npc, self.npc, self.burst_hide_magic[3], 0)
      cast_magic(self.npc, self.npc, self.burst_hide_magic[4], 0)
      self.burst_hide_cast_tag[2] = false
    end
  end
  local now_hp = get_npc_attr(self.npc, 1)
  local hp_max = get_npc_attr(self.npc, 4)
  if (self.l_hand_burst or self.r_hand_burst) and 1 == self.ai_part then
    self.ai_part = 2
  end
  if self.l_hand_burst and self.r_hand_burst and 2 == self.ai_part then
    self.ai_part = 3
    self.skill_laser[9] = true
    self.skill_laserbomb[9] = true
    self.skill_mega_double_punch[9] = false
    self.skill_double_punch[9] = false
    self.skill_by_distance = self.skill_laserbomb
    self.skill_list[4] = self.skill_by_distance
    cast_missile(self.npc, self.npc, nil, nil, 201038010914, 0)
  end
  if 3 == self.ai_part then
    self.skill_by_distance[9] = true
  elseif self.target and not check_npc_distance(self.npc, self.target, 15, false) then
    self.skill_by_distance[9] = true
  else
    self.skill_by_distance[9] = false
  end
  self:mega_stone_cast(self.mega_missile_1)
  self:mega_stone_cast(self.mega_missile_2)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if npc ~= self.npc then
    return
  end
  local now_npc_time = get_npc_time(self.npc)
  if skill_id == self.aim_tag_skill[1] then
    self:set_waiting(true)
    self.aim_tag_skill[9] = false
    cast_magic(self.npc, self.npc, 20103801048, 0)
    cast_magic(self.npc, self.npc, 20103801059, 0)
  elseif skill_id == self.begin_damage_end[1] then
    cast_magic(self.npc, self.npc, 20103801047, 0)
    set_sync_var("story1501", true)
    self:set_waiting(true)
  elseif skill_id == self.sp_laserbomb[1] then
    self:set_waiting(true)
    self.sp_laserbomb[9] = false
  elseif skill_id == self.skill_l_punch_mega[1] then
    play_DBM_ani(5)
    set_part_attr(self.npc, 1, 25, -20000)
    set_part_attr(self.npc, 2, 25, 8000)
  elseif skill_id == self.skill_r_punch_mega[1] then
    play_DBM_ani(5)
    set_part_attr(self.npc, 2, 25, -20000)
    set_part_attr(self.npc, 1, 25, 8000)
  elseif skill_id == self.skill_mega_double_punch[1] or skill_id == self.skill_double_punch[1] then
    self.punch_pit_effect = true
    self.punch_pit_effect_timer = now_npc_time + 2.45
    if not self.l_hand_burst then
      cast_magic(self.npc, self.npc, 20103801004, 0)
    end
    if not self.r_hand_burst then
      cast_magic(self.npc, self.npc, 20103801007, 0)
    end
  end
  if skill_id == self.l_burst_start[1] then
    self.punch_pit_effect_break = true
    self.l_hand_burst = true
    enable_part_damage(self.npc, 1, false)
    self.punch_pit_effect = false
    self.eye_follow_swtich = false
    abort_magic_by_id(self.npc, 20103801047)
    if 3 == self.ai_part then
      set_source_volume(1, 0.5, 0)
    end
    self.burst_hide_timer[1] = now_npc_time + self.burst_hide_timer[1]
    self.burst_hide_timer[3] = now_npc_time + self.burst_hide_timer[3]
    self.burst_hide_cast_tag[1] = true
    self.burst_hide_cast_tag[3] = true
  elseif skill_id == self.r_burst_start[1] then
    self.punch_pit_effect_break = true
    self.r_hand_burst = true
    enable_part_damage(self.npc, 2, false)
    self.punch_pit_effect = false
    abort_magic_by_id(self.npc, 20103801047)
    if 3 == self.ai_part then
      set_source_volume(1, 0.5, 0)
    end
    self.burst_hide_timer[2] = now_npc_time + self.burst_hide_timer[2]
    self.burst_hide_timer[4] = now_npc_time + self.burst_hide_timer[4]
    self.burst_hide_cast_tag[2] = true
    self.burst_hide_cast_tag[4] = true
  elseif skill_id == self.l_burst_end[1] then
    self.eye_follow_swtich = true
    if 3 == self.ai_part then
      cast_magic(self.npc, self.npc, 20103801048, 0)
      cast_magic(self.npc, self.npc, 20103801049, 0)
      self.part_eye_npc = create_part_npc(201048, self.npc, "Part_Eye", 3, 2)
      enable_part_damage(self.npc, 3, true)
      cast_missile(self.npc, self.npc, nil, nil, 201038010915, 0)
      set_source_volume(1, 0.5, 0.5)
      play_DBM_ani(6)
      play_ui_fight_button_effect({
        "Strengthen_skill_1",
        1
      })
    else
      cast_magic(self.npc, self.npc, 20103801047, 0)
    end
  elseif skill_id == self.r_burst_end[1] then
    if 3 == self.ai_part then
      cast_magic(self.npc, self.npc, 20103801048, 0)
      cast_magic(self.npc, self.npc, 20103801049, 0)
      self.part_eye_npc = create_part_npc(201048, self.npc, "Part_Eye", 3, 2)
      enable_part_damage(self.npc, 3, true)
      cast_missile(self.npc, self.npc, nil, nil, 201038010915, 0)
      set_source_volume(1, 0.5, 0.5)
      play_DBM_ani(6)
      play_ui_fight_button_effect({
        "Strengthen_skill_1",
        1
      })
    else
      cast_magic(self.npc, self.npc, 20103801047, 0)
    end
  elseif skill_id == self.begin_damage_start[1] then
    cast_magic(self.npc, self.target, 20103801075, 0)
  end
  if skill_id == self.skill_laser[1] then
    self.eye_follow_swtich = false
  end
  if skill_id == self.skill_by_distance[1] then
    self.skill_by_distance[9] = false
    self.skill_double_punch[3] = get_time() + self.skill_double_punch[2]
  end
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  Base.on_skill_hit(self, npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc ~= self.npc then
    return
  end
  if missile_cfg.Id == 201038010701 then
    cast_magic(self.npc, hit_target, 20103801204, 0)
    stop_missile(missile)
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if skill_id == self.l_burst_end[1] then
    self.eye_follow_swtich = true
  elseif skill_id == self.skill_laser[1] then
    self.laser_l_active = false
    self.laser_r_active = false
  elseif skill_id == self.skill_l_punch_mega[1] or skill_id == self.skill_r_punch_mega[1] then
    set_part_attr(self.npc, 1, 25, 0)
    set_part_attr(self.npc, 2, 25, 0)
  end
  self:set_waiting(false)
end

function M:on_skill_break(npc, skill_id)
  if skill_id == self.skill_l_punch_mega[1] or skill_id == self.skill_r_punch_mega[1] then
    set_part_attr(self.npc, 1, 25, 0)
    set_part_attr(self.npc, 2, 25, 0)
  end
end

function M:mega_stone_cast(missile_list)
  if self.mega_stone then
    local stone_now_time = get_time()
    local target_pos = get_npc_pos(self.target)
    if stone_now_time > self.mega_stone_timer then
      local scale = 4
      local target_pos_x = {
        target_pos.x
      }
      target_pos_x = target_pos.x + math.random() + math.random(-scale, scale)
      local target_pos_z = {
        target_pos.z
      }
      target_pos_z = target_pos.z + math.random() + math.random(-scale, scale)
      for _, missile_id in ipairs(missile_list) do
        cast_missile(self.npc, nil, target_pos_x, target_pos_z, missile_id, 0)
      end
      self.mega_stone_timer = stone_now_time + 1
    end
  end
end

function M:part_create(key, part_npc, part_name, part_id)
  if not self[key] and is_npc_loaded(part_npc) then
    became_part(part_npc, self.npc, part_name, part_id)
    enable_shadow(part_npc, true)
    self[key] = true
  end
end

function M:replace_on_click_fight_story()
  if self.story_trigger_1 and get_sync_var("story1304") then
    self.story_trigger_1 = false
    self.play_story = true
    self:set_waiting(false)
    self.part_eye_npc = create_part_npc(201048, self.npc, "Part_Eye", 3, 2)
  elseif self.story_trigger_2 and get_sync_var("story1501") then
    self.story_trigger_2 = false
    self.play_story = false
    self:set_waiting(false)
    self.part_l_npc = create_part_npc(201048, self.npc, "Part_L_Hand", 1, 2)
    self.part_r_npc = create_part_npc(201048, self.npc, "Part_R_Hand", 2, 2)
    enable_part_damage(self.npc, 1, true)
    enable_part_damage(self.npc, 2, true)
  end
end

function M:on_frame()
  self:born()
  self:skill_main_logic()
  self:replace_on_click_fight_story()
  if self.remove_switch and get_npc_time(self.npc) > self.remove_timer then
    cast_magic(self.npc, self.npc, 20103801072, 0)
    cast_magic(self.npc, self.npc, 20103801073, 0)
    cast_magic(self.npc, self.target, 20103801010, 0)
    abort_magic_by_id(self.npc, 20103801059)
    remove_npc(self.npc)
  end
  CommonMonster.search_target(self, 30, 20)
  self:state_change()
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    disable_DBM(6, 1)
    stop_ui_fight_button_effect({
      "Strengthen_skill_1",
      1
    })
    self.remove_timer = get_npc_time(npc) + 1.4
    self.remove_switch = true
    abort_skill(self.npc)
    cast_skill(npc, self.target, self.die)
    abort_magic_by_id(self.npc, 20103801047)
    abort_magic_by_id(self.npc, 20103801048)
    cast_magic(self.npc, self.target, 20103801071, 0)
    if self.part_eye_npc then
      remove_npc(self.part_eye_npc)
    end
  end
end

return M
