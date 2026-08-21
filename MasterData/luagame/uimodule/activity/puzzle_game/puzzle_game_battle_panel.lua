local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Input = UnityEngine.Input
local Vec2 = require("base.vec2")
local PREVIEW_COLOR_LEGAL = Util.get_unity_color_by_hex(tonumber("efc66e", 16), 0.6)
local PREVIEW_COLOR_ILLEGAL = Util.get_unity_color_by_hex(tonumber("d74343", 16), 0.6)
local MAP_UNIT_ITEM_TEMP_KEY = "PUZZLE_GAME_MAP_UNIT_ITEM_TEMP_KEY"
local GRAPH_ITEM_TEMP_KEY = "PUZZLE_GAME_GRAPH_ITEM_TEMP_KEY"
local GraphItem = require("uimodule.activity.puzzle_game.puzzle_game_graph_item")
local CommDefine = require("cs_share.common_define")
local _ceil = math.ceil
local ROW_NUM = 6
local COLUMN_NUM = 7
local NODE_WIDTH = 104
local NODE_WIDTH_PADDING = 108

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:on_click_return()
  end)
  self:set_button("BtnReset", function()
    self:on_click_reset()
  end)
  Util.set_click(nil, self.v_uiobjects.MapContent, self, function()
    self:reset_graph_in_map()
  end)
  Util.set_start_drag(self.v_uiobjects.MapContent, self, function(x, y)
    self:drag_start_map(x, y)
  end)
  Util.set_drag(self.v_uiobjects.MapContent, self, function()
    self:on_drag_map()
  end)
  Util.set_end_drag(self.v_uiobjects.MapContent, self, function()
    self:drag_end_map()
  end)
  self.v_progress_content_width = self.v_uicompents.Bar_rect.sizeDelta.x
  self.v_canvas_camera = self:get_canvas().worldCamera
  self.v_preview_unit_obj_num = self.v_uicompents.PreviewUnitObjs_rect.childCount
  self:init_preview()
  self:init_effect()
  self:init_drag_nodes()
  self:register_exist_auto_template(MAP_UNIT_ITEM_TEMP_KEY, self.v_uiobjects.MapUnitObj, self.v_uiobjects.MapContent)
  self:register_exist_auto_template(GRAPH_ITEM_TEMP_KEY, self.v_uiobjects.GraphTem, self.v_uiobjects.GraphContent)
end

function ui:init_preview()
  self.v_preview_nodes = {}
  for i = 1, self.v_preview_unit_obj_num do
    local key = "PreviewUnitObj" .. i
    self.v_preview_nodes[i] = {
      obj = self.v_uiobjects[key],
      img = self.v_uicompents[key .. "_img"]
    }
  end
  self.v_uiobjects.PreviewUnitObjs:SetActiveEx(false)
end

function ui:init_effect()
  self.v_effect_objs = {}
  for i = 1, self.v_preview_unit_obj_num do
    local key = "EffectObj" .. i
    self.v_effect_objs[i] = self.v_uiobjects[key]
  end
  self.v_uiobjects.EffectObjs:SetActiveEx(false)
end

function ui:init_drag_nodes()
  self.v_drag_nodes = {}
  for i = 1, 9 do
    local obj_key = "DragObj" .. i
    local img_key = obj_key .. "_img"
    self.v_drag_nodes[i] = {
      obj = self.v_uiobjects[obj_key],
      img = self.v_uicompents[img_key]
    }
  end
  self.v_uiobjects.DragObjs:SetActiveEx(false)
end

function ui:start_new(stage_id)
  self:on_enter_stage(stage_id)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.puzzle_game_battle_panel_UI_SOUND)
end

function ui:ui_on_show(stage_id)
  self:on_enter_stage(stage_id)
  self:check_close()
  self:bind_auto_mq(Const.MSG_ON_HIDE_UI, self.response_hide_ui_event, self)
  self:bind_auto_mq(Const.MSG_ON_SHOW_UI, self.response_show_ui_event, self)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name, nil, true)
end

