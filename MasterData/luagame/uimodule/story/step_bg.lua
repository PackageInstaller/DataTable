local UnityTime = UnityEngine.Time
local CSScreen = UnityEngine.Screen
local DESIGN_RATIO = 1.7777777777777777
local STORY_BG_MAX_LAYER = 2
local DOTweenLoopType = CS.DG.Tweening.LoopType
local Vec3 = require("base.vec3")
local Base = require("uimodule.story.step_base")
local M = Util.create_child_mt(Base)
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local DEFAULT_LAYER = 0
local EXTRA_BG_ANIM_TYPE = {SHOW_EXTRA_BG = 0, END_EXTRA_BG = 1}
local EXTRA_BG_END_ANIM_TYPE = {
  RECOVER = 0,
  FULL_SCREEN = 1,
  DISAPPEAR = 2
}
local SHAKE_STYLE = {
  DEFAULT = 0,
  LOW_SHAKE = 1,
  MID_SHAKE = 2,
  HIGH_SHAKE = 3
}
local EXTRA_BG_SHOW_ANIM_LENGTH = 200
local EXTRA_MASK_LOC = 3000

function M:_init(...)
  Base._init(self, ...)
end

function M:on_destroy()
  Base.on_destroy(self)
  self:revert_ui_pos()
  self:revert_bg_pos()
  self.v_lua_obj:stop_storybg_shake()
end

function M:revert_ui_pos()
  if not self.v_step_cfg.IsShake then
    return
  end
  local rect = Util.get_rect_transform(nil, self.v_uiobjects.StoryBg)
  rect:SetAnchoredPositionA(0, 0)
end

function M:revert_bg_pos()
  if not self.v_step_cfg.HasExtraBg then
    return
  end
  self.v_storybg_rect:SetAnchoredPositionA(0, 0)
  self.v_extrabg_rect:SetAnchoredPositionA(self.v_step_cfg.ExtraBgPosX, self.v_step_cfg.ExtraBgPosY)
  self.v_uicompents.FullScreenBackground_img.enabled = false
end

function M:down_btn()
  Base.down_btn(self)
  self.v_is_click_end = true
  self:check_complete()
end

function M:update()
  Base.update(self)
  self:check_play_insert_anim()
end

function M:start()
  local step_cfg = self.v_step_cfg
  local bg_canvas_group = self.v_uiobjects.StoryBg:GetComponent("CanvasGroup")
  bg_canvas_group.alpha = 1
  local is_hide_bg = step_cfg.HideBg
  self.v_uiobjects.FullBg:SetActive(not is_hide_bg)
  local layer = step_cfg.Level
  self.v_lua_obj:insert_ui_obj_layer_data(self.v_uiobjects.StoryBg, layer)
  self.v_is_click_end = false
  self.v_complete_data = {
    is_shake = false,
    is_hide_bg = false,
    is_show_bg = false,
    is_hide_location = false,
    is_show_extra_bg = false,
    is_end_extra_bg = false
  }
  if not step_cfg.HasExtraBg then
    self.v_complete_data.is_show_extra_bg = true
    self.v_complete_data.is_end_extra_bg = true
  else
    self.v_uiobjects.ExtraBgObj:SetActive(true)
    self.v_uiobjects.ExtraBgMask:SetActive(true)
    self.v_storybg_rect = self.v_storybg_rect or Util.get_rect_transform(nil, self.v_uiobjects.StoryBg)
    self.v_extrabg_rect = self.v_extrabg_rect or Util.get_rect_transform(nil, self.v_uiobjects.ExtraBgObj)
    self.v_extra_bg_canvas = self.v_extra_bg_canvas or self.v_uiobjects.ExtraBg:GetComponent("CanvasGroup")
    if step_cfg.ExtraBgAnimType == EXTRA_BG_ANIM_TYPE.SHOW_EXTRA_BG then
      self.v_storybg_rect:SetAnchoredPositionA(0, EXTRA_BG_SHOW_ANIM_LENGTH)
      self.v_extrabg_rect:SetAnchoredPositionA(step_cfg.ExtraBgPosX, step_cfg.ExtraBgPosY - EXTRA_BG_SHOW_ANIM_LENGTH)
      self.v_uiobjects.ExtraBgMask.transform:SetAnchoredPositionA(0, 0, 0)
      self.v_extrabg_rect:SetLocalScaleA(step_cfg.ExtraBgScale)
      self.v_uicompents.FullScreenBackground_img.enabled = true
      self.v_extra_bg_canvas.alpha = 1
    end
  end
  self.v_insert_anim = {}
  self.v_play_anim_data = nil
  self:set_location()
  local is_use_spine = step_cfg.IsUseSpine
  if not is_use_spine then
    self:load_bg_res(step_cfg)
  else
    self:load_spine_bg()
  end
  self.v_lua_obj:stop_storybg_shake()
  self.v_lua_obj:on_story_bg_change(self.v_step_cfg.Image)
