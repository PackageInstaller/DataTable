---@class BombGameFish:BaseClass
---@field public id string
---@field public x number
---@field public y number
---@field public layerIndex integer
---@field public dir integer
---@field public hp integer
---@field public maxHp integer
---@field public speed number
---@field public radius number
---@field public fishIconId integer
---@field public score integer
---@field public dropChance number
---@field public respawnDelay number
---@field public state string
---@field public sprint table
---@field public attack table
---@field public moveMode string
---@field public moveTargetY number
---@field public moveDirX integer
---@field public moveTargetX number
---@field public explodeOnDeath boolean
---@field public explodeRadius number
---@field public timer number
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.RectTransform
---@field public animator any
---@field private _myImage any
---@field private _halfWidth number
---@field private _halfHeight number
---@field private _hitTween any
---@field private _deathTween any
local BombGameFish = class("BombGameFish")


local hitFlashAlpha = 0.35
local hitFlashDuration = 0.08
local hitFlashLoopCount = 4
local deathFlashAlpha = 0.2
local deathFlashStepDuration = 0.12
local deathFlashLeadGap = 0.18
local deathFlashGapDuration = 0.32
local deathFlashEndGap = 0.46
local deathFlashTotalDuration = 2

---@param cfg BombGamePanel._cfg
function BombGameFish:ctor(_, data, cfg, viewEntry)
    self._cfg = cfg
    for key, value in pairs(data) do
        self[key] = value
    end
    self.timer = self.timer or 0
    self.gameObject = nil
    self.transform = nil
    self.animator = nil
    self.animStateInfo = nil
    self._baseLocalPos = nil
    self._viewEntry = viewEntry
    self._hitTween = nil
    self._deathTween = nil
    self._myImage = nil
    local fishScale = data.fishScale or {1, 1, 1}
    self._leftDir = Vector3.New(fishScale[1], fishScale[2], fishScale[3])
    self._rightDir = Vector3.New(-fishScale[1], fishScale[2], fishScale[3])
    self._downDir = Vector3.New(fishScale[1], -fishScale[2], fishScale[3])
    self._halfWidth = data.halfWidth or data.radius or 0
    self._halfHeight = data.halfHeight or self._halfWidth
    self:_bindView(viewEntry)
end

function BombGameFish:_bindView(viewEntry)
    if not viewEntry or not viewEntry.transform then
        return
    end
    self._viewEntry = viewEntry
    self.transform = viewEntry.transform
    self.gameObject = self.transform.gameObject
    -- self.animator = self.gameObject:GetComponent(TypeInfo.Animator)
    self._baseLocalPos = Vector3.New(self.x, self.y, 0)
    self.transform.localScale = self.dir == 1 and self._rightDir or self._leftDir
    self:_stopImageTweens()
    
    local imageTransform = self.transform:Find("FishImage")
    self._myImage = imageTransform and imageTransform:GetComponent(TypeInfo.Image) or nil
    self:_setImageAlpha(1)
    self:_syncView()
    self:_refreshAnimatorState()
end

function BombGameFish:SetImageSprite(sprite)
    if self._myImage then
        self._myImage.sprite = sprite
        self._myImage:SetNativeSize()
        local size = self._myImage.rectTransform.sizeDelta
        self._halfWidth = ((size.x - 10) / 2) * self.fishScale[1]
        self._halfHeight = ((size.y - 10) / 2) * self.fishScale[2]
    end
end

function BombGameFish:GetViewEntry()
    return self._viewEntry
end

---@return number, number, number, number, number, number
function BombGameFish:GetCollisionBox()
    local centerX = self.x
    local centerY = self.y
    return centerX - self._halfWidth,
        centerX + self._halfWidth,
        centerY - self._halfHeight,
        centerY + self._halfHeight,
        centerX,
        centerY
end

function BombGameFish:IsAlive()
    return self.state == "alive"
end

function BombGameFish:IsRemoved()
    return self.state == "removed"
end

