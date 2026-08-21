local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local GRAPH_TEMP_KEY = "PUZZLE_FILTER_TIPS_TEMP_KEY_GRAPH"
local ATTR_TEMP_KEY = "PUZZLE_FILTER_TIPS_TEMP_KEY_ATTR"
local ENTRY_TEMP_KEY = "PUZZLE_FILTER_TIPS_TEMP_KEY_ENTRY"

function ui:ui_finish_load()
  self:set_button("BtnBack", function()
    self:ui_hide()
  end)
  self:set_button("Btn_Cancel", function()
    self:ui_hide()
  end)
  self:set_button("Btn_Close", function()
    self:ui_hide()
  end)
  self:set_button("Btn_SetDefault", function()
    self:reset_data()
  end)
  self:set_button("Btn_Sure", function()
    self:try_save_data()
  end)
  self.v_tog_graph_all = self.v_uicompents.SizeAll_tog
  self.v_tog_attr_all = self.v_uicompents.AttrAll_tog
  self.v_tog_entry_all = self.v_uicompents.EffectAll_tog
  self:set_toggle_listener(self.v_tog_graph_all, function(is_on)
    if not self.v_init_done then
      return
    end
    if is_on then
      self:reset_graph()
    elseif self:is_filter_tog_empty(self.v_graph_list) then
      self.v_tog_graph_all.isOn = true
    end
  end)
  self:set_toggle_listener(self.v_tog_attr_all, function(is_on)
    if not self.v_init_done then
      return
    end
    if is_on then
      self:reset_attr()
    elseif self:is_filter_tog_empty(self.v_attr_list) then
      self.v_tog_attr_all.isOn = true
    end
  end)
  self:set_toggle_listener(self.v_tog_entry_all, function(is_on)
    if not self.v_init_done then
      return
    end
    if is_on then
      self:reset_entry()
    elseif self:is_filter_tog_empty(self.v_entry_list) then
      self.v_tog_entry_all.isOn = true
    end
  end)
  self:register_exist_auto_template(GRAPH_TEMP_KEY, self.v_uiobjects.SizeTem, self.v_uiobjects.SizeContent)
  self:register_exist_auto_template(ATTR_TEMP_KEY, self.v_uiobjects.AttrTem, self.v_uiobjects.AttrContent)
  self:register_exist_auto_template(ENTRY_TEMP_KEY, self.v_uiobjects.EffectTem, self.v_uiobjects.EffectContent)
end

function ui:ui_on_show(is_bag, quality)
  self.v_is_bag = is_bag
  self.v_quality_filter = quality
  self:init_graph_list()
  self:init_attr_list()
  self:init_entry_list()
  self.v_init_done = true
  self:refresh_tog_by_mgr_data()
  self.v_uicompents.TagList_rect:SetLocalPositionA(0, 0, 0)
end

function ui:init_graph_list()
  self.v_graph_list = {}
  self:give_back_auto_cache(GRAPH_TEMP_KEY)
  for idx, graph_cfg in ipairs(ShareRes.get_buddy_puzzle_graph_show_list()) do
    local item = self:get_auto_cache(GRAPH_TEMP_KEY)
    local tog = Util.get_toggle(nil, item)
    local icon1 = Util.get_image("Icon", item)
    local icon2 = Util.get_image("Checkmark/Icon", item)
    ResMgr:load_set_icon(icon1, graph_cfg.SmallIcon, nil, true)
    ResMgr:load_set_icon(icon2, graph_cfg.SmallIcon, nil, true)
    self.v_graph_list[idx] = {
      id = graph_cfg.GraphId,
      tog = tog
    }
    self:set_toggle_listener(tog, function(is_on)
      if is_on and self.v_tog_graph_all.isOn then
        self.v_tog_graph_all.isOn = false
      end
    end)
    tog.isOn = false
  end
end

function ui:init_attr_list()
  self.v_attr_list = {}
  self:give_back_auto_cache(ATTR_TEMP_KEY)
  for idx, attr_show_cfg in ipairs(ShareRes.get_buddy_puzzle_attr_show_list()) do
    local attr_id = attr_show_cfg.AttrId
    local item = self:get_auto_cache(ATTR_TEMP_KEY)
    local txt = Util.get_text("Label", item)
    local txt2 = Util.get_text("Checkmark/Label", item)
    local tog = Util.get_toggle(nil, item)
    tog.isOn = false
    local name = ShareRes.get_attr_name(attr_id)
    txt.text = name
    txt2.text = name
    self.v_attr_list[idx] = {id = attr_id, tog = tog}
    self:set_toggle_listener(tog, function(is_on)
      if is_on then
        if self.v_tog_attr_all.isOn then
          self.v_tog_attr_all.isOn = false
        end
        local count = 0
        for _idx, _data in ipairs(self.v_attr_list) do
          if idx ~= _idx and _data.tog.isOn then
            count = count + 1
          end
          if count >= 3 then
            tog.isOn = false
            return
          end
        end
      end
    end)
  end
end

