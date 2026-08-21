local Config = require("config")
local ShareRes = require("utils.share_res")
local Math = require("base.mathx")
local Layer = require("utils.layer")
local Json = require("utils.json")
local Vec3 = require("base.vec3")
local Vec2 = require("base.vec2")
local Quat = require("base.quat")
local VEC3_TEMP = Vec3.New(0, 0, 0)
local VEC3_TEMP_1 = Vec3.New(0, 0, 0)
local VEC2_TEMP = Vec2.New(0, 0)
local QuatTemp = Quat.New(0, 0, 0, 0)
local CSHelper = _ENV.CSHelper
local CSDragEventListener = CS.Game.DragEventListener
local CSDragEventListener2 = CS.Game.DragEventListener2
local TouchManager = CS.TouchManager
local TABLE_STR = "table"
local NUMBER_STR = "number"
local COMPONENT_TYPE_STR = "component_type"
local TRANSFORM_STR = "transform"
local COMPONENT_STR = "component"
local FUNCTION_STR = "function"
local GAMEOBJECT_STR = "gameObject"
local AssetCache = require("manager.res.asset_cache")
local Regex = CS.System.Text.RegularExpressions.Regex
local legal_special_char = "^[\\u4e00-\\u9fa5A-Za-z0-9%s]+$"
local special_char = ShareRes.get_legal_special_char()
legal_special_char = string.format(legal_special_char, special_char)
local UnityFind = _ENV.UnityFind
local UnityShader = UnityEngine.Shader
local UnityScreen = UnityEngine.Screen
local Rect = UnityEngine.Rect
local _cos = math.cos
local _acos = math.acos
local _sin = math.sin
local _rad2deg = math.deg(1)
local _deg2rad = math.rad(1)
local _floor = math.floor
local _insert = table.insert
local _format = string.format
local _clamp = Math.Clamp
local _tconcat = table.concat
local _find = string.find
local _gsub = string.gsub
local TWO_PI = 2 * math.pi
local HALF_PI = math.pi / 2
local ONE_HALF_PI = math.pi * 3 / 2
local COLOR_CODE_TEMPLATE = "<color=#%s>%s</color>"
local Cs_color = UnityEngine.Color
local PointListener = CS.Game.PointEventListener
local CSDOTween = CS.DG.Tweening.DOTween
local ItemQualityCfg = ShareRes.create("item.item_quality")
local VersionInfo = require("version")
local BuildVersionInfo = require("build_version")
local INDEX = 0
local M = {}
M.ColorWhite = Cs_color.white
M.ColorGreen = Cs_color.green
M.ColorRed = Cs_color.red
M.VEC3_TEMP = VEC3_TEMP
M.VEC3_TEMP_1 = VEC3_TEMP_1
M.VEC2_TEMP = VEC2_TEMP
M.QuatTemp = QuatTemp
M.EMPTY_STR = ""
local CSUnityMaterial = UnityEngine.Material
local CSUnityGraphic = UnityEngineUI.Graphic
local UnityGraphicType = typeof(CSUnityGraphic)
local TypeCustomDOTween = typeof(CS.CustomDOTween)
local CSPlayerableDirector = UnityEngine.Playables.PlayableDirector
local CSSkinnedMeshRednerer = UnityEngine.SkinnedMeshRenderer
local _unique_index = {}
local _track_mt = {
  __index = function(t, k)
    return t[_unique_index][k]
  end,
  __newindex = function(t, k, v)
    if "uuid" == k and nil == v then
      Log.Error("set uuid : ", debug.traceback())
    end
    t[_unique_index][k] = v
  end
}

function M.track(t)
  local proxy = {}
  proxy[_unique_index] = t
  setmetatable(proxy, _track_mt)
  return proxy
end

local holder = {}

function M.newindex_check(src_table, check_func)
  holder[src_table] = src_table
  local proxy = {}
  local mt = {
    __index = function(t, k)
      return src_table[k]
    end,
    __newindex = function(t, k, v)
      if check_func then
        check_func(t, k, v)
      end
      src_table[k] = v
    end
  }
  setmetatable(proxy, mt)
  return proxy
end

function M.create_child_mt(base)
  local child = setmetatable({}, base)
  child.__index = child
  return child
end

local function _create_class_new(self, ...)
  local ret = setmetatable({}, self)
  ret:_init(...)
  return ret
end

local function _create_class_on_destroy(self)
end

function M.create_class()
  local class = {}
  class.__index = class
  class.new = _create_class_new
  class.on_destroy = _create_class_on_destroy
  return class
end

function M.get_i18n(msg)
  if Global.i18n and Global.i18n[msg] then
    return Global.i18n[msg].lang1
  end
  return msg
end

function M.format_str(key, ...)
  local msg = M.get_i18n(key)
  msg = string.gsub(msg, "\\n", "\n")
  return M.format_str_raw(msg, ...)
end

function M.format_str_raw(msg, ...)
  if nil ~= (...) then
    local args = {
      ...
    }
    local result = string.gsub(msg, "{([%d]+)}", function(idx)
      local value = args[tonumber(idx)] or ""
      return tostring(value)
    end)
    return result
  else
    return msg
  end
end

function M.keep_newline(txt)
  return string.gsub(txt, "\\n", "\n")
end

function M.gsub_sex(text, sex)
  return string.gsub(text, "%[#sex|.+.+%]", function(txt)
    local tbl = {}
    string.gsub(txt, "|[^|%]]+", function(pattern)
      _insert(tbl, string.sub(pattern, 2))
    end)
    return tbl[sex + 1]
  end)
end

function M.get_string_len(s)
  return utf8.len(s)
end

function M.get_sub_string_utf8(str, len)
  local index = utf8.offset(str, len + 1)
  local new_str = string.sub(str, 1, index - 1)
  return new_str
end

function M.get_strip_space_str(s)
  local str = string.gsub(s, "^( *)", "")
  return string.gsub(str, "$( *)", "")
end

function M.hide_notify_popup_message()
  Global.ui_mgr:try_hide_ui("uinotice_tips")
end

function M.show_notify_popup_message(confirm_cb, message, title, confirm_txt, cancel_txt, cancel_cb, one_btn, battle_setting, enable_bg_click)
  local notice_ui = UIMgr:try_get_visible_ui("uinotice_tips")
  if not notice_ui then
    notice_ui = Global.ui_mgr:get_ui("uinotice_tips")
    notice_ui:ui_show(confirm_cb, cancel_cb, message, confirm_txt, cancel_txt, title, one_btn, battle_setting)
  else
    notice_ui:refresh_data(confirm_cb, cancel_cb, message, confirm_txt, cancel_txt, title, one_btn, battle_setting)
  end
  if enable_bg_click then
    notice_ui:enable_bg_click(true)
  end
end

function M.create_sequence()
  return CSDOTween.Sequence()
end

function M.wrap_xpcall_func(func, ...)
  xpcall(func, function(err)
    Log.Error(err, debug.traceback())
  end, ...)
end

function M.show_server_error(err_msg)
  if not err_msg then
    return
  end
  Global.lua_error.on_lua_error(err_msg, "服务器报错")
end

function M.show_client_error(err_msg)
  if not err_msg then
    return
  end
  Global.lua_error.on_lua_error(err_msg, "客户端报错")
end

function M.get_error_code_msg(errcode)
  local error_info = ShareRes.create("err_code.err_code", errcode)
  return error_info and error_info.tips or "未知错误码"
end

function M.is_errcode_empty(errcode)
  return not errcode or 0 == errcode
end

function M.show_errkey(errkey, ...)
  if not errkey or filter_errors[errkey] then
    return
  end
  local errcode_msg = M.format_str(errkey, ...)
  local ui = Global.ui_mgr:get_ui("error_message")
  ui:ui_show(errcode_msg)
  Global.log.Debug("--- errkey ---", errkey)
end

function M.show_errcode(errcode, err_fun)
  local error_info = M.get_errcode_msg(errcode)
  if not error_info then
    return
  end
  if err_fun then
    err_fun(error_info)
    return
  end
  if not GAME_DEBUG and 1 == error_info.ignore_tips then
    return
  end
  local error_ui = error_info.error_ui
  if 0 == error_ui then
    return
  elseif 1 == error_ui then
    M.show_message_tip(error_info.tips)
  elseif 2 == error_ui then
    M.show_conform_tip(error_info.tips, nil, nil, nil, nil, true)
  end
end

function M.get_errcode_msg(errcode)
  local error_info = ShareRes.create("err_code.err_code", errcode)
  return error_info
end

function M.debug_print(k, v)
  local t = UIMgr:get_ui("ui_debug_info").debug_info
  if t then
    t[k] = tostring(v)
  end
end

function M.show_message(message, ...)
  message = Util.format_str(message, ...)
  local ui = Global.ui_mgr:get_ui("error_message")
  ui:ui_show(message)
end

function M.show_special_message(message, ...)
  message = Util.format_str(message, ...)
  local ui = Global.ui_mgr:get_ui("enter_fight_message")
  ui:ui_show(message)
end

function M.show_system_forbidden()
  M.show_error("系统暂未开放")
end

function M.shadow_copy(vtable)
  local t = {}
  for k, v in pairs(vtable) do
    t[k] = v
  end
  return t
end

function M.reset_trans(trans)
  trans:SetPositionA(0, 0, 0)
end

local _abs = math.abs

function M.almost_zero(number, interval)
  interval = interval or 1.0E-5
  return interval > _abs(number)
end

function M.is_target_camp(obj_self, obj_tar, relationship)
  relationship = tonumber(relationship)
  local need_self = 1 == relationship % 2
  local need_friend = 1 == (relationship >> 1) % 2
  local need_enamy = 1 == (relationship >> 2) % 2
  if need_self and obj_self == obj_tar then
    return true
  end
  if need_friend and obj_self:get_camp() == obj_tar:get_camp() and obj_self ~= obj_tar then
    return true
  end
  if need_enamy and obj_self:get_camp() ~= obj_tar:get_camp() then
    return true
  end
  return false
end

function M.move(go, x, y, z, layer, ground, max_dis)
  return CSMove(go, x, y, z, layer, ground, max_dis or 50)
end

function M.get_child(name, parent)
  return parent:FindChild(name)
end

local NEED_CACHE_PROPERTIES = {
  [TRANSFORM_STR] = true
}
local GAMEOBJ_INFOS = {}

local function wrap_gameobj_func(func)
  return function(obj, ...)
    assert(obj.gameObject)
    return func(obj.gameObject, ...)
  end
end

local function gameobj_index_func(tbl, key)
  local info = GAMEOBJ_INFOS[key]
  if not info then
    local go = rawget(tbl, GAMEOBJECT_STR)
    local val = go[key]
    local is_func = type(val) == FUNCTION_STR
    local func = is_func and wrap_gameobj_func(val) or nil
    info = {
      is_func,
      func,
      NEED_CACHE_PROPERTIES[key]
    }
    GAMEOBJ_INFOS[key] = info
  end
  if info[1] then
    return info[2]
  else
    local ret = rawget(tbl, GAMEOBJECT_STR)[key]
    if info[3] then
      rawset(tbl, key, ret)
    end
    return ret
  end
end

local function gameobj_newindex_func(tbl, k, v)
  rawget(tbl, GAMEOBJECT_STR)[k] = v
end

local COMPONENT_INFOS = {}

local function wrap_compoent_func(func)
  return function(obj, ...)
    return func(obj.component, ...)
  end
end

