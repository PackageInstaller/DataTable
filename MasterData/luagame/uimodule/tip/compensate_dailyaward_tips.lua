local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SaticSv = require("ui.widget.static_scroll_view")
local COMPENSTATE_DAILYAWARD_ITEM = require("uimodule.activity.ui_compensate_activity_dailyaward_item")
local COMPENSATE_DAILYAWARD_ITEM_TEMP_KEY = "COMPENSATE_DAILYAWARD_ITEM_TEMP_KEY"

function ui:ui_finish_load()
  self:set_button("BgClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnAward", function()
    CompensateMgr:request_compensate_gained_award(self.v_compensate_cfg.ActivityId)
  end)
  self.v_static_svdly = SaticSv:new(self, self.v_uiobjects.AwardContent, COMPENSTATE_DAILYAWARD_ITEM, COMPENSATE_DAILYAWARD_ITEM_TEMP_KEY)
end

function ui:ui_on_show(data, ...)
  self.v_compensate_cfg = data.cfg
  self:refresh_dailyaward_state()
  self.v_static_svdly:update_list(self.v_award_item_list)
end

function ui:refresh_dailyaward_state()
  self.v_award_item_list = ShareRes.get_awards(self.v_compensate_cfg.AwardGroupId)
  local daily_state = CompensateMgr:get_compensate_dailyaward_data()
  local nextday, finished, can_receive
  if 0 == daily_state.can_gain_day and daily_state.gained_day < self.v_compensate_cfg.AwardDayLimit then
    nextday = true
  end
  if daily_state.can_gain_day > 1 then
    self.v_uicompents.Tips_txt.text = "累计" .. daily_state.can_gain_day .. "日奖励"
    can_receive = true
  elseif 0 == daily_state.can_gain_day and daily_state.gained_day < self.v_compensate_cfg.AwardDayLimit then
    can_receive = false
    self.v_uicompents.Tips_txt.text = "奖励已领取"
  elseif daily_state.gained_day == self.v_compensate_cfg.AwardDayLimit then
    self.v_uicompents.Tips_txt.text = "奖励已领取"
    finished = true
  elseif 1 == daily_state.can_gain_day then
    self.v_uicompents.Tips_txt.text = "今日奖励"
    can_receive = true
  end
  self.v_uiobjects.BtnAward:SetActive(can_receive and not nextday and not finished)
end

function ui:ui_on_hide()
  self.v_compensate_cfg = nil
  self.v_award_item_list = nil
  self.v_static_svdly:clear()
end

function ui:ui_on_destroy()
  self.v_static_svdly = nil
end

return ui
