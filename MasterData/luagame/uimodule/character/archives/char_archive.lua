local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local TypeUnityCamera = typeof(UnityEngine.Camera)
local AnimatorType = TypeUnityAnimator
local SIGNBOARD_PARAM = Config.SIGNBOARD_PARAM
local UnityShader = UnityEngine.Shader
local MAIN_SCENE_SHOW_ID = UnityShader.PropertyToID("_MAIN_SCENE_SHOW")
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_archive_pnl = {
    "ArchivePnl",
    BIND_TYPE.OBJECT
  },
  v_archive_red = {
    "ArchiveRed",
    BIND_TYPE.IMAGE
  },
  v_btn_archive = {
    "BtnArchive",
    BIND_TYPE.BUTTON
  },
  v_btn_ret1 = {
    "BtnRet1",
    BIND_TYPE.BUTTON
  },
  v_btn_to_main = {
    "BtnToMain",
    BIND_TYPE.BUTTON
  },
  v_btn_voice = {
    "BtnVoice",
    BIND_TYPE.BUTTON
  },
  v_char_base_info = {
    "CharBaseInfo",
    BIND_TYPE.IMAGE
  },
  v_char_favorability = {
    "CharFavorability",
    BIND_TYPE.TEXT
  },
  v_char_name = {
    "CharName",
    BIND_TYPE.TEXT
  },
  v_char_profile = {
    "CharProfile",
    BIND_TYPE.IMAGE
  },
  v_char_relation = {
    "CharRelation",
    BIND_TYPE.TEXT
  },
  v_favor_bar_fill = {
    "FavorBarFill",
    BIND_TYPE.IMAGE
  },
  v_favor_max = {
    "FavorMax",
    BIND_TYPE.IMAGE
  },
  v_favor_num_max = {
    "FavorNumMax",
    BIND_TYPE.TEXT
  },
  v_favor_num_now = {
    "FavorNumNow",
    BIND_TYPE.TEXT
  },
  v_none_archive = {
    "NoneArchive",
    BIND_TYPE.TEXT
  },
  v_voice_pnl = {
    "VoicePnl",
    BIND_TYPE.OBJECT
  },
  v_voice_red = {
    "VoiceRed",
    BIND_TYPE.IMAGE
  }
}
local Camera_Move_Time = 0.5
local Canvas_Fade_Time = 0.3
local Vec2 = require("base.vec2")
local Archive_Model_Obj_Class = require("uimodule.character.archives.archive_model_obj")
local Model_Text_Name = "ModelText"
local Model_NewTag_Name = "NewTag"
local Model_Attach_Name = "Book"
local Layer = require("utils.layer")
local Transform_state = require("utils.transform_state")
local Input = UnityEngine.Input
local MaxHitLen = 100
local CameraNames = {
  Archive = "ArchiveCamera",
  Voice = "VoiceCamera",
  PadArchive = "PadArchiveCamera",
  PadVoice = "PadVoiceCamera"
}
local CameraNameToId = {ArchiveCamera = 9, VoiceCamera = 10}
local BookIndexs = {
  Book1 = {name = "Book1_", index = 1},
  Book2 = {name = "Book2_", index = 2},
  Book3 = {name = "Book3_", index = 3},
  Book4 = {name = "Book4_", index = 4}
}
local UnityFind = _ENV.UnityFind
local TypeSceneContainer = typeof(CS.Game.SceneContainer)

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_panel_voice = self:get_panel("char_archive_voice")
  local ucpm = self.v_uicompents
  self:set_button_listener(ucpm.BtnToMain_btn, function()
    self.v_uimain:ui_show()
    self.v_uimain:change_model_view_param(SIGNBOARD_PARAM.NORMAL, true)
  end)
  self:set_button_listener(ucpm.BtnRet1_btn, function()
    if self.v_panel_voice:get_object().activeSelf == true then
      self:on_click_archive_in_voice_pnl()
      self.v_panel_voice:hide_pnl()
      return
    end
    self:ui_hide()
  end)
  self:set_button_listener(ucpm.BtnVoice_btn, function()
    CharacterMgr:clear_red(RedEnum.CHAR_CV_VOICE, self.v_buddy_id)
    self:on_click_voice()
  end)
  self:set_button_listener(ucpm.BtnArchive_btn, function()
    CharacterMgr:clear_red(RedEnum.CHAR_ARCHIVE_INFO, self.v_buddy_id)
    self:on_click_bg()
  end)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.VoiceRed, RedEnum.CHAR_CV_VOICE)
  RedPointMgr:bind_redpoint(self, self.v_archive_red, RedEnum.CHAR_ARCHIVE_INFO)
end

function ui:show_anim(cb)
  self:clear_sequence()
  self.v_canvas_grp.blocksRaycasts = true
  self.v_sequence = Util.create_sequence()
  self.v_sequence:AppendInterval(0.3)
  self.v_sequence:Append(self.v_canvas_grp:DOFade(1, Canvas_Fade_Time))
  self.v_sequence:OnComplete(function()
    if cb then
      cb()
    end
  end)
