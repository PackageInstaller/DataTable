local M = {}
local TYPE_PLAY_DIRECTOR = typeof(UnityEngine.Playables.PlayableDirector)
local temp_list = {}
local name2act = {}
local UIConfig = require("ui.uiconfig")

local function set_act(out_put_array, pd)
  local size = UtilTable.hash_lenth(name2act)
  for i = 1, size do
    local sobj = out_put_array[i + 1].sourceObject
    local lua_obj = name2act[sobj.name]
    if lua_obj and not lua_obj:is_destroy() then
      pd:SetGenericBinding(sobj, lua_obj.cg_play_obj)
    end
  end
end

Global.is_fixed_timeline = true
M.IS_PLAY_TIMELINE = false
M.PLAYING_TIMLINE = {}

function M.play_time_line_seq(data)
  if M.stop_func then
    return
  end
  local name = data.name
  local fade_in = data.fade_in
  local fade_out = data.fade_out
  local uuid_list = data.uuid_list
  local can_skip = data.can_skip
  local is_active_lua = data.is_active_lua
  local close_camera_transparent = data.close_camera_transparent
  local black_fade_in = data.black_fade_in or 0
  local black_fade_out = data.black_fade_out or 0
  local black_hold = data.black_hold or 0
  local is_show_ui = data.is_show_ui or false
  M.IS_DELAY_DESTROY = data.is_delay_destroy
  local before_black_fade_in = data.before_black_fade_in
  local before_black_fade_out = data.before_black_fade_out
  local before_black_hold = data.before_black_hold
  local is_white = data.is_white
  Log.Info("play timeline", name)
  if M.IS_DELAY_DESTROY then
    black_hold = -1
    if black_fade_in <= 0 then
      black_fade_in = 0.1
    end
    if black_fade_out <= 0 then
      black_fade_out = 0.1
    end
  end
  M.close_camera_transparent = close_camera_transparent
  local act_list = {}
  local act_size = uuid_list and #uuid_list or 0
  if nil == can_skip then
    can_skip = true
  end
  Cinemachine:update_settings(fade_in, fade_out)
  for i = 1, act_size do
    table.insert(act_list, SceneMgr:pick_by_uuid(uuid_list[i]))
  end
  
  local function do_play()
    UtilTable.clear_map(temp_list)
    UtilTable.clear_map(name2act)
    for i = 1, #act_list do
      name2act["act" .. i] = act_list[i]
    end
    local obj = ResPoolMgr:get_timeline(name)
    if nil == obj or obj:IsNull() then
      Log.Error("load timeline failed! ", name)
      return
    end
    M.PLAYING_TIMLINE[obj.name] = obj
    local root_trans = obj.transform
    M.v_root_trans = root_trans
    for i = 0, root_trans.childCount - 1 do
      local child = root_trans:GetChild(i)
      Util.reset_by_root(root_trans.gameObject)
      local vcams = child:GetComponentsInChildren(TypeCinemaVirtalCamera, true)
      for cam_idx = 0, vcams.Length - 1 do
        vcams[cam_idx].Priority = 100 + i
      end
      if not Global.is_fixed_timeline then
        local pd = child:GetComponent(TYPE_PLAY_DIRECTOR)
        local outputs = pd.playableAsset:GetBindings()
        set_act(outputs, pd)
      end
    end
    if false == can_skip and true == is_show_ui then
      UIConfig:set_sort_order_to_tip(UIConfig.ui.ui_timeline)
    else
      UIConfig:set_sort_order_to_system(UIConfig.ui.ui_timeline)
    end
    local ui_timeline
    ui_timeline = UIMgr:get_ui("ui_timeline")
    ui_timeline:ui_show(can_skip, is_show_ui)
    M.need_fade_out = true
    M.IS_PLAY_TIMELINE = true
    SceneMgr:c2gs_call_scene("on_timeline_start", name)
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_TIMELINE_BEGIN, name)
    BehaviorMgr:call_scene_logic_event_fun("on_timeline_start", name)
    local global_camera = Global.camera
    if global_camera and global_camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.SHOULDER and (black_fade_in > 0 or black_fade_out > 0 or black_hold > 0 or 0 == black_fade_in and 0 == black_fade_out and 0 == black_hold and 0 == fade_out) then
      Cinemachine:update_settings(fade_in, 0)
    end
    
    function M.stop_func(is_skip, force)
      local function cb()
        M.close_camera_transparent = false
        
        local function fade_out_cb()
          if root_trans and not root_trans:IsNull() then
            M.PLAYING_TIMLINE[obj.name] = nil
            ResPoolMgr:release(obj)
          end
          Global.is_cg_active_lua = true
          for _, lua_obj in pairs(act_list) do
            lua_obj:set_playing_cg(false)
          end
          if force then
            UIMgr:try_hide_ui("ui_timeline")
          end
        end
        
        root_trans.gameObject:SetActive(false)
        M.stop_func = nil
        if M.need_fade_out and not is_skip then
          ui_timeline:ui_hide()
        end
        M.IS_PLAY_TIMELINE = false
        MsgGame:mq_publish2(Const.MSG_CG_TIMELINE_END)
        if not force and Util.is_more_than_zero(fade_out) then
          Timer:add_timer("stop", fade_out, fade_out_cb)
        else
          fade_out_cb()
        end
        SceneMgr:c2gs_call_scene(BehaviorMgr.EVENTS.ON_TIMELINE_END, name)
        BehaviorMgr:call_scene_logic_event_fun(BehaviorMgr.EVENTS.ON_TIMELINE_END, name)
        BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_TIMELINE_END, name)
      end
      
      if black_fade_in > 0 and black_fade_out > 0 then
        UIMgr:get_ui("ui_blackfade"):ui_show(black_fade_in, black_hold, black_fade_out, cb, true, is_white)
      else
        cb()
      end
    end
    
    Global.is_cg_active_lua = is_active_lua
    if can_skip or not is_show_ui then
      MsgGame:mq_publish2(Const.MSG_CG_TIMELINE_START)
    end
    root_trans:PlayTimeLineSeq(M.stop)
  end
  
  if 0 == act_size then
    M.execution_do_play(do_play, before_black_fade_in, before_black_fade_out, before_black_hold, is_white)
  else
    local load_count = 0
    
    local function add_load_count()
      load_count = load_count + 1
      if load_count == act_size then
        M.execution_do_play(do_play, before_black_fade_in, before_black_fade_out, before_black_hold, is_white)
      end
    end
    
    for _, lua_obj in pairs(act_list) do
      lua_obj:set_playing_cg(true, add_load_count)
    end
  end
