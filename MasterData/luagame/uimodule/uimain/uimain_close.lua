local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SIGNBOARD_PARAM = Config.SIGNBOARD_PARAM
local NORMAL_PARAM_ID = 0
local UnityShader = UnityEngine.Shader
local UnityFind = _ENV.UnityFind
local TypeSceneContainer = typeof(CS.Game.SceneContainer)
local MAIN_SCENE_SHOW_ID = UnityShader.PropertyToID("_MAIN_SCENE_SHOW")
local SCENE_LIGHT_REV = UnityShader.PropertyToID("_SCENE_LIGHT_REV")
local MAIN_SCENE_LIGHT_POS = "_MAIN_SCENE_LIGHT_POS"
local CSPostProcessBehavior = typeof(UnityEngine.PostProcessing.PostProcessingBehaviour)

function ui:ui_finish_load()
  local ucmp = self.v_uicompents
  self:set_button_listener(ucmp.Button_return_btn, function()
    if not self.v_uimain then
      self.v_uimain = UIMgr:get_ui("uimain")
    end
    if self.v_uimain then
      self.v_uimain:refresh_book_model()
    end
    self:ui_hide()
  end)
  self:set_button_listener(ucmp.FullHideBtn_btn, function()
    self:set_ui_visible(true)
  end)
  self:set_button_listener(ucmp.Gift_btn, function()
    self:show_gift_list()
  end)
  self:set_button_listener(ucmp.Char_btn, function()
    self:show_signboard_list()
  end)
  self:set_button_listener(ucmp.Archive_btn, function()
    local char_archive = UIMgr:get_ui("char_archive")
    char_archive:ui_show(self.v_cur_buddy_id)
  end)
  self:set_button_listener(ucmp.Collect_btn, function()
    UIMgr:get_ui("archive_enter"):ui_show()
  end)
  self:set_button_listener(ucmp.HideUI_btn, function()
    self:set_ui_visible(false)
  end)
  self:set_button_listener(ucmp.Fashion_btn, function()
    UIMgr:get_ui("ui_fashionable_dress"):ui_show(self.v_cur_buddy_id, nil, nil, nil, nil, true, nil, true)
  end)
  self:set_button_listener(ucmp.BtnHideGift_btn, function()
    self:hide_gift_list(false)
    SignBoardGirlMgr:send_change_model_view_param(SIGNBOARD_PARAM.CHANGE_ROLE)
  end)
  self:set_button_listener(ucmp.Event_btn, function()
    if self.event_btn_cb then
      self:get_canvas().planeDistance = 0
      self.event_btn_cb(PlayerMgr:get_signboard_girl_id())
    end
  end)
  self:set_button("BtnGetAward", function()
    self:show_favor_award()
  end)
  self:set_button("Favor", function()
    self:show_favor_award()
  end)
  self.v_canvas_grp = self:get_canvas_group(nil, self.v_uiobjects.ClosePanel)
  self.v_dialog_panel = self:get_panel("signboard_girl")
  self.v_gift_panel = self:get_panel("signboard_gift_list")
end

function ui:ui_on_show(event_btn_cb, ui_show_finish_cb)
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 1)
  self:init_container()
  self:resgister_event()
  self.v_uiobjects.BtnHideGift:SetActive(false)
  self.v_uiobjects.Favor:SetActive(false)
  self.v_uiobjects.FullHideBtn:SetActive(false)
  self:refresh_player_icon()
  self.v_uimain = UIMgr:get_ui("uimain")
  self.v_uimain:set_control_sign_board(true)
  self.v_model_view = self.v_uimain:get_model_view()
  self.v_uimain:set_model_view_visible(true)
  self:check_play_sound_dialog()
  SignBoardGirlMgr:send_change_model_view_param(SIGNBOARD_PARAM.CHANGE_ROLE, false, false)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SET_LIGHT_INFO)
  msg.mm_x = 120
  self.event_btn_cb = event_btn_cb
  self:refresh_task_event_btn_state()
  self:reset_btn_show()
  self.v_uiobjects.UIMainClose_IN:SetActive(true)
  self.v_gift_panel:set_enable(false)
  self.v_cache_show_gift_list = false
  SignBoardGirlMgr:set_cloth_buddy_cache(nil)
  self:refresh_red_point()
  if ui_show_finish_cb then
    ui_show_finish_cb()
  end
  local camera_state = self.v_uimain:get_camera_state()
  if camera_state.to == Config.SIGNBOARD_PARAM.ARCHIVE then
    self.v_uicompents.Ani_UIMainClose_CH_In_pd.time = 0
    self.v_uicompents.Ani_UIMainClose_CH_In_pd:Play()
  else
    self.v_uicompents.Ani_UIMainClose_pd.time = 0
    self.v_uicompents.Ani_UIMainClose_pd:Play()
  end
