local monstBase = import("character.base.monster_base")
local monster = Util.create_child_mt(monstBase)
local cargo_manager = import("character.trap.3001090_1")

function monster:_init(npc)
  self.npc = npc
  self.search = {}
  set_npc_status(self.npc, 3, true)
  self.drop_missile_id = 30010900201
  self.player = get_come_on_hero()
  self.playerPosY = get_npc_pos(self.player).y
  self.dash_scale = 1
  self.last_time_play_effect = 0
  self.effect_cd = 0.2
  self.cargo_effect_list = {}
  self.cargo_list = {}
  self.item_point_max_num = 4
  self.item_born_points = {}
  self.last_time_create_item = 0
  self.refresh_cooldown = get_sync_var("refresh_cooldown")
  self.max_item_amount = math.min(get_sync_var("max_item_amount"), self.item_point_max_num)
  self.current_item_amount = 0
  self.item_list = {}
  local room_id = get_cur_room_id()
  if 800501 == room_id then
    self.level_item_list = {}
  elseif 800502 == room_id then
    self.level_item_list = {3001096, 3001097}
  elseif 800503 == room_id then
    self.level_item_list = {
      3001096,
      3001097,
      3001098
    }
  elseif 800504 == room_id then
    self.level_item_list = {
      3001096,
      3001097,
      3001098
    }
  end
  self.is_strengthen = false
  self.strengthen_duration = 8
  self.last_time_strengthen = 0
  for i = 1, self.item_point_max_num do
    local born_point = "D" .. i
    table.insert(self.item_born_points, born_point)
  end
  set_hud_config("weight", {
    Prefab = "UI_Hud8",
    Fore = "UIFight/Fight_bg_cyjd",
    Back = "UIFight/Fight_bg_cyjdd",
    HasTxt = true,
    TxtParent = "Skill/SkillName",
    TxtSrc = 2
  }, 2, 3, 6)
  active_hud(self.player, "weight", "qipao_gd", true, "当前货物价值：" .. cargo_manager.cargo_value)
  local actSkills = {
    check = {300109001}
  }
  local actMoves = {}
  local nodes = {}
  monstBase._init(self, actSkills, actMoves, nodes)
  local states = self.states
  do
    local _ENV = states
    _ENV.root(_ENV.check, _ENV.decisionFailed)
  end
end

function monster:on_npc_removed(npc)
  if npc.id == 3001092 or npc.id == 3001093 or npc.id == 3001094 then
    self:update_weight()
    return
  end
  for i = 1, #self.item_list do
    if npc == self.item_list[i] then
      table.insert(self.item_born_points, self.item_list[i].born_pos_index)
      table.remove(self.item_list, i)
      if self.current_item_amount == self.max_item_amount then
        self.last_time_create_item = get_npc_time(self.npc)
      end
      self.current_item_amount = self.current_item_amount - 1
      return
    end
  end
end

function monster:update_weight()
  cast_magic(self.player, self.player, 300204108, cargo_manager.cargo_weight + 1)
  active_hud(self.player, "weight", "qipao_gd", false, "当前货物价值：" .. cargo_manager.cargo_value)
  active_hud(self.player, "weight", "qipao_gd", true, "当前货物价值：" .. cargo_manager.cargo_value)
  self:update_speed()
end

function monster:update_speed()
  if self.is_strengthen == false then
    cast_magic(self.player, self.player, 300204109, cargo_manager.cargo_weight + 1)
  else
    cast_magic(self.player, self.player, 300204109, 1)
  end
end

function monster:on_frame()
  self:check_cargo()
  self:check_item()
  self:check_strength()
end

function monster:check_strength()
  if self.is_strengthen == false then
    return
  end
  if get_npc_time(self.npc) < self.last_time_strengthen + self.strengthen_duration then
    return
  end
  self.is_strengthen = false
  self:update_speed()
end

