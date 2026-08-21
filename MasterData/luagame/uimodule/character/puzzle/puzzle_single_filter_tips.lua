local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ATTR_TEMP_KEY = "PUZZLE_SINGLE_FILTER_TIPS_TEMP_KEY_ATTR"
local ENTRY_TEMP_KEY = "PUZZLE_SINGLE_FILTER_TIPS_TEMP_KEY_ENTRY"
local ICON_NORMAL_COLOR = Util.get_unity_color_by_hex(tonumber("292929", 16))
local ICON_ACTIVE_COLOR = Util.get_unity_color_by_hex(tonumber("EFC66E", 16))
local TXT_NORMAL_COLOR = Util.get_unity_color_by_hex(tonumber("484243", 16))
local TXT_ACTIVE_COLOR = Util.get_unity_color_by_hex(tonumber("F5EDE2", 16))
local NUM_NORMAL_COLOR = Util.get_unity_color_by_hex(tonumber("68645f", 16))
local NUM_ACTIVE_COLOR = Util.get_unity_color_by_hex(tonumber("B19F89", 16))

function ui:ui_finish_load()
  self:set_button("BgClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnReset", function()
    self:reset_data()
  end)
  self:set_button("BtnConfirm", function()
    self:try_save_data()
  end)
  self:register_exist_auto_template(ATTR_TEMP_KEY, self.v_uiobjects.AttrTem, self.v_uiobjects.AttrContent)
  self:register_exist_auto_template(ENTRY_TEMP_KEY, self.v_uiobjects.EffectTem, self.v_uiobjects.EffectContent)
end

function ui:ui_on_show(is_entry)
  self.v_is_entry = is_entry
  self.v_uicompents.AttrContent_rect:SetLocalPositionA(0, 0, 0)
  self.v_uicompents.EffectContent_rect:SetLocalPositionA(0, 0, 0)
  self.v_uiobjects.EffectObj:SetActive(true == is_entry)
  self.v_uiobjects.AttrObj:SetActive(not is_entry)
  if is_entry then
    self:init_entry_list()
  else
    self:init_attr_list()
  end
  self:refresh_tog_by_mgr_data()
end

function ui:init_attr_list()
  self.v_attr_list = {}
  self:give_back_auto_cache(ATTR_TEMP_KEY)
  for idx, attr_show_cfg in ipairs(ShareRes.get_buddy_puzzle_attr_show_list()) do
    local attr_id = attr_show_cfg.AttrId
    local item = self:get_auto_cache(ATTR_TEMP_KEY)
    local txt = Util.get_text("Name", item)
    local tog = Util.get_toggle(nil, item)
    tog.isOn = false
    local name = ShareRes.get_attr_name(attr_id)
    txt.text = name
    self.v_attr_list[idx] = {
      id = attr_id,
      tog = tog,
      txt = txt
    }
    self:set_attr_item_color(txt, false)
    self:set_toggle_listener(tog, function(is_on)
      if is_on then
        local count = 0
        for _idx, _data in ipairs(self.v_attr_list) do
          if idx ~= _idx and _data.tog.isOn then
            count = count + 1
          end
        end
      end
      self:set_attr_item_color(txt, is_on)
    end)
    local icon = Util.get_image("Icon", item)
    local icon_name = ShareRes.get_attr_icon(attr_id)
    if icon_name then
      Util.load_attr_icon(icon, icon_name)
    end
  end
end

