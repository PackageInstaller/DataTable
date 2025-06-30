-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/types/towerstair.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TowerStair = class("TowerStair")
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local SpriteRendererStaticFunctions = ((CS.PixelNeko).Lua).SpriteRendererStaticFunctions
local cstairobjectconfig = (BeanManager.GetTableByName)("dungeonselect.cstairobjectconfig")
local stair_animator_type = {nullary = 1, unary = 1, binary = 2, ternary = 3}
TowerStair.Ctor = function(self, id, typeid, delegate)
  -- function num : 0_0 , upvalues : cstairobjectconfig
  self._id = id
  self._typeid = typeid
  self._typecfg = cstairobjectconfig:GetRecorder(typeid)
  self._delegate = delegate
  self._children = {}
  self._points = {}
  self._attachments = {}
  self._stairtype = "nullary"
  self._state = "hidden"
  self._normalizedTime = 0
end

TowerStair.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._handler then
    ((((CS.PixelNeko).Animation).EventTriggerHelper).RemoveStateUpdateListener)(self._object, self._handler)
    self._handler = nil
  end
end

TowerStair.BuildObject = function(self, parent)
  -- function num : 0_2 , upvalues : PrefabLoader, TransformStaticFunctions, _ENV
  self._object = (PrefabLoader.LoadAndInstantiatePrefab)((self._typecfg).assetbundle, (self._typecfg).assetname)
  ;
  (TransformStaticFunctions.SetParent)((self._object).transform, parent.transform)
  ;
  (TransformStaticFunctions.SetLocalPosition)(self._object, -100, -100, -100)
  self._transform = (self._object).transform
  local path_t = "Tile_#"
  local point_path_t = "Tile_#/point"
  local sprite_path_t = "Tile_#/Sprite"
  for i = 0, 3 do
    local path = path_t:gsub("#", i)
    local point_path = point_path_t:gsub("#", i)
    local sprite_path = sprite_path_t:gsub("#", i)
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (self._children)[i] = {object = (TransformStaticFunctions.GetChild)(self._object, path), point = (TransformStaticFunctions.GetChild)(self._object, point_path), sprite = (TransformStaticFunctions.GetChild)(self._object, sprite_path)}
  end
  self._director = (TransformStaticFunctions.GetChild)(self._object, "")
  self._handler = ((((CS.PixelNeko).Animation).EventTriggerHelper).AddStateUpdateListener)(self._object, self.OnStateUpdate, self)
end

TowerStair.SetBornPosition = function(x, y)
  -- function num : 0_3 , upvalues : TowerStair
  TowerStair.BornPosition = {x = x, y = y}
end

TowerStair.SetSpeed = function(speed)
  -- function num : 0_4 , upvalues : TowerStair
  TowerStair.speed = speed
end

TowerStair.SetVelocity = function(dir, speed)
  -- function num : 0_5 , upvalues : TowerStair
  local dis = 1
  if not speed then
    speed = TowerStair.speed
  end
  TowerStair.velocity = {x = dir.x / dis * speed, y = dir.y / dis * speed, z = dir.z / dis * speed}
end

TowerStair.GetID = function(self)
  -- function num : 0_6
  return self._id
end

TowerStair.GetType = function(self)
  -- function num : 0_7
  return self._stairtype
end

TowerStair.GetTypeID = function(self)
  -- function num : 0_8
  return self._typeid
end

TowerStair.SetType = function(self, stair_type)
  -- function num : 0_9 , upvalues : AnimationHelper, stair_animator_type
  self._stairtype = stair_type
  ;
  (AnimationHelper.SetAnimatorInteger2)(self._object, "type", stair_animator_type[stair_type])
end

TowerStair.GetState = function(self)
  -- function num : 0_10
  return self._state
end

TowerStair.GetChild = function(self, index)
  -- function num : 0_11
  return (self._children)[index]
end

TowerStair.SetSortingOrder = function(self, index, order)
  -- function num : 0_12 , upvalues : SpriteRendererStaticFunctions, _ENV
  if ((self._children)[index]).object then
    (SpriteRendererStaticFunctions.SetSortingOrderRecursive)(((self._children)[index]).object, order, true)
    if (self._attachments)[index] then
      for _,v in pairs((self._attachments)[index]) do
        (SpriteRendererStaticFunctions.SetSortingOrderRecursive)(v, order + 100, true)
      end
    end
  end
end

TowerStair.GetSortingOrder = function(self, index)
  -- function num : 0_13 , upvalues : SpriteRendererStaticFunctions
  if ((self._children)[index]).sprite then
    return (SpriteRendererStaticFunctions.GetSortingOrder)(((self._children)[index]).sprite)
  end
end

TowerStair.GetObject = function(self)
  -- function num : 0_14
  return self._object
end

TowerStair.MapChildren = function(self, object)
  -- function num : 0_15 , upvalues : _ENV
  for i,v in pairs(self._children) do
    if v.object == object then
      return i
    end
  end
  return -1
end

