local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

function M:on_effect()
  Global.camera:set_blur_focus(self.cfg[1], self.cfg[2], self.cfg[3], self.cfg[4])
end

function M:on_remove()
  Global.camera:set_blur_focus(-0.01, self.cfg[2], self.cfg[3], self.cfg[5])
end

return M
