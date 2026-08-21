local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Math = require("base.mathx")
local NODECONTENT_CLUETEM_TEMP_KEY = "NODECONTENT_CLUETEM_TEMP_KEY"
local LINKCONTENT_LINETEMP_TEMP_KEY = "LINKCONTENT_LINETEMP_TEMP_KEY"
local NODECONTENT_THINKTEM_TEMP_KEY = "NODECONTENT_THINKTEM_TEMP_KEY"

function ui:on_click_node(node_id)
  local node_cfg = ShareRes.get_ponder_maze_node_cfg(node_id)
  if 3 == node_cfg.NodeType then
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_maze_game_view_click_UI_SOUND)
  end
  NoviceMgr.ponder_maze_mgr:try_interactable_node(node_id)
end

function ui:on_click_BtnRet1()
  local function sure_cb()
    self:ui_hide()
    
    NoviceMgr:stop_ponder_maze_game()
    UIMgr:try_show_ui("ui_maze_game_main", nil, self.v_activity_id)
  end
  
  if self.v_all_finish then
    sure_cb()
    return
  end
  Util.show_conform_tip("退出后当前进度将重制，是否退出？", "取消", "确定", nil, sure_cb)
end

function ui:on_click_BtnMain()
  local function sure_cb()
    if not SceneMgr:check_main_scene() then
      UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("当前场景不可回到主界面"))
    else
      UIMgr:go_to_main()
      UIMgr:clear_all_cache_ui_custom_data()
    end
    NoviceMgr:stop_ponder_maze_game()
  end
  
  if self.v_all_finish then
    sure_cb()
    return
  end
  Util.show_conform_tip("退出后当前进度将重制，是否退出？", "取消", "确定", nil, sure_cb)
end

function ui:on_ponder_maze_game_node_update()
  self:refresh_node_map()
end

function ui:on_ponder_maze_game_thought_update()
  self:refresh_thought_and_clue()
end

function ui:on_ponder_maze_restart()
  self:refresh_view()
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:on_click_BtnRet1()
  end)
  self:_init_common_widget()
  self:set_button("BtnMain", function()
    self:on_click_BtnMain()
  end)
  self.v_uiobjects.LineTemp:SetActive(false)
  self.v_cache_line_obj_map = {}
  self.v_line_obj_map = {}
  self:register_exist_auto_template(NODECONTENT_CLUETEM_TEMP_KEY, self.v_uiobjects.ClueTem, self.v_uiobjects.NodeContent)
  self:register_exist_auto_template(LINKCONTENT_LINETEMP_TEMP_KEY, self.v_uiobjects.LineTemp, self.v_uiobjects.LinkContent)
  self:register_exist_auto_template(NODECONTENT_THINKTEM_TEMP_KEY, self.v_uiobjects.ThinkTem, self.v_uiobjects.NodeContent)
end

function ui:ui_on_show()
  UIMgr:remove_stace_by_ui_name("ui_maze_game_event")
  self.v_activity_id, self.v_point_id = NoviceMgr.ponder_maze_mgr:get_game_param()
  local is_active = NoviceMgr:get_novice_activity_active(self.v_activity_id)
  if not is_active then
    UIMgr:go_to_main()
    return
  end
  self.v_point_cfg = ShareRes.get_ponder_maze_point_cfg(self.v_point_id)
  self.v_map_id = self.v_point_cfg.MapID
  self:refresh_view()
  NoviceMgr:check_maze_game_tips_and_story(self.v_activity_id)
  self:bind_auto_mq(Const.ON_PONDER_MAZE_NODE_UPDATE, self.on_ponder_maze_game_node_update, self)
  self:bind_auto_mq(Const.ON_PONDER_MAZE_ITEM_UPDATE, self.on_ponder_maze_game_thought_update, self)
  self:bind_auto_mq(Const.ON_PONDER_MAZE_RESTART, self.on_ponder_maze_restart, self)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh_view()
  self:refresh_thought_and_clue()
  self:refresh_node_map()
end

