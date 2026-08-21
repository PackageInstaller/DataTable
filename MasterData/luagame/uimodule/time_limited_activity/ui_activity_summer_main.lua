local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local AssetBarView = require("ui.asset_bar.asset_bar")
local Shop_Helper = require("uimodule.shop.shop_helper")

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("JumpBtn", function()
    self:open_shop()
  end)
  self:set_button("MainSkinBtn", function()
    self:jump_to_fashion_panel()
  end)
  self:set_button("WeaponSkinBtn", function()
    self:jump_to_weapon_panel()
  end)
  self.v_btn_objs = {
    [1] = self.v_uiobjects.GameTem1,
    [2] = self.v_uiobjects.GameTem2,
    [3] = self.v_uiobjects.GameTem3,
    [4] = self.v_uiobjects.GameTem4
  }
  self.v_btn_coms = {
    [1] = self.v_uicompents.GameTem1_btn,
    [2] = self.v_uicompents.GameTem2_btn,
    [3] = self.v_uicompents.GameTem3_btn,
    [4] = self.v_uicompents.GameTem4_btn
  }
  for i = 1, #self.v_btn_objs do
    local red = Util.get_child_gameobj("UnLockObj_/redpoint_", self.v_btn_objs[i])
    RedPointMgr:bind_redpoint(self, red, TimeLimitedActMgr.summer_red_list[i])
  end
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
end

function ui:ui_on_show(activity_id)
  activity_id = activity_id or TimeLimitedActMgr:get_summer_activity_id()
  self.v_activity_id = activity_id
  local is_active = NoviceMgr:get_novice_activity_active(activity_id)
  if is_active then
    self.v_activities_detail_cfg = TimeLimitedActMgr:get_version_child_activities_detail_cfg(self.v_activity_id)
    if self.v_activities_detail_cfg then
      self:refresh()
    end
  else
    UIMgr:go_to_main()
    return
  end
  self.v_shop_activity_id = tonumber(self.v_shop_activity_cfg.Param[1])
  self.v_shop_id = tonumber(self.v_shop_activity_cfg.Param[2])
  self:refresh_asset_bar()
  self:refresh_shop_buy_progress()
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
  self:bind_auto_mq(Const.ON_VERSION_ACTIVITY_UPDATE, self.on_version_activity_update, self)
end

function ui:open_shop()
  UIMgr:get_ui("ui_activity_summer_shop"):ui_show(self.v_shop_activity_id, self.v_shop_id)
end

function ui:jump_to_fashion_panel()
  UIMgr:get_ui("itemTip"):ui_show({item_id = 50020001})
end

function ui:jump_to_weapon_panel()
  UIMgr:get_ui("itemTip"):ui_show({item_id = 50012601})
end

function ui:refresh_asset_bar()
  local data = ShareRes.create("shop.exchange_shop")
  self.v_cur_shop_data = data[self.v_shop_id]
  self.v_cur_shop_type = self.v_cur_shop_data.Type
  local key, value = next(self.v_cur_shop_data.ItemId)
  if 0 ~= value then
    local list = Shop_Helper.get_asset_list(self.v_cur_shop_data.ItemId)
    self.v_asset_bar:reset_config(list)
  else
    self.v_asset_bar:reset_config()
  end
  self.v_asset_bar:on_create()
end

function ui:refresh_shop_buy_progress()
  local cost, total = ShopMgr:get_shop_limit_currency(self.v_shop_id)
  local slider = Util.get_slider("UnLockObj_/ProgressBg/Slider_", self.v_uiobjects.GameTem4)
  slider.value = cost / total
  local value = math.floor(100 * cost / total)
  local num_txt = Util.get_text("UnLockObj_/ProgressBg/ProgressNum_", self.v_uiobjects.GameTem4)
  num_txt.text = Util.format_str("{1}%", value)
end

function ui:refresh()
  self:clear_timer()
  self.v_timer_list = {}
  local activity_cfg = ShareRes.get_activity_cfg(self.v_activity_id)
  local remain_time = NoviceMgr:get_time_remaining(activity_cfg.TimeType, activity_cfg.StopTime, activity_cfg.OpenTime, activity_cfg.SustainTime)
  if remain_time then
    self.v_uicompents.Time_txt.text = Date.get_time_format_7(remain_time)
  end
  self:add_timer(0, remain_time, self.v_uicompents.Time_txt)
  for idx, obj in ipairs(self.v_btn_objs) do
    local cfg = self.v_activities_detail_cfg[idx]
    local is_open, tips, result3, result4, left_time = TimeLimitedActMgr:is_activity_open(cfg.Id)
    local unlockobj = Util.get_child_gameobj("UnLockObj_", obj)
    local lockobj = Util.get_child_gameobj("LockObj_", obj)
    unlockobj:SetActiveEx(is_open)
    if lockobj then
      lockobj:SetActiveEx(not is_open)
    end
    local text
    if is_open then
      text = Util.get_text("Time/ActivityTime_", unlockobj)
      text.text = tips
    else
      text = Util.get_text("UnlockTime/UnlockTime_", lockobj)
      text.text = tips
    end
    if cfg.Type == TimeLimitedActMgr.Type.SummerShop then
      self.v_shop_activity_cfg = cfg
    end
    self:add_timer(idx, left_time, text)
    self:set_button_listener(self.v_btn_coms[idx], function()
      self:on_click_btn(idx)
    end)
  end
end

function ui:on_click_btn(index)
  local cfg = self.v_activities_detail_cfg[index]
  if cfg and cfg.Type == TimeLimitedActMgr.Type.SummerFight and not Util.get_res_is_integrity() then
    return
  end
  local fun = TimeLimitedActMgr:get_btn_jump_fun(cfg.Type)
  local is_open, tips, is_time_check_fail, open_time_tip = TimeLimitedActMgr:is_activity_open(cfg.Id)
  if is_open then
    fun(cfg.Param)
    TimeLimitedActMgr:storage_click_state(cfg.Id)
  elseif is_time_check_fail then
    Util.show_message_tip(open_time_tip .. "解锁")
  else
    Util.show_message_tip(tips)
  end
end

function ui:add_timer(index, left_time, text)
  if not left_time or left_time <= 0 then
    text.text = ""
    return
  end
  local timer = Global.ct_timer:add_timer("ui_summer_main_timer" .. index, left_time, function(result_time)
    text.text = Date.get_time_format_7(result_time)
    if result_time <= 0 then
      self:refresh()
    end
  end)
  table.insert(self.v_timer_list, timer)
end

function ui:clear_timer()
  if not self.v_timer_list then
    return
  end
  for _, timer in pairs(self.v_timer_list) do
    if timer then
      Global.ct_timer:remove_timer(timer)
    end
  end
  self.v_timer_list = nil
end

function ui:ui_on_hide()
  self.v_asset_bar:on_hide()
  self:clear_timer()
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_activity_id
end

function ui:check_close()
  local is_close = NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name)
  if not is_close then
    self:refresh()
  end
end

function ui:on_version_activity_update()
  local activity_detail_cfg_list = TimeLimitedActMgr:get_version_child_activities_detail_cfg(self.v_activity_id)
  if activity_detail_cfg_list then
    self:refresh()
  end
end

return ui
