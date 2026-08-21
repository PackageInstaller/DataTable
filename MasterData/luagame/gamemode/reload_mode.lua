local Const = require("const")
local Base = require("gamemode.base")
local AssetCache = require("manager.res.asset_cache")
local UnityFindObjectsOfType = UnityGameObject.FindObjectsOfType
local UnityCamera = typeof(UnityEngine.Camera)

local function create_child_mt(base)
  local child = setmetatable({}, base)
  child.__index = child
  return child
end

local M = create_child_mt(Base)

function M:gd_init()
  Base.gd_init(self)
  self.v_init_tasks = {
    {
      self._create_reload_camera
    },
    {
      self._load_empty_scene
    },
    {
      self._do_reload
    }
  }
end

function M:gd_update(delta_time)
  self:_exec_task()
end

function M:_create_reload_camera()
  if 0 == self.dummy_cnt then
    self.dummy_cnt = 1
  else
    return true
  end
end

function M:_load_empty_scene()
  if 0 == self.dummy_cnt then
    self.dummy_cnt = self.dummy_cnt + 1
    if not SceneMgr:get_scene_cfg() or Config.EMPTY_SCENE_CFG.MapName == SceneMgr:get_scene_cfg().MapName then
      Util.collectgarbage()
      return true
    end
    if SceneLoader then
      SceneLoader:load_scene(Config.EMPTY_SCENE_CFG)
    end
  end
  if not SceneLoader then
    return true
  end
  if SceneLoader:is_load_scene_done() then
    Util.collectgarbage()
    return true
  end
end

local function reload()
  Global.stop_update = true
  collectgarbage("collect")
  collectgarbage("collect")
  CS.Game.Service.Instance:Reload()
end

function M:_do_reload()
  if Global.assetbundle_mgr and Global.assetbundle_mgr:has_loading_bundle() then
    return
  end
  if not Global.assetbundle_mgr then
    reload()
    return
  end
  if Global.assetbundle_mgr:has_loading_bundle() then
    return
  end
  reload()
  return true
end

return M
