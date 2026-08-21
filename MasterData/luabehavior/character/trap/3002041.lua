local M = Util.create_class()
local vec3 = require("base.vec3")

function M:_init(npc)
  self.npc = npc
  self.player = get_come_on_hero()
  self.control = true
  set_can_searched(npc, true)
  set_npc_status(npc, 2, true)
  self.item_large_id = 3002050
  self.item_fast_id = 3002051
  self.boom_kind = {
    3002040,
    3002045,
    3002046
  }
  self.boom_item_id = 0
  self.boom_item_list = {}
  self.max_item_amount = 3
  self.item_point_amount = 3
  self.current_item_amount = 0
  self.item_born_points = {}
  self.enhance_type = 0
  self.enhance_duration = 0
  self.last_time_enhanced = 0
  self.last_time_create_item = 0
  self.item_cd = get_sync_var("item_cd") or 8
  self.room_id = get_cur_room_id()
  for i = 1, self.item_point_amount do
    table.insert(self.item_born_points, "B" .. i)
  end
  self.boomer = add_npc(2, self.boom_kind[1], get_npc_pos(npc), vec3.New(0, 0, 0), 2, 1, get_npc_group_id(npc))
  self.boomer.creator = npc
  set_hud_config("enhance", {
    Prefab = "UI_Hud8",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 2, 3, 6)
  cast_magic(self.npc, self.npc, 300204101)
  self.fxArrow = play_effect(self.npc, "Fx_skillarea_BattingBoomer", "BottomPoint", false)
end

function M:on_npc_removed(npc)
  if self.control == false then
    return
  end
  if npc.id == 3002047 or npc.id == 3002048 or npc.id == 3002049 then
    return
  end
  if npc == self.boomer then
    if 0 == self.enhance_type then
      self.boomer = add_npc(2, self.boom_kind[1], get_npc_pos(self.npc), vec3.New(0, 0, 0), 2, 1, get_npc_group_id(self.npc))
      return
    end
    if 1 == self.enhance_type then
      self.boomer = add_npc(2, self.boom_kind[2], get_npc_pos(self.npc), vec3.New(0, 0, 0), 2, 1, get_npc_group_id(self.npc))
      return
    end
    if 2 == self.enhance_type then
      self.boomer = add_npc(2, self.boom_kind[3], get_npc_pos(self.npc), vec3.New(0, 0, 0), 2, 1, get_npc_group_id(self.npc))
      return
    end
  end
  for i = 1, #self.boom_item_list do
    if npc == self.boom_item_list[i] then
      table.insert(self.item_born_points, self.boom_item_list[i].pos)
      table.remove(self.boom_item_list, i)
      self.current_item_amount = self.current_item_amount - 1
      self:decide_boom_type(npc)
      return
    end
  end
end

function M:decide_boom_type(npc)
  if npc.id == self.item_large_id then
    self.enhance_type = 1
    self.enhance_duration = 6
    self.last_time_enhanced = get_npc_time(self.npc)
    cast_magic(self.npc, self.npc, 300204102)
    cast_magic(self.npc, self.npc, 300100301)
    active_hud(self.npc, "enhance", nil, false, "")
    active_hud(self.npc, "enhance", nil, true, "巨型")
    return
  end
  if npc.id == self.item_fast_id then
    self.enhance_type = 2
    self.enhance_duration = 10
    self.last_time_enhanced = get_npc_time(self.npc)
    cast_magic(self.npc, self.npc, 300204102)
    cast_magic(self.npc, self.npc, 300100302)
    active_hud(self.npc, "enhance", nil, false, "")
    active_hud(self.npc, "enhance", nil, true, "急速")
    return
  end
end

function M:on_frame(npc)
  local player = get_come_on_hero()
  lookat_npc(self.npc, self.player, true)
  if self.control == false then
    return
  end
  if self.room_id == 800201 or self.room_id == 800205 then
    return
  end
  local current_time = get_npc_time(self.npc)
  if 1 == self.enhance_type then
    cast_magic(self.npc, self.npc, 300204103)
  end
  if 2 == self.enhance_type then
    cast_magic(self.npc, self.npc, 300204104)
  end
  if 0 ~= self.enhance_type and current_time > self.last_time_enhanced + self.enhance_duration then
    self.enhance_type = 0
    active_hud(self.npc, "enhance", nil, false, "")
  end
  if self.current_item_amount >= self.max_item_amount then
    return
  end
  if current_time < self.last_time_create_item + self.item_cd then
    return
  end
  if #self.item_born_points <= 0 then
    return
  end
  local randomkind = math.random(2)
  if 1 == randomkind then
    self.boom_item_id = self.item_large_id
  else
    self.boom_item_id = self.item_fast_id
  end
  local randomPos = math.random(#self.item_born_points)
  local boom_item = add_npc_by_pos_key(2, self.boom_item_id, self.item_born_points[randomPos], 0, 0, self.item_born_points[randomPos], 0, 0, 2, 1)
  boom_item.pos = self.item_born_points[randomPos]
  table.insert(self.boom_item_list, boom_item)
  table.remove(self.item_born_points, randomPos)
  self.current_item_amount = self.current_item_amount + 1
  self.last_time_create_item = get_npc_time(self.npc)
end

function M:on_room_pass(room_id)
  self.control = false
end

return M
