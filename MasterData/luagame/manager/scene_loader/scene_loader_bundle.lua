local Base = require("manager.scene_loader.scene_loader")
local M = Global.util.create_child_mt(Base)
local PathDefine = require("utils.path_define")
local AssetToBundle = PathDefine.requrie_assettobundle()
local BundleDeps = PathDefine.requrie_bundle_deps()
local AssetCache = require("manager.res.asset_cache")
local ShareRes = Global.share_res
local AssetBundleMgr = Global.assetbundle_mgr
local UnitySceneManager = UnityEngine.SceneManagement.SceneManager
local UnityLoadSceneAsync = UnitySceneManager.LoadSceneAsync
local UnityUnloadScene = UnitySceneManager.UnloadScene
local UnityLoad = UnityEngine.Resources.Load
local UnityUnLoad = UnityEngine.Resources.UnloadAsset
local _slower = string.lower
local _sformat = string.format
local UnityFind = _ENV.UnityFind
local RuntimeMeshCombinener = CS.RuntimeMeshCombinener
local CSSceneIllumination = CS.SceneIllumination
local LOAD_SCENE_BUNDLE_PROGRESS = 0.2
local LOAD_SCENE_PROGRESS = 0.8
local MAX_LIGHTMAP_COUNT = 16
local MAX_DIFF_LIGHT_COUNT = 4
local LIGHTMAP_NAME_RULES = {
  "lightmap-%s_comp_light_%s",
  "lightmap-%s_comp_dir_%s",
  "lightmap-%s_comp_shadowmask_%s"
}

local function get_scene_asset_path(scene_cfg)
  local scene_name = string.lower(scene_cfg.MapName)
  local name = scene_cfg.SceneName and scene_cfg.SceneName or scene_cfg.MapName
  name = string.lower(Util.check_load_scene_name(name))
  local scene_asset_path = "assets/product/world/" .. scene_name .. "/" .. name .. ".unity"
  return scene_asset_path
end

local function _get_scene_lightmap_directory(scene_cfg)
  local scene_name = scene_cfg.SceneName and scene_cfg.SceneName or scene_cfg.MapName
  scene_name = string.lower(scene_name)
  local map_name = string.lower(scene_cfg.MapName)
  local scene_lightmap_dir = "assets/product/world/" .. map_name .. "/" .. scene_name .. "/lightingmapdata"
  return scene_lightmap_dir
end

local function _get_cur_diff_light_index(use_flag)
  local index = 0
  local use_index_table = {}
  if TowerMgr then
    local tower = TowerMgr:get_tower()
    if tower then
      index = tower:get_diff_light_index()
      local use_index_cfg = tower:get_diff_light_index_AB()
      if use_index_cfg then
        for _, use_value in pairs(use_index_cfg) do
          use_index_table[use_value] = true
        end
      end
    else
      local story_room = TowerMgr:get_story_room()
      index = story_room and story_room:get_diff_light_index() or 0
      if story_room then
        local use_index_cfg_story = story_room:get_diff_light_index_AB()
        if use_index_cfg_story then
          for _, use_value in pairs(use_index_cfg_story) do
            use_index_table[use_value] = true
          end
        end
      end
    end
  end
  use_index_table[index] = true
  if use_flag then
    return index
  else
    return use_index_table
  end
end

local function _get_filered_unused_lightmap_bundles_deps(self, scene_deps)
  if self.v_scene_name == "Main" or self.v_scene_name == "main" then
    return scene_deps
  end
  local deps = UtilTable.copy_table(scene_deps)
  local use_index_table = _get_cur_diff_light_index()
  for i = 0, MAX_DIFF_LIGHT_COUNT - 1 do
    local bundle_raw_name = self.v_scene_lightmap_directory .. tostring(i)
    local md5 = MD5Helper.ComputeHash(bundle_raw_name)
    md5 = string.lower(md5)
    local md5_key = md5 .. ".ab"
    for key, value in pairs(deps) do
      if value == md5_key and not use_index_table[i] then
        deps[key] = nil
      end
    end
  end
  return deps
end

local function _init_scene_diff_light()
  local scene_effect_obj = UnityFind("SceneEffect")
  if not scene_effect_obj then
    return
  end
  local scene_illumination = scene_effect_obj:GetComponent(typeof(CSSceneIllumination))
  local index = _get_cur_diff_light_index(true)
  scene_illumination.curLightDataIndex = index
  scene_illumination:ApplySceneEffect()
end

