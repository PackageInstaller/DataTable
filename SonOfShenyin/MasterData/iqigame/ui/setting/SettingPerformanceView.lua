-- chunkname: @IQIGame\\UI\\Setting\\SettingPerformanceView.lua

local SettingPerformanceView = {
	AnimatorInit = false,
	ToggleTable = {},
	ToggleType = {
		PowerSaving = 1,
		HeroActive = 2,
		AllMessageSend = 3
	},
	OnClick_ToggleTable = {},
	Bool_Toggle = {
		PowerSaving = false,
		HeroActive = true,
		AllMessageSend = true
	},
	AnimationType = {
		OneTimes = 2,
		Close = 3,
		Open = 1
	}
}
local CommonSettingToggle = require("IQIGame.UI.Setting.CommonSettingToggle")

function SettingPerformanceView.New(go, mainView)
	local o = Clone(SettingPerformanceView)

	o:Initialize(go, mainView)

	return o
end

function SettingPerformanceView:DeleteFunction()
	function self.OnClick_PowerSaving()
		self:OnClickPowerSaving()
	end

	function self.OnClick_HeroActive()
		self:OnClickHeroActive()
	end

	function self.OnClick_AllMessageSend()
		self:OnClickAllMessageSend()
	end

	self.OnClick_ToggleTable = {
		self.OnClick_PowerSaving,
		self.OnClick_HeroActive,
		self.OnClick_AllMessageSend
	}

	function self.OnToggleAnimationChangedDelegate(go, isOn)
		self:OnToggleAnimationChanged(go, isOn)
	end
end

function SettingPerformanceView:Initialize(go, mainView)
	self.gameObject = go
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(go, self)
	self:DeleteFunction()

	local ToggleObjTable = {
		self.PowerSavingToggle,
		self.HeroActiveToggle,
		self.MessageSendToggle
	}

	for i = 1, 3 do
		local itemObj = ToggleObjTable[i]

		itemObj.name = "Toggle_" .. i
		self.ToggleTable[i] = {
			obj = itemObj,
			userTable = {}
		}

		local userTable = self.ToggleTable[i].userTable

		LuaCodeInterface.BindOutlet(self.ToggleTable[i].obj, userTable)

		self.ToggleTable[i].button = userTable.Btn:GetComponent("Button")
		self.ToggleTable[i].OnText = userTable.On:GetComponent("Text")
		self.ToggleTable[i].OffText = userTable.Off:GetComponent("Text")
		self.ToggleTable[i].OnText.text = SettingUIApi:GetTextTitle_15()
		self.ToggleTable[i].OffText.text = SettingUIApi:GetTextTitle_16()
	end

	self.AnimationTapContent = TapContent:New()

	self.AnimationTapContent:Init(self.tapRoot.gameObject, self.OnToggleAnimationChangedDelegate)
	self:AddEventListener()
	self:InitToggle()
	self:InitAnimation()

	self.maintainBattleSpeedSettingToggle = CommonSettingToggle.New(self.MaintainBattleSpeedToggle)
	self.maintainAutoBattleSettingToggle = CommonSettingToggle.New(self.MaintainAutoBattleToggle)
	self.skinSettingToggle = CommonSettingToggle.New(self.SkinToggle)
	self.fpsToggleGroupView = {}

	LuaCodeInterface.BindOutlet(self.FpsToggleGroup, self.fpsToggleGroupView)

	self.fpsToggleGroupView.ToggleList = {
		[SettingModule.FpsEnum.UnlimitedFPS] = self.fpsToggleGroupView.UnlimitedFpsToggle,
		[SettingModule.FpsEnum._30FPS] = self.fpsToggleGroupView._30FpsToggle,
		[SettingModule.FpsEnum._60FPS] = self.fpsToggleGroupView._60FpsToggle
	}
	self.urpToggleGroupView = {}

	LuaCodeInterface.BindOutlet(self.UrpToggleGroup, self.urpToggleGroupView)

	self.urpToggleGroupView.ToggleList = {
		[SettingModule.UrpEnum.Fastest] = self.urpToggleGroupView.FastestToggle,
		[SettingModule.UrpEnum.Low] = self.urpToggleGroupView.LowToggle,
		[SettingModule.UrpEnum.Medium] = self.urpToggleGroupView.MediumToggle,
		[SettingModule.UrpEnum.High] = self.urpToggleGroupView.HighToggle
	}
