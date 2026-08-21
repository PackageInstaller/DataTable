local M = Util.create_class()
local FUNC_TYPE = {
  NORMAL = 1,
  LONG_CLICK = 2,
  NOTIFY = 3,
  STORY = 4
}

function M:_init(guide_id, step)
  self.v_finish_first_step = false
  if not guide_id then
    Log.Error("create guider failure!")
    return
  end
  self.v_skip_data = {}
  self.guide_id = guide_id
  self.v_guide_cfg = ShareRes.create("guide.guide", guide_id)
  if not self.v_guide_cfg then
    Log.Error("read guide config failure! guide_id=", guide_id)
    return
  end
  self.v_cur_step = step or 1
  self.v_guide_step_cfg = ShareRes.create("guide.guide_step", guide_id)
  if not self.v_guide_step_cfg then
    Log.Error("read guide step config failure! guide_id=", guide_id)
    return
  end
  self.v_cur_step_cfg = self.v_guide_step_cfg[self.v_cur_step]
  if not self.v_cur_step_cfg then
    Log.Error("read guide step config failure! step_id=", self.v_cur_step)
    return
  end
  self.v_waiting_ui = nil
  self.v_cur_step = self.v_cur_step - 1
  self.v_cur_step_start_time = Global.real_time
  self:complete_step()
  self.v_finish_init = true
end

local function _trace_step(self)
  if 0 ~= self.v_cur_step then
    local cost_time = math.max(0, Global.real_time - self.v_cur_step_start_time)
    local id = self.v_cur_step_cfg.id
  end
end

function M:complete_step()
  _trace_step(self)
  UIMgr:try_hide_ui("ui_guide")
  local complete_step = self.v_guide_cfg.complete_step
  self.v_guide_compelet = false
  if complete_step and complete_step == self.v_cur_step then
    GuideMgr:complete_guide(self.v_guide_cfg.id)
    self.v_guide_compelet = true
  end
  if 0 ~= self.v_cur_step and self.v_guide_step_cfg[self.v_cur_step] ~= nil then
    self:trace_guide_data()
  end
  if GuideMgr and GuideMgr:get_disable_guide() then
    return
  end
  if nil == GuideMgr:get_cur_guider() and self.v_finish_first_step then
    return
  end
  self:_switch_next_step()
  self.v_finish_first_step = true
end

function M:_switch_next_step()
  self.v_cur_step_start_time = Global.real_time
  self.v_cur_step = self.v_cur_step + 1
  self.v_cur_step_cfg = self.v_guide_step_cfg[self.v_cur_step]
  if not self.v_cur_step_cfg or self.v_guide_compelet then
    GuideMgr:finish_guide(self.v_guide_cfg.id, true)
    self.v_guide_compelet = false
    return
  end
  if self.v_waiting_ui then
    Log.Error("there are already ui waiting. ui=", self.v_waiting_ui)
    return
  end
  self.v_waiting_ui = self.v_cur_step_cfg.ui_name
  self:start_cur_guide(self.v_waiting_ui)
end

function M:_do_step()
  GuideMgr:set_recove_guide_cfg(self.guide_id, self.v_cur_step)
  if self.v_cur_step_cfg.request_cpl then
    GuideMgr:complete_guide(self.guide_id)
  end
  local func_name = self.v_cur_step_cfg.func_name
  if not self[func_name] then
    Log.Error("the guide function of ", func_name, " is not callable, which configed in step=", self.v_cur_step)
    return
  end
  self[func_name](self, self.v_cur_step_cfg.param)
end

function M:start_cur_guide(ui_name)
  if not self.v_waiting_ui or ui_name ~= self.v_waiting_ui then
    return
  end
  local ui = UIMgr:try_get_visible_ui(self.v_waiting_ui)
  if ui then
    local canvas = ui:get_canvas(nil)
    if 0 == canvas.planeDistance then
      Log.Info(self.v_waiting_ui, " is still invisible, when after waiting ", self.v_wait_time, " sec")
      return
    end
    self.v_waiting_ui = nil
    self:_do_step()
  end
end

function M:get_cur_step()
  return self.v_cur_step
end

function M:get_target_ui()
  if self.v_cur_step_cfg then
    return self.v_cur_step_cfg.ui_name
  end
