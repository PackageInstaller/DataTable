local Base = require("ui.widget.widget_base")
local M = Util.create_child_mt(Base)

function M:_init(ud, key_list, toggle_list, panel_name_list, default_key, click_callback, keep_style)
  assert(ud)
  assert(key_list)
  assert(toggle_list)
  assert(#key_list == #toggle_list)
  assert(not panel_name_list or #key_list == #panel_name_list)
  self.v_ud = ud
  self.v_key_list = key_list
  self.v_toggle_list = toggle_list
  self.v_panel_name_list = panel_name_list
  self.v_click_callback = click_callback
  self.v_keep_stype = true == keep_style
  self.v_panel_list = {}
  self.v_key_to_idx = {}
  for idx, key in ipairs(key_list) do
    self.v_key_to_idx[key] = idx
  end
  self:_register_ui_event_listener()
  if default_key then
    self.v_last_key = default_key
  else
    self.v_last_key = self.v_key_list[1]
  end
  self.v_last_idx = self.v_key_to_idx[self.v_last_key]
  self.v_toggle_list[self.v_last_idx].isOn = true
end

function M:on_show()
  self:_on_click_tab(self.v_last_idx, self.v_last_key, true)
end

function M:on_hide()
  self:_on_click_tab(self.v_last_idx, self.v_last_key, false)
end

function M:get_key_idx(key)
  assert(self.v_key_to_idx[key], "key no exist: " .. key)
  local idx = self.v_key_to_idx[key]
  return idx
end

function M:get_cur_key()
  return self.v_last_key
end

function M:click_tab(key)
  assert(key, "key is nil")
  local idx = self:get_key_idx(key)
  self.v_toggle_list[idx].isOn = true
end

function M:_register_ui_event_listener()
  for idx, key in ipairs(self.v_key_list) do
    local toggle = self.v_toggle_list[idx]
    if not self.v_keep_stype then
      self.v_ud:get_text("Text", toggle.gameObject).color = Util.get_unity_color_by_hex(tonumber("938564", 16))
      self.v_ud:get_text("Text", toggle.gameObject).fontSize = 35
    end
    toggle.isOn = false
    self.v_ud:set_toggle_listener(toggle, self.v_ud:get_object(), function(is_on)
      self:_on_click_tab(idx, key, is_on)
    end)
  end
end

function M:_on_click_tab(idx, key, is_show)
  local toggle = self.v_toggle_list[idx]
  if not self.v_keep_stype then
    if is_show then
      self.v_ud:get_text("Text", toggle.gameObject).color = Util.get_unity_color_by_hex(tonumber("FFFAE6", 16))
      self.v_ud:get_text("Text", toggle.gameObject).fontSize = 40
    else
      self.v_ud:get_text("Text", toggle.gameObject).color = Util.get_unity_color_by_hex(tonumber("938564", 16))
      self.v_ud:get_text("Text", toggle.gameObject).fontSize = 35
    end
  end
  if self.v_panel_name_list then
    local panel = self.v_ud:get_panel(self.v_panel_name_list[idx])
    panel:set_enable(is_show, key)
  end
  if self.v_click_callback then
    self.v_click_callback(self.v_ud, idx, key, is_show)
  end
  self.v_last_idx = idx
  self.v_last_key = key
end

return M
