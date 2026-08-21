local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local SOUND_STATUS = Config.SOUND_STATUS
local SOURCE_TYPE = Config.SOURCE_TYPE
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_active = {
    "Active",
    BIND_TYPE.IMAGE
  },
  v_condition = {
    "Condition",
    BIND_TYPE.TEXT
  },
  v_lock = {
    "Lock",
    BIND_TYPE.IMAGE
  },
  v_play = {
    "Play",
    BIND_TYPE.BUTTON
  },
  v_playing = {
    "Playing",
    BIND_TYPE.OBJECT
  },
  v_point = {
    "Point",
    BIND_TYPE.IMAGE
  },
  v_red_point = {
    "RedPoint",
    BIND_TYPE.IMAGE
  },
  v_stop_play = {
    "StopPlay",
    BIND_TYPE.BUTTON
  },
  v_unlock = {
    "Unlock",
    BIND_TYPE.OBJECT
  },
  v_voice_name = {
    "VoiceName",
    BIND_TYPE.TEXT
  },
  v_slider = {
    "Slider",
    BIND_TYPE.SLIDER
  }
}
local Light_Star_Color = "292929"
local Light_Star_Color_Alpha = 255
local Dark_Star_Color = "fff0d5"
local Dark_Star_Color_Alpha = 126
local Light_Text_Color = "484243"
local Dark_Text_Color = "f5ede1"
local ease_linear = CS.DG.Tweening.Ease.Linear

function ui:ui_finish_load()
  self:init_model(MODEL)
end

function ui:set_data(data)
  self.v_data = data
  self.v_voice_ui = self.v_data.v_archive_voice_ui
  local is_lock = CharacterMgr.v_voice_list[data.cfg.Id] == nil
  local need_hide = is_lock and 1 == data.cfg.NeedHide
  if need_hide then
    self.v_object:SetActive(false)
    return
  end
  self.v_lock:SetActive(is_lock)
  self.v_unlock:SetActive(not is_lock)
  self.v_slider.gameObject:SetActive(false)
  self.v_playing.gameObject:SetActive(false)
  self.v_active.gameObject:SetActive(false)
  self.v_slider.value = 0
  if is_lock then
    local condition_cfg = ShareRes.create("condition.condition", data.cfg.Condition)
    if condition_cfg then
      self.v_condition.text = condition_cfg.Desc
    else
      Log.Error(" 没有此条件ID =", data.cfg.Condition)
    end
  else
    self.v_red_point:SetActive(not CharacterMgr.v_voice_list[data.cfg.Id].is_read)
    self.v_voice_name.text = data.cfg.Title
    self.v_stop_play.gameObject:SetActive(false)
    self.v_play.gameObject:SetActive(true)
    self:set_button_listener(self.v_play, function()
      self:on_click_play()
    end)
    self:set_button_listener(self.v_stop_play, function()
      self:on_click_stop()
    end)
  end
end

function ui:get_buddy_cv_cfg()
  local buddy_cv_cfg = ShareRes.get_buddy_cv_config(tostring(self.v_data.cfg.Id))
  return buddy_cv_cfg
end

function ui:get_buddy_cfg()
  local buddy_cfg = ShareRes.get_buddy_cfg(self.v_data.cfg.HeroId)
  return buddy_cfg
end

function ui:play_audio(audio_id)
  self:clear_timer()
  self.v_voice_ui.v_static_sv:on_select_change(self)
  Global.sound_mgr:voice_stop()
  if self.v_voice_ui.v_is_playing then
    self:play_audio_id(audio_id)
  else
    self.v_voice_ui:play_cd_ani(true)
    self.v_voice_delay_timer = Timer:add_timer("voice_delay_play", 1, function()
      self:play_audio_id(audio_id)
    end)
  end
end

function ui:play_audio_id(audio_id)
  Global.sound_mgr:play_sound_by_id(audio_id, nil, function(time)
    self.v_play_time = time / 1000
    self.v_voice_ui:on_play_voice_item(self, self.v_play_time)
    self:play_audio_pro(self.v_play_time)
  end)
end

function ui:play_audio_pro(time)
  self:clear_play_audio_pro()
  self.v_audio_pro_seq = Util.create_sequence()
  self.v_audio_pro_seq:Append(self.v_slider:DOValue(1, time):SetEase(ease_linear))
  self.v_audio_pro_seq:AppendCallback(function()
    self.v_slider:SetActive(false)
    self:play_audio_finish()
  end)
end

function ui:play_audio_finish()
  Global.sound_mgr:voice_stop()
  self.v_voice_ui:on_play_voice_finish()
  self:set_selected(false)
  self:clear_play_audio_pro()
end

function ui:clear_play_audio_pro()
  if self.v_audio_pro_seq then
    self.v_audio_pro_seq:Kill()
    self.v_audio_pro_seq = nil
  end
  self:clear_timer()
end

function ui:on_click_play()
  self.v_slider.value = 0
  local cfg = self.v_data.cfg
  local buddy_cv_cfg = ShareRes.get_buddy_cv_config(tostring(cfg.Id))
  if buddy_cv_cfg then
    self:play_audio(buddy_cv_cfg.ChineseSound)
    if not CharacterMgr.v_voice_list[cfg.Id].is_read then
      CharacterMgr:req_read_buddy_voice(cfg.Id, cfg.HeroId, function()
        self.v_red_point:SetActive(false)
      end)
    end
  else
    Log.Error("角色CV音效表 没有此ID =", cfg.Id)
  end
end

function ui:on_click_stop()
  self.v_voice_ui:on_play_voice_finish()
  self:set_selected(false)
  Global.sound_mgr:voice_stop()
end

function ui:set_selected(is_select)
  self.v_playing.gameObject:SetActive(is_select)
  self.v_active.gameObject:SetActive(is_select)
  self.v_slider.gameObject:SetActive(is_select)
  self.v_stop_play.gameObject:SetActive(is_select)
  self.v_play.gameObject:SetActive(not is_select)
  if is_select then
    Util.set_color(self.v_point, Light_Star_Color, Light_Star_Color_Alpha)
    Util.set_color(self.v_voice_name, Light_Text_Color)
  else
    Util.set_color(self.v_point, Dark_Star_Color, Dark_Star_Color_Alpha)
    Util.set_color(self.v_voice_name, Dark_Text_Color)
    self:clear_play_audio_pro()
  end
end

function ui:on_clear()
  self:set_selected(false)
  self:clear_timer()
end

function ui:clear_timer()
  if self.v_voice_delay_timer then
    Timer:remove_timer(self.v_voice_delay_timer)
    self.v_voice_delay_timer = nil
  end
end

return ui
