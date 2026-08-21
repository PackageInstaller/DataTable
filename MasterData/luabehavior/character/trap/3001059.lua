local M = Util.create_class()
local CommonMonster = import("common.monster")

function M:_init(npc)
  self.skill01 = {
    300105901,
    3,
    0,
    0,
    0,
    get_skill_cfg(300105901).CastTime,
    get_skill_cfg(300105901).AfterTime
  }
  self.skill02 = {
    300105902,
    5,
    0,
    0,
    0,
    get_skill_cfg(300105902).CastTime,
    get_skill_cfg(300105902).AfterTime
  }
  self.control = nil
  self.target = nil
  self.biubiu_timer = nil
  set_hud_config("3001059_bar", {
    Prefab = "UI_Hud4",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd"
  }, 2, 3, 6)
  cast_magic(npc, npc, 201010302, 0)
  cast_magic(npc, npc, 201010304, 0)
  set_npc_floating_text_hud_visible(npc, false)
end

function M:skill_logic()
  if 0 == self.control then
    cast_skill(self.npc, self.target, 300105901, nil, nil)
    self.biubiu_timer = get_npc_time(self.npc) + 0.75
    self.control = 3
  end
  if 1 == self.control then
    cast_skill(self.npc, self.target, 300105902, nil, nil)
    self.biubiu_timer = get_npc_time(self.npc) + 2
    self.control = 4
  end
end

function M:on_skill_end(npc, skill_id)
  if npc == self.npc and 300105903 == skill_id then
    cast_skill(self.npc, self.target, 300105901, nil, nil)
    cast_magic(self.npc, self.npc, 201010304, 0)
    active_hud(self.npc, "3001059_bar", "attachpoint", false)
    self.hud_start = nil
    self.control = 0
  end
end

function M:on_frame()
  if self.hud_start and get_npc_time(self.npc) > self.hud_start and get_npc_attr(self.npc, 3) < 100 then
    cast_magic(self.npc, self.npc, 201010303, 0)
    self.hud_start = get_npc_time(self.npc) + 0.1
  end
  if is_pass_room() then
    abort_skill(self.npc)
    self.control = 9
  end
  self:skill_logic()
  self:search_target()
  if self.target and self.control == nil then
    self.control = 0
  end
  if 3 == self.control and get_npc_time(self.npc) > self.biubiu_timer then
    self.control = 1
  end
  if 4 == self.control and get_npc_time(self.npc) > self.biubiu_timer then
    self.control = nil
  end
end

function M:after_damage(npc, target, magic_id, damage_sign, damage_type, is_crit, damage_val)
  if target == self.npc and damage_val < 0 then
    abort_skill(self.npc)
    cast_skill(self.npc, self.npc, 300105903, nil, nil)
    active_hud(self.npc, "3001059_bar", "attachpoint", true)
    self.hud_start = get_npc_time(self.npc) + 0.1
    self.control = nil
  end
end

function M:search_target()
  local target = search_npc(self.npc, 4, 10, nil, 1)
  if target and 5 ~= get_role_kind(target) then
    self.target = target
  end
end

return M
