local UnityTime = UnityEngine.Time
local ease_linear = CS.DG.Tweening.Ease.Linear
local ScrambleMode = CS.DG.Tweening.ScrambleMode
local UnityRawImage = UnityEngine.UI.RawImage
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local FadeText = typeof(CS.Game.FadeText)
local LOGIC_FRAME = Config.LOGIC_FRAME
local TIME_DEFAULT_LEN2 = 20
local Math = require("base.mathx")
local _clamp = Math.Clamp
local Base = require("uimodule.story.step_base")
local M = Util.create_child_mt(Base)
local SHOW_EFFECT_TYPE = {DEFAULT = 0, GRADIENT = 1}
local DESC_EFFECT_TYPE = {DEFAULT = 0, GARBLED = 1}
local SEQUENCE_TIME = 0.6
local TIME_DEFAULT_LEN = 5
local TIME_GARBLED_LEN = 10
local STORY_CONFIG = require("uimodule.story.story_config")
local MIN_SPEED = STORY_CONFIG.FADE_TXT_DEFAULT_SPEED
local GARBLED_SPEED = STORY_CONFIG.GARBLED_DEFAULT_SPEED
local SPEED_UP = 35
local CLICK_SPEED = 100
local MAX_CHAR_NUM = STORY_CONFIG.MAX_CHAR_NUM
local BACKGROUND_BLUR_TYPE = STORY_CONFIG.BACKGROUND_BLUR_TYPE
local TextMeshProType = typeof(CS.TMPro.TextMeshProUGUI)

function M:_init(...)
  Base._init(self, ...)
  self.v_time = UnityTime.realtimeSinceStartup
end

function M:on_destroy()
  Base.on_destroy(self)
  self.v_uiobjects.FightTalk:SetActive(false)
end

function M:update()
  Base.update(self)
  local now_time = UnityTime.realtimeSinceStartup
  if self.v_dalay_time and now_time - self.v_time >= self.v_dalay_time then
    if self.v_delay_cb then
      self.v_delay_cb()
      self.v_delay_cb = nil
    end
    self.v_dalay_time = nil
  end
  self:update_scene_blur_effect()
end

function M:init_ui()
  self.v_fade_text = self.v_uiobjects.FTContent
  self.v_ft_content = self.v_uiobjects.FTContent:GetComponent(TextMeshProType)
  self.v_ft_content.text = ""
  self.v_ft_name = self.v_uiobjects.FTName:GetComponent(TextMeshProType)
  self.v_ft_name.text = ""
  self.v_uiobjects.FightTalk:SetActive(true)
  self.v_uiobjects.Talk:SetActive(false)
end

function M:speed_up()
  Base.speed_up(self)
end

function M:speed_none()
  Base.speed_none(self, GARBLED_SPEED)
end

function M:down_btn()
  Base.down_btn(self)
end

function M:up_btn()
  Base.up_btn(self)
end

function M:start()
  self:init_ui()
  self:init_talk_pos()
  local step_cfg = self.v_step_cfg
  local layer = step_cfg.Level
  self.v_lua_obj:insert_ui_obj_layer_data(self.v_uiobjects.FightTalk, layer)
  self.v_complete_data = {is_desc_effect = false, is_blur = false}
  self:update_talk_view()
  local blur_fade_time = step_cfg.FadeTime or 0
  self.v_blur_fade_time = blur_fade_time
  self.v_last_blur_time = 0
  local background_type = step_cfg.BackgroundBlurType
  if background_type == BACKGROUND_BLUR_TYPE.SHOW then
    self:show_background_blur()
  elseif background_type == BACKGROUND_BLUR_TYPE.HIDE then
    self:hide_background_blur()
  else
    self.v_complete_data.is_blur = true
    self:check_complete()
  end
end

function M:check_complete()
  for _, val in pairs(self.v_complete_data) do
    if not val then
      return
    end
  end
  self:complete()
end

function M:init_talk_pos()
  local pos_x = self.v_step_cfg.SceneTalkPosX
  local pos_y = self.v_step_cfg.SceneTalkPosY
  local talk_obj = self.v_uiobjects.FightTalk
  talk_obj.transform:SetAnchoredPositionA(pos_x, pos_y)
end

