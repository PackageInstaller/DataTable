local SpineController = typeof(CS.Game.SpineController)
local Base = require("uimodule.story.step_base")
local M = Util.create_child_mt(Base)
local Vec2 = require("base.vec2")
local Vec3 = require("base.vec3")
local UnityTime = UnityEngine.Time
local _tinsert = table.insert
local _remove = table.remove
local UnityRawImage = UnityEngine.UI.RawImage
local MASK_TYPE = typeof(UnityEngine.UI.Mask)
local CHARACTER_POS = 5
local EFFECT_TYPE = {
  DEFAULT = 0,
  GRADUAL = 1,
  EXTEND_EFFECT = 2
}
local CHAR_POS = {
  [1] = {x = -768, y = 0},
  [2] = {x = -384, y = 0},
  [3] = {x = 0, y = 0},
  [4] = {x = 384, y = 0},
  [5] = {x = 768, y = 0}
}
local NO_SPINE_POSY = -217
local TRACK_TYPE = {
  BODY = 1,
  EYES = 2,
  MOUTH = 3
}
local CHAR_PATH = "hero/"
local SEQENCE_TIME = 0.6
local EXTEND_SHOW_TIME = 0.5
local EXTEND_HIDE_TIME = 0.5
local SHOW_EFFECT_POS = Vec2.New(738, 1080)
local HIDE_EFFECT_POS = Vec2.New(150, 1080)
local SHOW_BG_POS = Vec2.New(789, 1080)
local HIDE_BG_POS = Vec2.New(170, 1080)
local SHOW_FRAME_POS = Vec2.New(743, 1080)
local HIDE_FRAME_POS = Vec2.New(164, 1080)
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")

function M:_init(...)
  Base._init(self, ...)
  self:check_use_config_pos()
  self.v_time = UnityTime.realtimeSinceStartup
  self.v_delay_cb_list = {}
  self.v_complete_data = {}
end

function M:on_destroy()
  self.v_revert_anim = true
  if self.v_char_list then
    for _, char_data in pairs(self.v_char_list) do
      self:update_anim_info(char_data)
    end
  end
  Base.on_destroy(self)
  if self.v_spine then
    ResPoolMgr:release(self.v_spine)
    self.v_spine = nil
  end
  self:revert_char_ui()
end

function M:revert_char_ui()
  local step_cfg = self.v_step_cfg
  local char_list = step_cfg.CharacterInfos
  for _, char_data in ipairs(char_list) do
    local role_pos = char_data.RolePos
    local show_effect = char_data.ShowEffect
    local hide_effect = char_data.HideEffect
    if show_effect.Enable then
      self:set_ui_state(role_pos, true)
    elseif hide_effect.Enable then
      self:set_ui_state(role_pos, false)
    end
  end
end

function M:set_ui_state(role_pos, is_show)
  local char_ui = self.v_uiobjects["Char" .. role_pos]
  if not self.v_is_spine then
    char_ui = self.v_uiobjects["CharImg" .. role_pos]
  end
  local canvas = char_ui:GetComponent("CanvasGroup")
  char_ui:SetActiveEx(is_show)
  local alpha = is_show and 1 or 0
  canvas.alpha = alpha
end

function M:down_btn()
  Base.down_btn(self)
  self.v_is_click_end = true
  if self.v_char_list then
    for _, char_data in pairs(self.v_char_list) do
      self:update_anim_info(char_data)
    end
  end
  self:check_complete()
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
  if self.v_char_list then
    for _, char_data in pairs(self.v_char_list) do
      self:update_anim_info(char_data)
    end
  end
end

function M:init_ui()
end

function M:start()
  local step_cfg = self.v_step_cfg
  local parent_layer = step_cfg.ParentLevel
  local char_list_obj = self.v_uiobjects.CharList
  char_list_obj:SetActive(true)
  self.v_lua_obj:insert_ui_obj_layer_data(char_list_obj, parent_layer)
  self:init_ui()
  self.v_is_click_end = false
  self.v_revert_anim = false
  self.v_body_anim_record = {}
  self.v_eye_anim_record = {}
  self.v_mouth_anim_record = {}
  self.v_loaded_record = {}
  self.v_is_spine = self.v_lua_obj:check_cur_step_use_spine_res()
  local char_list = step_cfg.CharacterInfos
  self.v_char_num = #char_list
  self.v_char_list = char_list
  self.v_complete_num = 0
  for _, char_data in ipairs(char_list) do
    self:update_char_view(char_data)
  end
