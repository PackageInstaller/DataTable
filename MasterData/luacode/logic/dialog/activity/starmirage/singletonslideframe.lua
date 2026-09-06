local UIManager = CS.PixelNeko.UI.UIManager
local SingletonSlideFrame = class("SingletonSlideFrame")

function SingletonSlideFrame:Ctor(window, isVertical, leftEdgeLocalPosition, rightEdgeLocalPosition, elasticity)
  if not window then
    LogError("SingletonSlideFrame", "have no window.")
    return
  end
  if not leftEdgeLocalPosition then
    LogError("SingletonSlideFrame", "leftEdgeLocalPosition is nil.")
    return
  end
  if not rightEdgeLocalPosition then
    LogError("SingletonSlideFrame", "rightEdgeLocalPosition is nil.")
    return
  end
  self._window = window
  self._isVertical = isVertical
  if leftEdgeLocalPosition < rightEdgeLocalPosition then
    self._leftEdgeLocalPosition = leftEdgeLocalPosition
    self._rightEdgeLocalPosition = rightEdgeLocalPosition
    local range = rightEdgeLocalPosition - leftEdgeLocalPosition
    self._range = range
  else
    self._leftEdgeLocalPosition = rightEdgeLocalPosition
    self._rightEdgeLocalPosition = leftEdgeLocalPosition
    local range = leftEdgeLocalPosition - rightEdgeLocalPosition
    self._range = range
  end
  local delta = self._range * 0.5
  if elasticity then
    delta = elasticity
  elseif 500 < delta then
    delta = 500
  end
  self._delta = delta
  self._leftDragLimitLocalPosition = self._leftEdgeLocalPosition - delta
  self._rightDragLimitLocalPosition = self._rightEdgeLocalPosition + delta
  self._beginDragHandler = self._window:Subscribe_BeginDragEvent(self.OnBeginDrag, self)
  self._dragHandler = self._window:Subscribe_DragEvent(self.OnDrag, self)
  self._endDragHandler = self._window:Subscribe_EndDragEvent(self.OnEndDrag, self)
  self._cancelDragHandler = self._window:Subscribe_CancelDragEvent(self.OnEndDrag, self)
  self._updateHandler = self._window:Subscribe_UpdateEvent(self.OnUpdate, self)
  self._slideInertiaTime = 0.5
  self._sprintTime = 0.2
end

function SingletonSlideFrame:Destroy()
  if self._beginDragHandler then
    self._window:Unsubscribe_BeginDragEvent(self._beginDragHandler)
    self._beginDragHandler = nil
  end
  if self._dragHandler then
    self._window:Unsubscribe_DragEvent(self._dragHandler)
    self._dragHandler = nil
  end
  if self._endDragHandler then
    self._window:Unsubscribe_EndDragEvent(self._endDragHandler)
    self._endDragHandler = nil
  end
  if self._cancelDragHandler then
    self._window:Unsubscribe_CancelDragEvent(self._cancelDragHandler)
    self._cancelDragHandler = nil
  end
  if self._updateHandler then
    self._window:Unsubscribe_UpdateEvent(self._updateHandler)
    self._updateHandler = nil
  end
end

function SingletonSlideFrame:OnBeginDrag()
  self._slideTask = nil
  self._moveSpeed = {x = 0, y = 0}
  self._dragDelta = 0
  self._local_posX, self._local_posY, self._local_posZ = self._window:GetLocalPosition()
  if self._isVertical then
    self._currentPosition = self._local_posY
  else
    self._currentPosition = self._local_posX
  end
end

function SingletonSlideFrame:OnDrag(args)
  local pressPosition = args.pressPosition
  local position = args.position
  self._moveSpeed.x = args.xSpeed / 60
  self._moveSpeed.y = args.ySpeed / 60
  local dragDelta = self._dragDelta
  local currentPosition = self._currentPosition
  if self._isVertical then
    if math.abs(self._moveSpeed.y) > 0 then
      local _, localPressY = UIManager.ScreenPointToLocalPointInRectangle(self._window._uiObject, pressPosition.x, pressPosition.y)
      local _, localY = UIManager.ScreenPointToLocalPointInRectangle(self._window._uiObject, position.x, position.y)
      self._currentPosition = currentPosition - self._dragDelta
      self._dragDelta = localY - localPressY
    else
      return
    end
  elseif math.abs(self._moveSpeed.x) > 0 then
    local localPressX, _ = UIManager.ScreenPointToLocalPointInRectangle(self._window._uiObject, pressPosition.x, pressPosition.y)
    local localX, _ = UIManager.ScreenPointToLocalPointInRectangle(self._window._uiObject, position.x, position.y)
    self._currentPosition = currentPosition - self._dragDelta
    self._dragDelta = localX - localPressX
  else
    return
  end
  local currentPosition1 = self._currentPosition + self._dragDelta
  if 0 <= dragDelta and self._dragDelta > 0 and currentPosition1 ~= currentPosition and currentPosition1 >= self._rightEdgeLocalPosition then
    self._dragDelta = dragDelta + (self._dragDelta - dragDelta) / 60
  elseif dragDelta <= 0 and self._dragDelta < 0 and currentPosition1 ~= currentPosition and currentPosition1 <= self._leftEdgeLocalPosition then
    self._dragDelta = dragDelta + (self._dragDelta - dragDelta) / 60
  end
  self._currentPosition = self._currentPosition + self._dragDelta
  if self._currentPosition < self._leftDragLimitLocalPosition then
    self._currentPosition = self._leftDragLimitLocalPosition
  elseif self._currentPosition > self._rightDragLimitLocalPosition then
    self._currentPosition = self._rightDragLimitLocalPosition
  end
  if currentPosition ~= self._currentPosition then
    self:UpdateView()
  end