local function _init_static_batching()
  if Global.scene_mgr and Global.scene_mgr:check_main_scene() or Global.render_mgr:is_low_memory_device() then
    return
  end
  local root_obj = UnityFind("Root")
  if not root_obj then
    return
  end
  local runtime_mesh_comb = root_obj:GetComponent(typeof(RuntimeMeshCombinener))
  if not runtime_mesh_comb then
    return
  end
  runtime_mesh_comb:StaticBatch()
end

function M:load_scene(scene_cfg)
  if self.v_scene_loading then
    Global.log.Debug("----- scene_loading ----- " .. self.v_scene_name)
    return
  end
  local new_scene_name = scene_cfg.SceneName and scene_cfg.SceneName or scene_cfg.MapName
  self:unload_current_scene()
  self.v_scene_asset_path = get_scene_asset_path(scene_cfg)
  self.v_scene_lightmap_directory = _get_scene_lightmap_directory(scene_cfg)
  local _, _, scene_deps = ResMgr.get_deps_info(self.v_scene_asset_path)
  assert(scene_deps, self.v_scene_asset_path .. " deps not exist")
  self.v_loadsceneop = nil
  self.v_scene_loading = true
  self.v_scene_name = new_scene_name
  self.v_scene_deps = scene_deps
  self.v_scene_deps_count = #scene_deps
  self.v_loaded_scene_dep_count = 0
  self.v_scene_loading_stage = 0
  self.v_total_progress = 0
  self.v_total_progress = LOAD_SCENE_BUNDLE_PROGRESS + LOAD_SCENE_PROGRESS
  self:before_load_scene(scene_cfg)
  self:load_scene_res()
  self.v_need_load = true
end

function M:need_load_scene()
  if self.v_scene_loading or self.v_scene_loaded then
    return false
  end
  return true
end

function M:get_additive_scene_loader()
  return M
end

function M:get_load_scene_progress()
  if self.v_scene_deps_count <= 0 then
    return 0.1
  end
  local deps_progress = _min(self.v_loaded_scene_dep_count / self.v_scene_deps_count, 1) * LOAD_SCENE_BUNDLE_PROGRESS
  local scene_progress = self.v_loadsceneop and self.v_loadsceneop.progress * LOAD_SCENE_PROGRESS or 0
  return (deps_progress + scene_progress) / self.v_total_progress
end

function M:is_load_scene_done()
  if self.v_loadsceneop and self.v_loadsceneop.isDone then
    _init_scene_diff_light()
    _init_static_batching()
    self.v_loadsceneop = nil
    self.v_scene_loading = nil
    self.v_scene_loaded = true
    self:unload_current_scene(false)
  end
  return not self.v_scene_loading
end

function M:on_load_scene_dep_callback()
  self.v_loaded_scene_dep_count = self.v_loaded_scene_dep_count + 1
end

function M:load_scene_res()
  self.v_scene_loading_stage = self.v_scene_loading_stage + 1
  if 1 == self.v_scene_loading_stage then
    if self.v_scene_deps then
      self.v_scene_deps = _get_filered_unused_lightmap_bundles_deps(self, self.v_scene_deps)
      AssetBundleMgr:load_multi_bundles_async(self.v_scene_deps, self.on_load_scene_dep_callback, self, self.load_scene_res, self)
    else
      self:load_scene_res()
    end
  elseif 2 == self.v_scene_loading_stage then
    self.v_scene_bundle_path = AssetToBundle[self.v_scene_asset_path]
    Global.log.Debug("self.v_scene_bundle_path = ", self.v_scene_asset_path)
    AssetBundleMgr:load_bundle_async(self.v_scene_bundle_path, self.load_scene_res, self)
  elseif 3 == self.v_scene_loading_stage then
    local name = Util.check_load_scene_name(self.v_scene_name)
    self.v_loadsceneop = UnityLoadSceneAsync(name)
    self.v_loadsceneop.allowSceneActivation = true
    return
  end
end

function M:unload_current_scene(unload_bundle_true)
  Base.unload_current_scene(self)
  if not self.v_scene_loaded then
    self.v_need_load = nil
    return
  end
  if nil ~= self.v_scene_name then
    AssetCache:del_ref(self.v_scene_bundle_path, AssetCache.DEFAULT_ASSET_TYPE)
    ResMgr:unload_deps(self.v_scene_deps)
    self.v_scene_bundle_path = nil
    self.v_scene_asset_path = nil
    self.v_scene_deps = nil
    self.v_scene_name = nil
    AssetCache:collectgarbage(unload_bundle_true)
  end
end

return M