end

function M:extrabg_show_anim(step_cfg, bg)
  if not step_cfg.HasExtraBg or step_cfg.ExtraBgAnimType ~= EXTRA_BG_ANIM_TYPE.SHOW_EXTRA_BG then
    self.v_complete_data.is_show_extra_bg = true
    self:check_complete()
    return
  end
  
  local function load_cb()
    local sequence = self:get_new_sequence("extrabg_show_anim")
    sequence:Join(self.v_storybg_rect:DOAnchorPosY(0, step_cfg.ExtraBgAnimHoldTime))
    sequence:Join(self.v_extrabg_rect:DOAnchorPosY(step_cfg.ExtraBgPosY, step_cfg.ExtraBgAnimHoldTime))
    sequence:OnComplete(function()
      self.v_complete_data.is_show_extra_bg = true
      self:revert_bg_pos()
      self:check_complete()
    end)
  end
  
  ResMgr:load_set_icon(self.v_uicompents.ExtraBg_img, step_cfg.ExtraBg, load_cb, true, self.v_lua_obj)
end

function M:extrabg_end_anim(step_cfg)
  if not step_cfg.HasExtraBg or step_cfg.ExtraBgAnimType ~= EXTRA_BG_ANIM_TYPE.END_EXTRA_BG then
    self.v_complete_data.is_end_extra_bg = true
    self:check_complete()
    return
  end
  if self.v_uiobjects.ExtraBgObj.activeSelf then
    local sequence = self:get_new_sequence("extrabg_end_anim")
    local extra_mask_rect = Util.get_rect_transform(nil, self.v_uiobjects.ExtraBgMask)
    if step_cfg.ExtraBgEndAnimType == EXTRA_BG_END_ANIM_TYPE.RECOVER then
      sequence:Append(extra_mask_rect:DOAnchorPosX(EXTRA_MASK_LOC, step_cfg.ExtraBgAnimHoldTime))
    elseif step_cfg.ExtraBgEndAnimType == EXTRA_BG_END_ANIM_TYPE.FULL_SCREEN then
      sequence:Append(extra_mask_rect:DOAnchorPosX(-EXTRA_MASK_LOC, step_cfg.ExtraBgAnimHoldTime))
    else
      sequence:Append(self.v_extra_bg_canvas:DOFade(0, step_cfg.ExtraBgAnimHoldTime))
    end
    sequence:OnComplete(function()
      self.v_complete_data.is_end_extra_bg = true
      self:revert_bg_pos()
      self:check_complete()
    end)
  else
    self.v_complete_data.is_end_extra_bg = true
    self:revert_bg_pos()
    self:check_complete()
  end
end

function M:shake_anim(step_cfg)
  if not step_cfg.IsShake then
    self.v_complete_data.is_shake = true
    self:check_complete()
    return
  end
  local shake_cfg = step_cfg.ShakeData
  
  local function shake_cb()
    self.v_complete_data.is_shake = true
    self.v_lua_obj:stop_storybg_shake()
    self:check_complete()
  end
  
  local time = shake_cfg[1]
  local force = shake_cfg[2]
  local shake_times = shake_cfg[3]
  local random = shake_cfg[4] or 0
  local transform = self.v_uiobjects.StoryBg.transform
  self:revert_ui_pos()
  local sequence = self:get_new_sequence("bg_shake_anim")
  local shake_vec = Vec3.New(0, force, 0)
  if step_cfg.shakeDelay and step_cfg.shakeDelay > 0 then
    sequence:AppendInterval(step_cfg.shakeDelay)
  end
  if step_cfg.shakeStyle == SHAKE_STYLE.DEFAULT then
    sequence:Append(transform:DOShakePosition(time, shake_vec, shake_times, random, true))
    if step_cfg.IsLoopShake then
      sequence:SetLoops(-1, DOTweenLoopType.Restart)
      shake_cb()
    else
      sequence:OnComplete(shake_cb)
    end
  else
    sequence:AppendCallback(function()
      self.v_lua_obj:play_storybg_shake(step_cfg.shakeStyle)
    end)
    sequence:AppendInterval(self.v_lua_obj:get_storybg_shake_duration(step_cfg.shakeStyle))
    if step_cfg.shakeHoldTime and step_cfg.shakeHoldTime > 0.1 then
      sequence:AppendInterval(step_cfg.shakeHoldTime)
    end
    sequence:AppendCallback(function()
      self.v_lua_obj:play_storybg_shake(step_cfg.shakeStyle, true)
    end)
    sequence:AppendInterval(self.v_lua_obj:get_storybg_shake_duration(step_cfg.shakeStyle, true))
    sequence:OnComplete(shake_cb)
  end