end

function SingletonSlideFrame:OnEndDrag(args)
  self._dragDelta = 0
  if self._currentPosition == self._leftDragLimitLocalPosition then
    self._slideTask = Tween.new(self._sprintTime, {
      pos = self._currentPosition
    }, {
      pos = self._leftEdgeLocalPosition
    }, "linear")
  elseif self._currentPosition == self._rightDragLimitLocalPosition then
    self._slideTask = Tween.new(self._sprintTime, {
      pos = self._currentPosition
    }, {
      pos = self._rightEdgeLocalPosition
    }, "linear")
  else
    local speed
    if self._isVertical then
      local _, original = UIManager.ScreenPointToLocalPointInRectangle(self._window._uiObject, 0, 0)
      _, speed = UIManager.ScreenPointToLocalPointInRectangle(self._window._uiObject, self._moveSpeed.x, self._moveSpeed.y)
      speed = speed - original
    else
      local original, _ = UIManager.ScreenPointToLocalPointInRectangle(self._window._uiObject, 0, 0)
      speed, _ = UIManager.ScreenPointToLocalPointInRectangle(self._window._uiObject, self._moveSpeed.x, self._moveSpeed.y)
      speed = speed - original
    end
    if 0 < math.abs(speed) then
      local slideInertiaTime = self._slideInertiaTime
      local targetPos = self._currentPosition + speed
      if targetPos < self._leftDragLimitLocalPosition then
        targetPos = self._leftDragLimitLocalPosition
      elseif targetPos > self._rightDragLimitLocalPosition then
        targetPos = self._rightDragLimitLocalPosition
      end
      if targetPos < self._leftEdgeLocalPosition or targetPos > self._rightEdgeLocalPosition then
        slideInertiaTime = math.abs((targetPos - self._currentPosition) / speed / 20)
      end
      self._slideTask = Tween.new(slideInertiaTime, {
        pos = self._currentPosition
      }, {pos = targetPos}, "linear")
    elseif self._currentPosition < self._leftEdgeLocalPosition then
      self._slideTask = Tween.new(self._sprintTime, {
        pos = self._currentPosition
      }, {
        pos = self._leftEdgeLocalPosition
      }, "linear")
    elseif self._currentPosition > self._rightEdgeLocalPosition then
      self._slideTask = Tween.new(self._sprintTime, {
        pos = self._currentPosition
      }, {
        pos = self._rightEdgeLocalPosition
      }, "linear")
    end
  end
end

function SingletonSlideFrame:UpdateView()
  if self._isVertical then
    self._window:SetLocalPosition(self._local_posX, self._currentPosition, self._local_posZ)
  else
    self._window:SetLocalPosition(self._currentPosition, self._local_posY, self._local_posZ)
  end
end

function SingletonSlideFrame:OnUpdate(deltaTime)
  if self._slideTask then
    if self._slideTask:update(deltaTime) then
      self._currentPosition = self._slideTask.target.pos
      self._slideTask = nil
      if self._currentPosition < self._leftEdgeLocalPosition then
        self._slideTask = Tween.new(self._sprintTime, {
          pos = self._currentPosition
        }, {
          pos = self._leftEdgeLocalPosition
        }, "linear")
      elseif self._currentPosition > self._rightEdgeLocalPosition then
        self._slideTask = Tween.new(self._sprintTime, {
          pos = self._currentPosition
        }, {
          pos = self._rightEdgeLocalPosition
        }, "linear")
      end
    else
      self._currentPosition = self._slideTask.subject.pos
    end
    self:UpdateView()
  end
end

return SingletonSlideFrame
