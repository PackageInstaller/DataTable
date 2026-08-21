local M = Util.create_class()

function M:_init()
end

function M:on_start()
  self.level = get_develop_level(self.npc, 6, 651110041)
  self.allow_buff = false
  self.buff_651110044 = false
  self.buff_651110045 = false
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type, is_crit, damage_val, base_dmg, element_dmg, skill_id, missile)
  if self.allow_buff then
    if 6 == damage_sign and self.buff_651110044 then
      cast_magic(self.npc, self.npc, 651110044, self.level)
      self.buff_651110044 = false
    end
    if 4 == damage_sign and self.buff_651110045 then
      cast_magic(self.npc, self.npc, 651110045, self.level)
      self.buff_651110045 = false
    end
  end
end

function M:on_self_skill_hit(skill_id, hit_target, hit_type, missile_cfg, missile, part_npc)
  if not self.allow_buff then
    local kind = get_role_kind(hit_target)
    if (2 == kind or 3 == kind or 4 == kind or 8 == kind or 9 == kind) and not check_npc_die(self.npc) then
      local info = missile and get_missile_skill_action_info(missile)
      local skAct = info and info.skAct
      if skAct and (skAct:deemSkill() or skAct:deemUlt()) then
        self.allow_buff = true
        self.buff_651110044 = true
        self.buff_651110045 = true
      end
    end
  end
end

function M:on_self_skill_end(skill_id, is_time_out, is_break, behavior_abort)
  if self.allow_buff then
    self.allow_buff = false
  end
end

return M