end

function M:update_bg_ui(use_bg_layer, is_use_spine)
  self.v_uiobjects.BlackBg:SetActive(true)
  self.v_uiobjects.BlackBg.transform:SetSiblingIndex(0)
  local bg_obj = self.v_uiobjects["StoryBg" .. use_bg_layer]
  if is_use_spine then
    bg_obj = self.v_uiobjects["StorySpineBg" .. use_bg_layer]
  end
  bg_obj:SetActive(true)
  bg_obj.transform:SetSiblingIndex(1)
  local canvas = bg_obj:GetComponent("CanvasGroup")
  canvas.alpha = 0
end

function M:load_bg_res(step_cfg)
  local use_bg_layer = self.v_lua_obj:get_cur_bg_layer()
  self:update_bg_ui(use_bg_layer)
  local img_obj = self.v_uicompents["StoryBg" .. use_bg_layer .. "_img"]
  self:image_grey(img_obj, step_cfg.Grey)
  local fade_out_time = step_cfg.FadeTime
  local fade_in_time = step_cfg.FadeInTime
  local bg_res = step_cfg.Image
  local bg_img = self.v_uicompents["StoryBg" .. use_bg_layer .. "_img"]
  self:fade_out_bg(use_bg_layer, fade_out_time)
  
  local function load_cb()
    if self.v_lua_obj.v_visible then
      self:fade_in_bg(use_bg_layer, fade_in_time)
      self:shake_anim(step_cfg)
      self:extrabg_show_anim(step_cfg, bg_img)
      self:extrabg_end_anim(step_cfg)
      self.v_uiobjects.BlackBg:SetActive(false)
    end
  end
  
  ResMgr:load_set_icon(bg_img, bg_res, load_cb, true, self.v_lua_obj)
  local rect = Util.get_rect_transform(nil, bg_img.gameObject)
  rect:SetAnchoredPositionA(0, 0)
  bg_img.gameObject.transform:SetLocalScaleA(1, 1, 1)
end

function M:load_spine_bg()
  if not self.v_step_cfg then
    return
  end
  local step_cfg = self.v_step_cfg
  local res_name = step_cfg.Image
  local use_bg_layer = self.v_lua_obj:get_cur_bg_layer()
  self:update_bg_ui(use_bg_layer, true)
  local img_obj = self.v_uiobjects["StorySpineBg" .. use_bg_layer]
  local fade_out_time = step_cfg.FadeTime
  local fade_in_time = step_cfg.FadeInTime
  local scale = step_cfg.BgScale
  if step_cfg.NotFullImage ~= true and CSScreen.width / CSScreen.height > DESIGN_RATIO then
    scale = scale * (CSScreen.width * 1080 / (CSScreen.height * 1920))
  end
  self:fade_out_bg(use_bg_layer, fade_out_time)
  
  local function cb(obj)
    self.v_uiobjects.BlackBg:SetActive(false)
    obj:ResetAttr()
    obj.transform:SetLocalScaleA(scale, scale, scale)
    obj.transform:SetLocalPositionA(step_cfg.BgPosX, step_cfg.BgPosY, step_cfg.BgPosZ)
    if self.v_lua_obj.v_visible then
      self:fade_in_bg(use_bg_layer, fade_in_time)
      self:shake_anim(step_cfg)
      self:extrabg_show_anim(step_cfg, img_obj)
      self:extrabg_end_anim(step_cfg)
    end
    self:update_bg_anim(img_obj)
  end
  
  if not step_cfg.IsNoSwitchBgIdx then
    self.v_lua_obj:load_bg_spine_res(img_obj, res_name, cb)
  else
    self.v_uiobjects.BlackBg:SetActive(false)
    if self.v_lua_obj.v_visible then
      local bg_obj = self.v_uiobjects["StorySpineBg" .. use_bg_layer]
      local canvas = bg_obj:GetComponent("CanvasGroup")
      canvas.alpha = 1
      self.v_complete_data.is_show_bg = true
      self:check_complete()
      local camera = Global.camera
      if camera then
        local enable_camera = self.v_step_cfg.NotFullImage == true or bg_obj.activeInHierarchy == false
        camera:set_enable_camera(enable_camera)
      end
      self:shake_anim(step_cfg)
      self:extrabg_show_anim(step_cfg, img_obj)
      self:extrabg_end_anim(step_cfg)
    end
    self:update_bg_anim(img_obj)
  end
