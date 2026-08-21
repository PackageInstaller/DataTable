local Base = require("gamelogic.base_system")
local Jump_Helper = require("gamelogic.sys_open.jump_helper")
local ActivityCfg = require("gamelogic.activity.activity_config")
local CommonDef = require("cs_share.common_define")
local M = Util.create_child_mt(Base)

function M:init_sys()
  Base.init_sys(self)
  self.v_opend_sys = {}
  self.v_notice_queue = {}
  self.v_sys_cfg = ShareRes.create("sysopen.sys_open")
  self.v_name2sys = ShareRes.create("sysopen.ui_to_sys")
  self.v_condition_cfg = ShareRes.create("condition.condition")
  self.v_jump_cfg = ShareRes.create("sysopen.sys_jump")
  self:sys_mq_bind(Const.MSG_SCENE_LOAD, self.response_secen_load_finish_event, self)
end

function M:on_reconnect()
  self.v_opend_sys = {}
  self.v_notice_queue = {}
  self.v_is_lvup = false
end

function M:response_secen_load_finish_event(msg)
  self:show_notice()
end

function M:on_sys_list_init(data)
  for k, v in pairs(data.sysopen_list) do
    self.v_opend_sys[v] = v
  end
  MsgGame:mq_publish2(Const.MSG_SYS_OPEN)
end

function M:on_sys_open(data)
  local new_sys = data.sys_id
  if self.v_opend_sys[new_sys] then
    Log.Error("该系统已经开启，sys_id=", new_sys)
    return
  end
  self.v_opend_sys[new_sys] = new_sys
  local cfg = self.v_sys_cfg[new_sys]
  if not cfg then
    Log.Error("获取系统配置失败，sys_id=", new_sys)
    return
  end
  if 1 == cfg.Notice then
    table.insert(self.v_notice_queue, cfg)
  end
  table.sort(self.v_notice_queue, function(a, b)
    return a.SortId > b.SortId
  end)
  self:show_notice()
  local msg = MsgGame:mq_publish2(Const.MSG_NEW_SYS_OPEN)
  msg.mm_obj = new_sys
end

function M:show_notice()
  if SceneMgr:check_main_scene() and next(self.v_notice_queue) ~= nil and not self.v_is_lvup then
    UIMgr:add_ui_queue_no_repeat(Config.UI_QUEUE_GROUP.Sys_Open_Notice, "sys_open_tips")
  end
end

function M:get_open_queue()
  return self.v_notice_queue
end

function M:get_sys_is_open(sys_id, need_notice)
  if 0 == sys_id then
    return true
  end
  local open = self.v_opend_sys[sys_id] ~= nil
  if true == need_notice and false == open then
    local sys_cfg = self.v_sys_cfg[sys_id]
    if sys_cfg then
      local tb = {}
      for _, v in pairs(sys_cfg.Condition) do
        if 0 ~= v then
          local condition = self.v_condition_cfg[v]
          if condition then
            table.insert(tb, condition.Desc)
          end
        end
      end
      if #tb > 0 then
        local str = table.concat(tb, "，")
        UIMgr:get_ui("uimessagetip"):ui_show(str)
      end
    end
  end
  return open
end

function M:get_is_ui_open(ui_name, need_notice)
  local sys_id = self.v_name2sys[ui_name]
  if nil == sys_id then
    return true
  end
  return self:get_sys_is_open(sys_id, need_notice)
end

function M:get_sys_tips(sys_id)
  local sys_cfg = self.v_sys_cfg[sys_id]
  local condition = self.v_condition_cfg[sys_cfg.Condition[1]]
  if nil == condition then
  end
  return condition.Desc
end

function M:jump_to_sys(jump_id, need_notice, ...)
  if not SceneMgr:check_main_scene() then
    Util.show_message_tip(2095)
    return
  end
  local jump_cfg = self.v_jump_cfg[jump_id]
  if not jump_cfg then
    Log.Error("跳转配置读取失败，请检查jump_id=", jump_id)
    return
  end
  local jump_condition = jump_cfg.condition
  if jump_condition and jump_condition > 0 then
    local is_can_jump = Condition:check_condition(jump_condition, true)
    if not is_can_jump then
      return
    end
  end
  local sys_id = jump_cfg.sys_id
  if self:get_sys_is_open(sys_id, need_notice) == false then
    return
  end
  local activity_id = ActivityCfg.SYSID_TO_ACTY_TYPE[sys_id]
  if nil ~= activity_id and activity_id ~= CommonDef.ACTY_TYPE.BUDDY_TEACH and activity_id ~= CommonDef.ACTY_TYPE.CLIMBING_TOWER and not ActivityMgr:get_activity_is_open(activity_id) then
    Util.show_message_tip(2096)
    return
  end
  local result = Jump_Helper.jump_to_sys(jump_cfg, ...)
  if result then
    MsgGame:mq_publish2(Const.MSG_ON_JUMP_TO_SYS)
  end
  return result
end

return M
