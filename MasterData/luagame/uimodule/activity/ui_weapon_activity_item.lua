local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(weapon_group_id, weapon_id, is_center)
  self.v_weapon_id = weapon_id
  local cfg = ShareRes.get_gold_equip_single_group_cfg(weapon_group_id, weapon_id)
  local weapon_cfg = ShareRes.get_equip(weapon_id)
  local path = UtilUI.get_weapon_tex(weapon_cfg.Painting[2])
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, path, nil, true, self)
  local time = Util.is_more_than_zero(cfg.BeginTime) and Date.get_time_stamp_by_scheme_id(cfg.BeginTime)
  self:set_lock(time)
end

function ui:set_weapon_name(name)
  self.v_parent_ui.v_uicompents.WeaponName_txt.text = name
end

function ui:set_special(is_special)
  self.v_parent_ui.v_uiobjects.LimitTips:SetActive(is_special)
end

function ui:set_lock(begin_time)
  local time = begin_time
  local is_unlock = not begin_time or time <= Date.server_time()
  Util.set_color(self.v_uicompents.Icon_img, is_unlock and "FFFFFF" or "000000")
end

return ui