end

function M:update_char_view(char_data)
  local sub_lv = char_data.SubLevel
  local role_pos = char_data.RolePos
  self.v_complete_data[char_data.RolePos] = {
    is_show_effect = false,
    is_hide_effect = false,
    is_move = false,
    is_anim = false
  }
  local char_ui
  if self.v_is_spine then
    char_ui = self.v_uiobjects["Char" .. role_pos]
    local char_ui_trans = char_ui.transform
    char_ui_trans:SetParent(self.v_uiobjects.CharList.transform)
    self:load_char_spine_res(char_data)
    local change_parent_name = char_data.ChangeParentName
    if change_parent_name and "" ~= change_parent_name then
      local parent_ui = self.v_uiobjects[change_parent_name]
      if parent_ui then
        local anchorMin = char_ui_trans.anchorMin
        local anchorMax = char_ui_trans.anchorMax
        char_ui_trans:SetParent(parent_ui.transform)
        char_ui_trans.anchorMin = anchorMin
        char_ui_trans.anchorMax = anchorMax
      end
    end
  else
    char_ui = self.v_uiobjects["CharImg" .. role_pos]
    self:load_char_img_res(char_data)
  end
  char_ui.transform:SetSiblingIndex(sub_lv)
end

function M:load_char_spine_res(char_data)
  local role_pos = char_data.RolePos
  local role_res = char_data.RoleImg
  local char_img_obj = self.v_uiobjects["CharRt" .. role_pos]
  local def_pos_info = CHAR_POS[role_pos]
  local show_effect = char_data.ShowEffect
  if show_effect and show_effect.Enable and def_pos_info then
    self.v_uicompents["Char" .. role_pos .. "_rect"]:SetAnchoredPositionA(def_pos_info.x, def_pos_info.y)
  end
  local img = Util.get_component(nil, char_img_obj, UnityRawImage)
  if 0 ~= char_data.Grey then
    self:image_grey(img, char_data.Grey)
  end
  local loop_anim_name = char_data.LoopAnimName
  local loop_anim_name1 = char_data.LoopAnimName1
  local pos_info = char_data.PosInfo
  local scale = 0 ~= pos_info[4] and pos_info[4] or 1
  
  local function load_cb(obj)
    local spine_component = obj:GetComponent(SpineController)
    if char_data.IsReset and spine_component and not spine_component:IsNull() then
      spine_component:ClearBodyTrack(true)
    end
    if char_data.IsBodyReset and spine_component and not spine_component:IsNull() then
      spine_component:ClearBodyTrack()
    end
    local spine_rt = self.v_lua_obj:get_spine_rt_view(role_pos)
    if spine_rt then
      if not loop_anim_name1 or "" == loop_anim_name1 then
        spine_rt:play_loop_anim(role_res, loop_anim_name)
      else
        spine_rt:play_anim(role_res, loop_anim_name, false, 0, 0)
        spine_rt:add_animation(role_res, loop_anim_name1, true, 0, 0)
      end
    end
    self.v_time = UnityTime.realtimeSinceStartup
    obj:ResetAttr()
    obj.transform:SetLocalScaleA(scale, scale, scale)
    obj.transform:SetLocalPositionA(pos_info[1], pos_info[2], pos_info[3])
    self.v_loaded_record[role_pos] = true
    self:update_anim_info(char_data)
    if self.v_lua_obj.v_visible then
      self:update_effect(char_data)
    end
  end
  
  self.v_lua_obj:load_spine_res(role_res, role_pos, load_cb)
end

function M:load_char_img_res(char_data)
  local role_pos = char_data.RolePos
  local role_img = char_data.RoleImg
  local char_img_obj = self.v_uicompents["CharImg" .. role_pos .. "_img"]
  self.v_complete_data[role_pos].is_anim = true
  local def_pos_info = CHAR_POS[role_pos]
  local show_effect = char_data.ShowEffect
  if show_effect and show_effect.Enable and def_pos_info then
    self.v_uicompents["CharImg" .. role_pos .. "_rect"]:SetAnchoredPositionA(def_pos_info.x, NO_SPINE_POSY)
  end
  if 0 ~= char_data.Grey then
    self:image_grey(char_img_obj, char_data.Grey)
  end
  
  local function callback()
    if self.v_lua_obj.v_visible then
      self:update_effect(char_data)
    end
  end
  
  local path = CHAR_PATH .. role_img
  ResMgr:load_set_icon(char_img_obj, path, callback, true, self.v_lua_obj)
