local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local Char_Helper = require("uimodule.character.char_helper")
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")

function ui:ui_finish_load()
  self.v_object:SetActive(true)
  self.v_toggle = Util.get_toggle(nil, self.v_object)
  self:set_toggle_listener(self.v_toggle, function(is_on)
    if is_on then
      self.v_parent_ui:set_select_buddy_id(self.v_buddy_id)
    end
  end)
  self:set_button("BtnDetaile", function()
    self:on_click_jump()
  end)
end

function ui:on_click_jump()
  local choose_config, curr_count, max_count, select_buddy_id, group_id, pool_id = self.v_parent_ui:get_cache_data()
  
  local function show_cb()
    self.v_parent_ui:ui_hide()
  end
  
  local function return_cb()
    UIMgr:get_ui("uidrawcard_choose_award"):ui_show(choose_config, curr_count, max_count, select_buddy_id, group_id, pool_id)
  end
  
  Player_Hero_Helper.build_fake_buddy(self.v_buddy_id)
  UIMgr:get_ui("player_hero"):ui_show(nil, show_cb, return_cb)
end

function ui:set_data(buddy_id, delay)
  self.v_buddy_id = buddy_id
  self.v_buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  self:refresh_select()
  self:refresh_quality_icon()
  self:refresh_char_icon()
  self:refresh_name()
  self:refresh_element()
  self:refresh_job()
  self:refresh_own()
  self:clear_timer()
  local anim = self.v_uicompents.Ani_CharTem_In_pd
  anim:Stop()
  anim.time = 0
  anim:Evaluate()
  if 0 == delay then
    anim:Play()
  else
    self.v_anim_delay_timer = Timer:add_timer("draw_card_award_" .. self.v_buddy_id, delay, function()
      anim:Play()
    end)
  end
end

function ui:refresh_select()
  local selected = self.v_parent_ui:get_select_buddy_id() == self.v_buddy_id
  self.v_uiobjects.Select:SetActiveEx(selected)
end

function ui:refresh_quality_icon()
  local char_quality_icon_path = Char_Helper.get_char_select_quality_icon(self.v_buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.Quality_Icon_img, char_quality_icon_path)
  Char_Helper.set_buddy_quality_star(self.v_uiobjects, nil, self.v_buddy_id)
end

function ui:refresh_char_icon()
  local icon_path = UtilUI.get_hero_images(self.v_buddy_id, 3)
  ResMgr:load_set_icon(self.v_uicompents.Char_icon_img, icon_path, nil, true, self)
end

function ui:refresh_name()
  self.v_uicompents.CharName_txt.text = self.v_buddy_cfg.Name
end

function ui:refresh_element()
  local element_icon_path = Char_Helper.get_char_element_icon(self.v_buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.EleIcon_img, element_icon_path)
end

function ui:refresh_job()
  local char_job_icon = Char_Helper.get_char_job_icon(self.v_buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.JobIcon_img, char_job_icon)
end

function ui:refresh_own()
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  self.v_uiobjects.Own:SetActive(nil ~= buddy_info)
  if nil ~= buddy_info then
    local lv = buddy_info.advance - 1
    self.v_uicompents.Own_txt.text = Util.format_str(0 == lv and "已拥有" or "潜能{1}", Config.NUM_2_ROMAN[lv])
  end
end

function ui:ui_on_hide()
  self:clear_timer()
end

function ui:clear_timer()
  if self.v_anim_delay_timer then
    Timer:remove_timer(self.v_anim_delay_timer)
    self.v_anim_delay_timer = nil
  end
end

return ui