function ui:refresh_thought_and_clue()
  local map_cfg = ShareRes.get_ponder_maze_map_cfg(self.v_map_id)
  self.v_uicompents.Content_rect:SetSizeDeltaA(map_cfg.MapSize[1], map_cfg.MapSize[2])
  self.v_all_finish = true
  for i = 1, 3 do
    local clue_obj = self.v_uiobjects["Clue" .. i]
    local clue_id = map_cfg.TargetClue[i]
    if clue_id then
      clue_obj:SetActive(true)
      local clue_txt = self:get_text("Text", clue_obj)
      local clue_num_txt = self:get_text("NumText", clue_obj)
      local clue_cfg = ShareRes.get_ponder_maze_clue_cfg(clue_id)
      clue_txt.text = clue_cfg.Name
      local curr_count = NoviceMgr.ponder_maze_mgr:get_clue_count(clue_id)
      local total_count = map_cfg.ClueCount[i] or 0
      clue_num_txt.text = curr_count .. "/" .. total_count
      if self.v_all_finish and curr_count < total_count then
        self.v_all_finish = false
      end
    else
      clue_obj:SetActive(false)
    end
    local thought_id = map_cfg.Thought[i]
    local thought_num = NoviceMgr.ponder_maze_mgr:get_thought_count(thought_id)
    local thought_img = self.v_uicompents["Think" .. i .. "_img"]
    if thought_id then
      thought_img.gameObject:SetActive(true)
      local thought_cfg = ShareRes.get_ponder_maze_node_thought_cfg(thought_id)
      if thought_cfg then
        ResMgr:load_set_icon(thought_img, thought_cfg.IconPath[3])
      end
      local thought_txt = self:get_text("Text", thought_img.gameObject)
      thought_txt.text = thought_num
    else
      thought_img.gameObject:SetActive(false)
    end
  end
end

local function calculateAngleBetweenUpAndAB(x1, z1, x2, z2)
  local abX = x2 - x1
  local abY = z2 - z1
  local upX, upY = 0, 1
  local dot = upX * abX + upY * abY
  local cross = upX * abY - upY * abX
  local angle_rad = math.acos(dot / math.sqrt(abX ^ 2 + abY ^ 2))
  local angle_deg = math.deg(angle_rad)
  return cross >= 0 and angle_deg or 360 - angle_deg
end

function ui:create_line(node_id, pre_node_id, is_active)
  local temp_key = node_id .. pre_node_id
  if self.v_line_obj_temp[temp_key] then
    if is_active then
      self.v_line_obj_temp[temp_key]:SetActive(is_active)
      local active_obj = self:get_child_gameobj("Active", self.v_line_obj_temp[temp_key])
      if active_obj then
        active_obj:SetActive(true == is_active)
      end
    end
    return
  end
  local node_cfg = ShareRes.get_ponder_maze_node_cfg(node_id)
  local pre_node_cfg = ShareRes.get_ponder_maze_node_cfg(pre_node_id)
  local node_pos = node_cfg.Position
  local pre_node_pos = pre_node_cfg.Position
  if not (node_pos[1] and node_pos[2] and pre_node_pos[1]) or not pre_node_pos[2] then
    Log.Error("create_line error, pos format error", node_id, pre_node_id)
    return
  end
  local pre_node_pos_x, pre_node_pos_y = pre_node_pos[1], pre_node_pos[2]
  if 1 == pre_node_cfg.NodeType then
    local dir_x, dir_y = pre_node_pos_x - node_pos[1], pre_node_pos_y - node_pos[2]
    Util.VEC2_TEMP:Set(dir_x, dir_y)
    Util.VEC2_TEMP:SetNormalize():Mul(-200)
    pre_node_pos_x, pre_node_pos_y = pre_node_pos_x + Util.VEC2_TEMP.x, pre_node_pos_y + Util.VEC2_TEMP.y
  end
  local center_pos_x = (node_pos[1] + pre_node_pos_x) / 2
  local center_pos_y = (node_pos[2] + pre_node_pos_y) / 2
  local dist = Math.dist_vec2A(node_pos[1], node_pos[2], pre_node_pos_x, pre_node_pos_y)
  local dir = calculateAngleBetweenUpAndAB(node_pos[1], node_pos[2], pre_node_pos_x, pre_node_pos_y) + 180
  local line_obj = self:get_auto_cache(LINKCONTENT_LINETEMP_TEMP_KEY)
  line_obj.transform:SetParent(self.v_uicompents.LinkContent_rect)
  line_obj:SetActive(true)
  local rect_tf = self:get_rect_transform(nil, line_obj)
  rect_tf:SetAnchoredPositionA(center_pos_x, center_pos_y)
  rect_tf:SetSizeDeltaHeightA(dist)
  rect_tf:SetLocalEuler(0, 0, dir)
  local active_obj = self:get_child_gameobj("Active", line_obj)
  if active_obj then
    active_obj:SetActive(true == is_active)
  end
  self.v_line_obj_temp[temp_key] = line_obj
  self.v_line_obj_temp[pre_node_id .. node_id] = line_obj