end

function M:update_effect(char_data)
  local show_effect = char_data.ShowEffect
  local hide_effect = char_data.HideEffect
  local now_time = UnityTime.realtimeSinceStartup
  local complete_data = self.v_complete_data[char_data.RolePos]
  local is_insert = false
  local delay_time, cb
  if show_effect.Enable then
    delay_time = show_effect.Delay
    if delay_time <= now_time - self.v_time then
      self:show_effect(char_data)
    else
      is_insert = true
      
      function cb()
        self:show_effect(char_data)
      end
    end
    complete_data.is_hide_effect = true
  elseif hide_effect.Enable then
    delay_time = hide_effect.Delay
    if delay_time <= now_time - self.v_time then
      self:hide_effect(char_data)
    else
      is_insert = true
      
      function cb()
        self:hide_effect(char_data)
      end
    end
    complete_data.is_show_effect = true
  else
    complete_data.is_hide_effect = true
    complete_data.is_show_effect = true
  end
  if is_insert then
    local cb_data = {delay_time = delay_time, cb = cb}
    _tinsert(self.v_delay_cb_list, cb_data)
  end
  if char_data.IsMove then
    self:char_move(char_data)
  else
    complete_data.is_move = true
    self:check_complete()
  end
end

function M:show_effect(char_data)
  local show_effect = char_data.ShowEffect
  local role_pos = char_data.RolePos
  local char_ui = self.v_uiobjects["Char" .. role_pos]
  if not self.v_is_spine then
    char_ui = self.v_uiobjects["CharImg" .. role_pos]
  end
  self.v_uiobjects["SpineBg" .. role_pos]:SetActive(false)
  local canvas = char_ui:GetComponent("CanvasGroup")
  local effect_type = show_effect.Effect
  char_ui:SetActive(true)
  canvas.alpha = 0
  local mask_obj = self.v_uiobjects["CharMask" .. role_pos]
  local mask_component = mask_obj:GetComponent(MASK_TYPE)
  if role_pos <= CHARACTER_POS then
    mask_component.enabled = false
  end
  local bg_obj = self.v_uiobjects["CharBg" .. role_pos]
  local frame_obj = self.v_uiobjects["CharFrame" .. role_pos]
  bg_obj:SetActive(false)
  frame_obj:SetActive(false)
  if not effect_type or effect_type == EFFECT_TYPE.DEFAULT then
    canvas.alpha = 1
    self:spine_show_effect_complete(char_data.RolePos)
  elseif effect_type == EFFECT_TYPE.GRADUAL then
    local seqence = self:get_new_sequence("step_char_effect_gradual" .. role_pos)
    seqence:Append(canvas:DOFade(1, SEQENCE_TIME))
    seqence:OnComplete(function()
      self:spine_show_effect_complete(char_data.RolePos)
    end)
  elseif effect_type == EFFECT_TYPE.EXTEND_EFFECT then
    mask_component.enabled = true
    bg_obj:SetActive(true)
    frame_obj:SetActive(true)
    mask_obj.transform:SetSizeDeltaA(HIDE_EFFECT_POS.x, HIDE_EFFECT_POS.y)
    canvas.alpha = 1
    bg_obj.transform:SetSizeDeltaA(HIDE_BG_POS.x, HIDE_BG_POS.y)
    frame_obj.transform:SetSizeDeltaA(HIDE_FRAME_POS.x, HIDE_FRAME_POS.y)
    
    local function sequence_cb()
      local seqence = self:get_new_sequence("char_show_effect_extend" .. role_pos)
      seqence:Append(mask_obj.transform:DOSizeDelta(SHOW_EFFECT_POS, EXTEND_SHOW_TIME))
      seqence:Insert(bg_obj.transform:DOSizeDelta(SHOW_BG_POS, EXTEND_SHOW_TIME))
      seqence:Insert(frame_obj.transform:DOSizeDelta(SHOW_FRAME_POS, EXTEND_SHOW_TIME))
      seqence:OnComplete(function()
        self:spine_show_effect_complete(char_data.RolePos)
      end)
    end
    
    local bg_res = char_data.ShowBgRes
    if not Util.is_empty(bg_res) then
      local img_obj = self.v_uicompents["SpineBg" .. role_pos .. "_img"]
      
      local function cb()
        self.v_uiobjects["SpineBg" .. role_pos]:SetActive(true)
        img_obj.transform:SetLocalPositionA(char_data.ShowBgPosX, char_data.ShowBgPosY, char_data.ShowBgPosZ)
        sequence_cb()
      end
      
      ResMgr:load_set_icon(img_obj, bg_res, cb, true)
    else
      sequence_cb()
    end
  end
