local Vec3 = require("base.vec3")
local _abs = math.abs
local _ceil = math.ceil
local TWEEN_EASE_LINEAR = CS.DG.Tweening.Ease.Linear
local NODE_ITEM_CLASS = require("uimodule.mini_game.insert_needle.insert_needle_node_item")
local INSERT_NEEDLE_NODE_ITEM_TEMP_KEY = "INSERT_NEEDLE_NODE_ITEM_TEMP_KEY"
local INIT_EFFECT_ROOT_SCALE = 0.575
local CT_Timer = Global.ct_timer
local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local UI_TYPE = {
  GREEN = 1,
  BLUE = 2,
  YELLOW = 3,
  PURPLE = 4
}
local BG_EFFECT = {
  [UI_TYPE.GREEN] = "GreenBg",
  [UI_TYPE.BLUE] = "BlueBg",
  [UI_TYPE.YELLOW] = "CommonBg",
  [UI_TYPE.PURPLE] = "purpleBg"
}
local LINE_EFFECT = {
  [UI_TYPE.GREEN] = "Fx_UIBattleGame2_Wenli_Green",
  [UI_TYPE.BLUE] = "Fx_UIBattleGame2_Wenli_Blue",
  [UI_TYPE.YELLOW] = "Fx_UIBattleGame2_Wenli_Com",
  [UI_TYPE.PURPLE] = "Fx_UIBattleGame2_Wenli_Pur"
}
local END_EFFECT = {
  [UI_TYPE.GREEN] = "Fx_UIBattleGame2_End_Green",
  [UI_TYPE.BLUE] = "Fx_UIBattleGame2_End_Blue",
  [UI_TYPE.YELLOW] = "Fx_UIBattleGame2_End_Com",
  [UI_TYPE.PURPLE] = "Fx_UIBattleGame2_End_Pur"
}
local MISS_EFFECT = {
  [UI_TYPE.GREEN] = "Fx_UI_UIBattleGame2_Miss_Green",
  [UI_TYPE.BLUE] = "Fx_UI_UIBattleGame2_Miss_Blue",
  [UI_TYPE.YELLOW] = "Fx_UI_UIBattleGame2_Miss_Comm"
}
local COOL_EFFECT = {
  [UI_TYPE.GREEN] = "Ani_UIBattleGame2_Handle_Miss",
  [UI_TYPE.BLUE] = "Ani_UIBattleGame2_Handle_Miss",
  [UI_TYPE.YELLOW] = "Ani_UIBattleGame2_Handle_Miss",
  [UI_TYPE.PURPLE] = "Ani_UIBattleGame2_Handle_UnClick"
}
local OUT_EFFECT = {
  [UI_TYPE.GREEN] = "Ani_UIBattleGame2_Out",
  [UI_TYPE.BLUE] = "Ani_UIBattleGame2_Out",
  [UI_TYPE.YELLOW] = "Ani_GameType3_Out",
  [UI_TYPE.PURPLE] = "Ani_UIBattleGame2_Out"
}

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:do_out()
  end)
  self:set_button("BtnA", function()
    self:do_judge(self.v_nodes_A)
  end)
  self:set_button("BtnB", function()
    self:do_judge(self.v_nodes_B)
  end)
  self:register_exist_auto_template(INSERT_NEEDLE_NODE_ITEM_TEMP_KEY, self.v_uiobjects.DecisionPoint, self.v_uiobjects.Content)
  self.v_click_effect = self.v_uiobjects.Ani_UIBattleGame2_Handle_Click
end

function ui:do_out()
  self:clear_out_timer()
  if self.v_timeline_out then
    self.v_timeline_out:SetActive(true)
  end
  self.v_out_timer = Timer:add_timer("mini_game_insert_needle_out", 0.3, function()
    self:ui_hide()
  end)
end

function ui:ui_on_show(id, finish_cb, special_arg, game_id_list)
  if Global.is_skip_insert_needle then
    self:do_out()
    if finish_cb then
      finish_cb()
    end
    return
  end
  if self.v_timeline_out then
    self.v_timeline_out:SetActive(false)
  end
  self.v_uiobjects.Timer:SetActive(false)
  self.v_cur_game_idx = 0
  if special_arg then
    self.v_target_num = tonumber(special_arg[1])
    self.v_target_time = tonumber(special_arg[2])
    self.v_fail_story_id = tonumber(special_arg[3])
    self.v_game_id_list = game_id_list
    if self.v_target_time > 0 then
      self.v_uiobjects.Timer:SetActive(true)
      local time_txt = self.v_uicompents.TimeNum_txt
      self.v_ct_timer = CT_Timer:add_timer("minigame_timer", self.v_target_time, function(sec)
        if sec > 0 then
          time_txt.text = Date.get_print_count_down(sec)
        else
          self:do_out()
          if self.v_fail_story_id then
            StoryMgr:on_start(self.v_fail_story_id)
          end
        end
      end)
    end
  else
    self.v_game_id_list = {id}
  end
  Global.sound_mgr:play_sound_by_id("Sound_xiaoyouxi01_01")
  self.v_finish_cb = finish_cb
  self:play_next()
