-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/yardcharacter.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local YardSceneHelper = (((CS.PixelNeko).P1).Scene).YardSceneHelper
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local BoxColiderStaticFunctions = ((CS.PixelNeko).Lua).BoxColiderStaticFunctions
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local RigidbodyStaticFunctions = ((CS.PixelNeko).Lua).RigidbodyStaticFunctions
local EventTriggerHelper = (((CS.PixelNeko).P1).CourtYardScene).EventTriggerHelper
local StateEventTriggerHelper = ((CS.PixelNeko).Animation).EventTriggerHelper
local Role = require("logic.manager.experimental.types.role")
local moveSpeed = 0.5
local sitLimit = 6
local g = -9.8
local YardCharacter = strictclass("YardCharacter")
YardCharacter.Ctor = function(self, roleId, sceneTag)
  -- function num : 0_0 , upvalues : _ENV, Role
  self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
  if not self._role then
    self._role = (Role.Create)(roleId)
  end
  self._type = nil
  self._direction = nil
  self._arriveBorderDirection = 0
  self._pos = nil
  self._posRef = nil
  self._parentPointObject = nil
  self._roleId = roleId
  self._sceneTag = sceneTag
end

YardCharacter.Destroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._task = nil
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(self._gameObject)
  self._gameObject = nil
end

YardCharacter.GetId = function(self)
  -- function num : 0_2
  return self._roleId
end

YardCharacter.Clone = function(self)
  -- function num : 0_3 , upvalues : _ENV
  return clone(self)
end

YardCharacter.CreatePlayer = function(self, pointObject)
  -- function num : 0_4 , upvalues : TransformStaticFunctions, YardSceneHelper, BoxColiderStaticFunctions, StateEventTriggerHelper
  self._parentPointObject = pointObject
  self._upColliderObject = (TransformStaticFunctions.GetChild)(pointObject, "Top")
  self._downColliderObject = (TransformStaticFunctions.GetChild)(pointObject, "Bottom")
  self._leftColliderObject = (TransformStaticFunctions.GetChild)(pointObject, "Left")
  self._rightColliderObject = (TransformStaticFunctions.GetChild)(pointObject, "Right")
  local prefab = nil
  if self._sceneTag == "Yard" then
    prefab = (self._role):GetYardPrefab()
  else
    if self._sceneTag == "Cabin" then
      prefab = (self._role):GetCabinPrefab()
    end
  end
  self._gameObject = (YardSceneHelper.CreatePlayer)(prefab.assetBundleName, prefab.prefabName, pointObject)
  self._boundsSize = (BoxColiderStaticFunctions.GetBoundsSize)(self._gameObject)
  self._boundsCenterx = (BoxColiderStaticFunctions.GetBoundsCenter)(self._gameObject)
  ;
  (StateEventTriggerHelper.AddStateExitListener)(self._gameObject, self.OnClickAnimationEnd, self)
  do
    if self._gameObject then
      local x, y, z = (TransformStaticFunctions.GetPosition)(self._gameObject)
      self._pos = {x = x, y = y, z = z}
      self._posRef = {x = x, y = y, z = z}
    end
    self._centerx = self._boundsCenterx - (self._pos).x
    self:SetMoveRange()
  end
end

YardCharacter.InitZPosition = function(self, z)
  -- function num : 0_5 , upvalues : _ENV, TransformStaticFunctions
  local y = (self._moveRange).minY
  local x = (math.random)() * ((self._moveRange).maxX - (self._moveRange).minX) + (self._moveRange).minX
  ;
  (TransformStaticFunctions.SetPosition)(self._gameObject, x, y, z)
end

YardCharacter.SetMoveRange = function(self, pointObject)
  -- function num : 0_6 , upvalues : BoxColiderStaticFunctions
  local centerX, centerY, centerZ = (BoxColiderStaticFunctions.GetBoundsCenter)(self._upColliderObject)
  local size = (BoxColiderStaticFunctions.GetBoundsSize)(self._upColliderObject)
  local maxY = centerY - size.y / 2
  centerX = (BoxColiderStaticFunctions.GetBoundsCenter)(self._downColliderObject)
  size = (BoxColiderStaticFunctions.GetBoundsSize)(self._downColliderObject)
  local minY = centerY + size.y / 2
  -- DECOMPILER ERROR at PC25: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC26: Overwrote pending register: R3 in 'AssignReg'

  centerX = (BoxColiderStaticFunctions.GetBoundsCenter)(self._leftColliderObject)
  size = (BoxColiderStaticFunctions.GetBoundsSize)(self._leftColliderObject)
  local minX = centerX + size.x / 2
  -- DECOMPILER ERROR at PC38: Overwrote pending register: R4 in 'AssignReg'

  -- DECOMPILER ERROR at PC39: Overwrote pending register: R3 in 'AssignReg'

  centerX = (BoxColiderStaticFunctions.GetBoundsCenter)(self._rightColliderObject)
  size = (BoxColiderStaticFunctions.GetBoundsSize)(self._rightColliderObject)
  local maxX = centerX - size.x / 2
  self._moveRange = {minX = minX + (self._boundsSize).x / 2 - self._centerx, maxX = maxX - (self._boundsSize).x / 2 - self._centerx, minY = minY + (self._boundsSize).y / 2 - self._centery, maxY = maxY - (self._boundsSize).y / 2 - self._centery}
