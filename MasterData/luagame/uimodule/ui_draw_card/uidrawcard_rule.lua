local Base = require("ui.uibase")
local ToggleTab = require("ui.widget.widget_toggle_tab")
local TAB_TYPE = {
  BASE_RULE = 1,
  DROP_RULE = 2,
  HISTORY = 3,
  MAX = 4
}
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_close = {
    "BtnClose",
    BIND_TYPE.BUTTON
  },
  v_page1 = {
    "Page1",
    BIND_TYPE.OBJECT
  },
  v_page2 = {
    "Page2",
    BIND_TYPE.OBJECT
  },
  v_page3 = {
    "Page3",
    BIND_TYPE.OBJECT
  },
  v_right_list = {
    "RightList",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self.v_cur_panel = nil
  self.v_toggles = ToggleTab:new(self)
  self.v_toggles:init_by_obj(self.v_right_list, TAB_TYPE.MAX - 1, function(idx)
    self:_select_tag(idx)
  end, nil, false)
end

function ui:ui_on_show(group_id, pool_id, tab_idx)
  self.v_group_id = group_id
  self.v_pool_id = pool_id
  if self:check_pool_status(true) then
    return
  end
  self.v_toggles:set_toggle_by_index(tab_idx or TAB_TYPE.BASE_RULE)
  if self.v_cur_panel == nil then
    self:_select_tag(tab_idx or TAB_TYPE.BASE_RULE)
  end
  self:bind_auto_mq(Const.MSG_DRAW_GROUP_LIST_UPDATE, self.check_pool_status, self)
end

function ui:check_pool_status(force_hide)
  force_hide = true == force_hide
  local pool_vo = DrawCardMgr:get_pool_vo(self.v_group_id, self.v_pool_id)
  if not pool_vo then
    local confirmCb
    if not force_hide then
      function confirmCb()
        self:ui_hide()
      end
    end
    NextFrameMgr:add_next_update(function()
      if force_hide then
        self:ui_hide()
      end
      Util.show_notify_popup_message(confirmCb, "活动已结束", nil, "确定", nil, nil, true)
    end)
    return true
  end
end

function ui:ui_on_hide()
  if self.v_cur_panel then
    self.v_cur_panel:set_enable(false)
    self.v_cur_panel = nil
  end
end

function ui:_select_tag(idx)
  local target_panel = self:get_panel("page" .. idx)
  if self.v_cur_panel and self.v_cur_panel ~= target_panel then
    self.v_cur_panel:set_enable(false)
  end
  self.v_cur_panel = target_panel
  self.v_cur_panel:set_enable(true)
  self.v_cur_panel:set_data(self.v_group_id, self.v_pool_id)
  self.v_cur_panel_idx = idx
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_group_id, self.v_pool_id, self.v_cur_panel_idx
end

return ui
