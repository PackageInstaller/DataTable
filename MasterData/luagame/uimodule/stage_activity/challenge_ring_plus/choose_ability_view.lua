local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CHOOSE_ABILITY_TEM = "CHOOSE_ABILITY_TEM"
local CHOOSE_ORNAMENT_TEM = "CHOOSE_ORNAMENT_TEM"
local AssetBarView = require("ui.asset_bar.asset_bar")
local ORN_VIEW_ITEM = require("uimodule.battle_bag.orn_view_item")
local DROP_ABILITY_ITEM_CLASS = require("uimodule.stage_activity.challenge_ring_plus.drop_ability_item")
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local asset_bar_config = {
  {
    item_id = Config.CURSE_GOLD,
    const_event = Const.MSG_ON_FIGHT_DIAMOND_UPDATE,
    is_fight_bag = true,
    not_show_max = true,
    bg_click = false
  }
}
local CURSE_CHOOSE_ITEM_TYPE = curse_com_def.CURSE_CHOOSE_ITEM_TYPE
local REFRESH_FUNC_NAME = {
  [CURSE_CHOOSE_ITEM_TYPE.ABILITY] = "refresh_drop_ability_data",
  [CURSE_CHOOSE_ITEM_TYPE.ORNAMENT] = "refresh_ornament_data",
  [CURSE_CHOOSE_ITEM_TYPE.BUFF_ABILITY] = "refresh_buff_ability_data",
  [CURSE_CHOOSE_ITEM_TYPE.BUFF_ORNAMENT] = "refresh_buff_ornament_data",
  [CURSE_CHOOSE_ITEM_TYPE.UPDAGRADE_ABILITY] = "refresh_updagrade_ability_data",
  [CURSE_CHOOSE_ITEM_TYPE.TASK_ABILITY_AWARD] = "refresh_task_ability_award_data",
  [CURSE_CHOOSE_ITEM_TYPE.OPTION_ABILITY] = "refresh_option_ability_data",
  [CURSE_CHOOSE_ITEM_TYPE.OPTION_ORNAMENT] = "refresh_option_ornament_data",
  [CURSE_CHOOSE_ITEM_TYPE.MINI_GAME_ORNAMENT] = "refresh_option_ornament_data",
  [CURSE_CHOOSE_ITEM_TYPE.TASK_ORNAMENT_AWARD] = "refresh_task_ornament_award_data"
}
local CONFIRM_FUNC_NAME = {
  [CURSE_CHOOSE_ITEM_TYPE.ABILITY] = "on_confirm_select_ability",
  [CURSE_CHOOSE_ITEM_TYPE.ORNAMENT] = "on_confirm_select_ornament",
  [CURSE_CHOOSE_ITEM_TYPE.BUFF_ABILITY] = "on_confirm_select_buff_ability",
  [CURSE_CHOOSE_ITEM_TYPE.BUFF_ORNAMENT] = "on_confirm_select_buff_ornament",
  [CURSE_CHOOSE_ITEM_TYPE.UPDAGRADE_ABILITY] = "on_confirm_updagrade_ability",
  [CURSE_CHOOSE_ITEM_TYPE.TASK_ABILITY_AWARD] = "on_confirm_task_ability_award",
  [CURSE_CHOOSE_ITEM_TYPE.OPTION_ABILITY] = "on_confirm_option_ability",
  [CURSE_CHOOSE_ITEM_TYPE.OPTION_ORNAMENT] = "on_confirm_option_ornament",
  [CURSE_CHOOSE_ITEM_TYPE.MINI_GAME_ORNAMENT] = "on_confirm_drop_ornament",
  [CURSE_CHOOSE_ITEM_TYPE.TASK_ORNAMENT_AWARD] = "on_confirm_task_ornament_award"
}
local enough_color = Util.CommonColor_White
local not_enough_color = Util.CommonColor_RedWarm

function ui:ui_finish_load()
  self:set_button("BtnChoose", function()
    self:on_click_select_button()
  end)
  self:set_button("BtnRefresh", function()
    self:on_click_refresh_btn()
  end)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, asset_bar_config)
  self:register_exist_auto_template(CHOOSE_ABILITY_TEM, self.v_uiobjects.DropTem, self.v_uiobjects.DropList)
  self:register_exist_auto_template(CHOOSE_ORNAMENT_TEM, self.v_uiobjects.OrnTem, self.v_uiobjects.DropList)
  self.v_choose_ability_item_list = {}
  self.v_choose_ornament_item_list = {}
