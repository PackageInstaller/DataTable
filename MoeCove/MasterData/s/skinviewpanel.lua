---@class SkinViewPanel : SkinViewPanel_Generate
---##################### 【SkinViewPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SkinViewPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SkinViewPanel = require "SkinViewPanel_Generate"

local MIN_SCALE = 0.5
local MAX_SCALE = 2.0
-- 双指距离过小时忽略，避免两指叠在一起时比例爆炸
local MIN_PINCH_DISTANCE = 20
-- 滚轮缩放平滑时间（触摸仍跟手，不做额外阻尼）
local WHEEL_SMOOTH_TIME = 0.05
-- 拖拽中 slider 同步节流，减少无意义的 UI 刷新
local SLIDER_SYNC_INTERVAL = 0.03

function SkinViewPanel:InitLogic(data)
    self.currentScale = 1
    self.velocity = Vector2(0, 0)
    self.nowShowSpineObj = nil

    self.targetScale = 1
    self.scaleVelocity = 0

    self.dragParentRect = nil
    self.contentRect = nil
    self.roleScrollRect = nil
    self.isPinching = false
    self.waitAllTouchReleaseAfterPinch = false
    self.prevPinchMidScreen = Vector2.zero
    self.prevPinchDistance = 0
    self._lastSliderSyncTime = 0
    -- 代码同步 slider 显示时置 true，防止 onValueChanged 回调反向覆盖驱动值
    self.isSliderSyncingFromCode = false
end

--function SkinViewPanel:StartCreating(time)
--
--end

--function SkinViewPanel:StartEnter(time)
--
--end

--function SkinViewPanel:StartRemoving(time)
--
--end

--function SkinViewPanel:StartExit(time)
--
--end

function SkinViewPanel:OnOpen(data, initiative)
    self.currentScale = 1
    self.targetScale = 1
    self.scaleVelocity = 0
    self.velocity = Vector2(0, 0)
    self.contentRect = self.posPoint.rectTransform
    self.dragParentRect = self.contentRect.parent
    self.roleScrollRect = self.roleView:GetComponent(TypeInfo.ScrollRect)
    if self.roleScrollRect then
        self.roleScrollRect.enabled = true
        self.roleScrollRect.inertia = false
        self.roleScrollRect.decelerationRate = 0.03
        self.roleScrollRect.velocity = Vector2.zero
    end
    self.isPinching = false
    self.waitAllTouchReleaseAfterPinch = false
    self.prevPinchMidScreen = Vector2.zero
    self.prevPinchDistance = 0
    self._lastSliderSyncTime = 0
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.SkinView, self)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        --清空返回方法
        self.customBackPanel.customBackPanel:ClearBackFunc()
        UIMgr:closeSpecificUI(self)
    end)
    self.roleId = data.roleID
    self.skinId = data.skinId
    self.skinConfig = Config.GetCharacterSkinInfo(self.skinId)
    self:SetView()
end

function SkinViewPanel:SetView()
    self:SyncSliderDisplay(self.currentScale)
    self.targetScale = self.currentScale
    self.scaleVelocity = 0
    local skinConfig = self.skinConfig
    UICommonUtils:ShowRolePicOrSpine(self, self.showCharacter, self.skinId, function(spineObject)
        if UICommonUtils.Checkobj(self.nowShowSpineObj) then
             GameObject.Destroy(self.nowShowSpineObj)
        end
        self.nowShowSpineObj = spineObject
    end)
    -- 根据皮肤类型选择正确的初始偏移，避免两次赋值互相覆盖
    local offsetY
    if skinConfig.spineKey and skinConfig.spineKey ~= "" then
        offsetY = skinConfig.spineOffset[2]
    else
        offsetY = skinConfig.imgOffset[2]
    end
    self.showCharacter.rectTransform.anchoredPosition = Vector2(0, offsetY)
end

function SkinViewPanel:SetScrollRectEnabled(enabled)
    if not self.roleScrollRect then
        return
    end
    self.roleScrollRect.velocity = Vector2.zero
    self.roleScrollRect.enabled = enabled
end

function SkinViewPanel:ClampScale(value)
    if value < MIN_SCALE then
        return MIN_SCALE
    elseif value > MAX_SCALE then
        return MAX_SCALE
    end
    return value
end

