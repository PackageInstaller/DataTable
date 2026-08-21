local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local ENDLESS_SYS_ID = 8

function ui:ui_finish_load()
  self:set_button("BtnStart", function()
    self:on_click_start_btn()
  end)
  self.v_red_point = Util.get_child_gameobj("Redpoint", self.v_uiobjects.BtnStart)
end

function ui:on_click_start_btn()
  if SysOpenMgr:get_sys_is_open(ENDLESS_SYS_ID) then
    ChapterEndlessMgr:refresh_endless_enter_finish()
    UIMgr:get_ui("endless_main"):ui_show()
  end
end

function ui:ui_on_show()
  self:refresh_score()
end

function ui:refresh_score()
  local is_week_infi_open = ChapterEndlessMgr:is_week_infinite_open()
  self.v_uiobjects.Score:SetActive(is_week_infi_open)
  if is_week_infi_open then
    local score = ChapterEndlessMgr:get_endless_total_score()
    self.v_uicompents.ScoreNum_txt.text = score
  end
end

function ui:get_btn_start_red()
  return self.v_red_point
end

return ui
