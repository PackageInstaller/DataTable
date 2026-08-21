local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local EVENT_CARD_ITEM = require("uimodule.stage_activity.fate_book.fate_book_event_card_item")
local CURSE_OBJ_CLASS = require("uimodule.stage_activity.challenge_ring_plus.curse_obj")
local AssetBarView = require("ui.asset_bar.asset_bar")
local EVENT_CARD_DESC_ITEM = "EVENT_CARD_DESC_ITEM"
local EVENT_CARD_OPTION_ITEM = "EVENT_CARD_OPTION_ITEM"
local BUFF_TYPE = Config.CommonDefine.BUFF_TYPE
local GET_AWARD_BUFF_TYPE = {
  [BUFF_TYPE.REFRESH_ALL_ORNAMENTS_BUFF] = true,
  [BUFF_TYPE.ADD_ORNAMENTS_BY_DROP_ID] = true,
  [BUFF_TYPE.UP_ABILITY_GRADE] = true,
  [BUFF_TYPE.GET_ABILITY] = true
}
local ASSET_BAR_CONFIG = {
  {
    item_id = Config.CURSE_GOLD,
    const_event = Const.MSG_ON_FIGHT_DIAMOND_UPDATE,
    is_fight_bag = true,
    not_show_max = true,
    bg_click = false
  }
}
local PLAY_TYPE = {DESC = 1, OPTION = 2}

function ui:on_select_option_item(option_index, option_id)
  self.v_select_option_index = option_index
  for key, item in pairs(self.v_option_item_list) do
    item:on_select_option(option_id, self.v_select_option_id ~= nil)
  end
  self.v_select_option_id = option_id
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.event_select_UI_SOUND)
end

function ui:on_gm_response_suc(msg)
  local index = ChallengeRingPlusMgr:get_cur_select_card_index()
  local event_data = ChallengeRingPlusMgr:get_card_event_data()
  self:reset_data()
  self:remove_all_select_item()
  self:refresh_view(index, event_data, false)
end

function ui:on_uiqueue_empty()
  if self.v_have_get_award_buff_type then
    self:do_hide()
  end
end

function ui:ui_finish_load()
  self:set_button("BtnPause", function()
    self.v_is_click_pause = true
    UIMgr:get_ui("battle_bag4"):ui_show()
  end)
  self.v_desc_txt_list = {}
  self.v_option_item_list = {}
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, ASSET_BAR_CONFIG)
  self.v_stop = false
  self.v_cur_play_type = PLAY_TYPE.DESC
  self.v_curse_view = CURSE_OBJ_CLASS:ui_wrap(self, self.v_uiobjects.CurseObj, false)
  self:register_exist_auto_template(EVENT_CARD_DESC_ITEM, self.v_uiobjects.DescTem, self.v_uiobjects.DescContent)
  self:register_exist_auto_template(EVENT_CARD_OPTION_ITEM, self.v_uiobjects.OptionTem, self.v_uiobjects.OptionContent)
end

function ui:ui_on_update(delta_time)
  if not (not self.v_stop and self.v_delay_create_timer) or self.v_is_click_pause then
    return
  end
  self.v_delay_create_timer = self.v_delay_create_timer - delta_time
  if self.v_delay_create_timer <= 0 then
    if self.v_cur_play_type == PLAY_TYPE.DESC then
      self:play_event_desc()
      self.v_uiobjects.OptionContent:SetActive(false)
    else
      self:play_event_option()
    end
  end
end

function ui:ui_on_show(index, event_data, need_back_ring_view, by_continue)
  self:reset_data()
  self.v_need_back_ring_view = need_back_ring_view
  self.v_by_continue = by_continue
  self:bind_auto_mq(Const.MSG_ON_GM_RESPONSE_SUC, self.on_gm_response_suc, self)
  self:bind_auto_mq(Const.MSG_ON_UIQUEUE_EMPTY, self.on_uiqueue_empty, self)
  self:refresh_view(index, event_data, by_continue)
end

function ui:ui_on_hide()
  if self.v_option_sound_timer then
    Timer:remove_timer(self.v_option_sound_timer)
    self.v_option_sound_timer = nil
  end
  self.v_curse_view:ui_hide()
  self.v_asset_bar:on_hide()
  self:remove_all_select_item()
  self.v_by_continue = nil
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:refresh_view(index, event_data)
  self.v_uiobjects.NoClick:SetActive(false)
  self.v_index = index
  self.v_event_data = event_data
  self.v_event_id = event_data.event_id
  self.v_curse_view:set_enable(true)
  self.v_curse_view:ui_show()
  self.v_asset_bar:on_create()
  self.v_event_cfg = ShareRes.get_curse_event_cfg(self.v_event_id)
  if self.v_is_click_pause then
    self.v_uiobjects.OptionContent:SetActive(true)
    self:create_all_desc_and_option()
  else
    self.v_uiobjects.OptionContent:SetActive(false)
    self:refresh_event_info()
    self:play_event_desc()
  end
