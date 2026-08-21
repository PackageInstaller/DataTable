local BeePlaneCtrl = BaseClass("BeePlaneCtrl")
local M = BeePlaneCtrl

function M:LocalPos()
    return self._view.transform.localPosition
end

function M:Min()
    return self._min
end

function M:Max()
    return self._max
end

function M:PlaneMove(pos, bg)
    local state = self:_State(pos)
    self:_PlayAni(state, bg)

    if (state == 'Idle') then
        return
    end

    local factor = state == 'Left' and -1 or 1
    self._localPos.x = self._localPos.x + self._moveSleep * factor * Time.deltaTime
    self._localPos.x = math.min(self._localPos.x, self._limit)
    self._localPos.x = math.max(self._localPos.x, -self._limit)
    self:_SetLocalPos(self._localPos)
    self:_OnUpdataData()
end

function M:Reset(sleep, maxX)
    self._limit = maxX
    self._moveSleep = sleep
    self._localPos = self._resetPos
    self._view:SetLocalPos(self._localPos.x, self._localPos.y, self._localPos.z)
    self:_OnUpdataData()
end

function M:_State(pos)
    if pos > self._localPos.x + 1 then
        return 'Right'
    end

    if pos < self._localPos.x - 1 then
        return 'Left'
    end

    return 'Idle'
end

function M:_PlayAni(type, bg)
    if type == 'Idle' then

    end

    if type == 'Left' then
        self._animator:Play(type)
        bg:Play(type)
    end

    if type == 'Right' then
        self._animator:Play(type)
        bg:Play(type)
    end
end

function M:_SetLocalPos(v3)
    self._view:SetLocalPos(v3.x, v3.y, v3.z)
end

function M:_OnUpdataData()
    self._min.x = self._localPos.x - self._sizeHalf.x
    self._min.y = self._localPos.y - self._sizeHalf.y
    self._max.x = self._localPos.x + self._sizeHalf.x
    self._max.y = self._localPos.y + self._sizeHalf.y
end

function M:_OnDisposeBullet(index)
    table.remove(self._bullet, index)
end

function M:__init(view)
    self._view = view
    self._animator = self._view.transform:GetAnimator()
    self._moveSleep = 0
    self._resetPos = { x = 0, y = -300, z = 0 }
    self._sizeHalf = { x = 28, y = 30 }
    self._localPos = {}
    self._max = { x = 0, y = 0 }
    self._min = { x = 0, y = 0 }
end

function M:Clear()
    if self._view then
        self._view:Destory()
        self._view = nil
    end
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return BeePlaneCtrl
