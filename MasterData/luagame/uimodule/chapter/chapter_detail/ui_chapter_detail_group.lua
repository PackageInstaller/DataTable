local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local CHAPTER_DETAIL_ITEM = require("uimodule.chapter.chapter_detail.ui_chapter_detail_item")
local EMPTY = "empty"
local GLOWLINE = "GlowLine"
local MOVE_TIME = 0.65
local SHOW_TIME = 0.3
local REFRESH_TIME = 0.5
local Vec2 = require("base.vec2")
local VEC2_TEMP = Vec2.New()
local CSImage = UnityEngine.UI.Image
local CHAPTER_NODE_STATE = Config.CommonDefine.CHAPTER_NODE_STATE

function ui:ui_finish_load()
  self.v_longitude_obj_list = {}
  self.v_detail_item_obj_list = {}
  self.v_detail_item_map = {}
  self.v_line_map = {}
  self.v_line_obj_name_map = {}
  self.v_empty_pivot = self.v_uicompents.EmptyLine_rect.pivot
  self.v_empty_cg = self:get_canvas_group(nil, self.v_uiobjects.EmptyPoint).component
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
  self.v_all_data = nil
  self.v_area_data = nil
  self.v_can_get_award = false
  self:remove_longitude_show_timer()
  self:remove_refresh_detail_info_timer()
  self:clear_sequence()
  self:give_back_all_temp()
end

function ui:ui_on_destroy()
end

function ui:set_data(chapter_id, all_data, index)
  self.v_chapter_id = chapter_id
  self.v_all_data = all_data
  self.v_area_data = all_data[index]
  self.v_can_get_award = false
  self.v_object.name = self.v_area_data.area_cfg.Id
  self:set_area_width()
  local is_empty_area = Util.is_true(self.v_area_data.area_cfg.IsEmptyArea)
  self:set_empty_area(not is_empty_area)
  if is_empty_area then
    return
  end
  self:set_empty_point()
  self:set_detail_item()
  self:set_longitude()
  self:set_award_node(true)
end

function ui:set_empty_area(is_on)
  local root = self:get_object_transform().transform
  local count = root.childCount
  local child
  for index = 0, count - 1 do
    child = root:GetChild(index)
    child.gameObject:SetActive(is_on)
  end
end

function ui:set_award_node(is_init)
  local area_cfg = self.v_area_data.area_cfg
  if not area_cfg.AwardPointOffset or #area_cfg.AwardPointOffset < 2 then
    return
  end
  local stage_group_id = area_cfg.StageGroup
  if stage_group_id then
    if is_init then
      self.v_parent_ui:add_group_award_item(stage_group_id, self)
    end
    if not self.v_award_node_obj or self.v_award_node_obj:IsNull() then
      self.v_award_node_obj = self.v_parent_ui:get_group_award_node_temp()
    end
    local pro_txt = self:get_text("ProgressNum", self.v_award_node_obj)
    local pro_img = self:get_image("Progress/ProgressFill", self.v_award_node_obj)
    local effect = self:get_child_gameobj("Progress/Image/Effect", self.v_award_node_obj)
    local btn = self:get_button(nil, self.v_award_node_obj)
    local tr = self.v_award_node_obj:GetComponent(typeof(CS.TouchReciver))
    local tf = self.v_award_node_obj.transform
    local task_complete_num, can_get_award_num = ChapterMgr:get_chapter_task_complete_num(self.v_chapter_id, stage_group_id)
    local chapter_cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
    local task_group_id = chapter_cfg.TaskGroupId
    local task_max_num
    self.v_award_node_obj:SetActive(true)
    local task_list = ShareRes.get_chapter_stage_group_task_cfg(task_group_id, stage_group_id)
    if task_list then
      task_max_num = UtilTable.hash_lenth(task_list)
    else
      Log.Error(string.format("获取阶段任务失败，章节任务组%s,阶段%s", task_group_id, stage_group_id))
      return
    end
    self.v_can_get_award = can_get_award_num > 0
    if effect then
      effect:SetActive(self.v_can_get_award)
    end
    local percent = task_complete_num / task_max_num
    pro_txt.text = math.floor(percent * 100) .. "%"
    pro_img.fillAmount = percent
    tf:SetParent(self:get_object_transform().transform)
    tf:ResetAttr()
    tf:SetAnchoredPositionA(area_cfg.AwardPointOffset[1], area_cfg.AwardPointOffset[2])
    btn.enabled = true
    tr.enabled = true
    self:set_button_listener(btn, function()
      self.v_parent_ui:on_click_chapter_task_btn(stage_group_id, "阶段奖励")
    end)
  end