end

function ui:resgister_event()
  self:bind_auto_mq(Const.MSG_ON_BROWSE_SIGNBOARD_GIRL, self.response_browse_signboard_girl, self)
  self:bind_auto_mq(Const.MSG_ON_SIGNBOARD_SOUND_FINISH, self.response_signboar_sound_finish, self)
  self:bind_auto_mq(Const.MSG_ON_SIGNBOARD_ACTIVE_ACTION, self.response_signboard_girl_action, self)
  self:bind_auto_mq(Const.MSG_ON_SIGNBOARD_GIRL_CHANGE_UI_HIDE, self.hide_signboard_list, self)
  self:bind_auto_mq(Const.MSG_CHANGE_MODEL_VIEW_PARAM, self.check_play_sound_dialog, self)
  self:bind_auto_mq(Const.MSG_REFRESH_UIMAIN_CLOSE_RED_POINT, self.refresh_red_point, self)
  self:bind_auto_mq(Const.MSG_ON_FAVOR_AWARD_UPDATE, self.check_favor_award, self)
end

function ui:ui_on_hide()
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 0)
  local uimain = UIMgr:get_ui("uimain")
  if uimain then
    uimain:set_dof_eff()
  end
  self.v_uimain:set_control_sign_board(false)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SET_LIGHT_INFO)
  msg.mm_x = 1
  Global.sound_mgr:stop_lipsync_data()
end

function ui:ui_on_update()
  if self.v_model_view then
    self:refresh_entry_pos()
  end
end

function ui:cache_ui()
  return true
end

function ui:refresh_task_event_btn_state()
  local buddy_data = TaskMgr:get_buddy_event_data_with_player_board_npc_id()
  self.v_uicompents.Event_btn.gameObject:SetActive(nil ~= buddy_data)
end

function ui:reset_signboard_girl()
  if self.v_now_id then
    local signboard_id = PlayerMgr:get_signboard_girl_id()
    if self.v_now_id ~= signboard_id then
      local msg = MsgGame:mq_publish2(Const.MSG_ON_BROWSE_SIGNBOARD_GIRL)
      msg.mm_x = signboard_id
      SignBoardGirlMgr:try_clear_sound_immediately(true)
      self:refresh_player_icon(signboard_id)
      self:check_play_sound_dialog()
    end
  end
end

function ui:reset_btn_show()
  self.v_uiobjects.UIMainClose_IN:SetActiveEx(false)
  self.v_uiobjects.UIMainClose_IN_GiftOut:SetActiveEx(false)
  self.v_uiobjects.UIMainClose_IN_GiftIn:SetActiveEx(false)
  self.v_uiobjects.UIMainClose_Delay:SetActiveEx(false)
  self.v_uiobjects.Ani_HideUI:SetActiveEx(false)
  self.v_uiobjects.Ani_HideUI_GiftOut:SetActiveEx(false)
  self.v_uiobjects.Ani_GiftRoot_IN:SetActiveEx(false)
  self.v_uiobjects.Ani_CharFavorability:SetActiveEx(false)
  self.v_uiobjects.Ani_HideUI_GiftIn:SetActiveEx(false)
end

function ui:refresh_red_point()
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.CollectRed, RedEnum.ARCHIVES)
  local buddy_id = PlayerMgr:get_signboard_girl_id()
  local show_red = false
  if not buddy_id then
    self.v_uiobjects.ArchiveRed:SetActive(false)
    return
  end
  local voice_red = CharacterMgr:get_red_state(buddy_id, RedEnum.CHAR_CV_VOICE)
  local archive_red = CharacterMgr:get_red_state(buddy_id, RedEnum.CHAR_ARCHIVE_INFO)
  if voice_red or archive_red then
    show_red = true
  end
  self.v_uiobjects.ArchiveRed:SetActive(show_red)
end

