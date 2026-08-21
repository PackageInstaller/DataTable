local Base = require("gamelogic.base_system")
local Guider = require("gamelogic.guide.guider")
local Seri = require("seri")
local LocalStorage = require("utils.localstorage")
local LOCAL_GUIDE_COMPLETE_KEY = "LOCAL_GUIDE_COMPLETE_KEY"
local LOCAL_GUIDE_RECOVE_KEY = "RecoveGuide"
local GUIDE_RECOVE_START_UI = "uimain"
local M = Util.create_child_mt(Base)
local GUIDE_TYPE = {SYS = 1, LEVEL = 2}

function M:init_sys()
  Base.init_sys(self)
  self.v_complete_list = {}
  self.v_update_complete_list = {}
  self.v_guide_cfg = ShareRes.create("guide.guide")
  self.v_ui_guide_cfg = ShareRes.create("guide.ui_guide")
  self.v_cur_guide = nil
  self.v_disable_guide = nil
  self.v_tips_break_list = {}
  self.v_uis_break_list = {}
  self:sys_mq_bind(Const.MSG_PRE_TP_ROOM, self.on_pre_tp_room, self)
  self:sys_mq_bind(Const.MSG_BEGIN_SWITCH_ROOM, self.on_pre_tp_room, self)
  self:sys_mq_bind(Const.MSG_ON_HIDE_UI, self.on_ui_hide_event, self)
  self:sys_mq_bind(Const.MSG_ON_UI_BE_COVERED, self.on_ui_hide_event, self)
  self:sys_mq_bind(Const.MSG_ON_SHOW_UI, self.on_ui_show_event, self)
  self.v_check_recove_guide = true
end

function M:on_reconnect()
  self.v_cur_guide = nil
  self.v_disable_guide = nil
  self.v_tips_break_list = {}
  self.v_uis_break_list = {}
  self.v_check_recove_guide = true
end

function M:on_pre_tp_room()
  if self.v_cur_guide then
    local guide_cfg = ShareRes.create("guide.guide", self.v_cur_guide.guide_id)
    if guide_cfg.guide_type == GUIDE_TYPE.LEVEL then
      self:force_finish_cur_guide()
    end
  end
end

function M:on_ui_hide_event(msg)
  if not msg then
    return
  end
  if self.v_disable_guide then
    return
  end
  local ui_name = msg.mm_obj
  if not self.v_cur_guide then
    if self.v_break_guide and UIMgr:try_get_visible_ui(self.v_break_guide[1]) then
      self:enter_guide(self.v_break_guide[2], self.v_break_guide[3])
      self.v_break_guide = nil
    end
    if self.v_tips_break_list[ui_name] then
      local info = self.v_tips_break_list[ui_name]
      local is_table = type(info) == "table"
      local check_ui_name = is_table and info[1] or info
      local check_ui = UIMgr:try_get_visible_ui(check_ui_name)
      if is_table then
        self:enter_guide(info[2], info[3])
      elseif check_ui then
        self:check_sys_guide(check_ui)
      end
      self.v_tips_break_list[ui_name] = nil
    end
  else
    local target_ui = self.v_cur_guide:get_target_ui()
    if ui_name == target_ui then
      local guide_id = self.v_cur_guide.guide_id
      local step_id = self.v_cur_guide:get_cur_step()
      self.v_break_guide = {
        self:_get_guide_bind_ui(guide_id, step_id),
        guide_id,
        step_id
      }
      Log.Info("break current guide = ", guide_id, ", because of show tips=", ui_name)
      self:finish_guide(self.v_cur_guide.guide_id, false)
    end
    if "uistory" == ui_name and self.v_cur_guide:is_story_guide() then
      self.v_cur_guide:complete_story_guide()
    end
  end
end