function M:update_talk_view()
  local step_cfg = self.v_step_cfg
  local show_effect = step_cfg.ShowEffect
  local hide_effect = step_cfg.HideEffect
  if show_effect and show_effect.Enable then
    local delay_time = show_effect.Delay
    if delay_time and 0 ~= delay_time then
      self.v_dalay_time = delay_time
      
      function self.v_delay_cb()
        self:show_effect()
      end
    else
      self:show_effect()
    end
  elseif hide_effect and hide_effect.Enable then
    local delay_time = hide_effect.Delay
    if delay_time and 0 ~= delay_time then
      self.v_dalay_time = delay_time
      
      function self.v_delay_cb()
        self:hide_effect()
      end
    else
      self:hide_effect()
    end
  end
end

function M:show_effect()
  local talk_obj = self.v_uiobjects.FightTalk
  local canvas = talk_obj:GetComponent("CanvasGroup")
  local step_cfg = self.v_step_cfg
  local show_effect_data = step_cfg.ShowEffect
  local effect_type = show_effect_data.Effect
  
  local function callback()
    self:shake_anim()
    self:update_talk_desc()
  end
  
  talk_obj:SetActive(true)
  if effect_type == SHOW_EFFECT_TYPE.DEFAULT then
    canvas.alpha = 1
    callback()
  elseif effect_type == SHOW_EFFECT_TYPE.GRADIENT then
    canvas.alpha = 0
    local sequence = self:get_new_sequence("talk_show_effect")
    sequence:Append(canvas:DOFade(1, SEQUENCE_TIME))
    sequence:OnComplete(callback)
  end
end

function M:hide_effect()
  local talk_obj = self.v_uiobjects.FightTalk
  local canvas = talk_obj:GetComponent("CanvasGroup")
  local step_cfg = self.v_step_cfg
  local hide_effect_data = step_cfg.HideEffect
  local effect_type = hide_effect_data.Effect
  
  local function callback()
    self:shake_anim()
    self.v_complete_data.is_desc_effect = true
    self:check_complete()
  end
  
  if effect_type == SHOW_EFFECT_TYPE.DEFAULT then
    talk_obj:SetActive(false)
    canvas.alpha = 0
    callback()
  elseif effect_type == SHOW_EFFECT_TYPE.GRADIENT then
    local sequence = self:get_new_sequence("talk_hide_effect")
    sequence:Append(canvas:DOFade(0, SEQUENCE_TIME))
    sequence:OnComplete(function()
      talk_obj:SetActive(false)
      callback()
    end)
  end
end

function M:shake_anim()
  local step_cfg = self.v_step_cfg
  if not step_cfg.IsShake then
    return
  end
  local shake_data = step_cfg.ShakeData
  local time = shake_data[1]
  local force = shake_data[2]
  local shake_times = shake_data[3]
  local random = shake_data[4]
  local transform = self.v_uiobjects.FightTalk.transform
  local sequence = self:get_new_sequence("bg_shake_anim")
  sequence:Append(transform:DOShakePosition(time, force, shake_times, random, true))
end

function M:update_char_state()
  local step_cfg = self.v_step_cfg
  if step_cfg.IsNoEffect then
    return
  end
  local show_char_list = {}
  for _, id in pairs(step_cfg.TalkPos) do
    show_char_list[id] = true
  end
  for index = 1, MAX_CHAR_NUM do
    local image, char_ui
    local grey_val = show_char_list[index] and 255 or 100
    if self.v_lua_obj:check_cur_step_use_spine_res() then
      char_ui = self.v_uiobjects["CharRt" .. index]
      if char_ui then
        image = Util.get_component(nil, char_ui, UnityRawImage)
      end
    else
      image = self.v_uicompents["CharImg" .. index .. "_img"]
    end
    if image then
      self:image_grey(image, grey_val)
    end
  end
end

function M:check_play_sound()
  local sound_name = self.v_step_cfg.Sound
  if not sound_name or "" == sound_name then
    return
  end
  if Global.sound_mgr then
    Global.sound_mgr:play_sound_by_id(sound_name)
  end
end

