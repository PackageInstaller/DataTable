local StoryInteractUICtrl = BaseClass("StoryInteractUICtrl", BaseUICtrl)
local M = StoryInteractUICtrl

local Time = CS.UnityEngine.Time

function M:Init()
    self._wipeTween = nil
    self._powerTween = nil

    self._view.sliderWipe:onClickPointerDown(Bind(self, self.OnWipePointerDown))
    self._view.rectPress:onClickPointerDown(Bind(self, self.OnPressPointerDown))

    self._view.sliderWipe:onUp(Bind(self, self.OnWipeUp))
    self._view.rectPress:onUp(Bind(self, self.OnPressUp))

    self._view.rectPress:onLongPress(Bind(self, self.OnPressLongPress))
    self._view.rectPress:SetLongPressTimes(0.02)

    self._view.sliderWipe:OnSliderChanged(Bind(self, self.OnWipeValueChanged))
    self._view.sliderPower:OnSliderChanged(Bind(self, self.OnPowerValueChanged))
    
end

function M:OnDispose()
    self:_StopWipeTween()
    self:_StopPowerTween()

    self._view.sliderWipe:onLongPress(nil)
    self._view.rectPress:onLongPress(nil)

    self._view.sliderWipe:onClickPointerDown(nil)
    self._view.rectPress:onClickPointerDown(nil)
    self._view.sliderWipe:onUp(nil)
    self._view.rectPress:onUp(nil)

    M.super.OnDispose(self)
end

function M:OnEnter()
    self._view.txtRatio:SetText("0<size=40>%</size>")
    self._view.rectWipeGuide:SetActive(true)
    self._view.rectPressGuide:SetActive(false)
end

function M:OnWipeValueChanged(value)
    if value >= 1 then
        self._view.sliderWipe:SetValue(1)
        self._view.rectWipeGuide:SetActive(false)
        self._view.rectPressGuide:SetActive(true)
        self._view.sliderWipe:SetInteractive(false)
        -- self._view.animFinger:SetTrigger(StoryConst.AnimName.InteractTrigger)
    end
end

function M:OnWipePointerDown(go, eventData)
    self:_StopWipeTween()
end

function M:OnWipeUp()
    local value = self._view.sliderWipe:GetValue()
    if value < 1 then
        self._wipeTween = self._view.sliderWipe
            :SetDoValue(0, 0.5)
            :SetTweenUpdate(true)
            :OnTweenComplete(Bind(self, self._StopWipeTween))
    end
end

function M:_StopWipeTween()
    if self._wipeTween then
        self._wipeTween:TweenPause()
        self._wipeTween:TweenKill()
        self._wipeTween = nil
    end
end

function M:_StopPowerTween()
    if self._powerTween then
        self._powerTween:TweenPause()
        self._powerTween:TweenKill()
        self._powerTween = nil
    end
end

function M:OnPowerValueChanged(value)
    value = math.floor(value * 100 / 53)
    self._view.txtRatio:SetText(value.."<size=40>%</size>")
end

function M:OnPressPointerDown(go, eventData)
    self:_StopPowerTween()
end

function M:OnPressLongPress()
    local wipeValue = self._view.sliderWipe:GetValue()
    if wipeValue >= 1 then
        local powerValue = self._view.sliderPower:GetValue()
        powerValue = powerValue + Time.unscaledDeltaTime * 53
        self._view.sliderPower:SetValue(powerValue)
        if powerValue >= 53 then
            StoryDataMgr:GetInstance():NextStory()
            self:Close()
        end
    end
end

function M:OnPressUp()
    local value = self._view.sliderPower:GetValue()
    if value < 53 then
        self._view.sliderPower
            :SetDoValue(0, 0.5)
            :SetTweenUpdate(true)
            :OnTweenComplete(Bind(self, self._StopPowerTween))
    end
end

function M:OnClose()
end

return StoryInteractUICtrl