end

function ui:ui_on_show(data, data_type, cb)
  self:set_opeartion_lock(nil)
  self.v_ability_refresh_cnt = 0
  self.v_asset_bar:on_create()
  self.v_cb = cb
  if not data then
    data = ChallengeRingPlusMgr:drop_award_data_dequeue()
    data_type = data.data_type
  end
  self:refresh(data, data_type, true)
end

function ui:ui_on_hide()
  self:clear_all_choose_item()
  if self.v_cb then
    self.v_cb()
    self.v_cb = nil
  end
  self.v_data = nil
  self.v_data_type = nil
  if self.v_hide_timer then
    Timer:remove_timer(self.v_hide_timer)
    self.v_hide_timer = nil
  end
  if self.v_show_scene_skill_lv_up_tips then
    local scene_skill_data = TowerMgr:get_scene_skill_data()
    UIMgr:get_ui("scene_skill_lv_up_tips"):ui_show(scene_skill_data)
    self.v_show_scene_skill_lv_up_tips = false
  end
  self.v_asset_bar:on_hide()
  local cur_show_ui = UIMgr:get_cur_show_ui()
  if cur_show_ui and cur_show_ui:ui_get_name() == "fate_book_event_card" then
    cur_show_ui:after_confirm_select_option()
  end
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:refresh(data, data_type, init_show)
  self:set_opeartion_lock(nil)
  self.v_select_ability_index = nil
  self.v_select_ability_id = nil
  self.v_select_ornament_index = nil
  self.v_select_ornament_id = nil
  self.v_data = data
  self.v_data_type = data_type
  self.v_uicompents.InPd_pd:ResetPD()
  self.v_uicompents.InPd_pd:Play()
  self:clear_all_choose_item()
  Global.sound_mgr:play_common_sound("Sound_getskill_fresh")
  if REFRESH_FUNC_NAME[data_type] then
    self[REFRESH_FUNC_NAME[data_type]](self, init_show)
  end
end

function ui:_refresh_ability_data(ability_list, init_show, titel_str, drop_id, can_refresh)
  self:refresh_drop_ability(ability_list)
  local refresh_count = 0
  local max_count = 0
  local cost_count = 0
  local cur_count = 0
  local is_enough = true
  if drop_id then
    local drop_cfg = ShareRes.get_ability_drop_cfg(drop_id)
    if drop_cfg then
      local add_count, add_refresh_count = 0, 0
      if self.v_data_type == CURSE_CHOOSE_ITEM_TYPE.ABILITY then
        local buff_type_map = BuffMgr:get_buff_type_map(Config.CommonDefine.BUFF_TYPE.ABILITY_DROP_DISCOUNT)
        if buff_type_map then
          for _, buff in pairs(buff_type_map) do
            add_count = add_count + buff.buff_cfg.Arg[1]
          end
        end
        add_refresh_count = add_count - self:get_ability_discount_refresh()
      end
      refresh_count = self:get_can_refresh_count() + add_refresh_count
      max_count = drop_cfg.RefreshCnt + add_count
      cost_count = self:get_final_cost_count(drop_cfg.CostCount)
      cur_count = BagMgr:get_item_num(drop_cfg.CostItem)
      is_enough = Util.check_item_cost_enough(drop_cfg.CostItem, cost_count)
    end
    self.v_uicompents.GoldNow_txt.color = is_enough and enough_color or not_enough_color
    self.v_uicompents.GoldNow_txt.text = math.floor(cur_count)
    self.v_uicompents.GoldNeed_txt.text = math.floor(cost_count)
    self.v_uicompents.Tips_txt.text = drop_cfg.DropTips
  end
  if titel_str then
    self.v_uicompents.Tips_txt.text = titel_str
  end
  if nil == can_refresh then
    can_refresh = refresh_count < max_count
  end
  self:update_refresh_count(init_show, max_count, refresh_count, can_refresh)
end