function ui:on_enter_stage(stage_id)
  self.v_stage_cfg = ShareRes.get_puzzle_game_cfg(stage_id)
  self.v_activity_id = PuzzleGameMgr:get_activity_id()
  self.v_stage_id = stage_id
  self:show_tage_info()
  self:init_map()
  self:init_graph()
  self:start_count_down()
  self.v_uiobjects.PreviewUnitObjs:SetActiveEx(false)
  self.v_uiobjects.DragObjs:SetActiveEx(false)
  self.v_uiobjects.EffectObjs:SetActiveEx(false)
  self.v_uiobjects.Ani_UIPuzzleMain_In:SetActiveEx(false)
  self.v_uiobjects.Ani_UIPuzzleMain_In:SetActive(true)
  self.v_uicompents.ProgressSPos_rect:SetAnchoredPositionA(self.v_progress_content_width * (self.v_stage_cfg.PassTime - self.v_stage_cfg.EpicPassTime) / self.v_stage_cfg.PassTime, 0, 0)
end

function ui:response_hide_ui_event(msg)
  if nil == msg then
    return
  end
  local ui_name = msg.mm_obj
  if "ui_introduce" == ui_name then
    self:continue_ct()
  end
end

function ui:response_show_ui_event(msg)
  if nil == msg then
    return
  end
  local ui_name = msg.mm_obj
  if "ui_introduce" == ui_name then
    self:stop_ct()
  end
end

function ui:ui_on_hide()
  self:stop_ct()
  self:clear_wrap_items()
end

function ui:ui_on_update(delta_time)
  if self.v_count_down_sec then
    self.v_count_down_sec = self.v_count_down_sec - delta_time
    self:refresh_count_down_txt()
    return
  end
  if self.v_is_running then
    self:do_ct()
  end
end

function ui:show_tage_info()
  local data = PuzzleGameMgr:get_stage_data(self.v_stage_id)
  if not data then
    return
  end
  local is_done = data.pass_second > 0
  self.v_uicompents.StageName_txt.text = string.format("关卡%s", self.v_stage_cfg.SortId)
  self.v_uiobjects.UnlockState:SetActive(not is_done)
  self.v_uiobjects.PassState:SetActive(is_done)
  self.v_uiobjects.Check:SetActive(is_done)
  self.v_uiobjects.ScoreNone:SetActive(data.grade == CommDefine.PUZZLE_GAME_SCORE_GRADE.UNKNOW)
  self.v_uiobjects.ScoreA:SetActive(data.grade == CommDefine.PUZZLE_GAME_SCORE_GRADE.A)
  self.v_uiobjects.ScoreS:SetActive(data.grade == CommDefine.PUZZLE_GAME_SCORE_GRADE.S)
end

function ui:init_map()
  self.v_map_bounds_x = COLUMN_NUM * NODE_WIDTH_PADDING
  self.v_map_bounds_y = ROW_NUM * NODE_WIDTH_PADDING
  local map_graph_cfg = ShareRes.get_puzzle_game_graph_cfg(self.v_stage_cfg.MapGraphId)
  local block_node_icon = map_graph_cfg.Icon
  local row_cfg = map_graph_cfg.Row
  local empty_map = {}
  for row, v in pairs(row_cfg) do
    empty_map[row] = {}
    for _, column in pairs(v) do
      empty_map[row][column] = true
    end
  end
  self.v_map_nodes = {}
  self:give_back_auto_cache(MAP_UNIT_ITEM_TEMP_KEY)
  for row = 1, ROW_NUM do
    for col = 1, COLUMN_NUM do
      local axes_pos = {col, row}
      local pos = self:axes_to_position(axes_pos)
      local map_item_obj = self:get_auto_cache(MAP_UNIT_ITEM_TEMP_KEY)
      local icon_image = self:get_image(nil, map_item_obj)
      map_item_obj.transform:SetAnchoredPositionA(pos[1], pos[2])
      local node = {
        idx = #self.v_map_nodes + 1,
        row = row,
        col = col,
        pos = pos,
        obj = map_item_obj,
        img = icon_image,
        is_block = false,
        is_using = false
      }
      table.insert(self.v_map_nodes, node)
      if empty_map[row] and empty_map[row][col] then
        map_item_obj:SetActiveEx(false)
      else
        ResMgr:load_set_icon(icon_image, block_node_icon)
        node.is_block = true
      end
    end
  end
end

function ui:init_graph()
  local graphs = self.v_stage_cfg.SubGraph
  self:give_back_auto_cache(GRAPH_ITEM_TEMP_KEY)
  self:clear_wrap_items()
  self.v_graph_item_list = {}
  for idx, graph_id in ipairs(graphs) do
    local graph_cfg = ShareRes.get_puzzle_game_graph_cfg(graph_id)
    local obj = self:get_auto_cache(GRAPH_ITEM_TEMP_KEY)
    local item = GraphItem:ui_wrap_ex(self, obj, true)
    item:set_data(graph_cfg, idx)
    table.insert(self.v_graph_item_list, item)
  end