end

function ui:play_next()
  self.v_cur_game_idx = self.v_cur_game_idx + 1
  local id = self.v_game_id_list[self.v_cur_game_idx]
  if not id then
    self:do_out()
    if self.v_finish_cb then
      self.v_finish_cb()
    end
    return
  end
  self.v_game_cfg = ShareRes.get_minigame_cfg_insertNeedle(id)
  if not self.v_game_cfg then
    Log.Error("miss mini_game insert_needle config id:" .. id)
    self:ui_hide()
  end
  local total_width = self.v_uicompents.SliderArea_rect.rect.width
  local high = self.v_uicompents.SliderArea_rect.rect.height
  self.v_unit_length = total_width / (self.v_game_cfg.nodeNum + 2 * self.v_game_cfg.spacing)
  self.v_spacing = self.v_game_cfg.spacing * self.v_unit_length
  self.v_content_width = total_width - 2 * self.v_spacing
  self.v_uicompents.Content_rect:SetSizeDeltaA(self.v_content_width, high)
  self.v_uicompents.Content_rect:SetAnchoredPositionA(self.v_spacing, 0)
  self.v_uicompents.HandleContent_rect:SetSizeDeltaA(self.v_content_width, high)
  self.v_uicompents.HandleContent_rect:SetAnchoredPositionA(self.v_spacing, 0)
  self.v_handle_trans = self.v_uicompents.Handle_rect
  local left_point = Vec3.New(0, 0, 0)
  local right_point = Vec3.New(self.v_content_width, 0, 0)
  self.v_start_point = self.v_game_cfg.isLeftStart and left_point or right_point
  self.v_end_point = self.v_game_cfg.isLeftStart and right_point or left_point
  self.v_speed = self.v_unit_length * self.v_game_cfg.speed
  self.v_ui_type = self.v_game_cfg.uiType
  self.v_effect_type = self.v_game_cfg.uiTypeEffect or self.v_ui_type
  if 3 == self.v_ui_type then
    local icon_path = self.v_game_cfg.uiTypeIcon
    if type(icon_path) ~= "string" or "" == icon_path then
      icon_path = "UIBattleGame3/Fight_icon_xwh"
    end
    local img = self.v_uicompents["GameType" .. self.v_ui_type .. "_img"]
    ResMgr:load_set_icon(img, icon_path)
    img:SetNativeSize()
  end
  local objs = self.v_uiobjects
  objs.GameType1:SetActiveEx(false)
  objs.GameType2:SetActiveEx(false)
  objs.GameType3:SetActiveEx(false)
  objs.GameType4:SetActiveEx(false)
  objs["GameType" .. self.v_ui_type]:SetActiveEx(true)
  for _, v in pairs(BG_EFFECT) do
    objs[v]:SetActiveEx(false)
  end
  for _, v in pairs(LINE_EFFECT) do
    objs[v]:SetActiveEx(false)
  end
  for _, v in pairs(END_EFFECT) do
    objs[v]:SetActiveEx(false)
  end
  for _, v in pairs(MISS_EFFECT) do
    objs[v]:SetActiveEx(false)
  end
  for _, v in pairs(COOL_EFFECT) do
    objs[v]:SetActiveEx(false)
  end
  for _, v in pairs(OUT_EFFECT) do
    objs[v]:SetActiveEx(false)
  end
  self.v_bg_effect = objs[BG_EFFECT[self.v_effect_type]]
  self.v_bg_effect:SetActiveEx(true)
  self.v_wl_effect = objs[LINE_EFFECT[self.v_effect_type]]
  self.v_end_effect = objs[END_EFFECT[self.v_effect_type]]
  self.v_miss_effect = objs[MISS_EFFECT[self.v_effect_type]]
  self.v_cool_effect = objs[COOL_EFFECT[self.v_effect_type]]
  self.v_timeline_out = objs[OUT_EFFECT[self.v_effect_type]]
  objs.Handle:SetActiveEx(false)
  objs.Handle1:SetActiveEx(4 ~= self.v_ui_type)
  objs.Handle2:SetActiveEx(4 == self.v_ui_type)
  self.v_handle_obj = 4 == self.v_ui_type and objs.Handle2 or objs.Handle1
  Util.set_color(self.v_uicompents.Handle1_img, "FFFFFF")
  Util.set_color(self.v_uicompents.Handle2_img, "FFFFFF")
  self.v_click_effect:SetActiveEx(false)
  objs.BtnB:SetActive(self.v_game_cfg.isDubbleBtn == true)
  objs.TipText:SetActive(4 ~= self.v_ui_type)
  objs.TipText4:SetActive(4 == self.v_ui_type)
  self.v_end_point_cache = self.v_end_point
  self.v_is_cooling = false
  self.v_wait_order = 1
  self:init_nodes()
  self:init_ui()
  self:clear_in_timer()
  self.v_in_timer = Timer:add_timer("mini_game_insert_needle_in", 0.5, function()
    self.v_uiobjects.Handle:SetActiveEx(true)
    self.v_handle_trans:SetLocalPositionA(self.v_start_point.x, 0, 0)
    self:play_anim()
  end)
