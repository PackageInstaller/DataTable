local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ModelRtView = require("ui.model_rt_view.signboard_rt_view_new")
local MODEL_CONFIG = require("ui.model_rt_view.model_config")
local UnityShader = UnityEngine.Shader
local MAIN_SCENE_SHOW_ID = UnityShader.PropertyToID("_MAIN_SCENE_SHOW")
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local CharacterRotatePage = ShareRes.get_comm_string_value("CharacterRotatePage")
local PAGE_VIEW_TYPE = {
  [1] = 2,
  [2] = 3,
  [3] = 4,
  [4] = 5
}
local MODEL_PARAM = MODEL_CONFIG.UI_CHARACTER_MODEL_PARAM

function ui.refresh_character_attr(attr, buddy_id)
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  if not buddy_info then
    return
  end
  local res_attr_id = ShareRes.get_buddy_res_attr_id(buddy_info.id)
  local res_cfg = ShareRes.get_buddy_attr_cfg(res_attr_id)
  local res_name = res_cfg.Name
  local attrs = buddy_info.attrs
  local ui_comment = attr.v_uicompents
  for index = 1, 2 do
    local txt = ui_comment["CharMpName" .. index .. "_txt"]
    if txt then
      local attr_name = ShareRes.get_buddy_attr_name(res_attr_id)
      txt.text = attr_name
    end
    local img_icon = ui_comment["MpIcon" .. index .. "_img"]
    if img_icon then
      Util.load_attr_icon(img_icon, res_cfg.IconName)
    end
  end
  ui_comment.HpName_txt.text = ShareRes.equip_attr_str("hp")
  ui_comment.AtkName_txt.text = ShareRes.equip_attr_str("attack")
  attr.v_hp.text = attrs.hp
  attr.v_mp.text = attrs[res_name]
  attr.v_attack.text = attrs.attack
  attr.v_spec_attack.text = attrs.penetrate
  attr.v_def.text = attrs.defense
  local exp, max_exp = CharacterMgr:get_character_exp_info(buddy_info.id)
  local level = buddy_info.lv
  local buddy_next_break_cfg = ShareRes.create("buddy.buddy_break", buddy_info.id)[buddy_info.break_lv + 1]
  if not buddy_next_break_cfg then
    local max_level = ShareRes.get_buddy_max_level(buddy_info.break_lv)
    if max_level <= buddy_info.lv then
      exp = max_exp
    end
  end
  attr.v_exp_now_text.text = exp
  attr.v_exp_max_text.text = max_exp
  attr.v_exp_slider.value = exp / max_exp
  attr.v_level_now_text.text = level
  attr.v_level_max_text.text = ShareRes.get_buddy_max_level(buddy_info.break_lv)
  local break_lv = buddy_info.break_lv
  break_lv = break_lv - 1
  for i = 1, 5 do
    local star_obj = attr.v_uiobjects["Star" .. i]
    local lightup = Util.get_child_gameobj("Lightup", star_obj)
    lightup:SetActive(i <= break_lv)
  end
end

function ui:ui_finish_load()
  self.v_weapon_attr_open_type = CHARACTER_CONFIG.WEAPON_ATTR_OPEN_TYPE.CHAR
  self.v_panel_character_main = self:get_panel("char_main")
  self.v_panel_character_list = self:get_panel("char_list")
  self.v_panel_character_attr = self:get_panel("char_attr")
end

local effect_id = "Fx_UI_Switch_Hero"

function ui:update_model_view(buddy_id, load_cb)
  if not self:visible() then
    return
  end
  local model_fashion_id = FashionMgr:get_fashion_model_id(buddy_id)
  if not model_fashion_id then
    Log.Error(debug.traceback())
    Log.Error("模型Id为空-buddy_id:", buddy_id, "最后选择的英雄id:", CharacterMgr.v_last_select_buddy_id)
    return
  end
  local params = {
    model_id = model_fashion_id,
    npc_id = buddy_id,
    is_reload = self.v_model_view ~= nil,
    cb = load_cb
  }
  if not self.v_model_view then
    self.v_model_view = ModelRtView:new(MODEL_PARAM.BG_NAME, nil, nil, true)
    self.v_model_view:is_play_show_effect(true, effect_id)
    self.v_model_idx = self.v_model_view:load_npc(params)
    self.v_model_view:hide_model_node(false)
    local camera_param = MODEL_PARAM.INIT_CAMERA_PARAM
    self.v_model_view:set_camera_param(camera_param)
  else
    self.v_model_view:is_play_show_effect(true, effect_id)
    self.v_model_idx = self.v_model_view:load_npc(params)
  end
end

function ui:check_loading_model()
  if self.v_model_view then
    return self.v_model_view:is_loading()
  end
  return false
end

function ui:change_fashion(msg)
  local buddy_id = msg.mm_obj
  if buddy_id ~= self.last_buddy_id then
    return
  end
  self:update_model_view(buddy_id)
end

function ui:change_page(page)
  self.last_buddy_page = page
end

function ui:ui_update()
  if self.v_model_view then
    self.v_model_view:update()
  end
end