function ui:refresh_drop_ability_data(init_show)
  local ability_list = self.v_data.ability_drop_data.ability_drop
  local drop_id = self.v_data.ability_drop_data.drop_id
  self:_refresh_ability_data(ability_list, init_show, nil, drop_id)
end

function ui:refresh_buff_ability_data(init_show)
  local ability_list = self.v_data.ability_drop_data.ability_drop
  local drop_id = self.v_data.ability_drop_data.drop_id
  self:_refresh_ability_data(ability_list, init_show, nil, drop_id)
end

function ui:refresh_updagrade_ability_data(init_show)
  local ability_list = self.v_data.ability_drop
  self:_refresh_ability_data(ability_list, init_show, "片语升级")
end

function ui:refresh_task_ability_award_data(init_show)
  local ability_list = self.v_data.ability_drop_data.ability_drop
  local drop_id = self.v_data.ability_drop_data.drop_id
  self:_refresh_ability_data(ability_list, init_show, nil, drop_id)
end

function ui:refresh_option_ability_data(init_show)
  local ability_list = self.v_data.ability_drop_data.ability_drop
  local drop_id = self.v_data.ability_drop_data.drop_id
  self:_refresh_ability_data(ability_list, init_show, nil, drop_id)
end

function ui:refresh_drop_ability(ability_list)
  for key, ability_data in pairs(ability_list) do
    local ability_id = ability_data.id
    local obj = self:get_auto_cache(CHOOSE_ABILITY_TEM)
    self.v_choose_ability_item_list[ability_id] = DROP_ABILITY_ITEM_CLASS:ui_wrap(self, obj, true)
    self.v_choose_ability_item_list[ability_id]:set_data(ability_id, key, true, false, ability_data.grade, nil, self.v_data_type)
  end
end

function ui:refresh_ornament_data(init_show)
  self:refresh_ornament(self.v_data.recuperate_data.ornaments_drop_data.choose_ornamets)
  self.v_uiobjects.BtnRefresh:SetActive(false)
  self.v_uicompents.Tips_txt.text = Util.format_str("获得奇珍")
end

function ui:refresh_buff_ornament_data(init_show)
  self:refresh_ornament(self.v_data.choose_ornamets)
  self.v_uiobjects.BtnRefresh:SetActive(false)
  self.v_uicompents.Tips_txt.text = Util.format_str("获得奇珍")
end

function ui:refresh_option_ornament_data(init_show)
  self:refresh_ornament(self.v_data.ornaments_drop_data.choose_ornamets)
  self.v_uiobjects.BtnRefresh:SetActive(false)
  self.v_uicompents.Tips_txt.text = Util.format_str("获得奇珍")
end

function ui:refresh_task_ornament_award_data(init_show)
  self:refresh_ornament(self.v_data.ornaments_drop_data.choose_ornamets)
  self.v_uiobjects.BtnRefresh:SetActive(false)
  self.v_uicompents.Tips_txt.text = Util.format_str("获得奇珍")
end

function ui:refresh_ornament(ornament_datas)
  for key, ornament_data in pairs(ornament_datas) do
    local ornament_id = ornament_data.ornamets_id
    local obj = self:get_auto_cache(CHOOSE_ORNAMENT_TEM)
    self.v_choose_ornament_item_list[ornament_id] = ORN_VIEW_ITEM:ui_wrap(self, obj, true, true)
    local tog = self.v_choose_ornament_item_list[ornament_id]:set_data(ornament_id, true, ornament_data.index)
  end
end

function ui:update_refresh_count(init_show, max_count, refresh_count, can_refresh)
  local can_refresh_count = max_count - refresh_count
  if init_show then
    if can_refresh then
      self.v_uicompents.LimitNow_txt.text = can_refresh_count
      self.v_uicompents.LimitMax_txt.text = max_count
      self.v_uiobjects.BtnRefresh:SetActive(true)
    else
      self.v_uiobjects.BtnRefresh:SetActive(false)
    end
  else
    self.v_uicompents.LimitMax_txt.text = max_count
    if can_refresh then
      self.v_uicompents.LimitNow_txt.text = can_refresh_count
      self.v_uiobjects.BtnRefresh:SetActive(true)
    else
      self.v_uicompents.LimitNow_txt.text = "<color=#e0212c>" .. 0 .. "</color>"
    end
  end
