local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local PuzzleHelper = require("uimodule.character.puzzle.puzzle_helper")
local TEMPLATE_KEY_ATTR = "CHAR_PUZZLE_TEMPLATE_KEY_ATTR"
local TEMPLATE_KEY_EFFECT = "CHAR_PUZZLE_TEMPLATE_KEY_EFFECT"
local ImageType = TypeUnityUIImage
local Input = UnityEngine.Input
local Vec2 = require("base.vec2")
local RectTransformUtility = UnityEngine.RectTransformUtility

function ui:ui_finish_load()
  self:set_toggle("PageAttr", function(is_on)
    if not is_on then
      return
    end
    self.v_uiobjects.AttrList:SetActive(true)
    self.v_uiobjects.EffectList:SetActive(false)
  end)
  self:set_toggle("PageEffect", function(is_on)
    if not is_on then
      return
    end
    self.v_uiobjects.AttrList:SetActive(false)
    self.v_uiobjects.EffectList:SetActive(true)
  end)
  self:set_button("BtnEquip", function()
    UIMgr:get_ui("puzzle_panel"):ui_show(self.v_buddy_id)
  end)
  Util.set_click(nil, self.v_uiobjects.MapContent, self, function()
    self:on_point_click_at_map()
  end)
  self.v_canvas_camera = self.v_parent_ui:get_canvas().worldCamera
  self.v_tem_obj_root_trans = self.v_uiobjects.TempObjs.transform
  self:register_exist_auto_template(TEMPLATE_KEY_ATTR, self.v_uiobjects.AttrTemp, self.v_uiobjects.AttrContent)
  self:register_exist_auto_template(TEMPLATE_KEY_EFFECT, self.v_uiobjects.EffectTem, self.v_uiobjects.EffectContent)
end

function ui:ui_on_show()
  self.v_buddy_id = CharacterMgr.v_last_select_buddy_id
  self.v_uicompents.PageAttr_tog.isOn = true
  self:refresh_puzzle_red()
  self:bind_auto_mq(Const.MSG_BUDDY_DATA_UPDATE, self.refresh_map_nodes, self)
end

function ui:refresh(buddy_id)
  if buddy_id then
    self.v_buddy_id = buddy_id
  end
  self:refresh_graph()
  self:refresh_map_nodes_occupy()
end

function ui:clear_node_objs()
  if self.v_node_objs and #self.v_node_objs > 0 then
    for i = #self.v_node_objs, 1, -1 do
      UnityDestroy(self.v_node_objs[i])
    end
  end
  self.v_node_objs = nil
end

function ui:refresh_graph()
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  local puzzle_graph = buddy_info.puzzle_graph
  local map_graph_id = puzzle_graph.id
  local map_trans = self.v_uiobjects.MapContent.transform
  local map_obj_num = map_trans.childCount
  for idx = 0, map_obj_num - 1 do
    map_trans:GetChild(idx):SetActive(false)
  end
  if not self.v_uiobjects["MapGraph" .. map_graph_id] then
    Log.Error("没有与地图id匹配的地图UI，需要将该地图命名为MapGraph" .. map_graph_id)
    return
  end
  self.v_uiobjects["MapGraph" .. map_graph_id]:SetActive(true)
  local puzzle_place_infos = puzzle_graph.puzzle_place_infos
  self:clear_node_objs()
  self.v_node_objs = {}
  for idx, node_data in ipairs(puzzle_place_infos) do
    local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(node_data.id)
    local graph_obj = self.v_uiobjects["TempObj" .. puzzle_cfg.GraphID]
    if not graph_obj then
      Log.Error("没有与图形id匹配的预制节点，需要将该地图命名为TempObj" .. puzzle_cfg.GraphID)
      return
    end
    local obj = UnityGameObject.Instantiate(graph_obj, self.v_uiobjects.ObjContent.transform)
    self.v_node_objs[idx] = obj
    local hex_pos = node_data.position
    local position = PuzzleHelper.hex_to_position(hex_pos)
    obj.transform:SetAnchoredPositionA(position.x, position.y)
    obj.transform:Rotate(0, 0, 60 * node_data.rotate_count)
    obj:SetActive(true)
    local icon_path = puzzle_cfg.IconPath[node_data.quality]
    local img = obj:GetComponent(ImageType)
    ResMgr:load_set_icon(img, icon_path, nil, true)
  end
  self:refresh_attr_list(puzzle_place_infos)
  self:refresh_entry_list(puzzle_place_infos)
end

function ui:refresh_attr_list(puzzle_place_infos)
  self:give_back_auto_cache(TEMPLATE_KEY_ATTR)
  local attr_id2value = {}
  for _, node_data in ipairs(puzzle_place_infos) do
    for _, attr_cfg_id in ipairs(node_data.attr_list) do
      local attr_cfg = ShareRes.get_buddy_puzzle_attr_cfg(attr_cfg_id)
      attr_id2value[attr_cfg.AttrId] = (attr_id2value[attr_cfg.AttrId] or 0) + attr_cfg.AttrValue
    end
  end
  local is_empty = not next(attr_id2value)
  self.v_uiobjects.AttrEmpty:SetActive(is_empty)
  if is_empty then
    return
  end
  for _, attr_show_cfg in ipairs(ShareRes.get_buddy_puzzle_attr_show_list()) do
    local attr_id = attr_show_cfg.AttrId
    local attr_val = attr_id2value[attr_id]
    if attr_val then
      local item = self:get_auto_cache(TEMPLATE_KEY_ATTR)
      local icon = Util.get_image("AttrIcon", item)
      local name_txt = Util.get_text("AttrName", item)
      local val_txt = Util.get_text("AttrVal", item)
      Util.load_attr_icon(icon, ShareRes.get_attr_icon(attr_id))
      name_txt.text = attr_show_cfg.Desc
      local is_ration = 1 == attr_show_cfg.AttrType
      val_txt.text = Util.format_number(attr_val, is_ration)
    end
  end
