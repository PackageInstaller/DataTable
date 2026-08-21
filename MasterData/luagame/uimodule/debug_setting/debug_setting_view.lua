local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local INPUT_FIELD = UnityEngine.UI.InputField
local LocalStorage = require("utils.localstorage")
local CUSTOM_ROLE_STR = "自定义角色"
local MODEL = {
  v_input_role1 = {
    "Role1Input",
    BIND_TYPE.INPUT
  },
  v_input_role2 = {
    "Role2Input",
    BIND_TYPE.INPUT
  },
  v_input_role3 = {
    "Role3Input",
    BIND_TYPE.INPUT
  },
  v_param_input1 = {
    "ParamInput1",
    BIND_TYPE.INPUT
  },
  v_param_input2 = {
    "ParamInput2",
    BIND_TYPE.INPUT
  },
  v_param_input3 = {
    "ParamInput3",
    BIND_TYPE.INPUT
  },
  v_input_tower_id = {
    "TowerInput",
    BIND_TYPE.INPUT
  },
  v_input_tower_floor_id = {
    "FloorInput",
    BIND_TYPE.INPUT
  },
  v_input_tower_room_id = {
    "RoomInput",
    BIND_TYPE.INPUT
  },
  v_input_bornpos_x = {
    "BornPosXInput",
    BIND_TYPE.INPUT
  },
  v_input_bornpos_y = {
    "BornPosYInput",
    BIND_TYPE.INPUT
  },
  v_input_bornpos_z = {
    "BornPosZInput",
    BIND_TYPE.INPUT
  },
  v_input_camera_id = {
    "CameraInput",
    BIND_TYPE.INPUT
  },
  v_input_monster_id = {
    "MonsterIdInput",
    BIND_TYPE.INPUT
  },
  v_toggle_enter_chapter = {
    "EnterChapter",
    BIND_TYPE.TOGGLE
  },
  v_toggle_no_play_sound = {
    "NoPlaySound",
    BIND_TYPE.TOGGLE
  },
  v_toggle_show_res_log = {
    "ShowResLoadLog",
    BIND_TYPE.TOGGLE
  },
  v_input_room_id = {
    "SceneId",
    BIND_TYPE.INPUT
  },
  v_input_born_key = {
    "BornKey",
    BIND_TYPE.INPUT
  },
  v_toggle_open_skill = {
    "OpenSkill",
    BIND_TYPE.TOGGLE
  },
  v_toggle_jump_scene_show = {
    "JumpSceneShow",
    BIND_TYPE.TOGGLE
  },
  v_input_god_id = {
    "GodNpcId",
    BIND_TYPE.INPUT
  },
  v_input_operate_id = {
    "OperateCharId",
    BIND_TYPE.INPUT
  },
  v_input_challenge_type = {
    "ChallengeType",
    BIND_TYPE.INPUT
  }
}
local EDITOR_CHAR_KEY = "EDITOR_CHAR_KEY"

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("Submit", function()
    if not self:is_data_validate() then
      return
    end
    self:save_setting()
    self:ui_hide()
  end)
  self:set_button("Cancel", function()
    self:ui_hide()
  end)
  self:set_button("Exit", function()
    CS.Game.Service.Instance:SetEnterGameFlag(true)
    Global.gamemode:gmode_set_mode(Global.const.MODE_RELOAD)
  end)
  self:set_button("CharContent", function()
    self.v_uiobjects.CharContent:SetActive(false)
  end)
  self:set_toggle_listener(self.v_toggle_enter_chapter, function(is_on)
    self.v_is_enter_chapter = is_on
  end)
  self:set_toggle_listener(self.v_toggle_no_play_sound, function(is_on)
    self.v_is_no_play_sound = is_on
  end)
  self:set_toggle_listener(self.v_toggle_show_res_log, function(is_on)
    self.v_is_show_res_log = is_on
  end)
  self:set_toggle_listener(self.v_toggle_open_skill, function(is_on)
    self.v_is_open_skill = is_on
  end)
  self:set_toggle_listener(self.v_toggle_jump_scene_show, function(is_on)
    self.v_jump_scene_show = is_on
  end)
  for i = 1, 3 do
    self:set_button("SelectBtn" .. i, function()
      self:select_char(i)
    end)
  end
  self:register_exist_auto_template(EDITOR_CHAR_KEY, self.v_uiobjects.CharItem, self.v_uiobjects.CharList)
end

function ui:ui_on_show()
  self.v_uiobjects.CharContent:SetActive(false)
  self:init_char_list()
  self:refresh_role_list()
  self:refresh_fixed_buddy_list()
  self:refresh_tower_id()
  self:refresh_born_pos()
  self:refresh_camera_id()
  self:refresh_monster_id()
  self:refresh_enter_chapter_toggle()
  self:refresh_no_play_sound_toggle()
  self:refresh_show_res_log_toggle()
  self:refresh_client_scene_data()
  self:refresh_show_open_skill_toggle()
  self:refresh_jump_scene_show()
  self:refresh_god_id()
  self:refresh_operate_id()
end

function ui:ui_on_hide()
  self.v_setting = nil
