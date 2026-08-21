local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  self.count = 0
  Base._init(self, owner, magic_info)
end

function M:on_effect()
  if not self.owner.element_abnormal_mgr then
    Log.Error("不可对非怪物单位添加元素异常标记, 被添加单位：", self.owner.id, "magic ID：", self.magic_id, debug.traceback())
    return
  end
  self.element_id = self.cfg[1]
  local cal_level = self.cfg[3] and self.cfg[3] > 0
  self.count = cal_level and self.cfg[2] * self.magic_level or self.cfg[2]
  self.owner.element_abnormal_mgr:add_element_abnormal_flag(self.element_id, self.rtid)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_ABNORMAL_FLAG_CHANGE)
  msg.mm_obj = self.owner.uuid
  msg.mm_x = self.element_id
end

function M:on_effect_after()
end

function M:on_remove(magic_map)
  if not self.owner.element_abnormal_mgr then
    Log.Error("不可对非怪物单位添加元素异常标记, 被添加单位：", self.owner.id, "magic ID：", self.magic_id, debug.traceback())
    return
  end
  self.count = 0
  self.owner.element_abnormal_mgr:remove_element_abnormal_flag(self.element_id, self.rtid)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_ABNORMAL_FLAG_CHANGE)
  msg.mm_obj = self.owner.uuid
  msg.mm_x = self.element_id
end

function M:get_count()
  return self.count
end

function M:get_element_id()
  return self.element_id
end

return M
