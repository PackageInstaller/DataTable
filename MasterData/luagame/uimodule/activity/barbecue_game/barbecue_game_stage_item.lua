local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("Content", function()
    self:on_click()
  end)
end

function ui:on_click()
  if self.v_is_unlock then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_BBQ_STAGE_ENTER_GAME)
    msg.mm_x = self.v_stage_id
    self.v_parent_ui:ui_hide()
    return
  end
  Util.show_message_tip("该关卡未解锁")
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(cfg)
  local idx = cfg.Order
  local x, y, z
  if 0 ~= idx % 2 then
    x, y, z = self.v_uicompents.LowerPos_rect:GetLocalPositionA3()
  else
    x, y, z = self.v_uicompents.UpPos_rect:GetLocalPositionA3()
  end
  self.v_uicompents.Content_rect:SetLocalPositionA(0, y, 0)
  self.v_stage_id = cfg.Id
  self.v_stage_cfg = cfg
  self.v_uicompents.StageName_txt.text = cfg.Name
  self.v_uiobjects.NormalBg:SetActiveEx(cfg.TargetScore ~= nil)
  self.v_uiobjects.SpecialBg:SetActiveEx(cfg.TargetScore == nil)
  self.v_uiobjects.RedDot:SetActiveEx(BarbecueGameMgr:is_stage_new(cfg.Id))
  self:refresh_view()
  self.v_cache_time = 0
end

function ui:refresh_view()
  local data = BarbecueGameMgr:get_stage_data(self.v_stage_cfg.Id)
  local now_time = Date.server_time()
  local start_time = self.v_stage_cfg.StartTime and Date.get_time_stamp_by_scheme_id(self.v_stage_cfg.StartTime) or 0
  local time_open = data and not data.is_lock
  local condition_open = data and data.is_challenge
  local is_unlock = time_open and condition_open
  self.v_is_unlock = is_unlock
  self.v_uiobjects.Lock:SetActive(not is_unlock)
  self.v_uiobjects.Unlock:SetActive(is_unlock)
  if not time_open then
    local remain_time = start_time - now_time
    if remain_time > 86400 then
      self.v_uicompents.LockTipsTxt_txt.text = string.format("%s天后解锁", math.ceil(remain_time / 86400))
    elseif remain_time > 3600 then
      self.v_uicompents.LockTipsTxt_txt.text = string.format("%s时后解锁", math.ceil(remain_time / 3600))
    else
      remain_time = remain_time > 0 and remain_time or 1
      self.v_uicompents.LockTipsTxt_txt.text = string.format("%s分后解锁", math.ceil(remain_time / 60))
    end
  elseif not condition_open then
    self.v_uicompents.LockTipsTxt_txt.text = "通关前置关卡后解锁"
  else
    local pass = data and data.score > 0
    self.v_uiobjects.NotFinish:SetActive(not pass)
    self.v_uiobjects.Finish:SetActive(pass)
  end
end

return ui
