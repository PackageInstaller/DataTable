local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local BUILDING_CONFIG = require("uimodule.building.building_config")
local building_model_classify = ShareRes.create("building.building_model_classify")
local SetActiveModelMap = building_model_classify.SetActiveModelMap
local SetMaterialModelMap = building_model_classify.SetMaterialModelMap
local CommonDefine = Config.CommonDefine
local BUILDING_TYPE = CommonDefine.BUILDING_TYPE
local BUILDING_MODEL_RT_VIEW = require("uimodule.building.building_model_rt_view")
local PointListener = CS.Game.PointEventListener
local TypeUnityCollider = typeof(UnityEngine.Collider)
local Layer = require("utils.layer")

function M:on_click_building(building_type)
  if building_type then
    local ui = UIMgr:try_get_visible_ui("building_main")
    if ui then
      ui:on_click_building(building_type)
    end
  end
end

function M:on_building_level_up()
  self.v_active_model_name_map = nil
  if self:scene_visible() then
    self:set_model_state()
  end
end

function M:init_sys()
  Base.init_sys(self)
  self.v_scene_be_loading = false
  self.v_scene_load_success = false
  self:sys_mq_bind(Const.MSG_ON_BUILDING_LEVEL_UP, self.on_building_level_up, self)
  self:reset_data()
end

function M:reset_data()
  self.v_load_prefab_count = 0
  self.v_load_prefab_suc_count = 0
  self.v_container_go_map = {}
  self.v_id_to_model_map = {}
  self.v_name_to_material_map = {}
  self.v_only_set_active_model_map = {}
  self.v_only_set_material_model_map = {}
  self.v_ui_binding_pos_map = {}
end

function M:update()
  if self:scene_visible() then
    self.v_model_view:update()
    local CSInput = UnityEngine.Input
    if self.v_collider_cid_to_build and CSInput.GetMouseButtonDown(0) then
      local cur_pos = UtilUI.convert_to_resolution_pos(CSInput.mousePosition)
      local ray = self.v_model_view.v_camera:ScreenPointToRay(cur_pos)
      if UNITY_EDITOR or UNITY_STANDALONE_WIN then
        if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject() then
          return
        end
      elseif UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject(CSInput.GetTouch(0).fingerId) then
        return
      end
      local hits = CompExtensions.GetRaycastHitArray(10)
      local hit_num = UnityPhysics.RaycastNonAlloc(ray, hits, 1000, Layer.LayerMask.UIModelView)
      if hit_num > 0 then
        for i = 0, hits.Length - 1 do
          if hits[i].collider then
            local id = hits[i].collider.gameObject:GetInstanceID()
            self:on_click_building(self.v_collider_cid_to_build[id])
            break
          end
        end
      end
    end
  end
end

function M:on_destroy()
  self:release_prefab()
  self.v_load_prefab_count = nil
  self.v_load_prefab_suc_count = nil
  self.v_container_go_map = nil
  self.v_id_to_model_map = nil
  self.v_load_done_cb = nil
  self.v_active_model_name_map = nil
  self.v_ui_binding_pos_map = nil
  Base.on_destroy(self)
  if self.v_model_view then
    self.v_model_view:on_destroy()
  end
end

function M:build_active_model_name_map()
  self.v_active_model_name_map = {}
  self.v_ui_binding_pos_map = {}
  local building_level, building_cfg, building_level_cfg, model_name_list, material_map, ui_binding_pos
  for key, building_type in pairs(BUILDING_TYPE) do
    model_name_list = nil
    material_map = nil
    ui_binding_pos = nil
    building_level = BuildingMgr:get_building_level(building_type)
    building_level_cfg = ShareRes.get_building_level_cfg(building_type, building_level)
    if building_level_cfg then
      model_name_list = building_level_cfg.ModelNameList
      material_map = building_level_cfg.ModelMaterialMap
      ui_binding_pos = building_level_cfg.UIBindingPos
    end
    building_cfg = ShareRes.get_building_cfg(building_type)
    if building_cfg then
      if not model_name_list then
        model_name_list = building_cfg.DefaultModelNameList
        material_map = building_cfg.DefaultModelMaterialMap
      end
      ui_binding_pos = ui_binding_pos or building_cfg.DefaultUIBindingPos
    end
    if model_name_list then
      for _, model_name in pairs(model_name_list) do
        if self.v_container_go_map[model_name] then
          self.v_active_model_name_map[model_name] = building_type
        else
          self.log_miss_obj(model_name)
        end
      end
    end
    if material_map then
      self.v_set_material_model_map = self.v_set_material_model_map or {}
      for model_name, material_name in pairs(material_map) do
        if self.v_container_go_map[model_name] then
          self.v_set_material_model_map[model_name] = material_name
        else
          self.log_miss_obj(model_name)
        end
      end
    end
    if ui_binding_pos then
      if self.v_container_go_map[ui_binding_pos] then
        local x, y, z = self.v_container_go_map[ui_binding_pos].transform:GetLocalPositionA3()
        self.v_ui_binding_pos_map[building_type] = {
          x,
          y,
          z
        }
      else
        self.log_miss_obj(ui_binding_pos)
      end
    end
  end
