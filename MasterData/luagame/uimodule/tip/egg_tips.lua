local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:on_click_BtnClose()
  self:ui_hide()
end

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:on_click_BtnClose()
  end)
end

function ui:ui_on_show(egg_id)
  self.v_uicompents.ScrollView_rect:ResetContentPosition()
  self:refresh_view(egg_id)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh_view(egg_id)
  local cfg = ShareRes.get_egg_cfg(egg_id)
  if not cfg then
    Log.Error("获取彩蛋配置失败，彩蛋ID: ", egg_id)
    return
  end
  self.v_uicompents.Name_txt.text = cfg.Name
  self.v_uicompents.Desc_txt.text = cfg.Desc
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, cfg.Icon, function()
    Util.change_component_alpha2(self.v_uicompents.Icon_img, 1)
  end)
end

return ui
