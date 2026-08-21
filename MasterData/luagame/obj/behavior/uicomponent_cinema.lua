local Base = require("obj.behavior.uicomponent_char")
local HEAD_TEXT_HEIGHT = 0.4
local M = Util.create_child_mt(Base)

function M:get_name_color()
  return self.v_char:get_headbar_color()
end

function M:setup_headbar()
  if self.v_char:is_show_name() then
    self:add_headbar(self.v_char.attr_mgr.name)
  end
end

return M
