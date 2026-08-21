local UINewSlider = BaseClass("UINewSlider", UIBaseComponent)
local base = UIBaseComponent


-- 创建
local function OnCreate(self, unity_uislider)
    base.OnCreate(self)
    -- Unity侧原生组件
    self.unity_uislider = unity_uislider

    if not IsNull(self.unity_uislider) and IsNull(self.gameObject) then
        self.gameObject = self.unity_uislider.gameObject
        self.transform = self.unity_uislider.transform
    end

    self.value = self:GetValue()
    self.onValueChanged = self.unity_uislider.onValueChanged
end

-- 获取进度
local function GetValue(self)
    if self.value then return self.value end
    if not IsNull(self.unity_uislider) then
        return self.unity_uislider.value
    end
end

-- 设置进度
local function SetValue(self, value)
    if not IsNull(self.unity_uislider) then
        -- self.unity_uislider.normalizedValue = value
        self.unity_uislider.value = value
        self.value = value
    end
end

-- 设置进度
local function SetNormalLizedValue(self, value)
    if not IsNull(self.unity_uislider) then
        self.unity_uislider.normalizedValue = value
        self.value = value
    end
end

local function SetMin(self, value)
    if not IsNull(self.unity_uislider) then
        self.unity_uislider.minValue = value
        self.minValue = value
    end
end

local function SetMax(self, value)
    if not IsNull(self.unity_uislider) then
        self.unity_uislider.maxValue = value
        self.maxValue = value
    end
end

local function SetValueWithoutNotify(self, input)
    if not IsNull(self.unity_uislider) then
        self.unity_uislider:SetValueWithoutNotify(input)
    end
end

local function SetDoValue(self, endValue, duration)
    if not IsNull(self.unity_uislider) then
        self.value = endValue
        return self.unity_uislider:SetDoValue(endValue, duration)
    end
    return nil
end

local function onLongPress(self, ...)
    local arr = { ... }
    if #arr == 0 then
        self.unity_uislider:onLongPress(nil)
        return
    end
    self.__onLongPress = BindCallback(...)
    self.unity_uislider:onLongPress(self.__onLongPress)
end

local function onUp(self, ...)
    local arr = { ... }
    if #arr == 0 then
        self.unity_uislider:onUp(nil)
        return
    end
    self.__onUp = BindCallback(...)
    self.unity_uislider:onUp(self.__onUp)
end

local function onDown(self, ...)
    local arr = { ... }
    if #arr == 0 then
        self.unity_uislider:onDown(nil)
        return
    end
    self.__onDown = BindCallback(...)
    self.unity_uislider:onDown(self.__onDown)
end

local function SetLongPressTimes(self, time)
    if time == nil or type(time) ~= "number" then return end
    self.unity_uislider:SetLongPressTimes(time)
end

local function onClickPointer(self, ...)
    local arr = { ... }
    if #arr == 0 then
        self.unity_uislider:onClickPointer(nil)
        return
    end
    self.__onClickPointer = BindCallback(...)
    self.unity_uislider:onClickPointer(self.__onClickPointer)
end

local function onClickPointerDown(self, ...)
    local arr = { ... }
    if #arr == 0 then
        self.unity_uislider:onClickPointerDown(nil)
        return
    end
    self.__onClickPointerDown = BindCallback(...)
    self.unity_uislider:onClickPointerDown(self.__onClickPointerDown)
end

local function onClickPointerUp(self, ...)
    local arr = { ... }
    if #arr == 0 then
        self.unity_uislider:onClickPointerUp(nil)
        return
    end
    self.__onClickPointerUp = BindCallback(...)
    self.unity_uislider:onClickPointerUp(self.__onClickPointerUp)
end

local function SetInteractive(self, active)
    if IsNull(self.unity_uislider) then
        return
    end
    self.unity_uislider.interactable = active
end

-- 销毁
local function OnDestroy(self)
    self:RemoveSliderListener()
    self.onValueChanged:RemoveAllListeners()
    self.onValueChanged = nil
    self.unity_uislider.onValueChanged = nil
    base.OnDestroy(self)
end

local function OnSliderChanged(self, callback)
    self._callback = callback
    self.unity_uislider:OnSliderChanged(self._callback)
end

local function RemoveSliderListener(self)
    self.unity_uislider:RemoveSliderListener(self._callback)
    self._callback = nil
end

local function RemoveSliderAllListeners(self)
    self._callback = nil
    self.unity_uislider:RemoveSliderAllListeners()
end

local function OnEndDrag(self, callback)
    self.__onEndDrag = callback
    self.unity_uislider:OnEndDrag(self.__onEndDrag)
end

UINewSlider.OnCreate = OnCreate
UINewSlider.GetValue = GetValue
UINewSlider.SetValue = SetValue
UINewSlider.SetMin = SetMin
UINewSlider.SetMax = SetMax
UINewSlider.SetValueWithoutNotify = SetValueWithoutNotify
UINewSlider.SetDoValue = SetDoValue
UINewSlider.onLongPress = onLongPress
UINewSlider.onUp = onUp
UINewSlider.onDown = onDown
UINewSlider.SetLongPressTimes = SetLongPressTimes
UINewSlider.onClickPointer = onClickPointer
UINewSlider.onClickPointerDown = onClickPointerDown
UINewSlider.onClickPointerUp = onClickPointerUp
UINewSlider.OnDestroy = OnDestroy
UINewSlider.SetInteractive = SetInteractive
UINewSlider.OnSliderChanged = OnSliderChanged
UINewSlider.RemoveSliderListener = RemoveSliderListener
UINewSlider.RemoveSliderAllListeners = RemoveSliderAllListeners
UINewSlider.SetNormalLizedValue = SetNormalLizedValue
UINewSlider.OnEndDrag = OnEndDrag

return UINewSlider
