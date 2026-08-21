local PathDefine = require("utils.path_define")
local AssetToBundle = PathDefine.requrie_assettobundle()
local BundleDeps = PathDefine.requrie_bundle_deps()
local AssetCache = require("manager.res.asset_cache")
local RuntimePackage = require("manager.res.runtime_package")
local AssetBundleMgr = Global.assetbundle_mgr
local UnitySprite = UnityEngine.Sprite
local UnityTexture2D = UnityEngine.Texture2D
local UnityDestroy = _ENV.UnityDestroy
local UnityDontDestroyOnLoad = UnityGameObject.DontDestroyOnLoad
local UnityInstantiate = UnityGameObject.Instantiate
local UnityAssetBundle = UnityEngine.AssetBundle
local _sformat = string.format
local _slower = string.lower
local _floor = math.floor
local _min = math.min
local GOPATHS = setmetatable({}, Global.config.WEAK_METATABLE)
local DONT_DESTROY_ONLOAD_OBJS = {}
local EMPTY_PREFAB_NAME = "EmptyObj"
local TypeItem = typeof(CS.Game.EquipCube)
local Base = require("manager.res.base_loader")
local M = Global.util.create_child_mt(Base)
local MAX_EXT_STAGE = 2
local CACHE_ASSET_TYPE = AssetCache.DEFAULT_ASSET_TYPE

local function get_asset_full_path(asset, subfix)
  if subfix then
    return _sformat("assets/resources/%s%s", asset, subfix)
  else
    return _sformat("assets/resources/%s", asset)
  end
end

local function get_icon_full_path(icon)
  return _sformat("assets/product/ui/images/%s.png", _slower(icon))
end

local function get_atlas_assetbundle_path(atlas)
  atlas = _slower(atlas)
  return _sformat("rawdata/ui_atlas/%s.assetbundle", atlas)
end

local function asset_to_bundle(asset)
  return AssetToBundle[asset]
end

function M.get_deps_info(res)
  local full_res_path = _slower(res)
  local bundle_path = asset_to_bundle(full_res_path)
  local deps = BundleDeps[bundle_path]
  return full_res_path, bundle_path, deps, lower_res
end

function M:_init()
  self.v_instantiate_gameobj_callback = setmetatable({}, Global.config.WEAK_METATABLE)
  self.v_destroy_gameobj_callback = setmetatable({}, Global.config.WEAK_METATABLE)
end

function M:on_destroy()
  for _, obj in pairs(DONT_DESTROY_ONLOAD_OBJS) do
    if not obj:IsNull() then
      UnityDestroy(obj)
    end
  end
  GOPATHS = setmetatable({}, Config.WEAK_METATABLE)
  DONT_DESTROY_ONLOAD_OBJS = {}
  AssetBundleMgr:on_destroy()
end

function M:register_instantaite_go_cb(callback, cbdata)
  self.v_instantiate_gameobj_callback[callback] = cbdata
end

function M:register_destroy_go_cb(callback, cbdata)
  self.v_destroy_gameobj_callback[callback] = cbdata
end

function M:create_skill_area_obj()
  local gameobj = self:raw_instantiate(self.v_skill_area, false)
  return gameobj
end

function M:create_empty_role_obj(name, dont_destroy)
  local gameobj = UnityGameObject()
  if name then
    gameobj.name = name
  end
  if dont_destroy then
    UnityDontDestroyOnLoad(gameobj)
  end
  return Util.wrap_gameobj(gameobj)
end

function M:raw_instantiate(res, dont_destroy, path, add_ref)
  local go = UnityInstantiate(res)
  if dont_destroy then
    self:dont_destroy_on_load(go)
  end
  if path then
    GOPATHS[go:GetInstanceID()] = path
  end
  if add_ref then
    local _, bundle_path, deps = M.get_deps_info(path)
    if bundle_path then
      AssetCache:add_ref(bundle_path, CACHE_ASSET_TYPE)
    end
    if deps then
      for _, v in pairs(deps) do
        AssetCache:add_ref(v, CACHE_ASSET_TYPE)
      end
    end
  end
  local retgo = Util.wrap_gameobj(go)
  for callback, cbdata in pairs(self.v_instantiate_gameobj_callback) do
    callback(cbdata, retgo)
  end
  return retgo
end

function M:dont_destroy_on_load(go)
  local gameobj = go.gameObject
  DONT_DESTROY_ONLOAD_OBJS[go:GetInstanceID()] = go
  UnityDontDestroyOnLoad(gameobj)
  if Global.memory_debug then
    go.tag = Global.config.memory_tag
  end