end

function M:spine_show_effect_complete(rolePos)
  self.v_complete_data[rolePos].is_show_effect = true
  self:check_complete()
end

function M:hide_effect(char_data)
  local hide_effect = char_data.HideEffect
  local role_pos = char_data.RolePos
  local char_ui = self.v_uiobjects["Char" .. role_pos]
  if not self.v_is_spine then
    char_ui = self.v_uiobjects["CharImg" .. role_pos]
  end
  local canvas = char_ui:GetComponent("CanvasGroup")
  local effect_type = hide_effect.Effect
  local mask_obj = self.v_uiobjects["CharMask" .. role_pos]
  local mask_component = mask_obj:GetComponent(MASK_TYPE)
  if role_pos <= CHARACTER_POS then
    mask_component.enabled = false
  end
  if not effect_type or effect_type == EFFECT_TYPE.DEFAULT then
    canvas.alpha = 0
    char_ui:SetActive(false)
    self:spine_hide_effect_complete(char_data.RolePos)
  elseif effect_type == EFFECT_TYPE.GRADUAL then
    local seqence = self:get_new_sequence("step_char_hide_effect" .. role_pos)
    seqence:Append(canvas:DOFade(0, SEQENCE_TIME))
    seqence:AppendCallback(function()
      char_ui:SetActive(false)
      self:spine_hide_effect_complete(char_data.RolePos)
    end)
  elseif effect_type == EFFECT_TYPE.EXTEND_EFFECT then
    mask_component.enabled = true
    local transform = mask_obj.transform
    local bg_trans = self.v_uiobjects["CharBg" .. role_pos].transform
    local frame_trans = self.v_uiobjects["CharFrame" .. role_pos].transform
    local seqence = self:get_new_sequence("char_hide_effect_extend" .. role_pos)
    seqence:Append(transform:DOSizeDelta(HIDE_EFFECT_POS, EXTEND_HIDE_TIME))
    seqence:Insert(bg_trans:DOSizeDelta(HIDE_BG_POS, EXTEND_HIDE_TIME))
    seqence:Insert(frame_trans:DOSizeDelta(HIDE_FRAME_POS, EXTEND_HIDE_TIME))
    seqence:Append(canvas:DOFade(0, EXTEND_HIDE_TIME))
    seqence:OnComplete(function()
      char_ui:SetActive(false)
      self.v_uiobjects["SpineBg" .. role_pos]:SetActive(false)
      self:spine_hide_effect_complete(char_data.RolePos)
    end)
  end
end

function M:spine_hide_effect_complete(rolePos)
  self.v_complete_data[rolePos].is_hide_effect = true
  self:check_complete()
end

function M:char_move(char_data)
  local move_data = char_data.MoveData
  local move_pos = CHAR_POS[move_data[2]]
  local move_time = move_data[3] or 0.5
  local rect = self.v_uicompents["Char" .. char_data.RolePos .. "_rect"]
  local pos_y = move_pos.y
  if not self.v_is_spine then
    rect = self.v_uicompents["CharImg" .. char_data.RolePos .. "_rect"]
    pos_y = NO_SPINE_POSY
  end
  local new_pos = Vec2.New(move_pos.x, pos_y)
  local sequence = self:get_new_sequence("step_chap_move_pos" .. char_data.RolePos)
  sequence:Append(rect:DOLocalMove(new_pos, move_time, false))
  sequence:OnComplete(function()
    self.v_complete_data[char_data.RolePos].is_move = true
    self:check_complete()
  end)
end

function M:check_complete()
  for _, data in pairs(self.v_complete_data) do
    if not (data.is_show_effect and data.is_hide_effect) or not data.is_move then
      return
    end
  end
  if not self:check_anim_play_end() then
    return
  end
  self:complete()
end

function M:check_anim_play_end()
  if self.v_is_click_end then
    return true
  end
  for _, data in pairs(self.v_body_anim_record) do
    if not data.is_end then
      return
    end
  end
  for _, data in pairs(self.v_eye_anim_record) do
    if not data.is_end then
      return
    end
  end
  for _, data in pairs(self.v_mouth_anim_record) do
    if not data.is_end then
      return
    end
  end
  return true