function ui:response_browse_signboard_girl(msg)
  if nil == msg then
    return
  end
  self.v_now_id = msg.mm_x
  self:refresh_player_icon(self.v_now_id)
  self:refresh_task_event_btn_state()
  self:refresh_red_point()
end

function ui:refresh_player_icon(buddy_id)
  buddy_id = buddy_id or SignBoardGirlMgr:get_cloth_buddy_cache() or PlayerMgr:get_signboard_girl_id()
  self.v_cur_buddy_id = buddy_id
  self:refresh_favors()
end

function ui:response_signboar_sound_finish(msg)
  self:set_dialog_enable(false)
  Global.sound_mgr:stop_lipsync_data()
end

function ui:response_signboard_girl_action(msg)
  self:check_play_sound_dialog()
end

function ui:set_ui_visible(is_visible)
  self:reset_btn_show()
  if not is_visible then
    if self.v_gift_panel:visible() then
      self:hide_gift_list(true, true)
    else
      self.v_uiobjects.Ani_HideUI:SetActive(true)
    end
  elseif self.v_cache_show_gift_list then
    self:show_gift_list()
  else
    self.v_uiobjects.UIMainClose_IN:SetActive(true)
  end
  self.v_uiobjects.FullHideBtn:SetActive(not is_visible)
end

function ui:check_play_sound_dialog(msg)
  if msg and msg.mm_x then
    local param_id = msg.mm_x
    if param_id ~= SIGNBOARD_PARAM.CHANGE_ROLE then
      self:set_dialog_enable(false)
      return
    end
  end
  local cur_play_actoin = SignBoardGirlMgr:get_cur_playing_action_cfg()
  if not cur_play_actoin then
    self:set_dialog_enable(false)
    return
  end
  self:set_dialog_enable(true)
  self.v_dialog_panel:change_content(cur_play_actoin.Text)
end

function ui:set_dialog_enable(is_enable)
  self.v_dialog_panel:set_enable(is_enable)
end

function ui:show_signboard_list()
  if self.v_gift_panel:visible() then
    self:hide_gift_list(true)
  else
    self.v_uiobjects.Ani_HideUI:SetActive(false)
    self.v_uiobjects.UIMainClose_IN_GiftOut:SetActive(false)
    self.v_uiobjects.Ani_HideUI:SetActive(true)
  end
  UIMgr:get_ui("signboard_change"):ui_show(self.v_cache_show_gift_list)
end

function ui:hide_signboard_list()
  if self.v_cache_show_gift_list then
    self:show_gift_list()
  else
    SignBoardGirlMgr:send_change_model_view_param(SIGNBOARD_PARAM.CHANGE_ROLE)
    SignBoardGirlMgr:set_cloth_buddy_cache(nil)
    self:reset_btn_show()
    self.v_uiobjects.UIMainClose_IN:SetActive(true)
    self:reset_signboard_girl()
  end
end

function ui:show_gift_list()
  SignBoardGirlMgr:send_change_model_view_param(SIGNBOARD_PARAM.CHOOSE_GIFT)
  self.v_uiobjects.BtnHideGift:SetActive(true)
  self.v_uiobjects.Favor:SetActive(true)
  self.v_gift_panel:set_enable(true, self.v_cur_buddy_id)
  self:reset_btn_show()
  self.v_uiobjects.Ani_GiftRoot_IN:SetActive(true)
  if self.v_cache_show_gift_list then
    self.v_uiobjects.UIMainClose_IN_GiftIn:SetActive(true)
    self.v_cache_show_gift_list = false
  else
    self.v_uiobjects.Ani_HideUI_GiftIn:SetActive(true)
  end
end

function ui:hide_gift_list(cache_show)
  self.v_cache_show_gift_list = cache_show
  self.v_uiobjects.BtnHideGift:SetActive(false)
  self.v_uiobjects.Favor:SetActive(false)
  self:reset_btn_show()
  if cache_show then
    self.v_uiobjects.Ani_HideUI_GiftOut:SetActive(true)
  else
    self.v_uiobjects.UIMainClose_IN_GiftOut:SetActive(true)
    SignBoardGirlMgr:set_cloth_buddy_cache(nil)
    self:reset_signboard_girl()
  end
  self.v_gift_panel:set_enable(false)
  self:refresh_favors()
end

