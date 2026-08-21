local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local TextMeshProType = typeof(CS.TMPro.TextMeshProUGUI)
local UI_RETURN_ACT_NEW_KEY = "UI_RETURN_ACT_NEW_KEY"
local DEFAULT_SELECT
local ACT_TYPE = {SIMPLE_ACT = 1, ROLE_ACT = 2}
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")
local Char_Helper = require("uimodule.character.char_helper")
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_return_activity_main_in_UI_SOUND)
  end)
  self:set_button("BtnMain", function()
    if SceneMgr:check_main_scene() then
      UIMgr:go_to_main()
    end
  end)
  self:set_button("BtnGet", function()
    if not self.v_jump_id then
      return
    end
    UIMgr:go_to_main()
    SysOpenMgr:jump_to_sys(self.v_jump_id, true)
  end)
  self:set_button("BtnTry", function()
    if not self.v_select_buddy_id then
      return
    end
    UIMgr:go_to_main()
    SysOpenMgr:jump_to_sys(30002, true)
  end)
  self:set_button("BtnJump", function()
    if self.v_jump_id then
      UIMgr:go_to_main()
      SysOpenMgr:jump_to_sys(self.v_jump_id, true)
    end
  end)
  self:set_button("BtnCharInfoMajor", function()
    if not self.v_select_buddy_id then
      return
    end
    self:on_click_char_btn(self.v_select_buddy_id)
  end)
  self:register_exist_auto_template(UI_RETURN_ACT_NEW_KEY, self.v_uiobjects.PageTem, self.v_uiobjects.PageCnt)
  self.v_act_desc = self.v_uiobjects.ActivityDesc:GetComponent(TextMeshProType)
  self.v_uiobjects.BtnIntroduce:SetActive(false)
  self.v_new_act_bg1 = Util.get_child_gameobj("Bg1", self.v_uiobjects.NewAct)
  self.v_new_act_bg_img = Util.get_image("Bg1", self.v_uiobjects.NewAct)
  self.v_new_act_bg2 = Util.get_child_gameobj("Bg1/Bg2", self.v_uiobjects.NewAct)
  self.v_new_act_bg3 = Util.get_child_gameobj("Bg1/Bg3", self.v_uiobjects.NewAct)
  self.v_new_act_bg2:SetActive(false)
  self.v_new_act_bg3:SetActive(false)
end

function ui:ui_on_show(parent_ui)
  self.v_select_buddy_id = nil
  self.v_parent_ui = parent_ui
  self.v_uiobjects.NewAct:SetActive(true)
  self.v_uiobjects.NewChar:SetActive(false)
  self:refresh_page()
end

function ui:ui_on_hide()
  if self.v_parent_ui then
    self.v_parent_ui:play_in_eff()
  end
  self:clear_spine_rt()
end

function ui:set_page_select(page, flag)
  for _, page_col in pairs(self.v_page_list) do
    page_col.unselect_mask1:SetActive(true)
    page_col.unselect_mask2:SetActive(true)
    page_col.select_img:SetActive(false)
  end
  page.unselect_mask1:SetActive(not flag)
  page.unselect_mask2:SetActive(not flag)
  page.select_img:SetActive(flag)
end

function ui:refresh_page()
  self.v_page_list = {}
  self:give_back_auto_cache(UI_RETURN_ACT_NEW_KEY)
  local cfg = ShareRes.get_return_activity_new_cfg()
  for idx, data in ipairs(cfg) do
    if self:check_time_condition(data.ActStartTime, data.ActEndTime) then
      DEFAULT_SELECT = DEFAULT_SELECT or idx
      self.v_page_list[idx] = {}
      local page_obj = self:get_auto_cache(UI_RETURN_ACT_NEW_KEY)
      local unselect_mask1 = Util.get_child_gameobj("UnSelectMask1_", page_obj)
      local unselect_mask2 = Util.get_child_gameobj("UnSelectMask2_", page_obj)
      local select_img = Util.get_child_gameobj("Select_", page_obj)
      local title_name = Util.get_text("Name_", page_obj)
      local btn = Util.get_button(nil, page_obj)
      self.v_page_list[idx].page_obj = page_obj
      self.v_page_list[idx].unselect_mask1 = unselect_mask1
      self.v_page_list[idx].unselect_mask2 = unselect_mask2
      self.v_page_list[idx].select_img = select_img
      self.v_page_list[idx].title_name = title_name
      title_name.text = data.PageDesc
      self:set_button_listener(btn, function()
        self:set_page_select(self.v_page_list[idx], true)
        self:click_page_btn(data)
      end)
    end
  end
  if self.v_page_list[DEFAULT_SELECT] then
    self:set_page_select(self.v_page_list[DEFAULT_SELECT], true)
    self:click_page_btn(cfg[DEFAULT_SELECT])
  end
