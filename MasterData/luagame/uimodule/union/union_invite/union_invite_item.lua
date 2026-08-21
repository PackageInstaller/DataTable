local Base = require("ui.uiobject")
local UnionCfg = require("uimodule.union.union_config")
local UnionHelper = require("uimodule.union.union_helper")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_offline = {
    "Offline",
    BIND_TYPE.OBJECT
  },
  v_online = {
    "Online",
    BIND_TYPE.OBJECT
  },
  v_player_id = {
    "PlayerID",
    BIND_TYPE.TEXT
  },
  v_player_lv = {
    "PlayerLV",
    BIND_TYPE.TEXT
  },
  v_player_name = {
    "PlayerName",
    BIND_TYPE.TEXT
  },
  v_profile = {
    "Profile",
    BIND_TYPE.IMAGE
  },
  v_btn_invite = {
    "BtnInvite",
    BIND_TYPE.BUTTON
  },
  v_btn_invited = {
    "BtnInvited",
    BIND_TYPE.BUTTON
  }
}
local INVITE_STATE = UnionCfg.INVITE_STATE
local LOGIN_STATE = UnionCfg.PLAYER_LOGIN_STATE

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnInvite", function()
    self:_onclick_invite_btn()
  end)
end

function ui:ui_on_show(player_data, ...)
end

function ui:ui_on_hide()
end

function ui:set_data(go, data_list, index)
  self.v_player_data = data_list[index]
  self.v_player_name.text = self.v_player_data.name
  self.v_player_id.text = self.v_player_data.uuid
  self.v_player_lv.text = self.v_player_data.lv
  ResMgr:load_set_icon(self.v_profile, UnionHelper.get_player_icon_path(self.v_player_data.icon))
  local login_state = 0 == self.v_player_data.offline_time and LOGIN_STATE.ONLINE or LOGIN_STATE.OFFLINE
  self.v_online:SetActive(login_state == LOGIN_STATE.ONLINE)
  self.v_offline:SetActive(login_state == LOGIN_STATE.OFFLINE)
  local invite_state = self.v_player_data.invite_status
  self.v_btn_invite:SetActive(invite_state == INVITE_STATE.NONE or invite_state == INVITE_STATE.IN_UNION)
  self.v_btn_invited:SetActive(invite_state == INVITE_STATE.INVITED)
end

function ui:_onclick_invite_btn()
  if self.v_player_data.invite_status == INVITE_STATE.IN_UNION then
    Util.show_message_tip(2303)
    return
  end
  UnionMgr:request_invite_player(self.v_player_data.uuid, function(ok)
    if ok then
      self.v_player_data.invite_status = UnionCfg.INVITE_STATE.INVITED
      Util.show_message_tip(2304)
      self.v_btn_invite:SetActive(false)
      self.v_btn_invited:SetActive(true)
    end
  end)
end

return ui