end

function M:destroy_gameobj(go)
  local gameobj = go.gameObject
  local cid = gameobj:GetInstanceID()
  local bundle_path = GOPATHS[cid]
  DONT_DESTROY_ONLOAD_OBJS[cid] = nil
  GOPATHS[cid] = nil
  for callback, cbdata in pairs(self.v_destroy_gameobj_callback) do
    callback(cbdata, go)
  end
  if Global.mat_mgr then
    Global.mat_mgr:on_destroy_gameobj(cid)
  end
  UnityDestroy(gameobj)
  if not bundle_path then
    return
  end
  self:unload_res(bundle_path)
end

function M.on_load_bundle_res_callback(data)
  local self = data[1]
  local stage = data[2]
  local bundle_res = data[3]
  local res = data[4]
  local deps = data[5]
  local final_callback = data[6]
  stage = stage + 1
  data[2] = stage
  if 1 == stage then
    if deps then
      AssetBundleMgr:load_multi_bundles_async(deps, nil, nil, self.on_load_bundle_res_callback, data)
    else
      self.on_load_bundle_res_callback(data)
    end
  elseif 2 == stage then
    AssetBundleMgr:load_bundle_async(bundle_res, self.on_load_bundle_res_callback, data)
    return
  elseif 3 == stage then
    AssetBundleMgr:load_bundle_asset_async(bundle_res, res, self.on_load_bundle_res_callback, data)
    return
  else
    final_callback()
    return
  end
end

function M:load_prefab_async(res, full_res_path, bundle_path, dont_destroy, callback, cbdata)
  local asset = AssetBundleMgr:get_bundle_asset(bundle_path, full_res_path)
  if not asset then
    Util.show_error("----- res not exist ----- " .. bundle_path, " ", full_res_path)
    callback(cbdata)
    return
  end
  local go = self:raw_instantiate(asset)
  local cid = go:GetInstanceID()
  if dont_destroy then
    self:dont_destroy_on_load(go)
  end
  GOPATHS[cid] = res
  callback(cbdata, go)
end

function M:load_gameobj_async(res, asset_type, dont_destroy, callback, cbdata)
  local full_res_path, bundle_res, deps = M.get_deps_info(res)
  if not bundle_res then
    Util.show_error("----- res not exist ----- " .. res)
    return
  end
  if deps then
    self.on_load_bundle_res_callback({
      self,
      0,
      bundle_res,
      full_res_path,
      deps,
      function()
        self:load_prefab_async(res, full_res_path, bundle_res, dont_destroy, callback, cbdata)
      end
    })
  else
    AssetBundleMgr:load_bundle_async(bundle_res, function()
      AssetBundleMgr:load_bundle_asset_async(bundle_res, full_res_path, function()
        self:load_prefab_async(res, full_res_path, bundle_res, dont_destroy, callback, cbdata)
      end)
    end)
  end
end

function M:load_gameobj(res, _, dont_destroy)
  local asset, _ = self:load_res(res)
  if not asset then
    Util.show_error("----- res not exist ----- " .. res)
    return
  end
  local go = self:raw_instantiate(asset)
  local cid = go:GetInstanceID()
  if dont_destroy then
    self:dont_destroy_on_load(go)
  end
  GOPATHS[cid] = res
  return go
end

function M:unload_res(res_path, _, count)
  local _, bundle_res, deps = M.get_deps_info(res_path)
  if bundle_res then
    AssetCache:del_ref(bundle_res, AssetCache.DEFAULT_ASSET_TYPE, count)
  end
  if not deps then
    return
  end
  self:unload_deps(deps)
end

function M:do_unload(asset, unload_type)
  if "5785f65217892ec68924ee454bff0692.ab" == asset or "bbc2aa00f66f619e7ff7e654af6ae63f.ab" == asset then
    return
  end
  asset:Unload(unload_type)
  UnityDestroy(asset)
end

function M:load_raw_res(res_path)
  local full_res_path, bundle_path, _ = M.get_deps_info(res_path)
  local full_bundle_path = RuntimePackage.get_bundle_path(bundle_path)
  local bundle = UnityAssetBundle.LoadFromFile(full_bundle_path)
  local asset = bundle:LoadAsset(full_res_path)
  return asset, bundle
end