local function component_newindex_func(tbl, k, v)
  rawget(tbl, COMPONENT_STR)[k] = v
end

local function component_index_func(tbl, key)
  local component_type = rawget(tbl, COMPONENT_TYPE_STR)
  local component_func_cache = COMPONENT_INFOS[component_type]
  if not component_func_cache then
    component_func_cache = {}
    COMPONENT_INFOS[component_type] = component_func_cache
  end
  local info = component_func_cache[key]
  if not info then
    local component = rawget(tbl, COMPONENT_STR)
    local val = component[key]
    local is_func = type(val) == FUNCTION_STR
    local func = is_func and wrap_compoent_func(val) or nil
    info = {
      is_func,
      func,
      NEED_CACHE_PROPERTIES[key]
    }
    component_func_cache[key] = info
  end
  if info[1] then
    return info[2]
  else
    local ret = rawget(tbl, COMPONENT_STR)[key]
    if info[3] then
      rawset(tbl, key, ret)
    end
    return ret
  end
end

local function get_new_transforms()
  return setmetatable({}, {
    __mode = "k",
    __index = function(tbl, go)
      local transform = go.transform
      rawset(tbl, go, transform)
      return transform
    end
  })
end

local GAMEOBJ_CACHES = setmetatable({}, {__mode = "k"})
local COMPONENT_CACHES = setmetatable({}, {__mode = "k"})
TRANSFORMS = get_new_transforms()
local COMPONENT_METATABLE = {__index = component_index_func, __newindex = component_newindex_func}
local GAMEOBJ_METATABLE = {__index = gameobj_index_func, __newindex = gameobj_newindex_func}

local function SetParent(self, parent, ...)
  self.gameObject:SetParent(parent.gameObject, ...)
end

function M.clear_wrap_caches()
  GAMEOBJ_CACHES = setmetatable({}, {__mode = "k"})
  COMPONENT_CACHES = setmetatable({}, {__mode = "k"})
  TRANSFORMS = get_new_transforms()
end

function M.wrap_gameobj(go)
  local ret = GAMEOBJ_CACHES[go]
  if not ret then
    ret = setmetatable({
      gameObject = go,
      obj = go,
      component_type = TypeUnityGameObject
    }, GAMEOBJ_METATABLE)
    GAMEOBJ_CACHES[go] = ret
  end
  return ret
end

function M.get_child_gameobj(name, parent)
  local trans = parent:FindChild(name)
  local go = trans and trans.gameObject
  if go then
    return M.wrap_gameobj(go)
  else
    return nil
  end
end

local COMPONENT_TYPES = {}

local function get_component_type(type)
  local component_type = COMPONENT_TYPES[type]
  if not component_type then
    component_type = typeof(type)
    COMPONENT_TYPES[type] = component_type
  end
  return component_type
end

function M.get_component(path, parent, component_type)
  local component, gameobj
  if not parent then
    return
  end
  if not path then
    gameobj = parent.gameObject
  else
    assert(parent.FindChild, "parent need be gameObject or transform ")
    gameobj = parent:FindChild(path)
  end
  if gameobj then
    component_type = get_component_type(component_type)
    local components = COMPONENT_CACHES[component_type]
    if not components then
      components = {}
      COMPONENT_CACHES[component_type] = components
    end
    component = components[gameobj]
    if M.is_nil(component) then
      local result = gameobj:GetComponent(component_type)
      if not M.is_nil(result) then
        component = setmetatable({
          gameObject = gameobj,
          component = result,
          obj = result,
          component_type = component_type
        }, COMPONENT_METATABLE)
        components[gameobj] = component
      end
    end
  end
  return component
end

function M.get_canvas(path, parent)
  return M.get_component(path, parent, UnityUICanvas)
end

function M.get_ejlabel(path, parent)
  return M.get_component(path, parent, EJLabel)
end

function M.get_text(path, parent)
  return M.get_component(path, parent, UnityUIText)
end

function M.get_outline(path, parent)
  return M.get_component(path, parent, UnityUIOutline)
end

function M.get_image(path, parent)
  return M.get_component(path, parent, UnityUIImage)
end

function M.get_rawimage(path, parent)
  return M.get_component(path, parent, UnityUIRawImage)
end

function M.get_button(path, parent)
  return M.get_component(path, parent, UnityUIButton)
end

function M.get_button_ex(path, parent)
  return M.get_component(path, parent, CSButtonEx)
end

function M.get_toggle(path, parent)
  return M.get_component(path, parent, UnityUIToggle)
end

function M.get_slider(path, parent)
  return M.get_component(path, parent, UnityUISlider)
end

function M.get_scrollrect(path, parent)
  return M.get_component(path, parent, UnityUIScrollRect)
end

function M.get_dropdown(path, parent)
  return M.get_component(path, parent, UnityUIDropDown)
end

function M.get_scrollrect_ex(path, parent)
  return M.get_component(path, parent, TypeCSScrollRectEx)
end

function M.get_animator(path, parent)
  return M.get_component(path, parent, UnityAnimator)
end

function M.get_inputfield(path, parent)
  return M.get_component(path, parent, UnityUIInputField)
end

function M.get_rect_transform(path, parent)
  return M.get_component(path, parent, UnityRectTransform)
end

function M.get_ui_particle(path, parent)
  return M.get_component(path, parent, CSUIParticle)
end

function M.get_effect_status(path, parent)
  return M.get_component(path, parent, CSEffectStatus)
end

function M.get_playabledirector(path, parent)
  return M.get_component(path, parent, CSPlayerableDirector)
end

function M.get_custom_dotween(path, parent)
  return M.get_component(path, parent, TypeCustomDOTween)
end

function M.get_transform_dist(trans_a, trans_b)
  local x1, y1, z1 = trans_a:GetPositionA()
  local x2, y2, z2 = trans_b:GetPositionA()
  return Math.dist_vec3A(x1, y1, z1, x2, y2, z2)
end

function M.get_skinned_mesh_renderer(path, parent)
  return M.get_component(path, parent, CSSkinnedMeshRednerer)
end

function M.set_click(path, parent, root, cb)
  if path then
    parent = parent.transform:Find(path)
    parent = parent.gameObject
  end
  local event = PointListener.Get(parent).onClick
  Global.listener_mgr:add_listener(root, event, cb)
end

function M.remove_click(path, parent, root)
  if path then
    parent = parent.transform:Find(path)
    parent = parent.gameObject
  end
  local listener = PointListener.Get(parent, true)
  if listener then
    local event = listener.onClick
    Global.listener_mgr:remove_listener(root, event)
  end
end

function M.set_point_down(path, parent, root, cb)
  if path then
    parent = parent.transform:Find(path)
    parent = parent.gameObject
  end
  local event = PointListener.Get(parent).onDown
  Global.listener_mgr:add_listener(root, event, cb)
end

function M.remove_point_down(path, parent, root)
  if path then
    parent = parent.transform:Find(path)
    parent = parent.gameObject
  end
  local listener = PointListener.Get(parent, true)
  if listener then
    local event = listener.onDown
    Global.listener_mgr:remove_listener(root, event)
  end
end

function M.set_point_up(path, parent, root, cb)
  if path then
    parent = parent.transform:Find(path)
    parent = parent.gameObject
  end
  local listener = PointListener.Get(parent, true)
  if listener then
    local event = listener.onUp
    Global.listener_mgr:add_listener(root, event, cb)
  end
end

function M.remove_point_up(path, parent, root)
  if path then
    parent = parent.transform:Find(path)
    parent = parent.gameObject
  end
  local listener = PointListener.Get(parent, true)
  if listener then
    local event = listener.onUp
    Global.listener_mgr:remove_listener(root, event)
  end
end

function M.remove_longpress(path, parent, root)
  if path then
    parent = parent.transform:Find(path)
    parent = parent.gameObject
  end
  local listener = PointListener.Get(parent, true)
  if listener then
    local event = listener.onLongPress
    Global.listener_mgr:remove_listener(root, event)
  end
end

function M.set_longpress(path, parent, root, cb)
  if path then
    parent = parent.transform:Find(path)
    parent = parent.gameObject
  end
  local event = PointListener.Get(parent).onLongPress
  Global.listener_mgr:add_listener(root, event, cb)
end

function M.set_longlongpress(path, parent, root, cb)
  if path then
    parent = parent.transform:Find(path)
    parent = parent.gameObject
  end
  local event = PointListener.Get(parent).onLongLongPress
  Global.listener_mgr:add_listener(root, event, cb)
end

function M.remove_longlongpress(path, parent, root)
  if path then
    parent = parent.transform:Find(path)
    parent = parent.gameObject
  end
  local listener = PointListener.Get(parent, true)
  if listener then
    local event = listener.onLongLongPress
    Global.listener_mgr:remove_listener(root, event)
  end
end

function M.reset_pointer_event(path, parent)
  if path then
    parent = parent.transform:Find(path)
    parent = parent.gameObject
  end
  PointListener.Get(parent):ResetPointerEvent()
end

function M.set_start_drag(gameobj, root, cb)
  local event = CSDragEventListener.Get(gameobj).OnDragHandleStar
  Global.listener_mgr:add_listener(root, event, cb)
end

function M.set_drag(gameobj, root, cb)
  local event = CSDragEventListener.Get(gameobj).OnDragHandle
  Global.listener_mgr:add_listener(root, event, cb)
end

function M.set_end_drag(gameobj, root, cb)
  local event = CSDragEventListener.Get(gameobj).OnDragHandleEnd
  Global.listener_mgr:add_listener(root, event, cb)
end

function M.set_start_drag2(drag_obj, father_obj, cb)
  local event = CSDragEventListener2.BindListener(drag_obj, father_obj).onDragStart
  Global.listener_mgr:add_listener(father_obj, event, cb)
end

function M.set_drag2(drag_obj, father_obj, cb)
  local event = CSDragEventListener2.BindListener(drag_obj, father_obj).onDrag
  Global.listener_mgr:add_listener(father_obj, event, cb)
end

function M.set_end_drag2(drag_obj, father_obj, cb)
  local event = CSDragEventListener2.BindListener(drag_obj, father_obj).onDragEnd
  Global.listener_mgr:add_listener(father_obj, event, cb)
end

function M.inject(meta, api_tbl)
  for k, v in pairs(api_tbl) do
    meta[k] = v
  end
end

function M.remove_prefix(str, prefix)
  prefix = "%." .. prefix
  local pos = string.find(str, prefix)
  if pos then
    return string.sub(str, 1, pos - 1)
  else
    return str
  end
end

local deg2rad = math.pi / 180

function M.get_move_dir(dir)
  local rad = dir * deg2rad
  return math.sin(rad), math.cos(rad)
end

function M.normalize2(x, z)
  if 0 == x and 0 == z then
    return 1, 0
  end
  local len = (x * x + z * z) ^ 0.5
  if len <= 1.0E-5 then
    return 0, 0
  end
  return x / len, z / len
end

local id_list = CS.System.Array.CreateInstance(typeof(CS.System.Int32), 10)
local collider_list = CS.System.Array.CreateInstance(typeof(UnityEngine.Collider), 10)
local CompExtensions = _ENV.CompExtensions
CompExtensions.IdCache = id_list
CompExtensions.ColliderCache = collider_list
local IngnoreTrigger = UnityEngine.QueryTriggerInteraction.Ignore
local char_mask = UnityEngine.LayerMask.GetMask("NPC", "Character")
local block_mask = Layer.obstacle_mask

