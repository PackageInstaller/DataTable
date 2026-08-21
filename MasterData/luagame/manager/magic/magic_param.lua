local M = Util.create_class()

function M:_init(magic_id, attacker, owner_missile, owner_skill, magic_level, logic_cfg, effect_cfg, part_id, ext_args, not_send_msg)
  self.magic_id = magic_id
  self.attacker = attacker
  self.owner_missile = owner_missile
  self.owner_skill = owner_skill
  self.magic_level = magic_level
  self.logic_cfg = logic_cfg
  self.effect_cfg = effect_cfg
  self.part_id = part_id
  self.ext_args = ext_args
  if self.ext_args then
    self.attacker_magic_mgr = self.ext_args.attacker_magic_mgr or attacker.magic_mgr
    self.attacker_attr_mgr = self.ext_args.attacker_attr_mgr or attacker.attr_mgr
    self.args = self.ext_args.arg
    self.attach_point = self.ext_args.attach_point
  else
    self.attacker_magic_mgr = attacker.magic_mgr
    self.attacker_attr_mgr = attacker.attr_mgr
  end
  if owner_skill then
    self.owner_skill_id = owner_skill.skill_id
  end
  if owner_missile then
    self.owner_skill_id = owner_missile:get_skill_id()
  end
  self.not_send_msg = not_send_msg
  self.is_destroy = false
end

function M:on_destroy()
  self.is_destroy = true
  self.magic_id = nil
  self.attacker = nil
  self.owner_missile = nil
  self.owner_skill = nil
  self.magic_level = nil
  self.logic_cfg = nil
  self.effect_cfg = nil
  self.part_id = nil
  self.attacker_attr_mgr = nil
  self.attacker_magic_mgr = nil
  self.owner_skill_id = nil
  self.args = nil
  self.not_send_msg = nil
  self.ext_args = nil
  self.attach_point = nil
end

return M