function M:load_res(res_path, asset_type)
  local full_res_path, bundle_path, deps = M.get_deps_info(res_path)
  if not bundle_path then
    return
  end
  if deps then
    AssetBundleMgr:load_multi_bundles(deps)
  end
  AssetBundleMgr:load_bundle(bundle_path)
  asset_type = asset_type and typeof(asset_type)
  local asset = AssetBundleMgr:load_bundle_asset(bundle_path, full_res_path, asset_type)
  return asset, bundle_path
end

function M:load_res_async(res_path, asset_type, cb, cbdata)
  local full_res_path, bundle_res, deps, lower_res = M.get_deps_info(res_path)
  bundle_res = bundle_res or lower_res
  if deps then
    self.on_load_bundle_res_callback({
      self,
      0,
      bundle_res,
      full_res_path,
      deps,
      function()
        cb(cbdata, AssetBundleMgr:get_bundle_asset(bundle_res, full_res_path))
      end
    })
  else
    AssetBundleMgr:load_bundle_async(bundle_res, function()
      AssetBundleMgr:load_bundle_asset_async(bundle_res, full_res_path, function()
        cb(cbdata, AssetBundleMgr:get_bundle_asset(bundle_res, full_res_path))
      end)
    end)
  end
end

function M:load_set_icon(image, icon_path, callback, is_texture, uiobj, parent_name)
  if image.overrideSprite ~= nil then
    image.overrideSprite = nil
  end
  if not is_texture then
    local path = ShareRes.create("img_collection", icon_path)
    if path then
      icon_path = path
    end
    icon_path = _slower(icon_path)
    icon_path = Path.get_image_icon_path(icon_path)
  else
    icon_path = _slower(icon_path)
    icon_path = Path.get_texture_path(icon_path)
  end
  local icon_bundle_path = asset_to_bundle(icon_path)
  assert(icon_bundle_path, icon_path)
  AssetBundleMgr:load_bundle_async(icon_bundle_path, function()
    AssetBundleMgr:load_bundle_asset_async(icon_bundle_path, icon_path, function(_, icon)
      if icon then
        if image:IsNull() then
          ResMgr:unload_res(icon_path)
        else
          local is_need_override_sprite = false
          if not parent_name then
            is_need_override_sprite = true
          else
            local image_parent_name = Util.get_obj_parent_name(image)
            if image_parent_name == parent_name then
              is_need_override_sprite = true
            end
          end
          if is_need_override_sprite then
            image.sprite = icon
            if callback then
              callback(image)
            end
          end
          if is_texture and uiobj then
            if uiobj:is_destroy() then
              self:unload_res(icon_path)
            else
              uiobj:add_texture_reference(icon_path)
            end
          end
        end
      else
        Global.log.Error("Image path Cant Find", image, icon_path, " ", debug.traceback())
      end
    end, nil, typeof(UnitySprite))
  end)
end

function M:load_set_icon_sync(image, icon_path, callback, is_texture, uiobj, parent_name)
  if image.overrideSprite ~= nil then
    image.overrideSprite = nil
  end
  if not is_texture then
    local path = ShareRes.create("img_collection", icon_path)
    if path then
      icon_path = path
    end
    icon_path = _slower(icon_path)
    icon_path = Path.get_image_icon_path(icon_path)
  else
    icon_path = _slower(icon_path)
    icon_path = Path.get_texture_path(icon_path)
  end
  local icon_bundle_path = asset_to_bundle(icon_path)
  assert(icon_bundle_path, icon_path)
  AssetBundleMgr:load_bundle(icon_bundle_path)
  local icon = AssetBundleMgr:load_bundle_asset(icon_bundle_path, icon_path, typeof(UnitySprite))
  if icon then
    if image:IsNull() then
      ResMgr:unload_res(icon_path)
    else
      local is_need_override_sprite = false
      if not parent_name then
        is_need_override_sprite = true
      else
        local image_parent_name = Util.get_obj_parent_name(image)
        if image_parent_name == parent_name then
          is_need_override_sprite = true
        end
      end
      if is_need_override_sprite then
        image.sprite = icon
        if callback then
          callback(image)
        end
      end
      if is_texture and uiobj then
        if uiobj:is_destroy() then
          self:unload_res(icon_path)
        else
          uiobj:add_texture_reference(icon_path)
        end
      end
    end
  else
    Global.log.Error("Image path Cant Find", image, icon_path, " ", debug.traceback())
  end
end

