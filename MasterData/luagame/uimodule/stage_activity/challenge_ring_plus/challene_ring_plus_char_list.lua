local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local CommonDefine = require("cs_share.common_define")
local RUNE2_TYPE = CommonDefine.RUNE2_TYPE
local CURSE_CARD_TYPE = CommonDefine.CURSE_CARD_TYPE
local RUNE_HELPER = require("gamelogic.activity.rune2_helper")
local RUNE_COLOR = RUNE_HELPER.RUNE_COLOR
local BIND_TYPE = Config.BIND_TYPE
local BALL_LIGHT_ICON_PATH = {
  "UIRune/UIRune_txfw_yk_red",
  "UIRune/UIRune_txfw_yk_yellow",
  "UIRune/UIRune_txfw_yk_blue"
}
local MODEL = {
  v_char_icon = {
    "CharIcon",
    BIND_TYPE.IMAGE
  },
  v_mask = {
    "Mask",
    BIND_TYPE.OBJECT
  },
  v_death = {
    "Death",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_tog = Util.get_toggle(nil, self.v_object)
  self:set_toggle_listener(self.v_tog, function(isOn)
    self:on_click_tog(isOn)
  end)
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(hero, type)
  self.v_hero = hero
  self.v_type = type
  if self.v_type == CURSE_CARD_TYPE.SHOP_RUNE then
    self:set_tog_interactable(false)
    self:set_tog_state(false)
  elseif self.v_type == CURSE_CARD_TYPE.FORGE_UPGRADE then
    self:set_tog_interactable(true)
  elseif self.v_type == CURSE_CARD_TYPE.FORGE_ENTRY then
    self:set_tog_interactable(true)
  end
  self:refresh_info()
end

function ui:refresh_info()
  local buddy_id = self.v_hero.buddy_cfg.Id
  self.v_mask:SetActive(self.v_hero:is_die())
  self.v_death:SetActive(self.v_hero:is_die())
  local path = UtilUI.get_hero_images(buddy_id, 1)
  ResMgr:load_set_icon(self.v_char_icon, path)
  self.v_rune_lv = 0
  local hero_rune_list = self.v_hero.buddy_cfg.RuneType
  local rune_info = Rune2Mgr:get_rune_buddy_info(buddy_id)
  local is_have_info = false
  for i = 1, 3 do
    self.v_uiobjects["Star" .. i]:SetActive(false)
  end
  for index, rune_type in ipairs(hero_rune_list) do
    local level = 0
    local pos = index
    if not is_have_info then
      local max_lv = ShareRes.get_buddy_rune_max_lv(self.v_buddy_id, rune_type)
      for i = 1, max_lv do
        local star = self.v_uiobjects["Star" .. i]
        local star_light = Util.get_child("Light", star)
        star_light.gameObject:SetActive(false)
        star:SetActive(true)
      end
    end
    if rune_info and rune_info.pos == index then
      is_have_info = true
      level = rune_info.level
      self.v_rune_lv = self.v_rune_lv + rune_info.level
      pos = rune_info.pos
      for i = 1, level do
        local star_light = Util.get_child("Light", self.v_uiobjects["Star" .. i])
        star_light.gameObject:SetActive(i <= level)
      end
    end
    local ball_image = self.v_uicompents["Ball" .. index .. "_img"]
    Rune2Mgr:set_ball_img(ball_image, rune_type)
    local light = Util.get_image("Light", ball_image.gameObject)
    if index == pos and level > 0 then
      ResMgr:load_set_icon(light, BALL_LIGHT_ICON_PATH[rune_type])
      light.gameObject:SetActive(true)
    else
      light.gameObject:SetActive(false)
    end
  end
end

function ui:get_rune_lv()
  return self.v_rune_lv
end

function ui:on_click_tog(isOn)
  self:set_tog_interactable(not isOn)
  if not isOn then
    return
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SELECT_CURSE_RUNE_HERO_HEAD)
  msg.mm_obj = self.v_hero
end

function ui:force_onclick()
  self.v_tog.isOn = true
  self:on_click_tog(true)
end

function ui:set_tog_state(state)
  self.v_tog.isOn = state
end

function ui:set_tog_interactable(state)
  self.v_tog.interactable = state
end

return ui
