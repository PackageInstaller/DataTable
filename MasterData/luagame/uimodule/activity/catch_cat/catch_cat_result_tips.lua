local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:on_click_BtnNext()
  if self.v_lock_str then
    Util.show_message_tip(self.v_lock_str)
    return
  end
  local catch_cat_battle_panel = UIMgr:try_get_visible_ui("catch_cat_battle_panel")
  if catch_cat_battle_panel then
    catch_cat_battle_panel:start_new(self.v_next_stage_cfg)
  end
  self:ui_hide()
end

function ui:on_click_BtnQuit()
  local catch_cat_battle_panel = UIMgr:try_get_visible_ui("catch_cat_battle_panel")
  if catch_cat_battle_panel then
    catch_cat_battle_panel:ui_hide()
  end
  self:ui_hide()
end

function ui:on_click_BtnReStart()
  local catch_cat_battle_panel = UIMgr:try_get_visible_ui("catch_cat_battle_panel")
  if catch_cat_battle_panel then
    catch_cat_battle_panel:start_new(self.v_stage_cfg)
  end
  self:ui_hide()
end

function ui:ui_finish_load()
  self:set_button("BtnNext", function()
    self:on_click_BtnNext()
  end)
  self:set_button("BtnQuit", function()
    self:on_click_BtnQuit()
  end)
  self:set_button("BtnReStart", function()
    self:on_click_BtnReStart()
  end)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:ui_on_show(stage_cfg, is_success, is_gm_show)
  self.v_stage_cfg = stage_cfg
  self.v_is_success = true == is_success
  self.v_is_gm_show = is_gm_show
  if self.v_is_success then
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.catch_cat_success_UI_SOUND)
  else
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.catch_cat_fail_UI_SOUND)
  end
  self:refresh_view()
end

function ui:refresh_view()
  self.v_uiobjects.Success:SetActive(self.v_is_success)
  self.v_uiobjects.Fail:SetActive(not self.v_is_success)
  self.v_uiobjects.BtnNext:SetActive(self.v_is_success and not self.v_is_gm_show)
  self.v_uiobjects.BtnReStart:SetActive(not self.v_is_success or self.v_is_gm_show)
  self.v_uicompents.StageNum_txt.text = self.v_stage_cfg.NumTxt
  self.v_uicompents.StageName_txt.text = self.v_stage_cfg.Name
  if not self.v_is_success or self.v_is_gm_show then
    return
  end
  local next_stage_cfg = CatchCatMgr:get_next_stage_cfg(self.v_stage_cfg)
  self.v_next_stage_cfg = next_stage_cfg
  if not next_stage_cfg then
    self.v_uiobjects.BtnNext:SetActive(false)
    return
  end
  local next_stage_open_time = next_stage_cfg.OpenTime and Date.get_time_stamp_by_scheme_id(next_stage_cfg.OpenTime) or 0
  if next_stage_open_time > Date:server_time() then
    self.v_lock_str = os.date("%m.%d后解锁", next_stage_open_time)
    self.v_uicompents.NextStageUnlock_txt.text = self.v_lock_str
    self.v_uiobjects.NextStageUnlock:SetActive(true)
  else
    self.v_lock_str = nil
    self.v_uiobjects.NextStageUnlock:SetActive(false)
  end
  Util.apply_grey_ex(self.v_uiobjects.BtnNext, self.v_lock_str ~= nil)
end

return ui