function M.overlap_sphere(x, y, z, r, is_wall)
  local check_mask = is_wall and block_mask or char_mask
  local len = CompExtensions.OverLapSphere(x, y, z, r, check_mask, IngnoreTrigger)
  return len, id_list, collider_list
end

function M.set_sprite_with_atlas_key(uiobj, image, atlas, key)
  assert(uiobj)
  assert(image)
  assert(key)
  assert(atlas)
  local sprite, res_path = ResMgr:load_atlas_sprite(atlas, key)
  image.overrideSprite = sprite
  uiobj:add_texture_reference(res_path)
end

function M.set_virtual_item_icon(uiobj, image, id)
  local sprite_name = ShareRes.create("item", id).atlas_sprite
  local sprite, res_path = ResMgr:load_atlas_sprite("Common", sprite_name)
  image.overrideSprite = sprite
  uiobj:add_texture_reference(res_path)
end

function M.get_path_name(path)
  return string.match(path, "^.+/([%w_%-]+)")
end

function M.get_path_name_without_subfix(path)
  return string.match(path, "^.+/([%w_%-]+)%.")
end

function M.get_scene_name(path)
  return string.match(path, "^.+/([%w_%-]+).unity")
end

function M.remove_subfix(name)
  local s, e = string.find(name, "^(.+)%.")
  if s then
    return string.sub(name, s, e - 1), true
  else
    return name, false
  end
end

function M.get_subfix(name)
  local _, e = string.find(name, "^(.+)%.")
  if e then
    return string.sub(name, e + 1)
  end
  return ""
end

function M.get_printable_number(val)
  if val < 0.1 then
    return "0"
  elseif math.tointeger(val) then
    return string.format("%d", math.floor(val))
  else
    return string.format("%.1f", val)
  end
end

local MEGABYTE = 1048576

function M.format_size(size)
  if size < MEGABYTE then
    return string.format("%.2fK", size / 1024)
  else
    return string.format("%.2fM", size / MEGABYTE)
  end
end

function M.round(num)
  return math.floor(num + 0.5)
end

function M.format_number(num, is_percentage)
  if type(num) ~= "number" then
    error("Invalid attribute value: expected a number")
    return 0
  end
  if is_percentage then
    local percentage = num / 100
    local formatted = string.format("%.2f", percentage)
    formatted = formatted:gsub("(%.?0+)$", "")
    return formatted .. "%"
  else
    return tostring(Util.round(num))
  end
end

local _atan = math.atan

function M.get_eulery(x, z)
  return -math.atan(z, x) * _rad2deg + 90
end

function M.get_clamp_number(number)
  return number < 10000000 and math.floor(number) or Util.format_str("{1}万", math.floor(number / 10000))
end

local screen_view_width = Global.uiconfig.ui_width / UnityScreen.width
local screen_view_height = Global.uiconfig.ui_height / UnityScreen.height

function M.get_screen_by_view(x, y)
  return x * screen_view_width, y * screen_view_height
end

function M.get_trans_view_pos(trans)
  local x, y, z = trans:GetPositionA()
  local camera = Global.ui_mgr.root_camera
  return CSHelper.GetScreenPosByWorldPos(x, y, z, camera)
end

function M.get_image_anchored_pos(trans, px, pz)
  local camera = Global.ui_mgr.root_camera
  return CSHelper.GetImageAnchoredPos(trans, px, pz, camera)
end

function M.get_screen_precent_by_view(x, y)
  return x / UnityScreen.width, y / UnityScreen.height
end

function M.apply_grey(path, parent, is_grey, is_fast)
  local graphic = M.get_component(path, parent, CSUnityGraphic)
  local mat
  if is_grey then
    local path = is_fast and "UI_Fast_Grey.mat" or "UI_Default_Grey.mat"
    mat = ResMgr:load_res(Path.get_res_path(path), CSUnityMaterial)
  else
    mat = nil
  end
  graphic.material = mat
end

function M.apply_grey_ex(gameObject, is_grey, ignore_children, use_default_mat)
  local graphic = gameObject:GetComponent(UnityGraphicType)
  local mat
  if is_grey then
    local mat_path = is_default and "UI_Default_Grey.mat" or "UI_Fast_Grey.mat"
    mat = ResMgr:load_res(Path.get_res_path(mat_path), CSUnityMaterial)
  end
  if graphic then
    graphic.material = mat
  end
  if not ignore_children then
    local children = gameObject:GetComponentsInChildren(UnityGraphicType, true)
    for i = 0, children.Length - 1 do
      children[i].material = mat
    end
  end
end

function M.disable_btn(btn_component, is_grey, is_fast)
  btn_component.enabled = false
  M.apply_grey(nil, btn_component.gameObject, is_grey, is_fast)
end

function M.enable_btn(btn_component)
  btn_component.enabled = true
  M.apply_grey(nil, btn_component.gameObject, false)
end

function M.get_rgb_by_hex(hex)
  local hex_num = hex
  if type(hex) == "string" then
    hex_num = tonumber(hex, 16)
  end
  local r = (hex_num >> 16 & 255) / 255
  local g = (hex_num >> 8 & 255) / 255
  local b = (hex_num & 255) / 255
  return r, g, b, hex_num
end

function M.get_unity_color_by_hex(hex, alpha)
  if not M.color_tbl then
    M.color_tbl = {}
    setmetatable(M.color_tbl, {__mode = "v"})
  end
  if M.color_tbl[hex] then
    return M.color_tbl[hex]
  else
    local r, g, b, hex_num = M.get_rgb_by_hex(hex)
    local color_data = UnityEngine.Color(r, g, b, alpha or 1)
    M.color_tbl[hex] = color_data
    M.color_tbl[hex_num] = color_data
    return color_data
  end
end

M.RED_COLOR_STR = "E22525"
M.WHITE_COLOR_STR = "FFFFFF"
M.CommonColor_RedWarm = M.get_unity_color_by_hex(tonumber(M.RED_COLOR_STR, 16))
M.CommonColor_White = M.get_unity_color_by_hex(tonumber(M.WHITE_COLOR_STR, 16))

function M.get_month_period_str(time_config)
  return Util.format_str("{1}月{2}日{3}:{4}-{5}月{6}日{7}:{8}", time_config.begin_day.month, time_config.begin_day.day, time_config.begin_day.hour, time_config.begin_day.min, time_config.end_day.month, time_config.end_day.day, time_config.end_day.hour, time_config.end_day.min)
end

function M.apply_callback(cb, ...)
  if cb then
    cb(...)
  end
end

function M.split_str(str, splitter)
  local rt = {}
  string.gsub(str, "[^" .. splitter .. "]+", function(w)
    table.insert(rt, w)
  end)
  return rt
end

function M.split_trim_str(str, splitter)
  local rt = {}
  string.gsub(str, "[^" .. splitter .. "]+", function(w)
    table.insert(rt, M.trim(w))
  end)
  return rt
end

function M.trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function M.is_animator_playing(animator)
  local state_info = animator:GetCurrentAnimatorStateInfo(0)
  return state_info.normalizedTime < 1
end

function M.SLog(msg)
  local static = Global.ui_mgr:get_ui("statics")
  if static then
    static:append_log_msg(msg)
  end
end

function M.clear_SLOG()
  local static = Global.ui_mgr:get_ui("statics")
  if static then
    static:clear_log_msg()
  end
end

function M.format_quality_color(text, quality)
  local color = ItemQualityCfg[quality].Color
  return string.format(COLOR_CODE_TEMPLATE, color, text)
end

function M.format_quality_txt_color(text, quality)
  local color = ItemQualityCfg[quality].TxtColor
  return string.format(COLOR_CODE_TEMPLATE, color, text)
end

function M.format_color(txt, color)
  return string.format(COLOR_CODE_TEMPLATE, color, txt)
end

function M.get_text_color(txt_obj, color)
  local color_attr = "color"
  if txt_obj then
    if txt_obj:CompareTag("深色背景") then
      color_attr = "deep_color"
    elseif txt_obj:CompareTag("暗色背景") then
      color_attr = "dark_color"
    end
  end
  local code = ColorCfg[color]
  if code then
    return code[color_attr]
  end
  return color
end

function M.format_ngui_color(txt, color)
  return string.format("[%s]%s[-]", color, txt)
end

function M.get_item_rich_name(id)
  local cfg = ItemCfg[id]
  return M.format_color(cfg.name, cfg.quality)
end

function M.get_dark_item_rich_name(id)
  local cfg = ItemCfg[id]
  return M.format_color(cfg.name, cfg.quality, nil, true)
end

function M.get_items_rich_name(items)
  local bag_mgr = Global.hero.bag_mgr
  local tbl = {}
  for _, item in pairs(items) do
    if item.count > 0 then
      local name = M.get_item_rich_name(item.id)
      table.insert(tbl, string.format("[%s]*%d", name, item.count))
    end
  end
  return table.concat(tbl, ", ")
end

function M.force_dispath_msg(msgId, params)
  local msg = MsgGame:mq_publish2(Const[msgId])
end

local meta = {}

function meta:start_statistic(...)
  if not self.active then
    return
  end
  self.last_mem = collectgarbage("count") * 1024
end

function meta:record_statistic(tag)
  if not self.active then
    return
  end
  local mem = collectgarbage("count") * 1024
  self.mems[tag] = (self.mems[tag] or 0) + (mem - self.last_mem)
  self.last_mem = mem
end

function meta:check_statistic(...)
  if not self.active then
    return
  end
  self.last_print_time = self.last_print_time or Global.real_time
  if Global.real_time - self.last_print_time > 10 then
    M.print_statistic_mem(self.mems)
    self.mems = {}
    self.last_print_time = nil
  end
end

function M.new_mem_tool(...)
  local t = {}
  t.active = true
  t.last_mem = 0
  t.mems = {}
  return setmetatable(t, {__index = meta})
end

function M.print_statistic_mem(mems)
  local total = 0
  for k, v in pairs(mems) do
    mems[k] = string.format("%dK", math.floor(v / 1024))
    total = total + v
  end
  mems.total = string.format("%dK", math.floor(total / 1024))
  Global.log.Info("statistic_memory", mems)
end

function M.collectgarbage()
  collectgarbage("collect")
  CSHelper.GCCollect()
  AssetCache:collectgarbage()
  UnityEngine.Resources.UnloadUnusedAssets()
end

function M.handler(obj, method)
  return function(...)
    return method(obj, ...)
  end
end

local TIME_UNIT = Config.TIME_UNIT
local MINUTE_SEC = 60
local HOUR_SEC = MINUTE_SEC * 60
local DAY_SEC = HOUR_SEC * 24

function M.sec2time(sec)
  local day = math.floor(sec / DAY_SEC)
  if day > 0 then
    return day, TIME_UNIT.DAY
  end
  local hour = math.floor(sec / HOUR_SEC)
  if hour > 0 then
    return hour, TIME_UNIT.HOUR
  end
  local mins = math.floor(sec / MINUTE_SEC)
  return mins, TIME_UNIT.MINUTE
end

local SCENE_RESOLUTION = 1

function M.set_scene_resolution(percent)
  percent = tonumber(percent) / 100
  if percent == SCENE_RESOLUTION then
    return
  end
  SCENE_RESOLUTION = percent
  local camera_obj = UnityFind(Config.CAMERA_NAME)
  if camera_obj then
    local resolution = camera_obj:GetComponent(BnH.CameraResolution)
    if 1 == percent then
      UnityDestroy(resolution)
      return
    end
    local reso = UnityScreen.currentResolution
    local width = reso.width * percent
    local height = reso.height * percent
    resolution = resolution or camera_obj:AddComponent(BnH.CameraResolution)
    Log.Info(Util.format_str("set_scene_resolution {1}*{2}", width, height))
    resolution:ResetResolution(width, height)
    resolution.enabled = true
  end
