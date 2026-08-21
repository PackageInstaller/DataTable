local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local EFFECT_NAME = "Effect"
local COLOR_NO_PROTECT = UnityEngine.Color(0.47058823529411764, 0.6196078431372549, 0.9254901960784314, 0.4980392156862745)
local COLOR_PROTECT = UnityEngine.Color(0.47058823529411764, 0.6196078431372549, 0.9254901960784314, 1)
local WEEKLY_CFG = require("gamelogic.weekly.weekly_config")
local END_STR = "活动已结束"
local CLOSE_STR = "活动未开启"
local TIPS_ADD_RATIO_STR = "（%s%%）"
local SHOW_CURRENCY = WEEKLY_CFG.SHOW_CURRENCY
local HURDLE_ITEM = require("uimodule.weekly.weekly_pvp_hurdle_item")
local WEEKLY_PVP_TEAM_ITEM_KEY = "WEEKLY_PVP_TEAM_ITEM_KEY"
local CommonDefine = require("cs_share.common_define")

function ui:init_effect_obj()
  self.v_effect_obj_map = {}
  local all_cfg = ShareRes.create("buddy.buddy_element")
  local effect_name, effect_obj
  for key, cfg in pairs(all_cfg) do
    effect_name = EFFECT_NAME .. cfg.Id
    if self.v_uiobjects[effect_name] then
      effect_obj = self.v_uiobjects[effect_name]
      self.v_effect_obj_map[cfg.Id] = self.v_effect_obj_map[cfg.Id] or {}
      table.insert(self.v_effect_obj_map[cfg.Id], effect_obj)
    end
  end
end

function ui:ui_finish_load()
  self:init_effect_obj()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnMain", function()
    UIMgr:go_to_main()
  end)
  self:set_button("BtnShop", function()
    local main_cfg = ShareRes.get_weekly_pvp_activity_cfg()
    if Util.is_more_than_zero(main_cfg.ShopId) then
      SysOpenMgr:jump_to_sys(main_cfg.ShopId, true)
    end
  end)
  self:set_button("BtnStageList", function()
    self:click_stage_list_btn()
  end)
  self:set_button("BtnStageList", function()
    self:click_stage_list_btn()
  end)
  self:set_button("BtnRule", function()
    self:click_stage_rule_btn()
  end)
  self:set_button("BtnStarTask", function()
    self:click_award_des_btn()
  end)
  for i = 1, 2 do
    self:set_button("Stage" .. i, function()
      self:click_stage_btn(i)
    end)
  end
  self:set_button("StageSingle", function()
    self:click_stage_btn(1)
  end)
  self.v_wrap_list = {}
  self.v_template_key = "current_item" .. self:ui_get_name()
  self:register_exist_auto_template(self.v_template_key, self.v_uiobjects.Asset_Item, self.v_uiobjects.AssetBar)
  self:register_exist_auto_template(WEEKLY_PVP_TEAM_ITEM_KEY, self.v_uiobjects.CharTem, self.v_uiobjects.CharListTemp)
end

function ui:click_top_rank_btn()
  UIMgr:get_ui("weekly_pvp_top_rank"):ui_show()
end

function ui:on_btn_difficulty_click()
end

function ui:click_award_des_btn()
  UIMgr:get_ui("weekly_pvp_star_award"):ui_show()
end

function ui:click_stage_list_btn()
  UIMgr:get_ui("weekly_select"):ui_show()
end

function ui:click_stage_rule_btn()
  UIMgr:get_ui("weekly_rule"):ui_show(true)
end

function ui:ui_on_update()
  self:update_stage_end_time()
end

function ui:cache_ui()
  return true
end

function ui:ui_on_show()
  WeeklyMgr:set_battle_type(2)
  self:bind_auto_mq(Const.MSG_ON_WEEKLY_PVP_SCORE_RESET, self.on_pvp_score_reset, self)
  self:bind_auto_mq(Const.MSG_ON_WEEKLY_UPDATE_PVP_SEGMENT, self.update_player_data, self)
  self:bind_auto_mq(Const.MSG_ON_WEEKLY_PVP_SETLMENT, self.update_player_data, self)
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self._refresh_currency_list, self)
  self:bind_auto_mq(Const.MSG_ON_WEEKLY_PVP_AWARD_GET, self.refresh_star_red, self)
  self.pvp_activity_config = ShareRes.get_weekly_pvp_activity_cfg()
  local state = WeeklyMgr:get_weekly_pvp_player_state()
  if state == CommonDefine.WEEK_ACTY_PLAYER_PVP_STATE.NOT_IN_PARTICIPATE then
    WeeklyMgr:request_change_weekly_pvp_difficulty(nil)
  elseif state == CommonDefine.WEEK_ACTY_PLAYER_PVP_STATE.NOT_IN_PARTICIPATE_CHOOSE_SEGMENT then
    self:on_btn_difficulty_click()
  else
    self:update_player_data()
  end
  self:check_is_new_season()
end

function ui:check_is_new_season()
  local is_new_season = WeeklyMgr:get_is_new_season()
  if is_new_season then
    UIMgr:get_ui("weekly_new_season"):ui_show()
    WeeklyMgr:set_week_new_season_read(2)
  end
  WeeklyMgr:set_weekly_reset_finish()
end

function ui:update_player_data()
  local pvp_player_data = WeeklyMgr:get_player_pvp_data()
  if self.v_pvp_player_data and pvp_player_data.periods > self.v_pvp_player_data.periods then
    local function confirmCb()
      UIMgr:go_to_main()
    end
    
    UIMgr:get_ui("uinotice_tips"):ui_show(confirmCb, nil, "当前活动已结束，请返回主界面", nil, nil, nil, true)
  end
  self.v_pvp_player_data = pvp_player_data
  self:refresh_curr_star()
  self:give_back_auto_cache(self.v_template_key)
  self.v_currency_list = {}
  self:_refresh_currency_list()
  self:update_stage_end_time()
  self:update_hurdle_view()
  self:refresh_add_ratio()
  self:refresh_star_red()
