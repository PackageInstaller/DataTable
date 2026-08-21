local M = Util.create_class()
local _tinsert = table.insert
local CSResLoader = CS.ResLoader

function M:_init()
  self.v_active_map = {}
  self.v_free_map = {}
  self.v_loaded_effect_data = {}
end

function M:_set_npc_info(npc, npc_info)
  local npc_id = npc_info.res_id
  npc.uuid = npc_info.uuid
  npc:set_camp(npc_info.abs_camp)
  npc:set_group_id(npc_info.ext_args.npc_group or -1)
  npc:set_ai_group_id(npc_info.ext_args.ai_group_id)
  npc:set_ai_group(npc_info.ext_args.ai_group)
  npc:set_difficulty_tag(npc_info.ext_args.difficulty_tag)
  npc:set_level(npc_info.level)
  npc:set_local_name(npc_info.ext_args.npc_name)
  npc:set_event_key(npc_info.ext_args.event_key)
  npc:set_max_wave(npc_info.ext_args.is_max_wave)
  npc:set_end_action(npc_info.ext_args.is_end_action)
  npc:set_params(npc_info.ext_args.params)
  npc:set_auto_level(npc_info.ext_args.auto_level)
  if npc_info.ext_args.cur_hp and 0 ~= npc_info.ext_args.cur_hp then
    npc:set_cur_hp(npc_info.ext_args.cur_hp)
  end
  local character_cfg = ShareRes.get_character_cfg(npc_id)
  assert(character_cfg, "can't find character config: " .. npc_id)
  local model_cfg = ShareRes.create("character.character_model", character_cfg.ModelId)
  assert(model_cfg, "can't find model config: " .. npc_id .. " ModelId: " .. character_cfg.ModelId)
  npc.character_cfg = character_cfg
  npc.model_cfg = model_cfg
  local x, y, z = npc_info.x, npc_info.y, npc_info.z
  if not y then
    local ret, height
    if Global.hero then
      ret, height = Util.raycast_by_role(Global.hero, x, z)
    else
      ret, height = Util.get_height(x, z)
    end
    y = height
  end
  npc:set_pos(x, y, z)
  npc:init_canuse_pos()
  local is_look_at_role = npc_info.ext_args.is_look_at_role
  if is_look_at_role and Global.hero then
    local owner_pos = npc:get_pos_vec3()
    if Global.hero then
      local hero_pos = Global.hero:get_pos_vec3()
      local angle = UnityVector3.Angle(owner_pos, hero_pos)
      npc:lookat_pos(hero_pos)
    end
  else
    npc:face_dir(npc_info.dir or 0, true)
  end
end

local function _get_npc_class_name(npc_id, npc_class)
  local character_cfg = ShareRes.get_character_cfg(npc_id)
  assert(character_cfg, "can't find character config: " .. npc_id)
  return character_cfg.NpcClass and "obj." .. character_cfg.NpcClass or npc_class or "obj.npc"
end

function M:_create_new_npc(npc_info, load_gameobj_callback, npc_class)
  local npc_id = npc_info.res_id
  Util.assert(npc_id, "create new npc fialed! npc id is nil!")
  local npc_class_name = _get_npc_class_name(npc_id, npc_class)
  local npc = require(npc_class_name):new()
  self:_set_npc_info(npc, npc_info)
  npc:report_create()
  if not npc:is_setup() then
    self:_setup_cobj(npc)
  end
  self:add_magic_with_npc_info(npc, npc_info)
  if not npc:will_init_gameobj() then
    if npc.model_cfg and npc.model_cfg.ControllerPath then
      SceneMgr:load_model_animator(npc, load_gameobj_callback)
    else
      SceneMgr:load_gameobj_async(npc, load_gameobj_callback)
    end
  end
  return npc
end

function M:_set_preload_npc(npc, npc_info, callback)
  npc.uuid = npc_info.uuid
  npc:_init(true)
  self:_set_npc_info(npc, npc_info)
  npc:report_create()
  npc:on_pool_init_npc()
  self:add_magic_with_npc_info(npc, npc_info)
  if callback then
    callback(npc:get_cid(), npc)
  end
