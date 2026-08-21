local M = Util.create_class()
local hero = get_come_on_hero()
local team_hero_list = {
  get_scene_hero_by_poskey(21),
  get_scene_hero_by_poskey(22),
  get_come_on_hero()
}

function M:_init(npc)
  self.lazer_num = 0
  self.lazer_start = false
  self.levelup_limit = 2
  self.isSkill = true
end

function M:on_start()
  self.level = get_ability_level(60016) or 1
  if self.level > 1 then
    self.levelup_limit = 3
  end
  if not check_magic(self.npc, 6171001) then
    for k, v in pairs(team_hero_list) do
      cast_magic(self.npc, v, 6171001, 0)
    end
  end
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_room_change(npc)
  self.level = get_ability_level(60016) or 1
  if self.level > 1 then
    self.levelup_limit = 3
  end
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:deemUlt() or act:deemSkill() then
    self.isSkill = true
  end
end

function M:on_self_skill_end(skill_id, is_time_out, is_break, behavior_abort)
  self.isSkill = false
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= self.npc then
    return
  end
  if missile_cfg.Id == 61710910401 then
    self.lazer_start = true
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= self.npc then
    return
  end
  if missile_cfg.Id == 61710910401 then
    self.lazer_start = false
  end
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if self.npc ~= get_come_on_hero() then
    return
  end
  local kind = get_role_kind(target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local num = get_magic_num(self.npc, 61710011)
  if 7 == damage_sign and num > 4 and self.isSkill then
    local self_pos = get_npc_pos(self.npc)
    local base_pos1 = get_npc_offset_position(self.npc, nil, 90, 2)
    local base_pos2 = get_npc_offset_position(self.npc, nil, -90, 2)
    local target_pos = get_npc_offset_position(self.npc, nil, 0, 3.5)
    local p1 = get_position_offset_position(self_pos, target_pos, 0, 0)
    if not self.lazer_start then
      if not check_magic(self.npc, 6171018) then
        cast_missile3(self.npc, nil, p1.x, p1.z, 61710910401, 1, target_pos.x, target_pos.z)
        cast_missile3(self.npc, nil, p1.x, p1.z, 61710910402, 1, target_pos.x, target_pos.z)
      else
        cast_missile3(self.npc, self.npc, nil, nil, 61710910405, 1)
        cast_missile3(self.npc, self.npc, nil, nil, 61710910406, 1)
        cast_missile3(self.npc, self.npc, nil, nil, 61710910407, 1)
        cast_missile3(self.npc, self.npc, nil, nil, 61710910408, 1)
        cast_missile3(self.npc, self.npc, nil, nil, 61710910420, 1)
        cast_missile3(self.npc, self.npc, nil, nil, 61710910421, 1)
      end
      self.isSkill = false
    end
    self.lazer_num = self.lazer_num + 1
    if self.lazer_num == self.levelup_limit then
      abort_magic_by_id(self.npc, 61710011)
    end
  end
end

return M