function ui:init_entry_list()
  self.v_entry_list = {}
  self:give_back_auto_cache(ENTRY_TEMP_KEY)
  do
    local item = self:get_auto_cache(ENTRY_TEMP_KEY)
    local txt = Util.get_text("Name", item)
    local num1 = Util.get_text("Amount", item)
    local num2 = Util.get_text("AmountNum", item)
    local tog = Util.get_toggle(nil, item)
    tog.isOn = false
    txt.text = Util.format_str("无古痕效果")
    num2.text = PuzzleMgr:get_own_puzzle_num_by_entry(nil)
    local t = {
      id = 0,
      tog = tog,
      txt = txt,
      num1 = num1,
      num2 = num2
    }
    self.v_entry_list[1] = t
    self:set_entry_item_color(t, false)
    self:set_toggle_listener(tog, function(is_on)
      self:set_entry_item_color(t, is_on)
    end)
    Util.get_child_gameobj("SizeIcon", item):SetActiveEx(false)
    Util.get_child_gameobj("NoEffect", item):SetActiveEx(true)
  end
  for _, entry_id in ipairs(ShareRes.get_buddy_puzzle_entry_id_list()) do
    local item = self:get_auto_cache(ENTRY_TEMP_KEY)
    local icon = Util.get_image("SizeIcon", item)
    local txt = Util.get_text("Name", item)
    local num1 = Util.get_text("Amount", item)
    local num2 = Util.get_text("AmountNum", item)
    local tog = Util.get_toggle(nil, item)
    tog.isOn = false
    local entry_cfg = ShareRes.create("buddy.buddy_puzzle_entry")[entry_id]
    local single_cfg = entry_cfg[next(entry_cfg)]
    local graph_cfg = ShareRes.get_buddy_puzzle_graph_show_cfg(single_cfg.GraphID)
    txt.text = single_cfg.Name
    num2.text = PuzzleMgr:get_own_puzzle_num_by_entry(entry_id)
    local idx = #self.v_entry_list + 1
    local t = {
      id = entry_id,
      tog = tog,
      txt = txt,
      num1 = num1,
      num2 = num2,
      icon = icon
    }
    self.v_entry_list[idx] = t
    self:set_entry_item_color(t, false)
    self:set_toggle_listener(tog, function(is_on)
      self:set_entry_item_color(t, is_on)
    end)
    local icon_name = graph_cfg.SmallIcon
    if icon_name then
      ResMgr:load_set_icon(icon, icon_name, nil, true)
    end
    Util.get_child_gameobj("SizeIcon", item):SetActiveEx(true)
    Util.get_child_gameobj("NoEffect", item):SetActiveEx(false)
  end
end

function ui:set_attr_item_color(txt, active)
  txt.color = active and TXT_ACTIVE_COLOR or TXT_NORMAL_COLOR
end

function ui:set_entry_item_color(item, active)
  if item.icon then
    item.icon.color = active and ICON_ACTIVE_COLOR or ICON_NORMAL_COLOR
  end
  item.txt.color = active and TXT_ACTIVE_COLOR or TXT_NORMAL_COLOR
  item.num1.color = active and NUM_ACTIVE_COLOR or NUM_NORMAL_COLOR
  item.num2.color = active and NUM_ACTIVE_COLOR or NUM_NORMAL_COLOR
end

function ui:refresh_tog_by_mgr_data()
  if self.v_is_entry then
    self.v_new_filter_entry = PuzzleMgr:get_view_filter(PuzzleMgr.FilterTypeEnum.Entry)
    for _, data in ipairs(self.v_entry_list) do
      local is_on = false
      if self.v_new_filter_entry and self.v_new_filter_entry[data.id] then
        is_on = true
      end
      data.tog.isOn = is_on
    end
  else
    self.v_new_filter_attr = PuzzleMgr:get_view_filter(PuzzleMgr.FilterTypeEnum.Attr)
    for _, data in ipairs(self.v_attr_list) do
      local is_on = false
      if self.v_new_filter_attr and self.v_new_filter_attr[data.id] then
        is_on = true
      end
      data.tog.isOn = is_on
    end
  end
end

function ui:reset_data()
  if self.v_is_entry then
    self:reset_entry()
  else
    self:reset_attr()
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

function ui:load_data()
  if self.v_is_entry then
    self.v_new_filter_entry = nil
    for _, data in ipairs(self.v_entry_list) do
      if data.tog.isOn then
        if not self.v_new_filter_entry then
          self.v_new_filter_entry = {}
        end
        self.v_new_filter_entry[data.id] = true
      end
    end
  else
    self.v_new_filter_attr = nil
    for _, data in ipairs(self.v_attr_list) do
      if data.tog.isOn then
        if not self.v_new_filter_attr then
          self.v_new_filter_attr = {}
        end
        self.v_new_filter_attr[data.id] = true
      end
    end
  end
end

function ui:try_save_data()
  self:load_data()
  if self.v_is_entry then
    PuzzleMgr:set_view_filter_ex(PuzzleMgr.FilterTypeEnum.Entry, self.v_new_filter_entry)
  else
    PuzzleMgr:set_view_filter_ex(PuzzleMgr.FilterTypeEnum.Attr, self.v_new_filter_attr)
  end
  self:ui_hide()
end

function ui:ui_on_hide()
end

return ui
