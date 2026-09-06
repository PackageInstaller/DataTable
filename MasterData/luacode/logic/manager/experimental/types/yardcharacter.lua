local YardSceneHelper = CS.PixelNeko.P1.Scene.YardSceneHelper
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local BoxColiderStaticFunctions = CS.PixelNeko.Lua.BoxColiderStaticFunctions
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local RigidbodyStaticFunctions = CS.PixelNeko.Lua.RigidbodyStaticFunctions
local EventTriggerHelper = CS.PixelNeko.P1.CourtYardScene.EventTriggerHelper
local StateEventTriggerHelper = CS.PixelNeko.Animation.EventTriggerHelper
local Role = require("logic.manager.experimental.types.role")
local moveSpeed = 0.5
local sitLimit = 6
local g = -9.8
local YardCharacter = strictclass("YardCharacter")

function YardCharacter:Ctor(roleId, sceneTag)
  self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  if not self._role then
    self._role = Role.Create(roleId)
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

function YardCharacter:Destroy()
  self._task = nil
  LuaNotificationCenter.RemoveObserver(self)
  CS.PixelNeko.Common.GameObjectHelper.DestroyObject(self._gameObject)
  self._gameObject = nil
end

function YardCharacter:GetId()
  return self._roleId
end

function YardCharacter:Clone()
  return clone(self)
end

function YardCharacter:CreatePlayer(pointObject)
  self._parentPointObject = pointObject
  self._upColliderObject = TransformStaticFunctions.GetChild(pointObject, "Top")
  self._downColliderObject = TransformStaticFunctions.GetChild(pointObject, "Bottom")
  self._leftColliderObject = TransformStaticFunctions.GetChild(pointObject, "Left")
  self._rightColliderObject = TransformStaticFunctions.GetChild(pointObject, "Right")
  local prefab
  if self._sceneTag == "Yard" then
    prefab = self._role:GetYardPrefab()
  elseif self._sceneTag == "Cabin" then
    prefab = self._role:GetCabinPrefab()
  end
  self._gameObject = YardSceneHelper.CreatePlayer(prefab.assetBundleName, prefab.prefabName, pointObject)
  self._boundsSize = BoxColiderStaticFunctions.GetBoundsSize(self._gameObject)
  self._boundsCenterx, self._boundsCentery, self._boundsCenterz = BoxColiderStaticFunctions.GetBoundsCenter(self._gameObject)
  StateEventTriggerHelper.AddStateExitListener(self._gameObject, self.OnClickAnimationEnd, self)
  if self._gameObject then
    local x, y, z = TransformStaticFunctions.GetPosition(self._gameObject)
    self._pos = {
      x = x,
      y = y,
      z = z
    }
    self._posRef = {
      x = x,
      y = y,
      z = z
    }
  end
  self._centerx, self._centery = self._boundsCenterx - self._pos.x, self._boundsCentery - self._pos.y
  self:SetMoveRange()
end

function YardCharacter:InitZPosition(z)
  local y = self._moveRange.minY
  local x = math.random() * (self._moveRange.maxX - self._moveRange.minX) + self._moveRange.minX
  TransformStaticFunctions.SetPosition(self._gameObject, x, y, z)
end

function YardCharacter:SetMoveRange(pointObject)
  local centerX, centerY, centerZ = BoxColiderStaticFunctions.GetBoundsCenter(self._upColliderObject)
  local size = BoxColiderStaticFunctions.GetBoundsSize(self._upColliderObject)
  local maxY = centerY - size.y / 2
  centerX, centerY, centerZ = BoxColiderStaticFunctions.GetBoundsCenter(self._downColliderObject)
  size = BoxColiderStaticFunctions.GetBoundsSize(self._downColliderObject)
  local minY = centerY + size.y / 2
  centerX, centerY, centerZ = BoxColiderStaticFunctions.GetBoundsCenter(self._leftColliderObject)
  size = BoxColiderStaticFunctions.GetBoundsSize(self._leftColliderObject)
  local minX = centerX + size.x / 2
  centerX, centerY, centerZ = BoxColiderStaticFunctions.GetBoundsCenter(self._rightColliderObject)
  size = BoxColiderStaticFunctions.GetBoundsSize(self._rightColliderObject)
  local maxX = centerX - size.x / 2
  self._moveRange = {
    minX = minX + self._boundsSize.x / 2 - self._centerx,
    maxX = maxX - self._boundsSize.x / 2 - self._centerx,
    minY = minY + self._boundsSize.y / 2 - self._centery,
    maxY = maxY - self._boundsSize.y / 2 - self._centery
  }
end

function YardCharacter:GetMoveRange()
  return self._moveRange
end

