local CommonRole = import("common.role")
local Base = import("character.base.base_role")
local M = Util.create_child_mt(Base)
local x, y
local TEMP_POS = {}
local indicator_set = 0
local press_set = 0
local death_set = 0
local skill_area = {
  type = 1,
  res = "FX_text_kong",
  sizex = 12
}
local arrow_indi_cfg = {
  type = 2,
  res = "Fx_skillarea_N2",
  sizex = 3,
  sizey = 12
}
local tower_skill_id = {
  [1] = 310100201,
  [2] = 310100202,
  [3] = 310100203,
  [4] = 310100204,
  [5] = 310100205,
  [6] = 310100206,
  [7] = 310100207,
  [8] = 310100208
}
local tower_missile_id = {
  31010020101,
  31010020201,
  31010020202,
  31010020301,
  31010020302,
  31010020303,
  31010020401,
  31010020501,
  31010020601,
  31010020602,
  31010020701,
  31010020702,
  31010020703,
  31010020801
}

function M:_init(npc)
  Base._init(self)
  CommonRole.role_common_init(self)
  self.indicator_input_timer = self.indicator_input_timer or {}
  self.now_input_id = nil
  self.now_skill_id = 310100201
end

function M:cast_skill()
  if get_npc_cd_charge(self.npc, self.now_skill_id) < get_skill_cfg(self.now_skill_id).CdChargePerCost then
    CommonRole.magic_with_check(self, self.npc, self.npc, 100159)
    indicator_set = 0
    return
  end
  if 0 == indicator_set then
    return
  end
  if check_npc_status(self.npc, 2) then
    return
  end
  if is_cast_skill_time(self.npc) and skill_abort_level > 3 then
    return
  end
  TEMP_POS = get_npc_pos(self.npc)
  abort_skill(self.npc)
  lookat_position(self.npc, x, y, 1)
  if 1 == press_set then
    if math.abs(TEMP_POS.x - x) <= 0.5 and math.abs(TEMP_POS.z - y) <= 0.5 then
      if not self.now_skill_id then
        cast_skill(self.npc, nil, tower_skill_id[1], nil, nil)
        cast_magic(self.npc, self.npc, 399954, 1)
        self.now_skill_id = tower_skill_id[5]
      elseif self.now_skill_id == tower_skill_id[1] then
        cast_skill(self.npc, nil, tower_skill_id[1], nil, nil)
        cast_magic(self.npc, self.npc, 399954, 1)
        self.now_skill_id = tower_skill_id[5]
      elseif self.now_skill_id == tower_skill_id[5] then
        cast_skill(self.npc, nil, tower_skill_id[5], nil, nil)
        cast_magic(self.npc, self.npc, 399950, 1)
        self.now_skill_id = tower_skill_id[1]
      end
    elseif not self.now_skill_id then
      cast_skill(self.npc, nil, tower_skill_id[1], x, y)
      cast_magic(self.npc, self.npc, 399954, 1)
      self.now_skill_id = tower_skill_id[5]
    elseif self.now_skill_id == tower_skill_id[1] then
      cast_skill(self.npc, nil, tower_skill_id[1], x, y)
      cast_magic(self.npc, self.npc, 399954, 1)
      self.now_skill_id = tower_skill_id[5]
    elseif self.now_skill_id == tower_skill_id[5] then
      cast_skill(self.npc, nil, tower_skill_id[5], x, y)
      cast_magic(self.npc, self.npc, 399950, 1)
      self.now_skill_id = tower_skill_id[1]
    end
  elseif not self.now_skill_id then
    cast_skill(self.npc, nil, tower_skill_id[1], nil, nil)
    cast_magic(self.npc, self.npc, 399954, 1)
    self.now_skill_id = tower_skill_id[5]
  elseif self.now_skill_id == tower_skill_id[1] then
    cast_skill(self.npc, nil, tower_skill_id[1], nil, nil)
    cast_magic(self.npc, self.npc, 399954, 1)
    self.now_skill_id = tower_skill_id[5]
  elseif self.now_skill_id == tower_skill_id[5] then
    cast_skill(self.npc, nil, tower_skill_id[5], nil, nil)
    cast_magic(self.npc, self.npc, 399950, 1)
    self.now_skill_id = tower_skill_id[1]
  end
  indicator_set = 0
  press_set = 0
  CommonRole.clear_input(self, 60)
end

function M:on_missile_collide(m1_owner, m2_owner, m1, m2, m1_cfg, m2_cfg)
  if m1_owner ~= self.npc then
    return
  end
  for _, v in pairs(tower_missile_id) do
    if m1_cfg.Id == v and 0 ~= m2_cfg.LineType and m2 then
      remove_missile(m2)
    end
  end
end

function M:on_frame()
  for id, value in pairs(self.indicator_input_timer) do
    self.indicator_input_timer[id] = self.indicator_input_timer[id] + 1
    if self.indicator_input_timer[id] > 7 then
      self:on_press(id)
      press_set = 1
      self.indicator_input_timer[id] = nil
    end
  end
end

function M:on_press(input_id)
  local now_npc_time = get_npc_time(self.npc)
  local now_cd_charge = get_npc_cd_charge(self.npc, self.now_skill_id)
  if self.now_skill_id == 310100204 or self.now_skill_id == 310100208 then
    press_set = 0
    return
  end
  if 60 == input_id then
    if now_cd_charge < get_skill_cfg(self.now_skill_id).CdChargePerCost then
      return
    end
    update_skill_indicator(input_id, skill_area, arrow_indi_cfg, 0.5)
    set_indicator_active(input_id, true, false)
  end
end

function M:before_damage(npc, target, magic_id, damage_sign, damage_type, is_crit)
  if npc ~= self.npc then
    return
  end
end

function M:on_input(input_id)
  CommonRole.role_common_on_input(self, input_id)
  self.indicator_input_timer[input_id] = 0
end

function M:on_touch_up(input_id, iscancle)
  self.indicator_input_timer[input_id] = nil
  if true == iscancle then
    press_set = 0
  end
  if 60 == input_id then
    set_indicator_active(input_id, false)
    x, y = get_indicator_pos(input_id)
  end
  if 60 == input_id and false == iscancle then
    indicator_set = 1
    self:cast_skill()
    self.now_input_id = nil
  elseif true == iscancle then
    self.now_input_id = nil
  end
end

function M:on_room_change(npc)
  if npc == self.npc then
    abort_skill(self.npc, 1)
    clear_input()
  end
end

function M:on_npc_hp_zero(npc)
  if npc ~= self.npc then
    return
  end
end

return M
