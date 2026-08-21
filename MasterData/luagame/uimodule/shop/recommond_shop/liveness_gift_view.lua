local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local DAY_ITEM_OBJ_CLASS = require("uimodule.shop.recommond_shop.liveness_gift_award_item")
local commonDef = require("cs_share.common_define")
local CURSE_BOX_STATE = commonDef.CURSE_BOX_STATE

function ui:ui_finish_load()
  self:set_button("BtnGiftDetail", function()
    UIMgr:get_ui("info_tips"):ui_show(self.v_gift_cfg.IntroduceKey)
  end)
  self:set_button("DailyAward", function()
    self:on_click_get_free_award()
  end)
  self:set_button("BtnRecive", function()
    self:on_click_get_award()
  end)
  self:set_button("BtnBuy", function()
    self:on_click_buy()
  end)
end

function ui:on_click_get_free_award()
  local free_award_group_id = self.v_gift_cfg and self.v_gift_cfg.FreeAwardGroupId
  if free_award_group_id then
    local function recive_func()
      LivenessGiftMgr:req_get_free_award(self.v_id)
    end
    
    local data = LivenessGiftMgr:get_liveness_gift_data(self.v_id)
    local state
    if not data then
      state = CURSE_BOX_STATE.LOCK
    elseif data.can_gain_day_free_award then
      state = CURSE_BOX_STATE.FINISH
    else
      state = CURSE_BOX_STATE.GET_AWARD
    end
    UIMgr:get_ui("ui_award_tips_com"):ui_show(nil, free_award_group_id, state, recive_func)
  end
end

function ui:on_click_get_award()
  local data = LivenessGiftMgr:get_liveness_gift_data(self.v_id)
  if not data then
    return
  end
  local end_time = data and data.end_time or 0
  local not_buy = 0 == end_time
  local can_get = data.buyed_sign_day > data.buyed_gained_day
  if not_buy or not can_get then
    return
  end
  LivenessGiftMgr:req_get_award(self.v_id)
end

function ui:on_click_buy()
  local data = LivenessGiftMgr:get_liveness_gift_data(self.v_id)
  if not data then
    return
  end
  local end_time = data and data.end_time or 0
  if 0 ~= end_time then
    return
  end
  ScreenMaskMgr:open_one_tag(self.v_object.name, 1, false)
  RechargeMgr:request_buy_product(self.v_gift_cfg, function()
    ScreenMaskMgr:close_one_tag(self.v_object.name)
  end)
end

function ui:ui_on_show(id)
  self.v_id = id
  self.v_gift_cfg = ShareRes.get_liveness_gift_cfg(id)
  self.v_uicompents.Tips1_txt.text = self.v_gift_cfg.Tips1
  self.v_uicompents.Tips2_txt.text = self.v_gift_cfg.Tips2
  self.v_uicompents.CurrNum_txt.text = RechargeMgr:get_product_show_price_str(self.v_gift_cfg)
  self:bind_auto_mq(Const.MSG_ON_LIVENESS_GIFT_UPDATE, self.refresh_view, self)
  self:refresh_view()
end

function ui:refresh_view()
  self:refresh_timer()
  self:refresh_award()
  self:refresh_free_award()
  self:refresh_btn()
end

function ui:ui_on_hide()
  self:clear_wrap_day_items()
end

function ui:ui_on_update(dt)
  if not self.v_dt_cache then
    self.v_dt_cache = 0
  end
  self.v_dt_cache = self.v_dt_cache + dt
  if self.v_dt_cache > 2 then
    self.v_dt_cache = 0
    self:refresh_timer()
  end
end

function ui:refresh_timer()
  local data = LivenessGiftMgr:get_liveness_gift_data(self.v_id)
  local end_time = data and data.end_time or 0
  local not_buy = 0 == end_time
  self.v_uiobjects.BuyTime:SetActiveEx(not_buy)
  self.v_uiobjects.AwardTime:SetActiveEx(not not_buy)
  if not_buy then
    end_time = self.v_gift_cfg and Date.get_time_stamp_by_scheme_id(self.v_gift_cfg.ShowEndTime) or 0
  end
  local remain_second = end_time - Date.server_time()
  remain_second = remain_second > 0 and remain_second or 0
  local time_txt = not_buy and self.v_uicompents.BuyTimeNum_txt or self.v_uicompents.AwardTimeNum_txt
  time_txt.text = Date.get_time_format_7(remain_second)
end

function ui:refresh_award()
  local day_list = ShareRes.create("recharge.liveness_day_award", self.v_id)
  self:clear_wrap_day_items()
  self.v_wrap_day_items = {}
  for idx, day_cfg in ipairs(day_list) do
    local obj = self.v_uiobjects["Day" .. idx]
    local item = DAY_ITEM_OBJ_CLASS:ui_wrap_ex(self, obj, true)
    item:set_data(day_cfg, true, true)
    table.insert(self.v_wrap_day_items, item)
  end
end

function ui:clear_wrap_day_items()
  if self.v_wrap_day_items then
    for key, item in pairs(self.v_wrap_day_items) do
      item:ui_destroy()
      self.v_wrap_day_items[key] = nil
    end
    self.v_wrap_day_items = nil
  end
end

function ui:refresh_free_award()
  local free_award_group_id = self.v_gift_cfg and self.v_gift_cfg.FreeAwardGroupId
  self.v_uiobjects.DailyAward:SetActiveEx(nil ~= free_award_group_id)
  if not free_award_group_id then
    return
  end
  local data = LivenessGiftMgr:get_liveness_gift_data(self.v_id)
  if not data then
    self.v_uiobjects.DailyAward:SetActiveEx(false)
    return
  end
  local can_get = data.can_gain_day_free_award
  local free_award_times = data.gained_free_award_day
  local max_times = self.v_gift_cfg.FreeAwardGroupDay
  self.v_uiobjects.Recive:SetActiveEx(can_get)
  self.v_uiobjects.NextDay:SetActiveEx(not can_get and free_award_times < max_times)
  self.v_uiobjects.Finish:SetActiveEx(free_award_times >= max_times)
  self.v_uicompents.DayNum_txt.text = string.format("%s/%s", free_award_times, max_times)
end

function ui:refresh_btn()
  local data = LivenessGiftMgr:get_liveness_gift_data(self.v_id)
  local end_time = data and data.end_time or 0
  local not_buy = 0 == end_time
  local day_num = #ShareRes.create("recharge.liveness_day_award", self.v_id)
  local can_get = data and data.buyed_sign_day > data.buyed_gained_day and day_num > data.buyed_gained_day
  self.v_uiobjects.BtnBuy:SetActiveEx(not_buy)
  self.v_uiobjects.BtnRecive:SetActiveEx(not not_buy and can_get)
  local is_recive = not not_buy and not can_get
  local day_list = ShareRes.create("recharge.liveness_day_award", self.v_id)
  local is_all_recive = is_recive and data and #day_list <= data.buyed_gained_day
  self.v_uiobjects.Recived:SetActiveEx(is_recive)
  if self.v_uiobjects.RecivedText then
    self.v_uiobjects.RecivedText:SetActiveEx(is_recive and not is_all_recive)
    self.v_uiobjects.AllRecivedText:SetActiveEx(is_all_recive)
  end
end

return ui
