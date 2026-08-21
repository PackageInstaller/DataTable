local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local STATE_TO_COLOR = {
  [true] = "FFFFFF",
  [false] = "001532"
}

function ui:on_click_upgrade()
  BarbecueGameMgr:send_upgrade(self.v_id, function(ok)
    self.v_parent_ui:refresh_view()
    if ok then
      Util.show_message_tip("升级成功")
    end
  end)
end

function ui:ui_finish_load()
  self:set_button("UpgradeBtn", function()
    self:on_click_upgrade()
  end)
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(data)
  self.v_id = data.id
  local cfg = data.cfg
  local own_num = BagMgr:get_item_num(cfg.CostItem)
  self.v_uicompents.CtContent_txt.text = cfg.Desc
  self.v_uicompents.Now_txt.text = data.is_finish and cfg.CostCount or own_num
  self.v_uicompents.Need_txt.text = cfg.CostCount
  self.v_uiobjects.UpgradeBtn:SetActiveEx(not data.is_finish and own_num >= cfg.CostCount)
  self.v_uiobjects.NoFinish:SetActiveEx(not data.is_finish and own_num < cfg.CostCount)
  self.v_uiobjects.FinishText:SetActiveEx(data.is_finish)
  self.v_uiobjects.BgComplete:SetActiveEx(data.is_finish)
  local color = STATE_TO_COLOR[data.is_finish]
  Util.set_color(self.v_uicompents.CtContent_txt, color)
  Util.set_color(self.v_uicompents.Now_txt, color)
  Util.set_color(self.v_uicompents.split_txt, color)
  Util.set_color(self.v_uicompents.Need_txt, color)
  self.v_uicompents.CtTaskDone_img.fillAmount = data.is_finish and 1 or own_num / cfg.CostCount
  local icon_path = UtilUI.get_item_images(cfg.CostItem)
  ResMgr:load_set_icon(self.v_uicompents.UpgradeItem_img, icon_path)
end

return ui