function BombGameFish:Update(dt)
    if self.state == "alive" then
        self:_updateMovement(dt)
    elseif self.state == "dying" then
        self.timer = self.timer - dt
        if self.timer <= 0 then
            self.state = "removed"
            self:_stopImageTweens()
        end
    end
    self:_syncView()
    self:_refreshAnimatorState()
end

function BombGameFish:_updateMovement(dt)
    local speed = self.speed
    if self.sprint then
        self.sprint.left = self.sprint.left - dt
        if self.sprint.activeLeft > 0 then
            self.sprint.activeLeft = self.sprint.activeLeft - dt
            speed = speed * self.sprint.speedMul
        elseif self.sprint.left <= 0 then
            self.sprint.left = self.sprint.cooldown
            self.sprint.activeLeft = self.sprint.duration
        end
    end

    if self.moveMode == "rush_track_burst" then
        local fishMinX = self._cfg.fishMinX or -1000
        local fishMaxX = self._cfg.fishMaxX or 1000
        local offscreenPadding = self._cfg.rushOffscreenPadding or 220
        local minX = fishMinX - offscreenPadding
        local maxX = fishMaxX + offscreenPadding
        local approachSpeed = self._cfg.rushApproachSpeed or (speed * 1.9)
        local pauseDuration = self._cfg.rushPauseDuration or 0.8
        local aimTolerance = self._cfg.rushAimTolerance or 15

        self.moveOriginDir = self.moveOriginDir or self.dir or 1
        self.rushPhase = self.rushPhase or "entering"

        if self.rushPhase == "entering" then
            self.x = self.x + self.moveOriginDir * speed * dt
            if self.transform then
                self.transform.localScale = self.moveOriginDir >= 0 and self._rightDir or self._leftDir
            end
            if self.x >= fishMinX and self.x <= fishMaxX then
                self.rushPhase = "approach"
            end
            return
        elseif self.rushPhase == "approach" then
            local targetX = self.moveTargetX or self.x
            local deltaX = targetX - self.x
            if math.abs(deltaX) <= aimTolerance then
                self.rushPhase = "pause"
                self.rushPhaseLeft = pauseDuration
            else
                local dirX = deltaX > 0 and 1 or -1
                local moveStep = math.min(math.abs(deltaX), approachSpeed * dt)
                self.x = self.x + dirX * moveStep
                if self.transform then
                    self.transform.localScale = dirX >= 0 and self._rightDir or self._leftDir
                end
            end
            return
        elseif self.rushPhase == "pause" then
            self.rushPhaseLeft = (self.rushPhaseLeft or pauseDuration) - dt
            if self.rushPhaseLeft <= 0 then
                self.pendingAttackBurst = self._cfg.rushBurstCount or 3
                self.rushPhase = "exit"
                self.dir = self.moveOriginDir
                if self.transform then
                    self.transform.localScale = self.moveOriginDir >= 0 and self._rightDir or self._leftDir
                end
            end
            return
        end

        self.x = self.x + (self.moveOriginDir or self.dir or 1) * speed * dt
        if self.transform then
            local lookDir = self.moveOriginDir or self.dir or 1
            self.transform.localScale = lookDir >= 0 and self._rightDir or self._leftDir
        end
        if self.x <= minX then
            self.x = minX
            self.moveOriginDir = 1
            self.dir = 1
            self.rushPhase = "entering"
        elseif self.x >= maxX then
            self.x = maxX
            self.moveOriginDir = -1
            self.dir = -1
            self.rushPhase = "entering"
        end
        return
    end

    if self.moveMode == "rise_diagonal" then
        local targetY = self.moveTargetY or 0
        if self.y >= targetY then
            self.y = targetY
            return
        end

        self.movePhase = self.movePhase or "moving"
        self.movePhaseLeft = self.movePhaseLeft or (self._cfg.riseMoveDuration or 1)

        self.movePhaseLeft = self.movePhaseLeft - dt
        if self.movePhase == "paused" then
            if self.movePhaseLeft <= 0 then
                local targetX = self.moveTargetX or self.x
                self.moveDirX = targetX >= self.x and 1 or -1
                self.movePhase = "moving"
                self.movePhaseLeft = self._cfg.riseMoveDuration or 1
                if self.transform then
                    self.transform.localScale = (self.moveDirX or 1) >= 0 and self._rightDir or self._leftDir
                end
            end
            return
        end

        local realMove = speed * dt
        self.y = math.min(targetY, self.y + realMove)
        self.x = self.x + (self.moveDirX or 1) * realMove

        if self.transform then
            self.transform.localScale = (self.moveDirX or 1) >= 0 and self._rightDir or self._leftDir
        end
        if self.movePhaseLeft <= 0 and self.y < targetY then
            self.movePhase = "paused"
            self.movePhaseLeft = self._cfg.risePauseDuration or 0.8
        end
        return
    end

    self.x = self.x + self.dir * speed * dt
    local minX = self._cfg.fishMinX - 450
    local maxX = self._cfg.fishMaxX + 450
    if self.x <= minX then
        self.x = minX
        self.dir = 1
        self.transform.localScale = self._rightDir
    elseif self.x >= maxX then
        self.x = maxX
        self.dir = -1
        self.transform.localScale = self._leftDir
    end
