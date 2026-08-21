local Layer = require("utils.layer")
local Math = require("base.mathx")
local TypeUnityRigidbody = typeof(UnityEngine.Rigidbody)
local TypeDynamicGridObstacle = typeof(CS.Pathfinding.DynamicGridObstacle)
local NOWALK_LAYER = Layer.Layer.WalkBlock
local UnityFind = _ENV.UnityFind
local CONFIG = {
  DGO_UPDATE_ERR = 0.5,
  DGO_CHECK_TIME = 0.2,
  SHADOW_SYNC_DIS = 0.1,
  SHADOW_CHECK_TIME = 1
}
local PLAT_OBSTACLE_ROOT = "PlatObstacleRoot"

local function _get_plat_obstacle_root()
  local root_obj = UnityFind(PLAT_OBSTACLE_ROOT)
  if nil == root_obj then
    root_obj = UnityGameObject(PLAT_OBSTACLE_ROOT)
    root_obj:ResetAttr()
  end
  return root_obj
end

local Shadow = Util.create_class()

function Shadow:_init(collider, plat)
  self.v_plat = plat
  self.v_collider = collider
  self.v_last_local_x = 0
  self.v_last_local_z = 0
  self:_create_shadow()
  self:_sync_pos()
end

function Shadow:_create_shadow()
  local collider = self.v_collider
  local plat = self.v_plat
  local shadow = UnityGameObject()
  local shadow_tf = shadow.transform
  self.v_origin_tf = collider.transform
  local root = _get_plat_obstacle_root()
  shadow_tf.parent = root.transform
  shadow_tf:CopyRotation(self.v_origin_tf)
  CSHelper.CopyComponent(collider, shadow)
  shadow.layer = NOWALK_LAYER
  shadow.name = "shadow_collider_" .. plat:get_name()
  local rigidibody = collider:GetComponent(TypeUnityRigidbody)
  if not rigidibody or rigidibody:IsNull() then
    local new_rigid = shadow:AddComponent(TypeUnityRigidbody)
    new_rigid.useGravity = false
    new_rigid.isKinematic = true
  end
  local comp = shadow:AddComponent(TypeDynamicGridObstacle)
  comp.updateError = CONFIG.DGO_UPDATE_ERR
  comp.checkTime = CONFIG.DGO_CHECK_TIME
  self.v_obj = shadow
  self.v_tf = shadow_tf
  self:_on_change_obstacle_in_plat()
end

function Shadow:_get_local_pos()
  local target_curx, _, target_curz = self.v_collider.transform:GetPositionA()
  local platx, platz = self.v_plat:get_pos2()
  return target_curx - platx, target_curz - platz
end

function Shadow:_sync_pos()
  local plat = self.v_plat
  local shadow_tf = self.v_tf
  local localx, localz = self:_get_local_pos()
  self.v_last_local_x, self.v_last_local_z = localx, localz
  local region = plat:get_region()
  local gg_offset = region:get_gg_offset()
  local worldx, worldz = gg_offset.x + localx, gg_offset.z + localz
  shadow_tf:SetPositionA(worldx, 0, worldz)
end

function Shadow:check_sync()
  local localx, localz = self:_get_local_pos()
  local last_localx, last_localz = self.v_last_local_x, self.v_last_local_z
  local dis = Math.square_distance2(localx, localz, last_localx, last_localz)
  if dis > CONFIG.SHADOW_SYNC_DIS then
    self:_sync_pos()
  end
end

function Shadow:_on_change_obstacle_in_plat()
  local plat_mgr = SceneMgr:get_plat_mgr()
  if plat_mgr then
    plat_mgr:refresh_link_connection_in_plat(self.v_plat)
  end
end

function Shadow:on_remove_from_plat()
  self:_on_change_obstacle_in_plat()
end

function Shadow:release()
  if self.v_obj then
    UnityDestroy(self.v_obj)
    self.v_obj = nil
  end
  self.v_plat = nil
  self.v_tf = nil
  self.v_origin_tf = nil
  self.v_collider = nil
end

local M = Util.create_class()

function M:_init(collider, is_static)
  self.v_collider = collider
  self.v_gameobj = collider.gameObject
  self.v_shadow_dic = {}
  self.v_valid = true
  self.v_static = is_static
  self.v_static_checked = false
  self.v_next_check_time = Global.real_time
  local comp = self.v_gameobj:TryAddComponent(TypeDynamicGridObstacle)
  comp.enabled = true
  comp.updateError = CONFIG.DGO_UPDATE_ERR
  comp.checkTime = CONFIG.DGO_CHECK_TIME
end

function M:_update_shadow()
  local plat_mgr = SceneMgr:get_plat_mgr()
  plat_mgr:check_overlap_plats(self.v_collider, self.v_shadow_dic, self._on_remove_shadow, self._on_add_shadow, self)
end

function M:_on_remove_shadow(plat)
  local shadow = self.v_shadow_dic[plat]
  self.v_shadow_dic[plat] = nil
  shadow:on_remove_from_plat()
  shadow:release()
end

function M:_on_add_shadow(plat)
  local shadow = Shadow:new(self.v_collider, plat)
  self.v_shadow_dic[plat] = shadow
end

function M:_check_valid()
  if not (not self.v_gameobj:IsNull() and self.v_gameobj.activeInHierarchy) or not self.v_collider.enabled then
    local map = SceneMgr:get_scene_map()
    if map then
      map:unregist_obstacle(self)
    end
    self:release()
  end
end

function M:_update_shadow_pos()
  for _, shadow in pairs(self.v_shadow_dic) do
    shadow:check_sync()
  end
end

function M.add(collider, is_static)
  local obj = M:new(collider, is_static)
  local map = SceneMgr:get_scene_map()
  if map then
    map:regist_obstacle(obj)
  end
end

function M.remove(collider)
  if nil == collider or collider:IsNull() then
    return
  end
  local gameobj = collider.gameObject
  local obstacle = gameobj:GetComponent(TypeDynamicGridObstacle)
  if obstacle and not obstacle:IsNull() then
    obstacle.enabled = false
  end
end

function M:release()
  if not self.v_valid then
    return
  end
  self.v_valid = false
  for _, shadow in pairs(self.v_shadow_dic) do
    shadow:release()
  end
  M.remove(self.v_collider)
end

function M:late_update()
  self:_check_valid()
  if not self.v_valid then
    return
  end
  if self.v_static then
    if not self.v_static_checked then
      self:_update_shadow()
      self.v_static_checked = true
    end
  else
    local cur_time = Global.real_time
    if cur_time >= self.v_next_check_time then
      self.v_next_check_time = self.v_next_check_time + CONFIG.SHADOW_CHECK_TIME
      self:_update_shadow()
      self:_update_shadow_pos()
    end
  end
end

return M