function ui:ui_on_show(is_not_clear, panel_type, callback, buddy_id)
  local uimain = UIMgr:try_get_visible_ui("uimain")
  if uimain then
    uimain:set_model_view_visible(false)
  end
  if panel_type then
    CharacterMgr:set_last_select_page(panel_type)
  end
  if buddy_id then
    CharacterMgr:set_last_select_buddy_id(buddy_id)
  end
  self.v_is_init_view = false
  self.v_is_not_clear = is_not_clear
  self.v_uicompents.CharPos_sld.gameObject:SetActive(false)
  self.v_uicompents.CharPos_sld.value = 0.5
  self:bind_auto_mq(Const.MSG_ON_HERO_UPDATE_FASHION, self.change_fashion, self)
  self.v_buddy_id = CharacterMgr.v_last_select_buddy_id
  self:update_model_view(self.v_buddy_id)
  self.v_lie_cfg = ShareRes.get_buddy_lie_cfg(self.v_buddy_id)
  self.v_lie_timer = 0
  self.v_is_playing = false
  self.v_open_callback = nil
  if callback then
    callback()
    self:show_attrs(false)
    self:show_main(false)
  else
    self:show_attrs(true)
    self:show_main(true)
  end
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 1)
end

function ui:ui_on_hide()
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 0)
  self.last_buddy_page = nil
  self:release_model()
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if ui_main then
    ui_main:refresh_character_red()
  end
  self.v_model_idx = nil
  self.v_lie_cfg = nil
  if UIMgr:has_ui("char_skill_task") then
    UIMgr:get_ui("char_skill_task"):ui_hide()
  end
  CharacterMgr.v_is_drop = false
  CharacterMgr:set_screen_condtion(1, nil, nil, nil, true)
end

function ui:show_char_image(show)
  if not self.v_model_view then
    return
  end
  self.v_model_view:set_visible(show)
  self.v_uiobjects.FullScreenBackground:SetActive(not show)
end

function ui:show_weapon_img(show)
  self.v_uicompents.ShowWeapon_rect.gameObject:SetActive(show)
  self.v_uiobjects.FullScreenBackground:SetActive(not show)
end

function ui:hide_all_img()
  if not self.v_model_view then
    return
  end
  self.v_model_view:set_visible(false)
  self.v_uiobjects.ShowWeapon:SetActive(false)
  self.v_uiobjects.FullScreenBackground:SetActive(true)
end

function ui:show_attrs(show)
  self.v_panel_character_attr:set_enable(show)
end

function ui:show_main(show)
  self.v_panel_character_main:set_enable(show)
end

function ui:show_char_list(show)
  self.v_panel_character_main:show_char_list(show)
end

function ui:change_buddy(buddy_id)
  self.v_is_init_view = false
  CharacterMgr:set_last_select_buddy_id(buddy_id)
  CharacterMgr:update_buddy_red(buddy_id)
  self.v_buddy_id = buddy_id
  
  local function load_cb()
    MsgGame:mq_publish2(Const.MSG_INSIDE_LIST_CHANGE_BUDDY)
  end
  
  self:update_model_view(self.v_buddy_id, load_cb)
  self.v_lie_cfg = ShareRes.get_buddy_lie_cfg(self.v_buddy_id)
end

function ui:show_main(show)
  self.v_panel_character_main:set_enable(show)
end

function ui:update_weapon_view(buddy_id)
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  if not buddy_info then
    return
  end
  local equip_uuid = buddy_info.weapon
  self.v_last_equip_uuid = equip_uuid
end

function ui:change_char_view(page, buddy_id)
  local type = PAGE_VIEW_TYPE[page]
  if self.v_model_view and type then
    local is_fast = not self.v_is_init_view
    local fashion_id = FashionMgr:get_fashion_wearing_id(buddy_id)
    self.v_model_view:set_view_param(buddy_id, type, is_fast, is_fast, self.v_model_idx, fashion_id)
    self.v_is_init_view = true
    if not CharacterRotatePage or 1 == CharacterRotatePage[page] then
      self.v_model_view:set_touch_area(self.v_uicompents.TouchArea_rect)
    else
      self.v_model_view:set_touch_area(nil)
    end
    self.v_model_view:set_content_rotate_zero()
    CharacterMgr:play_hero_approach_anim(buddy_id, type, self.v_model_view)
    self.v_model_view:show_char_advance_bg(2 == page)
    self.v_model_view:show_char_weapon_bg(3 == page)
  end
end

function ui:get_main_pnl()
  return self.v_panel_character_main
end

function ui:set_open_callback(cb)
  self.v_open_callback = cb
end

function ui:get_cache_data()
  return nil, nil, self.v_open_callback
end

function ui:cache_ui()
  return true
end

function ui:release_model()
  if self.v_model_view then
    self.v_model_view:on_destroy()
    self.v_model_view = nil
  end
end

function ui:stop_touch_rotate()
  if self.v_model_view then
    self.v_model_view:stop_touch_rotate()
  end
end

function ui:reset_touch_rotate()
  if self.v_model_view then
    self.v_model_view:reset_touch_rotate()
  end
end

return ui