end

function ui:refresh_event_info()
  ResMgr:load_set_icon(self.v_uicompents.EventIcon_img, self.v_event_cfg.IconPath, nil, true, self)
  self.v_uicompents.EventName_txt.text = self.v_event_cfg.Name
end

function ui:play_event_desc()
  if not self.v_event_cfg then
    Log.Error("获取事件牌数据失败， 事件牌ID", self.v_event_id)
    self.v_stop = true
    return
  end
  local cur_index = self.v_cur_index and self.v_cur_index + 1 or 1
  self.v_cur_index = cur_index
  self:create_desc_text()
end

function ui:create_desc_text()
  if UIMgr.ui_queue_mgr:check_cur_scene_queue_is_empty() and not self.v_by_continue then
    Global.sound_mgr:play_common_sound("Sound_textopition_show")
  end
  local obj = self:get_auto_cache(EVENT_CARD_DESC_ITEM)
  local text_component = self:get_text(nil, obj).component
  text_component.text = self.v_event_cfg.Desc[self.v_cur_index]
  self:move_to_pos(obj)
  self:check_next_desc()
end

function ui:check_next_desc()
  local next_id = self.v_cur_index + 1
  local delay
  local pd = self.v_uicompents.DescTem_pd
  if Util.is_more_than_zero(self.v_event_cfg.Delay[next_id]) then
    delay = self.v_event_cfg.Delay[next_id]
  elseif not Util.is_nil(pd) then
    delay = pd.duration
  end
  self.v_delay_create_timer = delay or 0
  if not self.v_event_cfg.Desc[next_id] then
    self.v_cur_play_type = PLAY_TYPE.OPTION
    self.v_cur_index = 0
    self:check_next_option()
  end
end

function ui:play_event_option()
  local cur_index = self.v_cur_index and self.v_cur_index + 1 or 1
  self.v_cur_index = cur_index
  self:create_option_button()
end

function ui:create_option_button()
  if self.v_option_sound_timer then
    Timer:remove_timer(self.v_option_sound_timer)
    self.v_option_sound_timer = nil
  end
  if UIMgr.ui_queue_mgr:check_cur_scene_queue_is_empty() and not self.v_by_continue then
    self.v_option_sound_timer = Timer:add_timer("option_sound_timer", 0.8, function()
      Global.sound_mgr:play_common_sound("Sound_textopition_show")
    end)
  end
  self.v_uiobjects.OptionContent:SetActive(true)
  self.v_stop = true
  self.v_by_continue = false
  local last_obj
  for index, option_id in ipairs(self.v_event_cfg.Option) do
    last_obj = self:create_option_item(index, option_id)
  end
  if last_obj then
    self:move_to_pos(last_obj)
  end
end

function ui:check_next_option()
  local next_id = self.v_cur_index + 1
  local option_id = self.v_event_cfg.Option[next_id]
  if not option_id then
    self.v_stop = true
  end
  local delay
  local option_cfg = ShareRes.get_curse_event_option_cfg(option_id)
  local pd = self.v_uicompents.OptionTem_pd
  if Util.is_more_than_zero(option_cfg.Delay) then
    delay = option_cfg.Delay
  elseif not Util.is_nil(pd) then
    delay = pd.duration
  end
  self.v_delay_create_timer = delay or 0
end

function ui:create_all_desc_and_option()
  local obj, item, text_component
  for index, str in ipairs(self.v_event_cfg.Desc) do
    obj = self:get_auto_cache(EVENT_CARD_DESC_ITEM)
    text_component = self:get_text(nil, obj).component
    text_component.text = str
  end
  for index, option_id in ipairs(self.v_event_cfg.Option) do
    self:create_option_item(index, option_id)
    self.v_option_item_list[option_id]:set_canvas_group_alpha(1)
  end
end

function ui:create_option_item(index, option_id)
  local item, obj
  obj = self:get_auto_cache(EVENT_CARD_OPTION_ITEM)
  item = EVENT_CARD_ITEM:ui_wrap(self, obj, true)
  item:set_data(index, option_id, not self.v_is_click_pause)
  self.v_option_item_list[option_id] = item
  return obj
end