end

function SettingPerformanceView:OnOpen()
	if self.maintainBattleSpeedSettingToggle ~= nil then
		self.maintainBattleSpeedSettingToggle:Initialize(SettingModule.GetMaintainBattleSpeedSetting() == 1, function(isOn)
			SettingModule.SetMaintainBattleSpeedSetting(isOn and 1 or 0)
		end)
	end

	if self.maintainAutoBattleSettingToggle ~= nil then
		self.maintainAutoBattleSettingToggle:Initialize(SettingModule.GetMaintainAutoBattleSetting() == 1, function(isOn)
			SettingModule.SetMaintainAutoBattleSetting(isOn and 1 or 0)
		end)
	end

	if self.skinSettingToggle ~= nil then
		self.skinSettingToggle:Initialize(SettingModule.GetEquipSkinTogetherSetting() == 1, function(isOn)
			SettingModule.SetEquipSkinTogetherSetting(isOn and 1 or 0)
		end)
	end

	if self.fpsToggleGroupView ~= nil and getTableLength(self.fpsToggleGroupView.ToggleList) > 0 then
		for fps, toggleObj in pairs(self.fpsToggleGroupView.ToggleList) do
			local toggle = toggleObj:GetComponent("Toggle")

			toggle.isOn = SettingModule.LoadTargetFrameRate() == fps

			toggle.onValueChanged:AddListener(function(isOn)
				if isOn then
					SettingModule.SaveTargetFrameRate(fps)
				end
			end)
		end
	end

	if self.urpToggleGroupView ~= nil and getTableLength(self.urpToggleGroupView.ToggleList) > 0 then
		for urpLevel, toggleObj in pairs(self.urpToggleGroupView.ToggleList) do
			local toggle = toggleObj:GetComponent("Toggle")

			toggle.isOn = SettingModule.LoadUrpLevel() == urpLevel

			toggle.onValueChanged:AddListener(function(isOn)
				if isOn then
					SettingModule.SaveUrpSetting(urpLevel)
				end
			end)
		end
	end
end

function SettingPerformanceView:InitToggle()
	self.Bool_Toggle.PowerSaving = SettingModule.PowerSavingModule == 0 and true or false

	self.PowerOn:SetActive(self.Bool_Toggle.PowerSaving)
	self.PowerOff:SetActive(not self.Bool_Toggle.PowerSaving)
	self:ToggleFunction(self.ToggleTable[self.ToggleType.PowerSaving], self.Bool_Toggle.PowerSaving)

	self.Bool_Toggle.HeroActive = SettingModule.PersonalActive == 0 and true or false

	self:ToggleFunction(self.ToggleTable[self.ToggleType.HeroActive], self.Bool_Toggle.HeroActive)

	self.Bool_Toggle.AllMessageSend = SettingModule.messageMainSwitch == 0 and true or false

	self:ToggleFunction(self.ToggleTable[self.ToggleType.AllMessageSend], self.Bool_Toggle.AllMessageSend)
end

function SettingPerformanceView:OnClickPowerSaving(isInit)
	self.Bool_Toggle.PowerSaving = not self.Bool_Toggle.PowerSaving

	self:ToggleFunction(self.ToggleTable[self.ToggleType.PowerSaving], self.Bool_Toggle.PowerSaving)
	self.PowerOn:SetActive(self.Bool_Toggle.PowerSaving)
	self.PowerOff:SetActive(not self.Bool_Toggle.PowerSaving)

	local value = self.Bool_Toggle.PowerSaving and 0 or 1

	SettingModule.SavePowerSavingState(value)
end

function SettingPerformanceView:OnClickHeroActive(isInit)
	if isInit == nil then
		self.Bool_Toggle.HeroActive = not self.Bool_Toggle.HeroActive
	end

	self:ToggleFunction(self.ToggleTable[self.ToggleType.HeroActive], self.Bool_Toggle.HeroActive)

	local value = self.Bool_Toggle.HeroActive and 0 or 1

	SettingModule.SavePersonalActiveState(value)