end

function ui:is_draging()
  return self.v_draging
end

local offset_vec2 = Vec2.New()

function ui:get_click_pos(offset)
  local touch_0_pos
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    touch_0_pos = Input.mousePosition
  elseif Input.touchCount > 0 then
    touch_0_pos = Input.GetTouch(0).position
  else
    return
  end
  local click_pos_x, click_pos_y = CSHelper.ScreenPointToLocalPointInRectangle(self.v_uicompents.MapContent_rect, touch_0_pos.x, touch_0_pos.y, self.v_canvas_camera)
  if offset then
    return click_pos_x + offset.x, click_pos_y + offset.y
  else
    return click_pos_x, click_pos_y
  end
end

function ui:axes_to_position(axes_pos)
  axes_pos[1] = (axes_pos[1] - 1) * NODE_WIDTH_PADDING
  axes_pos[2] = (axes_pos[2] - 1) * NODE_WIDTH_PADDING
  return axes_pos
end

function ui:on_drag_start(data, touch_axes_idx)
  self.v_operate_graph_data = data
  self.v_is_drag_suc = false
  self.v_draging = true
  local touch_axes = data.axes_list[touch_axes_idx]
  offset_vec2.x = -((touch_axes[1] - 1) * NODE_WIDTH_PADDING + NODE_WIDTH / 2)
  offset_vec2.y = -((touch_axes[2] - 1) * NODE_WIDTH_PADDING + NODE_WIDTH / 2)
  self:show_drag_nodes()
  self.v_uiobjects.PreviewUnitObjs:SetActiveEx(true)
  self.v_uiobjects.DragObjs:SetActiveEx(true)
  self.v_uicompents.DragObjContent_rect:SetLocalScaleA(0.4, 0.4, 1)
  self.v_uicompents.DragObjContent_rect:DOScale(1, 0.1)
end

function ui:on_drag()
  local click_pos_x, click_pos_y = self:get_click_pos(offset_vec2)
  self.v_uicompents.DragObjs_rect:SetAnchoredPositionA(click_pos_x, click_pos_y, 0)
  local locate_done = false
  self.v_is_drag_suc = true
  self.v_active_preview_objs = {}
  for _, axes in ipairs(self.v_operate_graph_data.axes_list) do
    local pos_x = click_pos_x + (axes[1] - 1) * NODE_WIDTH_PADDING
    local pos_y = click_pos_y + (axes[2] - 1) * NODE_WIDTH_PADDING
    local idx_in_map = self:get_idx_in_map_ex(pos_x, pos_y)
    if idx_in_map then
      local map_node = self.v_map_nodes[idx_in_map]
      local idx_in_preview = (axes[2] - 1) * 3 + axes[1]
      local preview_item = self.v_preview_nodes[idx_in_preview]
      local is_fail = map_node.is_block or map_node.is_using
      preview_item.img.color = is_fail and PREVIEW_COLOR_ILLEGAL or PREVIEW_COLOR_LEGAL
      preview_item.obj:SetActiveEx(true)
      self.v_active_preview_objs[idx_in_preview] = true
      if is_fail then
        self.v_is_drag_suc = false
      end
      if not locate_done then
        locate_done = true
        local match_pos = map_node.pos
        pos_x = match_pos[1] - (axes[1] - 1) * NODE_WIDTH_PADDING
        pos_y = match_pos[2] - (axes[2] - 1) * NODE_WIDTH_PADDING
        self.v_uicompents.PreviewUnitObjs_rect:SetAnchoredPositionA(pos_x, pos_y, 0)
        self.v_match_idx_in_map = idx_in_map - (axes[2] - 1) * COLUMN_NUM - (axes[1] - 1)
      end
    else
      self.v_is_drag_suc = false
    end
  end
  for i, preview_item in ipairs(self.v_preview_nodes) do
    if not self.v_active_preview_objs[i] then
      preview_item.obj:SetActiveEx(false)
    end
  end
end

