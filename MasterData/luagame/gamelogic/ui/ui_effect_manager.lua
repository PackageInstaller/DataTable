local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local UI_EFFECT_ID = 0

local function get_ui_effect_id()
  UI_EFFECT_ID = UI_EFFECT_ID + 1
  return UI_EFFECT_ID
end

local EFFECT_PARAM_KEY = {
  "prefab_name",
  "ui_object",
  "go",
  "parent",
  "effect_id",
  "callback",
  "callback_params",
  "load_callback",
  "effect_length",
  "position",
  "is_world",
  "effect_status",
  "life_end_time",
  "end_effect_time"
}
local EFFECT_PARAM_INDEX = {}
for index = 1, #EFFECT_PARAM_KEY do
  EFFECT_PARAM_INDEX[EFFECT_PARAM_KEY[index]] = index
end
EFFECT_PARAM_INDEX.___destroy_in_pool = true
local param_count = #EFFECT_PARAM_KEY

local function CHECK_NEW_INDEX(tb, k, v)
  if not EFFECT_PARAM_INDEX[k] then
    Log.Error("不能对EffectParam对象的任意字段赋值，你尝试去赋值", k, "请先在param_key与param_index中定义字段名", debug.traceback())
  end
  rawset(tb, k, v)
end

local UIEffectData = Util.create_class()
UIEffectData.__newindex = CHECK_NEW_INDEX

function UIEffectData:_init()
end

function UIEffectData:on_destroy()
  for i = 1, param_count do
    self[EFFECT_PARAM_KEY[i]] = nil
  end
end

function M.get_new_effect_data()
  return UIEffectData:new()
end

function M:enter_tower()
  self:clear_all_effect()
end

function M:exit_tower()
  self:clear_all_effect()
end

function M:init_sys()
  Base.init_sys(self)
  self.v_wait_load_effect_data_map = {}
  self.v_active_effect_map = {}
  self.v_uiobject_effect_map = {}
end

local NEXT_UPDATE_TIME

function M:update()
  local need_low_update = Global.low_update
  if need_low_update then
    self:low_update()
  end
end

function M:low_update()
  if not NEXT_UPDATE_TIME then
    return
  end
  local time = GlobalTimeMgr:get_time()
  if time < NEXT_UPDATE_TIME then
    return
  end
  local next_update_time
  for effect_id, effect_data in pairs(self.v_active_effect_map) do
    local end_time, update_func
    if effect_data.end_effect_time then
      update_func = self.end_effect_time_over
      end_time = effect_data.end_effect_time
    elseif effect_data.life_end_time then
      update_func = self.try_play_end_effect
      end_time = effect_data.life_end_time
    end
    if end_time then
      if time >= end_time then
        update_func(self, effect_id)
      end
      next_update_time = math.min(NEXT_UPDATE_TIME or math.huge, end_time)
    end
  end
  NEXT_UPDATE_TIME = next_update_time
end

function M:play_effect(effect_data)
  if Util.is_destroy(effect_data.ui_object) then
    Log.Error("ui对象不存在或已销毁，无法创建特效", debug.traceback())
    return
  end
  if Util.is_nil(effect_data.parent) then
    Log.Error("ui对象不存在或已销毁，无法创建特效", debug.traceback())
    return
  end
  local effect_id = get_ui_effect_id()
  effect_data.effect_id = effect_id
  self.v_wait_load_effect_data_map[effect_id] = effect_data
  local ui_object = effect_data.ui_object
  self.v_uiobject_effect_map[ui_object] = self.v_uiobject_effect_map[effect_data.ui_object] or {}
  self.v_uiobject_effect_map[ui_object][effect_id] = effect_data
  local effect_name = effect_data.prefab_name
  ResPoolMgr:get_ui_effect_async(effect_name, self.effect_load_done, {self, effect_data})
  return effect_id
end