end

function ui:ui_on_hide()
  self:remove_wrap_list()
end

function ui:refresh_add_ratio()
  local add_ratio = (WeeklyMgr:get_cur_pvp_add_ratio() or 0) / 100
  local tips_add_ratio_str = string.format(TIPS_ADD_RATIO_STR, add_ratio)
  self.v_uicompents.AdditionNum_txt.text = tips_add_ratio_str
end

function ui:_refresh_currency_list()
  for _, id in pairs(SHOW_CURRENCY) do
    if not self.v_currency_list[id] then
      local obj = self:get_auto_cache(self.v_template_key)
      self.v_currency_list[id] = obj
      local btn = Util.get_button("AddBtn", obj)
      self:set_button_listener(btn, function()
        UIMgr:get_ui("itemTip"):ui_show({item_id = id})
      end)
    end
    self:_set_currency(self.v_currency_list[id], id)
  end
end

function ui:_set_currency(obj, id)
  if nil == obj then
    Log.Error("获取货币item对象失败！！！")
    return
  end
  local cfg = ShareRes.get_item_cfg(id)
  if not cfg then
    return
  end
  obj:SetActiveEx(true)
  local moneyIcon = self:get_image("Label", obj)
  local path = UtilUI.get_item_icon(id)
  ResMgr:load_set_icon(moneyIcon, path)
  local moneyNum = self:get_text("Aomunt", obj)
  local item_num = BagMgr:get_item_num(id)
  moneyNum.text = item_num
end

function ui:refresh_curr_star()
  local star = WeeklyMgr:get_pvp_curr_star()
  local total_star = WeeklyMgr:get_pvp_total_star()
  self.v_uicompents.StarNow_txt.text = star
  self.v_uicompents.StarMax_txt.text = total_star
end

function ui:update_stage_end_time()
  local stage_end_time = WeeklyMgr:get_pvp_remaining_time()
  local str
  if stage_end_time < 0 then
    local is_open = WeeklyMgr:check_weekly_pvp_opn()
    str = is_open and END_STR or CLOSE_STR
  else
    str = Date.get_time_desc(stage_end_time)
  end
  self.v_uicompents.Time_txt.text = str
end

function ui:update_hurdle_view()
  self:remove_wrap_list()
  self:give_back_auto_cache(WEEKLY_PVP_TEAM_ITEM_KEY)
  local stage_data = WeeklyMgr:get_stage_data()
  if not stage_data then
    return
  end
  local count = #stage_data
  if 1 == count then
    self.v_uiobjects.StageNumber1:SetActive(true)
    self.v_uiobjects.StageNumber2:SetActive(false)
    self:create_hurdle_item(stage_data[1], self.v_uiobjects.StageSingle, true, stage_data[1].epi_stage)
  elseif 2 == count then
    self.v_uiobjects.StageNumber1:SetActive(false)
    self.v_uiobjects.StageNumber2:SetActive(true)
    self:create_hurdle_item(stage_data[1], self.v_uiobjects.Stage1, false, stage_data[1].epi_stage)
    self:create_hurdle_item(stage_data[2], self.v_uiobjects.Stage2, true, stage_data[2].epi_stage)
  end
end

function ui:create_hurdle_item(hurdle_data, hurdle_obj, is_right, stage)
  if not self.v_wrap_list[stage] then
    hurdle_obj:SetActive(true)
    local item_lua_obj = HURDLE_ITEM:ui_wrap_ex(self, hurdle_obj, true)
    item_lua_obj:set_data(hurdle_data, is_right, stage)
    table.insert(self.v_wrap_list, item_lua_obj)
  end
end

function ui:get_team_buddy_item()
  local item = self:get_auto_cache(WEEKLY_PVP_TEAM_ITEM_KEY)
  return item
end

function ui:click_stage_btn(i)
  if WeeklyMgr:check_pvp_end() then
    Util.show_message_tip(2096)
    return
  end
  if not self.v_wrap_list[i] then
    return
  end
  self.v_wrap_list[i]:click_effect()
end

function ui:remove_wrap_list()
  for key, obj in pairs(self.v_wrap_list) do
    obj:ui_hide()
    self:remove_wrap_ui(obj)
    self.v_wrap_list[key] = nil
  end
end

function ui:on_pvp_score_reset(msg)
  self:refresh_curr_star()
  self:update_hurdle_view()
  self:refresh_add_ratio()
end

function ui:get_effect_obj(element_id)
  if self.v_effect_obj_map[element_id] then
    local obj, effect_objs
    effect_objs = self.v_effect_obj_map[element_id]
    local length = #effect_objs
    if length > 0 then
      obj = effect_objs[length]
      effect_objs[length] = nil
    else
      local effect_name = EFFECT_NAME .. element_id
      if self.v_uiobjects[effect_name] then
        obj = UnityGameObject.Instantiate(self.v_uiobjects[effect_name])
      end
    end
    return obj
  end
end

function ui:give_back_effect_obj(element_id, obj)
  if self.v_effect_obj_map[element_id] then
    table.insert(self.v_effect_obj_map[element_id], obj)
    obj.transform:SetParent(self.v_uiobjects.EffectRoot.transform)
  end
end

function ui:refresh_star_red()
  local is_can_get_star_award = WeeklyMgr:get_star_award_red_state()
  self.v_uiobjects.StarRedPoint:SetActive(is_can_get_star_award)
end

return ui
