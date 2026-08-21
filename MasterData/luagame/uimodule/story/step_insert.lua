local Base = require("uimodule.story.step_base")
local M = Util.create_child_mt(Base)
local CSUnityColor = UnityEngine.Color
local UnityTime = UnityEngine.Time
local CSVideoPlayer = typeof(UnityEngine.Video.VideoPlayer)
local RenderTexture = UnityEngine.RenderTexture
local _insert = table.insert
local _remove = table.remove
local CSHelper = _ENV.CSHelper
local scale_x = Global.screen_width / 1920
local scale_y = Global.screen_height / 1080
local CriManaMovieControllerForUI = typeof(CS.CriWare.CriManaMovieControllerForUI)
local CriMoviePlayerStatus = CS.CriWare.CriMana.Player.Status
local EFFECT_TYPE = {DEFAULT = 0, GRADUAL = 1}

function M:_init(...)
  Base._init(self, ...)
  self.v_time = UnityTime.realtimeSinceStartup
  self.v_delay_cb_list = {}
  self.v_need_complete_num = 0
  self.v_is_play_movie = false
  self.v_is_insert = false
  self.v_have_play = nil
end

function M:on_destroy()
  Base.on_destroy(self)
  if not Util.is_nil(self.v_cri_video_player) then
    Util.remove_cri_subtitle_event(self.v_cri_video_player)
    self.v_cri_video_player:Stop()
  end
  if self.v_rtt then
    RenderTexture.ReleaseTemporary(self.v_rtt)
    self.v_rtt = nil
  end
  self.v_uiobjects.Video:SetActive(false)
  self.v_cri_video_player = nil
end

function M:update()
  Base.update(self)
  local now_time = UnityTime.realtimeSinceStartup
  for index = #self.v_delay_cb_list, 1, -1 do
    local data = self.v_delay_cb_list[index]
    if now_time - self.v_time >= data.delay_time then
      if data.cb then
        data.cb()
      end
      _remove(self.v_delay_cb_list, index)
    end
  end
  self:update_cri_video()
end

function M:init_ui()
end

function M:start()
  self:init_ui()
  self.v_play_video_end = false
  self.v_cri_video_player = nil
  self.v_start = false
  self.v_video_end_cb = nil
  local step_cfg = self.v_step_cfg
  local layer = step_cfg.ImgLevel
  self.v_lua_obj:insert_ui_obj_layer_data(self.v_uiobjects.InsertImg, layer)
  local is_img = self:load_img_res()
  local is_cg = self:check_insert_cg()
  if not is_img and not is_cg then
    self:check_complete()
  end
end

function M:load_img_res()
  local step_cfg = self.v_step_cfg
  local res_name = step_cfg.ImgRes
  if not res_name or "" == res_name or "0" == res_name then
    return
  end
  self.v_need_complete_num = self.v_need_complete_num + 1
  local pos_data = step_cfg.ImgPos
  local img_rect = self.v_uicompents.InsertImg_rect
  img_rect:SetAnchoredPositionA(pos_data[1], pos_data[2])
  
  local function load_cb()
    if self.v_lua_obj.v_visible then
      self.v_time = UnityTime.realtimeSinceStartup
      self.v_uicompents.InsertImg_img:SetNativeSize()
      self:update_img_view()
    end
  end
  
  local image = self.v_uicompents.InsertImg_img
  ResMgr:load_set_icon(image, res_name, load_cb, true, self.v_lua_obj)
  return true
end

function M:update_img_view()
  local step_cfg = self.v_step_cfg
  local show_data = step_cfg.Show
  local hide_data = step_cfg.Hide
  local now_time = UnityTime.realtimeSinceStartup
  if show_data.Enable then
    local delay = show_data.Delay
    if delay <= now_time - self.v_time then
      self:show_effect()
    else
      local delat_data = {
        delay_time = delay,
        cb = function()
          self:show_effect()
        end
      }
      _insert(self.v_delay_cb_list, delat_data)
    end
  elseif hide_data.Enable then
    local delay = hide_data.Delay
    if delay <= now_time - self.v_time then
      self:hide_effect()
    else
      local delat_data = {
        delay_time = delay,
        cb = function()
          self:hide_effect()
        end
      }
      _insert(self.v_delay_cb_list, delat_data)
    end
  end