function M.effect_load_done(obj, args)
  local self = args[1]
  local effect_data = args[2]
  local effect_id = effect_data.effect_id
  if not self.v_wait_load_effect_data_map[effect_id] then
    ResPoolMgr:release(obj)
    return
  end
  effect_data.go = obj
  self.v_active_effect_map[effect_id] = effect_data
  self.v_wait_load_effect_data_map[effect_id] = nil
  if Util.is_destroy(effect_data.ui_object) then
    self:release_effect(effect_id)
    return
  end
  local cid = obj:GetInstanceID()
  local length, effect_status = ResPoolMgr:get_effect_data(cid)
  if effect_status then
    effect_data.effect_status = effect_status
    if not effect_data.effect_length then
      effect_data.effect_length = length
    end
  end
  if not effect_data.effect_length then
    self:release_effect(effect_id)
    Log.Error("获取特效持续时间失败", effect_data.prefab_name, debug.traceback())
    return
  end
  obj:SetActive(true)
  if effect_data.parent then
    obj.transform:SetParent(effect_data.parent)
  end
  obj.transform:ResetAttr()
  if effect_data.position then
    if effect_data.is_world then
      obj.transform:SetPositionA(effect_data.position:Get())
    else
      obj.transform:SetLocalPositionA(effect_data.position:Get())
    end
  end
  if effect_data.load_callback then
    effect_data.load_callback()
  end
  if effect_data.effect_length >= 0 then
    effect_data.life_end_time = GlobalTimeMgr:get_time() + effect_data.effect_length
    if not NEXT_UPDATE_TIME or effect_data.life_end_time < NEXT_UPDATE_TIME then
      NEXT_UPDATE_TIME = effect_data.life_end_time
    end
  end
end

function M:try_replay_effect(effect_id)
  if self.v_wait_load_effect_data_map[effect_id] then
    return true
  end
  local effect_data = self.v_active_effect_map[effect_id]
  if effect_data and not Util.is_nil(effect_data.effect_status) then
    effect_data.effect_status:RestartAll(nil, true)
    return true
  end
end

function M:try_play_end_effect(effect_id)
  local effect_data = self.v_active_effect_map[effect_id]
  if not effect_data then
    return
  end
  if Util.is_nil(effect_data.go) or Util.is_destroy(effect_data.ui_object) then
    self:release_effect(effect_data.effect_id)
  end
  local end_length = effect_data.effect_status:GetEndLength()
  if not end_length or 0 == end_length then
    self:release_effect(effect_data.effect_id)
  elseif end_length > 0 then
    local animator = Util.get_animator(nil, effect_data.go)
    if animator then
      effect_data.end_effect_time = (effect_data.life_end_time or GlobalTimeMgr:get_time()) + end_length
      effect_data.effect_status:PlayEndEffect()
      if not NEXT_UPDATE_TIME or effect_data.end_effect_time < NEXT_UPDATE_TIME then
        NEXT_UPDATE_TIME = effect_data.end_effect_time
      end
    end
  end
end

function M:end_effect_time_over(effect_id)
  self:release_effect(effect_id)
end

function M:stop_effect(effect_id, skip_end)
  if skip_end then
    self:release_effect(effect_id)
  else
    self:try_play_end_effect(effect_id)
  end
end

function M:release_effect(effect_id)
  local effect_data = self.v_active_effect_map[effect_id]
  if not effect_data then
    return
  end
  if not Util.is_nil(effect_data.go) then
    ResPoolMgr:release(effect_data.go)
  end
  self:destory_effect_data(effect_data)
end

function M:destory_effect_data(effect_data)
  self.v_wait_load_effect_data_map[effect_data.effect_id] = nil
  self.v_active_effect_map[effect_data.effect_id] = nil
  if self.v_uiobject_effect_map[effect_data.ui_object] then
    self.v_uiobject_effect_map[effect_data.ui_object][effect_data.effect_id] = nil
  end
  effect_data:on_destroy()
end

function M:is_wait_load(effect_id)
  return self.v_wait_load_effect_data_map[effect_id] ~= nil
end

function M:clear_ui_effect(ui_object)
  if self.v_uiobject_effect_map[ui_object] then
    for effect_id in pairs(self.v_uiobject_effect_map[ui_object]) do
      self:release_effect(effect_id)
    end
  end
end

function M:clear_all_effect()
  for effect_id in pairs(self.v_active_effect_map) do
    self:release_effect(effect_id)
  end
  UtilTable.clear_map(self.v_wait_load_effect_data_map)
  UtilTable.clear_map(self.v_uiobject_effect_map)
end

return M
