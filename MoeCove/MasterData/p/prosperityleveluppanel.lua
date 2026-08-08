---@class ProsperityLevelUpPanel : ProsperityLevelUpPanel_Generate
---##################### 【ProsperityLevelUpPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ProsperityLevelUpPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ProsperityLevelUpPanel = require "ProsperityLevelUpPanel_Generate"

function ProsperityLevelUpPanel:InitLogic(data)
    -- 升级展示动画分段时长（秒），按需求对外暴露便于调参
    self.fadeInDuration = 0.35
    self.holdDuration = 3
    self.fadeOutDuration = 0.25
    self.outDelayDuration = 2
    -- out 状态 speed=2、clip≈1s，实际约 0.5s；超时兜底略留余量
    self.outAnimFallbackDuration = 1
    -- 从打开界面起算，超时后强制关闭，避免动画异常时遮挡全屏 UI
    self.fallbackCloseDuration = 8
    self.fadeTween = nil
    self.autoCloseTween = nil
    self.outTimer = nil
    self.outAnimFallbackTimer = nil
    self.fallbackCloseTimer = nil
    self.playToken = 0
    self._isClosing = false
end

--function ProsperityLevelUpPanel:StartCreating(time)
--
--end

--function ProsperityLevelUpPanel:StartEnter(time)
--
--end

--function ProsperityLevelUpPanel:StartRemoving(time)
--
--end

--function ProsperityLevelUpPanel:StartExit(time)
--
--end

function ProsperityLevelUpPanel:OnOpen(data, initiative)
    self.playToken = (self.playToken or 0) + 1
    local token = self.playToken
    self._isClosing = false
    self:ClearAutoCloseTimers()

    local showLevel = self:GetDisplayLevel(data)
    if self.levelTxt and self.levelTxt.text then
        self.levelTxt.text.text = tostring(showLevel)
    end

    local fallbackDuration = tonumber(self.fallbackCloseDuration) or 8
    if fallbackDuration > 0 then
        self.fallbackCloseTimer = DLuaTimer:DoAfter(fallbackDuration, function()
            self.fallbackCloseTimer = nil
            self:TryClosePanel(token)
        end)
    end

    local outDelay = tonumber(self.outDelayDuration) or 2
    if outDelay < 0 then
        outDelay = 0
    end
    self.outTimer = DLuaTimer:DoAfter(outDelay, function()
        self.outTimer = nil
        self:PlayOutAndClose(token)
    end)
    -- self:PlayFadeAndAutoClose(self.playToken)
end

function ProsperityLevelUpPanel:OnClose(initiative)
    self:ClearAutoCloseTimers()
end

function ProsperityLevelUpPanel:ClearAutoCloseTimers()
    if self.outTimer then
        DLuaTimer:RemoveTimer(self.outTimer)
        self.outTimer = nil
    end
    if self.outAnimFallbackTimer then
        DLuaTimer:RemoveTimer(self.outAnimFallbackTimer)
        self.outAnimFallbackTimer = nil
    end
    if self.fallbackCloseTimer then
        DLuaTimer:RemoveTimer(self.fallbackCloseTimer)
        self.fallbackCloseTimer = nil
    end
end

---强制进入 out 并保证关闭回调可达：先挂回调，再 Play，再用超时兜底
---@param token integer
function ProsperityLevelUpPanel:PlayOutAndClose(token)
    if token ~= self.playToken or self._isClosing then
        return
    end

    local function onOutFinished()
        self:TryClosePanel(token)
    end

    -- 必须先挂回调，再切状态，避免首帧/末帧事件抢跑时 CallBack 仍为空
    if self.animOverCallBack then
        self.animOverCallBack:SetCallBack(onOutFinished)
    end

    if self.animator then
        self.animator.enabled = true
        -- 直接 Play 状态，绕过 Trigger + ExitTime 过渡，确保 out clip（含 AnimCallBack）一定开播
        self.animator:Play("out", 0, 0)
        self.animator:Update(0)
    end

    if self.outAnimFallbackTimer then
        DLuaTimer:RemoveTimer(self.outAnimFallbackTimer)
        self.outAnimFallbackTimer = nil
    end
    local fallback = tonumber(self.outAnimFallbackDuration) or 1
    if fallback < 0 then
        fallback = 0
    end
    self.outAnimFallbackTimer = DLuaTimer:DoAfter(fallback, function()
        self.outAnimFallbackTimer = nil
        onOutFinished()
    end)
end

---@param token integer
function ProsperityLevelUpPanel:TryClosePanel(token)
    if token ~= self.playToken or self._isClosing then
        return
    end
    self._isClosing = true
    self:ClearAutoCloseTimers()
    UIMgr:closeSpecificUI(self)
end

--function ProsperityLevelUpPanel:OnRefresh(data)
--
--end

---@param data table|nil
---@return integer
function ProsperityLevelUpPanel:GetDisplayLevel(data)
    if data then
        local level = tonumber(data.level or data.currentLevel or data.prosperityLevel)
        if level then
            return level
        end
    end

    local homeland = Me and Me:getHomeland()
    local info = homeland and homeland.prosperityInfo
    if info then
        return info.currentLevel or 0
    end
    return 1
end

-------------------------------暂时废弃------------------------------------------------

function ProsperityLevelUpPanel:KillFadeTween()
    if self.fadeTween then
        self.fadeTween:Kill()
        self.fadeTween = nil
    end
    if self.autoCloseTween then
        self.autoCloseTween:Kill()
        self.autoCloseTween = nil
    end
end

---@param token integer
function ProsperityLevelUpPanel:PlayFadeAndAutoClose(token)
    self:KillFadeTween()

    local inDuration = tonumber(self.fadeInDuration) or 0.35
    if inDuration < 0 then
        inDuration = 0
    end
    local holdDuration = tonumber(self.holdDuration) or 0.7
    if holdDuration < 0 then
        holdDuration = 0
    end
    local outDuration = tonumber(self.fadeOutDuration) or 0.3
    if outDuration < 0 then
        outDuration = 0
    end
    local totalDuration = inDuration + holdDuration + outDuration

    -- 关闭与动画解耦，避免 OnComplete 因时序问题不触发导致面板残留
    self.autoCloseTween = DG.Tweening.DOVirtual.DelayedCall(totalDuration, function()
        self.autoCloseTween = nil
        if token ~= self.playToken then
            return
        end
        self:KillFadeTween()
        UIMgr:closeSpecificUI(self)
    end):SetUpdate(true)

    local cg = self.bg and self.bg.canvasGroup
    if cg then
        cg.alpha = 0
        self.fadeTween = DG.Tweening.DOTween.Sequence()
        self.fadeTween:SetUpdate(true)
        self.fadeTween:Append(cg:DOFade(1, inDuration):SetEase(DG.Tweening.Ease.OutCubic))
        self.fadeTween:AppendInterval(holdDuration)
        self.fadeTween:Append(cg:DOFade(0, outDuration):SetEase(DG.Tweening.Ease.Linear))
        self.fadeTween:OnComplete(function()
            self.fadeTween = nil
        end)
    else
        self.fadeTween = DG.Tweening.DOVirtual.DelayedCall(totalDuration, function()
            self.fadeTween = nil
        end):SetUpdate(true)
    end
end

return ProsperityLevelUpPanel