end

function ui:set_detail_item()
  local point_gather = self.v_area_data.point_gather
  if not point_gather then
    return
  end
  local id, module_type, module_param, item_obj, item_map, item
  local obj_index = 1
  local state, is_lock, is_finished
  self.v_empty_unlock = false
  self.v_pass_node_empty_unlock = false
  local max_pos_x, x_offset
  for key, point_cfg in pairs(point_gather) do
    module_type = point_cfg.ModuleType
    module_param = point_cfg.ModuleParam
    if module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE then
      state = ChapterMgr:get_node_state(self.v_chapter_id, module_param)
    elseif module_type == Config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT then
      state = ChapterMgr:get_chapter_point_state(self.v_chapter_id, module_param)
    end
    is_lock = state == CHAPTER_NODE_STATE.LOCK
    is_finished = state == CHAPTER_NODE_STATE.FINISHED
    if not is_lock then
      if not self.v_empty_unlock then
        self.v_empty_unlock = self:need_content_empty()
      end
      if is_finished and self.v_pass_node_empty_unlock then
        self.v_pass_node_empty_unlock = self:need_content_empty()
      end
      id = point_cfg.Id
      self:create_detail_item(id, obj_index)
      x_offset = point_cfg.Offset and point_cfg.Offset[1] or 0
      if not max_pos_x or max_pos_x < x_offset then
        max_pos_x = x_offset
      end
      obj_index = obj_index + 1
    end
  end
  for key, detail_item in pairs(self.v_detail_item_map) do
    self:set_line(detail_item)
  end
  self.v_uiobjects.EmptyPoint:SetActive(self.v_empty_unlock)
end

function ui:create_detail_item(id, obj_index)
  obj_index = obj_index or #self.v_detail_item_obj_list
  local item_obj = self.v_detail_item_obj_list[obj_index]
  if not item_obj then
    item_obj = self.v_parent_ui:get_detail_item_temp()
    self.v_detail_item_obj_list[obj_index] = item_obj
  end
  item_obj.transform:SetParent(self:get_object_transform().transform)
  item_obj.transform:ResetAttr()
  local item = CHAPTER_DETAIL_ITEM:ui_wrap(self, item_obj, true)
  item:set_data(self.v_area_data, id)
  self.v_detail_item_map[id] = item
end

function ui:set_area_width()
  local area_cfg = self.v_area_data.area_cfg
  if area_cfg.AreaWidth then
    local vec2_temp = self.v_parent_ui:get_vec2_temp()
    local self_rect = self:get_rect_transform()
    vec2_temp.y = self_rect.sizeDelta.y
    vec2_temp.x = area_cfg.AreaWidth
    self_rect.sizeDelta = vec2_temp
  end
end

function ui:set_empty_point()
  local area_cfg = self.v_area_data.area_cfg
  local empty_point = self.v_uiobjects.EmptyPoint
  local empty_line_rect = self.v_uicompents.EmptyLine_rect
  if self:need_content_empty() then
    local offset = area_cfg.EmptyPointOffset
    empty_point:SetActive(true)
    empty_point.transform:SetAnchoredPositionA(offset[1], offset[2])
  else
    empty_point:SetActive(false)
  end
  empty_line_rect.pivot = self.v_empty_pivot
  local line_length = area_cfg.LineLength
  local vec2_temp = self.v_parent_ui:get_vec2_temp()
  vec2_temp.y = empty_line_rect.sizeDelta.y
  vec2_temp.x = line_length
  empty_line_rect.sizeDelta = vec2_temp
end

function ui:set_longitude()
  local area_cfg = self.v_area_data.area_cfg
  local longitude_params = area_cfg.LongitudeParams
  local pos_x
  if longitude_params then
    local longitude_obj, longitude_tf, longitude_txt, time_txt, init_y
    for obj_index, param in ipairs(longitude_params) do
      longitude_obj = self.v_longitude_obj_list[obj_index]
      if not longitude_obj then
        longitude_obj = self.v_parent_ui:get_group_longitude_temp()
        self.v_longitude_obj_list[obj_index] = longitude_obj
      end
      longitude_tf = longitude_obj.transform
      longitude_txt = self:get_text("Longitude", longitude_obj)
      time_txt = self:get_text("Time", longitude_obj)
      longitude_txt.text = param[1]
      time_txt.text = "%null" == param[2] and "" or param[2]
      longitude_tf:SetParent(self:get_object_transform().transform, true)
      longitude_tf.transform:ResetAttr()
      init_y = 117
      pos_x = param[3] or 0
      pos_x = tonumber(pos_x)
      longitude_tf:SetAnchoredPositionA(pos_x, init_y)
      local detail_item
      local enable = true
      local point_id = param[4]
      if point_id then
        detail_item = self.v_detail_item_map[point_id]
        if not detail_item then
          enable = false
        else
          enable = detail_item:get_enable()
        end
      end
      longitude_tf:SetActive(enable)
    end
  end
