-- chunkname: @IQIGame\\UI\\Setting\\SettingMusicView.lua

local CommonSettingToggle = require("IQIGame.UI.Setting.CommonSettingToggle")
local DropDownViewClass = require("IQIGame.UI.Common.CommonDropDownView")

SettingMusicView = {
	SliderChangeValue = 100,
	SliderTable = {},
	delegateliderValueTable = {},
	SliderType = {
		Sound = 2,
		Music = 3,
		CVS = 4,
		AllAudio = 1
	}
}

function SettingMusicView.New(go, mianView)
	local o = Clone(SettingMusicView)

	o:Initialize(go, mianView)

	return o
end

function SettingMusicView:DeleteFunction()
	function self.delegateAllAudioSliderValue(value)
		self:OnAllAudioSliderValueChange(value)
	end

	function self.delegateSoundSliderValue(value)
		self:OnSoundSliderValueChange(value)
	end

	function self.delegateMusicSliderValue(value)
		self:OnMusicSliderValueChange(value)
	end

	function self.delegateCVSliderValue(value)
		self:OnCVSliderValueChange(value)
	end

	table.insert(self.delegateliderValueTable, self.delegateAllAudioSliderValue)
	table.insert(self.delegateliderValueTable, self.delegateSoundSliderValue)
	table.insert(self.delegateliderValueTable, self.delegateMusicSliderValue)
	table.insert(self.delegateliderValueTable, self.delegateCVSliderValue)
end

function SettingMusicView:Initialize(go, mianView)
	self.mianView = mianView

	LuaCodeInterface.BindOutlet(go, self)
	self:InitSlider()
	self:DeleteFunction()

	self.gameObject = go

	self:AddEventListener()
	self:InitVolume()

	self.roleVoiceDropdown = DropDownViewClass.New(self.RoleVoiceDropdown, function(selectIndex)
		self:OnRoleVoiceDropDownHasClick(selectIndex)
	end)

	self.roleVoiceDropdown:SetData(SettingUIApi:GetVoiceTypeText(), math.max(1, SettingModule.GetSoundGroupTypeSwitch(Constant.SoundGroupType.Battle)))

	self.storyVoiceDropdown = DropDownViewClass.New(self.StoryVoiceDropdown, function(selectIndex)
		self:OnStoryVoiceDropDownHasClick(selectIndex)
	end)

	self.storyVoiceDropdown:SetData(SettingUIApi:GetVoiceTypeText(), math.max(1, SettingModule.GetSoundGroupTypeSwitch(Constant.SoundGroupType.Story)))
end

function SettingMusicView:InitSlider()
	for i = 1, 4 do
		local itemObj = UnityEngine.Object.Instantiate(self.VolumePrefab.gameObject)

		itemObj.name = i

		if i == 1 then
			itemObj.transform:SetParent(self.MainVolueRoot.transform, false)
		else
			itemObj.transform:SetParent(self.VolumeGrid.transform, false)
		end

		itemObj:SetActive(true)

		itemObj.transform.localPosition = Vector3.zero
		self.SliderTable[i] = {
			obj = itemObj,
			userTable = {}
		}

		local userTable = self.SliderTable[i].userTable

		LuaCodeInterface.BindOutlet(self.SliderTable[i].obj, userTable)

		self.SliderTable[i]._HandleSlideText = userTable.HandleSlideText:GetComponent("Text")
		self.SliderTable[i]._VolumSlider = userTable.VolumSlider:GetComponent("Slider")
		userTable.VolumSlider.gameObject.name = i

		UGUIUtil.SetText(userTable.TitleText, SettingUIApi:GetTextDynamic(i))
	end
end

function SettingMusicView:InitVolume()
	self.SliderTable[self.SliderType.AllAudio]._VolumSlider.value = SettingModule.AllAudioVolume
	self.SliderTable[self.SliderType.Music]._VolumSlider.value = SettingModule.currentMusicVolume
	self.SliderTable[self.SliderType.Sound]._VolumSlider.value = SettingModule.currentSoundVolume
	self.SliderTable[self.SliderType.CVS]._VolumSlider.value = SettingModule.currentCvVolume
