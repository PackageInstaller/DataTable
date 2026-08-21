local Base = require("ui.uibase")
local OnlineConfig = require("gamelogic.activity.online_config")
local OnlineHelper = require("uimodule.stage_activity.online_battle.online_battle_helper")
local ui = Util.create_child_mt(Base)
local CommonDef = require("cs_share.common_define")
local Act_ID = CommonDef.ACTY_TYPE.ONLINE_BATTLE
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_accept = {
    "BtnAccept",
    BIND_TYPE.BUTTON
  },
  v_btn_refuse = {
    "BtnRefuse",
    BIND_TYPE.BUTTON
  },
  v_invited = {
    "Invited",
    BIND_TYPE.OBJECT
  },
  v_match_time = {
    "MatchTime",
    BIND_TYPE.TEXT
  },
  v_matching = {
    "Matching",
    BIND_TYPE.IMAGE
  },
  v_quit_match_btn = {
    "QuitMatchBtn",
    BIND_TYPE.BUTTON
  },
  v_spin = {
    "Spin",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnAccept", function()
    self:_onclick_accept_btn()
  end)
  self:set_button("BtnRefuse", function()
    self:_onclick_refuse_btn()
  end)
  self:set_button("Invited", function()
    self:_onclick_invite_btn()
  end)
  self:set_button("QuitMatchBtn", function()
    self:_onlick_quit_match_btn()
  end)
  self.online_cfg = ActivityMgr:invoke(Act_ID, "get_act_cfg")
  self.v_invited_rect = self:get_rect_transform(nil, self.v_invited)
end

function ui:ui_on_show(tip_type, param, ...)
  self.v_tip_type = tip_type
  self.v_param = param
  self.v_invited:SetActive(self.v_tip_type == OnlineConfig.Quick_TIPS_TYPE.INVITATION)
  self.v_matching:SetActive(self.v_tip_type == OnlineConfig.Quick_TIPS_TYPE.MATCH)
  if self.v_tip_type == OnlineConfig.Quick_TIPS_TYPE.MATCH then
    self.v_join_time = ActivityMgr:invoke(Act_ID, "get_join_match_time")
    self:_refresh_match_time()
  else
    self:_refresh_inviation()
  end
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_BE_INVITE_CD_FINISH, self._response_invite_cd_event, self)
end

function ui:_response_invite_cd_event(msg)
  if self.v_tip_type == OnlineConfig.Quick_TIPS_TYPE.MATCH then
    return
  end
  self:_pop_next_invite()
end

function ui:ui_on_hide()
  if self.v_exist_sq then
    self.v_exist_sq:Kill()
    self.v_exist_sq = nil
  end
  if self.v_enter_sq then
    self.v_enter_sq:Kill()
    self.v_enter_sq = nil
  end
end

function ui:ui_on_update()
  if self.v_tip_type ~= OnlineConfig.Quick_TIPS_TYPE.MATCH then
    return
  end
  self:_refresh_match_time()
end

function ui:_refresh_match_time()
  local match_time = GlobalTimeMgr:get_unscaled_time() - self.v_join_time
  if match_time > self.online_cfg.MatchTime then
    self:ui_hide()
    return
  end
  self.v_match_time.text = Date.get_print_count_down(match_time)
end

function ui:_refresh_inviation()
  self.v_invited_list = ActivityMgr:invoke(Act_ID, "get_invitation_list")
  if not self.v_invited_list or next(self.v_invited_list) == nil then
    self:_play_exist()
    return
  end
  self.v_invited_id = self.v_invited_list[1].info.id
  if self.v_param and self.v_param.need_tween then
    self:_play_enter()
  end
end

function ui:_pop_next_invite()
  self.v_invited_list = ActivityMgr:invoke(Act_ID, "get_invitation_list")
  if not self.v_invited_list or next(self.v_invited_list) == nil then
    self:_play_exist()
    return
  end
  self:_play_exist(function()
    self:_play_enter()
  end)
end

function ui:_play_enter(next_cb)
  if self.v_enter_sq then
    self.v_enter_sq:Kill()
    self.v_enter_sq = nil
  end
  self.v_invited_rect:SetAnchoredPositionA(0, -150, 0)
  self.v_enter_sq = Util.create_sequence()
  self.v_enter_sq:Append(self.v_invited_rect:DOLocalMoveY(-327, 1))
  self.v_enter_sq:AppendCallback(function()
    self.v_enter_sq:Kill()
    self.v_enter_sq = nil
    if next_cb then
      next_cb()
    end
  end)
end

function ui:_play_exist(next_cb)
  if self.v_exist_sq then
    self.v_exist_sq:Kill()
    self.v_exist_sq = nil
  end
  self.v_exist_sq = Util.create_sequence()
  self.v_exist_sq:Append(self.v_invited_rect:DOLocalMoveY(-666, 1))
  self.v_exist_sq:AppendCallback(function()
    self.v_exist_sq:Kill()
    self.v_exist_sq = nil
    if next_cb then
      next_cb()
    else
      self:ui_hide()
    end
  end)
end

function ui:_onlick_quit_match_btn()
  OnlineHelper.quit_match(self, nil, OnlineConfig.MATCH_OPERATE.BREAK)
end

function ui:_onclick_accept_btn()
  ActivityMgr:invoke(Act_ID, "request_invite_accept", self.v_invited_id, function()
    self:ui_hide()
  end)
end

function ui:_onclick_refuse_btn()
  ActivityMgr:invoke(Act_ID, "refuse_match_invited", self.v_invited_id)
  self:_pop_next_invite()
end

function ui:_onclick_invite_btn()
  local function cb()
    self:_pop_next_invite()
  end
  
  OnlineHelper.invite_operate(self, cb, self.v_invited_list[1].info)
end

return ui