end

function ui:set_line(item)
  local point_cfg = item:get_area_point_cfg()
  local point = point_cfg.FrontConnectPoint
  if point_cfg.FrontConnectPoint < 0 then
    return
  end
  local init_pos = item:get_left_end_point_pos()
  local obj_name, target_pos = self:get_line_name_and_pos(point_cfg.Id, point)
  self:create_line(target_pos, init_pos, obj_name)
  return
end

function ui:set_detail_item_select_state()
  for key, item in pairs(self.v_detail_item_map) do
    item:set_select_state()
  end
end

function ui:set_linked_parent(parent_ui)
  self.v_parent_ui = parent_ui
end

function ui:init_line_fill(line_obj, value, method, origin)
  local horo_line_img = self:get_image(nil, line_obj).component
  horo_line_img.fillAmount = value
  horo_line_img.fillMethod = method
  horo_line_img.fillOrigin = origin
end

function ui:create_line(target_pos, init_pos, obj_name)
  local line_index = #self.v_line_map + 1
  local line_data = {}
  self.v_line_map[line_index] = line_data
  self.v_line_obj_name_map[obj_name] = line_data
  local root_tf = self.v_uiobjects.LineRoot.transform
  local vec2_temp = self.v_parent_ui:get_vec2_temp()
  local cross_pos = vec2_temp.New()
  local mid_point
  cross_pos.x, cross_pos.y = target_pos.x, init_pos.y
  mid_point = vec2_temp.MidPoint(cross_pos, init_pos)
  local hori_dist = vec2_temp.Distance(cross_pos, init_pos)
  local space_dist
  if self:need_content_empty() then
    space_dist = self:get_empty_width() / 2 + 5
    if Util.almost_zero(target_pos.y - init_pos.y) then
      hori_dist = hori_dist - space_dist
      mid_point.x = mid_point.x + space_dist / 2 + 2.5
    else
      mid_point.x = mid_point.x + 1
    end
  end
  local hori_line = self.v_parent_ui:get_group_line_temp()
  self:init_line_fill(hori_line, 1, CSImage.FillMethod.Horizontal, CSImage.OriginHorizontal.Left)
  vec2_temp.x = hori_dist
  vec2_temp.y = 3
  local hori_line_rect = self:get_rect_transform(nil, hori_line)
  VEC2_TEMP:Set(0.5, 0.5)
  hori_line_rect.pivot = VEC2_TEMP
  hori_line_rect.name = obj_name
  hori_line_rect.sizeDelta = vec2_temp
  hori_line_rect:SetParent(root_tf)
  hori_line_rect.transform:ResetAttr()
  hori_line_rect.anchoredPosition = mid_point
  self.v_line_map[line_index].hori = hori_line
  if not Util.almost_zero(target_pos.y - init_pos.y) then
    mid_point = vec2_temp.MidPoint(cross_pos, target_pos)
    local vert_dist = vec2_temp.Distance(cross_pos, target_pos)
    if space_dist then
      if init_pos.y > target_pos.y then
        mid_point.y = mid_point.y + space_dist / 2 + 1
      else
        mid_point.y = mid_point.y - space_dist / 2 - 1
      end
      vert_dist = vert_dist - space_dist
    end
    mid_point.x = mid_point.x + 2.5
    local vert_line = self.v_parent_ui:get_group_line_temp()
    self:init_line_fill(vert_line, 1, CSImage.FillMethod.Vertical, CSImage.OriginVertical.Bottom)
    vec2_temp.x = 3
    vec2_temp.y = vert_dist
    local vert_line_rect = self:get_rect_transform(nil, vert_line)
    VEC2_TEMP:Set(0.5, 0.5)
    vert_line_rect.pivot = VEC2_TEMP
    vert_line_rect.sizeDelta = vec2_temp
    vert_line_rect:SetParent(root_tf)
    vert_line_rect.transform:ResetAttr()
    vert_line_rect.anchoredPosition = mid_point
    vert_line_rect.name = obj_name
    self.v_line_map[line_index].vert = vert_line
  end