end

function M:show_effect()
  local show_fcg = self.v_step_cfg.Show
  local effect_type = show_fcg.Effect
  local image_obj = self.v_uiobjects.InsertImg
  local canvas = image_obj:GetComponent("CanvasGroup")
  image_obj:SetActive(true)
  canvas.alpha = 0
  if effect_type == EFFECT_TYPE.DEFAULT then
    canvas.alpha = 1
    self.v_need_complete_num = self.v_need_complete_num - 1
    self:check_complete()
  elseif effect_type == EFFECT_TYPE.GRADUAL then
    local sequence = self:get_new_sequence("step_insert_show_effect")
    sequence:Append(canvas:DOFade(1, show_fcg.AnimTime))
    sequence:OnComplete(function()
      self.v_need_complete_num = self.v_need_complete_num - 1
      self:check_complete()
    end)
  end
end

function M:hide_effect()
  local hide_cfg = self.v_step_cfg.Hide
  local effect_type = hide_cfg.Effect
  local image_obj = self.v_uiobjects.InsertImg
  local canvas = image_obj:GetComponent("CanvasGroup")
  if effect_type == EFFECT_TYPE.DEFAULT then
    image_obj:SetActive(false)
    canvas.alpha = 0
    self.v_need_complete_num = self.v_need_complete_num - 1
    self:check_complete()
  elseif effect_type == EFFECT_TYPE.GRADUAL then
    local sequence = self:get_new_sequence("step_insert_hide_effect")
    sequence:Append(canvas:DOFade(0, hide_cfg.AnimTime))
    sequence:OnComplete(function()
      image_obj:SetActive(false)
      self.v_need_complete_num = self.v_need_complete_num - 1
      self:check_complete()
    end)
  end
end

function M:check_insert_cg()
  self.v_play_video_end = false
  local movie = self.v_step_cfg.AnimRes
  if not movie or "" == movie or "0" == movie then
    return
  end
  self.v_need_complete_num = self.v_need_complete_num + 1
  
  local function on_step_callback()
    if not Util.is_nil(self.v_cri_video_player) then
      Util.remove_cri_subtitle_event(self.v_cri_video_player)
      self.v_cri_video_player:Stop()
    end
    self.v_uiobjects.Video:SetActive(false)
    self:set_up_collect_status()
    self.v_need_complete_num = self.v_need_complete_num - 1
    self.v_is_play_movie = false
    self:check_complete()
    if self.v_lua_obj:visible() then
      self.v_lua_obj:check_step_all_complete()
    end
  end
  
  self.v_uiobjects.Video:SetActive(true)
  self.v_uiobjects.BtnSkip:SetActive(false)
  self:set_up_collect_status()
  if not self.v_rtt then
    self.v_rtt = CompExtensions.GetUIRT(1920, 1080, "StoryCG")
  end
  movie = movie:gsub(".mp4", ".usm")
  self.v_video_name = movie
  local path = VideoMgr:get_path(movie)
  self:play_cri_video(path)
  VideoMgr:check_and_play_sound(movie)
  self.v_temp_story_speed = self.v_story_speed
  self.v_lua_obj:reset_story_speed()
  local raw_img = Util.get_rawimage(nil, self.v_uiobjects.Video)
  raw_img.texture = self.v_rtt
  self.v_video_end_cb = on_step_callback
  self:play_insert_talk_step()
  local fade_or_show_time = 1.2
  raw_img.color = Util.ColorWhite
  local start_color = Util.ColorWhite
  self.v_raw_img = raw_img
  
  local function set_value_func(v)
    raw_img.color = start_color * v
  end
  
  local sequence = self:get_new_sequence("step_insert_movie_effect")
  if self.v_step_cfg.AnimShow then
    sequence:Append(CSHelper.WrapTweenTo(0, 1, fade_or_show_time, set_value_func))
  end
  self.v_start_color = 1
  return true