end

function ui:ui_on_show(buddy_id, force_switch_camera)
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 1)
  self.v_show_from_uimain = force_switch_camera
  buddy_id = buddy_id or PlayerMgr:get_signboard_girl_id()
  self.v_buddy_id = buddy_id
  self.v_canvas_grp = self:get_canvas_group(nil, self.v_archive_pnl)
  self.v_canvas_grp.alpha = 0
  self:check_scene_attach()
  self:refresh_ui()
  local uimain = UIMgr:get_ui("uimain")
  uimain:set_control_sign_board(true)
  self.v_uimain = uimain
  self.v_model_view = uimain:get_model_view()
  self.v_uimain:set_model_view_visible(true)
  self.v_uimain:set_signboard_param_type(SIGNBOARD_PARAM.CHAR_ARCHIVE)
  self.v_none_archive:SetActive(false)
  self:show_anim()
  self:move_camera(CameraNames.Archive, force_switch_camera, function()
    local archive_config = ShareRes.get_buddy_archive_groups(self.v_buddy_id)
    if 0 == UtilTable.hash_lenth(archive_config) then
      self.v_none_archive:SetActive(true)
    end
  end)
  self:register_event()
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_BUDDY_ARCHIVE_READ, self.refresh_archive_red, self)
end

function ui:ui_on_update()
  if self.v_model_view then
    self.v_model_view:update()
  end
end

function ui:check_scene_attach()
  if self.v_root_obj and not self.v_root_obj:IsNull() then
    return
  end
  local root_gameobj = UnityFind("Root")
  Util.assert(root_gameobj)
  self.v_root_obj = root_gameobj
  self.v_container = root_gameobj:GetComponent(TypeSceneContainer)
  Util.assert(self.v_container)
end

function ui:move_camera(camera_name, is_fast, callback)
  if camera_name == CameraNames.Archive then
    self.v_uimain:refresh_archive_voice_pos(self.v_btn_archive, self.v_btn_voice)
  else
  end
  local id = CameraNameToId[camera_name]
  if id then
    self.v_uimain:update_camera_state(id)
    local camera_state = self.v_uimain:get_camera_state()
    local key = (camera_state.from or "-1") .. "_" .. (camera_state.to or "-1")
    local pathgroup_cfg = ShareRes.get_signboard_girl_track_table(key)
    if pathgroup_cfg then
      self.v_uimain:play_camera_track_animation(pathgroup_cfg)
      return
    end
  end
  local target_cam_obj = self.v_container:Get(camera_name)
  if not target_cam_obj then
    return
  end
  local cam_trans = target_cam_obj.transform
  local x, y, z = cam_trans:GetPositionA()
  local rot_x, rot_y, rot_z = cam_trans:GetEulerAnglesA3()
  rot_x = rot_x < 0 and rot_x + 360 or rot_x
  rot_y = rot_y < 0 and rot_y + 360 or rot_y
  rot_z = rot_z < 0 and rot_z + 360 or rot_z
  local camera = Util.get_component(nil, target_cam_obj, TypeUnityCamera)
  local fov = camera.fieldOfView
  local camera_param = {
    pos_x = x,
    pos_y = y,
    pos_z = z,
    rot_x = rot_x,
    rot_y = rot_y,
    rot_z = rot_z,
    fov = fov
  }
  self.v_uimain:change_camera_param(camera_param, is_fast, callback, true)
end

function ui:refresh_archive_data()
  self.v_archive_data = {}
  local archive_list = CharacterMgr:get_buddy_archive_data(self.v_buddy_id)
  if not archive_list then
    return
  end
  for _, data in pairs(archive_list) do
    local id = data.archive_id
    self.v_archive_data[id] = data
  end
end

function ui:ui_on_hide()
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 0)
  self.v_uimain:set_control_sign_board(false)
  self:clear_sequence()
  self.v_panel_voice:hide_pnl(true)
end

function ui:refresh_archive_model()
  local style = 1
  local cfg = ShareRes.get_buddy_archive_overview(self.v_buddy_id)
  if cfg and cfg.Style then
    style = cfg.Style
  end
  local rotate = cfg.Rotate
  local pos = cfg.Pos
  local attach_trans = self.v_container:Get(Model_Attach_Name .. 1).transform
  attach_trans:SetActive(true)
  local obj_tans = Util.active_child_but(attach_trans, cfg.Style - 1, true)
  obj_tans:SetEuler(rotate[1], rotate[2], rotate[3])
  obj_tans:SetLocalPositionA(pos[1], pos[2], pos[3])
end

