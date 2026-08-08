---@class BombGameBomb
---@field public x number
---@field public y number
---@field public speed number
---@field public alive boolean
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.RectTransform
---@field public animator any
---@field private _halfWidth number
---@field private _halfHeight number
local BombGameBomb = class("BombGameBomb")

function BombGameBomb:ctor(_, data, viewEntry)
    self.data = data
    self.gameObject = nil
    self.transform = nil
    self.animator = nil
    self.animStateInfo = nil
    self._baseLocalPos = nil
    self._viewEntry = viewEntry
    self._halfWidth = data.halfWidth or 0
    self._halfHeight = data.halfHeight or self._halfWidth
    self.x = 0
    self.y = 0
    self.alive = true
    self:_bindView(viewEntry)
end

function BombGameBomb:_bindView(viewEntry)
    if not viewEntry or not viewEntry.transform then
        return
    end
    self._viewEntry = viewEntry
    self.transform = viewEntry.transform
    self.gameObject = self.transform.gameObject
    self.animator = self.gameObject:GetComponent(TypeInfo.Animator)
    self._baseLocalPos = Vector3.New(self.data.x, self.data.y, 0)
    self:_syncView()
    self:_refreshAnimatorState()
end

function BombGameBomb:GetViewEntry()
    return self._viewEntry
end

---@return number, number, number, number, number, number
function BombGameBomb:GetCollisionBox()
    local basePos = self._baseLocalPos
    local baseX = basePos and basePos.x or 0
    local baseY = basePos and basePos.y or 0
    local centerX = baseX + self.x
    local centerY = baseY + self.y
    return centerX - self._halfWidth,
        centerX + self._halfWidth,
        centerY - self._halfHeight,
        centerY + self._halfHeight,
        centerX,
        centerY
end

function BombGameBomb:Update(dt)
    if not self.alive then
        return
    end
    self.y = self.y - self.data.speed * dt
    self:_syncView()
    self:_refreshAnimatorState()
end

function BombGameBomb:Kill()
    self.alive = false
    self:_refreshAnimatorState()
end

function BombGameBomb:_syncView()
    if not self.transform or not self._baseLocalPos or not self.alive then
        return
    end
    self.transform.anchoredPosition3D = Vector3.New(self._baseLocalPos.x + self.x, self._baseLocalPos.y + self.y, self._baseLocalPos.z)
end

function BombGameBomb:_refreshAnimatorState()
    if not self.animator then
        return
    end
    self.animStateInfo = self.animator:GetCurrentAnimatorStateInfo(0)
end

return BombGameBomb