end

function ui:check_time_condition(start_time_param, end_time_param)
  local cur_time = Date.server_time()
  local start_time = start_time_param and Date.get_time_stamp_by_scheme_id(start_time_param)
  if start_time and cur_time < start_time then
    return false
  end
  local end_time = end_time_param and Date.get_time_stamp_by_scheme_id(end_time_param)
  if end_time and cur_time > end_time then
    return false
  end
  return true
end

function ui:click_page_btn(data)
  if data.ActType == ACT_TYPE.SIMPLE_ACT then
    self:set_simple_act_info(data)
  elseif data.ActType == ACT_TYPE.ROLE_ACT then
    self:set_role_act_info(data)
  end
end

function ui:set_simple_act_info(data_param)
  self.v_uiobjects.NewAct:SetActive(true)
  self.v_uiobjects.NewChar:SetActive(false)
  self.v_act_desc.text = data_param.ActDesc
  self.v_jump_id = data_param.ActJump
  self.v_end_time = data_param.ActEndTime
  if data_param.SpineID ~= nil and nil ~= data_param.TitleIcon then
    ResMgr:load_set_icon(self.v_new_act_bg_img, data_param.SpineID)
    ResMgr:load_set_icon(self.v_uicompents.Title_img, data_param.TitleIcon)
    self.v_uicompents.Title_img:SetNativeSize()
  end
end

function ui:set_role_act_info(data_param)
  self.v_uiobjects.NewAct:SetActive(false)
  self.v_uiobjects.NewChar:SetActive(true)
  self.v_jump_id = data_param.ActJump
  self.v_end_time = data_param.ActEndTime
  self.v_select_buddy_id = data_param.ActID
  self.v_spine_id = data_param.SpineID
  self.v_spine_offset = data_param.DisplayViewOffset
  self:set_show_buddy_info(self.v_uiobjects.BtnCharInfoMajor, self.v_select_buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.CharTitle_img, data_param.TitleIcon, nil, true)
  self.v_uicompents.CharTitle_img:SetNativeSize()
end

function ui:ui_on_update()
  local end_time = self.v_end_time and Date.get_time_stamp_by_scheme_id(self.v_end_time) or 0
  local has_time = Util.is_more_than_zero(end_time)
  self.v_uiobjects.LessTime:SetActive(has_time)
  self.v_uiobjects.Time:SetActive(has_time)
  if not has_time then
    return
  end
  local total_sec = end_time - Date.server_time()
  if total_sec <= 0 then
    self.v_uiobjects.LessTime:SetActive(false)
    self.v_uiobjects.Time:SetActive(false)
    return
  end
  self.v_uicompents.LessTime_txt.text = Date.get_time_formate_2(total_sec)
  self.v_uicompents.Time_txt.text = Date.get_time_formate_2(total_sec)
end

function ui:is_open_teaching()
  return CharacterMgr:is_open_teaching_entry(self.v_select_buddy_id)
end

function ui:on_click_char_btn(show_buddy)
  if not show_buddy then
    return
  end
  if 0 ~= show_buddy then
    Player_Hero_Helper.build_fake_buddy(show_buddy)
    UIMgr:get_ui("player_hero"):ui_show()
  end
end

function ui:set_show_buddy_info(obj, buddy_id)
  if not obj then
    return
  end
  local element_icon = Util.get_image("Ele_", obj)
  local name_txt = Util.get_text("Name_", obj)
  local quality = ShareRes.get_buddy_cfg(buddy_id).Quality
  for index = 1, 5 do
    local star_obj = Util.get_child_gameobj("QualityStarLayout_/QualityStar" .. index, obj)
    if star_obj then
      star_obj:SetActive(index <= quality)
    end
  end
  local element_icon_path = Char_Helper.get_char_element_icon(buddy_id)
  ResMgr:load_set_icon(element_icon, element_icon_path)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  name_txt.text = buddy_cfg.Name
  if self.v_spine_id and self.v_spine_id ~= self.v_cur_spine_id then
    self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.CharIconSpine)
    SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.CharIconSpine)
    self.v_uicompents.CharIconSpine_rect:SetLocalPositionA(self.v_spine_offset[1], self.v_spine_offset[2], 0)
    self.v_uicompents.CharIconSpine_rect:SetLocalScaleA(self.v_spine_offset[3], self.v_spine_offset[3], self.v_spine_offset[3])
    self.v_cur_spine_id = self.v_spine_id
  else
    self.v_uiobjects.CharIconSpine:SetActive(self.v_spine_id ~= nil)
  end
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
    self.v_cur_spine_id = nil
  end
end

return ui
