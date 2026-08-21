local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_choose = {
    "BtnChoose",
    BIND_TYPE.BUTTON
  },
  v_btn_close = {
    "BtnClose",
    BIND_TYPE.BUTTON
  },
  v_intro_icon = {
    "Intro_Icon",
    BIND_TYPE.IMAGE
  },
  v_intro_txt = {
    "Intro_Txt",
    BIND_TYPE.TEXT
  }
}
local CommonDefind = require("cs_share.common_define")
local PATH = "UINoFightGame/%s"
local OBJ_VISIBLE_TYPE = Config.FIGHT_OBJ_VISIBLE_TYPE

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnChoose", function()
    FunctionalNpcMgr:interact_with_no_fight_game_npc(self.v_npc_data, CommonDefind.NO_FIGHT_GAME_NPC_ACTION.START_CHALLENGE)
    self:ui_hide()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
end

function ui:ui_on_show(npc_data, game_data)
  self.v_npc_data = npc_data
  self.v_data = game_data
  self:refresh_view()
  UIMgr:get_ui("fight"):set_ui_node_visible("Main", OBJ_VISIBLE_TYPE.BUDDY, true)
end

function ui:refresh_view()
  local data = self.v_data
  local ucom = self.v_uicompents
  local intro_icon = data.Icon
  local intro_txt = data.Text
  local intro_icon_com = ucom.Intro_Icon_img
  local intro_text_com = ucom.Intro_Txt_txt
  local icon_path = string.format(PATH, intro_icon)
  intro_text_com.text = intro_txt
  ResMgr:load_set_icon(intro_icon_com, icon_path)
end

function ui:ui_on_hide()
  UIMgr:get_ui("fight"):set_uiobject_visible("Main", true)
  self.v_data = nil
  self.v_npc_data = nil
end

function ui:ui_on_destroy()
end

return ui