end

function ui:ui_on_destory()
  self.v_is_enter_chapter = nil
  self.v_is_no_play_sound = nil
  self.v_is_show_res_log = nil
  self.v_is_open_skill = nil
  self.v_jump_scene_show = nil
end

function ui:refresh_role_list()
  local role_list = DebugSetting:get_role_list()
  for i = 1, 3 do
    if role_list[i] and role_list[i] ~= CUSTOM_ROLE_STR then
      self:select_custom_role(i, role_list[i], false)
    end
  end
end

function ui:refresh_fixed_buddy_list()
  local fixed_buddy_list = DebugSetting:get_fixed_buddy_list()
  for i = 1, 3 do
    if fixed_buddy_list[i] then
      self:select_custom_role(i, CUSTOM_ROLE_STR, true)
      self["v_param_input" .. i].text = fixed_buddy_list[i]
    end
  end
end

function ui:init_char_list()
  local char_cfg = ShareRes.create("buddy.buddy")
  local char_list = {}
  for _, cfg in pairs(char_cfg) do
    table.insert(char_list, {
      id = cfg.Id,
      name = cfg.Name
    })
  end
  table.sort(char_list, function(a, b)
    return a.id < b.id
  end)
  table.insert(char_list, 1, {id = 0, name = "无"})
  for _, data in ipairs(char_list) do
    local item = self:get_auto_cache(EDITOR_CHAR_KEY)
    local desc = Util.get_text("Desc", item)
    desc.text = data.id .. "/" .. data.name
    self:set_button_listener(Util.get_button(nil, item), function()
      self.v_uiobjects.CharContent:SetActive(false)
      self:select_custom_role(self.v_select_index, data.id, false)
    end)
  end
  local item = self:get_auto_cache(EDITOR_CHAR_KEY)
  local desc = Util.get_text("Desc", item)
  desc.text = CUSTOM_ROLE_STR
  self:set_button_listener(Util.get_button(nil, item), function()
    self:select_custom_role(self.v_select_index, CUSTOM_ROLE_STR, true)
  end)
end

function ui:select_custom_role(index, text, open_interact)
  self.v_uiobjects.CharContent:SetActive(false)
  self["v_input_role" .. index].text = text
  local input = self["v_param_input" .. index]
  input.interactable = open_interact
  if not open_interact then
    input.text = ""
  end
end

function ui:select_char(index)
  self.v_uiobjects.CharContent:SetActive(true)
  self.v_select_index = index
end

function ui:refresh_tower_id()
  local tower_id = DebugSetting:get_tower_id()
  local tower_floor_id = DebugSetting:get_tower_floor_id()
  local tower_room_id = DebugSetting:get_tower_room_id()
  self.v_input_tower_id.text = tower_id
  self.v_input_tower_floor_id.text = tower_floor_id
  self.v_input_tower_room_id.text = tower_room_id
end

function ui:refresh_born_pos()
  local born_pos_map = DebugSetting:get_born_pos()
  self.v_input_bornpos_x.text = born_pos_map.x
  self.v_input_bornpos_y.text = born_pos_map.y
  self.v_input_bornpos_z.text = born_pos_map.z
end

function ui:refresh_camera_id()
  local camera_id = DebugSetting:get_camera_id()
  self.v_input_camera_id.text = camera_id
end

function ui:refresh_monster_id()
  local monster_id = DebugSetting:get_monster_id()
  self.v_input_monster_id.text = monster_id
end

function ui:refresh_enter_chapter_toggle()
  local is_enter_chapter = DebugSetting:is_enter_chapter()
  self.v_is_enter_chapter = is_enter_chapter
  self.v_toggle_enter_chapter.isOn = is_enter_chapter
end

function ui:refresh_no_play_sound_toggle()
  local is_no_play_sound = DebugSetting:is_no_play_sound()
  self.v_is_no_play_sound = is_no_play_sound
  self.v_toggle_no_play_sound.isOn = is_no_play_sound
end

function ui:refresh_show_res_log_toggle()
  local is_show_res_log = DebugSetting:is_show_res_load_log()
  self.v_is_show_res_log = is_show_res_log
  self.v_toggle_show_res_log.isOn = is_show_res_log
end

function ui:refresh_show_open_skill_toggle()
  local is_open_skill = DebugSetting:is_open_skill()
  self.v_is_open_skill = is_open_skill
  self.v_toggle_open_skill.isOn = is_open_skill
end

function ui:refresh_client_scene_data()
  local room_id = DebugSetting:get_room_id()
  local born_key = DebugSetting:get_born_key()
  self.v_input_room_id.text = room_id
  self.v_input_born_key.text = born_key
end

function ui:refresh_jump_scene_show()
  local is_jump = DebugSetting:is_jump_scene_show()
  self.v_jump_scene_show = is_jump
  self.v_toggle_jump_scene_show.isOn = is_jump
  local val = is_jump and 1 or 0
  LocalStorage:save_int("is_jump_scene_show", val)
end

function ui:refresh_god_id()
  local id = DebugSetting:get_god_id()
  self.v_input_god_id.text = id
end

