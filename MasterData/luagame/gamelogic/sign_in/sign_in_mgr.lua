local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local SIGN_IN_CFG = require("gamelogic.sign_in.sign_in_cfg")

function M:init_sys()
  Base.init_sys(self)
  self.month_reward_list = {}
  self.v_change_sign_in = false
end

local function is_sign_check(nowday, today, is_today_done)
  if is_today_done then
    if nowday <= today then
      return true
    end
  elseif nowday < today then
    return true
  end
  return false
end

function M:on_sign_in_hisotry(data)
  self.month_reward_list = self:_bulid_month_reward_tb(data)
  self.next_sign_in_time = data.next_timestamp
end

function M:_bulid_month_reward_tb(data)
  local sign_in_cfg = ShareRes.create("sign_in.sign_in")
  local month_card_cfg = ShareRes.create("sign_in.monthly_card", 1)
  local month = data.month
  local completed_days = data.completed_days
  local total_days = data.total_days
  local today_done = data.today_done
  if not today_done then
    RedPointMgr:enable_redpoint(RedEnum.SIGN_IN, true)
    completed_days = completed_days + 1
  end
  local reward_list = {
    month = month,
    completed_days = completed_days,
    total_days = total_days,
    today_done = today_done
  }
  local year = Date.get_time_tbl().year
  local is_leap_year = 0 == year % 400 or 0 == year % 4 and 0 ~= year % 100
  if nil ~= sign_in_cfg[month] then
    for _, sign_data in ipairs(sign_in_cfg[month]) do
      local day = sign_data.MonthSignDay
      if not (2 ~= month or is_leap_year) and day > 28 then
        break
      end
      reward_list[day] = self:_build_day_reward_tb(sign_data, completed_days, today_done)
    end
  end
  local month_card_daily_cfg = ShareRes.create("award.award", month_card_cfg.DailyAwardId)
  local month_card_item_cfg = ShareRes.get_item_cfg(month_card_daily_cfg.ItemId)
  local month_card_data = {
    num = month_card_daily_cfg.Num,
    item_cfg = month_card_item_cfg
  }
  reward_list.month_card_data = month_card_data
  return reward_list
end

function M:_build_day_reward_tb(sign_data, completed_days, is_today_done)
  local reward_cfg = ShareRes.create("award.award", sign_data.AwardId)
  local item_cfg = ShareRes.get_item_cfg(reward_cfg.ItemId)
  local day = sign_data.MonthSignDay
  local sign_in_state
  if completed_days > day then
    sign_in_state = SIGN_IN_CFG.SIGN_ITEM_STATE.PRE_DAY
  else
    sign_in_state = SIGN_IN_CFG.SIGN_ITEM_STATE.FOLLOW_DAY
  end
  if completed_days == day then
    sign_in_state = SIGN_IN_CFG.SIGN_ITEM_STATE.TODAY
  end
  local day_reward_tb = {
    item_cfg = item_cfg,
    num = reward_cfg.Num,
    state = sign_in_state,
    is_sign = is_sign_check(sign_data.MonthSignDay, completed_days, is_today_done),
    sign_data = sign_data
  }
  return day_reward_tb
end

function M:on_try_sign_in(cb)
  Network:call("c2gs_sign_in", {}, function(ok)
    if ok then
      Global.sound_mgr:play_sign_in_suc_sound()
      Util.show_message_tip(2088)
      self.v_change_sign_in = true
      RedPointMgr:enable_redpoint(RedEnum.SIGN_IN, false)
    end
    cb()
  end)
end

function M:on_open_sign_in(cb)
  Network:call("c2gs_sign_in_history", {}, function(ok, resp)
    if ok then
      self:on_sign_in_hisotry(resp)
      RedPointMgr:enable_redpoint(RedEnum.SIGN_IN, false)
      cb()
    end
  end)
end

function M:_get_main_ui_on_top()
  local main_ui = UIMgr:try_get_visible_ui("uimain")
  if not main_ui then
    return false
  end
  local canvas = main_ui:get_canvas(nil)
  if 0 == canvas.planeDistance then
    return false
  end
  return true
end

function M:on_update_red_point()
  self.month_reward_list.today_done = nil
  RedPointMgr:enable_redpoint(RedEnum.SIGN_IN, true)
end

function M:get_month_card()
  local has_card = RechargeMgr:get_has_buy_card(1)
  if not has_card then
    return
  end
  return RechargeMgr:get_month_card_remain_days()
end

function M:is_sign_in_main_red()
  return not self.month_reward_list.today_done
end

function M:get_today_done()
  return self.month_reward_list.today_done
end

function M:get_month_reward_list()
  return self.month_reward_list
end

function M:is_change_sign_in_state()
  return self.v_change_sign_in
end

function M:reset_change_sign_in_state()
  self.v_change_sign_in = false
end

function M:get_next_sign_in_time()
  return self.next_sign_in_time
end

return M