end

function M.del_scene_resolution(...)
  M.set_scene_resolution(100)
end

M.stat_fps_flag = false
M.stat_fpss = {}
M.start_stat_fps_time = 0

function M.start_stat_fps(...)
  M.stat_fps_flag = true
  M.stat_fpss = {}
  M.start_stat_fps_time = Date.now()
end

function M.record_fps(f)
  if M.stat_fps_flag then
    table.insert(M.stat_fpss, f)
  end
end

function M.output_stat_fps(...)
  if 0 == #M.stat_fpss then
    return
  end
  local total = 0
  for _, fps in ipairs(M.stat_fpss) do
    total = total + fps
  end
  return M.format_str("在{1}秒的时间内，平均帧率为:{2}", Date.now() - M.start_stat_fps_time, string.format("%.02f", total / #M.stat_fpss))
end

function M.stop_stat_fps(...)
  M.stat_fps_flag = false
end

function M.toggle_brightness(toggle)
  if M.is_brightness == nil then
    M.is_brightness = false
  end
  if M.is_brightness == toggle then
    return
  end
  if not M.is_brightness then
    Global.platform_utility:SetApplicationBrightnessTo(0.3)
  else
    Global.platform_utility:SetApplicationBrightnessTo(-1.0)
  end
  M.is_brightness = not M.is_brightness
end

function M.draw_line(x, y, z, x1, y1, z1, r, g, b)
  if UNITY_EDITOR then
    UnityEngine.Debug.DrawLineA(x, y, z, x1, y1, z1, r, g, b, 1, 0.5)
  end
end

function M.get_height(x, z)
  return CSHelper.GetHeight(x, z, Layer.LayerMask.Terrain)
end

function M.raycast(x, z, layer_mask, y, max_dis)
  y = y or 1000
  max_dis = max_dis or 2000
  return CSHelper.RayCast(x, y, z, max_dis, layer_mask)
end

function M.raycast_with_normal(x, y, z, dx, dy, dz, layer_mask, max_dis)
  layer_mask = layer_mask or block_mask
  max_dis = max_dis or 10
  return CSHelper.RayCastWithNormal(x, y, z, dx, dy, dz, max_dis, layer_mask)
end

function M.raycast_block(x, y, z, max_dis)
  y = y or 1000
  max_dis = max_dis or 2000
  return CSHelper.RayCast(x, y, z, max_dis, block_mask)
end

function M.raycast2_block(x, y, z, dir_x, dir_y, dir_z, max_dis)
  y = y or 1000
  max_dis = max_dis or 2000
  return CSHelper.RayCast2(x, y, z, dir_x, dir_y, dir_z, max_dis, block_mask)
end

function M.raycast2_block_vec3(src_pos, dir, max_dis)
  max_dis = max_dis or dir:Magnitude()
  local is_hit, hit_x, hit_y, hit_z = CSHelper.RayCast2(src_pos.x, src_pos.y, src_pos.z, dir.x, dir.y, dir.z, max_dis, block_mask)
  return is_hit, Vec3.New(hit_x, hit_y, hit_z)
end

function M.raycast_by_role(role, x, z, layer_mask, max_dis)
  if not role then
    Log.Error("角色不存在，无法获取基准坐标！", debug.traceback())
    return 0
  end
  local _, y, _ = role:get_pos()
  y = y + 2
  max_dis = max_dis or 10
  layer_mask = layer_mask or Layer.LayerMask.Terrain
  local ret, height, insID = CSHelper.RayCast(x, y, z, max_dis, layer_mask)
  if not ret then
    return ret, y - 2, insID
  end
  return ret, height, insID
end

function M.raycast_with_prefer_id(x, y, z, max_dis, layer_mask, prefer_cid)
  y = y or 1000
  max_dis = max_dis or 2000
  return CSHelper.RaycastNonAlloc(x, y, z, 0, -1, 0, max_dis, layer_mask, prefer_cid)
end

function M.is_true(value)
  return true == value or 1 == value
end

function M.frame2realtime(frame, tail_length)
  if tail_length > 0 then
    return (frame - 1) * Config.LOGIC_FRAME + tail_length
  else
    return frame * Config.LOGIC_FRAME
  end
end

local UnityPlayerPrefs = UnityEngine.PlayerPrefs

function M.get_auto_pick()
  return false
end

function M.toggle_auto_pick()
  local auto_pick = M.get_auto_pick()
  if auto_pick then
    UnityPlayerPrefs.SetInt("item_auto_pick", 0)
  else
    UnityPlayerPrefs.SetInt("item_auto_pick", 1)
  end
  MsgGame:mq_publish2(Const.MSG_CHANGE_AUTO_PICK)
end

function M.is_empty(value)
  return not value or value == M.EMPTY_STR
end

function M.is_more_than_zero(value)
  return nil ~= value and value > 0
end

function M.is_target_type(char, target, target_type)
  local char_camp = char:get_camp()
  local target_camp = target:get_camp()
  if 1 == target_type or 2 == target_type then
    return char_camp == target_camp
  elseif 4 == target_type then
    return char_camp ~= target_camp
  end
  return false
end

function M.is_client_only()
  return DebugSetting:is_client_only()
end

function M.is_story_only()
  return TowerMgr and TowerMgr:get_story_room() ~= nil
end

function M.is_show_all_arrow_fx()
  return DebugSetting:is_show_all_arrow_fx()
end

function M.is_gm_fight()
  return not DebugSetting:is_enter_chapter()
end

local TYPE_RD = typeof(UnityEngine.Renderer)

function M.set_all_mat(transform, func)
  local rds = transform:GetComponentsInChildren(TYPE_RD, true)
  for i = 0, rds.Length - 1 do
    local mats = rds[i].sharedMaterials
    local mat
    for j = 0, mats.Length - 1 do
      mat = mats[j]
      if mat and not mat:IsNull() then
        func(mat)
      end
    end
  end
end

function M.get_rect_transform_size(rect_tf)
  assert(rect_tf)
  if rect_tf.anchorMin == rect_tf.anchorMax then
    return rect_tf.sizeDelta
  else
    return rect_tf.rect.size
  end
end

function M.show_message_tip(tip, ...)
  local error_type
  tip, error_type = Util.get_tips_with_error_code(tip, ...)
  if not tip then
    return
  end
  if 1 == error_type then
    UIMgr:get_ui("uimessagetip"):ui_show(tip)
  else
    M.show_conform_tip(tip, nil, nil, nil, nil, true)
  end
end

function M.show_message_tip_with_path_data(tip, tip_img_path, tip_data)
  local error_type
  tip, error_type = Util.get_tips_with_error_code(tip)
  if not tip then
    return
  end
  if 1 == error_type then
    UIMgr:get_ui("uimessagetip"):ui_show(tip, tip_img_path, tip_data)
  else
    M.show_conform_tip(tip, nil, nil, nil, nil, true)
  end
end

function M.get_tips_with_error_code(tip, ...)
  local tips_cfg = Util.get_errcode_msg(tip)
  local tips_type = 1
  if tips_cfg then
    if not GAME_DEBUG and 1 == tips_cfg.ignore_tips then
      return
    end
    if 0 == tips_cfg.error_ui then
      return
    end
    tip = tips_cfg.tips
    tips_type = tips_cfg.error_ui
  end
  if (...) then
    tip = Util.format_str(tip, ...)
  end
  return tip, tips_type
end

function M.show_banner_tip(tip)
  UIMgr:try_hide_ui("uibanner_tip")
  UIMgr:get_ui("uibanner_tip"):ui_show(tip)
end

function M.show_item_tip(item_id)
  UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
end

function M.show_conform_tip(desc, cancel_btn_lab, conform_btn_lab, cancel_callback, conform_callback, one_btn)
  desc = Util.format_str(desc)
  if nil == cancel_btn_lab then
    cancel_btn_lab = Util.format_str("取消")
  end
  if nil == conform_btn_lab then
    conform_btn_lab = Util.format_str("确定")
  end
  UIMgr:get_ui("uinotice_tips"):ui_show(conform_callback, cancel_callback, desc, conform_btn_lab, cancel_btn_lab, nil, one_btn)
end

function M.show_relic_tip(relic_uuid)
  if relic_uuid and 0 ~= relic_uuid then
    UIMgr:get_ui("relic_item_tips"):ui_show(relic_uuid)
  else
    UIMgr:try_hide_ui("relic_item_tips")
  end
end

function M.show_puzzle_tip(puzzle_uuid, show_data)
  if puzzle_uuid and 0 ~= puzzle_uuid then
    UIMgr:get_ui("puzzle_item_tips"):ui_show(puzzle_uuid, show_data)
  else
    UIMgr:try_hide_ui("puzzle_item_tips")
  end
end

function M.is_windows_plat()
  return UNITY_EDITOR_WIN or UNITY_STANDALONE_WIN
end

local ITEM_Cfg = {
  item = {cfg_path = "item.item"},
  buddy = {
    cfg_path = "buddy.buddy"
  },
  equip = {
    cfg_path = "equip.equip"
  }
}

function M.load_quality_icon(item_id, quality_img)
  local cfg_name = ""
  for _, v in pairs(ShareRes.create("item.award_type")) do
    if item_id >= v.IdBegin and item_id <= v.IdEnd then
      cfg_name = v.TabName
      break
    end
  end
  local tb = ITEM_Cfg[cfg_name]
  local item_cfg = ShareRes.create(tb.cfg_path, item_id)
  local quality_cfg = ShareRes.create("item.item_quality", item_cfg.Quality)
  local path = string.format("UICommon/%s", quality_cfg.QualityIcon)
  local img = Util.get_image(nil, quality_img)
  ResMgr:load_set_icon(img, path)
end

local ITEM_QUALITY_PATH = "UICommon/pz_0%d"

function M.load_ui_item(item_obj, item_id, num, max_num)
  local item_cfg = ShareRes.get_item_cfg(item_id)
  local item_icon = Util.get_image("ItemIcon", item_obj)
  local path = string.format("Icon/Item/%s", item_cfg.Icon)
  ResMgr:load_set_icon(item_icon, path)
  local num_tip = "x" .. num
  if max_num then
    local now_num_txt
    if num < max_num then
      now_num_txt = Util.set_str_color("<color=#E22525>", num)
    else
      now_num_txt = num
    end
    num_tip = now_num_txt .. "/" .. max_num
  end
  local item_txt = Util.get_text("ItemNum", item_obj)
  if item_txt then
    item_txt.text = num_tip
  end
  local item_quality = Util.get_image("ItemQuality", item_obj)
  if item_quality then
    local icon_path = ShareRes.create("item.item_quality", item_cfg.Quality).QualityIcon
    local quality_path = string.format("UICommon/%s", icon_path)
    ResMgr:load_set_icon(item_quality, quality_path)
  end
end

function M.load_equip_item(equip_info, item_obj)
  local equip_id = equip_info.id
  local equip_cfg = ShareRes.create("equip.equip", equip_id)
  local path = string.format("Icon/Item/%s", equip_cfg.Icon)
  local item_icon = Util.get_image("ItemIcon", item_obj)
  ResMgr:load_set_icon(item_icon, path)
  local item_quality = Util.get_image("ItemQuality", item_obj)
  if item_quality then
    local icon_path = ShareRes.create("item.item_quality", equip_cfg.Quality).QualityIcon
    local quality_path = string.format("UICommon/%s", icon_path)
    ResMgr:load_set_icon(item_quality, quality_path)
  end
end

function M.load_ui_battle_item(item_obj, item_id, num)
  local item_cfg = ShareRes.get_battle_item_cfg(item_id)
  local item_icon = Util.get_image("ItemIcon", item_obj)
  local path = string.format("Icon/BattleItem/%s", item_cfg.Icon)
  ResMgr:load_set_icon(item_icon, path)
  local item_txt = Util.get_text("ItemNum", item_obj)
  if item_txt then
    item_txt.text = "x" .. num
  end
  local item_quality = Util.get_image("ItemQuality", item_obj)
  if item_quality then
    local quality_path = string.format(ITEM_QUALITY_PATH, _clamp(item_cfg.Quality - 2, 1, 3))
    ResMgr:load_set_icon(item_quality, quality_path)
  end
end

local BATTLE_ITEM_QUALITY_PATH = "UICommon2/Com/Common_qualitybox_new"

function M.load_ui_new_battle_item(item_obj, item_id, num)
  local battle_item_cfg = ShareRes.get_battle_item_cfg(item_id)
  local battle_equip_cfg = ShareRes.get_battle_equip_cfg(item_id)
  local item_cfg, path
  if battle_item_cfg then
    item_cfg = battle_item_cfg
    path = string.format("Icon/BattleItem/%s", item_cfg.Icon)
  elseif battle_equip_cfg then
    item_cfg = battle_equip_cfg
    path = string.format("Icon/BattleWeapon/%s", item_cfg.Icon)
  end
  local item_icon = Util.get_image("ItemIcon", item_obj)
  ResMgr:load_set_icon(item_icon, path)
  local item_txt = Util.get_text("ItemNum", item_obj)
  if item_txt then
    item_txt.text = "x" .. num
  end
  local item_quality = Util.get_image("ItemQuality", item_obj)
  if item_quality then
    local quailty_num = item_cfg.Quality
    local quality_path = BATTLE_ITEM_QUALITY_PATH
    local color_str = "62AAD3"
    if 4 == quailty_num then
      color_str = "CB70D9"
    elseif 5 == quailty_num then
      color_str = "F79934"
    end
    Util.set_color(item_quality, color_str)
    ResMgr:load_set_icon(item_quality, quality_path)
  end
  local item_name = Util.get_text("ItemName", item_obj)
  if item_name then
    item_name.text = item_cfg.Name
  end
end

function M.show_pop_text(text, is_senior_show, drop_data)
  local tip_lua = UIMgr:try_get_visible_ui("pop_text_tip")
  if not tip_lua then
    tip_lua = UIMgr:get_ui("pop_text_tip")
    tip_lua:ui_show()
  end
  if not is_senior_show then
    tip_lua:add_pop_task(text)
  else
    tip_lua:add_senior_pop_task(drop_data)
  end
end

function M.load_char_head_icon(head_icon, head_id)
  head_id = 0 ~= head_id and head_id or 700051
  local head_cfg = ShareRes.create("player.player_avatar", head_id)
  assert(head_cfg, "No HeadCfg id = " .. head_id)
  local player_icon_path_prefix = "Icon/Profile/%s"
  local head_icon_path = string.format(player_icon_path_prefix, head_cfg.Icon)
  ResMgr:load_set_icon(head_icon, head_icon_path)
end

function M.get_ui_by_sys(sys_id)
  local cfg = ShareRes.create("sysopen.sys_open", sys_id)
  if not cfg or cfg.UI_Name == "" then
    Log.Error("读取系统开放配置失败，请检查sys_id=", sys_id)
    return
  end
  return cfg.UI_Name
end

function M.load_attr_icon(img, name)
  local path = string.format("UIChar/new/%s", name)
  ResMgr:load_set_icon(img, path)
end

function M.load_char_icon(img, name, cb)
  local path = string.format("UICommon/%s", name)
  ResMgr:load_set_icon(img, path, cb)
end

function M.get_item_name(item_id)
  local item_cfg = ShareRes.get_item_cfg(item_id)
  if item_cfg then
    return item_cfg.Name
  end
  local name = ""
  local item_type_cfg = Util.get_item_type_cfg(item_id)
  if item_type_cfg.TabName == "buddy" then
    local buddy_cfg = ShareRes.get_buddy_cfg(item_id)
    if buddy_cfg then
      name = buddy_cfg.Name
    end
  elseif item_type_cfg.TabName == "equip" then
    local equip_cfg = ShareRes.create("equip.equip", item_id)
    if equip_cfg then
      name = equip_cfg.Name
    end
  end
  return name
end

function M.get_item_type_cfg(item_id)
  local award_type = ShareRes.create("item.award_type")
  for k, v in pairs(award_type) do
    if item_id >= v.IdBegin and item_id <= v.IdEnd then
      return v
    end
  end
end

local UnitySceneManager = UnityEngine.SceneManagement.SceneManager
local SCENE_OFFSET = Config.SCENE_HEIGHT_OFFSET

function M.reset_by_root(gameobj)
  local scene_name = UnitySceneManager.GetActiveScene().name
  local h = SCENE_OFFSET[scene_name] or 0
  gameobj.transform:ResetAttr()
  gameobj.transform:SetPositionA(0, h, 0)
end

function M.add_debug_msg(msg, msg_info)
  msg = os.date("%m-%d %X") .. "：  " .. msg
  Global.debug_msg_list:push({msg = msg, msg_info = msg_info})
end

function M.load_skill_icon(icon_name, image)
  local icon_path = string.format("Skill/%s", icon_name)
  ResMgr:load_set_icon(image, icon_path)
end

function M.load_talent_icon(icon_name, image)
  local icon_path = string.format("Skill/TianFu/%s", icon_name)
  ResMgr:load_set_icon(image, icon_path)
end

function M.get_android_cpuhardware()
  local cpu_name
  local ft = io.open("/proc/cpuinfo", "r")
  if ft then
    for line in ft:lines() do
      if string.find(line, "Hardware") then
        cpu_name = Util.split_str(line, ":")[2]
        break
      end
    end
    ft:close()
  end
  return cpu_name
end

function M.load_skill_upgrade_icon(icon_name, image)
  local icon_path = string.format("UISkillBook/%s", icon_name)
  ResMgr:load_set_icon(image, icon_path)
end

function M.show_error(...)
  local tbl = {
    ...
  }
  local msg = table.concat(tbl, " ")
  Log.Error(msg)
  if GAME_DEBUG then
    Global.lua_error.on_lua_error(msg, "客户端报错")
  end
end

function M.conver_config_time_str2(time_str)
  local _, _, y, m, d, hour, min, sec = string.find(time_str, "(%d+)%s*/%s*(%d+)%s*/%s*(%d+)%s*(%d+)%s*:%s*(%d+)%s*:%s*(%d+)")
  assert(y, time_str)
  assert(m)
  assert(d)
  assert(hour)
  assert(min)
  assert(sec)
  local timestamp = Date.to_timestamp({
    year = y,
    month = m,
    day = d,
    hour = hour,
    min = min,
    sec = sec
  })
  return timestamp
end

function M.is_fight_room(room_type)
  local cfg = ShareRes.create("tower.tower_room_type")
  if not cfg[room_type] then
    Log.Error("read tower_room_type failure, room_type=", room_type, debug.traceback())
    return false
  end
  return 1 == cfg[room_type].is_fight
end

function M.is_pos_in_screen(x, y, z)
  local rx, ry, rz = Global.camera:world_to_screen(x, y, z)
  local sw, sh = Global.camera:get_screen_wh()
  return rx > 0 and rx < sw and ry > 0 and ry < sh and rz > 0
end

function M.is_obj_in_screen(obj)
  return M.is_pos_in_screen(obj:get_pos())
end

function M.is_rect_in_screen(rect)
  local w = rect:GetSizeDeltaA()
  local x, y, z = rect:GetPositionA()
  local ui_camera = UIMgr:get_root_camera()
  local rx = ui_camera:WorldToScreenPointA(x + w / 2, y, z)
  if rx.x < 0 then
    return false
  end
  rx = ui_camera:WorldToScreenPointA(x - w / 2, y, z)
  return rx.x <= Global.screen_width
end

local HELP_GAMEOBJ_IN_SCREEN = {}

function M.is_gameobj_in_screen(gameobj)
  local x, y, z = gameobj.transform:GetPositionA()
  HELP_GAMEOBJ_IN_SCREEN.x = x
  HELP_GAMEOBJ_IN_SCREEN.y = y
  HELP_GAMEOBJ_IN_SCREEN.z = z
  return M.is_pos_in_screen(HELP_GAMEOBJ_IN_SCREEN)
end

function M.assert(condition, ...)
  if not condition then
    local tbl = {
      ...
    }
    local msg = _tconcat(tbl, " ")
    assert(nil, msg)
  end
end

function M.get_transform_path(tf)
  if nil == tf then
    return ""
  end
  local rlt = {}
  local cur = tf
  while cur and not cur:IsNull() do
    _insert(rlt, 1, cur.name)
    cur = cur.parent
    if #rlt > 10 then
      break
    end
  end
  return _tconcat(rlt, "/")
end

function M.get_random_weight(cfg)
  local max_weight = 0
  for _, weight_val in ipairs(cfg) do
    max_weight = max_weight + weight_val
  end
  if max_weight <= 0 then
    return
  end
  local random_val = math.random(1, max_weight)
  local cur_weigth = 0
  for index, weight_val in ipairs(cfg) do
    if weight_val > 0 and random_val <= weight_val + cur_weigth then
      return index
    end
    cur_weigth = cur_weigth + weight_val
  end
end

function M.bind_msg(owner, msg_type, callback, cbdata)
  owner._util_msg_handles = owner._util_msg_handles or {}
  local msg_handle = MsgGame:mq_bind(msg_type, callback, cbdata)
  owner._util_msg_handles[msg_handle] = msg_type
  return msg_handle
end

function M.unbind_msg(owner, msg_handle)
  MsgGame:mq_unbind(msg_handle)
  if owner._util_msg_handles then
    owner._util_msg_handles[msg_handle] = nil
  end
  return msg_handle
end

function M.unbind_all_msg(owner)
  if owner._util_msg_handles then
    for msg_handle, _ in pairs(owner._util_msg_handles) do
      MsgGame:mq_unbind(msg_handle)
    end
  end
  owner._util_msg_handles = nil
end

function M.split_str(str, splitter, is_tonumber)
  local rt = {}
  string.gsub(str, "[^" .. splitter .. "]+", function(w)
    if is_tonumber then
      table.insert(rt, tonumber(w))
    else
      table.insert(rt, w)
    end
  end)
  return rt
end

function M.set_str_color(config_color, str)
  return string.format("%s%s</color>", config_color, str)
end

function M.draw_one_point(pos, scale, name)
  local cube = UnityGameObject.CreatePrimitive(UnityEngine.PrimitiveType.Cube)
  cube:ResetAttr()
  cube.name = name
  cube.transform:SetPositionA(pos.x, pos.y, pos.z)
  cube.transform:SetLocalScaleA(scale)
  return cube
end

function M.get_effect_joint_pos(attach_point, owner)
  local is_camera_effect, attach_transform
  if attach_point then
    local list = Util.split_str(attach_point, "&")
    local attack_name = list[1]
    local attach_child_name = list[2]
    if "Camera" == attack_name then
      is_camera_effect = true
      if Util.is_empty(attach_child_name) then
        attach_transform = Global.camera:get_camera_effect_root()
      else
        attach_transform = Global.camera:get_child_transform(attach_child_name)
      end
    elseif "CameraVisibleEffect" == attack_name then
      is_camera_effect = true
      attach_transform = Global.camera:get_camera_visible_effect_root()
    else
      attach_transform = owner:get_setting_point(attack_name) or owner.transform
    end
  else
    attach_transform = owner.transform
  end
  return attach_transform, is_camera_effect
end

function M.change_component_alpha(component, alpha_val)
  local r, g, b, a
  r, g, b = component:GetGraphicColor()
  a = alpha_val / 255
  component:SetGraphicColor(r, g, b, a)
end

function M.change_component_alpha2(component, alpha_val)
  local r, g, b, a
  r, g, b = component:GetGraphicColor()
  a = alpha_val
  component:SetGraphicColor(r, g, b, a)
end

function M.set_joystick(etc_joystick_com)
  local easy_touch_obj = UnityFind("Easytouch")
  local touch_manager = easy_touch_obj:GetComponent(typeof(TouchManager))
  touch_manager:BindJoystickEvent(etc_joystick_com)
end

function M.get_format_num(num)
  if num < 10 then
    return "0" .. num
  end
  return num
end

function M.conversion_unit(nNum)
  if type(nNum) ~= "number" then
    return nNum
  end
  local unit = ""
  local n = 0
  if nNum > 1000 then
    unit = "k"
    n = 1
    nNum = nNum / 1000
  else
    return nNum
  end
  n = math.floor(n)
  local nDecimal = 10 ^ n
  local nTemp = math.floor(nNum * nDecimal)
  local nRet = nTemp / nDecimal
  return nRet .. unit
end

function M.set_default(t, defalu_t)
  assert(t)
  assert(defalu_t)
  for key, value in pairs(defalu_t) do
    if nil == t[key] then
      t[key] = value
    end
  end
end

function M.check_load_scene_name(name)
  return ("Main" == name or "main" == name) and name or name .. Config.SCENE_FINAL_SUFFIX
end

function is_debug_enviroment()
  return UNITY_EDITOR and GAME_DEBUG
end

function M.get_screen_area(rect)
  local rx, ry = UIMgr.root_camera:WorldToScreenPointA(rect:GetPositionA())
  local w, h = rect:GetRectWH()
  return {
    right_boundary = rx + w / 2,
    left_boundary = rx - w / 2,
    up_boundary = ry + h / 2,
    bottom_boundary = ry - h / 2
  }
end

function M.is_in_area(input_pos, area)
  return input_pos.x > area.left_boundary and input_pos.x < area.right_boundary and input_pos.y < area.up_boundary and input_pos.y > area.bottom_boundary
end

function M.is_interact(posa, posb, posc, posd)
  local ab_x, ab_y, ab_z = posb.x - posa.x, posb.y - posa.y, posb.z - posa.z
  local ca_x, ca_y, ca_z = posa.x - posc.x, posa.y - posc.y, posa.z - posc.z
  local cd_x, cd_y, cd_z = posd.x - posc.x, posd.y - posc.y, posd.z - posc.z
  local epsilon = 1.0E-5
  local cross_abcd = Util.VEC3_TEMP
  Vec3.CrossB(ab_x, ab_y, ab_z, cd_x, cd_y, cd_z, cross_abcd)
  if epsilon > cross_abcd:SqrMagnitude() then
    return false
  end
  if math.min(posa.x, posb.x) > math.max(posc.x, posd.x) or math.max(posa.x, posb.x) < math.min(posc.x, posd.x) or math.min(posa.z, posb.z) > math.max(posc.z, posd.z) or math.max(posa.z, posb.z) < math.min(posc.z, posd.z) then
    return false
  end
  local ad_x, ad_y, ad_z = posd.x - posa.x, posd.y - posa.y, posd.z - posa.z
  local cb_x, cb_y, cb_z = posb.x - posc.x, posb.y - posc.y, posb.z - posc.z
  local cross_caab = Util.VEC3_TEMP
  Vec3.CrossB(-ca_x, -ca_y, -ca_z, ab_x, ab_y, ab_z, cross_caab)
  local cross_abad = Util.VEC3_TEMP_1
  Vec3.CrossB(ab_x, ab_y, ab_z, ad_x, ad_y, ad_z, cross_abad)
  if Vec3.Dot(cross_caab, cross_abad) > 0 then
    local cross_caad = Util.VEC3_TEMP
    Vec3.CrossB(ca_x, ca_y, ca_z, ad_x, ad_y, ad_z, cross_caab)
    local cross_cdcb = Util.VEC3_TEMP_1
    Vec3.CrossB(cd_x, cd_y, cd_z, cb_x, cb_y, cb_z, cross_abad)
    if Vec3.Dot(cross_caad, cross_cdcb) > 0 then
      local v1 = Util.VEC3_TEMP
      Vec3.CrossB(ca_x, ca_y, ca_z, cd_x, cd_y, cd_z, v1)
      local v2 = Util.VEC3_TEMP_1
      Vec3.CrossB(cd_x, cd_y, cd_z, ab_x, ab_y, ab_z, v2)
      local ratio = Vec3.Dot(v1, v2) / v2:SqrMagnitude()
      ab_x, ab_y, ab_z = ab_x * ratio, ab_y * ratio, ab_z * ratio
      local interact_pos = Util.VEC3_TEMP.New(posa.x, posa.y, posa.z)
      interact_pos.x, interact_pos.y, interact_pos.z = interact_pos.x + ab_x, interact_pos.y + ab_y, interact_pos.z + ab_z
      return true, interact_pos
    end
  end
end

function M.has_special_tag(obj_self, obj_tar, hit_tag)
  local sp_tag = obj_tar:special_tag()
  if not hit_tag or not sp_tag then
    return false
  end
  return 0 ~= hit_tag & sp_tag
end

function M.get_canvas_group(path, parent)
  return M.get_component(path, parent, UnityEngine.CanvasGroup)
end

function M.set_color(graphic, hex_color_str, alpha)
  if not graphic then
    return
  end
  local r, g, b, a = graphic:GetGraphicColor()
  if not M.is_empty(hex_color_str) then
    r, g, b = M.get_rgb_by_hex(hex_color_str)
  end
  a = alpha or a
  graphic:SetGraphicColor(r, g, b, a)
end

function M.active_child_but(root_trans, index, is_need_hide_other)
  if not root_trans then
    return
  end
  local ret_child_trans
  for i = 0, root_trans.childCount - 1 do
    local child = root_trans:GetChild(i)
    child.gameObject:SetActive(i == index)
    if i == index then
      ret_child_trans = child
    elseif is_need_hide_other then
      child.gameObject:SetActive(false)
    end
  end
  return ret_child_trans
end

function M.get_point_list(start_pos, end_pos, segment_num)
  local dist = Vec3.Distance(start_pos, end_pos)
  local off_set_x = math.random(-5, 5) / 10
  local off_set_y = math.random(1, 10) / 10
  local x1, y1, z1 = Math.get_pos_by_line(start_pos, end_pos, dist * 0.2, dist)
  local x2, y2, z2 = Math.get_pos_by_line(start_pos, end_pos, dist * 0.4, dist)
  local control_pos1 = Vec3.New(x1 + off_set_x * dist, y1 + off_set_y * dist, z1)
  local control_pos2 = Vec3.New(x2 + off_set_x * dist, y2 + off_set_y * dist, z2)
  return Math.get_cubic_bezier_point_list(start_pos, control_pos1, control_pos2, end_pos, segment_num)
end

function M.get_cubic_bezier_control_pos(start_pos, end_pos)
  local dist = Vec3.Distance(start_pos, end_pos)
  local off_set_x = math.random(-5, 5) / 10
  local off_set_y = math.random(1, 10) / 10
  local x1, y1, z1 = Math.get_pos_by_line(start_pos, end_pos, dist * 0.2, dist)
  local x2, y2, z2 = Math.get_pos_by_line(start_pos, end_pos, dist * 0.4, dist)
  return Vec3.New(x1 + off_set_x * dist, y1 + off_set_y * dist, z1), Vec3.New(x2 + off_set_x * dist, y2 + off_set_y * dist, z2)
end

function M.set_ui_follow_npc(rect_tf, npc, off_set_y, attach_point_name)
  if not (rect_tf and Global.camera and Global.ui_dynamic_canvas) or not npc then
    return
  end
  local attach_point = npc:get_setting_point(attach_point_name or Config.UI_POINT_NAME)
  if not attach_point then
    attach_point = npc.transform
    off_set_y = off_set_y + npc.capsule.height
  end
  local camera = Global.camera:get_camera()
  local size_delta_x = Global.ui_dynamic_canvas:get_rect_size_delta_x()
  local size_delta_y = Global.ui_dynamic_canvas:get_rect_size_delta_y()
  local check_z = Global.camera:get_camera_mode() == Config.CAMERA_VIEW_TYPE.SHOULDER
  CSHelper.SetUIToBindTransPos(camera, attach_point, rect_tf, off_set_y, size_delta_x, size_delta_y, check_z)
end

function M.set_ui_follow_pos(rect_tf, x, y, z)
  if not (rect_tf and Global.camera) or not Global.ui_dynamic_canvas then
    return
  end
  local camera = Global.camera:get_camera()
  local size_delta_x = Global.ui_dynamic_canvas:get_rect_size_delta_x()
  local size_delta_y = Global.ui_dynamic_canvas:get_rect_size_delta_y()
  CSHelper.SetUIToBindTargetPos(camera, rect_tf, x, y, z, size_delta_x, size_delta_y)
end

function M.convert_excessively_long_strings(str, len, connect_str)
  return Util.get_sub_string_utf8(str, len) .. connect_str
end

function M.is_nil(obj)
  local success = nil == obj or obj:IsNull()
  return success
end

function M.update_energy_point_progress(ui, point_list, count, total_count, differen)
  if not total_count then
    return
  end
  for index, point in ipairs(point_list) do
    if total_count < index then
      ui:update_ui_visible(point.root, false)
      point.is_comp = false
    elseif index <= count then
      point.fill_img.fillAmount = 1
      ui:update_ui_visible(point.max_img, true)
      ui:update_ui_visible(point.root, true)
      if point.is_comp == false then
        ui:play_recover_particle(index)
      end
      point.is_comp = true
      if point.fill_bg_img then
        ui:update_ui_visible(point.fill_bg_img, true)
      end
    else
      if index == count + 1 then
        point.fill_img.fillAmount = differen / Config.EACH_POINT_EXPEND_VALUE
        if point.fill_bg_img then
          ui:update_ui_visible(point.fill_bg_img, true)
        end
      else
        point.fill_img.fillAmount = 0
        if point.fill_bg_img then
          ui:update_ui_visible(point.fill_bg_img, false)
        end
      end
      ui:update_ui_visible(point.root, true)
      ui:update_ui_visible(point.max_img, false)
      point.is_comp = false
    end
  end
end

function M.is_destroy(obj)
  return nil == obj or obj:is_destroy()
end

function M.need_check_server_redpoint(type, subtype)
  return Config.CommonDefine.SERVER_SAVE_TIP_ITEM_TYPE[type] and Config.CommonDefine.SERVER_SAVE_TIP_ITEM_TYPE[type][subtype]
end

function M.get_character_layer_mask()
  return Layer.LayerMask.Character
end

function M.get_main_role_or_bird_layer_mask()
  return Layer.LayerMask.Character | Layer.LayerMask.NPCCollider
end

function M.cal_after_correct_dir_x_y(x, z, target_dir)
  QuatTemp:SetEuler(0, 0, target_dir)
  VEC3_TEMP.x = x
  VEC3_TEMP.y = z
  local vec = QuatTemp * VEC3_TEMP
  return vec.x, vec.y
end

function M.get_equal_len_vector(cur_x, cur_z, tar_x, tar_z)
  VEC3_TEMP.x = tar_x
  VEC3_TEMP.y = tar_z
  VEC3_TEMP.z = 0
  local nor = VEC3_TEMP:Normalize()
  VEC3_TEMP.x = cur_x
  VEC3_TEMP.y = cur_z
  local magni = VEC3_TEMP:Magnitude()
  local dot = Vec3.Dot(VEC3_TEMP, nor)
  if M.almost_zero(math.abs(dot)) then
    return nor.x * magni, nor.y * magni
  end
  local pos = (nor * dot):SetNormalize()
  return pos.x * magni, pos.y * magni
end

function M.get_point_normal_award(point_id, is_hard, check_first_pass, is_type_five, data_list)
  local award_list = ShareRes.get_point_award(point_id)
  if award_list then
    for key, data in pairs(award_list) do
      data.star_count = 0
      table.insert(data_list, data)
    end
  end
end

function M.insert_abhurt_info_to_journal(attacker, defender, hurt, magic, index, is_sustain)
  if JournalMgr then
    local magic_info = magic.magic_info
    local effect_cfg = magic.effect_cfg
    local atk_attr_mgr = attacker.attr_mgr
    local def_attr_mgr = defender.attr_mgr
    local atk_attrs = attacker.attr_mgr.attrs
    local def_attrs = defender.attr_mgr.attrs
    local pre_caculate_data = {
      magic_level = magic_info.magic_level,
      skill_type = is_sustain and Config.FightDefine.DMG_TYPE.AB_SUS_DMG or Config.FightDefine.DMG_TYPE.AB_TRI_DMG,
      element_type = magic.element_id,
      base_hurt_src_info = magic.level_param,
      effect_type = Config.DAMAGE_EFFECT_TYPE.ABNORMAL,
      special_dmg_from = magic.element_id == Config.FightDefine.ELEMENT_TYPE.THUNDER and "雷"
    }
    local hurts = {base_hurt = 0, element_hurt = 0}
    if magic.element_id == Config.FightDefine.ELEMENT_TYPE.BASE then
      hurts.base_hurt = hurt
    else
      hurts.element_hurt = hurt
    end
    JournalMgr:insert_hurt_journal(atk_attr_mgr, atk_attrs, def_attr_mgr, def_attrs, pre_caculate_data, hurts, nil, magic_info)
  end
end

function M.is_net_work_error(unity_web_request)
  if unity_web_request.result == UnityEngine.Networking.UnityWebRequest.Result.ProtocolError or unity_web_request.result == UnityEngine.Networking.UnityWebRequest.Result.ConnectionError then
    return true
  else
    return false
  end
end

function M.get_buddy_teach_fight_cost(buddy_id, point_id, floor_index)
  local floor_cfg = ShareRes.get_buddy_teach_floor_cfg_by_point_id(point_id, floor_index)
  if floor_cfg then
    local has_pass = ActivityMgr:invoke(Config.CommonDefine.ACTY_TYPE.BUDDY_TEACH, "get_floor_has_passed", buddy_id, floor_index)
    return has_pass and floor_cfg.FightCost[2] or floor_cfg.FightCost[1]
  else
    Util.show_message_tip(2043)
  end
end

function M.get_buddy_teach_award(buddy_id, point_id, floor_index)
  local floor_cfg = ShareRes.get_buddy_teach_floor_cfg_by_point_id(point_id, floor_index)
  if floor_cfg then
    local has_pass = ActivityMgr:invoke(Config.CommonDefine.ACTY_TYPE.BUDDY_TEACH, "get_floor_has_passed", buddy_id or point_id, floor_index)
    return has_pass and floor_cfg.AwardId[2] or floor_cfg.AwardId[1]
  else
    Util.show_message_tip(2043)
  end
end

function M.custom_enable_keyword(name, enable)
  local keyword_id = UnityShader.PropertyToID(name)
  local keyword_enable = 0
  if enable then
    keyword_enable = 1
  end
  if keyword_id then
    UnityShader.SetGlobalFloat(keyword_id, keyword_enable)
  end
end

function M.move_to_target_point_pos(rect, root_rect, content, is_x, sequence, duration, not_check_break)
  local scroll_tf = root_rect.transform
  local rx, ry, rz = rect.transform:GetPositionA()
  local x, y = scroll_tf:GetInverseTransformPointA(rx, ry, rz)
  local lx, ly, lz = content.transform:GetLocalPositionA3()
  if is_x then
    lx = lx - x
  else
    ly = ly - y
  end
  local cw, ch = content:GetRectWH()
  local scrollrect = M.get_scrollrect(nil, root_rect)
  local viewport_rect = scrollrect.viewport:GetComponent("RectTransform")
  local vw, vh = viewport_rect:GetRectWH()
  local is_break
  if not not_check_break then
    if is_x then
      local max_x = cw - vw
      if lx < -max_x then
        lx = -max_x
        is_break = true
      elseif lx > 0 then
        lx = 0
        is_break = true
      end
    else
      local max_y = ch - vh
      if ly < -max_y then
        ly = -max_y
        is_break = true
      elseif ly > 0 then
        ly = 0
        is_break = true
      end
    end
  end
  if sequence then
    if not is_break then
      content.transform:DOLocalMoveA(lx, ly, lz, duration)
    end
  else
    content.transform:SetLocalPositionA(lx, ly, lz)
  end
end

function M.try_action(npc, action_name, custom_transition_time, cb, cb_data, is_loop)
  if not npc or not npc.act_ctrl then
    return
  end
  if npc:get_npc_id() == TaskMgr:get_bird_npc_id() then
    npc.act_ctrl:try_action(action_name, 0, function()
      TaskMgr:play_mascot_idle_anim()
    end, nil, false)
    return
  end
  if nil == is_loop then
    is_loop = true
  end
  npc.act_ctrl:try_action(action_name, 0, cb, cb_data, is_loop, nil, custom_transition_time)
end

function M.check_item_cost_enough(cost_item, cost_count)
  if not Util.is_more_than_zero(cost_item) or not Util.is_more_than_zero(cost_count) then
    return true
  end
  local cur_count = BagMgr:get_item_num(cost_item)
  cur_count = BuffMgr:check_borrow_money_map(cost_item) + cur_count
  local enough = nil ~= cur_count and cost_count <= cur_count
  return enough
end

function M.get_award_show_count(lower_limit, upper_limit)
  if not upper_limit then
    return lower_limit
  end
  return lower_limit == upper_limit and lower_limit or lower_limit .. "~" .. upper_limit
end

function M.debug_output(...)
  if GAME_DEBUG then
    local str = Global.frame_id .. ": " .. table.concat({
      ...
    }, ",")
    Log.Error(str .. "\n" .. debug.traceback())
  end
end

function M.get_obj_parent_name(obj)
  local obj_parent = obj.gameObject.transform.parent
  local obj_parent_name
  if obj_parent then
    obj_parent_name = obj_parent.gameObject.name
  end
  return obj_parent_name
end

function M.blend_transform_state(state_from, state_to, t, out_state)
  Vec3.LerpA(state_from.position, state_to.position, t, out_state.position)
  Quat.SlerpA(state_from.rotation, state_to.rotation, t, out_state.rotation)
end

function M.blend_transform_state_position(state_from, state_to, t, out_state)
  Vec3.LerpA(state_from.position, state_to.position, t, out_state.position)
end

function M.blend_transform_state_rotation(state_from, state_to, t, out_state)
  Quat.SlerpA(state_from.rotation, state_to.rotation, t, out_state.rotation)
end

function M.get_target_relative_to_attacker_deg(magic_target, attacker, magic_info)
  local owner_missile = magic_info and magic_info.owner_missile
  local deg_source
  deg_source = attacker
  local source_x, source_z = deg_source:get_pos2()
  local tar_x, tar_z = magic_target:get_pos2()
  return Math.get_lookat_dir(source_x, source_z, tar_x, tar_z)
end

function M.get_fight_ui_effect(effect_key, effect_name, auto_release)
  local fight = UIMgr:try_get_loaded_ui("fight")
  if fight then
    effect_key = effect_key or effect_name
    return fight:get_ui_effect(effect_name, effect_key, false, auto_release)
  end
end

function M.release_fight_ui_effect(effect_key)
  local fight = UIMgr:try_get_loaded_ui("fight")
  if fight then
    fight:release_ui_effect(effect_key)
  end
end

function M.play_auto_release_fight_ui_effect(effect_name, effect_key, root_tf)
  local ui_effect = M.get_fight_ui_effect(effect_key, effect_name, true)
  if ui_effect then
    ui_effect.gameObject:SetActive(true)
    if root_tf then
      ui_effect.transform:SetParent(root_tf)
    end
    ui_effect:ResetAttr()
    local effect = M.get_effect_status(nil, ui_effect)
    effect.component:RestartAll(nil, true)
    return ui_effect
  end
end

function M.check_show_hp_bar_type(bar_type)
  local show_ui_hp = 1 == bar_type % 2
  local show_elite_bar = 1 == (bar_type >> 1) % 2
  local show_big_bar = 1 == (bar_type >> 2) % 2
  return show_ui_hp, show_elite_bar, show_big_bar
end

function M.get_update_event_id_by_item_id(item_id)
  local ShopCfg = require("uimodule.shop.shop_config")
  if item_id == Config.DIAMOND_ITEMID then
    return Const.MSG_ON_DIAMOND_UPDATE
  elseif item_id == Config.COIN_ITEMID then
    return Const.MSG_ON_COIN_UPDATE
  elseif item_id == Config.PLAYER_SP_ITEMID then
    return Const.MSG_ON_PLAYER_SP_UPDATE
  elseif item_id == Config.GILTGOLD_ITEMID then
    return Const.MSG_ON_GOLD_UPDATE
  elseif item_id == ShopCfg.SKIN_COUPON_ID then
    return Const.MSG_ROLE_RES_CHANGE
  elseif item_id == Config.CURSE_GOLD then
    return Const.MSG_ON_FIGHT_DIAMOND_UPDATE
  else
    local award_type = ShareRes.create("item.award_type")
    for _, v in pairs(award_type) do
      if item_id >= v.IdBegin and item_id <= v.IdEnd then
        if v.BagType == Config.BAG_TYPE.RESOURCE then
          return Const.MSG_ROLE_RES_CHANGE
        elseif v.BagType == Config.BAG_TYPE.ITEM then
          return Const.MSG_ON_ITEM_UPDATE
        end
      end
    end
  end
end

function M.refresh_curr_language()
  local curr_language_index = CS.GameToLua.CheckUpdate.GetSelectLanguage()
  Global.curr_language = Config.CommonDefine.INDEX_LANGUAGE[curr_language_index]
  local curr_text_language_index = CS.GameToLua.CheckUpdate.GetSelectTextLanguage()
  Global.curr_text_language = Config.CommonDefine.INDEX_LANGUAGE[curr_text_language_index]
  local curr_story_cv_language_index = CS.GameToLua.CheckUpdate.GetSelectStoryVoiceLanguage()
  Global.curr_story_cv_language = Config.CommonDefine.INDEX_LANGUAGE[curr_story_cv_language_index]
  Global.is_need_check_default = CS.GameToLua.CheckUpdate.GetIsNeedCheckDefaultFolder()
end

function M.change_to_other_language(language, type)
  if UIMgr then
    UIMgr:open_default_ui(true)
  end
  if PlayerMgr then
    PlayerMgr:logout_game_server(function()
      CS.GameToLua.CheckUpdate.SetIsForceChangeLanguage(true, language, type)
    end)
  else
    Global.gamemode:gmode_set_mode(Const.MODE_CHECK_UPDATE)
    CS.GameToLua.CheckUpdate.SetIsForceChangeLanguage(true, language, type)
  end
end

local name_replace_key = "BBNAME"

function M.check_replace_player_name(content)
  if _find(content, name_replace_key) then
    local replace_content = M._get_player_name()
    content = _gsub(content, name_replace_key, replace_content)
  end
  return content
end

function M._get_player_name()
  if not PlayerMgr then
    return ""
  end
  return PlayerMgr:get_player_name() or ""
end

function M.get_patch_major_version()
  return VersionInfo[1]
end

function M.get_patch_res_version()
  return VersionInfo[2]
end

function M.get_patch_uuid()
  return VersionInfo.uuid
end

function M.get_patch_show_version()
  return VersionInfo.show_version
end

function M.get_build_number()
  return BuildVersionInfo.BuildNumber
end

function M.get_build_major_version()
  return BuildVersionInfo.MajorVersion
end

function M.get_build_res_version()
  return BuildVersionInfo.ResVersion
end

function M.get_build_show_version()
  return BuildVersionInfo.ShowVersion
end

local function get_platform_str()
  if UNITY_EDITOR then
    return "Editor"
  elseif UNITY_ANDROID then
    return "Android"
  elseif UNITY_IOS then
    return "iOS"
  else
    return ""
  end
end

local function get_area_tag_str()
  if SDKType == Config.SDK_TYPE.HIVE_SDK then
    return "GL"
  else
    return "CN"
  end
end

function M.get_bundle_version()
  return string.format("%s.%s.%s", M.get_build_show_version(), M.get_build_major_version(), M.get_build_res_version())
end

function M.get_login_version()
  return string.format("%s.%s", M.get_build_show_version(), M.get_build_major_version())
end

function M.get_version_str()
  local platform_str = get_platform_str()
  local area_tag_str = get_area_tag_str()
  return string.format("%s.%s.%s %s%s", M.get_build_show_version(), M.get_build_major_version(), M.get_patch_res_version(), area_tag_str, platform_str)
end

function M.is_in_loading()
  local tower = TowerMgr and TowerMgr:get_tower()
  return Global.gamemode:gmode_is_loadscene() or tower and tower:is_in_room_preload()
end

function M.clear_all_res()
  if Global.listener_mgr then
    Global.listener_mgr:release_all_listeners_on_reload()
  end
  if Global.ui_mgr then
    Global.ui_mgr:clear_ui_stack()
    Global.ui_mgr:on_destroy()
  end
  if Global.res_pool_mgr then
    Global.res_pool_mgr:on_destroy()
  end
  if Global.sound_mgr then
    Global.sound_mgr:on_destroy()
  end
  if Global.camera then
    Global.camera:on_destroy()
  end
  if Global.render_mgr then
    Global.render_mgr:on_destroy()
  end
  if SceneMgr then
    SceneMgr:destroy_camera()
  end
  if Global.config then
    local map = require("manager.scene.scene_map")
    map:destroy_finder()
  end
  if ResMgr then
    ResMgr:on_destroy()
    if AssetCache then
      AssetCache:del_all_caches()
    end
  end
end

function M.has_special_char(str)
  return not Regex.IsMatch(str, legal_special_char)
end

local debug_pos_go

function M.debug_pos(x, y, z, obj_type, name, print_track, size, clear_last_create)
  if GAME_RELEASE then
    return
  end
  debug_pos_go = debug_pos_go or {}
  size = size or 1
  obj_type = obj_type or 1
  local primitive_type
  if 1 == obj_type then
    primitive_type = UnityEngine.PrimitiveType.Cube
  elseif 2 == obj_type then
    primitive_type = UnityEngine.PrimitiveType.Sphere
  elseif 3 == obj_type then
    primitive_type = UnityEngine.PrimitiveType.Cylinder
  elseif 4 == obj_type then
    primitive_type = UnityEngine.PrimitiveType.Capsule
  end
  local obj = UnityGameObject.CreatePrimitive(primitive_type)
  obj.transform:SetPositionA(x, y, z)
  obj.transform:SetLocalScaleA(size)
  if name then
    obj.name = name .. Global.frame_id
  end
  Log.Error("debug_pos", name, debug.traceback())
  if clear_last_create then
    for key, go in pairs(debug_pos_go) do
      UnityDestroy(go)
      debug_pos_go[key] = nil
    end
  end
  debug_pos_go[#debug_pos_go + 1] = obj
  return obj
end

function M.debug_draw_ray(ox, oy, oz, dx, dy, dz, dist, color, duration)
  if GAME_RELEASE then
    return
  end
  local start = Vec3.New(ox, oy, oz)
  local dir = Vec3.New(dx, dy, dz) * dist
  color = color or Util.ColorRed
  duration = duration or 999
  UnityEngine.Debug.DrawRay(start, dir, color, duration)
end

function M.split_ipv6_address_str(str)
  local trimmed_str = str:match("^%s*(.-)%s*$")
  local bracket_start, bracket_end = trimmed_str:find("%[")
  local ip, port = trimmed_str:match("^%[([%a%d:]+)%]%s*:(%d+)$")
  if ip and port then
    return "[" .. ip .. "]", tonumber(port)
  else
    return nil, "Invalid address format"
  end
end

function M.set_cri_video_track(cri_video, video_name, ignore_subtitle)
  local cfg
  if video_name then
    local split = Util.split_str(video_name, ".")
    local name = split[1]
    cfg = ShareRes.get_usm_video_cfg(name)
  end
  local audio_track_index = 0
  local subtitle_track_index = 0
  if cfg and cfg.IsContainsVoice and 1 == cfg.IsContainsVoice then
    audio_track_index = Config.CommonDefine.LANGUAGE_AUDIO_TRACK_INDEX[Global.curr_story_cv_language]
    subtitle_track_index = Config.CommonDefine.LANGUAGE_INDEX[Global.curr_text_language] - 1
  end
  cri_video.player:SetAudioTrack(audio_track_index)
  if not ignore_subtitle then
    cri_video.player:SetSubtitleChannel(subtitle_track_index)
    M.remove_cri_subtitle_event(cri_video)
    cri_video:AddCriVideoSubtitleEvent(function(str)
      local msg = MsgGame:mq_publish2(Const.MSG_ON_CRI_VIDEO_SUBTITLE_UPDATE)
      msg.mm_x = str
    end)
  end
end

function M.remove_cri_subtitle_event(cri_video)
  cri_video:RemoveCriVideoSubtitleEvent()
end

function M.refresh_language_text(ui_object)
  if not ui_object then
    return
  end
  local ui_container = ui_object.gameObject:GetComponent(typeof(CS.UITextContainer))
  if Util.is_nil(ui_container) then
    return
  end
  local list = ui_container.TextList
  for i = 0, list.Count - 1 do
    local text = list[i]
    if Util.is_nil(text) then
    else
      local ui_language = text:GetComponent(typeof(CS.UILanguage))
      if not Util.is_nil(ui_language) then
        local language_id = ui_language.LanguageId
        if language_id and "" ~= language_id then
          text.text = LanguageMgr:get_text(ui_language.LanguageId)
        end
      end
    end
  end
  local dropdown_list = ui_container.DropdownList
  for i = 0, dropdown_list.Count - 1 do
    local dropdown = dropdown_list[i]
    if Util.is_nil(dropdown) then
    else
      local ui_dropdown = dropdown:GetComponent(typeof(CS.UIDropdown))
      if not Util.is_nil(ui_dropdown) then
        local options = ui_dropdown.Options
        for j = 0, options.Count - 1 do
          local option = options[j]
          dropdown.options[j].text = LanguageMgr:get_text(option)
        end
      end
    end
  end
end

function M.is_table(param)
  return type(param) == TABLE_STR
end

function M.is_number(param)
  return type(param) == NUMBER_STR
end

function M.get_point_nearest_vector_pos_and_len(px, py, pz, ax, ay, az, bx, by, bz)
  local pax, pay, paz = px - ax, py - ay, pz - az
  local abx, aby, abz = bx - ax, by - ay, bz - az
  local papx, papy, papz = Vec3.ProjectA(abx, aby, abz, pax, pay, paz)
  return ax + papx, ay + papy, az + papz
end

function M.get_index()
  INDEX = INDEX + 1
  return INDEX
end

function M.show_recharge_box(cost_id, lack_cnt, exchange_cost_id, exchange_cost_cnt, next_exchange_cost_id, next_exchange_cost_cnt, callback, asset_bar_is_list)
  if cost_id == Config.FATE_TICKET_ITEMID then
    local exchange_ui = UIMgr:get_ui("fate_exchange")
    exchange_ui:ui_show(cost_id, lack_cnt, exchange_cost_id, exchange_cost_cnt, next_exchange_cost_id, next_exchange_cost_cnt, callback)
    if asset_bar_is_list then
      exchange_ui:show_asset_bar_by_id_list(asset_bar_is_list)
    end
  else
    local recharge_ui = UIMgr:get_ui("uidrawcard_recharge")
    recharge_ui:ui_show(cost_id, lack_cnt, exchange_cost_id, exchange_cost_cnt, next_exchange_cost_id, next_exchange_cost_cnt, callback)
    if asset_bar_is_list then
      recharge_ui:show_asset_bar_by_id_list(asset_bar_is_list)
    end
  end
end

function M.show_recharge_box_by_item_id(item_id, lack_cnt, next_exchange_cost_id, next_exchange_cost_cnt, callback)
  lack_cnt = lack_cnt or 1
  local exchange_config = CharacterMgr:get_exchange_config_by_target_id(Config.EXCHANGE_TYPE.DEFAULT, item_id)
  local exchange_cost_id = exchange_config.Material[1]
  local exchange_cost_cnt = exchange_config.Num[1] * lack_cnt
  local item_num = BagMgr:get_item_num(item_id)
  callback = callback or function()
    local item_config = ShareRes.get_item_cfg(item_id)
    if item_num >= item_config.MaxCount then
      M.show_message_tip(2103)
      return
    end
    CharacterMgr:request_exchange_item(exchange_config.Id, lack_cnt)
  end
  M.show_recharge_box(item_id, lack_cnt, exchange_cost_id, exchange_cost_cnt, next_exchange_cost_id, next_exchange_cost_cnt, callback)
end

function M.get_res_is_integrity()
  if Game_AssetBundle and DownloadMgr and not DownloadMgr:check_res_is_integrity() then
    local Setting_Cfg = require("uimodule.battle_setting.battle_setting_cfg")
    local msg = "资源不完整，是否前往下载所有资源"
    Util.show_notify_popup_message(function()
      UIMgr:get_ui("battle_setting"):ui_show(Setting_Cfg.PageTag.Download)
    end, msg, "提示", "确定", "取消", nil, false)
    return false
  end
  return true
end

return M