function M:on_ui_show_event(msg)
  if not self.v_cur_guide and self.v_break_guide and UIMgr:try_get_visible_ui(self.v_break_guide[1]) then
    self:enter_guide(self.v_break_guide[2], self.v_break_guide[3])
    self.v_break_guide = nil
    return
  end
  if not msg or not self.v_cur_guide then
    return
  end
  if self.v_disable_guide then
    return
  end
  local ui_name = msg.mm_obj
  local ui = UIMgr:try_get_visible_ui(ui_name)
  if not ui then
    return
  end
  local info = self.v_uis_break_list[ui_name]
  if info then
    self:enter_guide(info.guide_id, info.step_id)
    self.v_uis_break_list[ui_name] = nil
  end
  if self.v_cur_guide then
    self.v_cur_guide:start_cur_guide(ui_name)
  end
end

function M:sync_guide_update(data)
  self.v_complete_list = self:load_local_guide_complete_data() or {}
  for k, v in pairs(data.guide_list) do
    self.v_complete_list[v] = v
  end
  for k, v in pairs(data.guide_list) do
    self.v_update_complete_list[v] = v
  end
  self.v_complete_get_guide_data = true
end

function M:request_complete_guide(guide_id, USE_GM)
  self.v_complete_list[guide_id] = guide_id
  Network:call("c2gs_complete_guide", {id = guide_id}, function(ok, resp)
    if true == ok and 0 == resp.errcode then
      self.v_update_complete_list[guide_id] = guide_id
    end
  end)
  self:save_local_guide_complete_data()
  if not USE_GM and not self.v_call_forbidden then
    self.v_call_forbidden = true
    local count = 0
    for _, complete_id in pairs(self.v_complete_list) do
      if complete_id ~= guide_id and not self.v_update_complete_list[complete_id] and count <= 2 then
        count = count + 1
        Log.Info("guide_id存在上传不成功的情况: guide_id = ", complete_id)
        Network:call("c2gs_complete_guide", {id = complete_id}, function(ok, resp)
          if true == ok and 0 == resp.errcode then
            self.v_update_complete_list[complete_id] = complete_id
          end
          self.v_call_forbidden = false
        end)
      end
    end
  end
  self:set_recove_guide_cfg(-1, -1)
end

function M:get_local_guide_complete_key()
  return LOCAL_GUIDE_COMPLETE_KEY .. Global.player_uuid
end

function M:save_local_guide_complete_data()
  LocalStorage:save_table(self:get_local_guide_complete_key(), self.v_complete_list)
end

function M:clear_local_guide_complete_data()
  Log.Info("Clear local guide data is done")
  LocalStorage:save_table(self:get_local_guide_complete_key(), {})
  LocalStorage:save_table(self:get_local_guide_complete_key() .. LOCAL_GUIDE_RECOVE_KEY, {})
  self.v_recove_net_data = nil
end

function M:load_local_guide_complete_data()
  return LocalStorage:load_table(self:get_local_guide_complete_key())
end

function M:on_get_netdisk_data(data)
  if data and next(data.netdisk_data) ~= nil then
    local info_str
    for k, v in pairs(data.netdisk_data) do
      if v.type == Config.SAVE_TYPE.GUIDE_RECOVER then
        info_str = v.pack_string
        break
      end
    end
    self.v_recove_net_data = Seri.unpack(info_str)
  end
end

function M:set_recove_guide_cfg(guide_id, step_id)
  local set_time = Date.server_time()
  local pack_args = Seri.packstring({
    [1] = guide_id,
    [2] = step_id,
    [3] = set_time
  })
  local type_tmp = Config.SAVE_TYPE.GUIDE_RECOVER
  Network:call("c2gs_netdisk_save_data", {type = type_tmp, pack_string = pack_args})
  self:save_recove_guide_cfg(guide_id, step_id, set_time)
end

function M:save_recove_guide_cfg(guide_id, step_id, set_time)
  local save_tolocal = {
    [1] = guide_id,
    [2] = step_id,
    [3] = set_time
  }
  LocalStorage:save_table(self:get_local_guide_complete_key() .. LOCAL_GUIDE_RECOVE_KEY, save_tolocal)
end

function M:load_recove_guide_data()
  local local_data = LocalStorage:load_table(self:get_local_guide_complete_key() .. LOCAL_GUIDE_RECOVE_KEY)
  local net_data = self.v_recove_net_data
  if not local_data then
    return net_data
  end
  if nil ~= net_data and nil ~= net_data[3] then
    if local_data[3] > net_data[3] then
      return local_data
    else
      return net_data
    end
  end
  return local_data