end

function M:update_anim_info(char_data)
  local role_pos = char_data.RolePos
  if not self.v_loaded_record[role_pos] then
    return
  end
  self:check_play_body_anim(char_data, char_data.BodyAnim, self.v_body_anim_record, TRACK_TYPE.BODY)
  self:check_play_body_anim(char_data, char_data.EyeAnim, self.v_eye_anim_record, TRACK_TYPE.EYES)
  local language_temp = char_data["MouthAnim_" .. Global.curr_language]
  local language_check = nil == language_temp
  language_check = language_check or #language_temp <= 0
  if Global.curr_language == Config.CommonDefine.LANGUAGE.CN or language_check then
    self:check_play_body_anim(char_data, char_data.MouthAnim, self.v_mouth_anim_record, TRACK_TYPE.MOUTH)
  else
    self:check_play_body_anim(char_data, char_data["MouthAnim_" .. Global.curr_language], self.v_mouth_anim_record, TRACK_TYPE.MOUTH)
  end
end

function M:check_play_body_anim(char_data, anim_list, anim_record, track_index)
  if not anim_list or 0 == #anim_list then
    return
  end
  local now_time = UnityTime.realtimeSinceStartup
  local role_pos = char_data.RolePos
  local res_name = char_data.RoleImg
  local spine_rt = self.v_lua_obj:get_spine_rt_view(role_pos)
  if not anim_record[role_pos] then
    anim_record[role_pos] = {
      play_anim_idx = 1,
      delay_time = {},
      playing_list = {},
      playing_time = {},
      is_end = false
    }
  end
  local record_data = anim_record[role_pos]
  if record_data.is_end then
    return
  end
  local idx = record_data.play_anim_idx
  local anim_data = anim_list[idx]
  if not anim_data then
    record_data.is_end = true
    self:check_complete()
    return
  end
  if self.v_is_click_end and self.v_revert_anim then
    idx = #anim_list
    anim_data = anim_list[idx]
    record_data.play_anim_idx = idx
  end
  local is_playing = record_data.playing_list[idx]
  record_data.delay_time[idx] = record_data.delay_time[idx] or now_time
  local cfg_delay_time = anim_data.InsertAnimDelay / self.v_story_speed
  local delay_time = record_data.delay_time[idx]
  if not is_playing and cfg_delay_time > now_time - delay_time then
    return
  end
  record_data.playing_list[idx] = true
  local loop_anim = false
  if track_index == TRACK_TYPE.MOUTH or self.v_is_click_end then
    loop_anim = idx < #anim_list
  end
  if self:check_in_list(anim_data.InsertAnim, char_data.noLoopAnim) then
    loop_anim = false
  end
  local life_time = anim_data.InsertAnimLifeTime / self.v_story_speed
  local start_time = record_data.playing_time[idx]
  local timeScale = self.v_story_speed
  if 0 == timeScale then
    timeScale = 1
  end
  if start_time then
    local time_pass = now_time - start_time
    if time_pass >= life_time - 0.05 then
      record_data.play_anim_idx = idx + 1
    end
  else
    record_data.playing_time[idx] = now_time
    if anim_data.InsertAnim and anim_data.InsertAnim ~= "" and spine_rt then
      spine_rt:play_anim(res_name, anim_data.InsertAnim, loop_anim, track_index, nil, nil, timeScale)
    end
  end
end

local WARN_OFFSET = {
  0,
  0,
  0,
  10
}

function M:check_use_config_pos()
  if not self.v_step_cfg or not self.v_step_cfg.CharacterInfos then
    return
  end
  local char_list = self.v_step_cfg.CharacterInfos
  for _, char_data in ipairs(char_list) do
    if char_data.UseConfigPosInfo and char_data.RoleImg then
      local offset = ShareRes.get_story_step_char_pos_offset(char_data.RoleImg, char_data.RolePos)
      if offset then
        char_data.PosInfo = offset
      else
        Log.Error("剧情编辑器-人物勾选了“使用配置坐标”但未在配置中找到,story_id：", self.v_story_id, char_data.RoleImg)
        char_data.PosInfo = WARN_OFFSET
      end
    end
  end
end

function M:check_in_list(item, item_list)
  if nil == item_list then
    return false
  end
  for _, data in pairs(item_list) do
    if item == data then
      return true
    end
  end
end

return M