end

function ui:check_can_refresh(show_tips)
  local drop_id = self.v_data.ability_drop_data.drop_id
  if Util.is_more_than_zero(drop_id) then
    local cfg = ShareRes.get_ability_drop_cfg(drop_id)
    if cfg then
      local can_refresh = cfg.RefreshCnt > self:get_can_refresh_count()
      if show_tips and not can_refresh then
        Util.show_message_tip(2287)
      end
      return can_refresh, cfg
    end
  end
  return false
end

function ui:buff_check_can_refresh(drop_id, show_tips)
  local uuid = self.v_data.uuid
  local buff = BuffMgr:get_buff_by_uuid(uuid)
  if not drop_id and buff then
    drop_id = buff.buff_cfg.Arg[1]
  end
  if Util.is_more_than_zero(drop_id) then
    local cfg = ShareRes.get_ability_drop_cfg(drop_id)
    if cfg then
      local can_refresh = cfg.RefreshCnt > self:get_can_refresh_count()
      if show_tips and not can_refresh then
        Util.show_message_tip(2287)
      end
      return can_refresh, cfg
    end
  end
  return false
end

function ui:get_can_refresh_count()
  return self.v_data.ability_drop_data.ability_refresh_cnt or self.v_ability_refresh_cnt or 0
end

function ui:get_ability_discount_refresh()
  return self.v_data.ability_drop_data.discount_refresh
end

function ui:get_ability_discount_value()
  return self.v_data.ability_drop_data.discount_value
end

function ui:on_select_drop_ability(index, ability_id)
  self.v_select_ability_index = index
  self.v_select_ability_id = ability_id
end

function ui:on_select_ornament(index, ornament_id)
  self.v_select_ornament_index = index
  self.v_select_ornament_id = ornament_id
end

function ui:on_click_select_button()
  if self.v_opeartion_lock then
    return
  end
  if not (self.v_select_ornament_index or self.v_select_ability_index) or self:is_in_hide_timer() then
    return
  end
  self:set_opeartion_lock(true)
  if CONFIRM_FUNC_NAME[self.v_data_type] then
    self[CONFIRM_FUNC_NAME[self.v_data_type]](self)
  end
end

function ui:on_confirm_updagrade_ability()
  if not self.v_select_ability_index or self.v_hide_timer then
    return
  end
  
  local function cb()
    self.v_hide_timer = Timer:add_timer(nil, self.v_uicompents.OutPd_pd.duration, function()
      self:ui_hide()
    end)
  end
  
  GenresMgr:request_upgrade_ability(self.v_data.id, self.v_select_ability_index, cb)
end

function ui:on_confirm_task_ability_award()
  if not self.v_select_ability_index or self.v_hide_timer then
    return
  end
  
  local function cb()
    self:after_select_ability()
  end
  
  ChallengeRingPlusMgr:get_curse_task_award(self.v_data.id, nil, nil, self.v_select_ability_index, nil, cb)
end

function ui:on_confirm_task_ornament_award()
  if not self.v_select_ornament_index or self.v_hide_timer then
    return
  end
  
  local function cb()
    self:after_select_ornament()
  end
  
  ChallengeRingPlusMgr:get_curse_task_award(self.v_data.id, nil, nil, nil, self.v_select_ornament_index, cb)
end

function ui:on_confirm_option_ability()
  if not self.v_select_ability_index or self.v_hide_timer then
    return
  end
  
  local function cb(resp)
    local data
    if resp.ability_drop_data and not UtilTable.is_empty(resp.ability_drop_data.ability_drop) then
      data = resp
    end
    self:after_select_ability(data, CURSE_CHOOSE_ITEM_TYPE.OPTION_ABILITY)
  end
  
  local uuid = self.v_data and self.v_data.uuid
  GenresMgr:request_choose_options_ability(self.v_select_ability_index, uuid, cb)
end

function ui:on_confirm_option_ornament()
  if not self.v_select_ornament_index or self.v_hide_timer then
    return
  end
  
  local function cb()
    self:after_select_ornament()
  end
  
  local uuid = self.v_data and self.v_data.uuid
  BattleOrnamentMgr:request_choose_options_ornaments(self.v_select_ornament_index, uuid, cb)
