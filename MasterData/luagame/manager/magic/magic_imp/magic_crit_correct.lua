local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
  self.fix_crit_value = self.cfg[1]
  self.fix_type = self.cfg[2]
  self.calculation_type = self.cfg[3]
end

function M:on_effect(magic_list)
end

function M.on_trigger_effect(magic_mgr, magic_map)
  local fix_crit_value = 0
  local fix_type = 0
  local calculation_type = 0
  for _, magic in pairs(magic_map) do
    local fix_val = magic.fix_crit_value or 0
    fix_crit_value = fix_crit_value + fix_val
    fix_type = magic.fix_type
    calculation_type = magic.calculation_type
  end
  M.remove_magic_on_effect(magic_mgr, magic_map)
  return fix_crit_value, fix_type, calculation_type
end

return M