end

YardCharacter.GetMoveRange = function(self)
  -- function num : 0_7
  return self._moveRange
end

YardCharacter.LoadBehavior = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self._behavior = (BehaviorManager.NewBehavior)("courtyard.yardcharacterai")
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._behavior)._character = self
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._behavior)._data = {RandomFunction = math.random}
  ;
  (self._behavior):SetTree()
  ;
  (self._behavior):Exec3(0)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnFixedUpdate, Common.n_FixedUpdate, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

YardCharacter.BeginDragYardCharacter = function(self)
  -- function num : 0_9 , upvalues : AnimationHelper
  self._dragTag = true
  self._startFreeFall = nil
  self._pausePlay = true
  ;
  (AnimationHelper.SetAnimatorInteger2)(self._gameObject, "isPick", 1)
end

YardCharacter.EndDragYardCharacter = function(self)
  -- function num : 0_10
  self._dragTag = false
  self._startFreeFall = 0
end

YardCharacter.SetClickParam = function(self, stringData, intData)
  -- function num : 0_11 , upvalues : SceneObjectClick
  local sceneObjectClick = (SceneObjectClick.GetSceneObjectClick)(self._gameObject)
  if sceneObjectClick == nil then
    return 
  end
  sceneObjectClick.IntData = intData
  sceneObjectClick.StringData = stringData
end

YardCharacter.SetDeltaMovePosition = function(self, x, y, z)
  -- function num : 0_12 , upvalues : RigidbodyStaticFunctions
  if self._gameObject then
    (RigidbodyStaticFunctions.MoveDeltaPosition)(self._gameObject, x, y, z)
  end
end

YardCharacter.SetMovePositionSpeed = function(self, x, y, z)
  -- function num : 0_13 , upvalues : RigidbodyStaticFunctions
  if self._gameObject then
    (RigidbodyStaticFunctions.SetMovePositionSpeed)(self._gameObject, x, y, z)
  end
end

YardCharacter.GetPosition = function(self)
  -- function num : 0_14 , upvalues : TransformStaticFunctions
  if self._gameObject then
    local x, y, z = (TransformStaticFunctions.GetPosition)(self._gameObject)
    return {x = x, y = y, z = z}
  end
end

YardCharacter.IsState = function(self, type)
  -- function num : 0_15
  do return type == self._type end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

YardCharacter.IsArriveBorder = function(self)
  -- function num : 0_16
  do return self._arriveBorderDirection ~= 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

YardCharacter.Walk = function(self, same, minTime, maxTime)
  -- function num : 0_17
  self:WalkOrStand(1, same * self._arriveBorderDirection, minTime, maxTime)
end

YardCharacter.Stand = function(self, same, minTime, maxTime)
  -- function num : 0_18
  self:WalkOrStand(0, same * self._direction, minTime, maxTime)
end

YardCharacter.WalkOrStand = function(self, type, direction, minTime, maxTime)
  -- function num : 0_19 , upvalues : _ENV, sitLimit
  self._type = type
  self._direction = direction
  local duration = (math.random)(minTime, maxTime) // 1000
  -- DECOMPILER ERROR at PC16: Unhandled construct in 'MakeBoolean' P1

  if self:IsState(0) and duration < sitLimit then
    duration = 4
  else
    duration = 8
  end
  self._task = (Tween.new)(duration, {num = duration}, {num = 0}, "linear")
end

YardCharacter.OnFixedUpdate = function(self)
  -- function num : 0_20
  if (self._posRef).x <= (self._moveRange).minX or (self._moveRange).maxX <= (self._posRef).x then
    if (self._posRef).x <= (self._moveRange).minX then
      self._arriveBorderDirection = -1
    else
      self._arriveBorderDirection = 1
    end
    if self._task then
      self._task = false
      if self._behavior then
        (self._behavior):Exec3(0)
      end
    end
  else
    self._arriveBorderDirection = 0
  end
end