end

function M:get_finish_init()
  return self.v_finish_init
end

function M:onclick_ui_control(arg, ...)
  local param = self:_get_guide_param(arg)
  param.ignore_act = tonumber(arg[9])
  local guide_ui = UIMgr:try_get_visible_ui("ui_guide")
  if guide_ui then
    guide_ui:refresh_guide(param)
  else
    UIMgr:get_ui("ui_guide"):ui_show(self, FUNC_TYPE.NORMAL, param)
  end
end

function M:long_click_ui_control(arg, ...)
  local param = self:_get_guide_param(arg)
  param.cancle_time = tonumber(arg[8])
  local guide_ui = UIMgr:try_get_visible_ui("ui_guide")
  if guide_ui then
    guide_ui:refresh_guide(param)
  else
    UIMgr:get_ui("ui_guide"):ui_show(self, FUNC_TYPE.LONG_CLICK, param)
  end
end

function M:notify_click_ui_control(arg, ...)
  local param = self:_get_guide_param(arg)
  local guide_ui = UIMgr:try_get_visible_ui("ui_guide")
  if guide_ui then
    guide_ui:refresh_guide(param)
  else
    UIMgr:get_ui("ui_guide"):ui_show(self, FUNC_TYPE.NOTIFY, param)
  end
end

function M:stroy_control(arg, ...)
  local param = self:_get_guide_param(arg)
  local guide_ui = UIMgr:try_get_visible_ui("ui_guide")
  if guide_ui then
    guide_ui:refresh_guide(param)
  else
    UIMgr:get_ui("ui_guide"):ui_show(self, FUNC_TYPE.STORY, param)
  end
end

function M:complete_story_guide()
  self:complete_step()
end

function M:is_story_guide()
  if self.v_cur_step_cfg then
    return self.v_cur_step_cfg.story_id ~= nil
  end
end

function M:is_jump_auto_click_guide()
  if self.v_cur_step_cfg then
    return self.v_cur_step_cfg.jump_auto_click ~= nil
  end
end

function M:_get_guide_param(arg)
  local param = {
    guide_id = self.v_guide_cfg.id,
    ui_name = self.v_cur_step_cfg.ui_name,
    story_id = self.v_cur_step_cfg.story_id,
    txt_type = self.v_cur_step_cfg.txt_type,
    txt_icon = self.v_cur_step_cfg.txt_icon,
    txt_icon_pos = self.v_cur_step_cfg.txt_icon_pos,
    spine_id = self.v_cur_step_cfg.spine_id,
    spine_pos = self.v_cur_step_cfg.spine_pos,
    click_mode = self.v_cur_step_cfg.click_mode,
    drag_target_path = self.v_cur_step_cfg.drag_target_path,
    follow_ui = Util.is_more_than_zero(self.v_cur_step_cfg.follow_ui),
    need_mask = tonumber(arg[1]),
    finish_type = tonumber(arg[2]),
    control_path = arg[3],
    hide_frame = tonumber(arg[4]),
    guide_txt = arg[5],
    txt_pos = tonumber(arg[6]),
    need_pause = tonumber(arg[7]),
    auto_jump_delay = self.v_cur_step_cfg.auto_jump_delay,
    delay_show = self.v_cur_step_cfg.delay_show,
    txt_side = self.v_cur_step_cfg.txt_side
  }
  if self.v_cur_step_cfg.func_name == "stroy_control" or 1 == tonumber(arg[2]) then
    self.v_finish_type = true
  else
    self.v_finish_type = false
  end
  return param
end

function M:trace_guide_data(is_skip)
  local id = self.v_guide_cfg.id .. "_" .. self.v_cur_step
  if not is_skip and self.v_skip_data[id] then
    return
  end
  if is_skip then
    self.v_skip_data[id] = true
  end
  local is_skip_step = false
  if is_skip then
    is_skip_step = true
  end
  local is_force_step = false
  if self.v_finish_type then
    is_force_step = true
  end
  local trace_data = {
    tutorial_id = id,
    is_force_step = is_force_step,
    is_skip_step = is_skip_step,
    step_duration = string.format("%.1f", Global.real_time - self.v_cur_step_start_time)
  }
  SDKTrack:trace_guid_data(trace_data)
end

return M
