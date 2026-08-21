local Base = require("ui.uibase")
local GMConfig = require("uimodule.gm.gm_config")
local Seri = require("seri")
local PathDefine = require("utils.path_define")
local CommonDefine = require("cs_share.common_define")
local CSUnityEngine = UnityEngine
local CSShader = CSUnityEngine.Shader
local CSErrorUpLoad = CS.Game.ErrorUpLoad
local UnityPlayerPrefs = UnityEngine.PlayerPrefs
local Application = UnityEngine.Application
local UnityFind = _ENV.UnityFind
local ui = Util.create_child_mt(Base)
local _tinsert = table.insert
local GM_TAG_KEY = "GM_TAG_LIST"
local GM_ITEM_KEY = "GM_ITEM_LIST"
local GM_INPUTFIELD_KEY = "GM_INPUTFIELD_LIST"
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_tag_content_obj = {
    "TagContent",
    BIND_TYPE.OBJECT
  },
  v_ag_item_obj = {
    "TagItem",
    BIND_TYPE.OBJECT
  },
  v_item_content_obj = {
    "ItemContnet",
    BIND_TYPE.OBJECT
  },
  v_item_obj = {
    "ItemBtn",
    BIND_TYPE.OBJECT
  },
  v_inputField_Panel_obj = {
    "InputPanel",
    BIND_TYPE.OBJECT
  },
  v_inputField_obj = {
    "InputField",
    BIND_TYPE.OBJECT
  },
  v_drag_panel = {
    "DragPanel",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("CloseBtn", function()
    self:ui_destroy()
  end)
  self:set_button("SendBtn", function()
    local select_item = self.v_select_item_config
    if select_item then
      local args_map = {}
      local args = {}
      if select_item.ParamsKey then
        for i = 1, #select_item.ParamsKey do
          local input = Util.get_component(nil, self.v_input_field_list[i].gameObject, UnityEngine.UI.InputField)
          local key = select_item.ParamsKey[i]
          local inputStr = input.text
          if "" == inputStr and "uuid" == key then
            local arg = tonumber(Util.get_text("Placeholder", self.v_input_field_list[i]).text)
            args_map[key] = arg
            _tinsert(args, arg)
          elseif "" ~= inputStr then
            local arg = tonumber(inputStr) ~= nil and tonumber(inputStr) or inputStr
            args_map[key] = arg
            _tinsert(args, arg)
          end
        end
      end
      if "reset_player" == select_item.Instruct then
        ui.gm_reset_guide_data()
      end
      if select_item.IsFunction then
        ui[select_item.Instruct](self, select_item, table.unpack(args))
      else
        local request = {
          instruct = select_item.Instruct,
          args_map = Seri.packstring(args_map)
        }
        if select_item.MultipleParams then
          ui[select_item.Instruct](self, select_item, args)
        end
        Network:call("c2gs_execute_instruct", request, function(ok, resp)
          MsgGame:mq_publish2(Const.MSG_ON_GM_RESPONSE_SUC)
          Log.Info(ok, resp.result)
        end)
      end
    end
  end)
  self:register_exist_auto_template(GM_TAG_KEY, self.v_ag_item_obj, self.v_tag_content_obj)
  self:register_exist_auto_template(GM_ITEM_KEY, self.v_item_obj, self.v_item_content_obj)
  self:register_exist_auto_template(GM_INPUTFIELD_KEY, self.v_inputField_obj, self.v_inputField_Panel_obj)
end

function ui:ui_on_show()
  self.v_item_list = {}
  self.v_input_field_list = {}
  self.v_select_item_config = nil
  self:refresh_view()
  self.drag_panel_pos = self.v_drag_panel.transform.localPosition
  Util.set_drag(self:get_object(), self, function(x, y)
    self.drag_panel_pos.x = self.drag_panel_pos.x + x
    self.drag_panel_pos.y = self.drag_panel_pos.y + y
    self.v_drag_panel.transform:SetLocalPositionA(self.drag_panel_pos.x, self.drag_panel_pos.y, self.drag_panel_pos.z)
  end)
end

function ui:ui_on_hide()
  self.v_item_list = nil
  self.v_input_field_list = nil
  self.v_select_item_config = nil
end

function ui:refresh_view()
  for _, gms in ipairs(GMConfig) do
    local name = gms.name
    local cmds = gms.cmds
    local item = self:get_auto_cache(GM_TAG_KEY)
    Util.get_text("Text", item).text = name
    local tag_item_btn = Util.get_button(nil, item)
    self:set_button_listener(tag_item_btn, function()
      self:refresh_item_list(cmds)
    end)
  end
end

function ui:refresh_item_list(cmds)
  if self.v_item_list then
    for _, item_trans in ipairs(self.v_item_list) do
      item_trans:SetActive(false)
    end
  end
  for index, item_info in ipairs(cmds) do
    local item = self.v_item_list[index]
    if not item then
      item = self:get_auto_cache(GM_ITEM_KEY)
      _tinsert(self.v_item_list, item)
    else
      item:SetActive(true)
    end
    local item_btn = Util.get_button(nil, item)
    self:set_button_listener(item_btn, function()
      self.v_select_item_config = item_info
      local str = "提示:" .. (item_info.Tips or item_info.name)
      self:refresh_tips(str)
      self:refresh_input_fieid(item_info)
    end)
    local name = item_info.name
    Util.get_text("Text", item).text = name
  end
end

function ui:refresh_tips(str)
  self.v_uicompents.TipsTxt_txt.text = str
end

function ui:refresh_input_fieid(item_info)
  if self.v_input_field_list then
    for _, Item_trans in ipairs(self.v_input_field_list) do
      Item_trans:SetActive(false)
    end
  end
  if not item_info.ParamsKey then
    return
  end
  local params_count = #item_info.ParamsKey
  if 0 == params_count then
    return
  end
  for index, key in ipairs(item_info.ParamsKey) do
    local input_filed = self.v_input_field_list[index]
    if not input_filed then
      input_filed = self:get_auto_cache(GM_INPUTFIELD_KEY)
      _tinsert(self.v_input_field_list, input_filed)
    else
      input_filed:SetActive(true)
    end
    if "uuid" == key then
      Util.get_text("Placeholder", input_filed).text = Global.player_uuid
    end
  end
end

local UnityQualitySetting = UnityEngine.QualitySettings
local anti_aliasing = 1

function ui:set_antialiasing(item_info)
  anti_aliasing = anti_aliasing * 2
  if anti_aliasing > 8 then
    anti_aliasing = 1
  end
  UnityQualitySetting.antiAliasing = anti_aliasing
  item_info.Tips = item_info.name .. ", QualitySettings.antiAliasing : " .. anti_aliasing
  self:refresh_tips(item_info.Tips)
end

local render_texture_msaa = 1

function ui:set_render_texture_msaa(item_info)
  render_texture_msaa = render_texture_msaa * 2
  if render_texture_msaa > 8 then
    render_texture_msaa = 1
  end
  local cameras = UnityEngine.GameObject.FindObjectsOfType(typeof(CS.CustomResolveCamera))
  CS.CustomResolveCamera.MSAA = render_texture_msaa
  for i = 0, cameras.Length - 1 do
    local custom_camera = cameras[i]
    custom_camera:UpdateRt()
  end
  item_info.Tips = item_info.name .. ", " .. render_texture_msaa
  self:refresh_tips(item_info.Tips)
end

function ui:set_fps(item_info, fps)
  Global.render_mgr:set_fps(fps)
  item_info.Tips = item_info.name .. ", 帧率 : " .. fps
  self:refresh_tips(item_info.Tips)
end

function ui:switch_memory_stat()
  CS.Game.MemoryStats.Switch()
end

function ui:set_quality_level(item_info, quality_level)
  item_info.Tips = item_info.name .. ", quality等级 : " .. quality_level
  self:refresh_tips(item_info.Tips)
  Global.render_mgr:set_quality_level(quality_level)
end

local function get_toggle_desc(enable)
  return enable and "开" or "关"
end

local transparent_clip = true

function ui:toggle_transparent_clip(item_info)
  transparent_clip = not transparent_clip
  if transparent_clip then
    CSShader.DisableKeyword("DONOT_CLIP_DEBUG")
  else
    CSShader.EnableKeyword("DONOT_CLIP_DEBUG")
  end
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(transparent_clip)
  self:refresh_tips(item_info.Tips)
end

local post_process = true

function ui:toggle_post_process(item_info)
  post_process = not post_process
  Global.render_mgr:enable_post_processing(post_process)
  if SceneMgr:check_main_scene() then
    local ui_camera = UnityFind("CameraRoot")
    if ui_camera then
      local camera = ui_camera:GetComponent(typeof(UnityEngine.Camera))
      if camera then
        local post_process_cmp = camera:GetComponent(typeof(UnityEngine.PostProcessing.PostProcessingBehaviour))
        post_process_cmp.enabled = post_process
      end
    end
  end
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(post_process)
  self:refresh_tips(item_info.Tips)
end

local enable_hdr = true

function ui:enable_hdr(item_info)
  enable_hdr = not enable_hdr
  Global.render_mgr:enable_hdr(enable_hdr)
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(enable_hdr)
  self:refresh_tips(item_info.Tips)
end

local fxaa = true

function ui:toggle_fxaa(item_info)
  fxaa = not fxaa
  Global.render_mgr:enable_fxaa(fxaa)
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(fxaa)
  self:refresh_tips(item_info.Tips)
end

local bloom = true

function ui:toggle_bloom(item_info)
  bloom = not bloom
  Global.render_mgr:enable_bloom(bloom)
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(bloom)
  self:refresh_tips(item_info.Tips)
end

local lut = true

function ui:toggle_lut(item_info)
  lut = not lut
  Global.render_mgr:enable_lut(lut)
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(lut)
  self:refresh_tips(item_info.Tips)
end

local distortion = true

function ui:toggle_distortion(item_info)
  distortion = not distortion
  Global.render_mgr:enable_distortion(distortion)
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(distortion)
  self:refresh_tips(item_info.Tips)
end

local depth_of_field = true

function ui:toggle_depth_of_field(item_info)
  depth_of_field = not depth_of_field
  Global.render_mgr:enable_depth_of_field(depth_of_field)
end

function ui:toggle_spline_debug(item_info)
  Global.spline_debug = not Global.spline_debug
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(Global.spline_debug)
  self:refresh_tips(item_info.Tips)
end

local shadow = true

function ui:toggle_shadow(item_info)
  shadow = not shadow
  Global.render_mgr:enable_shadow(shadow)
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(shadow)
  self:refresh_tips(item_info.Tips)
end

function ui:show_systeminfo()
  UIMgr:get_ui("systeminfo"):ui_show()
  self:ui_hide()
end

function ui:get_battle_skill()
  UIMgr:get_ui("uigmSkill"):ui_show()
  self:ui_hide()
end

function ui:play_story(item_info, story_id)
  StoryMgr:on_start(story_id)
end

function ui:play_desc_story(item_info, story_id)
  UIMgr:get_ui("desc_story"):ui_show(story_id)
end

function ui:enter_guide(item_info, args)
  GuideMgr:enter_guide(args)
end

function ui:jump_all_guide(item_info, args)
  GuideMgr:jump_all_guide()
end

function ui:jump_guide(item_info, args)
  GuideMgr:gm_complete_cur_guide()
end

function ui:test_guide(item_info, args)
  GuideMgr:test_guide(args)
end

function ui:change_setting_role(item_info, role_value)
  BattleSettingMgr:set_player_role(role_value)
end

function ui:jump_floor_ui(item_info, role_value)
  if SceneMgr then
    SceneMgr:jump_floor_ui()
  end
end

function ui:change_signboard_camera(item_info)
  SignBoardGirlMgr:set_camera_update()
end

function ui:stop_update(item_info)
  Global.stop_update = not Global.stop_update
  item_info.Tips = item_info.name .. ", " .. tostring(Global.stop_update)
  self:refresh_tips(item_info.Tips)
end

local hide_all_ui = false

function ui:hide_all_ui(item_info)
  hide_all_ui = not hide_all_ui
  item_info.Tips = item_info.name .. ", " .. tostring(hide_all_ui)
  UIMgr.root_camera_obj:SetActive(not hide_all_ui)
end

function ui:show_skill_task_id()
  local char_skill_ui = UIMgr:try_get_visible_ui("char_skill_task")
  if not char_skill_ui then
    return
  end
  char_skill_ui:gm_show_task_id()
end

function ui:cur_hero_suicide()
  SceneMgr:cur_hero_suicide()
end

function ui:npc_np_by_1()
  SceneMgr:cur_scene_npc_suicide()
end

local hide_monster = false

function ui:hide_monster(item_info)
  hide_monster = not hide_monster
  local all_npc = SceneMgr:get_all_npc()
  for _, npc in pairs(all_npc) do
    npc.gameobj:SetActive(hide_monster)
  end
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(hide_monster)
  self:refresh_tips(item_info.Tips)
end

function ui:open_water_pipe_game(item, game_id)
  if game_id and 0 ~= game_id then
    local game_cfg = ShareRes.create("minigame.waterpipe." .. game_id)
    if 2 == game_cfg.uiType then
      UIMgr:get_ui("ui_water_pipe_sp"):ui_show(game_id)
    else
      UIMgr:get_ui("ui_water_pipe"):ui_show(game_id)
    end
  end
end

function ui:play_cri_video(item_info, video_name, sound_name)
  local video_data = {
    video_name = video_name,
    is_skip = true,
    alpha_enter = 1,
    alpha_out = 1,
    sound_name = sound_name
  }
  VideoMgr:on_play_video(video_data)
end

function ui:run_journey_event(item, event_id)
  TowerMgr:get_tower_gm_info()
end

function ui:print_gm_info(item, event_id)
  local data = {
    scene_journey_event = {
      id = tonumber(event_id),
      state = 1
    }
  }
  JourneyEventMgr:on_scene_journey_event_update(data)
end

function ui:create_friend_monster(_, monster_id, num)
  local x, y, z = Global.hero:get_pos()
  for i = 1, num do
    SceneMgr:create_npc(monster_id, x + i, y, z + 1, 10, 10, Config.CAMPS.FRIEND)
  end
end

function ui:create_enemy_monster(_, monster_id, num)
  local x, y, z = Global.hero:get_pos()
  for i = 1, num do
    SceneMgr:create_npc(monster_id, x + i, y, z + 1, 10, 10, Config.CAMPS.ENEMY)
  end
end

local stop_behavior = false

function ui:stop_behavior(item_info)
  stop_behavior = not stop_behavior
  Global.stop_behavior = stop_behavior
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(stop_behavior)
  self:refresh_tips(item_info.Tips)
end

function ui:open_img_collect()
  Global.img_collector:open_collect()
end

function ui:show_scene_position()
  if SceneMgr then
    SceneMgr:show_scene_position()
  end
end

function ui:add_all_hero()
  local char_cfg = ShareRes.create("buddy.buddy")
  for _, cfg_data in pairs(char_cfg) do
    if 1 ~= cfg_data.IsShow then
      local advance_cfg = ShareRes.create("buddy.buddy_upgrade_advance_attr", cfg_data.Id)
      if advance_cfg then
        local args_map = {
          uuid = Global.player_uuid,
          item_id = cfg_data.Id,
          count = 1
        }
        local request = {
          instruct = "award_item",
          args_map = Seri.packstring(args_map)
        }
        Network:call("c2gs_execute_instruct", request, function(ok, resp)
          Log.Info(ok, resp.result)
        end)
      end
    end
  end
end

local CSGameMgr = CS.Game.GameMgr

function ui:gm_rt_test(item_info, tex_select)
  self.v_flag_open = not self.v_flag_open
  CSGameMgr.gm_rt_test(self.v_flag_open, tex_select)
  local ret = CSGameMgr.CurResolutionWidth .. "x" .. CSGameMgr.CurResolutionHeight
  if UNITY_EDITOR then
    ret = Global.screen_width .. "x" .. Global.screen_height
  end
  item_info.Tips = self.v_flag_open and "当前状态： " .. "打开RT渲染" .. ret or "当前状态： 关闭RT渲染"
  self:refresh_tips(item_info.Tips)
end

function ui:create_test_model_pnl()
  UIMgr:get_ui("test_show_prefab"):ui_show()
end

function ui:multi_add_item()
  local item_id_list = {}
  local item_count_list = {}
  for i = 2, 3 do
    local input = Util.get_component(nil, self.v_input_field_list[i].gameObject, UnityEngine.UI.InputField)
    local inputStr = input.text
    if 2 == i then
      local item_id_string_list = Util.split_str(inputStr, ",")
      for _, value in ipairs(item_id_string_list) do
        if tonumber(value) ~= nil then
          table.insert(item_id_list, tonumber(value))
        end
      end
      if 0 == #item_id_list then
        item_id_string_list = Util.split_str(inputStr, "\n")
        for _, value in ipairs(item_id_string_list) do
          if tonumber(value) ~= nil then
            table.insert(item_id_list, tonumber(value))
          end
        end
      end
    else
      local item_count_string_list = Util.split_str(inputStr, ",")
      for _, value in ipairs(item_count_string_list) do
        if tonumber(value) ~= nil then
          table.insert(item_count_list, tonumber(value))
        end
      end
    end
  end
  for index, id in ipairs(item_id_list) do
    local temp_count = 0
    if 1 == #item_count_list then
      temp_count = item_count_list[1]
    else
      temp_count = nil ~= item_count_list[index] and item_count_list[index] or 1
    end
    local args_map = {
      uuid = Global.player_uuid,
      item_id = id,
      count = temp_count
    }
    local request = {
      instruct = "award_item",
      args_map = Seri.packstring(args_map)
    }
    Network:call("c2gs_execute_instruct", request, function(ok, resp)
      Log.Info(ok, resp.result)
    end)
  end
end

function ui:clear_bag()
  local equips = CharacterMgr:get_equip_list()
  local items = BagMgr:get_bag(2)
  local equip_uuid_list = {}
  for _, equip in pairs(equips) do
    if 0 == equip.owner then
      table.insert(equip_uuid_list, equip.uuid)
    end
  end
  Network:call("c2gs_decompose_equip", {uuid_list = equip_uuid_list}, function(ok, resp)
    Log.Info(ok, resp.errcode)
  end)
  for _, item in pairs(items) do
    local args_map = {
      uuid = Global.player_uuid,
      item_id = item.id,
      count = -1 * item.count
    }
    local request = {
      instruct = "award_item",
      args_map = Seri.packstring(args_map)
    }
    Network:call("c2gs_execute_instruct", request, function(ok, resp)
      Log.Info(ok, resp.result)
    end)
  end
end

function ui:change_gyro_num()
  local val = {}
  for i = 1, 2 do
    local input = Util.get_component(nil, self.v_input_field_list[i].gameObject, UnityEngine.UI.InputField)
    val[i] = tonumber(input.text)
  end
  local msg = MsgGame:mq_publish2(Const.MSG_ON_GM_CHANGE_GYRO_MODEL)
  msg.mm_y = val[1]
  msg.mm_x = val[2]
end

function ui:upload_log()
  Log.upload_log()
end

function ui:show_touch_effect()
  InputMgr:change_gm_touch_effect_state()
end

function ui:upload_error()
  local str = "当前是否上传报错:"
  local last_is_upload = 0
  if UnityPlayerPrefs.HasKey(Config.UPLOAD_ERROR_KEY) then
    last_is_upload = UnityPlayerPrefs.GetInt(Config.UPLOAD_ERROR_KEY)
  end
  local cur_is_upload = 0 == last_is_upload and 1 or 0
  local is_upload_show = 0 == cur_is_upload and "否" or "是"
  UnityPlayerPrefs.SetInt(Config.UPLOAD_ERROR_KEY, cur_is_upload)
  CSErrorUpLoad.Instance:SetIsPostError(1 == cur_is_upload)
  self:refresh_tips(str .. is_upload_show)
end

function ui:open_find_path_debug()
  Global.IS_DEBUG_FIND_PATH = true
end

function ui:create_debug_code(item_info, file_name, code_text)
  local dir = Application.persistentDataPath .. "/debug/" .. file_name .. ".lua"
  CSHelper.WriteAllText(dir, code_text)
end

function ui:run_debug_code(item_info, code_text)
  if GAME_DEBUG then
    local func = load(code_text)
    if func then
      func()
    else
      Log.Error("lua代码编译错误")
    end
  end
end

function ui:set_effect_quality(_, quality_lv)
  if BattleSettingMgr then
    BattleSettingMgr:set_effect_quality(quality_lv)
  end
end

function ui:pinch_debug(_, pinch_limit_min, pinch_limit_max, d2s_distance, s2d_distance)
  if Global.camera then
    Global.camera:pinch_debug(pinch_limit_min, pinch_limit_max, d2s_distance, s2d_distance)
  end
end

function ui:debug_transition_cfg_name(item_info)
  Global.debug_transition_cfg_name = not Global.debug_transition_cfg_name
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(Global.debug_transition_cfg_name)
  self:refresh_tips(item_info.Tips)
end

function ui:open_debug_magic_parpam_count(item_info)
  Global.debug_magic_parpam_count = not Global.debug_magic_parpam_count
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(Global.debug_magic_parpam_count)
  self:refresh_tips(item_info.Tips)
end

function ui:play_video(video)
  local data = {
    video_name = "timeline-1.mp4",
    is_skip = true
  }
  VideoMgr:on_play_video(data)
end

local show_arrow = true

function ui:set_all_arrow_fx_visibility()
  show_arrow = not show_arrow
  local visible = show_arrow and 1 or 0
  DebugSetting:set_all_arrow_fx_visibility(visible)
  self:ui_hide()
end

function ui:hide_monster_footmark()
  SceneMgr:gm_set_monster_footmark_state()
end

function ui:gm_create_god_npc_in_client(item_info, char_id)
  SceneMgr:create_god_npc_in_client(char_id, true)
end

function ui:gm_oepn_ring_skip_btn(item_info, char_id)
  if Global.is_show_ring_skip_btn then
    Global.is_show_ring_skip_btn = nil
  else
    Global.is_show_ring_skip_btn = true
  end
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(Global.is_show_ring_skip_btn)
  self:refresh_tips(item_info.Tips)
end

function ui:gm_open_uifight_test(item_info, char_id)
  Global.is_open_uifight_test = true
end

function ui:gm_reset_guide_data()
  if GuideMgr then
    GuideMgr:clear_local_guide_complete_data()
  end
  if PlayerMgr then
    PlayerMgr:clear_achievement_red_point()
  end
end

function ui:gm_oen_button_9999999(item_info, char_id)
  Global.enable_hero_9999999 = not Global.enable_hero_9999999
  local hero_list = SceneMgr:get_hero_list()
  if hero_list then
    for key, hero in pairs(hero_list) do
      if Global.enable_hero_9999999 then
        hero.magic_mgr:add_magic(hero, 49999999)
        hero.magic_mgr:add_magic(hero, 29999999)
        hero.magic_mgr:add_magic(hero, 39999999)
      else
        hero.magic_mgr:remove_magic_by_id(hero, 49999999)
        hero.magic_mgr:remove_magic_by_id(hero, 29999999)
        hero.magic_mgr:remove_magic_by_id(hero, 39999999)
      end
    end
  end
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(Global.enable_hero_9999999)
  self:refresh_tips(item_info.Tips)
end

function ui:set_fight_log_write_length(item_info, max_num)
  JournalMgr:set_fight_log_write_length(max_num)
end

function ui:gyro_debug(_, idx, value)
  local uimain = UIMgr:get_ui("uimain")
  local model_view = uimain:get_model_view()
  if 1 == idx then
    model_view.v_gyro_speed = value
  elseif 2 == idx then
    model_view.v_gyro_range = value
  elseif 3 == idx then
    model_view.v_gyro_cold = value
  elseif 4 == idx then
    model_view.v_gyro_threshold = value
  elseif 5 == idx then
    model_view.v_gyro_reset_speed = value
  end
end

function ui:building_gyro_debug(_, idx, value)
  local building_scene_mgr = BuildingMgr.v_building_scene_mgr
  if not building_scene_mgr then
    return
  end
  local model_view = building_scene_mgr.v_model_view
  if not model_view then
    return
  end
  if 1 == idx then
    model_view.v_gyro_speed = value
  elseif 2 == idx then
    model_view.v_gyro_range = value
  elseif 3 == idx then
    model_view.v_gyro_cold = value
  elseif 4 == idx then
    model_view.v_gyro_threshold = value
  elseif 5 == idx then
    model_view.v_gyro_reset_speed = value
  end
end

function ui:archive_debug(_, idx, value)
  local archive_detail_pop = UIMgr:get_ui("archive_detail_pop")
  if not archive_detail_pop then
    return
  end
  if 1 == idx then
    archive_detail_pop.TuochSpeed = value
  elseif 2 == idx then
    archive_detail_pop.Max = value
  elseif 3 == idx then
    archive_detail_pop.Min = value
  end
end

function ui:char_map_debug(_, idx, value)
  local char_map = UIMgr:get_ui("char_map")
  if not char_map then
    return
  end
  if 1 == idx then
    char_map.v_scale_data.MouseSpeed = value
    char_map.v_scale_data.TuochSpeed = value
  elseif 2 == idx then
    char_map.v_scale_data.Max = value
  elseif 3 == idx then
    char_map.v_scale_data.Min = value
  end
end

function ui:set_char_rotate_limit(_, value)
  if SignBoardGirlMgr then
    SignBoardGirlMgr.TOUCH_ROTATE_SPEED_MAX = value
    Log.Info(">>成功设置模型旋转速度上限:", value)
  end
end

function ui:refresh_building_bind(_, value)
  if BuildingMgr then
    BuildingMgr:GM_REFRESH_ui_binding_pos_map()
  end
end

function ui:photo_scale_debug(_, idx, value)
  if 0 == idx then
    PhotoMgr.GM_TOUCH_SCALE_SPEED = nil
    PhotoMgr.GM_TOUCH_SCALE_SPEED_M = nil
  elseif 1 == idx then
    PhotoMgr.GM_TOUCH_SCALE_SPEED = value
  elseif 2 == idx then
    PhotoMgr.GM_TOUCH_SCALE_SPEED_M = value
  end
end

function ui:signboard_movie_speed(_, speed_times)
  SignBoardGirlMgr.signboard_movie_speed = speed_times
end

function ui:play_insert_needle(_, id)
  UIMgr:get_ui("mini_game_insert_needle"):ui_show(id)
  self:ui_hide()
end

function ui:play_catch_cat(_, id)
  local cfgs = ShareRes.create("activity.kitten_escape")
  for act_id, stages in pairs(cfgs) do
    for stage_id, stage in pairs(stages) do
      if stage_id == id then
        UIMgr:get_ui("catch_cat_battle_panel"):ui_show(stage, true)
        self:ui_hide()
        return
      end
    end
  end
  Log.Error("未找到关卡配置：", id)
end

function ui:play_puzzle_game(_, stage_id)
  if not stage_id then
    UIMgr:get_ui("puzzle_game_stage_panel"):ui_show()
  else
    UIMgr:get_ui("puzzle_game_battle_panel"):ui_show(stage_id)
  end
end

function ui:play_music_game(_, chapter_id, stage_id)
  if not chapter_id then
    UIMgr:get_ui("music_game_main_panel"):ui_show()
  else
    UIMgr:get_ui("music_game_battle_panel"):ui_show(chapter_id, stage_id)
  end
end

function ui:complete_task_group(_, uuid, task_group)
  local COMPLETE_TASK = "complete_task"
  local task_list = ShareRes.get_task_group(task_group)
  for task, value in pairs(task_list) do
    local args_map = {
      uuid = Global.player_uuid,
      task = task
    }
    local request = {
      instruct = COMPLETE_TASK,
      args_map = Seri.packstring(args_map)
    }
    Network:call("c2gs_execute_instruct", request, function(ok, resp)
      Log.Info(ok, resp.result)
    end)
  end
end

function ui:add_battle_ornament_list(_, uuid, ornament_list_str)
  local ornament_list = Util.split_str(ornament_list_str, ",")
  local COMPLETE_TASK = "add_battle_ornaments"
  for pos, ornament_id in pairs(ornament_list) do
    local args_map = {
      uuid = Global.player_uuid,
      ornaments_id = tonumber(ornament_id),
      pos = pos
    }
    local request = {
      instruct = COMPLETE_TASK,
      args_map = Seri.packstring(args_map)
    }
    Network:call("c2gs_execute_instruct", request, function(ok, resp)
      Log.Info(ok, resp.result)
    end)
  end
end

local org_mask
local cull_type = 0
local CULL_SCENE = 1
local CULL_CHARACTER = 2
local CULL_DEFAULT = 3
local CULL_SCENE_CHARACTER = 4
local CULL_ALL = 5

function ui:camera_cull(item_info)
  cull_type = cull_type + 1
  if cull_type > CULL_ALL then
    cull_type = 0
  end
  local camera = Global.camera and Global.camera:get_camera()
  if not camera then
    local camera_obj = UIMgr:get_wcanvas_transform().gameObject
    camera = camera_obj:GetComponentInChildren(typeof(UnityEngine.Camera))
  end
  if not org_mask then
    org_mask = camera.cullingMask
  end
  local mask
  local cull_type_name = ""
  if cull_type == CULL_SCENE then
    mask = UnityEngine.LayerMask.GetMask("Character", "NPC", "Default")
    cull_type_name = "场景"
  elseif cull_type == CULL_CHARACTER then
    mask = UnityEngine.LayerMask.GetMask("Default", "Terrain")
    cull_type_name = "角色"
  elseif cull_type == CULL_DEFAULT then
    mask = UnityEngine.LayerMask.GetMask("Character", "NPC", "Terrain")
    cull_type_name = "默认"
  elseif cull_type == CULL_SCENE_CHARACTER then
    cull_type_name = "场景和角色"
    mask = UnityEngine.LayerMask.GetMask("Default")
  elseif cull_type == CULL_ALL then
    mask = UnityEngine.LayerMask.GetMask("")
    cull_type_name = "所有"
  else
    cull_type_name = "不剔除"
    mask = org_mask
  end
  camera.cullingMask = mask
  camera.clearFlags = UnityEngine.CameraClearFlags.SolidColor
  camera.backgroundColor = UnityEngine.Color.black
  item_info.Tips = item_info.name .. ", " .. cull_type_name
  self:refresh_tips(item_info.Tips)
end

local is_cull_default = false

function ui:camera_cull_default(item_info)
  is_cull_default = not is_cull_default
  local camera = Global.camera and Global.camera:get_camera()
  if not camera then
    local camera_obj = UIMgr:get_wcanvas_transform().gameObject
    camera = camera_obj:GetComponentInChildren(typeof(UnityEngine.Camera))
  end
  if not org_mask then
    org_mask = camera.cullingMask
  end
  local mask
  if is_cull_default then
    mask = UnityEngine.LayerMask.GetMask("Character", "NPC", "Terrain")
  else
    mask = org_mask
  end
  camera.cullingMask = mask
  camera.clearFlags = UnityEngine.CameraClearFlags.SolidColor
  camera.backgroundColor = UnityEngine.Color.black
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(is_cull_default)
  self:refresh_tips(item_info.Tips)
end

local is_cull_all = false

function ui:cull_all(item_info)
  is_cull_all = not is_cull_all
  local camera = Global.camera and Global.camera.v_camera
  if not camera then
    local camera_obj = UIMgr:get_wcanvas_transform().gameObject
    camera = camera_obj:GetComponentInChildren(typeof(UnityEngine.Camera))
  end
  if not org_mask then
    org_mask = camera.cullingMask
  end
  local mask
  if is_cull_all then
    mask = UnityEngine.LayerMask.GetMask("")
  else
    mask = org_mask
  end
  camera.cullingMask = mask
  camera.clearFlags = UnityEngine.CameraClearFlags.SolidColor
  camera.backgroundColor = UnityEngine.Color.black
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(is_cull_all)
  self:refresh_tips(item_info.Tips)
end

function ui:set_obj_visible(item_info, name)
  local obj = UnityFind(name)
  if not obj then
    return
  end
  local visible = obj.activeInHierarchy
  visible = not visible
  obj:SetActive(visible)
end

function ui:camera_cull_distance(item_info, distance)
  local camera = Global.camera:get_camera()
  camera.farClipPlane = distance
  self:refresh_tips("裁剪距离：", distance)
end

local trail_effect_enable = true

function ui:set_trail_effect_enable(item_info, name)
  trail_effect_enable = not trail_effect_enable
  CS.Game.TrailEffect.IsEnable = trail_effect_enable
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(trail_effect_enable)
  self:refresh_tips(item_info.Tips)
end

local is_dyanmic_enable = true

function ui:set_dynamic_ui_enable(item_info)
  is_dyanmic_enable = not is_dyanmic_enable
  local dynamic_ui = UIMgr:get_ui("uidynamic_canvas")
  dynamic_ui.v_object:SetActive(is_dyanmic_enable)
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(is_dyanmic_enable)
  self:refresh_tips(item_info.Tips)
end

local is_hp_enable = true

function ui:set_hp_root_enable(item_info)
  is_hp_enable = not is_hp_enable
  local dynamic_ui = UIMgr:get_ui("uidynamic_canvas")
  dynamic_ui:get_hp_root_trans().gameObject:SetActive(is_hp_enable)
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(is_hp_enable)
  self:refresh_tips(item_info.Tips)
end

local is_hurt_enable = true

function ui:set_hurt_root_enable(item_info)
  is_hurt_enable = not is_hurt_enable
  local dynamic_ui = UIMgr:get_ui("uidynamic_canvas")
  dynamic_ui:get_hurt_root_trans().gameObject:SetActive(is_hurt_enable)
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(is_hurt_enable)
  self:refresh_tips(item_info.Tips)
end

function ui:set_debug_res(item_info)
  Global.debug_res = not Global.debug_res
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(Global.debug_res)
  self:refresh_tips(item_info.Tips)
end

function ui:set_debug_preload_npc(item_info)
  Global.debug_preload_npc = not Global.debug_preload_npc
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(Global.debug_preload_npc)
  self:refresh_tips(item_info.Tips)
end

function ui:preload_effect_on_born(item_info)
  Global.debug_born_load_effect = not Global.debug_born_load_effect
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(Global.debug_born_load_effect)
  self:refresh_tips(item_info.Tips)
end

function ui:hide_effect(item_info)
  Global.debug_hide_effect = not Global.debug_hide_effect
  item_info.Tips = item_info.name .. ", " .. (Global.debug_hide_effect and "隐藏" or "显示")
  self:refresh_tips(item_info.Tips)
end

function ui:auto_skip_story(item_info)
  Global.is_skip_story = not Global.is_skip_story
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(Global.is_skip_story)
  self:refresh_tips(item_info.Tips)
end

function ui:auto_skip_insert_needle_game(item_info)
  Global.is_skip_insert_needle = not Global.is_skip_insert_needle
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(Global.is_skip_insert_needle)
  self:refresh_tips(item_info.Tips)
end

function ui:switch_block(item_info, id, block_id)
  Global.sound_mgr:switch_block(id, block_id)
end

function ui:set_bus(item_info, bus_name, level)
  Global.sound_mgr:set_bus_sendLevel_bgm(bus_name, tonumber(level))
end

function ui:set_aisac(item_info, control_name, set_value)
  Global.sound_mgr:set_bgm_aisac_control(control_name, set_value)
end

function ui:play_sound_gm(item_info, sound_name)
  Global.sound_mgr:play_sound_by_id(sound_name)
end

function ui:open_uigm_spine(item_info, args)
  UIMgr:get_ui("uigm_spine"):ui_show()
  self:ui_hide()
end

local enable_pbr = false

function ui:set_pbr_enable(item_info)
  enable_pbr = not enable_pbr
  local ill = CS.SceneIllumination.Instance
  for i = 0, ill.SceneMats.Length - 1 do
    local mat = ill.SceneMats[i]
    if enable_pbr then
      mat:EnableKeyword("_PBR_FLOW")
    else
      mat:DisableKeyword("_PBR_FLOW")
    end
  end
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(Global.is_skip_story)
  self:refresh_tips(item_info.Tips)
end

function ui:log_device_unique_identifier(item_info)
  local mac_address = UnityEngine.SystemInfo.deviceUniqueIdentifier
  Log.Info("设备唯一标识: ", mac_address)
end

local CSScreen = CSUnityEngine.Screen

function ui:set_screen_down_times(item_info, times)
  times = times or 1.2
  CSScreen.SetResolution(math.floor(self.screen_width / times), math.floor(self.screen_height / times), true)
end

local debug_useless_preload_fx = false

function ui:start_debug_uesless_preload_fx(item_info)
  debug_useless_preload_fx = not debug_useless_preload_fx
  Global.debug_useless_preload_fx = debug_useless_preload_fx
  Global.debug_preload = {}
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(debug_useless_preload_fx)
  self:refresh_tips(item_info.Tips)
end

function ui:log_uesless_preload_fx()
  if not Global.debug_useless_preload_fx then
    Log.Error("请在加载前打开【调试冗余预加载特效】")
    return
  end
  local log_path = UnityEngine.Application.dataPath .. "/useless_fx.txt"
  local file = io.open(log_path, "w")
  if file then
    file:write("下面是预加载了但是没用到的特效：\n")
    for prefab_path, value in pairs(Global.debug_preload) do
      if 1 == value then
        file:write(prefab_path .. "\n")
      end
    end
    file:close()
    Log.Info("冗余预加载特效日志已保存到：" .. log_path)
  else
    Log.Error("下面是预加载了但是没用到的特效：")
    for prefab_path, value in pairs(Global.debug_preload) do
      if 1 == value then
        Log.Error(prefab_path)
      end
    end
  end
  Global.debug_preload = {}
end

function ui:set_grass_draw_distance(item_info, distance)
  local root = UnityFind("Root")
  local grass_renderers = root:GetComponentsInChildren(typeof(CS.Game.GrassRenderer), true)
  for i = 0, grass_renderers.Length - 1 do
    local rd = grass_renderers[i]
    rd.drawDistance = distance
  end
  self:refresh_tips("裁剪距离：", distance)
end

local enable_grass = true

function ui:set_grass_enable(item_info)
  enable_grass = not enable_grass
  local root = UnityFind("Root")
  local grass_renderers = root:GetComponentsInChildren(typeof(CS.Game.GrassRenderer), true)
  if not grass_renderers then
    return
  end
  for i = 0, grass_renderers.Length - 1 do
    local rd = grass_renderers[i]
    rd.enabled = enable_grass
  end
  local root = UnityFind("Root")
  local rds = root:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)
  for i = 0, rds.Length do
    if string.match(rds[i].gameObject.name, "grass") then
      rds[i].gameObject:SetActive(enable_grass)
    end
  end
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(enable_grass)
  self:refresh_tips(item_info.Tips)