end

function M:GM_REFRESH_ui_binding_pos_map()
  self.v_ui_binding_pos_map = {}
  local building_level, building_cfg, building_level_cfg, ui_binding_pos
  for key, building_type in pairs(BUILDING_TYPE) do
    ui_binding_pos = nil
    building_level = BuildingMgr:get_building_level(building_type)
    building_level_cfg = ShareRes.get_building_level_cfg(building_type, building_level)
    if building_level_cfg then
      ui_binding_pos = building_level_cfg.UIBindingPos
    end
    if not ui_binding_pos then
      building_cfg = ShareRes.get_building_cfg(building_type)
      if building_cfg then
        ui_binding_pos = building_cfg.DefaultUIBindingPos
      end
    end
    if ui_binding_pos and self.v_container_go_map[ui_binding_pos] then
      local x, y, z = self.v_container_go_map[ui_binding_pos].transform:GetLocalPositionA3()
      self.v_ui_binding_pos_map[building_type] = {
        x,
        y,
        z
      }
    end
  end
  Log.Error(">>成功刷新")
end

function M.log_miss_obj(name)
  Log.Error("获取物体 ", name, "失败, 请检查预制中是否有对应物体，若有则检查是否已添加下划线", debug.traceback())
end

function M:release_prefab()
  for _, obj in pairs(self.v_id_to_model_map) do
    ResPoolMgr:release(obj)
  end
  local path
  for name in pairs(self.v_name_to_material_map) do
    path = Path.get_mat_path(name)
    ResMgr:unload_res(path, UnityMaterial)
    self.v_name_to_material_map[name] = nil
  end
  self.v_scene_be_loading = false
  self.v_scene_load_success = false
  self:remove_building_click_listener()
end

function M:init_scene_container()
  local container = self.v_main_model.gameObject:GetComponent(typeof(CS.Game.SceneContainer))
  if container and container.ListObj then
    for i = 0, container.ListObj.Count - 1 do
      self.v_container_go_map[container.ListName[i]] = container.ListObj[i]
    end
  end
end

function M:on_load_prefab_done()
  self.v_load_prefab_suc_count = self.v_load_prefab_suc_count + 1
  if self.v_load_prefab_suc_count >= self.v_load_prefab_count then
    self:init_scene_container()
    self:init_model_rt_view()
    self.v_scene_be_loading = false
    self.v_scene_load_success = true
    self:before_open_building_main()
  end
end

function M:load_prefab_async(is_init, model_id, callback)
  local cfg = ShareRes.get_building_model_cfg(model_id)
  if not cfg then
    Log.Error("获取基建模型配置失败, model_id：", model_id, debug.traceback())
    return
  end
  
  local function async_callback(go)
    if model_id == BUILDING_CONFIG.BUILDING_ROOT_MODEL_ID then
      self.v_main_model = go
    end
    self.v_container_go_map[cfg.PrefabName] = go
    self.v_id_to_model_map[model_id] = go
    local content_root = self.v_model_view:get_content_root()
    go.transform:SetParent(content_root.transform)
    go.transform:ResetAttr()
    local position = cfg.Position
    local rotation = cfg.Rotation
    go.transform:SetPositionA(table.unpack(position))
    go.transform:SetEuler(table.unpack(rotation))
    if callback then
      callback(go)
    end
    if is_init then
      self:on_load_prefab_done()
    end
  end
  
  NextFrameMgr:add_next_update(ResPoolMgr.get_world_model_async, ResPoolMgr, cfg.PrefabName, async_callback)
  self.v_load_prefab_count = self.v_load_prefab_count + 1
end

function M:load_main_prefab()
  local model_id = BUILDING_CONFIG.BUILDING_ROOT_MODEL_ID
  self:load_prefab_async(true, model_id)
end

