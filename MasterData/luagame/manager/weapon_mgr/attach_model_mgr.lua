local Base = require("obj.base_component")
local CSChangeLayer = CSHelper.ChangeLayerRecursively
local Layer = require("utils.layer")
local M = Util.create_child_mt(Base)
local ResPool = Global.res_pool_mgr

function M:_init(char)
  Base._init(self)
  self.v_char = char
  self.v_buddy_id = char:get_buddy_id()
  self.v_animator = {}
  self.v_id_to_gameObject = {}
  self.v_id_to_animator_info = {}
end

local res_id_list = {}

function M:try_load_attach_model_by_act(act_name, done_cb)
  UtilTable.clear_list(res_id_list)
  local res_id = ShareRes.get_attach_model_id(self.v_buddy_id, act_name)
  if res_id then
    table.insert(res_id_list, res_id)
  end
  local weapon_mgr = self.v_char.weapon_mgr
  local weapon_res_id_list = weapon_mgr:get_current_weapon_res()
  if weapon_res_id_list then
    for _, weapon_res_id in ipairs(weapon_res_id_list) do
      local effect_res_id = ShareRes.get_weapon_attach_model_id(weapon_res_id, act_name)
      if effect_res_id then
        table.insert(res_id_list, effect_res_id)
      end
    end
  end
  self:try_load_attach_model(res_id_list, done_cb)
end

function M:hide_all_obj(done_cb)
  if self.v_id_to_gameObject then
    for i, model_go in pairs(self.v_id_to_gameObject) do
      model_go:SetActiveEx(false)
    end
  end
  if done_cb then
    done_cb()
  end
end

local loaded_model_visiable = {}

function M:try_load_attach_model(res_id_list, done_cb)
  if UtilTable.is_empty(res_id_list) then
    self:hide_all_obj(done_cb)
    return
  end
  self.v_session_need_done = 0
  UtilTable.clear_list(loaded_model_visiable)
  for _, res_id in ipairs(res_id_list) do
    local attach_model_cfg = ShareRes.create("attach_model.attach_model_res", res_id)
    if not attach_model_cfg or not attach_model_cfg.ModelRes then
      Log.Error("无法找到对应的附加模型配置,id:", res_id, self.v_buddy_id)
      self:hide_all_obj(done_cb)
      return
    end
    for _, temp_res in pairs(attach_model_cfg.ModelRes) do
      table.insert(loaded_model_visiable, temp_res)
    end
    for _, model_id in pairs(attach_model_cfg.ModelRes) do
      if not self.v_id_to_gameObject[model_id] then
        self.v_session_need_done = self.v_session_need_done + 1
      end
    end
  end
  self:set_loaded_model_visiable(loaded_model_visiable)
  if 0 == self.v_session_need_done then
    if done_cb then
      done_cb()
    end
    return
  end
  for _, res_id in ipairs(res_id_list) do
    local attach_model_cfg = ShareRes.create("attach_model.attach_model_res", res_id)
    local session_done_cb
    if done_cb then
      function session_done_cb()
        self.v_session_need_done = self.v_session_need_done - 1
        
        if self.v_session_need_done <= 0 then
          done_cb()
        end
      end
    end
    for i, model_id in pairs(attach_model_cfg.ModelRes) do
      if not self.v_id_to_gameObject[model_id] then
        local attach_point = attach_model_cfg.ResAttachPoint and attach_model_cfg.ResAttachPoint[i]
        local weapon_attach_point = attach_model_cfg.WeaponResAttachPoint and attach_model_cfg.WeaponResAttachPoint[i]
        local bind_to_hero = attach_model_cfg.BindToHero
        local use_self_animator = attach_model_cfg.UseSelfAnim
        self:load_model_animator(model_id, attach_point, weapon_attach_point, session_done_cb, bind_to_hero, use_self_animator)
      end
    end
  end
end

function M:set_loaded_model_visiable(model_res)
  for model_id, model_go in pairs(self.v_id_to_gameObject) do
    local not_use = true
    for _, _model_id in pairs(model_res) do
      if model_id == _model_id then
        not_use = false
      end
    end
    model_go:SetActiveEx(not not_use)
  end
end