end

function M:play_cri_video(video_path)
  self.v_start = false
  self.v_cri_video_player = self.v_uiobjects.Video:GetComponent(CriManaMovieControllerForUI)
  if Util.is_nil(self.v_cri_video_player) then
    self.v_cri_video_player = self.v_uiobjects.Video:AddComponent(CriManaMovieControllerForUI)
    self.v_cri_video_player.useOriginalMaterial = true
  end
  self.v_cri_video_player.player:SetFile(nil, video_path)
  Util.set_cri_video_track(self.v_cri_video_player, self.v_video_name)
  self.v_cri_video_player.player:SetVolume(BattleSettingMgr:get_voice_main())
  self.v_cri_video_player.maxFrameDrop = CS.CriWare.CriManaMovieMaterialBase.MaxFrameDrop.Five
  NextFrameMgr:add_next_update(function()
    self.v_cri_video_player:Play()
    self.v_start = true
  end)
end

function M:set_up_collect_status()
  local video_visible = false
  if self.v_uiobjects.Video then
    video_visible = self.v_uiobjects.Video.activeSelf
  end
  local title_black_bg = Util.get_child_gameobj("Up_/Bg", self.v_uiobjects.UpCollect)
  if video_visible then
    title_black_bg:SetActive(false)
    self.v_uiobjects.Skip.gameObject:SetActive(false)
  else
    title_black_bg:SetActive(true)
    self.v_uiobjects.Skip.gameObject:SetActive(true)
  end
end

function M:update_cri_video()
  if not self.v_start then
    return
  end
  if not self.v_cri_video_player then
    return
  end
  if self.v_play_video_end then
    return
  end
  if self.v_cri_video_player.player.status == CriMoviePlayerStatus.PlayEnd and self.v_video_end_cb then
    self.v_video_end_cb()
    self.v_video_end_cb = nil
    if self.v_temp_story_speed and self.v_lua_obj:visible() then
      self.v_lua_obj:set_story_speed(self.v_temp_story_speed)
      self.v_lua_obj:refresh_story_speed_view(self.v_temp_story_speed)
      self.v_temp_story_speed = nil
    end
  end
end

function M:play_insert_talk_step()
  if self.v_is_insert then
    return
  end
  local insert_talk_step = self.v_step_cfg.InsertTalkingStep
  if not insert_talk_step or #insert_talk_step <= 0 then
    return
  end
  
  local function cb()
    self:check_complete()
  end
  
  self.v_is_insert = true
  local step_idx_list = {}
  for _, jump_id in ipairs(insert_talk_step) do
    step_idx_list[#step_idx_list + 1] = self.v_lua_obj:get_jump_step_idx(jump_id)
  end
  self.v_lua_obj:play_insert_step_mod(step_idx_list, cb)
end

function M:check_complete()
  if self.v_need_complete_num > 0 then
    return
  end
  if not self.v_lua_obj:check_default_mod() then
    return
  end
  self:complete()
end

function M:get_curr_step_sound_list()
  if not self.v_step_all_cfg then
    return
  end
  if not self.v_step_all_cfg.Sound then
    return
  end
  local sound_list = self.v_step_all_cfg.Sound.SoundDatas
  if not sound_list or #sound_list <= 0 then
    return
  end
  local result_list
  for i, sound_data in pairs(sound_list) do
    if sound_data.ShowSound == true and sound_data.Sound ~= nil and sound_data.Sound ~= "" then
      result_list = result_list or {}
      table.insert(result_list, sound_data)
    end
  end
  return result_list
end

return M