function ui:on_drag_end()
  self.v_draging = false
  if self.v_is_drag_suc then
    self:show_effect_obj()
    self:show_operate_graph_in_map(self.v_match_idx_in_map)
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.puzzle_set_cube_suc_UI_SOUND)
  else
    self.v_graph_item_list[self.v_operate_graph_data.idx]:set_content_visible(true)
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.puzzle_set_cube_fal_UI_SOUND)
  end
  self.v_uiobjects.PreviewUnitObjs:SetActiveEx(false)
  self.v_uiobjects.DragObjs:SetActiveEx(false)
  if self.v_is_running then
    self:check_all_done()
  end
end

function ui:drag_start_map(click_pos_x, click_pos_y)
  local idx_in_map = self:get_idx_in_map(click_pos_x, click_pos_y)
  local map_node = self.v_map_nodes[idx_in_map]
  local belong_to = map_node and map_node.belong_to
  if belong_to then
    self.v_is_drag_map = true
    for _, node in ipairs(self.v_map_nodes) do
      if node.belong_to == belong_to then
        node.belong_to = nil
        node.is_using = false
        node.obj:SetActiveEx(false)
      end
    end
    local data, touch_pos_idx = self.v_graph_item_list[belong_to]:get_data()
    self:on_drag_start(data, touch_pos_idx)
  end
end

function ui:on_drag_map()
  if not self.v_is_drag_map then
    return
  end
  self:on_drag()
end

function ui:drag_end_map()
  if not self.v_is_drag_map then
    return
  end
  self.v_is_drag_map = false
  self:on_drag_end()
end

function ui:show_effect_obj()
  self.v_uiobjects.EffectObjs:SetActiveEx(false)
  self.v_uicompents.EffectObjs_rect:SetLocalPositionA(self.v_uicompents.PreviewUnitObjs_rect:GetLocalPositionA3())
  for i, preview_item in ipairs(self.v_preview_nodes) do
    self.v_effect_objs[i]:SetActiveEx(preview_item.obj.activeSelf)
  end
  self.v_uiobjects.EffectObjs:SetActiveEx(true)
end

function ui:show_drag_nodes()
  if not self.v_operate_graph_data then
    return
  end
  local active_idx_map = {}
  for _, axes in ipairs(self.v_operate_graph_data.axes_list) do
    local idx = (axes[2] - 1) * 3 + axes[1]
    active_idx_map[idx] = true
  end
  for idx, node in ipairs(self.v_drag_nodes) do
    node.obj:SetActiveEx(true == active_idx_map[idx])
    ResMgr:load_set_icon(node.img, self.v_operate_graph_data.icon)
  end
end

function ui:show_operate_graph_in_map(start_idx)
  if not self.v_operate_graph_data then
    return
  end
  local axes_list = self.v_operate_graph_data.axes_list
  for index, axes in ipairs(axes_list) do
    local idx_in_map = start_idx + (axes[2] - 1) * COLUMN_NUM + (axes[1] - 1)
    local map_node = self.v_map_nodes[idx_in_map]
    if not map_node or map_node.is_block or map_node.is_using then
      Log.Error("位置匹配异常,地图idx:", idx_in_map, "图形idx:", index, "图形list:", axes_list)
    else
      map_node.belong_to = self.v_operate_graph_data.idx
      map_node.is_using = true
      map_node.obj:SetActiveEx(true)
      ResMgr:load_set_icon(map_node.img, self.v_operate_graph_data.icon)
    end
  end
end

function ui:check_all_done()
  for _, graph_item in ipairs(self.v_graph_item_list) do
    if graph_item:get_content_visible() then
      return
    end
  end
  self:stop_ct()
  local pass_second = _ceil(Global.real_time - self.v_start_time_flag)
  local grade = pass_second <= self.v_stage_cfg.EpicPassTime and CommDefine.PUZZLE_GAME_SCORE_GRADE.S or CommDefine.PUZZLE_GAME_SCORE_GRADE.A
  PuzzleGameMgr:send_pass_stage(self.v_activity_id, self.v_stage_id, pass_second, function()
    UIMgr:get_ui("puzzle_game_result_tips"):ui_show(self.v_stage_id, true, grade)
  end)
end

function ui:get_idx_in_map_ex(x, y)
  x = x + 0.5 * NODE_WIDTH
  y = y + 0.5 * NODE_WIDTH
  if x < 0 or x > self.v_map_bounds_x or y < 0 or y > self.v_map_bounds_y then
    return nil
  end
  return self:get_idx_in_map(x, y)
end

