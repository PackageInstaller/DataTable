local monster = Util.create_class()
local vec3 = require("base.vec3")

function monster:_init(npc)
  self.npc = npc
  self.last_time_get = 0
  self.refresh_cooldown = 10
  self.need_refresh = false
  self.last_check_time = 0
  local room_id = get_cur_room_id()
  if 800501 == room_id then
    self.cargo_list = {3001092, 3001093}
  elseif 800502 == room_id then
    self.cargo_list = {3001092, 3001093}
  elseif 800503 == room_id then
    self.cargo_list = {
      3001092,
      3001093,
      3001094
    }
  elseif 800504 == room_id then
    self.cargo_list = {
      3001092,
      3001093,
      3001094
    }
  end
  local cargo_id = self:get_random_id()
  self.cargo = add_npc(1, cargo_id, get_npc_pos(self.npc), vec3.New(0, 0, 0), 2, 1, get_npc_group_id(self.npc))
  set_hud_config("coolDown", {
    Prefab = "UI_Hud7",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 2, 3, 6)
  cast_magic(self.npc, self.npc, 300204101)
end

function monster:get_random_id()
  local cargo_id = 0
  local randomIndex = math.random(#self.cargo_list)
  cargo_id = self.cargo_list[randomIndex]
  return cargo_id
end

function monster:on_frame()
  if self.need_refresh == false then
    return
  end
  local this_check_time = get_npc_time(self.npc)
  if this_check_time == self.last_check_time then
    return
  end
  self.last_check_time = this_check_time
  cast_magic(self.npc, self.npc, 300204111)
  if this_check_time < self.last_time_get + self.refresh_cooldown then
    return
  end
  local cargo_id = self:get_random_id()
  self.cargo = add_npc(1, cargo_id, get_npc_pos(self.npc), vec3.New(0, 0, 0), 2, 1, get_npc_group_id(self.npc))
  self.need_refresh = false
  active_hud(self.npc, "coolDown", nil, false, "物资刷新中")
end

function monster:on_npc_removed(npc)
  if npc == self.cargo then
    self.need_refresh = true
    self.last_time_get = get_npc_time(self.npc)
    cast_magic(self.npc, self.npc, 300204110)
    active_hud(self.npc, "coolDown", nil, true, "物资刷新中")
  end
end

return monster