--- 以屏幕点为缩放中心，调整 content 位置，使双指下的画面不漂移
function SkinViewPanel:ApplyScaleAroundScreenPoint(newScale, screenPos)
    local content = self.contentRect
    local parentRect = self.dragParentRect
    if not content or not parentRect then
        self.currentScale = newScale
        self.targetScale = newScale
        self.scaleVelocity = 0
        self:SetPosterSize(newScale)
        return
    end

    local oldScale = self.currentScale
    if oldScale < 0.0001 then
        oldScale = 0.0001
    end
    local ratio = newScale / oldScale
    if math.abs(ratio - 1) < 0.00001 then
        return
    end

    local uiCamera = UIMgr.uiCamera
    local midParent = UICommonUtils.ScreenToUILocalPos(parentRect, uiCamera, screenPos)
    local contentPos = content.anchoredPosition
    -- 缩放前后保持 pinch 中心对应的画面点不动：
    -- newPos = mid - (mid - oldPos) * ratio
    local newPos = Vector2(
        midParent.x - (midParent.x - contentPos.x) * ratio,
        midParent.y - (midParent.y - contentPos.y) * ratio
    )

    self.currentScale = newScale
    self.targetScale = newScale
    self.scaleVelocity = 0
    self:SetPosterSize(newScale)
    content.anchoredPosition = newPos
end

function SkinViewPanel:SyncSliderDisplayThrottled(value, force)
    local now = Time.unscaledTime
    if not force and (now - self._lastSliderSyncTime) < SLIDER_SYNC_INTERVAL then
        return
    end
    self._lastSliderSyncTime = now
    self:SyncSliderDisplay(value)
end

function SkinViewPanel:Update()
    local touchCount = Input.touchCount

    -- 无触摸：滚轮缩放交给平滑；单指拖拽仍由 ScrollRect 接管
    if touchCount == 0 then
        self.isPinching = false
        self.waitAllTouchReleaseAfterPinch = false
        self:SetScrollRectEnabled(true)

        local scrollDelta = Input.GetAxis("Mouse ScrollWheel")
        if scrollDelta ~= 0 then
            local mousePos = Input.mousePosition
            -- 滚轮也尽量绕鼠标位置缩放，手感更接近双指
            local desired = self:ClampScale(self.targetScale + scrollDelta * 3.0)
            self.targetScale = desired
            self.velocity = Vector2.zero
            -- 先记下目标，下方 SmoothDamp 再应用；记录鼠标供插值过程绕点缩放
            self._wheelPivotScreen = Vector2(mousePos.x, mousePos.y)
            self._wheelUsePivot = true
        end

        if math.abs(self.targetScale - self.currentScale) > 0.0005 or math.abs(self.scaleVelocity) > 0.0005 then
            local nextScale, nextVel = self:SmoothDamp(self.currentScale, self.targetScale, self.scaleVelocity, WHEEL_SMOOTH_TIME)
            self.scaleVelocity = nextVel
            if self._wheelUsePivot and self._wheelPivotScreen then
                self:ApplyScaleAroundScreenPoint(nextScale, self._wheelPivotScreen)
            else
                self.currentScale = nextScale
                self:SetPosterSize(nextScale)
            end
            if math.abs(self.targetScale - self.currentScale) <= 0.0005 and math.abs(self.scaleVelocity) <= 0.0005 then
                self.currentScale = self.targetScale
                self.scaleVelocity = 0
                self._wheelUsePivot = false
                self:SetPosterSize(self.currentScale)
                self:SyncSliderDisplay(self.currentScale)
            else
                self:SyncSliderDisplayThrottled(self.currentScale, false)
            end
        end
        return
    end

    -- 有触摸时停止滚轮阻尼，避免和手指抢
    self.scaleVelocity = 0
    self._wheelUsePivot = false

    -- 单指：双指结束后等全部抬手再交还 ScrollRect，避免残留指针导致跳动
    if touchCount == 1 then
        if self.isPinching then
            self.isPinching = false
            self.waitAllTouchReleaseAfterPinch = true
            self:SyncSliderDisplay(self.currentScale)
        end
        if self.waitAllTouchReleaseAfterPinch then
            self:SetScrollRectEnabled(false)
            return
        end
        self:SetScrollRectEnabled(true)
        return
    end

    -- 双指及以上：禁用 ScrollRect，自管缩放 + 平移
    self:SetScrollRectEnabled(false)
    local touch1 = Input.GetTouch(0)
    local touch2 = Input.GetTouch(1)

    -- 任一指结束：结束捏合，等全部抬手
    if touch1.phase == TouchPhase.Ended or touch1.phase == TouchPhase.Cancelled or
        touch2.phase == TouchPhase.Ended or touch2.phase == TouchPhase.Cancelled then
        if self.isPinching then
            self:SyncSliderDisplay(self.currentScale)
        end
        self.isPinching = false
        self.waitAllTouchReleaseAfterPinch = true
        return
    end

    local currMidScreen = (touch1.position + touch2.position) * 0.5
    local currDistance = (touch1.position - touch2.position).magnitude

    -- 新双指开始 / 有新指按下：只采样，不立刻缩放，避免相位切换跳变
    if (not self.isPinching) or touch1.phase == TouchPhase.Began or touch2.phase == TouchPhase.Began then
        self.isPinching = true
        self.waitAllTouchReleaseAfterPinch = true
        self.prevPinchMidScreen = currMidScreen
        self.prevPinchDistance = currDistance
        return
    end

    -- 缩放：直接跟手，绕双指中心缩放（去掉旧的每帧比例硬钳制，那是不流畅的主因）
    if self.prevPinchDistance >= MIN_PINCH_DISTANCE and currDistance >= MIN_PINCH_DISTANCE then
        local scaleDelta = currDistance / self.prevPinchDistance
        -- 仅做极轻度的异常帧保护（手指采样毛刺），正常捏合不会触发
        if scaleDelta > 0.7 and scaleDelta < 1.4 then
            local newScale = self:ClampScale(self.currentScale * scaleDelta)
            self:ApplyScaleAroundScreenPoint(newScale, currMidScreen)
            self:SyncSliderDisplayThrottled(newScale, false)
        end
    end

    -- 平移：双指中心在父节点本地空间的位移
    if self.dragParentRect and self.contentRect then
        local uiCamera = UIMgr.uiCamera
        local prevUI = UICommonUtils.ScreenToUILocalPos(self.dragParentRect, uiCamera, self.prevPinchMidScreen)
        local currUI = UICommonUtils.ScreenToUILocalPos(self.dragParentRect, uiCamera, currMidScreen)
        local dx = currUI.x - prevUI.x
        local dy = currUI.y - prevUI.y
        if (dx * dx + dy * dy) > 0.01 then
            local curPos = self.contentRect.anchoredPosition
            self.contentRect.anchoredPosition = Vector2(curPos.x + dx, curPos.y + dy)
        end
    end

    self.prevPinchMidScreen = currMidScreen
    self.prevPinchDistance = currDistance
