local TARGET_TYPE = {
  SELF = 0,
  OTHER = 1,
  TIME_SCALE = 2
}
local Base = require("manager.magic.magic_imp.magic_base")
local Time = CS.UnityEngine.Time
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

function M:on_effect(magic_list)
  local skill_mgr = self.owner.skill_mgr
  local skill_id_list = self.cfg[1]
  local skill_id = skill_mgr:get_change_effect_energy_id()
  if skill_id and 0 == #skill_id_list then
    self:on_set_skill_correct_data(skill_id, skill_mgr)
  end
  for index, id in ipairs(skill_id_list) do
    self:on_set_skill_correct_data(id, skill_mgr)
  end
end

function M:on_set_skill_correct_data(skill_id, skill_mgr)
  local skill_id = tonumber(skill_id)
  local skill = skill_mgr:get_skill(skill_id)
  if not skill then
    return
  end
  local energy_info = skill:get_skill_energy_info()
  if not energy_info then
    return
  end
  local value = self.cfg[2]
  local value_type = self.cfg[3]
  local set_type = self.cfg[4]
  skill_mgr:set_skill_correct_data(self.magic_id, skill_id, value, value_type, set_type)
end

function M:on_remove(magic_list)
  local skill_mgr = self.owner.skill_mgr
  skill_mgr:remove_effect_magic(self.magic_id)
end

return M
