local Behavior = require("manager.fight.behavior")
local sound_mgr = Global.sound_mgr
local UnityTime = UnityEngine.Time
local _tinsert = table.insert
local _tremove = table.remove
local SOURCE_TYPE = Config.SOURCE_TYPE
local Base = require("uimodule.story.step_base")
local M = Util.create_child_mt(Base)
local CAPTIONS_ANIM_TIME = 0.5

function M:_init(...)
  Base._init(self, ...)
  self.v_time = UnityTime.realtimeSinceStartup
  self.v_delay_cb_list = {}
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
  for index = #self.v_delay_cb_list, 1, -1 do
    local data = self.v_delay_cb_list[index]
    if now_time - self.v_time >= data.delay_time then
      if data.cb then
        data.cb()
      end
      _tremove(self.v_delay_cb_list, index)
    end
  end
end

function M:init_ui()
  local txt_obj = self.v_uicompents.Captions_Talk_content_txt
  txt_obj.text = ""
  self.v_uicompents.CaptionsTalk_rect:SetAnchoredPositionA(0, 81.8)
end

function M:start()
  self.v_show_captions_sq = nil
  self.v_hide_captions_sq = nil
  self.v_play_sound_sq = nil
  self:init_ui()
  local step_cfg = self.v_step_cfg
  if step_cfg.CaptionsTalkX or step_cfg.CaptionsTalkY then
    self.v_uicompents.CaptionsTalk_rect:SetAnchoredPositionA(step_cfg.CaptionsTalkX, step_cfg.CaptionsTalkY + 81.8)
  end
  local layer = step_cfg.Level
  self.v_lua_obj:insert_ui_obj_layer_data(self.v_uiobjects.Talk, layer)
  self:check_play_sound()
  self:update_captions_talk_desc()
  self:show_captions()
  Behavior.set_ui_object_visible("fight", "Main", true)
end

function M:pause_captions_talk(pause)
  if pause then
    if self.v_show_captions_sq ~= nil then
      self.v_show_captions_sq:Pause()
    end
    if nil ~= self.v_hide_captions_sq then
      self.v_hide_captions_sq:Pause()
    end
    if nil ~= self.v_play_sound_sq then
      self.v_play_sound_sq:Pause()
    end
    if self:have_sound() then
      sound_mgr:pause_sound_by_id(self.v_step_cfg.Sound, true, true)
    end
  else
    if self.v_show_captions_sq ~= nil then
      self.v_show_captions_sq:Play()
    end
    if nil ~= self.v_hide_captions_sq then
      self.v_hide_captions_sq:Play()
    end
    if nil ~= self.v_play_sound_sq then
      self.v_play_sound_sq:Play()
    end
    if self:have_sound() then
      sound_mgr:pause_sound_by_id(self.v_step_cfg.Sound, false, true)
    end
  end
end

function M:show_captions()
  local talk_obj = self.v_uiobjects.Talk
  talk_obj:GetComponent("CanvasGroup").alpha = 1
  talk_obj:SetActive(true)
  self.v_uiobjects.NormalTalk:SetActive(false)
  local captions_talk_obj = self.v_uiobjects.CaptionsTalk
  local canvas_group = captions_talk_obj:GetComponent("CanvasGroup")
  canvas_group.alpha = 0
  captions_talk_obj:SetActive(true)
  local stay_time = math.max(self.v_step_cfg.CaptionsTime - 2 * CAPTIONS_ANIM_TIME, 1)
  local sequence = self:get_new_sequence("captions_talk_show_effect")
  self.v_show_captions_sq = sequence
  sequence:AppendInterval(0.05)
  sequence:Append(canvas_group:DOFade(1, CAPTIONS_ANIM_TIME))
  if not self:have_sound() then
    sequence:AppendInterval(stay_time)
    sequence:OnComplete(function()
      self:hide_captions()
    end)
  end
end

function M:hide_captions()
  self:sound_up()
  local captions_talk_obj = self.v_uiobjects.CaptionsTalk
  local canvas_group = captions_talk_obj:GetComponent("CanvasGroup")
  local sequence = self:get_new_sequence("captions_talk_hide_effect")
  self.v_hide_captions_sq = sequence
  sequence:Append(canvas_group:DOFade(0, CAPTIONS_ANIM_TIME))
  sequence:OnComplete(function()
    self.v_uiobjects.Talk:SetActive(false)
    self.v_uiobjects.CaptionsTalk:SetActive(false)
    self:complete()
    local is_must_play = self.v_lua_obj:check_cur_step_must_play()
    if self.v_lua_obj:visible() then
      self.v_lua_obj:check_step_all_complete(is_must_play)
    end
  end)
end

function M:have_sound()
  local sound_name = self.v_step_cfg.Sound
  if not sound_name or "" == sound_name or not sound_mgr then
    return false
  end
  local is_file_exist = sound_mgr:check_sound_name_file_exist(sound_name)
  return is_file_exist
end

function M:check_play_sound()
  if not self:have_sound() then
    return
  end
  local sound_name = self.v_step_cfg.Sound
  self.v_sound_type = sound_mgr:play_sound_by_id(sound_name, nil, function(sound_length_msec)
    self:sound_down()
    local sound_length_seconds = sound_length_msec / 1000
    local cb_data = {
      delay_time = sound_length_seconds,
      cb = function()
        self:hide_captions()
      end
    }
    local sequence = self:get_new_sequence("captions_talk_start_hide")
    self.v_play_sound_sq = sequence
    sequence:AppendInterval(sound_length_seconds)
    sequence:OnComplete(function()
      self:hide_captions()
    end)
  end, nil, SOURCE_TYPE.VOICE)
end

function M:update_captions_talk_desc()
  local step_cfg = self.v_step_cfg
  local txt_obj = self.v_uicompents.Captions_Talk_content_txt
  self.v_lua_obj:cache_talk_data(step_cfg)
  local desc = LanguageMgr:get_story_text(step_cfg.Content)
  local show_name = LanguageMgr:get_story_text(step_cfg.CharName) or ""
  local content = string.format("<color=#BCB4A5>%s: </color>%s", show_name, desc)
  if "" == show_name then
    content = desc
  end
  content = self:replace_talk_content(content)
  txt_obj.text = content
end

function M:complete()
  Base.complete(self)
  self:clean_sequence()
  self:sound_up()
end

function M:sound_down()
  self.v_have_sound_down = true
end

function M:sound_up()
  if self.v_have_sound_down then
    self.v_have_sound_down = nil
  end
end

function M:on_comfirm_skip()
  self:clean_sequence()
  self:sound_up()
end

function M:on_destroy()
  self.v_uiobjects.CaptionsTalk:SetActive(false)
  self:clean_sequence()
  self:sound_up()
end

return M
