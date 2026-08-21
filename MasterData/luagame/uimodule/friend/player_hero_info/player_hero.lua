local ModelRtView = require("ui.model_rt_view.signboard_rt_view_new")
local MODEL_CONFIG = require("ui.model_rt_view.model_config")
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")
local all_fashionable_info = ShareRes.create("buddy.buddy_fashion")
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local UnityShader = UnityEngine.Shader
local MAIN_SCENE_SHOW_ID = UnityShader.PropertyToID("_MAIN_SCENE_SHOW")
local WEAPON_PANEL = 2
local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local CHAR_ATTR_MODEL = {
  v_hp = {
    "CharHp",
    BIND_TYPE.TEXT
  },
  v_mp = {
    "CharMp",
    BIND_TYPE.TEXT
  },
  v_attack = {
    "CharAttack",
    BIND_TYPE.TEXT
  },
  v_spec_attack = {
    "CharSpecAttack",
    BIND_TYPE.TEXT
  },
  v_def = {
    "CharDef",
    BIND_TYPE.TEXT
  },
  v_char_spec_def = {
    "CharSpecDef",
    BIND_TYPE.TEXT
  },
  v_level_now_text = {
    "LvNow",
    BIND_TYPE.TEXT
  },
  v_level_max_text = {
    "LvMax",
    BIND_TYPE.TEXT
  },
  v_exp_now_text = {
    "ExpNow",
    BIND_TYPE.TEXT
  },
  v_exp_max_text = {
    "ExpMax",
    BIND_TYPE.TEXT
  },
  v_exp_slider = {
    "ExpSlider",
    BIND_TYPE.SLIDER
  },
  v_star1 = {
    "Star1",
    BIND_TYPE.TRANSFORM
  },
  v_star2 = {
    "Star2",
    BIND_TYPE.TRANSFORM
  },
  v_star3 = {
    "Star3",
    BIND_TYPE.TRANSFORM
  }
}
local MODEL = {
  v_char_show = {
    "ShowChar",
    BIND_TYPE.RAW_IMAGE
  },
  v_attr_root = {
    "AttrRoot",
    BIND_TYPE.OBJECT
  }
}
local PAGE_VIEW_TYPE = {
  [1] = 2,
  [2] = 3,
  [3] = 4,
  [4] = 5
}
local MODEL_PARAM = MODEL_CONFIG.UI_CHARACTER_MODEL_PARAM

function ui:ui_finish_load()
  self.v_weapon_attr_open_type = CHARACTER_CONFIG.WEAPON_ATTR_OPEN_TYPE.CHAR
  self:init_model(MODEL)
  self.v_panel_character_main = self:get_panel("player_hero_main")
  self.v_panel_character_attr = self:get_panel("player_hero_attr")
end

function ui:update_model_view(buddy_id)
  if not self:visible() then
    return
  end
  if not self.v_fashion_id or self.v_fashion_id <= 0 then
    self.v_fashion_id = ShareRes.create("buddy.buddy", buddy_id).FashionInitId
  end
  local model_id = all_fashionable_info[self.v_fashion_id].ModelId
  if not self.v_model_view then
    self.v_model_view = ModelRtView:new(MODEL_PARAM.BG_NAME)
    local type = PAGE_VIEW_TYPE[1]
    local params = {
      model_id = model_id,
      npc_id = buddy_id,
      is_reload = true,
      use_weapon_id = Player_Hero_Helper.get_use_weapon_id(),
      ignore_fashion = true,
      init_anim = CharacterMgr:get_hero_approach_anim_by_type(buddy_id, type)
    }
    self.v_model_idx = self.v_model_view:load_npc(params)
    self.v_model_view:hide_model_node(false)
    local camera_param = MODEL_PARAM.INIT_CAMERA_PARAM
    self.v_model_view:set_camera_param(camera_param)
  end
end

function ui:check_loading_model()
  if self.v_model_view then
    return self.v_model_view:is_loading()
  end
  return false
end

function ui:change_page(page)
  self.last_buddy_page = page
end

function ui:ui_update()
  if self.v_model_view then
    self.v_model_view:update()
    if self.v_lie_timer and self.v_lie_cfg and self.v_lie_cfg.LieCd then
      self.v_lie_timer = self.v_lie_timer + GlobalTimeMgr:get_dt_time()
      if self.v_lie_timer > self.v_lie_cfg.LieCd and not self.v_is_playing and self.last_buddy_page ~= WEAPON_PANEL then
        local random_act = self.v_lie_cfg.Act[math.random(#self.v_lie_cfg.Act)]
        self.v_model_view:play_anim(random_act, self.v_model_idx, function()
          self.v_lie_timer = 0
          self.v_is_playing = false
        end)
        self.v_is_playing = true
      end
    end
  end
end

function ui:ui_on_show(last_page, show_cb, return_cb)
  self.v_return_cb = return_cb
  self.v_uimain = UIMgr:try_get_visible_ui("uimain")
  if self.v_uimain then
    self.v_uimain:set_model_view_visible(false)
  end
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 1)
  self.v_uiobjects.CharList:SetActive(false)
  if not last_page then
    CharacterMgr:set_last_select_page(1)
  end
  self.v_is_init_view = false
  self.v_uicompents.CharPos_sld.gameObject:SetActive(false)
  self.v_uicompents.CharPos_sld.value = 0.5
  self.v_buddy_id = Player_Hero_Helper.get_hero_id()
  self.v_buddy_info = Player_Hero_Helper.get_hero_data()
  self.v_fashion_id = self.v_buddy_info.fashion
  self:update_model_view(self.v_buddy_id)
  self.v_lie_cfg = ShareRes.get_buddy_lie_cfg(self.v_buddy_id)
  self.v_lie_timer = 0
  self.v_is_playing = false
  self.v_open_callback = nil
  self:show_attrs(true)
  self:show_main(true)
end

function ui:ui_after_show(last_page, show_cb, return_cb)
  if show_cb then
    show_cb()
  end
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

function ui:show_tip_by_type(type, target_info, msg)
  if type == CHARACTER_CONFIG.ETIP_TYPE.lv_tip then
    local tips = Util.format_str("等级提升")
    if msg then
      tips = Util.format_str(msg)
    end
    UIMgr:get_ui("uimessagetip"):ui_show(tips, nil, {
      target_info.lv,
      "LV"
    })
  elseif type == CHARACTER_CONFIG.ETIP_TYPE.tupo_tip then
  elseif type == CHARACTER_CONFIG.ETIP_TYPE.msg_tip then
    Util.show_message_tip(msg)
  end
end

function ui.get_char_attr_model()
  return CHAR_ATTR_MODEL
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
    self.v_model_view:set_view_param(buddy_id, type, is_fast, is_fast, self.v_model_idx, self.v_fashion_id)
    self.v_is_init_view = true
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
  return CharacterMgr:get_last_select_page()
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

return ui