function ui:refresh_operate_id()
  local id = DebugSetting:get_operate_char_id()
  self.v_input_operate_id.text = id
end

function ui:save_setting()
  local debug_setting = DebugSetting
  local role_list = {}
  local fixed_buddy_list = {}
  for index = 1, 3 do
    if self["v_input_role" .. index].text == CUSTOM_ROLE_STR then
      local fixed_id = tonumber(self["v_param_input" .. index].text)
      local cfg = ShareRes.get_fixed_buddy_config(fixed_id)
      role_list[index] = cfg.BuddyId
      fixed_buddy_list[index] = fixed_id
    else
      role_list[index] = tonumber(self["v_input_role" .. index].text) or 0
    end
  end
  debug_setting:set_role_list(role_list)
  debug_setting:set_fixed_buddy_list(fixed_buddy_list)
  debug_setting:set_challenge_type(self.v_input_challenge_type.text)
  local tower_id_txt = self.v_input_tower_id.text
  local strs = {}
  string.gsub(tower_id_txt, "(%d+)", function(w)
    table.insert(strs, w)
  end)
  local tower_id, tower_floor_id, tower_room_id
  if #strs >= 3 then
    tower_id, tower_floor_id, tower_room_id = tonumber(strs[1]), tonumber(strs[2]), tonumber(strs[3])
  else
    tower_id = tonumber(tower_id_txt)
    tower_floor_id = tonumber(self.v_input_tower_floor_id.text)
    tower_room_id = tonumber(self.v_input_tower_room_id.text)
  end
  debug_setting:set_tower_id(tower_id)
  debug_setting:set_tower_floor_id(tower_floor_id)
  debug_setting:set_tower_room_id(tower_room_id)
  local born_pos_x = tonumber(self.v_input_bornpos_x.text)
  local born_pos_y = tonumber(self.v_input_bornpos_y.text)
  local born_pos_z = tonumber(self.v_input_bornpos_z.text)
  debug_setting:set_born_pos(born_pos_x, born_pos_y, born_pos_z)
  local camera_id = tonumber(self.v_input_camera_id.text)
  debug_setting:set_camera_id(camera_id)
  local monster_id = tonumber(self.v_input_monster_id.text)
  debug_setting:set_monster_id(monster_id)
  debug_setting:set_enter_chapter(self.v_is_enter_chapter)
  debug_setting:set_no_play_sound(self.v_is_no_play_sound)
  debug_setting:set_show_res_load_log(self.v_is_show_res_log)
  debug_setting:set_open_skill(self.v_is_open_skill)
  local room_id = tonumber(self.v_input_room_id.text)
  debug_setting:set_room_id(room_id)
  debug_setting:set_born_key(self.v_input_born_key.text)
  debug_setting:set_jump_scene_show(self.v_jump_scene_show)
  local god_id = tonumber(self.v_input_god_id.text)
  debug_setting:set_god_id(god_id)
  local operate_id = tonumber(self.v_input_operate_id.text)
  debug_setting:set_operate_char_id(operate_id)
  debug_setting:save_setting()
  local val = self.v_jump_scene_show and 1 or 0
  LocalStorage:save_int("is_jump_scene_show", val)
end

function ui:is_data_validate()
  local role_map = {}
  for i = 1, 3 do
    local role_id = tonumber(self["v_input_role" .. i].text)
    if role_id and 0 ~= role_id then
      if role_map[role_id] then
        Util.show_message_tip(2173)
        return false
      end
      role_map[role_id] = true
    end
  end
  for index = 1, 3 do
    if self["v_input_role" .. index].text == CUSTOM_ROLE_STR then
      if Util.is_empty(self["v_param_input" .. index].text) then
        Util.show_message_tip(2174)
        return false
      else
        local fixed_id = tonumber(self["v_param_input" .. index].text)
        if not fixed_id then
          Util.show_message_tip(2175)
          return false
        elseif 0 == fixed_id then
          Util.show_message_tip(2176)
          return false
        else
          local cfg = ShareRes.get_fixed_buddy_config(fixed_id)
          if not cfg then
            Util.show_message_tip(Util.format_str("第{1}个自定义id配置为空", index))
            return false
          elseif role_map[cfg.BuddyId] then
            Util.show_message_tip(2173)
            return false
          end
        end
      end
    end
  end
  local ct_str = self.v_input_challenge_type.text
  if not Util.is_empty(ct_str) then
    local ct = tonumber(ct_str)
    if not ct then
      Util.show_message_tip(2177)
      return false
    end
    local include = false
    for key, challenge_type in pairs(Config.CommonDefine.CHALLENGE_TYPE) do
      if ct == challenge_type then
        include = true
        break
      end
    end
    if not include then
      Util.show_message_tip(2178)
    end
    return include
  end
  if not tonumber(self.v_input_tower_id.text) then
    local strs = {}
    string.gsub(self.v_input_tower_id.text, "(%d+)", function(w)
      table.insert(strs, w)
    end)
    if #strs < 3 then
      Util.show_message_tip("GM进入塔 信息有误")
      return false
    end
  end
  return true
end

return ui
