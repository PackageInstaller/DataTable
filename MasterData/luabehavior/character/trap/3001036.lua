local Base = import("character.base.base_monster")
local M = Util.create_class()
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
  
  self.skill_appending = monster_skill_cfg(self, 300103602, 0, 0, 0, 30, nil, true, false)
  self.skill_pre_appending = monster_skill_cfg(self, 300103601, 5, 4, 0, 30, self.skill_appending, true, false)
  self.black_line = false
  self.charge_time = 0
  self.appending_target = npc
  self.appending_cast = false
  self.water_missile_id = 30010360301
  self.summon_timer_missile_id = 30010360303
  self.black_magic_id = 3001036004
  self.summon_id = 2010100101
  self.appending_hp = 100
  self.target_pos_x = 0
  self.target_pos_z = 0
  self.summon_fish_id = 2010100101
  self.summon_murloc_id = 2010090101
  self.fish_id = {
    2010100101,
    2010100102,
    2010100103
  }
  self.murloc_id = {
    2010090101,
    2010090102,
    2010090103
  }
  self.control = 0
  set_hud_config("3001036_bar", {
    Prefab = "UI_Hud3",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd"
  }, 2, 3, 6)
  if CommonMonster.get_value("增生物数量", 1) then
    CommonMonster.set_value("增生物数量", 1, CommonMonster.get_value("增生物数量", 1) + 1)
  else
    CommonMonster.set_value("增生物数量", 1, 1)
  end
end

function M:monster_search(list, monster_type)
  local a
  for k, v in pairs(list) do
    a = search_npc(self.npc, 2, 30, 0, 0, false, v)
    if a then
      if 1 == monster_type then
        self.summon_fish_id = v
      elseif 2 == monster_type then
        self.summon_murloc_id = v
      end
      return a
    end
  end
end