function M:load_set_mat_texture(meshRenderer, texture_path, callback, uiobj)
  texture_path = _slower(texture_path)
  texture_path = Path.get_texture_path(texture_path)
  local icon_bundle_path = asset_to_bundle(texture_path)
  assert(icon_bundle_path, texture_path)
  AssetBundleMgr:load_bundle_async(icon_bundle_path, function()
    AssetBundleMgr:load_bundle_asset_async(icon_bundle_path, texture_path, function(_, sprite)
      if sprite then
        if meshRenderer:IsNull() then
          ResMgr:unload_res(texture_path)
        else
          meshRenderer.material.mainTexture = sprite.texture
          if callback then
            callback(meshRenderer)
          end
          if uiobj then
            if uiobj:is_destroy() then
              self:unload_res(texture_path)
            else
              uiobj:add_texture_reference(texture_path)
            end
          end
        end
      else
        Global.log.Error("texture path Cant Find", texture_path, " ", debug.traceback())
      end
    end, nil, typeof(UnitySprite))
  end)
end

function M:load_atlas_sprite(atlas, sprite_name, callback)
  atlas = string.lower(atlas)
  sprite_name = string.lower(sprite_name)
  local bundles = UIAtlas[atlas] or {}
  for _, bundle in ipairs(bundles) do
    local atlas_bundle = get_atlas_assetbundle_path(bundle)
    AssetBundleMgr:load_bundle(atlas_bundle)
    local asset = AssetBundleMgr:load_atlas_bundle_asset(atlas_bundle, sprite_name, typeof(UnitySprite))
    if asset then
      return asset, bundle
    end
  end
end

function M:load_set_itemobj_icon(gameobject, icon_path, callback)
  local icon_full_path = get_icon_full_path(icon_path)
  local icon_bundle_path = asset_to_bundle(icon_full_path)
  assert(icon_bundle_path, icon_full_path)
  AssetBundleMgr:load_bundle_async(icon_bundle_path, function()
    AssetBundleMgr:load_bundle_asset_async(icon_bundle_path, icon_full_path, function(_, icon)
      if icon then
        if gameobject:IsNull() then
          ResMgr:unload_res(icon_bundle_path)
        else
          local item_compent = gameobject:GetComponent(TypeItem)
          item_compent:SetSprite(icon)
          if callback then
            callback()
          end
        end
      else
        Global.log.Error("Image path Cant Find", image, icon_full_path, " ", debug.traceback())
      end
    end, nil, typeof(UnitySprite))
  end)
end

function M:load_set_itemobj_quality_icon(gameobject, icon_path)
  local icon_full_path = get_icon_full_path(icon_path)
  local icon_bundle_path = asset_to_bundle(icon_full_path)
  assert(icon_bundle_path, icon_full_path)
  AssetBundleMgr:load_bundle_async(icon_bundle_path, function()
    AssetBundleMgr:load_bundle_asset_async(icon_bundle_path, icon_full_path, function(_, icon)
      if icon then
        if gameobject:IsNull() then
          ResMgr:unload_res(icon_bundle_path)
        else
          local item_compent = gameobject:GetComponent(TypeItem)
          item_compent:SetBg(icon)
        end
      else
        Global.log.Error("Image path Cant Find", icon_full_path, " ", debug.traceback())
      end
    end, nil, typeof(UnitySprite))
  end)
end

function M:unload_texture(texture, count)
  self:unload_res(texture, nil, count)
end

function M:is_gameobj_dont_destroy_on_load(go)
  return DONT_DESTROY_ONLOAD_OBJS[go:GetInstanceID()] ~= nil
end

function M:get_dont_destroy_on_load()
  return DONT_DESTROY_ONLOAD_OBJS
end

function M:load_shader(shader)
end

function M:unload_deps(deps)
  if not deps then
    return
  end
  for _, v in pairs(deps) do
    AssetCache:del_ref(v, AssetCache.DEFAULT_ASSET_TYPE)
  end
end

function M:load_text_asset(text_path, cb)
  text_path = string.format("assets/product/%s", text_path)
  local text, _ = self:load_res(text_path, typeof(UnityEngine.TextAsset))
  cb(text.bytes)
end

function M:is_res_exist(res_path)
  local path = _slower(res_path)
  local ab = asset_to_bundle(path)
  if not ab then
    return false
  end
  local bundle_path = RuntimePackage.get_bundle_exist(ab)
  if bundle_path then
    return true
  end
  return false
end

function M:check_is_can_fight_with_res(chapter_cfg)
  local is_res_integrity = CS.GameToLua.CheckUpdate.GetResIntegrity()
  if is_res_integrity then
    return true
  end
  local chapter_index = chapter_cfg.Order
  if chapter_index < 4 then
    return true
  end
  local is_can_fight = DownloadMgr:is_can_fight(chapter_index, true)
  return is_can_fight
end

return M