function M:load_model_animator(model_id, attach_point, weapon_attach_point, done_cb, bind_to_hero, use_self_animator)
  local parent
  if attach_point then
    parent = self.v_char:get_setting_point(attach_point)
    if not parent then
      Log.Error("附加模型找不到角色上的挂点：", self.v_char.character_cfg.ModelId, attach_point, weapon_attach_point, model_id)
      return
    end
  elseif weapon_attach_point then
    parent = self.v_char.weapon_mgr:get_attach_point_obj(weapon_attach_point)
    if not parent then
      Log.Error("附加模型找不到武器上的挂点：", self.v_char.character_cfg.ModelId, attach_point, weapon_attach_point, model_id)
      return
    end
  end
  local animator_cfg = ShareRes.create("character.character_model", model_id)
  if not animator_cfg then
    Log.Error("找不到附加模型 模型表配置id：", model_id)
    if done_cb then
      done_cb()
    end
    return
  end
  if not animator_cfg.ControllerPath then
    self:load_gameobj(model_id, animator_cfg.ModelPath, parent, done_cb, bind_to_hero, use_self_animator)
    return
  end
  ResPool:get_animator_async(animator_cfg.ControllerPath, function(_, animator_info)
    if self.v_char:is_destroy() or not self.v_id_to_animator_info then
      ResPool:release_res(animator_info)
      return
    end
    local old_animator_info = self.v_id_to_animator_info[model_id]
    if old_animator_info then
      ResPool:release_res(old_animator_info)
    end
    self.v_id_to_animator_info[model_id] = animator_info
    self:load_gameobj(model_id, animator_cfg.ModelPath, parent, done_cb, bind_to_hero, use_self_animator)
  end)
end

function M:load_gameobj(model_id, prefab_name, parent, done_cb, bind_to_hero, use_self_animator)
  ResPoolMgr:get_weapon_async(prefab_name, function(go)
    if self.v_char:is_destroy() then
      ResPoolMgr:release(go)
      return
    end
    local old_gameObject = self.v_id_to_gameObject[model_id]
    if old_gameObject and not old_gameObject:IsNull() then
      ResPool:release(old_gameObject)
    end
    parent = parent or self.v_char.transform
    CSChangeLayer(go.transform, self.v_char:get_layer())
    if go.name == "H1001001_1(Clone)" then
      CSChangeLayer(go.transform, Layer.Layer.NPCCollider)
    end
    go.transform:SetParent(parent)
    go:ResetAttr()
    if nil ~= bind_to_hero and SceneMgr:check_main_scene() then
      local has_component, effect_status_com = go:TryGetComponent(TypeEffectStatus)
      if has_component then
        local effect_owner = self.v_char.gameobj.gameObject
        effect_status_com:SetupOwner(effect_owner, true)
      end
    end
    self.v_id_to_gameObject[model_id] = go
    self:init_animator(model_id, use_self_animator)
    if done_cb then
      done_cb()
    end
  end)
end

function M:init_animator(model_id, use_self_animator)
  if self.v_id_to_animator_info[model_id] and self.v_id_to_animator_info[model_id].res and self.v_id_to_gameObject[model_id] then
    local animator = self.v_id_to_gameObject[model_id]:GetComponent(TypeUnityAnimator)
    if not use_self_animator then
      animator.runtimeAnimatorController = self.v_id_to_animator_info[model_id].res
    end
    self.v_animator[model_id] = animator
  end
end

function M:play_model_ani(action, transition_time, layer)
  if UtilTable.is_empty(self.v_animator) then
    return
  end
  transition_time = transition_time or 0
  layer = layer or 0
  for _, animator in pairs(self.v_animator) do
    animator:CrossFadeInFixedTime(action, transition_time, layer, 0.0)
  end
end

function M:reset_weapon_pos(animator)
  local pos = animator.transform.localPosition
  if 0 ~= pos.x or 0 ~= pos.y or 0 ~= pos.z then
    animator.gameObject:SetActive(false)
    animator.gameObject:ResetAttr()
    animator.gameObject:SetActive(true)
  end
end

function M:on_destroy_gameobj()
  for _, animator_info in pairs(self.v_id_to_animator_info) do
    ResPool:release_res(animator_info)
  end
  self.v_id_to_animator_info = {}
  self.v_animator = {}
  for _, gameobj in pairs(self.v_id_to_gameObject) do
    if not gameobj:IsNull() then
      ResPool:release(gameobj)
    end
  end
  self.v_id_to_gameObject = {}
end

function M:set_animator_speed(speed)
  for key, animator in pairs(self.v_animator) do
    animator.speed = speed
  end
end

return M