end

function ui:give_back_all_temp()
  for id, item in pairs(self.v_detail_item_map) do
    item:ui_hide()
    item:ui_destroy()
    self.v_detail_item_map[id] = nil
  end
  for key, obj in pairs(self.v_longitude_obj_list) do
    self.v_parent_ui:give_back_group_longitude_temp(obj)
    self.v_longitude_obj_list[key] = nil
  end
  for key, obj in pairs(self.v_detail_item_obj_list) do
    self.v_parent_ui:give_back_detail_item_temp(obj)
    self.v_detail_item_obj_list[key] = nil
  end
  for key, all_line in pairs(self.v_line_map) do
    for key, obj in pairs(all_line) do
      self.v_parent_ui:give_back_group_line_temp(obj)
      all_line[key] = nil
    end
  end
  UtilTable.clear_map(self.v_line_obj_name_map)
  if self.v_award_node_obj then
    self.v_parent_ui:give_back_group_award_node_temp(self.v_award_node_obj)
    self.v_award_node_obj = nil
  end
end

function ui:on_click_detail_item(area_point_cfg, not_move)
  self.v_parent_ui:on_click_detail_item(area_point_cfg, not_move)
end

function ui:get_select_param()
  return self.v_parent_ui:get_select_param()
end

function ui:get_empty_pos()
  return self.v_uicompents.EmptyPoint_rect.anchoredPosition
end

function ui:get_empty_width()
  return self.v_uicompents.EmptyPoint_rect.rect.width
end

function ui:need_content_empty()
  local area_cfg = self.v_area_data.area_cfg
  local offset = area_cfg.EmptyPointOffset
  return nil ~= offset and #offset >= 2
end

function ui:get_detail_item(area_point_id)
  if not self.v_detail_item_map[area_point_id] then
    self:create_detail_item(area_point_id)
  end
  return self.v_detail_item_map[area_point_id]
end

function ui:refresh_award_node()
  if self.v_area_data and self.v_area_data.area_cfg then
    self:set_award_node()
  end
end

function ui:get_can_get_award()
  return self.v_can_get_award
end

function ui:get_award_position()
  return self.v_award_node_obj.transform.position
end

function ui:get_award_tf()
  return self.v_award_node_obj.transform
end

function ui:get_line_name_and_pos(start_pos_id, end_pos_id)
  local obj_name = start_pos_id
  local target_item = self.v_detail_item_map[end_pos_id]
  local target_pos
  if end_pos_id > 0 then
    if target_item then
      target_pos = target_item:get_right_end_point_pos()
      obj_name = obj_name .. "|" .. target_item.v_area_point_cfg.Id
    else
      Log.Error("目标点位不存在", end_pos_id)
      return
    end
  else
    target_pos = self:get_empty_pos()
    obj_name = obj_name .. EMPTY
  end
  return obj_name, target_pos
end

function ui:get_line_name(start_pos_id, end_pos_id)
  local obj_name
  local end_point_cfg = ShareRes.get_chapter_area_point_cfg(end_pos_id)
  if end_point_cfg.FrontConnectPoint == start_pos_id then
    obj_name = start_pos_id .. end_pos_id
  else
    obj_name = end_pos_id .. EMPTY
  end
  return obj_name
end

