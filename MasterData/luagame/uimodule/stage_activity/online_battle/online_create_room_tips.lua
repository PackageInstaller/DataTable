local Base = require("ui.uibase")
local commonDef = require("cs_share.common_define")
local ui = Util.create_child_mt(Base)
local UnityPlayerPrefs = UnityEngine.PlayerPrefs
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_auto_toggle = {
    "AutoToggle",
    BIND_TYPE.TOGGLE
  },
  v_btn_create_breach = {
    "BtnCreateBreach",
    BIND_TYPE.BUTTON
  },
  v_btn_create_cancel = {
    "BtnCreateCancel",
    BIND_TYPE.BUTTON
  },
  v_left_lv_num = {
    "LeftLvNum",
    BIND_TYPE.TEXT
  },
  v_min_lv_num = {
    "MinLVNum",
    BIND_TYPE.TEXT
  },
  v_rgith_lv_num = {
    "RgithLvNum",
    BIND_TYPE.TEXT
  },
  v_room_name = {
    "RoomName",
    BIND_TYPE.TEXT
  },
  v_select = {
    "Select",
    BIND_TYPE.IMAGE
  },
  v_set_lv_num = {
    "SetLVNum",
    BIND_TYPE.TEXT
  }
}
local Act_ID = commonDef.ACTY_TYPE.ONLINE_BATTLE

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnCreateBreach", function()
    self:_onclick_create_room_btn()
  end)
  self:set_button("BtnCreateCancel", function()
    self:ui_hide()
  end)
  self:set_button("Return", function()
    self:ui_hide()
  end)
  local select = 1 == UnityPlayerPrefs.GetInt("auto_match_remmber", 0)
  self:set_toggle_listener(self.v_auto_toggle, function(isOn)
    self:_onclick_auto_toggle(isOn)
  end, select)
  self.v_slider = self:get_slider(nil, self.v_uiobjects.Slider)
  self:set_slider_listener(self.v_slider, function()
    self:_ondrag_slider()
  end)
end

function ui:ui_on_show(point_id, ...)
  self.v_point_id = point_id
  self.v_point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  self.v_online_cfg = ShareRes.create("activity.online_battle", 1)
  self:_refesh_level_range()
end

function ui:ui_on_hide()
end

function ui:_refesh_level_range()
  self.v_left_lv_num.text = self.v_online_cfg.LimitGrade
  self.v_min_lv_num.text = self.v_online_cfg.LimitGrade
  self.v_set_lv_num.text = self.v_online_cfg.LimitGrade
  self.v_slider.minValue = self.v_online_cfg.LimitGrade
  local break_cfg = ShareRes.create("buddy.buddy_level")
  local len = #break_cfg
  local level_cfg = break_cfg[len]
  len = #level_cfg
  local max_level = level_cfg[len].Lv
  self.v_slider.maxValue = max_level
  self.v_rgith_lv_num.text = max_level
  self.v_slider.value = self.v_online_cfg.LimitGrade
end

function ui:_onclick_create_room_btn()
  ActivityMgr:invoke(Act_ID, "request_create_room", self.v_point_id, self.v_slider.minValue, function()
    self:ui_hide()
    UIMgr:try_hide_ui("online_battle_point_detail")
    UIMgr:get_ui("online_team"):ui_show(self.v_point_id)
  end)
end

function ui:_onclick_auto_toggle(isOn)
  local auto = isOn and 1 or 0
  UnityPlayerPrefs.SetInt("auto_match_remmber", auto)
end

function ui:_ondrag_slider()
  self.v_set_lv_num.text = math.floor(self.v_slider.value)
end

return ui
