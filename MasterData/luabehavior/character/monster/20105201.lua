local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")

function M:_init()
  Base._init(self)
  self.skill_set = 0
  self.control = 0
  self.skill01 = {
    201023010101,
    15,
    2,
    0,
    14,
    get_skill_cfg(201023010101).CastTime,
    get_skill_cfg(201023010101).AfterTime,
    true,
    nil
  }
  self.skill02 = {
    201023010102,
    15,
    8,
    0,
    14,
    get_skill_cfg(201023010102).CastTime,
    get_skill_cfg(201023010102).AfterTime,
    true,
    nil
  }
  self.skill03 = {
    201023010103,
    15,
    5,
    0,
    14,
    get_skill_cfg(201023010103).CastTime,
    get_skill_cfg(201023010103).AfterTime,
    true,
    nil
  }
end

function M:skill_cast(skill_cfg)
  local now_time = get_npc_time(self.npc)
  if now_time >= skill_cfg[3] then
    cast_skill(self.npc, self.target, skill_cfg[1], 1)
    skill_cfg[3] = get_npc_time(self.npc) + skill_cfg[2]
  end
end

function M:skill_main_logic()
  if not self.target or not self.npc then
    return
  end
  if is_cast_skill_time(self.npc) then
    return
  end
  if check_npc_status(self.npc, 2) then
    return
  end
  local now_time = get_npc_time(self.npc)
  if 0 == self.skill_set and 0 == self.control then
    local skill_set_random = math.random() + math.random(10, 20)
    if skill_set_random >= 14 and now_time >= self.skill01[3] then
      self.skill_set = 1
    elseif skill_set_random < 14 and now_time >= self.skill02[3] then
      self.skill_set = 2
    end
  elseif 1 == self.skill_set and check_npc_distance(self.npc, self.target, self.skill01[5], false) then
    self:skill_cast(self.skill01)
    self.skill_set = 99
  elseif 2 == self.skill_set and check_npc_distance(self.npc, self.target, self.skill02[5], false) then
    self:skill_cast(self.skill02)
    self.skill_set = 99
  end
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if skill_id == self.skill03[1] then
    CommonMonster.set_value("syclla_laydown", 1, false)
  end
  if skill_id == self.skill01[1] or skill_id == self.skill02[1] then
    self.skill_set = 0
  end
end

function M:on_skill_break(npc, skill_id)
  if npc ~= self.npc then
    return
  end
  if skill_id == self.skill03[1] then
    CommonMonster.set_value("syclla_laydown", 1, false)
  end
  if skill_id == self.skill01[1] or skill_id == self.skill02[1] then
    self.skill_set = 0
  end
end

function M:on_before_npc_hp_zero(npc)
  if npc == self.npc then
    for i = 1, 4 do
      if CommonMonster.get_value("tantacle_list", i) == self.npc then
        CommonMonster.set_value("tantacle_list", i, nil)
        break
      end
    end
    CommonMonster.set_value("syclla_laydown", 1, true)
  end
end

function M:on_frame()
  if not is_npc_loaded(self.npc) then
    return
  end
  if CommonMonster.get_value("syclla_laydown", 1) and get_npc_attr(self.npc, 1) > 0 and not is_cast_skill_time(self.npc, self.skill03[1]) then
    CommonMonster.set_value("syclla_pos_change", 1, true)
    abort_skill(self.npc, true)
    cast_skill(self.npc, self.npc, self.skill03[1], 1)
  end
  CommonMonster.remove_timer(self)
  CommonMonster.search_target(self, 30, 8)
  self:skill_main_logic()
end

return M
