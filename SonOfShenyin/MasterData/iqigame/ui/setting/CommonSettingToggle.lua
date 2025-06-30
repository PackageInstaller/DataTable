-- chunkname: @IQIGame\\UI\\Setting\\CommonSettingToggle.lua

local CommonSettingToggle = {}
local constant_ButtonPosX_On = -56
local constant_ButtonPosX_Off = 56
local constant_MarkBgPosX_On = 56
local constant_MarkBgPosX_Off = -56
local originalButtonPosY = 0
local originalMarkBgPosY = 0

function CommonSettingToggle.New(view)
	local obj = Clone(CommonSettingToggle)

	obj:Init(view)

	return obj
end

function CommonSettingToggle:Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitProperties()
	self:AddListeners()
end

function CommonSettingToggle:InitProperties()
	self.isOn = nil
	self.isInitialized = false
	self.stateChangeCallback = nil
	self.toggleOnDescText = self.On:GetComponent("Text")
	self.toggleOffDescText = self.Off:GetComponent("Text")
	self.button = self.Btn:GetComponent("Button")
	self.MarkBgRect = self.MarkBg:GetComponent(typeof(UnityEngine.RectTransform))
	self.BtnRect = self.Btn:GetComponent(typeof(UnityEngine.RectTransform))

	if self.BtnRect ~= nil then
		originalButtonPosY = self.BtnRect.anchoredPosition.y
	end

	if self.MarkBgRect ~= nil then
		originalMarkBgPosY = self.MarkBgRect.anchoredPosition.y
	end

	function self.DelegateOnButtonClick()
		self:OnButtonClick()
	end
end

function CommonSettingToggle:DisposeProperties()
	self.toggleOnDescText = nil
	self.toggleOffDescText = nil
	self.button = nil
	self.MarkBgRect = nil
	self.BtnRect = nil
end

function CommonSettingToggle:AddListeners()
	self.button.onClick:AddListener(self.DelegateOnButtonClick)
end

function CommonSettingToggle:RemoveListeners()
	self.button.onClick:RemoveListener(self.DelegateOnButtonClick)
end

function CommonSettingToggle:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	self:DisposeProperties()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function CommonSettingToggle:SetVisible(isVisible)
	LuaUtility.SetGameObjectShow(self.gameObject, isVisible)
end

function CommonSettingToggle:Initialize(isOn, stateChangeCallback)
	self.stateChangeCallback = stateChangeCallback
	self.isInitialized = true
	self.isOn = nil

	self:SetToggleState(isOn, false)
end

function CommonSettingToggle:SetToggleState(isOn, isDispatchStateChangeCallback)
	if not self.isInitialized then
		return
	end

	if self.isOn == isOn then
		return
	end

	self.isOn = isOn

	self:Refresh(self.isOn)

	if isDispatchStateChangeCallback and self.stateChangeCallback ~= nil then
		self.stateChangeCallback(self.isOn)
	end
end

function CommonSettingToggle:Refresh(isOn)
	if self.MarkBgRect ~= nil then
		LuaUtility.SetAnchoredPositionWithRectTransform(self.MarkBgRect, isOn and constant_MarkBgPosX_On or constant_MarkBgPosX_Off, originalMarkBgPosY)
	end

	if self.BtnRect ~= nil then
		LuaUtility.SetAnchoredPositionWithRectTransform(self.BtnRect, isOn and constant_ButtonPosX_On or constant_ButtonPosX_Off, originalButtonPosY)
	end

	LuaUtility.SetGameObjectShow(self.Background, not isOn)
	LuaUtility.SetGameObjectShow(self.Checkmark, isOn)
end

function CommonSettingToggle:SetToggleDesc(isOnToggle, desc)
	if isOnToggle then
		if self.toggleOnDescText ~= nil then
			UGUIUtil.SetText(self.toggleOnDescText, desc)
		end
	elseif self.toggleOffDescText ~= nil then
		UGUIUtil.SetText(self.toggleOffDescText, desc)
	end
end

function CommonSettingToggle:OnButtonClick()
	if not self.isInitialized then
		return
	end

	self:SetToggleState(not self.isOn, true)
end

return CommonSettingToggle
