local Base = require("uimodule.story.step_base")
local M = Util.create_child_mt(Base)
local STORY_BG_TALK_KEY = "STORY_BG_TALK_KEY"
local DESC_EFFECT_TYPE = {DEFAULT = 0, GARBLED = 1}
local TXT_ALIGNMENT = {
  [1] = 0,
  [2] = 1,
  [3] = 2
}
local INIT_POS_Y = 0
local INIT_POS_X = 100
local TALK_PHASE = 1
local ease_linear = CS.DG.Tweening.Ease.Linear
local ScrambleMode = CS.DG.Tweening.ScrambleMode
local FadeText = typeof(CS.Game.FadeText)
local STORY_CONFIG = require("uimodule.story.story_config")
local Vec2 = require("base.vec2")
local SINGLE_TEXT_WIDTH = 33
local SINGLE_TEXT_HIGHT = 60
local BASE_OFFSETX = -10
local BASE_OFFSETY = 10
local _floor = math.floor
local _ceil = math.ceil
local TIME_DEFAULT_LEN = 15
local TIME_GARBLED_LEN = 10
local TIME_DEFAULT_LEN2 = 20
local MIN_SPEED = STORY_CONFIG.FADE_TXT_DEFAULT_SPEED
local GARBLED_SPEED = STORY_CONFIG.GARBLED_DEFAULT_SPEED
local SPEED_UP = 35
local CLICK_SPEED = 100

function M:_init(...)
  Base._init(self, ...)
  self.v_talk_obj_map = {}
  TALK_PHASE = 1
end

function M:on_destroy()
  Base.on_destroy(self)
  self:release_timer()
  self.v_uiobjects.Talk_bg:SetActive(false)
end

function M:speed_up(speed)
  Base.speed_up(self)
  if self.v_txt_obj then
    local fade_text = self.v_txt_obj.gameObject:GetComponent(FadeText)
    fade_text.AnimSpeed = SPEED_UP
  end
end

function M:speed_none()
  Base.speed_none(self, GARBLED_SPEED)
  if self.v_txt_obj then
    local fade_text = self.v_txt_obj.gameObject:GetComponent(FadeText)
    fade_text.AnimSpeed = MIN_SPEED
  end
end

function M:down_btn()
  Base.down_btn(self)
  if self.v_cur_fade_complete then
    self:update_talk_phase()
    return
  end
  if self.v_txt_obj then
    local fade_text = self.v_txt_obj.gameObject:GetComponent(FadeText)
    fade_text.AnimSpeed = CLICK_SPEED
  end
end

function M:up_btn()
  Base.up_btn(self)
  if self.v_txt_obj then
    local fade_text = self.v_txt_obj.gameObject:GetComponent(FadeText)
    fade_text.AnimSpeed = MIN_SPEED
  end
end

function M:click_auto_btn()
  self:check_auto_next_desc()
end

function M:init_ui()
  self.v_uiobjects.Talk_bg:SetActive(true)
  self.v_cur_pos = 0
end

function M:start()
  self:init_ui()
  local step_cfg = self.v_step_cfg
  local first_pos_y = step_cfg.FirstLinePos or INIT_POS_Y
  self.v_uicompents.TalkList_rect:SetAnchoredPositionA(INIT_POS_X, first_pos_y)
  self.v_uicompents.TalkList_rect.offsetMax = Vec2.New(-INIT_POS_X, self.v_uicompents.TalkList_rect.offsetMax.y)
  self.v_uiobjects.Talk_bg.transform:SetSiblingIndex(step_cfg.Level)
  self.v_uiobjects.NormalTalk:SetActive(false)
  self:check_play_sound()
  self:update_bg_talk_desc()
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

function M:update_bg_talk_desc()
  self.v_lua_obj:give_back_auto_cache(STORY_BG_TALK_KEY)
  local step_cfg = self.v_step_cfg
  local desc_effect = step_cfg.ContentShowType
  local talk_list = Util.split_str(LanguageMgr:get_story_text(step_cfg.Content), "&")
  local talk_pos = step_cfg.BgTalkPos
  local talk_set_pos = step_cfg.BgTalkSetPos
  self.v_talk_set_pos = {}
  if talk_pos and next(talk_pos) then
    for index, talk_pos_val in ipairs(talk_pos) do
      self.v_talk_set_pos[talk_pos_val] = talk_set_pos[index]
    end
  end
  if step_cfg.UseNoteText then
    local temp_length = 0
    local target_index = 1
    for index, info in ipairs(talk_list) do
      temp_length = temp_length + Util.get_string_len(info)
      target_index = index
      if temp_length > step_cfg.NoteTextPos then
        break
      end
    end
    self.v_target_index = target_index
  end
  self.v_talk_list = talk_list
  self.v_desc_effect = desc_effect
  self:update_talk_phase()