end

function M:fade_out_bg(select_layer, fade_out_time)
  local step_cfg = self.v_step_cfg
  local is_use_spine = step_cfg.IsUseSpine
  for layer = 1, STORY_BG_MAX_LAYER do
    if layer ~= select_layer then
      local bg_obj = self.v_uiobjects["StoryBg" .. layer]
      local key = "bg_fade_out" .. layer
      self:bg_hide_sequence(key, bg_obj, fade_out_time)
      bg_obj = self.v_uiobjects["StorySpineBg" .. layer]
      key = "spine_bg_fade_out" .. layer
      self:bg_hide_sequence(key, bg_obj, fade_out_time)
    end
  end
end

function M:bg_hide_sequence(key, bg_obj, fade_out_time)
  fade_out_time = fade_out_time or 0
  local canvs_grp = bg_obj:GetComponent("CanvasGroup")
  
  local function cb()
    self.v_complete_data.is_hide_bg = true
    self:check_complete()
  end
  
  if 0 == fade_out_time then
    canvs_grp.alpha = 0
    cb()
  else
    function self.v_set_alpha_call_back()
      if not Util.is_nil(canvs_grp) then
        canvs_grp.alpha = 0
      end
    end
    
    local sequence = self:get_new_sequence(key)
    sequence:Append(canvs_grp:DOFade(0, fade_out_time))
    sequence:OnComplete(cb)
  end
end

function M:fade_in_bg(select_layer, fade_in_time)
  local step_cfg = self.v_step_cfg
  local is_use_spine = step_cfg.IsUseSpine
  local bg_obj, key
  if not is_use_spine then
    bg_obj = self.v_uiobjects["StoryBg" .. select_layer]
    key = "bg_fade_in" .. select_layer
  else
    bg_obj = self.v_uiobjects["StorySpineBg" .. select_layer]
    key = "spine_bg_fade_in" .. select_layer
  end
  self:bg_show_sequence(key, bg_obj, fade_in_time)
end

function M:bg_show_sequence(key, bg_obj, fade_in_time)
  fade_in_time = fade_in_time or 0
  local canvas_grp = bg_obj:GetComponent("CanvasGroup")
  
  local function cb()
    self.v_complete_data.is_show_bg = true
    self:check_complete()
    local camera = Global.camera
    if camera then
      local enable_camera = true == self.v_step_cfg.NotFullImage or bg_obj.activeInHierarchy == false
      camera:set_enable_camera(enable_camera)
    end
  end
  
  if 0 == fade_in_time then
    canvas_grp.alpha = 1
    cb()
  else
    local spine_sequence = self:get_new_sequence(key)
    spine_sequence:Append(canvas_grp:DOFade(1, fade_in_time))
    spine_sequence:OnComplete(cb)
  end
end

function M:check_complete()
  if self.v_is_click_end then
    if self.v_set_alpha_call_back then
      self.v_set_alpha_call_back()
    end
    self:complete()
    return
  end
  for _, complete in pairs(self.v_complete_data) do
    if not complete then
      return
    end
  end
  if self.v_play_anim_data and not self.v_play_anim_data.is_end then
    return
  end
  self.v_lua_obj:stop_storybg_shake()
  if self.v_set_alpha_call_back then
    self.v_set_alpha_call_back()
  end
  self:complete()
end