end

function M.execution_do_play(cb, before_black_fade_in, before_black_fade_out, before_black_hold, is_white)
  if before_black_fade_in and before_black_fade_out and before_black_fade_in > 0 and before_black_fade_out > 0 then
    UIMgr:get_ui("ui_blackfade"):ui_show(before_black_fade_in, before_black_hold, before_black_fade_out, cb, nil, is_white)
  else
    cb()
  end
end

function M.stop(is_skip, force)
  if M.stop_func then
    M.stop_func(is_skip, force)
  end
  if is_skip and TimeLineMgr then
    TimeLineMgr:check_curr_timeline_audio()
    TimeLineMgr:on_timeline_skip()
  end
end

function M.after_enter_loading()
  M.destroy_root()
end

function M.on_enter_room()
  M.stop(true, true)
  M.destroy_root()
end

function M.after_enter_settle()
  if M.IS_DELAY_DESTROY then
    UIMgr:try_destory_ui("ui_blackfade")
    M.destroy_root()
  end
end

function M.on_game_pause_state_change(is_pause)
  if not Util.is_nil(M.v_root_trans) then
    M.v_root_trans:SetTimeLinePause(is_pause)
  end
end

function M.destroy_root()
  M.release_all_timeline()
  M.IS_DELAY_DESTROY = false
  M.IS_PLAY_TIMELINE = false
  M.stop_func = nil
  M.v_root_trans = nil
  Global.is_cg_active_lua = true
end

function M.release_all_timeline()
  for name, obj in pairs(M.PLAYING_TIMLINE) do
    ResPoolMgr:release(obj)
  end
  M.PLAYING_TIMLINE = {}
end

return M