function ui:init_container()
  local root_gameobj = UnityFind("Root")
  Util.assert(root_gameobj)
  self.v_container = root_gameobj:GetComponent(TypeSceneContainer)
  Util.assert(self.v_container)
  self.v_entry_attach = self.v_container:Get("JourneyEntry").transform
  self.v_entry_trans = self.v_uicompents.Entry_rect
  self.v_canvas = self:get_canvas()
  local main_ui = UIMgr:try_get_visible_ui("uimain")
  if main_ui and main_ui.v_model_view then
    self.v_main_ui_camera = main_ui.v_model_view.v_camera
  end
end

function ui:refresh_entry_pos()
  if not self.v_main_ui_camera then
    local main_ui = UIMgr:try_get_visible_ui("uimain")
    if main_ui and main_ui.v_model_view then
      self.v_main_ui_camera = main_ui.v_model_view.v_camera
    end
    if not self.v_main_ui_camera then
      return
    end
  end
  local x, y, z = self.v_entry_attach:GetPositionA()
  local screen_pos_x, screen_pos_y = UtilUI.world_to_screen_pos(self.v_main_ui_camera, self.v_canvas, x, y, z)
  self.v_entry_trans:SetAnchoredPositionA(screen_pos_x, screen_pos_y)
end

function ui:refresh_favors()
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_cur_buddy_id)
  self.v_uicompents.CharFavorability_txt.text = buddy_info.favor_lv
  self.v_uicompents.CharFavorabilityTip_txt.text = "Lv."
  local max_lv = ShareRes.get_max_favor_lv()
  local is_max = max_lv <= buddy_info.favor_lv
  self.v_uiobjects.FavorNumNow:SetActive(not is_max)
  self.v_uiobjects.FavorMax:SetActive(is_max)
  local cfg = ShareRes.get_favor_lv_cfg(self.v_cur_buddy_id, is_max and max_lv or buddy_info.favor_lv)
  self.v_uicompents.CharRelation_txt.text = cfg.Stage
  if is_max then
    self.v_uicompents.FavorBarFill_img.fillAmount = 1
  else
    self.v_uicompents.FavorBarFill_img.fillAmount = buddy_info.favor_exp / cfg.Exp
    self.v_uicompents.FavorNumNow_txt.text = buddy_info.favor_exp
    self.v_uicompents.FavorNumMax_txt.text = cfg.Exp
    self.v_uicompents.CharRelation_txt.text = cfg.Stage
    local final_lv, add_exp = self.v_gift_panel:get_final_lv()
    self.v_uiobjects.FavorBarFillPreview:SetActive(add_exp > 0)
    if add_exp > 0 then
      self.v_uicompents.FavorBarFillPreview_img.fillAmount = (buddy_info.favor_exp + add_exp) / cfg.Exp
      self.v_uicompents.FavorNumNow_txt.text = string.format("<color=#D85D09>%s</color>", buddy_info.favor_exp + add_exp)
      if final_lv > buddy_info.favor_lv then
        self.v_uicompents.CharFavorability_txt.text = string.format("<color=#D85D09>%s</color>", final_lv)
        self.v_uicompents.CharFavorabilityTip_txt.text = "<color=#D85D09>Lv.</color>"
        cfg = ShareRes.get_favor_lv_cfg(self.v_cur_buddy_id, final_lv)
        self.v_uicompents.CharRelation_txt.text = string.format("<color=#D85D09>%s</color>", cfg.Stage)
      end
    end
  end
  self:check_favor_award()
end

function ui:on_favor_up()
  self.v_uiobjects.Ani_CharFavorability:SetActive(false)
  self.v_uiobjects.Ani_CharFavorability:SetActive(true)
  self:refresh_favors()
end

function ui:check_favor_award()
  local has_award = CharacterMgr:check_favor_award(self.v_cur_buddy_id)
  self.v_uiobjects.FavorRed:SetActive(has_award)
end

function ui:get_favor_award()
  local has_award = CharacterMgr:check_favor_award(self.v_cur_buddy_id)
  if has_award then
    local function refresh_cb()
      self:check_favor_award()
    end
    
    CharacterMgr:get_favor_award(self.v_cur_buddy_id, refresh_cb)
  end
end

function ui:show_favor_award()
  UIMgr:get_ui("ui_favor_award_tips"):ui_show(self.v_cur_buddy_id)
end

return ui
