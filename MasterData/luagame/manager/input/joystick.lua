local Mathx = require("base.mathx")
local M = {}
local POINTER_DOWN = 0
local POINTER_UP = 1
local START_EVENT = "start"
local END_EVENT = "end"
local POINTER_DOWN_EVENT = "pointerdown"
local POINTER_UP_EVENT = "pointerup"
local _abs = math.abs

function M.on_joystick(event, x, y)
  local hero = Global.hero
  if not (hero and Global.camera) or not Global.gamemode:gmode_is_game() then
    return
  end
  if SceneMgr and (SceneMgr:get_game_pause() or not SceneMgr:is_can_controlled()) and "end" ~= event then
    return
  end
  if event == START_EVENT then
  elseif event == END_EVENT then
    if not Global.joystick then
      return
    end
    Global.joystick_session = Global.joystick_session + 1
    Global.joystick = false
    Global.joystick_origin_x = 0
    Global.joystick_origin_y = 0
    Global.joystick_x = 0
    Global.joystick_y = 0
    Global.joystick_time = 0
    Global.camera_joystick_x = 0
    Global.camera_joystick_y = 0
    Global.camera:set_camera_is_only_forward(false)
    local state_manager = hero.state_manager
    state_manager:stop_move()
    hero.role_move_ctrl:set_joystick_dir(0, 0)
  elseif event == POINTER_DOWN_EVENT then
    M.on_joystick_pointer(0, UnityEngine.Input.touchCount - 1)
  elseif event == POINTER_UP_EVENT then
    M.on_joystick_pointer(1)
  elseif x and y and (_abs(x) >= 0.1 or _abs(y) >= 0.1) and Global.is_cg_active_lua then
    local fight_ui = UIMgr:try_get_visible_ui(UIMgr.FIGHT_UI_NAME)
    if fight_ui and not fight_ui:check_joystick_move() then
      return
    end
    local inverse_factor = Global.joystick_inverse and -1 or 1
    x = x * inverse_factor
    y = y * inverse_factor
    Global.joystick_x = x
    Global.joystick_y = y
    Global.joystick = true
    Global.joystick_time = Global.joystick_time + Global.delta_time
    local vec = Global.camera:camera_rotate(x, 0, y)
    Global.camera:set_camera_is_only_forward(0 == x)
    Global.camera_joystick_x = vec.x
    Global.camera_joystick_y = vec.z
    Global.hero.state_manager:move_by_dir(vec.x, vec.z)
    Global.hero.role_move_ctrl:set_joystick_dir(vec.x, vec.z)
    if fight_ui then
      fight_ui:on_joystick()
    end
  end
end

function M.on_joystick_pointer(event, pointer_id)
  if event == POINTER_DOWN then
    Global.joystick_pointer = true
    Global.joystick_pointer_id = pointer_id
  elseif event == POINTER_UP then
    Global.joystick_pointer = false
    Global.joystick_pointer_id = -1
  end
end

function M.on_jump()
end

function M.on_key(key)
  local test = require("test")
  test.test_key(key)
end

return M