function monster:check_cargo()
  if 0 == #self.cargo_effect_list then
    return
  end
  local currentTime = get_npc_time(self.npc)
  if currentTime < self.last_time_play_effect + self.effect_cd then
    return
  end
  self.last_time_play_effect = currentTime
  local cargo_value = self.cargo_effect_list[#self.cargo_effect_list]
  cast_magic(self.player, self.player, 300800500 + cargo_value)
  self:update_weight()
  table.remove(self.cargo_effect_list, #self.cargo_effect_list)
end

function monster:check_item()
  if 0 == #self.level_item_list then
    return
  end
  if self.current_item_amount >= self.max_item_amount then
    return
  end
  local currentTime = get_npc_time(self.npc)
  if currentTime < self.last_time_create_item + self.refresh_cooldown then
    return
  end
  self.last_time_create_item = currentTime
  local randomPos = math.random(#self.item_born_points)
  local randomIndex = math.random(#self.level_item_list)
  local item_npc = add_npc_by_pos_key(2, self.level_item_list[randomIndex], self.item_born_points[randomPos], 0, 0, self.item_born_points[randomPos], 0, 0, 2, 1)
  item_npc.born_pos_index = self.item_born_points[randomPos]
  table.insert(self.item_list, item_npc)
  table.remove(self.item_born_points, randomPos)
  self.current_item_amount = self.current_item_amount + 1
end

function monster:on_skill_hit(caster, skillId, hitTarget, hitType, missileCfg, missile, partNpc)
  if 1 ~= get_role_kind(hitTarget) then
    return
  end
  if caster.id == 3001095 then
    for i = 1, #cargo_manager.cargo_list do
      local drop_cargo_id = cargo_manager:drop_cargo()
      table.insert(self.cargo_list, drop_cargo_id)
      self:update_weight()
      local randomDeg = math.random(360)
      local lookPos = get_npc_offset_position(self.player, nil, randomDeg, 100)
      local plyaerPos = get_npc_pos(self.player)
      cast_missile3(self.player, nil, lookPos.x, lookPos.z, self.drop_missile_id, 1, lookPos.x, lookPos.y, lookPos.z, plyaerPos.y, plyaerPos.x, plyaerPos.z, plyaerPos.y)
    end
  elseif caster.id == 3001096 then
    remove_npc(caster)
    cast_magic(self.player, self.player, 300800504)
  elseif caster.id == 3001097 then
    remove_npc(caster)
    cast_magic(self.player, self.player, 300800505)
    self.is_strengthen = true
    self:update_speed()
    self.last_time_strengthen = get_npc_time(self.npc)
  elseif caster.id == 3001098 then
    remove_npc(caster)
    call_scene_logic_custom_event("teleport")
    local drop_num = math.floor(#cargo_manager.cargo_list / 2)
    for i = 1, drop_num do
      local drop_cargo_id = cargo_manager:drop_cargo()
      table.insert(self.cargo_list, drop_cargo_id)
      self:update_weight()
      local randomDeg = math.random(360)
      local lookPos = get_npc_offset_position(self.player, nil, randomDeg, 100)
      local plyaerPos = get_npc_pos(self.player)
      cast_missile3(self.player, nil, lookPos.x, lookPos.z, self.drop_missile_id, 1, lookPos.x, lookPos.y, lookPos.z, plyaerPos.y, plyaerPos.x, plyaerPos.z, plyaerPos.y)
    end
  end
end

function monster:on_self_skill_hit(skill_id, hit_target, hit_type, missile_cfg, missile)
  if 1 ~= get_role_kind(hit_target) then
    return
  end
  for i = 1, #cargo_manager.cargo_list do
    local cargo_value = cargo_manager:deliver_cargo()
    table.insert(self.cargo_effect_list, cargo_value)
  end
end

function monster:on_skill_begin(npc, skill_id, skill_type, skill_cfg)
  if 2 ~= skill_type then
    return
  end
  self.dash_scale = 1 - cargo_manager.cargo_weight * 0.12
  if 0 ~= #cargo_manager.cargo_list then
    local drop_cargo_id = cargo_manager:drop_cargo()
    table.insert(self.cargo_list, drop_cargo_id)
    self:update_weight()
    local lookPos = get_npc_offset_position(self.player, nil, 180, 100)
    local plyaerPos = get_npc_pos(self.player)
    cast_missile3(self.player, nil, lookPos.x, lookPos.z, self.drop_missile_id, 1, lookPos.x, lookPos.y, lookPos.z, plyaerPos.y, plyaerPos.x, plyaerPos.z, plyaerPos.y)
  end
  local role = npc:get_behavior()
  cast_magic(self.player, self.player, 1999171)
  role:set_move_scale(skill_cfg.Animation, self.dash_scale)
end

function monster:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile, is_break)
  if missile_cfg.Id ~= self.drop_missile_id then
    return
  end
  local drop_vec3 = vec3.New(pos_x, self.playerPosY, pos_z)
  if 0 == #self.cargo_list then
    return
  end
  local cargo = add_npc(1, self.cargo_list[1], drop_vec3, drop_vec3, 2, 1, get_npc_group_id(self.npc))
  local cargo_behavior = cargo:get_behavior()
  cargo_behavior:transState(cargo_behavior.states.drop)
  table.remove(self.cargo_list, 1)
end

return monster