end

function ui:on_confirm_drop_ornament()
  if not self.v_select_ornament_index or self.v_hide_timer then
    return
  end
  
  local function cb()
    self:after_select_ornament()
  end
  
  local uuid = self.v_data and self.v_data.uuid
  BattleOrnamentMgr:select_drop_ornament(self.v_select_ornament_index, uuid, cb)
end

function ui:on_confirm_select_ornament()
  if not self.v_select_ornament_index or self.v_hide_timer then
    return
  end
  local data = self.v_data
  if not ChallengeRingPlusMgr:check_can_pay_recuperation_card(data.pay_type, data.recuperate_cfg, true) then
    return
  end
  
  local function cb()
    self.v_hide_timer = Timer:add_timer(nil, self.v_uicompents.OutPd_pd.duration, function()
      self:ui_hide()
    end)
  end
  
  local use_curse_value = data.pay_type == Config.PAY_COSE_TYPE.USE_CUESE
  local recuperate_data = data.recuperate_data
  BattleOrnamentMgr:request_choose_ornament(recuperate_data.id, self.v_select_ornament_index, use_curse_value, cb)
end

function ui:on_confirm_select_buff_ornament()
  if not self.v_select_ornament_index or self.v_hide_timer then
    return
  end
  
  local function cb()
    self.v_hide_timer = Timer:add_timer(nil, self.v_uicompents.OutPd_pd.duration, function()
      self:ui_hide()
    end)
  end
  
  local uuid = self.v_data.uuid
  BattleOrnamentMgr:request_buff_choose_ornament(uuid, self.v_select_ornament_index, cb)
end

function ui:on_confirm_select_ability()
  if not self.v_select_ability_index or self.v_hide_timer then
    return
  end
  
  local function cb()
    self:after_select_ability()
  end
  
  self:set_opeartion_lock(true)
  GenresMgr:select_drop_ability(self.v_select_ability_index, self.v_data and self.v_data.uuid, cb)
end

function ui:on_confirm_select_buff_ability()
  if not self.v_select_ability_index or self.v_hide_timer then
    return
  end
  local uuid = self.v_data.uuid
  
  local function cb()
    self:after_select_ability()
  end
  
  GenresMgr:select_buff_ability(uuid, self.v_select_ability_index, cb)
end

function ui:after_select_ability()
  self.v_uicompents.OutPd_pd:ResetPD()
  self.v_uicompents.OutPd_pd:Play()
  if self.v_select_ability_id then
    self.v_choose_ability_item_list[self.v_select_ability_id]:on_confirm_select_ability()
  end
  self.v_ability_refresh_cnt = 0
  self.v_hide_timer = Timer:add_timer(nil, self.v_uicompents.OutPd_pd.duration, function()
    local data = ChallengeRingPlusMgr:drop_award_data_dequeue()
    if data then
      local data_type = data.data_type
      self:refresh(data, data_type)
    else
      self:ui_hide()
    end
    self.v_hide_timer = nil
  end)
end

function ui:after_select_ornament()
  self.v_uicompents.OutPd_pd:ResetPD()
  self.v_uicompents.OutPd_pd:Play()
  self.v_choose_ornament_item_list[self.v_select_ornament_id]:on_select_ornament()
  self.v_hide_timer = Timer:add_timer(nil, self.v_uicompents.OutPd_pd.duration, function()
    local data = ChallengeRingPlusMgr:drop_award_data_dequeue()
    if data then
      local data_type = data.data_type
      self:refresh(data, data_type)
    else
      self:ui_hide()
    end
    self.v_hide_timer = nil
  end)
end

function ui:on_click_refresh_btn()
  if self:is_in_hide_timer() then
    return
  end
  if self.v_opeartion_lock then
    return
  end
  if self.v_data_type == CURSE_CHOOSE_ITEM_TYPE.ABILITY then
    self:update_drop_ability_refresh()
  elseif self.v_data_type == CURSE_CHOOSE_ITEM_TYPE.BUFF_ABILITY then
    self:update_buff_ability_refresh()
  elseif self.v_data_type == CURSE_CHOOSE_ITEM_TYPE.TASK_ABILITY_AWARD then
    self:update_task_ability_refresh()
  end
