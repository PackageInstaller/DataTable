local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local Char_Helper = require("uimodule.character.char_helper")
local CommonDefine = require("cs_share.common_define")
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")

function ui:ui_finish_load()
  self:set_button("BtnDetail", function()
    Player_Hero_Helper.set_hero_data(self.v_buddy_info, nil, nil, true)
    UIMgr:get_ui("player_hero"):ui_show()
  end)
  self:set_button("Btn_Assist", function()
    self:click_char()
  end)
  self:set_button("Btn_Player", function()
    self:click_player()
  end)
end

function ui:click_char()
  if self.v_is_ban then
    return
  end
  self.v_parent_ui:on_select_buddy(self.v_buddy_info)
end

function ui:click_player()
  if self.v_type == CommonDefine.ASSIST_BUDDY_TYPE.ROBOT then
    return
  end
  AssistMgr:request_player_info(self.v_buddy_info.uuid)
end

function ui:ui_on_hide()
  self.v_buddy_info = nil
  self.v_team_data = nil
end

function ui:set_data(buddy_info, team_data, is_ban)
  self.v_buddy_info = buddy_info
  self.v_buddy_id = buddy_info.id
  self.v_buddy_cfg = ShareRes.get_buddy_cfg(self.v_buddy_id)
  self.v_advance_data = buddy_info.advance or 1
  self.v_lv_data = buddy_info.lv or 0
  self.v_break_lv_data = buddy_info.break_lv or 0
  self.v_type = buddy_info.type
  self.v_fix_buddy_id = buddy_info.fix_buddy_id
  self.v_power = buddy_info.power or 0
  self.v_player_data = buddy_info.snap_info or {}
  self.v_element_id = buddy_info.element
  self.v_idx = buddy_info.index
  self.v_team_data = team_data
  self.v_is_selected = AssistMgr:check_selected(buddy_info)
  self.v_is_ban = true == is_ban
  self:refresh_quailty_icon()
  self:refresh_element_icon()
  self:refresh_job_icon()
  self:refresh_char_icon()
  self:refresh_char_name()
  self:refresh_advance_icon()
  self:refresh_lv_num()
  self:refresh_recommend_tips()
  self:refresh_formation_mask()
  self:_refresh_player_info()
end

function ui:refresh_quailty_icon()
  local icon_path = Char_Helper.get_char_select_quality_icon(self.v_buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.CharQualityBg_img, icon_path)
  local quality = self.v_buddy_cfg.Quality
  icon_path = Char_Helper.get_char_line_quality_icon(quality)
  ResMgr:load_set_icon(self.v_uicompents.QualityLine_img, icon_path)
end

function ui:refresh_element_icon()
  local icon_path = Char_Helper.get_char_element_icon(self.v_buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.EleIcon_img, icon_path)
end

function ui:refresh_job_icon()
  local icon_path = Char_Helper.get_char_job_icon(self.v_buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.JobIcon_img, icon_path)
end

function ui:refresh_char_icon()
  local icon = UtilUI.get_hero_images(self.v_buddy_id, Config.HERO_ICON_LV.HALF_IMG, self.v_buddy_info.fashion, true)
  ResMgr:load_set_icon(self.v_uicompents.CharIcon_img, icon, nil, true)
end

function ui:refresh_char_name()
  local name = self.v_buddy_cfg.Name
  self.v_uicompents.CharName_txt.text = name
end

function ui:refresh_advance_icon()
  if self.v_uiobjects.Advance then
    self.v_uiobjects.Advance:SetActiveEx(self.v_advance_data > 1)
    local txt = self.v_uicompents.AdvanceNum_txt
    if txt and self.v_advance_data > 1 then
      txt.text = Config.NUM_2_ROMAN[self.v_advance_data - 1]
    end
  end
end

function ui:refresh_lv_num()
  self.v_uicompents.CharLvNum_txt.text = self.v_lv_data
end

function ui:refresh_recommend_tips()
  local is_friend = self.v_type == CommonDefine.ASSIST_BUDDY_TYPE.FRIEND
  self.v_uiobjects.Friend:SetActive(is_friend)
end

function ui:refresh_formation_mask()
  local is_formation = self:_check_is_formation()
  self.v_uiobjects.BanChar:SetActive(self.v_is_ban)
  local is_using = self:_check_is_using()
  self.v_uiobjects.SameChar:SetActive(is_formation and not is_using)
  self.v_uicompents.Btn_Assist_btn.interactable = not is_using and not is_formation and not self.v_is_ban
end

function ui:_check_is_using()
  local assist_buddy_info = AssistMgr:get_assist_buddy_info()
  if assist_buddy_info and self.v_element_id == assist_buddy_info.element and self.v_idx == assist_buddy_info.index then
    return true
  end
end

function ui:_check_is_formation()
  local assist_buddy_info = AssistMgr:get_assist_buddy_info()
  if assist_buddy_info and assist_buddy_info.id == self.v_buddy_id then
    return
  end
  local team_data = self.v_team_data
  if not team_data then
    return
  end
  local select_pos = team_data.select_pos
  local pos_data = team_data.pos_data
  if not pos_data then
    return
  end
  for key, data in pairs(pos_data) do
    if data.buddy_id == self.v_buddy_id and select_pos ~= key then
      return true, data
    end
  end
end

function ui:_refresh_player_info()
  local player_data = self.v_player_data
  local name, icon, lv
  if self.v_type ~= CommonDefine.ASSIST_BUDDY_TYPE.ROBOT then
    name = player_data.name
    icon = player_data.face_id
    lv = player_data.grade
  else
    local robot_cfg = ShareRes.create("helpfight.help_fight_push")[1]
    name = robot_cfg.PlayerName
    icon = robot_cfg.PlayerAvator
    lv = PlayerMgr:get_role_lv()
  end
  self.v_uicompents.PlayerName_txt.text = name or ""
  self.v_uicompents.PlayerLv_txt.text = lv or ""
  if icon then
    Util.load_char_head_icon(self.v_uicompents.PlayerProfile_img, icon)
  end
  self.v_uiobjects.Btn_Player:SetActiveEx(nil ~= player_data)
  self.v_uiobjects.PlayerIcon:SetActiveEx(self.v_type ~= CommonDefine.ASSIST_BUDDY_TYPE.ROBOT)
end

function ui:check_is_formation(buddy_id)
  local team_data = self.v_team_data
  local pos_data = team_data.pos_data
  if not pos_data then
    return
  end
  for key, data in pairs(pos_data) do
    if data.buddy_id == buddy_id then
      return true, data.pos
    end
  end
end

return ui
