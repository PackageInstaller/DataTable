---@class BombGameShip
---@field public x number
---@field public dir integer
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.RectTransform
---@field public animator SetSpineAnimation
---@field private _halfWidth number
---@field private _halfHeight number
local BombGameShip = class("BombGameShip")

local rightDirScale = Vector3.New(-1, 1, 1)
local leftDirScale = Vector3.New(1, 1, 1)

---@enum BombGameShipAnimNameEnum
local animNameEnum = {
    Idel = "idle",
    RunLeft = "run_left",
    RunLeftBomb = "run_left_bomb",
    Win = "win",
    Lose = "lose",
}

function BombGameShip:ctor(_, cfg, viewEntry)
    self._cfg = cfg
    self.x = cfg.shipStartX
    self.dir = 0
    self._halfWidth = cfg.shipHitHalfWidth or 53
    self._halfHeight = cfg.shipHitHalfHeight or 67
    self._offsetY = cfg.shipHitOffsetY or 0
    self.gameObject = nil
    self.transform = nil
    self.animator = nil
    self.animStateInfo = nil
    self._baseLocalPos = nil
    self._viewEntry = viewEntry
    self:_bindView(viewEntry)
    self._curAnim = nil
    self._isPlayingAttackAnim = false
end

function BombGameShip:_bindView(viewEntry)
    if not viewEntry or not viewEntry.transform then
        return
    end
    self._viewEntry = viewEntry
    ---@type UnityEngine.Transform
    self.transform = viewEntry.transform
    self.gameObject = viewEntry.roleObj.gameObject
    self._roleTransForm = viewEntry.roleObj.transform
    self._waterLine = viewEntry.waterLineObj
    self.animator = self.gameObject:GetComponent(TypeInfo.SetSpineAnimation)
    self.MinX = self._cfg.shipMinX + 100
    self.MaxX = self._cfg.shipMaxX - 100

    self._baseLocalPos = Vector3.New(0, self._cfg.waterSurfaceY, 0)
    self._waterLine.gameObject:SetActive(false)
    self:_refreshAnimatorState(animNameEnum.Idel)
    self:_syncView()
end

function BombGameShip:GetViewEntry()
    return self._viewEntry
end

function BombGameShip:SetX(value)
    self.x = value
    self:_syncView()
end

function BombGameShip:GetX()
    return self.x
end

---@return number, number, number, number, number, number
function BombGameShip:GetCollisionBox()
    local centerX = self.x
    local centerY = self._cfg.waterSurfaceY + (self._offsetY or 0)
    return centerX - self._halfWidth,
        centerX + self._halfWidth,
        centerY - self._halfHeight,
        centerY + self._halfHeight,
        centerX,
        centerY
end

function BombGameShip:SetDir(value)
    self.dir = value
    if self.dir == 1 then
        self.transform.localScale = rightDirScale
    elseif self.dir == -1 then
        self.transform.localScale = leftDirScale
    end
    self._waterLine.gameObject:SetActive(self.dir ~= 0)
    self:_refreshAnimatorState(self.dir == 0 and animNameEnum.Idel or animNameEnum.RunLeft)
end

function BombGameShip:GetDir()
    return self.dir
end

function BombGameShip:Stop()
    self.dir = 0
end

function BombGameShip:UpdateEntering(startX, targetX, ratio)
    self.x = startX + (targetX - startX) * ratio
    self:_syncView()
end

function BombGameShip:UpdateMove(dt, speedMul, isStunned)
    if isStunned or self.dir == 0 then
        return
    end

    self.x = self.x + self.dir * self._cfg.shipBaseSpeed * speedMul * dt
    if self.x <= self.MinX then
        self.x = self.MinX
        self.dir = 0
    elseif self.x >= self.MaxX then
        self.x = self.MaxX
        self.dir = 0
    end

    self:_syncView()
    self:_refreshAnimatorState(self.dir == 0 and animNameEnum.Idel or animNameEnum.RunLeft)
end

function BombGameShip:_syncView()
    if not self.transform or not self._baseLocalPos then
        return
    end
    self.transform.anchoredPosition3D = Vector3.New(self._baseLocalPos.x + self.x, self._baseLocalPos.y, self._baseLocalPos.z)
end

---@param animEnum BombGameShipAnimNameEnum
function BombGameShip:_refreshAnimatorState(animEnum)
    if not self.animator then
        return
    end
    ---如果当前动画是RunLeft，并且要切换的动画也是RunLeft，则不切换动画，避免重复设置动画导致的闪烁
    if self._curAnim == animNameEnum.RunLeft and animEnum == animNameEnum.RunLeft then
        return
    end
    if self._isPlayingAttackAnim then
        return
    end
    local isLoop = animEnum == animNameEnum.RunLeft
    local callBack = nil
    if animEnum == animNameEnum.RunLeftBomb then
        self._isPlayingAttackAnim = true
        callBack = function()
            self._curAnim = animNameEnum.RunLeftBomb
            self._isPlayingAttackAnim = false
        end
    else
        self._curAnim = animEnum
    end
    self.animator:SetAnimation(0, animEnum, isLoop, callBack)
end

function BombGameShip:PlayAttack()
    self:_refreshAnimatorState(animNameEnum.RunLeftBomb)
end

return BombGameShip