end

function BombGameFish:TakeDamage(damage)
    self.hp = math.floor(self.hp - damage)
    self:_playHitTween()
    return self.hp <= 0
end

function BombGameFish:SetDying(duration)
    if self.state ~= "alive" then
        return
    end
    self.state = "dying"
    self.timer = math.max(duration or 0, deathFlashTotalDuration)
    self:_playDeathTween()
    self.transform.localScale = self._downDir
    self:_refreshAnimatorState()
end

function BombGameFish:_syncView()
    if not self.transform or not self._baseLocalPos or self.state == "removed" then
        return
    end
    self.transform.anchoredPosition3D = Vector3.New(self.x, self.y, self._baseLocalPos.z)
end

function BombGameFish:_hideView()
    if self.gameObject then
        self.gameObject:SetActive(false)
    end
end

function BombGameFish:_setImageAlpha(alpha)
    if not self._myImage then
        return
    end
    ---@type any
    local color = self._myImage.color
    color.a = alpha
    self._myImage.color = color
end

function BombGameFish:_stopImageTweens()
    if self._myImage then
        self._myImage:DOKill(false)
    end
    self._hitTween = nil
    self._deathTween = nil
    self:_setImageAlpha(1)
end

function BombGameFish:_playHitTween()
    if not self._myImage or self.state ~= "alive" then
        return
    end
    self:_stopImageTweens()
    ---@type any
    local tween = self._myImage:DOFade(hitFlashAlpha, hitFlashDuration)
    self._hitTween = tween
    tween:SetEase(DG.Tweening.Ease.InOutSine)
    tween
        :SetLoops(hitFlashLoopCount, DG.Tweening.LoopType.Yoyo)
        :OnComplete(function()
            self._hitTween = nil
            self:_setImageAlpha(1)
        end)
end

function BombGameFish:_playDeathTween()
    if not self._myImage then
        return
    end
    self:_stopImageTweens()

    ---@type any
    local sequence = DOTween.Sequence()
    sequence:AppendInterval(deathFlashLeadGap)
    for index = 1, 2 do
        ---@type any
        local fadeOutTween = self._myImage:DOFade(deathFlashAlpha, deathFlashStepDuration)
        fadeOutTween:SetEase(DG.Tweening.Ease.InOutSine)
        sequence:Append(fadeOutTween)
        ---@type any
        local fadeInTween = self._myImage:DOFade(1, deathFlashStepDuration)
        fadeInTween:SetEase(DG.Tweening.Ease.InOutSine)
        sequence:Append(fadeInTween)
        if index < 3 then
            sequence:AppendInterval(deathFlashGapDuration)
        end
    end
    sequence:AppendInterval(deathFlashEndGap)
    self._deathTween = sequence:OnComplete(function()
        self._deathTween = nil
        self:_setImageAlpha(1)
        if self.state == "dying" then
            self.timer = 0
            self.state = "removed"
        end
    end)
end

function BombGameFish:_refreshAnimatorState()
    if not self.animator then
        return
    end
    self.animStateInfo = self.animator:GetCurrentAnimatorStateInfo(0)
end

return BombGameFish