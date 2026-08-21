local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local TEMPLATE_KEY_SIZE_SCREEN = "PUZZLE_FILTER_VIEW_TEMPLATE_KEY_SIZE_SCREEN"
local TEMPLATE_KEY_ENTRY_SCREEN = "PUZZLE_FILTER_VIEW_TEMPLATE_KEY_ENTRY_SCREEN"
local TEMPLATE_KEY_ATTR_SCREEN = "PUZZLE_FILTER_VIEW_TEMPLATE_KEY_ATTR_SCREEN"

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:set_enable(false)
  end)
  self:set_button("BtnReset", function()
    PuzzleMgr:reset_view_filter()
    self:refresh_by_data()
  end)
  self:set_button("BtnConfirm", function()
    self:set_enable(false)
  end)
  self:set_button("EffectScreen", function()
    UIMgr:get_ui("puzzle_single_filter_tips"):ui_show(true)
  end)
  self:set_button("AttrScreen", function()
    UIMgr:get_ui("puzzle_single_filter_tips"):ui_show(false)
  end)
  self:set_toggle("TogSize", function(isOn)
    if isOn then
      PuzzleMgr:set_view_filter_tab_type(PuzzleMgr.TabEnum.Graph)
      self:refresh_page_tab()
    end
  end)
  self:set_toggle("TogEffect", function(isOn)
    if isOn then
      PuzzleMgr:set_view_filter_tab_type(PuzzleMgr.TabEnum.Entry)
      self:refresh_page_tab()
    end
  end)
  self.v_quality_show_list = {}
  for quality = 3, 5 do
    self.v_quality_show_list[#self.v_quality_show_list + 1] = {
      selected_obj = self.v_uiobjects["QualitySelect" .. quality],
      quality = quality
    }
    self:set_button("Quality" .. quality, function()
      PuzzleMgr:set_view_filter(PuzzleMgr.FilterTypeEnum.Quality, quality)
      self:refresh_quality()
    end)
  end
  self:register_exist_auto_template(TEMPLATE_KEY_SIZE_SCREEN, self.v_uiobjects.SizeTem, self.v_uiobjects.Size)
  self:register_exist_auto_template(TEMPLATE_KEY_ENTRY_SCREEN, self.v_uiobjects.EffectTem, self.v_uiobjects.Effect)
  self:register_exist_auto_template(TEMPLATE_KEY_ATTR_SCREEN, self.v_uiobjects.AttrTem, self.v_uiobjects.Attr)
end

function ui:ui_on_show()
  self:init_size_screen_content()
  self:refresh_by_data()
  self:bind_auto_mq(Const.MSG_ON_PUZZLE_VIEW_FILTER_UPDATE_EX, self.on_filter_ex_update, self)
end

function ui:ui_on_hide()
end

function ui:init_size_screen_content()
  self:give_back_auto_cache(TEMPLATE_KEY_SIZE_SCREEN)
  self.v_graph_show_list = {}
  for idx, graph_cfg in ipairs(ShareRes.get_buddy_puzzle_graph_show_list()) do
    local item = self:get_auto_cache(TEMPLATE_KEY_SIZE_SCREEN)
    local btn = Util.get_button(nil, item)
    local icon = Util.get_image("Icon", item)
    local selected_obj = Util.get_child_gameobj("Select", item)
    selected_obj:SetActive(false)
    ResMgr:load_set_icon(icon, graph_cfg.SmallIcon, nil, true)
    self.v_graph_show_list[idx] = {
      selected_obj = selected_obj,
      graph_id = graph_cfg.GraphId,
      icon = icon
    }
    self:set_button_listener(btn, function()
      PuzzleMgr:set_view_filter(PuzzleMgr.FilterTypeEnum.Graph, graph_cfg.GraphId)
      self:refresh_graph()
    end)
  end
end

function ui:refresh_by_data()
  self:refresh_page_tab()
  self:refresh_quality()
  self:refresh_graph()
  self:refresh_entry_selected()
  self:refresh_attr_selected()
end

function ui:on_filter_ex_update(msg)
  if msg.mm_x == PuzzleMgr.FilterTypeEnum.Entry then
    self:refresh_entry_selected()
  else
    self:refresh_attr_selected()
  end
end