function ui:check_can_select_option()
  local cfg = ShareRes.get_curse_event_option_cfg(self.v_select_option_id)
  if cfg.CoinValue and cfg.CoinValue < 0 and not Util.check_item_cost_enough(Config.CURSE_GOLD, -cfg.CoinValue) then
    local name = UtilUI.get_item_name(Config.CURSE_GOLD)
    Util.show_message_tip(2314, name)
    return false
  end
  return true
end

function ui:confirm_select_option(option_index, option_id)
  if self.v_select_option_id ~= option_id or self.v_select_option_index ~= option_index or not Util.is_more_than_zero(option_index) then
    return
  end
  if not self:check_can_select_option() then
    self.v_uiobjects.NoClick:SetActive(false)
    return
  end
  self.v_uiobjects.NoClick:SetActive(true)
  local cfg = ShareRes.get_curse_event_option_cfg(self.v_select_option_id)
  if not ChallengeRingPlusMgr:check_option_condition(self.v_select_option_id) then
    self.v_uiobjects.NoClick:SetActive(false)
    return
  end
  if cfg.BuffId then
    BUFF_TYPE = Config.CommonDefine.BUFF_TYPE
    local buff_cfg = ShareRes.create("battle.battle_buff")[cfg.BuffId]
    if buff_cfg and (buff_cfg.Type == BUFF_TYPE.GET_ABILITY or buff_cfg.Type == BUFF_TYPE.ADD_ORNAMENTS_BY_DROP_ID) then
      ChallengeRingPlusMgr:request_select_event_option(self.v_index, self.v_select_option_index)
      self.v_uiobjects.NoClick:SetActive(false)
      return
    end
  end
  
  local function cb(ok, resp)
    self.v_uiobjects.NoClick:SetActive(false)
    if not ok then
      return
    end
    local option_room = self.v_event_data.option_room
    if option_room and option_room[self.v_select_option_index] then
      local data = option_room[self.v_select_option_index]
      ChallengeRingPlusMgr:select_battle_option(data.room_num)
    else
      self:after_confirm_select_option(resp)
    end
  end
  
  ChallengeRingPlusMgr:request_select_event_option(self.v_index, self.v_select_option_index, cb)
end

function ui:after_confirm_select_option(resp)
  local new_event_data = ChallengeRingPlusMgr:get_card_event_data()
  self.v_have_get_award_buff_type = nil
  if resp and resp.option_effect_list then
    local buff_cfg
    for key, data in pairs(resp.option_effect_list) do
      if data.type == Config.CommonDefine.EVENT_OPTION_EFFECT_TYPE.BUFF_ID then
        buff_cfg = ShareRes.create("battle.battle_buff")[data.value]
        if buff_cfg and GET_AWARD_BUFF_TYPE[buff_cfg.Type] then
          self.v_have_get_award_buff_type = true
        end
      elseif data.type == Config.CommonDefine.EVENT_OPTION_EFFECT_TYPE.CURSE_VALUE then
        ChallengeRingPlusMgr:record_before_fight_view_info()
      end
    end
  end
  if not new_event_data or not Util.is_more_than_zero(new_event_data.event_id) then
    if not self.v_have_get_award_buff_type then
      self:do_hide()
    end
    return
  end
  self:reset_data()
  self.v_is_click_pause = false
  self:refresh_view(self.v_index, new_event_data)
end

function ui:move_to_pos(obj)
  self:clear_sequence()
  self.v_sequence = Util.create_sequence()
  local rect = self:get_rect_transform(nil, obj)
  Util.move_to_target_point_pos(rect, self.v_uicompents.ScrollView_rect, self.v_uicompents.Content_rect, false, self.v_sequence, 0.35)
  self.v_sequence:OnComplete(function()
    self:clear_sequence()
  end)
end

function ui:do_hide()
  local function cb()
    self:reset_data()
    
    self.v_is_click_pause = false
    self.v_stop = true
    self:ui_hide()
    self.v_stop = false
    self.v_have_get_award_buff_type = nil
  end
  
  ChallengeRingPlusMgr:req_remove_card(cb)
end

function ui:remove_all_select_item()
  self:give_back_auto_cache(EVENT_CARD_OPTION_ITEM)
  for key, item in pairs(self.v_option_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_option_item_list[key] = nil
  end
end

function ui:reset_data()
  self.v_cur_play_type = PLAY_TYPE.DESC
  self.v_stop = false
  self.v_event_id = nil
  self.v_cur_index = nil
  self.v_event_cfg = nil
  self:give_back_auto_cache(EVENT_CARD_DESC_ITEM)
  self:remove_all_select_item()
end

function ui:clear_sequence()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_index, self.v_event_data
end

return ui
