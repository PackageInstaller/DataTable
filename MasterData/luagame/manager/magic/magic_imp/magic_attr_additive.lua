local Base = require("manager.magic.magic_imp.magic_base")
local FightDefine = require("cs_share.fight_define")
local CommDefine = require("cs_share.common_define")
local MagicEffectFunc = require("manager.magic.magic_event.magic_effect_func")
local M = Util.create_child_mt(Base)
local SET_TYPE = Config.ATTR_SET_TYPE
local ATTR_GROUP_TYPE = Config.ATTR_GROUP_TYPE
local ATTR_TYPE = FightDefine.ATTR_TYPE
local RATIO_TYPE = Config.RATIO_TYPE
local VALUE_TYPE = CommDefine.VALUE_TYPE
local VALUE_FUNCTION = CommDefine.VALUE_FUNCTION

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

function M:on_effect()
  self.is_change_speed, self.need_back, self.change_args, self.change_suc, self.change_percent = MagicEffectFunc.call_effect_func_by_object(self)
end

function M:on_remove()
  if self.need_back then
    local attr_mgr = self.owner.attr_mgr
    local param
    if self.change_suc then
      param = {
        ignoreDie = self.change_suc
      }
    end
    for _, args in ipairs(self.change_args) do
      attr_mgr:set_cur_attr(args.attr_group_type, args.attr_type, -args.value, args.value_type, args.set_type, args.attr_ratio_type, param)
    end
    if self.is_change_speed then
      self.owner.role_move_ctrl:set_change_speed_percent(-self.change_percent)
    end
  end
end

return M
