local Base = require("ui.widget.widget_base")
local M = Util.create_child_mt(Base)
local Toggle = require("ui.widget.widget_toggle_tab")
local ANI_VERTICAL = "RightArrowVer"
local ANI_HORI = "RightArrowHori"

function M:_init(ui)
  Base._init(self)
  self.v_ui = ui
  self.v_child_arr = {}
end

function M:init_folder(parent_obj, child_obj_arr, parent_click_cb, child_click_cb, parent_click_data, child_click_arr_data, arrow_animator)
  self.v_parent_obj = parent_obj
  self.v_child_arr = child_obj_arr
  self.v_parent_click_data = parent_click_data
  self.v_child_arr_data = child_click_arr_data
  self.v_parent_click_cb = parent_click_cb
  self.v_child_click_cb = child_click_cb
  Util.set_click(nil, parent_obj, self, function()
    Util.apply_callback(self.v_parent_click_cb, self.v_parent_click_data)
  end)
  self.v_use_arrow_ani = false
  if arrow_animator then
    self.v_arrow_animator = arrow_animator
    self.v_use_arrow_ani = true
  end
  self.v_child_toggle = Toggle:new(self.v_ui)
  self.v_child_toggle:init_by_toggle_objs(self.v_child_arr, function(cur)
    Util.apply_callback(self.v_child_click_cb, self.v_child_arr_data[cur])
  end, 1)
  self.v_is_open = false
  self:set_folder_open(false, -1)
end

function M:is_open()
  return self.v_is_open
end

function M:set_folder_open(is_open, select_child)
  if self.v_use_arrow_ani and self.v_is_open ~= is_open then
    if is_open then
      self.v_arrow_animator:Play(ANI_VERTICAL, -1, 0.0)
    else
      self.v_arrow_animator:Play(ANI_HORI, -1, 0.0)
    end
  end
  self.v_is_open = is_open
  for _, child in pairs(self.v_child_arr) do
    if child and not child:IsNull() then
      child:SetActive(self.v_is_open)
    end
  end
  if select_child then
    self.v_child_toggle:set_toggle_by_index(select_child)
  end
end

function M:dispose()
  if self.v_child_toggle then
    self.v_child_toggle:dispose()
    self.v_child_toggle = nil
  end
  self.v_arrow_animator = nil
  self.v_child_arr = {}
  self.v_child_arr_data = {}
  self.v_parent_click_cb = nil
  self.v_parent_click_data = nil
  self.v_child_click_cb = nil
end

return M