function M:set_location()
  local step_cfg = self.v_step_cfg
  local show_location = LanguageMgr:get_story_text(step_cfg.LocationName) ~= nil and LanguageMgr:get_story_text(step_cfg.LocationName) ~= ""
  local location_obj = self.v_uiobjects.Location
  location_obj:SetActive(show_location)
  if not show_location then
    self.v_complete_data.is_hide_location = true
    return
  end
  self.v_uicompents.LocationName_txt.text = LanguageMgr:get_story_text(step_cfg.LocationName)
  local location_canvas_group = location_obj:GetComponent("CanvasGroup")
  local name_bg_object = self.v_uiobjects.LocationNameBg
  local name_canvas_group = name_bg_object:GetComponent("CanvasGroup")
  location_canvas_group.alpha = 0
  name_canvas_group.alpha = 0
  local org_pos = name_bg_object.transform.anchoredPosition
  local sequence = self.v_lua_obj:get_new_sequence("location_anim")
  sequence:AppendInterval(step_cfg.FadeInTime)
  sequence:Append(location_canvas_group:DOFade(1, 0.5))
  sequence:Append(name_canvas_group:DOFade(1, 0.5))
  sequence:Join(name_canvas_group.transform:DOAnchorPosX(org_pos.x + 10, 0.5))
  sequence:AppendInterval(2.0)
  sequence:Append(location_canvas_group:DOFade(0, 0.5))
  sequence:OnComplete(function()
    name_bg_object.transform.anchoredPosition = org_pos
    self.v_complete_data.is_hide_location = true
    location_obj:SetActive(false)
    self:check_complete()
  end)
end

function M:update_bg_anim(img_obj)
  local step_cfg = self.v_step_cfg
  local loop_anim = step_cfg.BgLoopAnimName
  if not loop_anim or "" == loop_anim then
    return
  end
  local res_name = step_cfg.Image
  res_name = Path.get_spine_name(res_name)
  local spine_rt = self.v_lua_obj:get_bg_spine(img_obj)
  if spine_rt then
    spine_rt:play_loop_anim(res_name, loop_anim)
  end
  local insert_anim = step_cfg.InsertAnimList
  if not insert_anim or #insert_anim <= 0 then
    return
  end
  self.v_insert_anim = insert_anim
end

function M:check_play_insert_anim()
  if not self.v_insert_anim or #self.v_insert_anim <= 0 then
    return
  end
  if not self.v_play_anim_data then
    self.v_play_anim_data = {
      cur_idx = 1,
      is_end = false,
      delay_time = {},
      playing_list = {},
      playing_time = {},
      mix_duration = {}
    }
  end
  local now_time = Global.real_time
  local play_data = self.v_play_anim_data
  local idx = play_data.cur_idx
  local anim_data = self.v_insert_anim[idx]
  if not anim_data then
    play_data.is_end = true
    self:check_complete()
    return
  end
  if self.v_is_click_end then
    idx = #self.v_insert_anim
    anim_data = self.v_insert_anim[idx]
    play_data.cur_idx = idx
  end
  play_data.delay_time[idx] = play_data.delay_time[idx] or now_time
  local cfg_delay_time = anim_data.InsertAnimDelay / self.v_story_speed
  local delay_time = play_data.delay_time[idx]
  local is_playing = play_data.playing_list[idx]
  if not is_playing and cfg_delay_time > now_time - delay_time then
    return
  end
  local use_bg_layer = self.v_lua_obj:get_cur_bg_layer()
  local img_obj = self.v_uiobjects["StorySpineBg" .. use_bg_layer]
  local step_cfg = self.v_step_cfg
  local res_name = step_cfg.Image
  local life_time = (anim_data.InsertAnimLifeTime - (play_data.mix_duration[idx] and play_data.mix_duration[idx] + 0.1 or 0)) / self.v_story_speed
  local start_time = play_data.playing_time[idx]
  play_data.playing_list[idx] = true
  if start_time then
    local time_pass = now_time - start_time
    if life_time <= time_pass then
      play_data.cur_idx = idx + 1
    end
  else
    local spine_rt = self.v_lua_obj:get_bg_spine(img_obj)
    play_data.playing_time[idx] = now_time - Global.delta_time
    if nil ~= spine_rt then
      play_data.mix_duration[idx] = spine_rt:get_default_mix_duration(res_name)
      if anim_data.InsertAnim and anim_data.InsertAnim ~= "" then
        spine_rt:play_anim(res_name, anim_data.InsertAnim, true, 3, nil, nil, self.v_story_speed)
      end
    end
  end
end

return M
