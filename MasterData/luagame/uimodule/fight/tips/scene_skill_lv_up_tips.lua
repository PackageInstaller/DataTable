local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("Mask", function()
    if self.v_click_lock or self.v_hide_timer then
      return
    end
    self.v_uicompents.OutPd_pd:Stop()
    self.v_uicompents.OutPd_pd:Play()
    self.v_hide_timer = Timer:add_timer(nil, self.v_uicompents.OutPd_pd.duration, function()
      self:ui_hide()
    end)
  end)
  self:set_playable_stopped_action(self.v_uicompents.Ani_UICRStageSkillLvUp_pd, function()
    self.v_click_lock = false
  end)
end

function ui:ui_on_show(upgrade_data)
  self.v_click_lock = true
  local skill_id = upgrade_data.id
  local skill_cfg = ShareRes.get_scene_skill_cfg(skill_id)
  local skill_level_cfg = ShareRes.create("battle.scene_skill_level")[skill_id]
  local genres_id = skill_level_cfg[upgrade_data.lv].Param[1]
  local genres_cfg = ShareRes.get_genres_cfg(genres_id)
  ResMgr:load_set_icon(self.v_uicompents.SectIcon_img, genres_cfg.IconPath, nil, true, self)
  self.v_uicompents.SkillName_txt.text = skill_cfg.Name
  self.v_uicompents.SkillDesc_txt.text = skill_level_cfg[1].Desc
  self.v_uicompents.LvUpSkillName_txt.text = skill_level_cfg[upgrade_data.lv].Name
  self.v_uicompents.LvUpSkillDesc_txt.text = skill_level_cfg[upgrade_data.lv].Desc
  Global.sound_mgr:play_common_sound("Sound_skill_levelup")
end

function ui:ui_on_hide()
  self.v_click_lock = false
  if self.v_hide_timer then
    Timer:remove_timer(self.v_hide_timer)
    self.v_hide_timer = nil
  end
end

function ui:ui_on_destroy()
end

return ui
