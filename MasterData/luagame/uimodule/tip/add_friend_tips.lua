local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_assist_tips = {
    "AssistTips",
    BIND_TYPE.IMAGE
  },
  v_btn_accept = {
    "BtnAccept",
    BIND_TYPE.BUTTON
  },
  v_btn_refuse = {
    "BtnRefuse",
    BIND_TYPE.BUTTON
  },
  v_player_lv = {
    "PlayerLv",
    BIND_TYPE.TEXT
  },
  v_player_name = {
    "PlayerName",
    BIND_TYPE.TEXT
  },
  v_player_profile = {
    "PlayerProfile",
    BIND_TYPE.BUTTON
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnAccept", function()
    local function apply_callback()
      self:ui_hide()
      
      Util.show_message_tip(2194)
    end
    
    local function fail_callback()
      self:ui_hide()
    end
    
    FriendMgr:apply_add_friend(self.v_uuid, apply_callback, fail_callback)
  end)
  self:set_button("BtnRefuse", function()
    self:ui_hide()
  end)
end

function ui:ui_on_show(player_data)
  self.v_uuid = player_data.uuid
  self.v_uiobjects.AssistTips:SetActive(true)
  self.v_player_name.text = player_data.name
  self.v_player_lv.text = player_data.lv
  Util.load_char_head_icon(self.v_uicompents.PlayerProfile_img, player_data.icon)
end

function ui:ui_on_hide()
end

return ui