function M:update_talk_desc()
  local step_cfg = self.v_step_cfg
  local desc_effect = step_cfg.ContentShowType
  local show_name = LanguageMgr:get_story_text(step_cfg.CharName) or ""
  local show_char_icon = step_cfg.CharIcon or ""
  self.v_ft_name.text = show_name
  self.v_txt_obj = self.v_ft_content
  self:check_play_sound()
  local rect = Util.get_rect_transform(nil, self.v_uiobjects.Talk_name)
  LayoutRebuilder.ForceRebuildLayoutImmediate(rect)
  local obj = Util.get_child_gameobj("Image", self.v_uiobjects.Talk_name)
  obj:SetActive("" ~= show_name)
  self.v_lua_obj:cache_talk_data(step_cfg)
  if "" ~= show_char_icon then
    ResMgr:load_set_icon(self.v_uicompents.FightCharHeadIcon_img, show_char_icon)
    self.v_uicompents.Line_rect.offsetMin = UnityVector2(253, self.v_uicompents.Line_rect.offsetMin.y)
  else
    self.v_uicompents.Line_rect.offsetMin = UnityVector2(285, self.v_uicompents.Line_rect.offsetMin.y)
  end
  self.v_uiobjects.FightCharHeadBg:SetActive("" ~= show_char_icon)
  if not desc_effect or desc_effect == DESC_EFFECT_TYPE.DEFAULT then
    self:desc_effect_default()
  elseif desc_effect == DESC_EFFECT_TYPE.GARBLED then
    self:desc_effect_default()
  end
end

function M:desc_effect_default()
  local step_cfg = self.v_step_cfg
  local desc = LanguageMgr:get_story_text(step_cfg.Content)
  local talk_next = Util.get_child_gameobj("Talk_next", self.v_uiobjects.FightTalk)
  talk_next:SetActive(false)
  desc = self:replace_talk_content(desc)
  
  local function cb()
    self.v_uiobjects.Talk_next:SetActive(true)
    self.v_complete_data.is_desc_effect = true
    self:check_complete()
  end
  
  self.v_txt_obj.text = ""
  local string_len = Util.get_string_len(desc)
  if step_cfg.hasStyledText then
    string_len = step_cfg.ContentLength
  end
  local sequence = self:get_new_sequence("desc_fighttalkeffect_default")
  local time = string_len / TIME_DEFAULT_LEN2
  sequence:Append(CSHelper.WrapTextTweenTo(self.v_txt_obj.gameObject, desc, time))
  local sound_name = self.v_step_cfg.Sound
  if not sound_name or "" == sound_name then
    sequence:AppendCallback(function()
      talk_next:SetActive(true)
    end)
    sequence:AppendInterval(0.6)
  end
  sequence:OnComplete(cb)
end

function M:blur_complete()
  self.v_blur_show = false
  self.v_blur_hide = false
  self.v_radius = nil
  self.v_val = nil
  self.v_complete_data.is_blur = true
  self:check_complete()
end

function M:show_background_blur()
  local ui_cfg = self.v_lua_obj.v_cfg
  local blur_obj = self.v_uiobjects.Blur
  local canvas = blur_obj:GetComponent("CanvasGroup")
  local last_blur_state = self.v_lua_obj:get_blur_state()
  local init_val = last_blur_state and 1 or 0
  local fade_time = self.v_blur_fade_time
  if fade_time > 0 then
    local num = fade_time * 20
    self.v_val = 1 / num
    self.v_blur_show = true
    self.v_radius = init_val
  else
    self.v_radius = nil
    CSHelper.SetSceneGaussianBlur(1, 2, 1)
    self:blur_complete()
  end
  self.v_lua_obj:set_blur_state(true)
end

function M:update_scene_blur_effect()
  if not self.v_radius or not self.v_val then
    return
  end
  if self.v_blur_show then
    self.v_radius = self.v_radius + self.v_val
  elseif self.v_blur_hide then
    self.v_radius = self.v_radius - self.v_val
  end
  self.v_radius = _clamp(self.v_radius, -1, 1)
  CSHelper.SetSceneGaussianBlur(self.v_radius, 2, 1)
  self.v_last_blur_time = self.v_last_blur_time + LOGIC_FRAME
  if self.v_last_blur_time >= self.v_blur_fade_time then
    self:blur_complete()
  end
end

function M:hide_background_blur()
  local fade_time = self.v_blur_fade_time
  if fade_time > 0 then
    local num = fade_time * 20
    self.v_val = 1 / num
    self.v_radius = 1
    self.v_blur_hide = true
  else
    self.v_radius = nil
    CSHelper.SetSceneGaussianBlur(-1, 0, 0)
    self:blur_complete()
  end
  self.v_lua_obj:set_blur_state(false)
end

return M