end

function M:update_talk_phase()
  if self.v_last_index and self.v_last_index == TALK_PHASE then
    return
  end
  self.v_cur_fade_complete = false
  local step_cfg = self.v_step_cfg
  local desc = self.v_talk_list[TALK_PHASE]
  if not desc then
    self:complete()
    return
  end
  local cache_obj = self.v_lua_obj:get_auto_cache(STORY_BG_TALK_KEY)
  local note_obj = Util.get_child_gameobj("Note", cache_obj)
  local fade_text = cache_obj:GetComponent(FadeText)
  fade_text.enabled = false
  fade_text.OnPlayEnd = nil
  self.v_txt_obj = Util.get_text(nil, cache_obj)
  self.v_txt_obj.text = ""
  note_obj:SetActive(false)
  desc = self:replace_talk_content(desc)
  self.v_desc = desc
  self.v_last_index = TALK_PHASE
  self.v_txt_obj.alignment = TXT_ALIGNMENT[self.v_talk_set_pos[TALK_PHASE] or 1]
  self.v_lua_obj:cache_talk_data({
    Content = desc,
    Sound = self.v_step_cfg.Sound,
    TextAnchor = TXT_ALIGNMENT[self.v_talk_set_pos[TALK_PHASE] or 1]
  })
  if not self.v_desc_effect or self.v_desc_effect == DESC_EFFECT_TYPE.DEFAULT then
    self:desc_effect_default()
  elseif self.v_desc_effect == DESC_EFFECT_TYPE.GARBLED then
    self:desc_effect_garbled()
    cache_obj:SetActive(true)
  end
end

function M:desc_effect_default()
  self.v_txt_obj.text = self.v_desc
  local fade_text = self.v_txt_obj.gameObject:GetComponent(FadeText)
  
  local function cb()
    TALK_PHASE = TALK_PHASE + 1
    fade_text.enabled = false
    fade_text.OnPlayEnd = nil
    self:check_auto_next_desc()
    self.v_cur_fade_complete = true
  end
  
  fade_text.OnPlayEnd = cb
  fade_text.enabled = true
  local string_len = Util.get_string_len(self.v_desc)
  local speed = string_len / TIME_DEFAULT_LEN
  MIN_SPEED = math.max(speed, MIN_SPEED)
  fade_text.AnimSpeed = MIN_SPEED
  self.v_cur_pos = self.v_cur_pos + string_len
  local step_cfg = self.v_step_cfg
  if step_cfg.UseNoteText and self.v_target_index == TALK_PHASE then
    local set_pos = step_cfg.NoteTextPos - (self.v_cur_pos - string_len)
    local sequence = self:get_new_sequence("desc_bg_effect_default")
    local note_obj = Util.get_child_gameobj("Note", self.v_txt_obj.gameObject)
    local txt_rect = Util.get_rect_transform(nil, self.v_txt_obj.gameObject)
    local note_rect = Util.get_rect_transform(nil, note_obj)
    local note_txt = Util.get_text(nil, note_obj)
    local width = Global.screen_width
    local set_num = set_pos
    local txt_num = _floor(width / SINGLE_TEXT_WIDTH)
    local txt_row = _floor(set_num / txt_num)
    note_rect.anchoredPosition = Vec2.New(SINGLE_TEXT_WIDTH * (set_num - txt_row * txt_num) + BASE_OFFSETX, -(txt_row * SINGLE_TEXT_HIGHT) + BASE_OFFSETY)
    note_obj:SetActive(true)
    note_txt.text = ""
    local note_desc = step_cfg.NoteText
    local insert_note_time = set_num / TIME_DEFAULT_LEN2
    local show_note_time = 3 / TIME_DEFAULT_LEN2
    sequence:Insert(insert_note_time, note_txt:DOText(note_desc, show_note_time, true):SetEase(ease_linear))
  end
end

function M:desc_effect_garbled()
  local function cb()
    TALK_PHASE = TALK_PHASE + 1
    
    self:check_auto_next_desc()
    self.v_cur_fade_complete = true
  end
  
  local string_len = Util.get_string_len(self.v_desc)
  local sequence = self:get_new_sequence("desc_bg_effect_garbled")
  local time = string_len / TIME_GARBLED_LEN
  sequence.timeScale = GARBLED_SPEED
  sequence:Append(self.v_txt_obj:DOText(self.v_desc, time, true, ScrambleMode.All))
  sequence:OnComplete(cb)
end

function M:check_auto_next_desc()
  if self.v_timer then
    return
  end
  self.v_timer = Timer:add_timer("check_auto_next_desc", 0.5, function()
    self:release_timer()
    if self.v_lua_obj:check_auto() then
      self:update_talk_phase()
    end
  end)
end

function M:release_timer()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
end

return M