function YardCharacter:LoadBehavior()
  self._behavior = BehaviorManager.NewBehavior("courtyard.yardcharacterai")
  self._behavior._character = self
  self._behavior._data = {
    RandomFunction = math.random
  }
  self._behavior:SetTree()
  self._behavior:Exec3(0)
  LuaNotificationCenter.AddObserver(self, self.OnFixedUpdate, Common.n_FixedUpdate, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function YardCharacter:BeginDragYardCharacter()
  self._dragTag = true
  self._startFreeFall = nil
  self._pausePlay = true
  AnimationHelper.SetAnimatorInteger2(self._gameObject, "isPick", 1)
end

function YardCharacter:EndDragYardCharacter()
  self._dragTag = false
  self._startFreeFall = 0
end

function YardCharacter:SetClickParam(stringData, intData)
  local sceneObjectClick = SceneObjectClick.GetSceneObjectClick(self._gameObject)
  if sceneObjectClick == nil then
    return
  end
  sceneObjectClick.IntData = intData
  sceneObjectClick.StringData = stringData
end

function YardCharacter:SetDeltaMovePosition(x, y, z)
  if self._gameObject then
    RigidbodyStaticFunctions.MoveDeltaPosition(self._gameObject, x, y, z)
  end
end

function YardCharacter:SetMovePositionSpeed(x, y, z)
  if self._gameObject then
    RigidbodyStaticFunctions.SetMovePositionSpeed(self._gameObject, x, y, z)
  end
end

function YardCharacter:GetPosition()
  if self._gameObject then
    local x, y, z = TransformStaticFunctions.GetPosition(self._gameObject)
    return {
      x = x,
      y = y,
      z = z
    }
  end
end

function YardCharacter:IsState(type)
  return type == self._type
end

function YardCharacter:IsArriveBorder()
  return self._arriveBorderDirection ~= 0
end

function YardCharacter:Walk(same, minTime, maxTime)
  self:WalkOrStand(1, same * self._arriveBorderDirection, minTime, maxTime)
end

function YardCharacter:Stand(same, minTime, maxTime)
  self:WalkOrStand(0, same * self._direction, minTime, maxTime)
end

function YardCharacter:WalkOrStand(type, direction, minTime, maxTime)
  self._type = type
  self._direction = direction
  local duration = math.random(minTime, maxTime) // 1000
  if self:IsState(0) then
    if duration < sitLimit then
      duration = 4
    else
      duration = 8
    end
  end
  self._task = Tween.new(duration, {num = duration}, {num = 0}, "linear")
end

function YardCharacter:OnFixedUpdate()
  if self._posRef.x <= self._moveRange.minX or self._posRef.x >= self._moveRange.maxX then
    if self._posRef.x <= self._moveRange.minX then
      self._arriveBorderDirection = -1
    else
      self._arriveBorderDirection = 1
    end
    if self._task then
      self._task = false
      if self._behavior then
        self._behavior:Exec3(0)
      end
    end
  else
    self._arriveBorderDirection = 0
  end
end

function YardCharacter:OnUpdate(notification)
  if self._task and not self._pausePlay then
    if self._task:update(notification.userInfo.deltaTime) then
      self._task = nil
      if self._sitTag then
        self._sitTag = false
        AnimationHelper.SetAnimatorInteger2(self._gameObject, "isSit", 0)
      end
      self:DragYardCharacter(self._type * moveSpeed * self._direction * notification.userInfo.deltaTime, 0, 0)
      if self._behavior then
        self._behavior:Exec3(0)
      end
    elseif self:IsState(0) and not self._dragTag and self._task.time > sitLimit and self._task.subject.num <= self._task.time - 1 and self._task.subject.num >= 1 then
      if not self._sitTag then
        AnimationHelper.SetAnimatorInteger2(self._gameObject, "isSit", 1)
        self._sitTag = true
      end
    else
      if self._sitTag then
        self._sitTag = false
        AnimationHelper.SetAnimatorInteger2(self._gameObject, "isSit", 0)
      end
      if self._type ~= self._lastType then
        self._lastType = self._type
        AnimationHelper.SetAnimatorInteger2(self._gameObject, "moveState", self._type)
      end
      if self._direction ~= self._lastDirection then
        self._lastDirection = self._direction
        AnimationHelper.SetAnimatorInteger2(self._gameObject, "faceDir", self._direction)
      end
      self:DragYardCharacter(self._type * moveSpeed * self._direction * notification.userInfo.deltaTime, 0, 0)
    end
  end
  if self._startFreeFall then
    local lastTime = self._startFreeFall
    self._startFreeFall = self._startFreeFall + notification.userInfo.deltaTime
    self:DragYardCharacter(0, self._startFreeFall * self._startFreeFall * g / 2 - lastTime * lastTime * g / 2, 0)
  end
end

function YardCharacter:DragYardCharacter(x, y, z)
  local deltaX = 0
  local deltaY = 0
  local curPos = self:GetPosition()
  local nextPosX = curPos.x + x
  if nextPosX < self._moveRange.minX then
    if curPos.x > self._moveRange.minX then
      deltaX = self._moveRange.minX - curPos.x
    end
  elseif nextPosX > self._moveRange.maxX then
    if curPos.x < self._moveRange.maxX then
      deltaX = self._moveRange.maxX - curPos.x
    end
  else
    deltaX = x
  end
  local nextPosY = curPos.y + y
  if nextPosY < self._moveRange.minY then
    if curPos.y > self._moveRange.minY then
      deltaY = self._moveRange.minY - curPos.y
    end
  elseif nextPosY > self._moveRange.maxY then
    if curPos.y < self._moveRange.maxY then
      deltaY = self._moveRange.maxY - curPos.y
    end
  else
    deltaY = y
  end
  if self._startFreeFall and self._posRef.y <= self._moveRange.minY then
    self._startFreeFall = nil
    self._pausePlay = false
    AnimationHelper.SetAnimatorInteger2(self._gameObject, "isPick", 0)
  end
  if 0 < math.abs(deltaX) or 0 < math.abs(deltaY) or 0 < math.abs(z) then
    self._posRef.x = curPos.x + deltaX
    self._posRef.y = curPos.y + deltaY
    self._posRef.z = curPos.z + z
    self:SetDeltaMovePosition(deltaX, deltaY, z)
  end
end

function YardCharacter:ClickCharacter()
  if not self._clickTag and not self._dragTag and not self._startFreeFall then
    self._clickTag = true
    self._pausePlay = true
    self:SetDeltaMovePosition(0, 0, 0)
    AnimationHelper.SetAnimatorTrigger2(self._gameObject, "onClick")
  end
end

function YardCharacter:OnClickAnimationEnd()
  self._clickTag = false
  if not self._dragTag and not self._startFreeFall then
    self._pausePlay = false
  end
end

return YardCharacter