end

function SettingPerformanceView:OnClickAnimation()
	return
end

function SettingPerformanceView:OnClickAllMessageSend(isInit)
	if isInit == nil then
		self.Bool_Toggle.AllMessageSend = not self.Bool_Toggle.AllMessageSend
	end

	self:ToggleFunction(self.ToggleTable[self.ToggleType.AllMessageSend], self.Bool_Toggle.AllMessageSend)

	local value = self.Bool_Toggle.AllMessageSend and 0 or 1

	SettingModule.SaveMessageMainSwitch(value)
end

function SettingPerformanceView:ToggleFunction(DataTable, isOn)
	if isOn then
		DataTable.userTable.Background:SetActive(true)
		DataTable.userTable.Checkmark:SetActive(false)

		DataTable.userTable.MarkBg.gameObject.transform.localPosition = Vector3.New(-56)
		DataTable.userTable.Btn.gameObject.transform.localPosition = Vector3.New(56)
	else
		DataTable.userTable.Background:SetActive(false)
		DataTable.userTable.Checkmark:SetActive(true)

		DataTable.userTable.MarkBg.gameObject.transform.localPosition = Vector3.New(56)
		DataTable.userTable.Btn.gameObject.transform.localPosition = Vector3.New(-56)
	end
end

function SettingPerformanceView:InitAnimation()
	self.AnimatorInit = true

	self.AnimationTapContent:ToggleEvent("Toggle" .. SettingModule.ultimateAnimationState)
end

function SettingPerformanceView:OnToggleAnimationChanged(go_name, isOn, toggle, isinit)
	if self.AnimatorInit == true then
		self.AnimatorInit = false

		return
	end

	if go_name == "Toggle1" then
		self.CurAnimationChooseType = self.AnimationType.Open
	elseif go_name == "Toggle2" then
		self.CurAnimationChooseType = self.AnimationType.OneTimes
	elseif go_name == "Toggle3" then
		self.CurAnimationChooseType = self.AnimationType.Close
	end

	SettingModule.SaveUltimateAnimationState(self.CurAnimationChooseType)
end

function SettingPerformanceView:AddEventListener()
	for i = 1, #self.ToggleTable do
		self.ToggleTable[i].button.onClick:AddListener(self.OnClick_ToggleTable[i])
	end
end

function SettingPerformanceView:RemoveEventListener()
	for i = 1, #self.ToggleTable do
		self.ToggleTable[i].button.onClick:RemoveListener(self.OnClick_ToggleTable[i])
	end
end

function SettingPerformanceView:OnDestroy()
	if self.maintainBattleSpeedSettingToggle ~= nil then
		self.maintainBattleSpeedSettingToggle:Dispose()
	end

	if self.maintainAutoBattleSettingToggle ~= nil then
		self.maintainAutoBattleSettingToggle:Dispose()
	end

	if self.skinSettingToggle ~= nil then
		self.skinSettingToggle:Dispose()
	end

	if self.fpsToggleGroupView ~= nil and getTableLength(self.fpsToggleGroupView.ToggleList) > 0 then
		for _, toggle in pairs(self.fpsToggleGroupView.ToggleList) do
			UnityEngine.Object.Destroy(toggle)
		end

		LuaCodeInterface.ClearOutlet(self.FpsToggleGroup, self.fpsToggleGroupView)

		self.fpsToggleGroupView = {}
	end

	if self.urpToggleGroupView ~= nil and getTableLength(self.urpToggleGroupView.ToggleList) > 0 then
		for _, toggle in pairs(self.urpToggleGroupView.ToggleList) do
			UnityEngine.Object.Destroy(toggle)
		end

		LuaCodeInterface.ClearOutlet(self.UrpToggleGroup, self.urpToggleGroupView)

		self.urpToggleGroupView = {}
	end

	self:RemoveEventListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
	self.mainView = nil
end

return SettingPerformanceView