end

function M:recove_guide(ui_name)
  if GUIDE_RECOVE_START_UI ~= ui_name then
    return
  end
  if not self.v_check_recove_guide then
    return
  end
  self.v_check_recove_guide = false
  if self.v_cur_guide ~= nil then
    return
  end
  local save_tbl = self:load_recove_guide_data() or {}
  local cur_guide_id = save_tbl[1]
  local cur_step_id = save_tbl[2]
  if nil == cur_guide_id or nil == cur_step_id then
    return
  end
  if cur_guide_id < 0 then
    return
  end
  local step_cfg = ShareRes.create("guide.guide_step", cur_guide_id)[cur_step_id]
  local jump_id = step_cfg.jump_id
  local reguide_id = step_cfg.reguide_step_id
  local guide_cfg = self.v_guide_cfg[cur_guide_id]
  if self:_do_check_condition(guide_cfg) and nil == self.v_complete_list[cur_guide_id] then
    if nil ~= reguide_id then
      self:enter_sys_guide(cur_guide_id, reguide_id)
    end
    if nil ~= jump_id then
      SysOpenMgr:jump_to_sys(jump_id, true)
    end
    Global.is_first_login_today = false
  end
end

function M:check_sys_guide(ui, need_recove)
  if JourneyEventMgr:get_is_need_run_force_journey_event() then
    return
  end
  local name = ""
  local cur_ui
  if ui then
    name = ui:ui_get_name()
    cur_ui = ui
  else
    name = UIMgr:get_cur_show_ui_name()
    cur_ui = UIMgr:get_cur_show_ui()
  end
  if need_recove then
    self:recove_guide(name)
  end
  if self.v_cur_guide then
    return
  end
  local check_ui_cond = true
  if not self.v_ui_guide_cfg[name] then
    return
  end
  local cfg = self.v_ui_guide_cfg[name]
  local tb = {}
  for k, v in pairs(cfg) do
    if (self.v_test_id == v.id or self.v_complete_list[v.id] == nil) and v.guide_type == GUIDE_TYPE.SYS and self.v_complete_get_guide_data then
      table.insert(tb, v)
    end
  end
  if 0 == #tb then
    return
  end
  table.sort(tb, function(a, b)
    return a.sort > b.sort
  end)
  for i, v in ipairs(tb) do
    if nil ~= v.jump_condition and Condition:check_condition(v.jump_condition) then
      self:complete_guide(v.id)
    elseif self:_do_check_condition(v) then
      if cur_ui.check_ui_condition_guide then
        check_ui_cond = cur_ui:check_ui_condition_guide(v.id)
      end
      if check_ui_cond then
        self:enter_sys_guide(v.id)
      end
      return
    end
  end
end

function M:_do_check_condition(guide_cfg)
  if 0 == #guide_cfg.condition then
    return true
  else
    local enter = true
    for _, v in pairs(guide_cfg.condition) do
      if v > 0 and not Condition:check_condition(v) then
        enter = false
        break
      end
    end
    return enter
  end
end

function M:enter_sys_guide(guide_id, step_id)
  if self.v_cur_guide then
    return
  end
  self.v_cur_guide = Guider:new(guide_id, step_id)
  if not self.v_cur_guide:get_finish_init() then
    self.v_cur_guide = nil
  end
end

function M:enter_guide(guide_id, step_id)
  if self.v_cur_guide then
    return
  end
  local ui_name = self:_get_guide_bind_ui(guide_id, step_id)
  local ui = UIMgr:try_get_visible_ui(ui_name)
  self.v_cur_guide = Guider:new(guide_id, step_id)
  if not self.v_cur_guide:get_finish_init() then
    self.v_cur_guide = nil
  end
end

function M:complete_guide(guide_id)
  self.v_complete_list[guide_id] = guide_id
  self:request_complete_guide(guide_id)
  self.v_test_id = nil
end