end

function SettingMusicView:GetValuaState(value, Obj)
	Obj.userTable.MaxImg:SetActive(value >= 0.5)
	Obj.userTable.MediumImg:SetActive(value > 0 and value < 0.5)
	Obj.userTable.MinImg:SetActive(value == 0)
end

function SettingMusicView:OnAllAudioSliderValueChange(value)
	self.SliderTable[self.SliderType.AllAudio]._HandleSlideText.text = math.floor(value * self.SliderChangeValue)

	self:GetValuaState(value, self.SliderTable[self.SliderType.AllAudio])
	self:OnSliderSettingMisic(self.SliderType.AllAudio)
end

function SettingMusicView:OnMusicSliderValueChange(value)
	self.SliderTable[self.SliderType.Music]._HandleSlideText.text = math.floor(value * self.SliderChangeValue)

	self:GetValuaState(value, self.SliderTable[self.SliderType.Music])
	self:OnSliderSettingMisic(self.SliderType.Music)
end

function SettingMusicView:OnSoundSliderValueChange(value)
	self.SliderTable[self.SliderType.Sound]._HandleSlideText.text = math.floor(value * self.SliderChangeValue)

	self:GetValuaState(value, self.SliderTable[self.SliderType.Sound])
	self:OnSliderSettingMisic(self.SliderType.Sound)
end

function SettingMusicView:OnCVSliderValueChange(value)
	self.SliderTable[self.SliderType.CVS]._HandleSlideText.text = math.floor(value * self.SliderChangeValue)

	self:GetValuaState(value, self.SliderTable[self.SliderType.CVS])
	self:OnSliderSettingMisic(self.SliderType.CVS)
end

function SettingMusicView:OnSliderSettingMisic(type)
	if type == self.SliderType.AllAudio then
		local SaveValue = string.format("%.3f", self.SliderTable[self.SliderType.AllAudio]._VolumSlider.value)

		SettingModule.SaveCurrentAllAudioVolume(tonumber(SaveValue))
	elseif type == self.SliderType.Music then
		local SaveValue = string.format("%.3f", self.SliderTable[self.SliderType.Music]._VolumSlider.value)

		SettingModule.SaveCurrentMusicVolume(tonumber(SaveValue))
	elseif type == self.SliderType.Sound then
		local SaveValue = string.format("%.3f", self.SliderTable[self.SliderType.Sound]._VolumSlider.value)

		SettingModule.SaveCurrentSoundVolume(tonumber(SaveValue))
	elseif type == self.SliderType.CVS then
		local SaveValue = string.format("%.3f", self.SliderTable[self.SliderType.CVS]._VolumSlider.value)

		SettingModule.SaveCurrentCvVolume(tonumber(SaveValue))
	end
end

function SettingMusicView:AddEventListener()
	for i = 1, #self.SliderTable do
		self.SliderTable[i]._VolumSlider.onValueChanged:AddListener(self.delegateliderValueTable[i])
	end
end

function SettingMusicView:OnRoleVoiceDropDownHasClick(selectIndex)
	SettingModule.SetSoundGroupTypeSwitch(Constant.SoundGroupType.Battle, selectIndex)
end

function SettingMusicView:OnStoryVoiceDropDownHasClick(selectIndex)
	SettingModule.SetSoundGroupTypeSwitch(Constant.SoundGroupType.Story, selectIndex)
end

function SettingMusicView:RemoveEventListener()
	for i = 1, #self.SliderTable do
		self.SliderTable[i]._VolumSlider.onValueChanged:RemoveListener(self.delegateliderValueTable[i])
	end
end

function SettingMusicView:OnDestroy()
	self.roleVoiceDropdown:Dispose()
	self.storyVoiceDropdown:Dispose()
	self:RemoveEventListener()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.SliderTable do
		LuaCodeInterface.ClearOutlet(self.SliderTable[i].obj, self.SliderTable[i].userTable)
	end

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
	self.mainView = nil
end

return SettingMusicView