function M:load_building_prefab()
  local building_level, building_level_cfg, building_cfg, model_id_list
  Log.Error("加载模型开始", Global.time)
  for key, building_type in pairs(BUILDING_TYPE) do
    building_level = BuildingMgr:get_building_level(building_type)
    if Util.is_more_than_zero(building_level) then
      building_level_cfg = ShareRes.get_building_level_cfg(building_type, building_level)
      if building_level_cfg then
        model_id_list = building_level_cfg.ModelIDList
      end
    else
      building_cfg = ShareRes.get_building_cfg(building_type)
      if building_cfg then
        model_id_list = building_cfg.DefaultModelIDList
      end
    end
    if model_id_list then
      for key, model_id in pairs(model_id_list) do
        self:load_prefab_async(true, model_id)
        Log.Error("加载模型数", self.v_load_prefab_count)
      end
    end
  end
end

function M:create_build_scene(load_done_cb)
  if not self.v_scene_be_loading and not self.v_scene_load_success then
    self.v_load_done_cb = load_done_cb
    self:init_model_rt_view()
    self.v_scene_be_loading = true
    self.v_scene_load_success = false
    self:load_main_prefab()
  elseif self.v_scene_load_success then
    self.v_load_done_cb = load_done_cb
    self:before_open_building_main()
  else
    Log.Error("基建场景加载中，请勿重复加载", self.v_scene_be_loading, debug.traceback())
  end
end

function M:init_model_rt_view()
  if not self.v_model_view then
    self.v_model_view = BUILDING_MODEL_RT_VIEW:new(nil, true, nil, nil, true, "UIModelRtViewBuilding")
  end
end

function M:before_open_building_main()
  self:set_model_state()
  self.v_model_view:on_scene_load_on(true)
  if self.v_load_done_cb then
    self.v_load_done_cb()
    self.v_load_done_cb = nil
  end
end

function M:get_prefab_by_model_id(model_id, callback)
  if not model_id then
    return
  end
  if Util.is_nil(self.v_id_to_model_map[model_id]) then
    self:load_prefab_async(true, model_id, callback)
  elseif callback then
    callback(self.v_id_to_model_map[model_id])
  end
end

function M:set_model_state()
  if not self.v_active_model_name_map then
    self:build_active_model_name_map()
  end
  local active, model_active, material, mesh_render, path
  local MeshRenderer = typeof(UnityEngine.MeshRenderer)
  for name, model in pairs(self.v_container_go_map) do
    if SetActiveModelMap[name] then
      model_active = self.v_active_model_name_map[name] ~= nil
      active = model_active or nil ~= BUILDING_CONFIG.BUILDING_DEFAULT_MODEL[name]
      if not active and self.v_set_material_model_map and self.v_set_material_model_map[name] then
        active = true
      end
      if model_active then
        local result = Util.get_component(nil, model.gameObject, TypeUnityCollider)
        if not Util.is_nil(result) then
          self.v_collider_cid_to_build = self.v_collider_cid_to_build or {}
          self.v_collider_cid_to_build[result.gameObject:GetInstanceID()] = self.v_active_model_name_map[name]
        end
      else
        Util.remove_click(nil, model.gameObject, self)
      end
      model:SetActive(active)
    end
    if self.v_set_material_model_map and self.v_set_material_model_map[name] and SetMaterialModelMap[name] then
      local material_name = self.v_set_material_model_map[name]
      if not self.v_name_to_material_map[material_name] then
        path = Path.get_mat_path(material_name)
        material = ResMgr:load_res(path, UnityMaterial)
        self.v_name_to_material_map[material_name] = material
      else
        material = self.v_name_to_material_map[material_name]
      end
      mesh_render = self.v_container_go_map[name]:GetComponent(MeshRenderer)
      mesh_render.material = material
    end
  end
end

function M:get_building_scene_obj(obj_name)
  return self.v_container_go_map[obj_name]
end

function M:get_ui_binding_pos_map()
  return self.v_ui_binding_pos_map
end

function M:get_building_scene_camera()
  if self.v_model_view then
    return self.v_model_view:get_camera()
  end
end

function M:set_scene_visible(visible)
  if self.v_model_view and self.v_model_view:is_visible() ~= visible then
    self.v_model_view:set_visible(visible)
  end
end

function M:scene_visible()
  return self.v_model_view ~= nil and self.v_model_view:is_visible()
end

function M:remove_building_click_listener()
  for name, model in pairs(self.v_container_go_map) do
    Util.remove_click(nil, model.gameObject, self)
  end
end

return M
