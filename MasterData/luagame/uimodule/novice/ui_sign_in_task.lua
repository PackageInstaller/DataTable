local Base = require("ui.uiobject")
local BIND_TYPE = Config.BIND_TYPE
local Char_Helper = require("uimodule.character.char_helper")
local ui = Util.create_child_mt(Base)
local GET_STATE = {
  LOCK = 1,
  CAN_SIGN = 2,
  CAN_GET = 3,
  HAS = 4
}
local QUALITY_STR = {
  [1] = "",
  [2] = "",
  [3] = "R",
  [4] = "S R",
  [5] = "S S R"
}
local CT_Timer = Global.ct_timer
local COLOR_DIME_1 = tonumber("8c8473", 16)
local COLOR_LIGHT_1 = tonumber("dd7a39", 16)
local COLOR_DIME_2 = tonumber("6f6c64", 16)
local MODEL = {
  v_award_day = {
    "AwardDay",
    BIND_TYPE.TEXT
  },
  v_hero_name = {
    "HeroName",
    BIND_TYPE.TEXT
  },
  v_quality1 = {
    "Quality1",
    BIND_TYPE.IMAGE
  },
  v_quality2 = {
    "Quality2",
    BIND_TYPE.IMAGE
  },
  v_quality_txt = {
    "QualityTxt",
    BIND_TYPE.TEXT
  },
  v_show_hero = {
    "ShowHero",
    BIND_TYPE.IMAGE
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_novice_days = ShareRes.get_comm_value("NewbieSignInPeriod")
  self.v_sign_lists = {}
  for i = 1, self.v_novice_days do
    local str = "Signin" .. tostring(i)
    self.v_sign_lists[i] = self.v_uiobjects[str]
  end
  self.v_reward_cfg = ShareRes.create("newbie.newbie_sign_in")
  self.v_light_color = Util.get_unity_color_by_hex(COLOR_LIGHT_1)
  self.v_dime_color = Util.get_unity_color_by_hex(COLOR_DIME_1)
  self.v_dime_color_2 = Util.get_unity_color_by_hex(COLOR_DIME_2)
end

function ui:ui_on_show()
  self:_refresh_sign_list()
  self:_regist_client_event()
  self:_refresh_show_buddy()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_NOVICE_SIGN_UPDATE, self.response_sign_update_event, self)
end

function ui:response_sign_update_event()
  self:_refresh_sign_list()
  self:_refresh_show_buddy()
end

function ui:ui_on_hide()
  if self.v_reset_timer then
    CT_Timer:remove_timer(self.v_reset_timer)
    self.v_reset_timer = nil
  end
end

function ui:_refresh_sign_list()
  for i, v in ipairs(self.v_sign_lists) do
    self:_refresh_sign_item(i, v)
  end
end

function ui:_refresh_sign_item(idx, item)
  local data = ShareRes.create("award.award", self.v_reward_cfg[idx].AwardId)
  local state = NoviceMgr:get_reward_get_state(idx)
  local canGetBtn = self:get_button("BtnGet", item)
  local canGetBg = self:get_child_gameobj("BgGet", item)
  self:set_button_listener(canGetBtn, function()
    NoviceMgr:request_newbie_receive_award(idx)
  end)
  canGetBtn:SetActive(state == GET_STATE.CAN_GET)
  canGetBg:SetActive(state == GET_STATE.CAN_GET)
  if idx < 7 then
    local dayNum = self:get_text("DayNum", item)
    local dayNum2 = self:get_text("DayMask/DayNum2", item)
    dayNum.color = (state == GET_STATE.LOCK or state == GET_STATE.HAS) and self.v_dime_color or self.v_light_color
    dayNum2.color = (state == GET_STATE.LOCK or state == GET_STATE.HAS) and self.v_dime_color_2 or self.v_light_color
  end
  local hasGet = self:get_child_gameobj("SoldOut", item)
  hasGet:SetActive(state == GET_STATE.HAS)
  local icon = self:get_child_gameobj("ItemIcon", item)
  self:create_item_obj(nil, icon, nil, {
    item_id = data.ItemId,
    click_cb = function()
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = data.ItemId
      })
    end
  })
  local itemNum = self:get_text("ItemAmount", item)
  itemNum.text = data.Num
  local btn = self:get_button(nil, item)
  self:set_button_listener(btn, function()
    if state == GET_STATE.CAN_GET then
      NoviceMgr:request_newbie_receive_award(idx)
    end
  end)
end

function ui:_refresh_show_buddy()
  local day_cfg = self:_get_show_buddy()
  local buddy_id = day_cfg.BuddyId
  local pos = day_cfg.Pos
  local buddy_cfg = ShareRes.create("buddy.buddy", buddy_id)
  local pic_path = UtilUI.get_hero_images(buddy_id, Config.HERO_ICON_LV.HD_FULL_IMG)
  self.v_hero_name.text = buddy_cfg.Name
  ResMgr:load_set_icon(self.v_show_hero, pic_path, nil, true, self)
  self.v_show_hero.transform:SetLocalPositionA(pos[1], pos[2], 0)
  self.v_show_hero.transform:SetLocalScaleA(pos[3], pos[3], pos[3])
  local quality_path = Char_Helper.get_char_icon_quality(buddy_id, Config.CHAR_QUALITY_TYPE.NAME)
  ResMgr:load_set_icon(self.v_quality2, quality_path)
  self.v_quality_txt.text = QUALITY_STR[buddy_cfg.Quality] or ""
end

function ui:_get_show_buddy()
  local last_show_buddy_day
  for day = 1, self.v_novice_days do
    local state = NoviceMgr:get_reward_get_state(day)
    local cfg = self.v_reward_cfg[day]
    if cfg.BuddyId then
      if state ~= GET_STATE.HAS then
        return cfg
      else
        last_show_buddy_day = cfg
      end
    end
  end
  return last_show_buddy_day
end

return ui
