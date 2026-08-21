local BeePlaneBulletCtrl = BaseClass("BeePlaneBulletCtrl")
local M = BeePlaneBulletCtrl


function M:Index()
    return self._index
end


function M:LocalPos()
    return self._view.transform.localPosition
end


function M:Min()
    return self._min
end


function M:Max()
    return self._max
end


function M:InitLocalPos(v3)
    self._localPos = v3
    self._movePos = {x = v3.x, y = self._maxY, z = v3.z}
    self:_SetLocalPos(v3)
    self:_BulletMove()
    self:SetActive(true)
end


function M:TweenPause()
    self._view:DoTweenPause()
end


function M:TweenPlay()
    self._view:DoTweenPlay()
end


function M:SetActive(b)
    self._view:SetActive(b)
end


function M:_SetLocalPos(v3)
    self._view:SetLocalPos(v3.x ,v3.y, v3.z)
end


function M:_BulletMove()
    local tween = self._view:SetDoLocalMove(self._movePos, self._bulletSleep, 6)
    tween.onUpdate = function ()
        self:_OnUpdataBullet()
    end 
end


function M:_OnUpdataBullet()
    self._localPos.y = self._view.transform.localPosition.y
    self._min.x = self._localPos.x - self._sizeHalf.x 
    self._min.y = self._localPos.y - self._sizeHalf.y 
    self._max.x = self._localPos.x + self._sizeHalf.x
    self._max.y = self._localPos.y + self._sizeHalf.y
end


function M:__init(view, index, sleep)
    self._name = view.gameObject.name 
    self._view = view
    self._index = index
    self._bulletSleep = sleep
    self._max = {x = 0, y = 0}
    self._min = {x = 0, y = 0}
    self._sizeHalf = {x = 13, y = 38}
    self._localPos = {x = 0, y = 0, z = 0}
    self._maxY = 750
end


function M:Clear()
    self:SetActive(false)
    self._view:DoTweenKill()
end


function M:Dispose()
    if self._view then
        self._view:DoTweenKill()
        self._view:Destory()
        self._view = nil
    end
    
    self._index = nil
    self._bulletSleep = nil
    self._max = nil
    self._min = nil
    self._sizeHalf = nil
    self._localPos = nil
    self._maxY = nil
end

return BeePlaneBulletCtrl