function ui:init_entry_list()
  self.v_entry_list = {}
  self:give_back_auto_cache(ENTRY_TEMP_KEY)
  for idx, entry_id in ipairs(ShareRes.get_buddy_puzzle_entry_id_list()) do
    local item = self:get_auto_cache(ENTRY_TEMP_KEY)
    local txt = Util.get_text("Label", item)
    local txt2 = Util.get_text("Checkmark/Label", item)
    local tog = Util.get_toggle(nil, item)
    tog.isOn = false
    local entry_cfg = ShareRes.create("buddy.buddy_puzzle_entry")[entry_id]
    local name = entry_cfg[next(entry_cfg)].Name
    txt.text = name
    txt2.text = name
    self.v_entry_list[idx] = {id = entry_id, tog = tog}
    self:set_toggle_listener(tog, function(is_on)
      if is_on and self.v_tog_entry_all.isOn then
        self.v_tog_entry_all.isOn = false
      end
    end)
  end
end

function ui:refresh_tog_by_mgr_data()
  if self.v_is_bag then
    self.v_new_filter_graph = PuzzleMgr.graph_map_filter_bag
  else
    self.v_new_filter_graph = PuzzleMgr.graph_map_filter
  end
  if not self.v_new_filter_graph then
    self.v_tog_graph_all.isOn = false
    self.v_tog_graph_all.isOn = true
  else
    for _, data in ipairs(self.v_graph_list) do
      local is_on = false
      if self.v_new_filter_graph[data.id] then
        is_on = true
      end
      data.tog.isOn = is_on
    end
  end
  if self.v_is_bag then
    self.v_new_filter_attr = PuzzleMgr.attr_map_filter_bag
  else
    self.v_new_filter_attr = PuzzleMgr.attr_map_filter
  end
  if not self.v_new_filter_attr then
    self.v_tog_attr_all.isOn = false
    self.v_tog_attr_all.isOn = true
  else
    for _, data in ipairs(self.v_attr_list) do
      local is_on = false
      if self.v_new_filter_attr[data.id] then
        is_on = true
      end
      data.tog.isOn = is_on
    end
  end
  if self.v_is_bag then
    self.v_new_filter_entry = PuzzleMgr.entry_map_filter_bag
  else
    self.v_new_filter_entry = PuzzleMgr.entry_map_filter
  end
  if not self.v_new_filter_entry then
    self.v_tog_entry_all.isOn = false
    self.v_tog_entry_all.isOn = true
  else
    for _, data in ipairs(self.v_entry_list) do
      local is_on = false
      if self.v_new_filter_entry[data.id] then
        is_on = true
      end
      data.tog.isOn = is_on
    end
  end
end

function ui:reset_data()
  self.v_tog_graph_all.isOn = false
  self.v_tog_graph_all.isOn = true
  self.v_tog_attr_all.isOn = false
  self.v_tog_attr_all.isOn = true
  self.v_tog_entry_all.isOn = false
  self.v_tog_entry_all.isOn = true
end

function ui:reset_graph()
  self.v_new_filter_graph = nil
  for _, data in ipairs(self.v_graph_list) do
    data.tog.isOn = false
  end
end

function ui:reset_attr()
  self.v_new_filter_attr = nil
  for _, data in ipairs(self.v_attr_list) do
    data.tog.isOn = false
  end
end

function ui:reset_entry()
  self.v_new_filter_entry = nil
  for _, data in ipairs(self.v_entry_list) do
    data.tog.isOn = false
  end
end

function ui:is_filter_tog_empty(tog_list)
  for _, data in ipairs(tog_list) do
    if data.tog.isOn then
      return false
    end
  end
  return true
end

function ui:load_data()
  self.v_new_filter_graph = nil
  for _, data in ipairs(self.v_graph_list) do
    if data.tog.isOn then
      if not self.v_new_filter_graph then
        self.v_new_filter_graph = {}
      end
      self.v_new_filter_graph[data.id] = true
    end
  end
  self.v_new_filter_attr = nil
  for _, data in ipairs(self.v_attr_list) do
    if data.tog.isOn then
      if not self.v_new_filter_attr then
        self.v_new_filter_attr = {}
      end
      self.v_new_filter_attr[data.id] = true
    end
  end
  self.v_new_filter_entry = nil
  for _, data in ipairs(self.v_entry_list) do
    if data.tog.isOn then
      if not self.v_new_filter_entry then
        self.v_new_filter_entry = {}
      end
      self.v_new_filter_entry[data.id] = true
    end
  end
end

function ui:try_save_data()
  self:load_data()
  if not PuzzleMgr:check_filter_suc(self.v_quality_filter, self.v_new_filter_graph, self.v_new_filter_attr, self.v_new_filter_entry) then
    Util.show_message_tip(2259)
    return
  end
  if self.v_is_bag then
    PuzzleMgr.graph_map_filter_bag = self.v_new_filter_graph
    PuzzleMgr.attr_map_filter_bag = self.v_new_filter_attr
    PuzzleMgr.entry_map_filter_bag = self.v_new_filter_entry
  else
    PuzzleMgr.graph_map_filter = self.v_new_filter_graph
    PuzzleMgr.attr_map_filter = self.v_new_filter_attr
    PuzzleMgr.entry_map_filter = self.v_new_filter_entry
  end
  MsgGame:mq_publish2(Const.MSG_ON_PUZZLE_FILTER_UPDATE)
  self:ui_hide()
end

function ui:ui_on_hide()
  self.v_init_done = nil
end

return ui
