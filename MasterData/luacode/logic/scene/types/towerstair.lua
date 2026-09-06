local TowerStair = class("TowerStair")
local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local SpriteRendererStaticFunctions = CS.PixelNeko.Lua.SpriteRendererStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local cstairobjectconfig = BeanManager.GetTableByName("dungeonselect.cstairobjectconfig")
local stair_animator_type = {
  nullary = 1,
  unary = 1,
  binary = 2,
  ternary = 3
}

function TowerStair:Ctor(id, typeid, delegate)
  self._id = id
  self._typeid = typeid
  self._typecfg = cstairobjectconfig:GetRecorder(typeid)
  self._delegate = delegate
  self._children = {}
  self._points = {}
  self._attachments = {}
  self._stairtype = "nullary"
  self._state = "hidden"
  self._elapsed = 0
  self._normalizedTime = 0
end

function TowerStair:Destroy()
end

function TowerStair:BuildObject(parent)
  self._object = PrefabLoader.LoadAndInstantiatePrefab(self._typecfg.assetbundle, self._typecfg.assetname)
  TransformStaticFunctions.SetParent(self._object.transform, parent.transform)
  TransformStaticFunctions.SetLocalPosition(self._object, -100, -100, -100)
  self._transform = self._object.transform
  local path_t = "Tile_#"
  local point_path_t = "Tile_#/point"
  local sprite_path_t = "Tile_#/Sprite"
  for i = 0, 3 do
    local path = path_t:gsub("#", i)
    local point_path = point_path_t:gsub("#", i)
    local sprite_path = sprite_path_t:gsub("#", i)
    self._children[i] = {
      object = TransformStaticFunctions.GetChild(self._object, path),
      point = TransformStaticFunctions.GetChild(self._object, point_path),
      sprite = TransformStaticFunctions.GetChild(self._object, sprite_path)
    }
  end
  self._director = TransformStaticFunctions.GetChild(self._object, "")
end

function TowerStair.SetBornPosition(x, y)
  TowerStair.BornPosition = {x = x, y = y}
end

function TowerStair.SetSpeed(speed)
  TowerStair.speed = speed
end

function TowerStair.SetVelocity(dir, speed)
  local dis = 1
  speed = speed or TowerStair.speed
  TowerStair.velocity = {
    x = dir.x / dis * speed,
    y = dir.y / dis * speed,
    z = dir.z / dis * speed
  }
end

function TowerStair:GetID()
  return self._id
end

function TowerStair:SetID(id)
  self._id = id
end

function TowerStair:GetType()
  return self._stairtype
end

function TowerStair:GetTypeID()
  return self._typeid
end

function TowerStair:SetType(stair_type)
  self._stairtype = stair_type
  AnimationHelper.SetAnimatorInteger2(self._object, "type", stair_animator_type[stair_type])
end

function TowerStair:GetState()
  return self._state
end

function TowerStair:GetChild(index)
  return self._children[index]
end

function TowerStair:SetSortingOrder(index, order)
  if self._children[index].object then
    SpriteRendererStaticFunctions.SetSortingOrderRecursive(self._children[index].object, order, true)
    if self._attachments[index] then
      for _, v in pairs(self._attachments[index]) do
        SpriteRendererStaticFunctions.SetSortingOrderRecursive(v, order + 100, true)
      end
    end
  end
end

function TowerStair:GetSortingOrder(index)
  if self._children[index].sprite then
    return SpriteRendererStaticFunctions.GetSortingOrder(self._children[index].sprite)
  end
end

function TowerStair:GetObject()
  return self._object
end

function TowerStair:MapChildren(object)
  for i, v in pairs(self._children) do
    if v.object == object then
      return i
    end
  end
  return -1
end

function TowerStair:Attach(index, assetBundle, assetName)
  self._attachments[index] = self._attachments[index] or {}
  TransformStaticFunctions.SetActive(self._children[index].point, true)
  local obj = PrefabLoader.LoadAndInstantiatePrefab(assetBundle, assetName)
  TransformStaticFunctions.SetLocalPosition(obj, 0, 0, 0)
  TransformStaticFunctions.SetParent(obj.transform, self._children[index].point.transform, false)
  SpriteRendererStaticFunctions.SetSortingOrderRecursive(obj, 10, true)
  table.insert(self._attachments[index], obj)
end