function ui:get_idx_in_map(x, y)
  local row = math.floor(y / NODE_WIDTH_PADDING) + 1
  local col = math.floor(x / NODE_WIDTH_PADDING) + 1
  return (row - 1) * COLUMN_NUM + col
end

function ui:reset_graph_in_map()
  local click_pos_x, click_pos_y = self:get_click_pos()
  local idx_in_map = self:get_idx_in_map(click_pos_x, click_pos_y)
  local map_node = self.v_map_nodes[idx_in_map]
  local belong_to = map_node and map_node.belong_to
  if belong_to then
    self.v_graph_item_list[belong_to]:set_content_visible(true)
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.puzzle_set_cube_ret_UI_SOUND)
    for _, node in ipairs(self.v_map_nodes) do
      if node.belong_to == belong_to then
        node.belong_to = nil
        node.is_using = false
        node.obj:SetActiveEx(false)
      end
    end
  end
end

function ui:on_click_reset()
  self:stop_ct()
  Util.show_conform_tip("是否重置", nil, nil, function()
    self:continue_ct()
  end, function()
    self:reset_all()
  end)
end

function ui:on_click_return()
  self:stop_ct()
  Util.show_conform_tip("是否退出", nil, nil, function()
    self:continue_ct()
  end, function()
    self:ui_hide()
  end)
end

function ui:reset_all()
  for _, node in ipairs(self.v_map_nodes) do
    if not node.is_block then
      node.belong_to = nil
      node.is_using = false
      node.obj:SetActiveEx(false)
    end
  end
  self:init_graph()
  self:start_count_down()
  self.v_uiobjects.Ani_UIPuzzleMain_In:SetActiveEx(false)
  self.v_uiobjects.Ani_UIPuzzleMain_In:SetActive(true)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.puzzle_game_battle_panel_UI_SOUND)
end

function ui:do_ct()
  local pass_second = Global.real_time - self.v_start_time_flag
  pass_second = pass_second > 0 and pass_second or 0
  self.v_uicompents.BarFill_img.fillAmount = 1 - pass_second / self.v_stage_cfg.PassTime
  local left_time = self.v_stage_cfg.PassTime - pass_second
  left_time = left_time > 0 and _ceil(left_time * 10) / 10 or 0
  if left_time ~= self.v_showing_second then
    self.v_showing_second = left_time
    self.v_uicompents.Time_txt.text = Util.format_str("{1}秒", left_time)
  end
  if 0 == left_time then
    UIMgr:get_ui("puzzle_game_result_tips"):ui_show(self.v_stage_id, false)
    self.v_is_running = false
  end
end

function ui:start_ct()
  self.v_is_running = true
  self.v_start_time_flag = Global.real_time
  self.v_showing_second = nil
end

function ui:stop_ct()
  self.v_is_running = false
  self.v_stop_time_flag = Global.real_time
end

function ui:continue_ct()
  self.v_is_running = true
  self.v_start_time_flag = Global.real_time - self.v_stop_time_flag + self.v_start_time_flag
end

function ui:clear_wrap_items()
  if self.v_graph_item_list then
    for idx = #self.v_graph_item_list, 1, -1 do
      local item = self.v_graph_item_list[idx]
      item:ui_hide()
      item:ui_destroy()
      self.v_graph_item_list[idx] = nil
    end
    self.v_graph_item_list = nil
  end
end

function ui:start_count_down()
  self.v_count_down_sec = 3
  self.v_cur_count_down_sec = 3
  self.v_uicompents.CountDownText_txt.text = 3
  self.v_uiobjects.CountDown:SetActive(true)
  self.v_uicompents.BarFill_img.fillAmount = 1
  self.v_uicompents.Time_txt.text = Util.format_str("{1}秒", self.v_stage_cfg.PassTime)
end

function ui:refresh_count_down_txt()
  if self.v_count_down_sec < -1 then
    self.v_count_down_sec = nil
    self.v_uiobjects.CountDown:SetActive(false)
    self:start_ct()
    return
  end
  local sec = _ceil(self.v_count_down_sec)
  if self.v_cur_count_down_sec ~= sec then
    self.v_cur_count_down_sec = sec
    if 0 == sec then
      sec = "开始！"
    end
    self.v_uiobjects.CountDownText:SetActiveEx(false)
    self.v_uiobjects.CountDownText:SetActive(true)
    self.v_uicompents.CountDownText_txt.text = sec
  end
end

return ui
