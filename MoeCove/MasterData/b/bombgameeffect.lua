---@class BombGameEffect
---@field public id string
---@field public isBuff boolean
---@field public duration number
---@field public x number
---@field public y number
---@field public state string
---@field public timer number
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.RectTransform
---@field public animator any
local BombGameEffect = class("BombGameEffect")

function BombGameEffect:ctor(_, data, cfg, viewEntry)
    self._cfg = cfg
    self.id = data.id
    self.isBuff = data.isBuff == true
    self.duration = data.duration or 0
    self.x = data.x or 0
    self.y = data.y or 0
    self.state = data.state or "rising"
    self.timer = data.timer or 0
    self.gameObject = nil
    self.transform = nil
    self.animator = nil
    self.animStateInfo = nil
    self._baseLocalPos = nil
    self._viewEntry = viewEntry
    self._surfaceBaseY = cfg.waterSurfaceY
    self._surfaceFloatTimer = data.surfaceFloatTimer or math.random() * math.pi * 2
    self:_bindView(viewEntry)
end

function BombGameEffect:_bindView(viewEntry)
    if not viewEntry or not viewEntry.transform then
        return
    end
    self._viewEntry = viewEntry
    self.transform = viewEntry.transform
    self.gameObject = self.transform.gameObject
    self.animator = self.gameObject:GetComponent(TypeInfo.Animator)
    self:_syncView()
    self:_refreshAnimatorState()
end

function BombGameEffect:GetViewEntry()
    return self._viewEntry
end

function BombGameEffect:Update(dt)
    if self.state == "rising" then
        self.y = math.min(self._surfaceBaseY, self.y + self._cfg.dropRiseSpeed * dt)
        if self.y >= self._surfaceBaseY then
            self.y = self._surfaceBaseY
            self.state = "surface"
            self.timer = self._cfg.maxDropStayTime
        end
    elseif self.state == "surface" then
        self.timer = self.timer - dt
        self._surfaceFloatTimer = self._surfaceFloatTimer + dt * (self._cfg.dropFloatSpeed or 1)
        self.y = self._surfaceBaseY + math.sin(self._surfaceFloatTimer) * (self._cfg.dropFloatAmplitude or 0)
    end
    self:_syncView()
    self:_refreshAnimatorState()
end

function BombGameEffect:IsExpired()
    return self.state == "surface" and self.timer <= 0
end

function BombGameEffect:IsSurface()
    return self.state == "surface"
end

function BombGameEffect:_syncView()
    if not self.transform then
        return
    end
    self.transform.anchoredPosition3D = Vector3.New(self.x, self.y, 0)
end

function BombGameEffect:_refreshAnimatorState()
    if not self.animator then
        return
    end
    self.animStateInfo = self.animator:GetCurrentAnimatorStateInfo(0)
end

return BombGameEffect