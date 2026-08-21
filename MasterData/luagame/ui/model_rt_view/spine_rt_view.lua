local CSResLoader = CS.ResLoader
local CSChangeLayer = CSHelper.ChangeLayerRecursively
local UnityRenderTexture = UnityEngine.RenderTexture
local UnityCamera = UnityEngine.Camera
local UnityRawImage = UnityEngine.UI.RawImage
local Layer = require("utils.layer")
local UnityQualitySetting = UnityEngine.QualitySettings
local ANTIALIASING = 0
local _floor = math.floor
local SPINE_MGR = require("manager.spine.spine_mgr")
local M = Util.create_class()
local NEED_EXPAND = {
  1,
  2,
  3,
  4,
  5,
  [7] = 7
}

function M:_init(lua_ui, raw_image, role_pos)
  self.v_ui = lua_ui
  self.v_ui_root = lua_ui:get_object()
  self.v_ui_image = raw_image
  self.v_spine_list = {}
  self.v_spine_mgr = SPINE_MGR:new()
  self.v_spine_data = {}
  self.v_is_destroy = nil
  self.v_role_pos = role_pos
  self:on_create()
end

function M:on_create()
  local count = Global.ui_mgr.SPINE_VIEW_COUNT
  count = count + 1
  Global.ui_mgr.SPINE_VIEW_COUNT = count
  local prefab_name = "UISpineRtView"
  self.v_spine_root = ResPoolMgr:get_ui_obj(prefab_name)
  self.v_spine_root:SetActive(true)
  self.v_spine_root.transform:SetPositionA(2000 + count * 30, 1000, 0)
  self.v_content_root = Util.get_child_gameobj("ContentRoot", self.v_spine_root)
  self.v_camera_root = Util.get_child_gameobj("CameraRoot", self.v_spine_root)
  self.v_camera = Util.get_component("CameraRoot", self.v_spine_root, UnityCamera)
  self.v_raw_image = Util.get_component(nil, self.v_ui_image, UnityRawImage)
  self.v_is_destroy = nil
  self.v_content_root.transform:SetLocalPositionA(0, 0, NEED_EXPAND[self.v_role_pos] and 15 or 10)
  self:_create_rt()
end

function M:on_destroy()
  self.v_spine_mgr:on_destory()
  if self.v_spine_root then
    self.v_spine_root:SetActive(false)
    ResPoolMgr:release(self.v_spine_root)
    self.v_spine_root = nil
  end
  self.v_camera.targetTexture = nil
  self.v_role_pos = nil
  if self.v_rt_img then
    UnityRenderTexture.ReleaseTemporary(self.v_rt_img)
    self.v_rt_img = nil
  end
  local rt = self.v_raw_image.rectTransform
  local width, height = rt:GetRectWH()
  if width ~= self.v_raw_img_width or height ~= self.v_raw_img_hight then
    rt:SetSizeDeltaA(self.v_raw_img_width, self.v_raw_img_hight)
  end
  if self.v_raw_image then
    self.v_raw_image.enabled = false
    self.v_raw_image.texture = nil
    self.v_raw_image = nil
  end
  self.v_is_destroy = true
end

function M:_create_rt()
  if not self.v_rt_img then
    self.v_raw_image.enabled = true
    local rt = self.v_raw_image.rectTransform
    local rect = rt.rect
    local factor = math.min(Global.screen_factor, 2)
    self.v_raw_img_width = rect.width
    self.v_raw_img_hight = rect.height
    factor = NEED_EXPAND[self.v_role_pos] and 1.5 or 1
    self.v_rt_img_width = _floor(rect.width * factor)
    self.v_rt_img_height = _floor(rect.height * factor)
    if UNITY_EDITOR or UNITY_STANDALONE_WIN then
      self.v_rt_img = CompExtensions.GetUIRT(_floor(rect.width * factor), _floor(rect.height * factor), "SpineRT")
    else
      self.v_rt_img = CompExtensions.GetUIRT(_floor(rect.width), _floor(rect.height), "SpineRT")
    end
    self.v_raw_image.texture = self.v_rt_img
    self.v_camera.targetTexture = self.v_rt_img
    if rt.pivot.x == 0.5 and 0.5 == rt.pivot.y and 0.5 == rt.anchorMin.x and 0.5 == rt.anchorMin.y and 0.5 == rt.anchorMax.x and 0.5 == rt.anchorMax.y then
      rt.sizeDelta = UnityVector2(self.v_rt_img_width, self.v_rt_img_height)
    end
  end
end

function M:get_rt_img_width_height()
  return self.v_rt_img_width, self.v_rt_img_height
end

function M:get_obj()
  return self.v_spine_data.obj
end

function M:release_spine_obj(res_name)
  self.v_spine_mgr:release_spine_obj(res_name)
  self.v_spine_data = {}
end

function M:check_spine_res(res_name)
  local last_data = self.v_spine_data
  if last_data.res_name == res_name and last_data.obj and not last_data.obj:IsNull() then
    return true
  end
end

function M:load_spine_res(res_name, callback, is_sync_load)
  local last_data = self.v_spine_data
  if last_data.res_name == res_name and last_data.obj and not last_data.obj:IsNull() then
    if callback then
      callback(last_data.obj)
    end
    return
  end
  if last_data.res_name then
    self:release_spine_obj(last_data.res_name)
  end
  if self.v_content_root and not self.v_content_root:IsNull() then
    local chirldCount = self.v_content_root.transform.childCount
    if chirldCount > 0 then
      for i = 0, chirldCount - 1 do
        local chirld_obj = self.v_content_root.transform:GetChild(i).gameObject
        if chirld_obj then
          chirld_obj:SetActive(false)
        end
      end
    end
  end
  
  local function load_cb(obj)
    if self.v_is_destroy then
      if obj and not obj:IsNull() then
        obj.gameObject:SetActive(false)
        ResMgr:destroy_gameobj(obj)
        obj = nil
      end
      return
    end
    self.v_spine_data = {res_name = res_name, obj = obj}
    if obj and not obj:IsNull() and self.v_content_root and not self.v_content_root:IsNull() then
      local chirldCount = self.v_content_root.transform.childCount
      if chirldCount > 0 then
        for i = 0, chirldCount - 1 do
          local chirld_obj = self.v_content_root.transform:GetChild(i).gameObject
          if chirld_obj then
            chirld_obj:SetActive(false)
          end
        end
      end
      obj.transform:SetParent(self.v_content_root.transform)
      if not obj.transform.parent then
        obj.gameObject:SetActive(false)
      end
      CSChangeLayer(obj.transform, Layer.Layer.UIModelView)
    elseif obj and not obj:IsNull() then
      obj.gameObject:SetActive(false)
      ResMgr:destroy_gameobj(obj)
      obj = nil
      return
    end
    if callback and obj and not obj:IsNull() then
      callback(obj)
    end
  end
  
  self.v_spine_mgr:load_spine_res(res_name, load_cb, is_sync_load)
end

function M:play_loop_anim(res_name, anim_name)
  self.v_spine_mgr:play_loop_anim(res_name, anim_name)
end

function M:play_anim(res_name, anim_name, is_loop, track_index, delay, callback, timeScale)
  self.v_spine_mgr:play_anim(res_name, anim_name, is_loop, track_index, delay, callback, timeScale)
end

function M:add_animation(res_name, anim_name, is_loop, track_index, delay)
  self.v_spine_mgr:add_animation(res_name, track_index, anim_name, is_loop, delay)
end

function M:get_default_mix_duration(res_name)
  local mix_duration = self.v_spine_mgr:get_default_mix_duration(res_name)
  return mix_duration
end

return M