TowerStair.Attach = function(self, index, assetBundle, assetName)
  -- function num : 0_16 , upvalues : TransformStaticFunctions, PrefabLoader, SpriteRendererStaticFunctions, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  if not (self._attachments)[index] then
    (self._attachments)[index] = {}
    ;
    (TransformStaticFunctions.SetActive)(((self._children)[index]).point, true)
    local obj = (PrefabLoader.LoadAndInstantiatePrefab)(assetBundle, assetName)
    ;
    (TransformStaticFunctions.SetLocalPosition)(obj, 0, 0, 0)
    ;
    (TransformStaticFunctions.SetParent)(obj.transform, (((self._children)[index]).point).transform, false)
    ;
    (SpriteRendererStaticFunctions.SetSortingOrderRecursive)(obj, 10, true)
    ;
    (table.insert)((self._attachments)[index], obj)
  end
end

TowerStair.Detach = function(self, index)
  -- function num : 0_17 , upvalues : _ENV
  if (self._attachments)[index] then
    for _,v in pairs((self._attachments)[index]) do
      ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(v)
    end
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._attachments)[index] = nil
  end
end

TowerStair.DetachAll = function(self)
  -- function num : 0_18 , upvalues : _ENV
  for i,_ in pairs(self._attachments) do
    self:Detach(i)
  end
end

TowerStair.SetAttachmentActive = function(self, active)
  -- function num : 0_19 , upvalues : _ENV, TransformStaticFunctions
  for i,_ in pairs(self._attachments) do
    (TransformStaticFunctions.SetActive)(((self._children)[i]).point, active)
    for _,v in pairs((self._attachments)[i]) do
      (TransformStaticFunctions.SetActive)(v, active)
    end
  end
end

TowerStair.Appear2 = function(self)
  -- function num : 0_20 , upvalues : TransformStaticFunctions, _ENV
  (TransformStaticFunctions.SetActive)(self._object, true)
  ;
  (TransformStaticFunctions.SetLocalPosition)(self._object, 0, 0, 0)
  self._state = "appear"
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "state", 1)
  effect:Bind(self._object)
  return effect
end

TowerStair.Approach2 = function(self)
  -- function num : 0_21 , upvalues : TransformStaticFunctions, stair_animator_type, _ENV
  (TransformStaticFunctions.SetActive)(self._object, true)
  self._state = "approach"
  local stateName = nil
  if stair_animator_type[self._stairtype] == 2 then
    stateName = "SelectionFinish2"
  else
    if stair_animator_type[self._stairtype] == 3 then
      stateName = "SelectionFinish3"
    end
  end
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "state", 2, stateName, 1)
  effect:Bind(self._object)
  return effect
end

TowerStair.Forward2 = function(self)
  -- function num : 0_22 , upvalues : _ENV
  return (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_22_0 , upvalues : self
    self._state = "running"
  end
)
end

TowerStair.Hide = function(self)
  -- function num : 0_23 , upvalues : TransformStaticFunctions, AnimationHelper
  (TransformStaticFunctions.SetLocalPosition)(self._object, -100, -100, 0)
  ;
  (AnimationHelper.SetAnimatorInteger2)(self._object, "state", 0)
  ;
  (AnimationHelper.PlayAnimation2)(self._object, "New State", 0)
  self:DetachAll()
  self._normalizedTime = 0
  self._state = "hide"
end

TowerStair.Hide2 = function(self)
  -- function num : 0_24 , upvalues : _ENV, TransformStaticFunctions, AnimationHelper
  return (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_24_0 , upvalues : TransformStaticFunctions, self, AnimationHelper
    (TransformStaticFunctions.SetLocalPosition)(self._object, -100, -100, 0)
    ;
    (AnimationHelper.SetAnimatorInteger2)(self._object, "state", 0)
    ;
    (AnimationHelper.PlayAnimation2)(self._object, "New State", 0)
    self._normalizedTime = 0
    self._state = "hide"
    self:DetachAll()
  end
)
end

TowerStair.OnTimelineStop = function(self, notification)
  -- function num : 0_25
  if notification.userInfo ~= self._director then
    return 
  end
end

TowerStair.OnUpdate = function(self, deltaTime, unscaledDeltaTime)
  -- function num : 0_26 , upvalues : TransformStaticFunctions, TowerStair
  if self._state ~= "hide" then
    (TransformStaticFunctions.TranslateRelativeToSelf)(self._transform, (TowerStair.velocity).x * deltaTime, (TowerStair.velocity).y * deltaTime, (TowerStair.velocity).z * deltaTime)
  end
end

TowerStair.OnStateUpdate = function(self, handle, stateName, normalizedTime)
  -- function num : 0_27
  local state_switched = normalizedTime >= 1 or normalizedTime < self._normalizedTime
  self._normalizedTime = normalizedTime
  if self._state == "appear" and state_switched then
    self._state = "show"
  elseif self._state == "approach" and state_switched then
    self._state = "reach"
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

return TowerStair