end

function M:add_magic_with_npc_info(npc, npc_info)
  if npc_info.ext_args.magic_id ~= nil and npc_info.ext_args.magic_id > 0 and npc.magic_mgr then
    npc.magic_mgr:add_magic(npc, npc_info.ext_args.magic_id, nil, nil, 1)
  end
end

function M:_setup_cobj(npc)
  npc:presetup()
  npc:setup()
  npc:aftersetup()
end

function M:_clear_npc(npc)
  if not npc then
    return
  end
  npc:on_destroy_luaobj()
  local gameobj = npc:get_gameobj()
  ResPoolMgr:release_res(npc.animator_info)
  if gameobj then
    npc:on_destroy_gameobj()
    ResPoolMgr:release(gameobj)
  end
  if npc.on_destroy then
    npc:on_destroy()
  end
end

function M:get_npc(npc_info, callback, npc_class)
  Util.assert(npc_info, "npc_info is nil! can't create npc!")
  local npc_id = npc_info.res_id
  if self.v_free_map[npc_id] == nil then
    self.v_free_map[npc_id] = {}
  end
  local npc_list = self.v_free_map[npc_id]
  local npc
  if 0 == UtilTable.hash_lenth(npc_list) then
    npc = self:_create_new_npc(npc_info, callback, npc_class)
    if Global.debug_preload_npc then
      Log.Error("npc未预加载：", npc_info)
    end
  else
    npc = npc_list[#npc_list]
    npc_list[#npc_list] = nil
    self.v_active_map[npc_info.uuid] = npc
    self:_set_preload_npc(npc, npc_info, callback)
  end
  return npc
end

function M:preload_npc(npc_id, callback)
  if not npc_id then
    Log.Error("no modelid", npc_id, debug.traceback())
  end
  local npc = require("obj.npc"):new(true)
  local character_cfg = ShareRes.get_character_cfg(npc_id)
  assert(character_cfg, "can't find character config: " .. npc_id)
  local model_cfg = ShareRes.create("character.character_model", character_cfg.ModelId)
  assert(model_cfg, "can't find model config: " .. npc_id .. " ModelId: " .. character_cfg.ModelId)
  npc.character_cfg = character_cfg
  npc.model_cfg = model_cfg
  if not npc:is_setup() then
    self:_setup_cobj(npc)
  end
  
  local function cb()
    npc:set_pos(0, 0, 0)
    npc:set_enable(false)
    local trans = npc:get_transform()
    trans:SetParent(self.v_root_trans, true)
    if self.v_free_map[npc_id] == nil then
      self.v_free_map[npc_id] = {}
    end
    _tinsert(self.v_free_map[npc_id], npc)
    if callback then
      callback()
    end
  end
  
  if not npc:will_init_gameobj() then
    if model_cfg and model_cfg.ControllerPath then
      SceneMgr:load_model_animator(npc, cb)
    else
      SceneMgr:load_gameobj_async(npc, cb)
    end
  end
end

function M:release_npc(npc)
  local uuid = npc:get_uuid()
  local npc_id = npc:get_npc_id()
  self.v_active_map[uuid] = nil
  if nil == self.v_free_map[npc_id] then
    self.v_free_map[npc_id] = {}
  end
  if not npc:is_destroy() then
    _tinsert(self.v_free_map[npc_id], npc)
    npc:on_release()
  end
end

function M:clear()
  for uuid, npc in pairs(self.v_active_map) do
    self:_clear_npc(npc)
  end
  for _, npc_list in pairs(self.v_free_map) do
    for _, npc in ipairs(npc_list) do
      self:_clear_npc(npc)
    end
  end
  UtilTable.clear_map(self.v_active_map)
  UtilTable.clear_map(self.v_free_map)
end

function M:is_npc_active_in_pool(npc)
  local uuid = npc:get_uuid()
  return self.v_active_map[uuid] ~= nil
end

function M:set_pool_root(root_trans)
  self.v_root_trans = root_trans
end

return M