end

local enable_log_power = false

function ui:enable_log_power(item_info)
  enable_log_power = not enable_log_power
  Global.enable_log_power = enable_log_power
end

function ui:tsi_pay(item_info, product_id)
  product_id = product_id or "tc.bb.100package1"
  SDKManager:buy_product(product_id)
end

function ui:signboard_action(item_info, idx)
  local buddy_id = PlayerMgr:get_signboard_girl_id()
  local fashion_id = FashionMgr:get_fashion_wearing_id(buddy_id)
  local char_action_cfg = ShareRes.create("signboard_girl.signboard_girl_action")
  local char_action = char_action_cfg[idx]
  if not char_action then
    Log.Info("GM 播放未找到配置   看板反应ID", idx)
    return
  end
  if char_action.BuddyId ~= buddy_id and char_action.BuddyId ~= fashion_id then
    Log.Info("GM 播放 看板反应ID与当前角色不符", idx)
    return
  end
  SignBoardGirlMgr:gm_send_signboard_action(char_action)
end

function ui:disable_custom_resolve_camera(item_info)
  Global.disable_custom_resolve_camera = not Global.disable_custom_resolve_camera
  item_info.Tips = item_info.name .. ", " .. (Global.disable_custom_resolve_camera and "禁用" or "开启")
  self:refresh_tips(item_info.Tips)
