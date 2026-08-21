local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)
local MagicEffectFunc = require("manager.magic.magic_event.magic_effect_func")

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

function M:on_effect()
  MagicEffectFunc.call_effect_func_by_object(self)
end

function M:on_remove(magic_map)
end

return M