end

function ui:ui_on_hide()
  self:clear_in_timer()
  self:clear_out_timer()
  self:clear_cool_timer()
  self:clear_next_timer()
  self:clear_exit_timer()
  self:clear_ct_timer()
  if self.v_tween then
    self.v_tween:Kill()
  end
  self:remove_node_obj()
end

function ui:remove_node_obj()
  if self.v_wrap_node_obj then
    for _, node_item in pairs(self.v_wrap_node_obj) do
      node_item:ui_hide()
      node_item:ui_destroy()
    end
  end
  self.v_wrap_node_obj = nil
end

function ui:ui_on_destroy()
end

function ui:init_nodes()
  self.v_nodes_A = self:get_nodes_data(self.v_game_cfg.nodesA, self.v_game_cfg.orderA, self.v_game_cfg.iconA)
  self.v_nodes_B = nil
  if self.v_game_cfg.isDubbleBtn then
    self.v_nodes_B = self:get_nodes_data(self.v_game_cfg.nodesB, self.v_game_cfg.orderB, self.v_game_cfg.iconB)
  end
end

function ui:get_nodes_data(nodes, orders, icons)
  local fix_width = 4 == self.v_game_cfg.uiType and 2
  local nodes_data = {}
  local use_order = self.v_game_cfg.useOrder
  local use_icon = self.v_game_cfg.useIcon
  for idx, node_data in ipairs(nodes) do
    local begin_pos = node_data[1]
    local width = fix_width or node_data[2]
    local end_pos = begin_pos + width - 1
    local order = 0
    local icon
    if use_order then
      order = orders[idx] or 0
    end
    if use_icon then
      icon = icons[idx]
    end
    nodes_data[#nodes_data + 1] = {
      idx = idx,
      begin_pos = begin_pos,
      end_pos = end_pos,
      is_done = false,
      order = order,
      icon = icon
    }
  end
  return nodes_data
end