end

-- 阻尼弹簧算法（主要用于鼠标滚轮）
function SkinViewPanel:SmoothDamp(current, target, currentVelocity, smoothTime)
    local T = Time.unscaledDeltaTime
    if T <= 0 then
        T = 0.016
    end
    smoothTime = math.max(0.0001, smoothTime)
    local omega = 2 / smoothTime
    local x = omega * T
    local exp = 1 / (1 + x + 0.48 * x * x + 0.235 * x * x * x)
    local change = current - target
    local originalTo = target
    local maxChange = 10000 * T
    change = math.max(math.min(change, maxChange), -maxChange)
    target = current - change
    local temp = (currentVelocity + omega * change) * T
    currentVelocity = (currentVelocity - omega * temp) * exp
    local output = target + (change + temp) * exp
    if (originalTo - current > 0) == (output > originalTo) then
        output = originalTo
        currentVelocity = (output - originalTo) / T
    end
    return output, currentVelocity
end

function SkinViewPanel:SetPosterSize(value)
    local skinConfig = self.skinConfig
    if not skinConfig then
        return
    end
    self.size = value
    local content = self.contentRect or self.posPoint.rectTransform
    local targetSize
    if self.size >= 1 then
        targetSize = Vector2.New(5000 * value, 3000 * value)
    else
        targetSize = Vector2.New(5000, 3000)
    end
    -- 避免每帧无意义写入触发 Canvas 重建
    local curSize = content.sizeDelta
    if math.abs(curSize.x - targetSize.x) > 0.5 or math.abs(curSize.y - targetSize.y) > 0.5 then
        content.sizeDelta = targetSize
    end

    local needRate
    if skinConfig.spineKey and skinConfig.spineKey ~= "" then
        needRate = skinConfig.spineRate
    else
        needRate = skinConfig.imgRateF
    end
    self.showCharacter.rectTransform.localScale = Vector2.New(needRate * self.size, needRate * self.size)
end

-- 仅同步 slider 显示，不触发回调里的驱动逻辑
function SkinViewPanel:SyncSliderDisplay(value)
    self.isSliderSyncingFromCode = true
    self.sizeSlider.slider.value = value
    self.isSliderSyncingFromCode = false
end

--function SkinViewPanel:OnClose(initiative)
--
--end

--function SkinViewPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SkinViewPanel:OnRefresh(data)
--
--end

--[[
/SliderPanel/SizeSlider onValueChanged 
--]]
function SkinViewPanel:sizeSlider_Slider_onValueChanged(sizeSlider,value)
    -- 代码同步显示时忽略，只响应用户手动拖动
    if self.isSliderSyncingFromCode then
        return
    end
    self.currentScale = value
    self.targetScale = value
    self.scaleVelocity = 0
    self:SetPosterSize(value)
end

--[[
/CustomBackPanel/Bg/BackMainlBtn onClick 
--]]
function SkinViewPanel:backMainlBtn_ScaleButton_onClick(backMainlBtn)

end

--[[
/CustomBackPanel/Bg/HelpBtn onClick 
--]]
function SkinViewPanel:helpBtn_ScaleButton_onClick(helpBtn)

end

return SkinViewPanel
