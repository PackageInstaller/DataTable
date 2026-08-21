local UINewToggleGroup = BaseClass("UINewToggleGroup", UIBaseComponent)
local base = UIBaseComponent

-- 创建
local function OnCreate(self, unity_toggleGroup)
    base.OnCreate(self, unity_toggleGroup)
    -- Unity侧原生组件
    self.unity_toggleGroup = unity_toggleGroup
    self._allChildern = {}
    if not IsNull(self.unity_toggleGroup) and IsNull(self.gameObject) then
        self.gameObject = self.unity_toggleGroup.gameObject
        self.transform = self.unity_toggleGroup.transform
    end
end

local function AnyTogglesOn(self)
    -- body
    self.unity_toggleGroup:AnyTogglesOn()
end

local function EnsureValidState(self)
    -- body
    self.unity_toggleGroup:EnsureValidState()
end

local function NotifyToggleOn(self, toggle, sendCallback)
    if IsNull(toggle) then return end
    if sendCallback == nil then sendCallback = true end
    local unityToggle = self._CheckUnityToggle(self, toggle)
    if IsNull(unityToggle) then return end
    self.unity_toggleGroup:NotifyToggleOn(unityToggle, sendCallback)
end

local function _CheckUnityToggle(self, toggle)
    if IsNull(toggle) then return nil end

    if type(toggle) == "userdata" and toggle:GetType() ==
        typeof(CS.UnityEngine.UI.Toggle) then
        return toggle
    elseif toggle._class_type == UINewToggle then
        return toggle.unity_toggle
    end
    return nil
end

local function RegisterToggle(self, toggle)
    local unityToggle = self._CheckUnityToggle(self, toggle)
    if unityToggle == nil then return end
    self.unity_toggleGroup:RegisterToggle(unityToggle)
    table.insert(self._allChildern,toggle)
end

local function UnregisterToggle(self, toggle)
    local unityToggle = self._CheckUnityToggle(self, toggle)
    if unityToggle == nil then return end
    self.unity_toggleGroup:UnregisterToggle(unityToggle)
    table.removeValue(self._allChildern,toggle)
end

local function SetAllTogglesOff(self,sendCallback)
    -- body
    if sendCallback == nil then
        sendCallback = true 
    end
    self.unity_toggleGroup:SetAllTogglesOff(sendCallback)
end

local function GetSwitchState(self)
    -- body
    return self.unity_toggleGroup.allowSwitchOff
end

local function SetSwitchState(self, isOn)
    -- body
    self.unity_toggleGroup.allowSwitchOff = isOn
end

local function OnDestroy(self)
    -- body
    if self._allChildern then 
        for index, toggle in ipairs(self._allChildern) do
            -- body
            local c = self:_CheckUnityToggle(toggle)
            if c then 
                self.unity_toggleGroup.UnregisterToggle(toggle)
            end
        end
    end
    base.OnDestroy(self)
    self._allChildern = nil 
    self.unity_toggleGroup = nil 
end

UINewToggleGroup.OnCreate = OnCreate
UINewToggleGroup.AnyTogglesOn = AnyTogglesOn
UINewToggleGroup.EnsureValidState = EnsureValidState
UINewToggleGroup.NotifyToggleOn = NotifyToggleOn
UINewToggleGroup._CheckUnityToggle = _CheckUnityToggle
UINewToggleGroup.RegisterToggle = RegisterToggle
UINewToggleGroup.UnregisterToggle = UnregisterToggle
UINewToggleGroup.GetSwitchState = GetSwitchState
UINewToggleGroup.SetSwitchState = SetSwitchState
UINewToggleGroup.SetAllTogglesOff = SetAllTogglesOff
UINewToggleGroup.OnDestroy = OnDestroy

return UINewToggleGroup