function TowerStair:Detach(index)
  if self._attachments[index] then
    for _, v in pairs(self._attachments[index]) do
      CS.PixelNeko.Common.GameObjectHelper.DestroyObject(v)
    end
    self._attachments[index] = nil
  end
end

function TowerStair:DetachAll()
  for i, _ in pairs(self._attachments) do
    self:Detach(i)
  end
end

function TowerStair:SetAttachmentActive(active)
  for i, _ in pairs(self._attachments) do
    TransformStaticFunctions.SetActive(self._children[i].point, active)
    for _, v in pairs(self._attachments[i]) do
      TransformStaticFunctions.SetActive(v, active)
    end
  end
end

function TowerStair:Appear2()
  TransformStaticFunctions.SetActive(self._object, true)
  TransformStaticFunctions.SetLocalPosition(self._object, 0, 0, 0)
  self._state = "appear"
  self._elapsed = 0
  self._startPos = CS.UnityEngine.Vector3(TransformStaticFunctions.GetPosition(self._object))
  self:SetTargetPos()
  local effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "state", 1)
  effect:Bind(self._object)
  return effect
end

function TowerStair:Approach2()
  TransformStaticFunctions.SetActive(self._object, true)
  self._state = "approach"
  local stateName
  if stair_animator_type[self._stairtype] == 2 then
    stateName = "SelectionFinish2"
  elseif stair_animator_type[self._stairtype] == 3 then
    stateName = "SelectionFinish3"
  end
  self._elapsed = 0
  self._startPos = CS.UnityEngine.Vector3(TransformStaticFunctions.GetPosition(self._object))
  self:SetTargetPos()
  local effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "state", 2, stateName, 1)
  effect:Bind(self._object)
  return effect
end

function TowerStair:Forward2()
  return EffectFactory.CreateCustomEffect(function()
    self._state = "running"
  end)
end

function TowerStair:Hide()
  TransformStaticFunctions.SetLocalPosition(self._object, -100, -100, 0)
  AnimationHelper.SetAnimatorInteger2(self._object, "state", 0)
  AnimationHelper.PlayAnimation2(self._object, "New State", 0)
  self:DetachAll()
  self._normalizedTime = 0
  self._state = "hide"
end

function TowerStair:OnTimelineStop(notification)
  if notification.userInfo ~= self._director then
    return
  end
end

function TowerStair:Clamp01(t)
  if t < 0 then
    return 0
  elseif 1 < t then
    return 1
  else
    return t
  end
end

function TowerStair:SetTargetPos()
  local index = 0
  for _, v in pairs(self._delegate._stairs.running) do
    index = index + 1
    v:SetID(index)
  end
  local rightObject = self._delegate._rightChildObject
  if rightObject then
    local offsetLocal = CS.UnityEngine.Vector3(-1, -0.5, 0) * -0.3 * self._id
    local targetWorldPos = UIManager.TransformPoint(rightObject, offsetLocal)
    self._targetPos = targetWorldPos
  end
end

function TowerStair:OnUpdate(deltaTime, unscaledDeltaTime)
  if self._state ~= "hide" and self._startPos and self._targetPos then
    local currentPos = CS.UnityEngine.Vector3(TransformStaticFunctions.GetPosition(self._object))
    local distance = CS.UnityEngine.Vector3.Distance(currentPos, self._targetPos)
    if distance < 0.01 then
      self:SetTargetPos()
      TransformStaticFunctions.SetPosition(self._object, self._targetPos.x, self._targetPos.y, self._targetPos.z)
      if self._state == "appear" then
        self._state = "show"
      elseif self._state == "approach" then
        self._state = "reach"
      end
      return true
    end
    self._elapsed = self._elapsed + deltaTime
    local t = self._elapsed / 1
    t = self:Clamp01(t)
    local pos = CS.UnityEngine.Vector3.Lerp(self._startPos, self._targetPos, t)
    TransformStaticFunctions.SetPosition(self._object, pos.x, pos.y, pos.z)
  end
  return false
end

function TowerStair:OnMoveUpdate(deltaTime, unscaledDeltaTime)
  if self._state ~= "hide" then
    TransformStaticFunctions.TranslateRelativeToSelf(self._transform, TowerStair.velocity.x * deltaTime, TowerStair.velocity.y * deltaTime, TowerStair.velocity.z * deltaTime)
  end
end

function TowerStair:OnStateUpdate(handle, stateName, normalizedTime)
end

return TowerStair