end

function ui:create_node(node_id)
  local node_cfg = ShareRes.get_ponder_maze_node_cfg(node_id)
  local node_pos = node_cfg.Position
  local node_obj
  local thought_id = node_cfg.ThoughtId
  local thought_cfg = ShareRes.get_ponder_maze_node_thought_cfg(thought_id)
  local event_cfg = ShareRes.get_ponder_maze_node_event_cfg(node_cfg.Event)
  local icon_path, event_icon_path
  local is_active = NoviceMgr.ponder_maze_mgr:get_node_active_state(node_id)
  local is_comp = NoviceMgr.ponder_maze_mgr:get_node_comp_state(node_id)
  if 1 == node_cfg.NodeType then
    node_obj = self.v_uiobjects.Start
  elseif 2 == node_cfg.NodeType then
    icon_path = thought_cfg.IconPath[2]
    node_obj = self:get_auto_cache(NODECONTENT_THINKTEM_TEMP_KEY)
    if node_cfg.Event then
      event_icon_path = event_cfg.IconPath
    end
  elseif 3 == node_cfg.NodeType then
    icon_path = thought_cfg.IconPath[1]
    node_obj = self:get_auto_cache(NODECONTENT_CLUETEM_TEMP_KEY)
    local name_txt = self:get_text("ClueName_", node_obj)
    local clue_cfg = ShareRes.get_ponder_maze_clue_cfg(node_cfg.RelevantClue)
    name_txt.text = clue_cfg.Name
    local color_str = is_active and "EDDA84" or "AE9577"
    Util.set_color(name_txt, color_str)
    local active = self:get_child_gameobj("Active", node_obj)
    active:SetActive(is_active)
  end
  local icon_img = self:get_image("Icon_", node_obj)
  local type_icon_img = self:get_image("TypeIcon_", node_obj)
  local mask = self:get_child_gameobj("Mask_", node_obj)
  local click_btn = self:get_button(nil, node_obj)
  if type_icon_img and event_icon_path then
    ResMgr:load_set_icon(type_icon_img, event_icon_path)
  end
  if type_icon_img then
    type_icon_img.gameObject:SetActive(node_cfg.Event ~= nil)
  end
  node_obj.transform:SetAnchoredPositionA(node_pos[1], node_pos[2])
  if icon_img and icon_path then
    ResMgr:load_set_icon(icon_img, icon_path)
  end
  if click_btn then
    self:set_button_listener(click_btn, function()
      self:on_click_node(node_id)
    end)
  end
  if mask then
    mask:SetActive(not is_comp)
  end
end

function ui:refresh_node_map()
  self:give_back_auto_cache(LINKCONTENT_LINETEMP_TEMP_KEY)
  self:give_back_auto_cache(NODECONTENT_CLUETEM_TEMP_KEY)
  self:give_back_auto_cache(NODECONTENT_THINKTEM_TEMP_KEY)
  self.v_line_obj_temp = {}
  local map_cfg = ShareRes.get_ponder_maze_map_cfg(self.v_map_id)
  local library_id = map_cfg.NodeLibraryID
  local node_cfgs = ShareRes.get_ponder_maze_node_library_cfg(library_id)
  self.v_line_obj_map = {}
  local node_temp_map = {}
  for node_id, node_cfg in pairs(node_cfgs) do
    if not node_temp_map[node_id] then
      self:create_node(node_id)
    end
    for _, pre_node_id in pairs(node_cfg.PreNode) do
      local is_active = NoviceMgr.ponder_maze_mgr:get_node_comp_state(pre_node_id)
      self:create_line(node_id, pre_node_id, is_active)
    end
  end
end

function ui:cache_ui()
  return true
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name, false, true)
end

return ui