function M:cast_skill(skill)
  local nowtime = get_time()
  if 3 == self.control and nowtime >= self.wander_timer then
    self.control = 0
  end
  local monster_num = 0
  if CommonMonster.get_value("场上鱼数量", 1) then
    monster_num = monster_num + CommonMonster.get_value("场上鱼数量", 1)
  end
  if CommonMonster.get_value("场上鱼数量", 2) then
    monster_num = monster_num + CommonMonster.get_value("场上鱼数量", 2)
  end
  if 0 == self.control then
    skill = self.skill_pre_appending
    if nowtime >= skill[3] and nowtime > self.wander_timer and monster_num < CommonMonster.get_value("增生物数量", 1) * 3 then
      cast_skill(self.npc, self.npc, skill[1])
      active_hud(self.npc, "3001036_bar", "attachpoint", true)
      skill[3] = nowtime + skill[2]
      self:wander_time(skill)
      self.control = 1
    else
      return false
    end
    return true
  elseif 1 == self.control then
    local npc_time = get_npc_time(self.npc)
    local energy_now = get_npc_attr(self.npc, 3)
    local energy_max = get_npc_attr(self.npc, 6)
    if energy_now >= energy_max then
      self.control = 2
    end
    local fish = self:monster_search(self.fish_id)
    local murloc = self:monster_search(self.murloc_id)
    if not fish and not murloc then
      cast_magic(self.npc, self.npc, 3001036001, 0)
      active_hud(self.npc, "3001036_bar", "attachpoint", false)
      self.control = 4
    end
    if energy_now < energy_max and npc_time > self.charge_time then
      cast_magic(self.npc, self.npc, 3001036002, 0)
      self.charge_time = npc_time + 0.05
    end
    return true
  elseif 2 == self.control then
    skill = self.skill_appending
    cast_skill(self.npc, self.npc, skill[1])
    cast_magic(self.npc, self.npc, 3001036001, 0)
    self:wander_time(skill)
    active_hud(self.npc, "3001036_bar", "attachpoint", false)
    local fish = self:monster_search(self.fish_id)
    local murloc = self:monster_search(self.murloc_id)
    local summon
    local rand = math.random()
    if fish and murloc then
      if rand < 0.5 then
        summon = fish
        self.summon_id = self.summon_fish_id
        self.black_magic_id = 3001036007
      else
        summon = murloc
        self.summon_id = self.summon_murloc_id
        self.black_magic_id = 3001036004
      end
    elseif fish and not murloc then
      summon = fish
      self.summon_id = self.summon_fish_id
      self.black_magic_id = 3001036007
    elseif not fish and murloc then
      summon = murloc
      self.summon_id = self.summon_murloc_id
      self.black_magic_id = 3001036004
    end
    self.appending_cast = true
    if summon then
      self.appending_target = summon
    end
    if self.appending_target and self.appending_target ~= self.npc then
      self.black_line = true
      cast_magic(self.npc, self.npc, 3001036008, 0)
      cast_magic(self.npc, self.npc, 3001036005, 0)
      cast_magic(self.npc, self.appending_target, 3001036012, 0)
      cast_missile(self.npc, self.appending_target, nil, nil, 30010360304, 0)
    end
    self.control = 3
  elseif 3 == self.control then
    if self.black_line and self.appending_target and not check_magic(self.appending_target, 3001036012) then
      cast_magic(self.npc, self.appending_target, self.black_magic_id, 0)
      cast_magic(self.npc, self.appending_target, 3001036010, 0)
      self.black_line = false
    end
    if not self.black_line and self.appending_cast and self.appending_target and not check_magic(self.appending_target, 3001036010) then
      local target_pos = get_npc_offset_position(self.appending_target, nil, 0, 5)
      if self.appending_target ~= self.npc then
        self.appending_hp = math.ceil(get_npc_attr(self.appending_target, 1) / get_npc_attr(self.appending_target, 4) * 100)
      end
      cast_magic(self.npc, self.appending_target, 3001036011, 0)
      if target_pos then
        cast_missile(self.appending_target, nil, target_pos.x, target_pos.z, self.water_missile_id, 0)
        cast_missile(self.appending_target, nil, target_pos.x, target_pos.z, 30010360302, 0)
      end
      if CommonMonster.get_value("增生物分裂标记", self.appending_target) then
        CommonMonster.set_value("增生物分裂标记", self.appending_target, CommonMonster.get_value("增生物分裂标记", self.appending_target) + 1)
      else
        CommonMonster.set_value("增生物分裂标记", self.appending_target, 1)
      end
      self.appending_cast = false
      listen_missile_end_pos(self.appending_target, self.summon_timer_missile_id, self.on_missile_end_pos, self)
    end
  elseif 4 == self.control then
    local fish = self:monster_search(self.fish_id)
    local murloc = self:monster_search(self.murloc_id)
    local magic = 3001036014
    if not check_magic(self.npc, magic) then
      cast_magic(self.npc, self.npc, magic, 0)
    end
    if fish or murloc then
      self.control = 0
      self.wander_timer = get_time()
      abort_magic_by_id(self.npc, magic)
    end
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if owner == self.appending_target and missile_cfg.Id == self.summon_timer_missile_id and CommonMonster.get_value("增生物分裂标记", self.appending_target) > 0 then
    CommonMonster.set_value("增生物分裂标记", self.appending_target, CommonMonster.get_value("增生物分裂标记", self.appending_target) - 1)
    local npc = add_npc2(2, self.summon_id, pos_x, pos_z, 0, 0, 2, 0)
    cast_magic(self.npc, npc, 3001036006, self.appending_hp)
    cast_magic(self.npc, npc, 3001036009, 0)
    unlisten_missile_end_pos(self.appending_target, self.summon_timer_missile_id, self)
    self.appending_target = nil
  end
end

function M:skill_main_logic()
  if not self.target then
    return
  end
  self:cast_skill()
end

function M:wander_time(skill)
  self.wander_timer_skill_makeup = skill[6] + skill[7]
  self.wander_timer = get_time() + self.wander_timer_skill_makeup
end

function M:on_frame()
  CommonMonster.search_target(self, 30, 8)
  self:skill_main_logic()
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
    create_scene_effect("Fx_Common_Death", npc:get_pos_vec3(), 0)
    set_npc_dead(self.npc, nil, true)
    remove_npc(self.npc)
    if CommonMonster.get_value("增生物数量", 1) then
      CommonMonster.set_value("增生物数量", 1, CommonMonster.get_value("增生物数量", 1) - 1)
    end
  end
end

return M