function M:finish_guide(guide_id, check_follow, is_click_skip)
  local cfg = self.v_guide_cfg[guide_id]
  if cfg.guide_type == GUIDE_TYPE.LEVEL and SceneMgr then
    SceneMgr:c2gs_call_scene("scene_guide_finished", guide_id)
    BehaviorMgr:call_scene_logic_event_fun("on_guide_finished", guide_id)
  end
  if guide_id then
    self.v_complete_list[guide_id] = guide_id
    self:save_local_guide_complete_data()
  end
  self.v_cur_guide = nil
  UIMgr:try_hide_ui("ui_guide")
  if check_follow and not self.v_disable_guide then
    local follow_id = self.v_guide_cfg[guide_id].follow_id
    if follow_id then
      self:_check_follow_guide(follow_id)
    else
      local ui = UIMgr:get_cur_show_ui()
      if ui and 1041 ~= guide_id then
        self:check_sys_guide(ui)
      end
    end
  end
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_FINISH_GUIDE, guide_id, is_click_skip)
end

function M:_check_follow_guide(result)
  local next_id = result[1]
  if next_id < 0 then
    return
  end
  local com = self.v_complete_list[next_id] ~= nil
  if com then
    return
  end
  
  function self.v_wait_func()
    local tips = UIMgr:get_has_tips()
    if tips then
      self.v_tips_break_list[tips] = {
        self:_get_guide_bind_ui(next_id, result[2]),
        next_id,
        result[2]
      }
      return
    end
    self:enter_guide(next_id, result[2])
  end
  
  self.v_wait_func()
end

function M:_get_guide_bind_ui(guide_id, step_id)
  local cfg
  if step_id then
    cfg = ShareRes.create("guide.guide_step", guide_id)[step_id]
  else
    cfg = self.v_guide_cfg[guide_id]
  end
  if cfg then
    return cfg.ui_name
  end
end

function M:prase_data(follow_id)
  local result = {}
  for k, v in string.gmatch(follow_id, "(%-?%d+%.*%d*)") do
    table.insert(result, tonumber(k))
  end
  return result
end

function M:jump_guide(guide_id, is_click_skip)
  local jump_id = self.v_guide_cfg[guide_id].jump_id
  if jump_id > 0 then
    for _, v in pairs(self.v_guide_cfg) do
      if v.jump_id == jump_id then
        self.v_complete_list[v.id] = v.id
        self:request_complete_guide(v.id, true)
      end
    end
  end
  if self.v_cur_guide then
    self.v_cur_guide:trace_guide_data(true)
  end
  self:force_finish_cur_guide(is_click_skip)
end

function M:jump_all_guide()
  for guide_id, v in pairs(self.v_guide_cfg) do
    if not self.v_complete_list[guide_id] then
      self.v_complete_list[guide_id] = guide_id
      self:request_complete_guide(guide_id, true)
    end
  end
  self:force_finish_cur_guide()
end

function M:force_finish_cur_guide(is_click_skip)
  if self.v_cur_guide then
    self:finish_guide(self.v_cur_guide.guide_id, nil, is_click_skip)
  end
  UIMgr:try_hide_ui("ui_guide")
end

function M:force_finish_fixed_guide(guid_id)
  self:finish_guide(guid_id)
  UIMgr:try_hide_ui("ui_guide")
end

function M:test_guide(guide_id)
  self.v_test_id = guide_id
end

function M:gm_complete_cur_guide()
  if self.v_cur_guide then
    self:jump_guide(self.v_cur_guide.guide_id)
  end
end

function M:get_complete_guides()
  return self.v_complete_list
end

function M:get_cur_guider()
  return self.v_cur_guide
end

function M:clear_guide()
  self.v_disable_guide = true
  if self.v_cur_guide then
    local guide_id = self.v_cur_guide.guide_id
    local step_id = self.v_cur_guide:get_cur_step()
    self.v_break_guide = {
      self:_get_guide_bind_ui(guide_id, step_id),
      guide_id,
      step_id
    }
    Log.Info("break current guide =", "because of show tips=clear_guide", guide_id)
    self:finish_guide(self.v_cur_guide.guide_id, false)
    UIMgr:try_hide_ui("ui_guide")
  end
end

function M:open_guide()
  self.v_disable_guide = nil
end

function M:get_disable_guide()
  return self.v_disable_guide
end

return M