function ui:load_archive_model()
  self.v_models = {}
  self:refresh_archive_data()
  local archive_config = ShareRes.get_buddy_archive_groups(self.v_buddy_id)
  if 0 == UtilTable.hash_lenth(archive_config) then
    self.v_none_archive:SetActive(true)
  else
    self.v_none_archive:SetActive(false)
    for k, v in pairs(BookIndexs) do
      local attach_trans = self.v_container:Get(Model_Attach_Name .. v.index).transform
      local model_obj = Util.active_child_but(attach_trans, 0)
      model_obj:SetActive(false)
    end
    for k, v in pairs(archive_config) do
      local archive_data = self.v_archive_data[v.ID]
      local unlocked = false
      local state
      if archive_data then
        unlocked = true
        state = archive_data.state
      end
      local info = {
        have_red = 0 == state,
        unlocked = unlocked
      }
      local attach_trans = self.v_container:Get(Model_Attach_Name .. tostring(v.Priority)).transform
      local data = {
        info = info,
        cfg = v,
        parent_ui = self,
        trans = attach_trans,
        ui_text = self.v_uicompents[Model_Text_Name .. tostring(v.Priority) .. "_txt"],
        new_tag_obj = self.v_uiobjects[Model_NewTag_Name .. tostring(v.Priority)]
      }
      local lua_obj = Archive_Model_Obj_Class:new(data)
      self.v_models[v.Priority] = lua_obj
    end
  end
end

function ui:refresh_ui()
  local buddy_id = self.v_buddy_id
  local icon = UtilUI.get_hero_images(buddy_id, Config.HERO_ICON_LV.SHOW_IMG)
  ResMgr:load_set_icon(self.v_char_profile, icon)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  self.v_char_name.text = buddy_cfg.Name
  self:refresh_archive_data()
  self:refresh_char_favors(buddy_id)
  self:refresh_voice_red()
  self:refresh_archive_red()
end

function ui:refresh_voice_red()
  CharacterMgr:update_red_state(self.v_buddy_id, RedEnum.CHAR_CV_VOICE)
end

function ui:refresh_archive_red()
  CharacterMgr:update_red_state(self.v_buddy_id, RedEnum.CHAR_ARCHIVE_INFO)
end

function ui:refresh_char_favors(buddy_id)
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  local favor_lv = buddy_info.favor_lv or 0
  local favor_exp = buddy_info.favor_exp or 0
  local favors_cfg = ShareRes.get_favor_lv_cfg(buddy_id, favor_lv)
  local is_max = favor_lv == ShareRes.get_max_favor_lv(buddy_id)
  local favors_state = favors_cfg.Stage
  self.v_favor_num_now:SetActive(not is_max)
  self.v_favor_max:SetActive(is_max)
  self.v_char_relation.text = favors_state
  self.v_char_favorability.text = favor_lv
  if is_max then
    self.v_favor_bar_fill.fillAmount = 1
    return
  end
  local need_exp = favors_cfg.Exp
  self.v_favor_bar_fill.fillAmount = favor_exp / need_exp
  self.v_favor_num_now.text = favor_exp
  self.v_favor_num_max.text = need_exp
end

function ui:on_click_voice()
  self:clear_sequence()
  self:move_camera(CameraNames.Voice)
  self.v_canvas_grp.blocksRaycasts = false
  self.v_sequence = Util.create_sequence()
  self.v_sequence:Append(self.v_canvas_grp:DOFade(0, Canvas_Fade_Time))
  self.v_sequence:OnComplete(function()
    self.v_panel_voice:show_pnl(self.v_buddy_id)
  end)
  self.v_uicompents.Ani_UICharFileMain_Select_In_pd:Play()
end

local vec2_pos = Vec2.New()

function ui:get_click_obj(layer, max_ray_len)
  layer = layer or Layer.LayerMask.UIModelView
  max_ray_len = max_ray_len or MaxHitLen
  vec2_pos.x = Input.mousePosition.x
  vec2_pos.y = Input.mousePosition.y
  local ray = self.v_uimain:screen_point_to_ray(vec2_pos)
  local dir = ray.direction
  local org = ray.origin
  local is_hit, obj = CSHelper.RayCastGameObject(org.x, org.y, org.z, dir.x, dir.y, dir.z, max_ray_len, layer)
  if is_hit and nil ~= obj then
    return obj
  end
end

function ui:on_click_bg()
  UIMgr:get_ui("archive_detail_pop_new"):ui_show(self.v_buddy_id)
end

function ui:on_click_obj(index)
  if index then
    local lua_obj = self.v_models[index]
    if lua_obj then
      lua_obj:on_click(lua_obj:get_archive_id())
    end
  end
end

function ui:on_click_archive_in_voice_pnl()
  self.v_uicompents.Ani_UICharFileMain_Select_Out_pd:Play()
  self:show_anim()
  self:refresh_voice_red()
  self:move_camera(CameraNames.Archive)
end

function ui:clear_sequence()
  if self.v_sequence then
    self.v_sequence:Kill()
    self.v_sequence = nil
  end
end

function ui:get_buddy_id()
  return self.v_buddy_id
end

function ui:is_use_pad_camera()
  local const_rate = 1.5
  local cur_rate = Global.screen_width / Global.screen_height
  return const_rate >= cur_rate
end

return ui