end

function ui:refresh_entry_list(puzzle_place_infos)
  self:give_back_auto_cache(TEMPLATE_KEY_EFFECT)
  local entry_list = {}
  local entry_map = {}
  for _, puzzle_place_info in ipairs(puzzle_place_infos) do
    local puzzle_id = puzzle_place_info.id
    local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(puzzle_id)
    local entry_id = puzzle_cfg.EntryId
    if entry_id and (not entry_map[entry_id] or entry_map[entry_id] < puzzle_place_info.quality) then
      entry_map[entry_id] = puzzle_place_info.quality
    end
  end
  for entry_id, quality in pairs(entry_map) do
    entry_list[#entry_list + 1] = {id = entry_id, quality = quality}
  end
  table.sort(entry_list, function(a, b)
    if a.quality ~= b.quality then
      return a.quality > b.quality
    end
    return a.id < b.id
  end)
  local is_empty = not next(entry_list)
  self.v_uiobjects.EffectEmpty:SetActive(is_empty)
  if is_empty then
    return
  end
  for _, data in ipairs(entry_list) do
    local item = self:get_auto_cache(TEMPLATE_KEY_EFFECT)
    local entry_cfg = ShareRes.get_buddy_puzzle_entry_cfg(data.id, data.quality)
    Util.get_text("Title/EffectName", item).text = entry_cfg.Name
    Util.get_text("Title/EffectLv", item).text = "Lv." .. entry_cfg.Lv
    Util.get_text("EffectDesc", item).text = entry_cfg.Desc
  end
end

function ui:refresh_puzzle_red()
  local is_show_red = PuzzleMgr:is_any_free_puzzle_can_fit(self.v_buddy_id)
  self.v_uiobjects.RedPlugins:SetActive(is_show_red)
end

function ui:ui_on_hide()
  self:clear_node_objs()
end

function ui:ui_on_destroy()
end

function ui:on_point_click_at_map()
  local click_pos = self:get_click_pos()
  local closest_node_idx = PuzzleHelper.match_closest_node_idx(self.v_map_position_list, click_pos)
  local uuid = closest_node_idx and self.v_map_node_idx_to_puzzle_item_uuid[closest_node_idx]
  if uuid then
    Util.show_puzzle_tip(uuid, {
      offset = Config.PUZZLE_TIPS_OFFSET.RIGHT,
      show_up_lv_btn = true,
      show_remove_btn = true,
      show_select_btn = false,
      hide_close_btn = true,
      remove_cb = function()
        PuzzleMgr:uninstall_puzzle(uuid)
      end
    })
  end
end

local vec2_pos = Vec2.New()

function ui:get_click_pos(offset)
  local touch_0_pos
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    touch_0_pos = Input.mousePosition
  elseif Input.touchCount > 0 then
    touch_0_pos = Input.GetTouch(0).position
  else
    return
  end
  local click_pos_x, click_pos_y = CSHelper.ScreenPointToLocalPointInRectangle(self.v_tem_obj_root_trans, touch_0_pos.x, touch_0_pos.y, self.v_canvas_camera)
  vec2_pos.x = click_pos_x
  vec2_pos.y = click_pos_y
  if offset then
    return vec2_pos + offset
  else
    return vec2_pos
  end
end

function ui:refresh_map_nodes_occupy()
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  local puzzle_graph = buddy_info.puzzle_graph or {}
  local map_graph_id = puzzle_graph.id
  local puzzle_place_infos = puzzle_graph.puzzle_place_infos or {}
  self.v_map_position_list = PuzzleHelper.get_garph_position_list(map_graph_id, 0)
  self.v_map_hex_pos_list = ShareRes.get_buddy_puzzle_graph_hex_pos(map_graph_id, 0)
  local hex_to_puzzle_id = {}
  for idx, node_data in ipairs(puzzle_place_infos) do
    local anchor_hex_pos = node_data.position
    local graph_hex_pos_list = ShareRes.get_buddy_puzzle_graph_hex_pos_by_puzzle_id(node_data.id, node_data.rotate_count)
    for _, relative_hex_pos in ipairs(graph_hex_pos_list) do
      local real_hex_x = anchor_hex_pos[1] + relative_hex_pos[1]
      local real_hex_y = anchor_hex_pos[2] + relative_hex_pos[2]
      if not hex_to_puzzle_id[real_hex_x] then
        hex_to_puzzle_id[real_hex_x] = {}
      end
      local mark_uuid = hex_to_puzzle_id[real_hex_x][real_hex_y]
      if mark_uuid then
        Log.Error("已保存插件位置存在重叠,插件uuid:", mark_uuid, node_data.uuid)
      end
      hex_to_puzzle_id[real_hex_x][real_hex_y] = node_data.uuid
    end
  end
  self.v_map_node_idx_to_puzzle_item_uuid = {}
  for idx, node_hex_pos in ipairs(self.v_map_hex_pos_list) do
    local puzzle_item_uuid = hex_to_puzzle_id[node_hex_pos[1]] and hex_to_puzzle_id[node_hex_pos[1]][node_hex_pos[2]]
    if puzzle_item_uuid then
      self.v_map_node_idx_to_puzzle_item_uuid[idx] = puzzle_item_uuid
    end
  end
end

function ui:refresh_map_nodes(msg)
  if msg and msg.mm_x ~= self.v_buddy_id then
    return
  end
  self:refresh_puzzle_red()
  self:refresh()
end

return ui