function ui:refresh_page_tab()
  local tab_type = PuzzleMgr:get_view_filter_tab_type()
  if tab_type == PuzzleMgr.TabEnum.Graph then
    self.v_uicompents.TogSize_tog.isOn = true
    self:refresh_graph()
  else
    self.v_uicompents.TogEffect_tog.isOn = true
    self:refresh_entry_selected()
  end
  self.v_uiobjects.Size:SetActive(tab_type == PuzzleMgr.TabEnum.Graph)
  self.v_uiobjects.Effect:SetActive(tab_type == PuzzleMgr.TabEnum.Entry)
end

function ui:refresh_quality()
  local filter = PuzzleMgr:get_view_filter(PuzzleMgr.FilterTypeEnum.Quality)
  for _, data in ipairs(self.v_quality_show_list) do
    local active = filter and filter[data.quality] == true
    data.selected_obj:SetActiveEx(active)
  end
end

function ui:refresh_graph()
  local tab_type = PuzzleMgr:get_view_filter_tab_type()
  if tab_type ~= PuzzleMgr.TabEnum.Graph then
    return
  end
  local filter = PuzzleMgr:get_view_filter(PuzzleMgr.FilterTypeEnum.Graph)
  for _, data in ipairs(self.v_graph_show_list) do
    local active = filter and filter[data.graph_id]
    data.selected_obj:SetActiveEx(active)
    local color = data.icon.color
    color.a = active and 1 or 0.3
    data.icon.color = color
  end
end

function ui:refresh_entry_selected()
  local tab_type = PuzzleMgr:get_view_filter_tab_type()
  if tab_type ~= PuzzleMgr.TabEnum.Entry then
    return
  end
  self:give_back_auto_cache(TEMPLATE_KEY_ENTRY_SCREEN)
  local entry_map = PuzzleMgr:get_view_filter(PuzzleMgr.FilterTypeEnum.Entry)
  if not entry_map then
    return
  end
  local entry_list = {}
  for entry_id, _ in pairs(entry_map) do
    local insert_data
    if 0 == entry_id then
      insert_data = {
        entry_id = 0,
        name = Util.format_str("无古痕效果"),
        order = 0
      }
    else
      local entry_cfg = ShareRes.create("buddy.buddy_puzzle_entry")[entry_id]
      local single_cfg = entry_cfg[next(entry_cfg)]
      local graph_cfg = ShareRes.get_buddy_puzzle_graph_show_cfg(single_cfg.GraphID)
      insert_data = {
        entry_id = entry_id,
        name = single_cfg.Name,
        order = graph_cfg.Order,
        icon = graph_cfg.SmallIcon
      }
    end
    entry_list[#entry_list + 1] = insert_data
  end
  table.sort(entry_list, function(a, b)
    if a.order ~= b.order then
      return a.order < b.order
    end
    return a.entry_id < b.entry_id
  end)
  for _, data in ipairs(entry_list) do
    local item = self:get_auto_cache(TEMPLATE_KEY_ENTRY_SCREEN)
    local txt = Util.get_text("EffectDesc", item)
    local icon = Util.get_image("SizeIcon", item)
    local btn = Util.get_button("BtnDel", item)
    txt.text = data.name
    icon.gameObject:SetActive(data.icon ~= nil)
    if data.icon then
      ResMgr:load_set_icon(icon, data.icon, nil, true)
      self:set_button_listener(btn, function()
        item:SetActive(false)
        PuzzleMgr:set_view_filter(PuzzleMgr.FilterTypeEnum.Entry, data.entry_id, true)
      end)
    end
  end
end

function ui:refresh_attr_selected()
  self:give_back_auto_cache(TEMPLATE_KEY_ATTR_SCREEN)
  local attr_map = PuzzleMgr:get_view_filter(PuzzleMgr.FilterTypeEnum.Attr)
  if not attr_map then
    return
  end
  local show_list = ShareRes.get_buddy_puzzle_attr_show_list()
  local attr_list = {}
  for _, cfg in ipairs(show_list) do
    if attr_map[cfg.AttrId] then
      attr_list[#attr_list + 1] = cfg
    end
  end
  for _, cfg in ipairs(attr_list) do
    local item = self:get_auto_cache(TEMPLATE_KEY_ATTR_SCREEN)
    local txt = Util.get_text("Bg/Text", item)
    local btn = Util.get_button("BtnDel", item)
    txt.text = cfg.Desc
    self:set_button_listener(btn, function()
      item:SetActive(false)
      PuzzleMgr:set_view_filter(PuzzleMgr.FilterTypeEnum.Attr, cfg.AttrId, true)
    end)
  end
end

return ui