function ui:do_unlock_anima(start_pos_id, end_pos_id, need_refresh_detail, cb)
  self:clear_sequence()
  local target_item = self.v_detail_item_map[end_pos_id]
  if not target_item then
    return false
  end
  self.v_parent_ui:on_unlock_anima_play()
  self.v_sequence = Util.create_sequence()
  local target_point_cfg = target_item:get_area_point_cfg()
  local obj_name, _ = self:get_line_name(start_pos_id, end_pos_id)
  local line_data = self.v_line_obj_name_map[obj_name]
  
  local function done_cb()
    self.v_parent_ui:on_unlock_anima_end()
    target_item:set_enable(true)
    target_item:play_unlock_pd(cb)
    self:clear_sequence()
  end
  
  target_item:set_lock_state(true, true)
  local show_time
  if not line_data or not line_data.hori and not line_data.vert then
    done_cb()
    show_time = self.v_parent_ui:get_move_time() - SHOW_TIME
    self:add_longitude_show_timer(show_time, end_pos_id)
    return false
  end
  local hori_line = line_data.hori
  local vert_line = line_data.vert
  local is_single_line = nil == hori_line or nil == vert_line
  local line_fill_time, line_obj
  local is_empty_line = nil ~= string.find(obj_name, EMPTY)
  self.v_uiobjects.EmptyLine:SetActive(is_empty_line)
  if is_empty_line then
    if not self.v_pass_node_empty_unlock then
      self.v_pass_node_empty_unlock = self:need_content_empty()
      self.v_uiobjects.EmptyPoint:SetActive(self.v_pass_node_empty_unlock)
    end
    self.v_empty_cg.alpha = 0
    line_fill_time = MOVE_TIME / 2
    self.v_uicompents.EmptyLine_img.fillAmount = 0
    self.v_sequence:Join(self.v_empty_cg:DOFade(1, line_fill_time))
    self.v_sequence:Join(self.v_uicompents.EmptyLine_img:DOFillAmount(1, line_fill_time))
  else
    line_fill_time = MOVE_TIME
  end
  if is_single_line then
    line_obj = hori_line or vert_line
    self:line_dot(line_obj, line_fill_time, nil ~= hori_line)
  else
    line_fill_time = line_fill_time / 2
    self:line_dot(vert_line, line_fill_time, false)
    self:line_dot(hori_line, line_fill_time)
  end
  for key, obj in pairs(line_data) do
    obj:SetActive(true)
  end
  self.v_sequence:OnComplete(done_cb)
  self.v_parent_ui:move_to_target_area_point(target_point_cfg.AreaId, target_point_cfg.Id, true, true, true, MOVE_TIME, nil, true)
  if need_refresh_detail then
    self:add_refresh_detail_info_timer(REFRESH_TIME, end_pos_id)
  end
  show_time = MOVE_TIME - SHOW_TIME
  self:add_longitude_show_timer(show_time, end_pos_id, need_refresh_detail)
  return true
end

function ui:add_longitude_show_timer(show_time, end_pos_id)
  self:remove_longitude_show_timer()
  if show_time <= 0 then
    self:refresh_longitude_show_state(end_pos_id)
  else
    self.v_longitude_show_timer = Timer:add_timer("longitude_show_timer", show_time, function()
      self:refresh_longitude_show_state(end_pos_id)
    end)
  end
end

function ui:remove_longitude_show_timer()
  if self.v_longitude_show_timer then
    Timer:remove_timer(self.v_longitude_show_timer)
    self.v_longitude_show_timer = nil
  end
end

function ui:line_dot(line_obj, line_fill_time, show_glow)
  local line_img = self:get_image(nil, line_obj).component
  line_img.fillAmount = 0
  self.v_sequence:Append(line_img:DOFillAmount(1, line_fill_time))
end

function ui:clear_sequence()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

function ui:get_line_data(start_pos_id, end_pos_id)
  local obj_name, _ = self:get_line_name(start_pos_id, end_pos_id)
  local line_data = self.v_line_obj_name_map[obj_name]
  return line_data
end

function ui:set_line_visible(start_pos_id, end_pos_id, visible)
  local line_data = self:get_line_data(start_pos_id, end_pos_id)
  if not line_data or not line_data.hori and not line_data.vert then
    return
  end
  for key, obj in pairs(line_data) do
    obj:SetActive(visible)
  end
end

function ui:set_empty_point_visible_on_pass_node()
  self.v_uiobjects.EmptyPoint:SetActive(self.v_pass_node_empty_unlock)
end

function ui:refresh_longitude_show_state(force_id)
  local area_cfg = self.v_area_data.area_cfg
  local longitude_params = area_cfg.LongitudeParams
  local point_id, enable
  if longitude_params then
    local longitude_tf
    for obj_index, param in ipairs(longitude_params) do
      longitude_tf = self.v_longitude_obj_list[obj_index]
      if longitude_tf then
        point_id = param[4]
        if point_id and self.v_detail_item_map[point_id] then
          enable = self.v_detail_item_map[point_id]:get_enable() or force_id == point_id
        end
        longitude_tf:SetActive(enable)
      end
    end
  end
end

function ui:remove_refresh_detail_info_timer()
  if self.v_refresh_detail_info_timer then
    Timer:remove_timer(self.v_refresh_detail_info_timer)
    self.v_refresh_detail_info_timer = nil
  end
end

function ui:add_refresh_detail_info_timer(show_time, pos_id)
  self:remove_refresh_detail_info_timer()
  if show_time <= 0 then
    self.v_detail_item_map[pos_id]:on_click_detail_item(true)
  else
    self.v_refresh_detail_info_timer = Timer:add_timer("refresh_detail_info_timer", show_time, function()
      self.v_detail_item_map[pos_id]:on_click_detail_item(true)
    end)
  end
end

return ui
