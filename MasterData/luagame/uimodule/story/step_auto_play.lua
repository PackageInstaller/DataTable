local Base = require("uimodule.story.step_base")
local M = Util.create_child_mt(Base)

function M:_init(...)
  Base._init(self, ...)
end

function M:start()
  self:complete()
end

return M