end

function ui:equation_level_up(item_info, uuid, equation_id)
  local equation_data
  if not equation_id then
    local _
    _, equation_data = next(FateBookMgr:get_equation_data_map())
    if equation_data then
      equation_id = equation_data.id
    end
  else
    equation_data = FateBookMgr:get_equation_data(equation_id)
  end
  if not equation_data then
    return
  end
  local sect_info
  if equation_data.level <= 0 then
    local equation_cfg = ShareRes.get_curse_equation_cfg(equation_id)
    sect_info = equation_cfg.Sect
  elseif equation_data.branch_id <= 0 then
    return
  else
    local max_level = ShareRes.get_curse_equation_branch_max_level(equation_data.branch_id)
    if max_level <= equation_data.level then
      return
    end
    local target_level = equation_data.level + 1
    local branch_cfg = ShareRes.get_curse_equation_branch_cfg(equation_data.branch_id, target_level)
    if branch_cfg then
      sect_info = branch_cfg.Sect
    end
  end
  local target_count_map = {}
  local ability_id_map = {}
  for key, info in pairs(sect_info) do
    target_count_map[info.Sect] = target_count_map[info.Sect] or 0
    target_count_map[info.Sect] = target_count_map[info.Sect] + info.Count
  end
  local all_ability_cfg = ShareRes.create("activity.ability")
  for key, ability_cfg in pairs(all_ability_cfg) do
    if not GenresMgr:has_ability(ability_cfg.Id) and target_count_map[ability_cfg.Sect] then
      target_count_map[ability_cfg.Sect] = target_count_map[ability_cfg.Sect] - 1
      if 0 == target_count_map[ability_cfg.Sect] then
        target_count_map[ability_cfg.Sect] = nil
      end
      ability_id_map[#ability_id_map + 1] = ability_cfg.Id
    end
    if not next(target_count_map) then
      target_count_map = nil
      break
    end
  end
  if target_count_map then
    return
  end
  local ADD_ABILITY = "add_ability"
  for _, ability_id in ipairs(ability_id_map) do
    local args_map = {uuid = uuid, ability_id = ability_id}
    local request = {
      instruct = ADD_ABILITY,
      args_map = Seri.packstring(args_map)
    }
    Network:call("c2gs_execute_instruct", request, function(ok, resp)
      Log.Info(ok, resp.result)
    end)
  end
end

function ui:add_genres_ability(item_info, uuid, genres_id, count)
  local ADD_ABILITY = "add_ability"
  local all_ability_cfg = ShareRes.create("activity.ability")
  for key, ability_cfg in pairs(all_ability_cfg) do
    if not GenresMgr:has_ability(ability_cfg.Id) and ability_cfg.Sect == genres_id then
      local args_map = {
        uuid = uuid,
        ability_id = ability_cfg.Id
      }
      local request = {
        instruct = ADD_ABILITY,
        args_map = Seri.packstring(args_map)
      }
      Network:call("c2gs_execute_instruct", request, function(ok, resp)
        Log.Info(ok, resp.result)
      end)
      count = count - 1
      if count <= 0 then
        break
      end
    end
  end
end

function ui:clean_all_episode_box_data(item_info, uuid)
  local treasure_chest_cfg = ShareRes.create("episode_box.episode_box")
  local instruct = "clean_episode_box_data"
  for _, cfg in pairs(treasure_chest_cfg) do
    local args_map = {
      uuid = uuid,
      box_id = cfg.Id
    }
    local request = {
      instruct = instruct,
      args_map = Seri.packstring(args_map)
    }
    Network:call("c2gs_execute_instruct", request, function(ok, resp)
      Log.Info(ok, resp.result)
    end)
  end
end

function ui:back_ring_debug(item_info)
  Global.back_ring_debug = not Global.back_ring_debug
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(Global.back_ring_debug)
  self:refresh_tips(item_info.Tips)
end

function ui:skip_new_player_flow(item_info, uuid)
  if PlayerMgr then
    PlayerMgr:skip_new_player_flow()
  end
end

local is_cull_ui = false

function ui:cull_ui(item_info)
  is_cull_ui = not is_cull_ui
  local ui_camera = Util.get_component(nil, UIMgr.root_camera_obj, typeof(UnityEngine.Camera))
  local mask = is_cull_ui and UnityEngine.LayerMask.GetMask("UI3D") or UnityEngine.LayerMask.GetMask("UI", "UI3D")
  ui_camera.cullingMask = mask
end

local function get_ip()
  local ip_addresses = CS.System.Net.Dns.GetHostAddresses(CS.System.Net.Dns.GetHostName())
  for index = 0, ip_addresses.Length - 1 do
    local ip = ip_addresses[index]
    if ip.AddressFamily == CS.System.Net.Sockets.AddressFamily.InterNetwork then
      return ip:ToString()
    end
  end
end

function ui:start_listen_lua_code(item_info, port)
  port = port or 65535
  local ip = get_ip()
  Util.show_notify_popup_message(nil, "IP地址: " .. ip .. " 端口: " .. port)
  CS.Game.LuaService.StartListeningForConnections(port)
end

function ui:hive_pay(item_info, product_id, price)
  product_id = product_id or "tc.bb.1package1"
  price = price or 1
  Util.show_notify_popup_message(function()
    SDKManager:buy_product(product_id, price, function(result)
      local tip = result and "购买成功" or "购买失败"
      Util.show_message_tip(tip)
    end)
  end, "确定购买" .. product_id .. " " .. tostring(price), nil, "确定", "取消")
end

local enable_luaprofiler_debug = false

function ui:enable_luaprofiler_debug(item_info, open)
  if not USE_LUA_PROFILER then
    Util.show_notify_popup_message(nil, "USE_LUA_PROFILER宏未开启!")
    return
  end
  if not UNITY_ANDROID then
    Util.show_notify_popup_message(nil, "LuaProfiler真机调试仅支持在安卓平台!")
    return
  end
  enable_luaprofiler_debug = not enable_luaprofiler_debug
  CSHelper.OpenLuaProfilerMenu(enable_luaprofiler_debug)
  if enable_luaprofiler_debug then
    local ip = get_ip()
    Util.show_notify_popup_message(function()
      CS.GameToLua.CheckUpdate.RestartAppInAndroid()
    end, "已开启。IP地址: " .. ip .. "\n请重启游戏，使用LuaProfiler连接到此ip后，游戏会自动结束黑屏状态并开始运行。注意，如果不需要再使用LuaProfiler，请再次执行此命令关闭，否则游戏将在每次启动时都黑屏", nil, "重启游戏", "暂不重启")
  else
    Util.show_notify_popup_message(nil, "已关闭")
  end
end

function ui:show_google_utility_params(item_info)
  local is_chromeos = CS.GoogleDeviceUtilities.IsChromeOS
  local is_google_play_games = CS.GoogleDeviceUtilities.IsGooglePlayGames
  local has_keyboard = CS.GoogleDeviceUtilities.HasKeyboard
  local tip = "is_chromeos: " .. tostring(is_chromeos) .. [[

is_google_play_games: ]] .. tostring(is_google_play_games) .. [[

has_keyboard: ]] .. tostring(has_keyboard)
  Util.show_notify_popup_message(nil, tip)
  item_info.Tips = tip
  self:refresh_tips(item_info.Tips)
end

function ui:enable_time_scale_debug(item_info)
  Global.enable_time_scale_debug = not Global.enable_time_scale_debug
  item_info.Tips = item_info.name .. ", " .. get_toggle_desc(Global.enable_time_scale_debug)
  self:refresh_tips(item_info.Tips)
end

function ui:show_review()
  SDKManager:show_review()
end

function ui:is_tablet(item_info)
  local is_tablet = CS.DeviceDetectionUtility.IsTablet()
  item_info.Tips = "是否是平板: " .. tostring(is_tablet)
  self:refresh_tips(item_info.Tips)
end

function ui:show_getui_params()
  local client_id = CS.GTPush.GTPushBinding.getClientId()
  local is_push_turn_on = CS.GTPush.GTPushBinding.isPushTurnOn()
  local version = CS.GTPush.GTPushBinding.getVersion()
  Util.show_notify_popup_message(nil, "个推Client ID: " .. client_id .. "\n是否推送开启: " .. tostring(is_push_turn_on) .. "\n版本: " .. version)
  Log.Info("个推参数: " .. client_id .. "\n是否推送开启: " .. tostring(is_push_turn_on) .. "\n版本: " .. version)
end

function ui:instantiate_google_play_games_inputor()
  local find_obj = UnityFind("GooglePlayGamesInputor")
  if find_obj then
    Util.show_notify_popup_message(nil, "GooglePlayGamesInputor已存在")
    return
  end
  local obj = Global.res_mgr:create_emptygameobj("GooglePlayGamesInputor", true)
  obj:AddComponent(typeof(CS.GooglePlayGamesInputor))
  Util.show_notify_popup_message(nil, "已创建GooglePlayGamesInputor")
end

function ui:run_return_act_test(item_info, story_id)
  UIMgr:get_ui("ui_return_activity_main"):ui_show()
end

function ui:run_minesweeper_act_test(item_info, story_id)
  UIMgr:get_ui("ui_act_minesweeper"):ui_show()
end

function ui:change_main_scene_fashion(item_info, fashion_id)
  FashionMgr:refresh_main_scene_fashion(fashion_id)
end

function ui:open_summer_main_win(item_info)
  local activity_id = TimeLimitedActMgr:get_summer_activity_id()
  UIMgr:get_ui("ui_activity_summer_main"):ui_show(activity_id)
end

function ui:open_version_win_1_2(item_info)
  UIMgr:get_ui("ui_time_limited_activity_main_1_2"):ui_show(42)
end

function ui:enable_texture_streaming(item_info)
  Global.enable_texture_streaming = not Global.enable_texture_streaming
  item_info.Tips = item_info.name .. ", " .. (Global.enable_texture_streaming and "开启" or "关闭")
  self:refresh_tips(item_info.Tips)
end

local enable_camera_occlusion_culling = false

function ui:enable_camera_occlusion_culling(item_info)
  enable_camera_occlusion_culling = not enable_camera_occlusion_culling
  item_info.Tips = item_info.name .. ", " .. (enable_camera_occlusion_culling and "开启" or "关闭")
  self:refresh_tips(item_info.Tips)
  if Global.camera then
    Global.camera:enable_camera_occlusion_culling(enable_camera_occlusion_culling)
  end
end

function ui:start_uwa()
  CS.UWAEngine.StaticInit()
end

function ui:restart_game()
  Util.show_notify_popup_message(function()
    CS.Game.CSHelper.RestartApplication()
  end, "重启游戏", nil, "确定", "取消")
end

function ui:quit_game()
  Util.show_notify_popup_message(function()
    CS.Game.CSHelper.QuitApplication()
  end, "退出游戏", nil, "确定", "取消")
end

function ui:request_url_content(url)
  CSHelper.RequestContent(url, function(content)
    if not content or "" == content then
      Log.Error("request.error：", url)
      return
    end
    Util.show_notify_popup_message(nil, content)
    Log.Error("request url: " .. url)
    Log.Error("request content: " .. content)
  end)
end

local function get_platform_str()
  if UNITY_EDITOR then
    return "Editor"
  elseif UNITY_ANDROID then
    return "Android"
  elseif UNITY_IOS then
    return "iOS"
  else
    return "Unknown"
  end
end

function ui:request_tsi_update_md5()
  local platform = get_platform_str()
  local url = "https://cdnblackbeacon.mtiancity.com/10e909e7-8fbb-41e6-9afd-5aac80b44caa/release/" .. platform .. "/update_version_md5.md5"
  self:request_url_content(url)
end

function ui:request_tsi_live_server_list()
  local url = "https://cdnblackbeacon.mtiancity.com/sliebiao/live/server_list.json"
  self:request_url_content(url)
end

function ui:request_tsi_live_qd_server_list()
  local url = "https://cdnblackbeacon.mtiancity.com/sliebiao/live-qd/server_list.json"
  self:request_url_content(url)
end

function ui:show_patch_version_info()
  local major_version = Util.get_patch_major_version()
  local res_version = Util.get_patch_res_version()
  Util.show_notify_popup_message(nil, "patch版本信息: " .. major_version .. "." .. res_version)
end

function ui:show_build_version_info()
  local build_version_info = Util.get_bundle_version()
  local build_res_version_info = Util.get_build_res_version()
  Util.show_notify_popup_message(nil, "build版本信息: " .. build_version_info .. "." .. build_res_version_info)
end

function ui:set_window_mode(item_info, width, height)
  CS.Game.WindowsResolutionChangger.SetResolution(width, height, CS.Game.WindowsResolutionChangger.WindowMode.Windowed)
  item_info.Tips = item_info.name .. ", " .. "设置窗口模式: " .. width .. "x" .. height
  self:refresh_tips(item_info.Tips)
end

function ui:set_borderless_mode(item_info, width, height)
  CS.Game.WindowsResolutionChangger.SetResolution(width, height, CS.Game.WindowsResolutionChangger.WindowMode.Borderless)
  item_info.Tips = item_info.name .. ", " .. "设置无边框模式: " .. width .. "x" .. height
  self:refresh_tips(item_info.Tips)
end

function ui:set_fullscreen_mode(item_info, width, height)
  CS.Game.WindowsResolutionChangger.SetResolution(width, height, CS.Game.WindowsResolutionChangger.WindowMode.FullScreen)
  item_info.Tips = item_info.name .. ", " .. "设置全屏模式: " .. width .. "x" .. height
  self:refresh_tips(item_info.Tips)
end

function ui:set_windows_scroll_rect_sensitivity(item_info, sensitivity)
  UnityUIScrollRect.SCROLL_SENSITIVITY_MULTIPLIER = sensitivity
  item_info.Tips = item_info.name .. ", " .. "设置Windows滚动条灵敏度: " .. sensitivity
  self:refresh_tips(item_info.Tips)
end

function ui:play_fish_game()
  UIMgr:get_ui("fish_game_stage"):ui_show()
end

function ui:play_ponder_maze_game(item_info, activity_id)
  UIMgr:get_ui("ui_maze_game_main"):ui_show(activity_id)
end

return ui