YardCharacter.OnUpdate = function(self, notification)
  -- function num : 0_21 , upvalues : AnimationHelper, moveSpeed, sitLimit, g
  if self._task and not self._pausePlay then
    if (self._task):update((notification.userInfo).deltaTime) then
      self._task = nil
      if self._sitTag then
        self._sitTag = false
        ;
        (AnimationHelper.SetAnimatorInteger2)(self._gameObject, "isSit", 0)
      end
      self:DragYardCharacter(self._type * moveSpeed * self._direction * (notification.userInfo).deltaTime, 0, 0)
      if self._behavior then
        (self._behavior):Exec3(0)
      end
    else
      if self:IsState(0) and not self._dragTag and sitLimit < (self._task).time and ((self._task).subject).num <= (self._task).time - 1 and ((self._task).subject).num >= 1 and not self._sitTag then
        (AnimationHelper.SetAnimatorInteger2)(self._gameObject, "isSit", 1)
        self._sitTag = true
      end
    end
  end
  if self._sitTag then
    self._sitTag = false
    ;
    (AnimationHelper.SetAnimatorInteger2)(self._gameObject, "isSit", 0)
  end
  if self._type ~= self._lastType then
    self._lastType = self._type
    ;
    (AnimationHelper.SetAnimatorInteger2)(self._gameObject, "moveState", self._type)
  end
  if self._direction ~= self._lastDirection then
    self._lastDirection = self._direction
    ;
    (AnimationHelper.SetAnimatorInteger2)(self._gameObject, "faceDir", self._direction)
  end
  self:DragYardCharacter(self._type * moveSpeed * self._direction * (notification.userInfo).deltaTime, 0, 0)
  if self._startFreeFall then
    local lastTime = self._startFreeFall
    self._startFreeFall = self._startFreeFall + (notification.userInfo).deltaTime
    self:DragYardCharacter(0, self._startFreeFall * self._startFreeFall * g / 2 - lastTime * lastTime * g / 2, 0)
  end
end

YardCharacter.DragYardCharacter = function(self, x, y, z)
  -- function num : 0_22 , upvalues : AnimationHelper, _ENV
  local deltaX = 0
  local deltaY = 0
  local curPos = self:GetPosition()
  local nextPosX = curPos.x + x
  -- DECOMPILER ERROR at PC18: Unhandled construct in 'MakeBoolean' P1

  if nextPosX < (self._moveRange).minX and (self._moveRange).minX < curPos.x then
    deltaX = (self._moveRange).minX - curPos.x
  end
  -- DECOMPILER ERROR at PC32: Unhandled construct in 'MakeBoolean' P1

  if (self._moveRange).maxX < nextPosX and curPos.x < (self._moveRange).maxX then
    deltaX = (self._moveRange).maxX - curPos.x
  end
  deltaX = x
  local nextPosY = curPos.y + y
  -- DECOMPILER ERROR at PC49: Unhandled construct in 'MakeBoolean' P1

  if nextPosY < (self._moveRange).minY and (self._moveRange).minY < curPos.y then
    deltaY = (self._moveRange).minY - curPos.y
  end
  -- DECOMPILER ERROR at PC63: Unhandled construct in 'MakeBoolean' P1

  if (self._moveRange).maxY < nextPosY and curPos.y < (self._moveRange).maxY then
    deltaY = (self._moveRange).maxY - curPos.y
  end
  deltaY = y
  if self._startFreeFall and (self._posRef).y <= (self._moveRange).minY then
    self._startFreeFall = nil
    self._pausePlay = false
    ;
    (AnimationHelper.SetAnimatorInteger2)(self._gameObject, "isPick", 0)
  end
  -- DECOMPILER ERROR at PC103: Confused about usage of register: R9 in 'UnsetPending'

  if (math.abs)(deltaX) > 0 or (math.abs)(deltaY) > 0 or (math.abs)(z) > 0 then
    (self._posRef).x = curPos.x + deltaX
    -- DECOMPILER ERROR at PC107: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self._posRef).y = curPos.y + deltaY
    -- DECOMPILER ERROR at PC111: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self._posRef).z = curPos.z + z
    self:SetDeltaMovePosition(deltaX, deltaY, z)
  end
end

YardCharacter.ClickCharacter = function(self)
  -- function num : 0_23 , upvalues : AnimationHelper
  if not self._clickTag and not self._dragTag and not self._startFreeFall then
    self._clickTag = true
    self._pausePlay = true
    self:SetDeltaMovePosition(0, 0, 0)
    ;
    (AnimationHelper.SetAnimatorTrigger2)(self._gameObject, "onClick")
  end
end

YardCharacter.OnClickAnimationEnd = function(self)
  -- function num : 0_24
  self._clickTag = false
  if not self._dragTag and not self._startFreeFall then
    self._pausePlay = false
  end
end

return YardCharacter

