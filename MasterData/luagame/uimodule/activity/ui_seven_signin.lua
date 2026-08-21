local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Char_Helper = require("uimodule.character.char_helper")
local ItemHelper = require("utils.item_helper")
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local REWARD_STATE = {
  LOCK = 1,
  CAN_SIGN = 2,
  CAN_GET = 3,
  DONE = 4
}
local COLOR_DIME_1 = tonumber("8c8473", 16)
local COLOR_LIGHT_1 = tonumber("dd7a39", 16)
local COLOR_DIME_2 = tonumber("6f6c64", 16)

function ui:ui_finish_load()
  self.v_novice_days = ShareRes.get_comm_value("NewbieSignInPeriod")
  self.v_sign_objs = {}
  for i = 1, self.v_novice_days do
    local str = "Signin" .. i
    self.v_sign_objs[i] = self.v_uiobjects[str]
  end
  self.v_light_color = Util.get_unity_color_by_hex(COLOR_LIGHT_1)
  self.v_dime_color = Util.get_unity_color_by_hex(COLOR_DIME_1)
  self.v_dime_color_2 = Util.get_unity_color_by_hex(COLOR_DIME_2)
  self.v_uiobjects.ShowHero:SetActive(false)
  self:set_button("ShowHeroBtn", function()
    if self.v_anim_data.record_data.play_start then
      if self.v_anim_data.record_data.play_interrupt then
        SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
      end
    else
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
    end
  end)
  self.v_remain_time_text = Util.get_text("TimeNum", self.v_uiobjects.Time)
end

function ui:ui_on_show(activity_id)
  self:bind_auto_mq(Const.MSG_ON_UPDATE_SEVEN_SIGNIN, self.refresh_sign_list, self)
  self.v_activity_id = activity_id
  self.v_reward_cfg = ShareRes.create("activity.activity_sign_in", self.v_activity_id)
  self:refresh()
  self.v_low_update = Global.real_time
  self.v_anim_data = SpineHelper.get_init_anim_info()
end

function ui:refresh()
  self:refresh_show_role()
  self:refresh_sign_list()
end

function ui:refresh_sign_list()
  local sign_in_data = NoviceMgr:get_seven_sign_in_data(self.v_activity_id)
  for index, obj in ipairs(self.v_sign_objs) do
    local state
    if index > sign_in_data.login_day then
      state = REWARD_STATE.LOCK
    else
      local is_received = sign_in_data.reward_bit >> index - 1 & 1
      state = 1 == is_received and REWARD_STATE.DONE or REWARD_STATE.CAN_GET
    end
    self:_refresh_sign_item(index, obj, state)
  end
end

function ui:_refresh_sign_item(index, obj, state)
  local data = ShareRes.create("award.award", self.v_reward_cfg[index].AwardId)
  if not data then
    return
  end
  local Got = self:get_child_gameobj("Got", obj)
  local UnComplete = self:get_child_gameobj("UnComplete", obj)
  local BtnGet = self:get_button("BtnGet", obj)
  self:set_button_listener(BtnGet, function()
    NoviceMgr:request_newbie_receive_award(index)
  end)
  BtnGet:SetActive(state == REWARD_STATE.CAN_GET)
  Got:SetActive(state == REWARD_STATE.DONE)
  UnComplete:SetActive(state == REWARD_STATE.LOCK)
  local SoldOut = self:get_child_gameobj("SoldOut", obj)
  SoldOut:SetActive(state == REWARD_STATE.DONE)
  local icon = self:get_image("ItemIcon", obj)
  local item_icon = UtilUI.get_item_icon(data.ItemId)
  ResMgr:load_set_icon(icon, item_icon)
  local char_quality_img = self:get_image("CharQuality", obj)
  if self.v_reward_cfg[index].BuddyId then
    local quality_path = Char_Helper.get_char_icon_quality(self.v_reward_cfg[index].BuddyId, Config.CHAR_QUALITY_TYPE.NAME)
    ResMgr:load_set_icon(char_quality_img, quality_path)
    char_quality_img.gameObject:SetActive(true)
  else
    char_quality_img.gameObject:SetActive(false)
  end
  local itemNum = self:get_text("ItemAmount", obj)
  local BgAmount = self:get_child_gameobj("BgAmount", obj)
  if data.Num > 0 then
    itemNum.gameObject:SetActive(true)
    itemNum.text = data.Num
  else
    itemNum.gameObject:SetActive(false)
  end
  local RareBg = self:get_child_gameobj("RareBg", obj)
  RareBg:SetActive(self.v_reward_cfg[index].IsSpecial > 0)
  local btn = self:get_button(nil, obj)
  self:set_button_listener(btn, function()
    if state == REWARD_STATE.CAN_GET then
      NoviceMgr:request_seven_sign_in(self.v_reward_cfg[index].Id, self.v_activity_id, index, function()
        self:refresh_sign_list()
      end)
    else
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = data.ItemId
      })
    end
  end)
end

function ui:refresh_show_role()
  local day_cfg = self:_get_show_role()
  local buddy_id = day_cfg.BuddyId
  local pos = day_cfg.Pos
  local buddy_cfg = ShareRes.create("buddy.buddy", buddy_id)
  self:clear_spine_rt()
  self.v_spine_id = day_cfg.SpineID
  if self.v_spine_id then
    self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.ShowHero)
    self.v_anim_interval = SpineHelper.get_anim_interval(self.v_spine_id)
    SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.ShowHero)
  end
  self.v_uicompents.HeroName_txt.text = buddy_cfg.Name
  local quality_path = Char_Helper.get_char_icon_quality(buddy_id, Config.CHAR_QUALITY_TYPE.NAME)
  ResMgr:load_set_icon(self.v_uicompents.Quality2_img, quality_path)
end

function ui:_get_show_role()
  local last_show_buddy_day
  for day = 1, self.v_novice_days do
    local state = NoviceMgr:get_reward_get_state(day)
    local cfg = self.v_reward_cfg[day]
    if cfg.BuddyId then
      if state ~= REWARD_STATE.DONE then
        return cfg
      else
        last_show_buddy_day = cfg
      end
    end
  end
  return last_show_buddy_day
end

function ui:ui_on_update()
  if not self.v_spine_id then
    return
  end
  if Global.real_time - self.v_low_update < SpineHelper.UPDATE_TIME then
    return
  end
  self.v_low_update = Global.real_time
  if self.v_anim_data.record_data.play_end then
    self.v_start_time = self.v_start_time or Global.real_time
    if self.v_anim_interval and Global.real_time - self.v_start_time > self.v_anim_interval then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.INTERVAL)
    end
  else
    self.v_start_time = Global.real_time
  end
  SpineHelper.check_play_anim(self.v_spine_rt, self.v_anim_data)
  local activity_data = NoviceMgr:get_novice_activity_data(self.v_activity_id)
  local activity_cfg = ShareRes.get_activity_cfg(self.v_activity_id)
  self.v_remain_time_text.text = self.v_parent_panel:get_time_remaining(activity_cfg.TimeType, activity_cfg.StopTime, activity_data.open_time, activity_cfg.SustainTime)
end

function ui:ui_on_destroy()
  self:clear_spine_rt()
end

function ui:ui_on_hide()
  self:clear_spine_rt()
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

return ui
