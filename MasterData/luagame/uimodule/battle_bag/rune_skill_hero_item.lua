local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local RUNE_HELPER = require("gamelogic.activity.rune2_helper")
local CommonDefine = require("cs_share.common_define")
local RUNE2_TYPE = CommonDefine.RUNE2_TYPE
local NOT_HAVE_RUNE = 0
local RUNE_COLOR = RUNE_HELPER.RUNE_COLOR
local ACT_NAME_COLOR = Util.get_unity_color_by_hex(tonumber("292929", 16))
local NOT_ACT_NAME_COLOR = Util.get_unity_color_by_hex(tonumber("bcb4a5", 16))

function ui:ui_on_hide()
  self.v_idx = nil
end

function ui:set_data(hero, idx)
  local tog = Util.get_toggle(nil, self.v_object)
  if not hero then
    tog.interactable = false
    return
  end
  self.v_hero = hero
  self.v_idx = idx
  self.v_buddy_cfg = hero.buddy_cfg
  self.v_buddy_id = hero.buddy_cfg.Id
  self.v_buddy_rune_info = Rune2Mgr:get_rune_buddy_info(self.v_buddy_id)
  self:refresh_hero_name()
  self:refresh_hero_ball_info()
  tog.interactable = true
  local char_name_text = self.v_uicompents.CharName_txt
  self:set_toggle_listener(tog, function(is_on)
    if is_on then
      char_name_text.color = ACT_NAME_COLOR
      local msg = MsgGame:mq_publish2(Const.MSG_ON_SELECT_RUNE_HERO_ITEM)
      msg.mm_x = self.v_idx
      msg.mm_obj = hero
    else
      char_name_text.color = NOT_ACT_NAME_COLOR
    end
  end)
end

function ui:refresh_hero_name()
  local char_name_text = self.v_uicompents.CharName_txt
  char_name_text.color = NOT_ACT_NAME_COLOR
  char_name_text.text = self.v_buddy_cfg.Name
end

function ui:refresh_hero_ball_info()
  local rune_type_list = self.v_buddy_cfg.RuneType
  local lv = 0
  local pos = NOT_HAVE_RUNE
  if self.v_buddy_rune_info then
    lv = self.v_buddy_rune_info.level
    pos = self.v_buddy_rune_info.pos
  end
  for idx, rune_type in pairs(rune_type_list) do
    local ball_image = self.v_uicompents["Ball" .. idx .. "_img"]
    local ball_level_text = self.v_uicompents["BallLevel" .. idx .. "_txt"]
    ball_level_text.text = ""
    Rune2Mgr:set_ball_img(ball_image, rune_type)
    local txt_color = rune_type == RUNE2_TYPE.YELLOW_RUNE and "000000" or "FFFFFF"
    ball_level_text.color = Util.get_unity_color_by_hex(tonumber(txt_color, 16))
    if pos ~= NOT_HAVE_RUNE and pos == idx then
      ball_level_text.text = lv
    end
  end
end

function ui:on_select(idx)
  local char_name_text = self.v_uicompents.CharName_txt
  if idx == self.v_idx then
    local tog = Util.get_toggle(nil, self.v_object)
    char_name_text.color = ACT_NAME_COLOR
    tog.isOn = false
    tog.isOn = true
  else
    char_name_text.color = NOT_ACT_NAME_COLOR
  end
end

return ui