end

function ui:update_task_ability_refresh()
  local can_refresh, drop_cfg = self:check_can_refresh(true)
  if not can_refresh or not drop_cfg then
    return
  end
  local cost_count = self:get_final_cost_count(drop_cfg.CostCount)
  if drop_cfg.CostItem and drop_cfg.CostItem > 0 and not Util.check_item_cost_enough(drop_cfg.CostItem, cost_count) then
    Util.show_message_tip(2314, UtilUI.get_item_name(drop_cfg.CostItem))
    return
  end
  
  local function cb(data)
    self.v_ability_refresh_cnt = self.v_ability_refresh_cnt + 1
    if data then
      self:refresh(data, data.data_type)
    end
  end
  
  local task_id = self.v_data.id
  GenresMgr:refresh_task_ability_drop(task_id, cb)
end

function ui:update_buff_ability_refresh()
  local can_refresh, drop_cfg = self:buff_check_can_refresh(nil, true)
  if not can_refresh or not drop_cfg then
    return
  end
  local cost_count = self:get_final_cost_count(drop_cfg.CostCount)
  if drop_cfg.CostItem and drop_cfg.CostItem > 0 and not Util.check_item_cost_enough(drop_cfg.CostItem, cost_count) then
    Util.show_message_tip(2314, UtilUI.get_item_name(drop_cfg.CostItem))
    return
  end
  local uuid = self.v_data.uuid
  
  local function cb(resp)
    self.v_ability_refresh_cnt = self.v_ability_refresh_cnt + 1
    if resp then
      local data = resp
      data.uuid = uuid
      self:refresh(data, CURSE_CHOOSE_ITEM_TYPE.BUFF_ABILITY)
    end
  end
  
  GenresMgr:refresh_buff_ability(uuid, cb)
end

function ui:update_drop_ability_refresh()
  local drop_id = self.v_data.ability_drop_data.drop_id
  local drop_cfg = ShareRes.create("activity.ability_drop", drop_id)
  self.v_uicompents.Tips_txt.text = drop_cfg.DropTips
  if not self:check_can_refresh(true) then
    return
  end
  local cost_count = self:get_final_cost_count(drop_cfg.CostCount)
  if drop_cfg.CostItem and drop_cfg.CostItem > 0 and not Util.check_item_cost_enough(drop_cfg.CostItem, cost_count) then
    Util.show_message_tip(2314, UtilUI.get_item_name(drop_cfg.CostItem))
    return
  end
  
  local function cb(data)
    if data then
      self:refresh(data, CURSE_CHOOSE_ITEM_TYPE.ABILITY)
    end
  end
  
  GenresMgr:refresh_drop_ability(cb)
end

function ui:set_show_scene_skill_lv_up_tips()
  self.v_show_scene_skill_lv_up_tips = true
end

function ui:get_final_cost_count(cur_cost_count)
  local discount_refresh = self:get_ability_discount_refresh()
  local discount_value = self:get_ability_discount_value()
  discount_value = 0 ~= discount_refresh and (discount_value or 1) or 1
  return ChallengeRingPlusMgr:get_after_discount_price(cur_cost_count * discount_value)
end

function ui:clear_all_choose_item()
  self:give_back_auto_cache(CHOOSE_ABILITY_TEM)
  self:give_back_auto_cache(CHOOSE_ORNAMENT_TEM)
  for key, item in pairs(self.v_choose_ability_item_list) do
    item:ui_hide()
    item:ui_destroy()
  end
  for key, item in pairs(self.v_choose_ornament_item_list) do
    item:ui_hide()
    item:ui_destroy()
  end
end

function ui:get_award_type()
  return self.v_data_type
end

function ui:is_in_hide_timer()
  return self.v_hide_timer ~= nil
end

function ui:stop_hiding_and_restore()
  local data = ChallengeRingPlusMgr:drop_award_data_dequeue()
  self:refresh(data, data.data_type, true)
end

function ui:set_opeartion_lock(opeartion_lock)
  self.v_opeartion_lock = opeartion_lock
end

return ui