function ui:init_ui()
  self:refresh_nodes()
  self:give_back_auto_cache(INSERT_NEEDLE_NODE_ITEM_TEMP_KEY, false)
  local _, high = self.v_uicompents.DecisionPoint_rect:GetSizeDeltaA()
  self:remove_node_obj()
  self.v_wrap_node_obj = {}
  for _, node_data in ipairs(self.v_nodes) do
    local item = self:get_auto_cache(INSERT_NEEDLE_NODE_ITEM_TEMP_KEY)
    local node_item = NODE_ITEM_CLASS:ui_wrap_ex(self, item, true)
    node_item:set_data(node_data)
    node_item:set_order_highlight(self.v_wait_order)
    node_data.node_item = node_item
    self.v_wrap_node_obj[#self.v_wrap_node_obj + 1] = node_item
    local width = node_data.end_pos - node_data.begin_pos + 1
    local rect_trans = Util.get_rect_transform(nil, item)
    rect_trans:SetSizeDeltaA(width * self.v_unit_length, high)
    local effect_root_trans = Util.get_rect_transform("EffectRoot_", item)
    effect_root_trans:SetLocalScaleA(width * self.v_unit_length / 100 * INIT_EFFECT_ROOT_SCALE, 1, 1)
  end
end

function ui:refresh_nodes()
  self.v_nodes = {}
  local nodeNum = self.v_game_cfg.nodeNum
  local begin_pos, end_pos
  local next_start_pos = 1
  for pos = 1, nodeNum do
    if pos >= next_start_pos then
      begin_pos = pos
      end_pos = pos
      local node_type, order, icon = self:get_node_type_by_pos(pos)
      if pos == nodeNum then
        self.v_nodes[#self.v_nodes + 1] = self:build_node(begin_pos, end_pos, node_type, order, icon)
        next_start_pos = end_pos + 1
        return
      end
      for p = pos + 1, nodeNum do
        local temp_node_type = self:get_node_type_by_pos(p)
        if node_type ~= temp_node_type then
          end_pos = p - 1
          self.v_nodes[#self.v_nodes + 1] = self:build_node(begin_pos, end_pos, node_type, order, icon)
          next_start_pos = p
          break
        end
        if p == nodeNum then
          end_pos = p
          self.v_nodes[#self.v_nodes + 1] = self:build_node(begin_pos, end_pos, node_type, order, icon)
          next_start_pos = nodeNum + 1
        end
      end
    end
  end
end

function ui:build_node(begin_pos, end_pos, node_type, order, icon)
  local node_data = {
    begin_pos = begin_pos,
    end_pos = end_pos,
    node_type = node_type,
    order = order,
    icon = icon,
    ui_type = self.v_ui_type,
    effect_type = self.v_effect_type,
    is_dead_node = 1 == node_type,
    is_dead_node_highlight = false
  }
  node_data.is_dead_node_highlight = self:check_highlight(node_data)
  return node_data
end

function ui:refresh_nodes_highlight()
  for _, node_data in ipairs(self.v_nodes) do
    local is_dead_node_highlight = self:check_highlight(node_data)
    node_data.is_dead_node_highlight = is_dead_node_highlight
    if is_dead_node_highlight then
      node_data.node_item:set_highlight(true)
    end
  end
end

function ui:check_highlight(node_data)
  if 1 ~= node_data.node_type then
    return false
  end
  local dead_node = node_data
  local close_done_node_A = self:_check_dead_node_close_done_node(dead_node, self.v_nodes_A)
  local close_done_node_B = self:_check_dead_node_close_done_node(dead_node, self.v_nodes_B)
  return close_done_node_A or close_done_node_B
end

function ui:_check_dead_node_close_done_node(dead_node, nodes)
  if not dead_node or not nodes then
    return false
  end
  local begin_pos, end_pos = dead_node.begin_pos, dead_node.end_pos
  for _, node_data in ipairs(nodes) do
    if node_data.begin_pos == end_pos + 1 and node_data.is_done then
      return true
    end
    if node_data.end_pos == begin_pos - 1 and node_data.is_done then
      return true
    end
  end
  return false
end

function ui:get_node_type_by_pos(pos)
  local node_type, order, icon = 1, 0
  if self:check_nodes_contain_pos(self.v_nodes_A, pos) then
    node_type = 2
    order, icon = self:get_nodes_order_icon(self.v_nodes_A, pos)
  elseif self:check_nodes_contain_pos(self.v_nodes_B, pos) then
    node_type = 3
    order, icon = self:get_nodes_order_icon(self.v_nodes_B, pos)
  end
  return node_type, order, icon
end

function ui:check_nodes_contain_pos(nodes, pos)
  if nodes then
    for i, node_data in ipairs(nodes) do
      if pos >= node_data.begin_pos and pos <= node_data.end_pos then
        return true
      end
    end
  end
  return false
end

function ui:get_nodes_order_icon(nodes, pos)
  if nodes then
    for i, node_data in ipairs(nodes) do
      if pos >= node_data.begin_pos and pos <= node_data.end_pos then
        return node_data.order, node_data.icon
      end
    end
  end
  return 0, nil
end

function ui:check_undone_nodes_contain_pos(nodes, pos)
  if not nodes then
    return nil
  end
  for i, node_data in ipairs(nodes) do
    if not node_data.is_done and pos >= node_data.begin_pos and pos <= node_data.end_pos then
      if node_data.order == self.v_wait_order then
        self.v_wait_order = self.v_wait_order + 1
        node_data.is_done = true
        return node_data
      elseif 0 == node_data.order then
        node_data.is_done = true
        return node_data
      end
    end
  end
  return nil
end

function ui:is_nodes_all_done(nodes)
  if Global.is_skip_insert_needle then
    return true
  end
  if not nodes then
    return true
  end
  for i, node_data in ipairs(nodes) do
    if not node_data.is_done then
      return false
    end
  end
  return true
end

function ui:play_anim()
  local moveType = self.v_game_cfg.moveType
  if 1 == moveType then
    self:play_both_track()
  elseif 2 == moveType then
    self:play_single_track()
  elseif 3 == moveType then
    self:play_bounce_track()
  end
end

function ui:play_both_track()
  self.v_tween = self:move_to_point(self.v_end_point_cache)
  self.v_tween:OnComplete(function()
    self.v_end_point_cache = self.v_end_point_cache == self.v_end_point and self.v_start_point or self.v_end_point
    self:play_both_track()
  end)
end

function ui:play_single_track()
  self.v_tween = self:move_to_point(self.v_end_point)
  self.v_tween:OnComplete(function()
    self.v_handle_trans:SetLocalPositionA(self.v_start_point.x, 0, 0)
    self:play_single_track()
  end)
end

function ui:play_bounce_track()
  self.v_tween = self:move_to_point(self.v_end_point_cache)
  self.v_end_point_cache = self.v_end_point_cache == self.v_end_point and self.v_start_point or self.v_end_point
  self.v_tween:OnComplete(function()
    self:play_bounce_track()
  end)
end

function ui:move_to_point(end_point)
  if self.v_tween then
    self.v_tween:Kill()
  end
  local start_point = self.v_handle_trans.localPosition
  local duration = _abs(end_point.x - start_point.x) / self.v_speed
  return self.v_handle_trans:DOLocalMove(end_point, duration):SetEase(TWEEN_EASE_LINEAR)
end

function ui:do_judge(nodes)
  if self.v_is_cooling then
    return
  end
  if self.v_tween then
    self.v_tween:Kill()
  end
  local handle_x = self.v_handle_trans:GetLocalPositionA3()
  local cur_pos = _ceil(handle_x / self.v_unit_length)
  local hit_node = self:check_undone_nodes_contain_pos(nodes, cur_pos)
  if hit_node then
    if self.v_miss_effect then
      self.v_miss_effect:SetActiveEx(false)
    end
    self.v_cool_effect:SetActiveEx(false)
    self.v_click_effect:SetActiveEx(false)
    self.v_click_effect:SetActive(true)
    for _, node_data in ipairs(self.v_nodes) do
      if node_data.begin_pos == hit_node.begin_pos then
        node_data.node_item:do_judge_success()
      end
      node_data.node_item:set_order_highlight(self.v_wait_order)
    end
    Global.sound_mgr:play_sound_by_id("Sound_xiaoyouxi01_02")
  else
    if self.v_miss_effect then
      self.v_miss_effect:SetActiveEx(false)
      self.v_miss_effect:SetActive(true)
    end
    self.v_click_effect:SetActiveEx(false)
    self.v_cool_effect:SetActiveEx(false)
    self.v_cool_effect:SetActive(true)
    self.v_is_cooling = true
    self:clear_cool_timer()
    self.v_cool_timer = Timer:add_timer("mini_game_insert_needle_cool", 1.1, function()
      self.v_is_cooling = false
    end)
    Global.sound_mgr:play_sound_by_id("Sound_xiaoyouxi01_03")
  end
  self:clear_exit_timer()
  local is_nodes_all_done = self:is_nodes_all_done(self.v_nodes_A) and self:is_nodes_all_done(self.v_nodes_B)
  if is_nodes_all_done then
    self.v_handle_obj:SetActiveEx(false)
    self.v_wl_effect:SetActive(true)
    self.v_end_effect:SetActive(true)
    self.v_is_cooling = true
    self.v_exit_timer = Timer:add_timer("mini_game_insert_needle_exit", 0.5, function()
      self:play_next()
    end)
    Global.sound_mgr:play_sound_by_id("Sound_xiaoyouxi01_04")
  else
    self:play_anim()
  end
end

function ui:clear_in_timer()
  if self.v_in_timer then
    Timer:remove_timer(self.v_in_timer)
    self.v_in_timer = nil
  end
end

function ui:clear_out_timer()
  if self.v_out_timer then
    Timer:remove_timer(self.v_out_timer)
    self.v_out_timer = nil
  end
end

function ui:clear_cool_timer()
  if self.v_cool_timer then
    Timer:remove_timer(self.v_cool_timer)
    self.v_cool_timer = nil
  end
end

function ui:clear_next_timer()
  if self.v_next_timer then
    Timer:remove_timer(self.v_next_timer)
    self.v_next_timer = nil
  end
end

function ui:clear_exit_timer()
  if self.v_exit_timer then
    Timer:remove_timer(self.v_exit_timer)
    self.v_exit_timer = nil
  end
end

function ui:clear_ct_timer()
  if self.v_ct_timer then
    CT_Timer:remove_timer(self.v_ct_timer)
    self.v_ct_timer = nil
  end
end

return ui
