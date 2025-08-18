-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainMenu\\QualitySettingCellToggle.lua

local strClassName = "QualitySettingCellToggle"
local QualitySettingCellToggle = Class(strClassName, UIControls.Child)

function QualitySettingCellToggle:ctor(...)
	self:initUI()
end

function QualitySettingCellToggle:initUI(...)
	self.nameTxt = UIControls.Label(self, "TextTitle")
	self.toggleBtn = UIControls.Button(self, "")

	self.toggleBtn:addEventClick(self._onToggleChanged)

	self.btnImage = UIControls.Image(self, "Img")
end

function QualitySettingCellToggle:setToggleSetting(name, callback)
	self.nameTxt:setText(name or "")

	self.changeCallback = callback
end

function QualitySettingCellToggle:setToggle(isOn)
	local toggleChanged = self.isOn ~= isOn

	self.isOn = isOn

	if not self.isInited then
		if isOn then
			self.btnImage:playAnimator("BtnSwitchSetOn")
		else
			self.btnImage:playAnimator("BtnSwitchSetOff")
		end

		self.isInited = true
	elseif toggleChanged then
		if isOn then
			self.btnImage:playAnimator("BtnSwitchOn")
		else
			self.btnImage:playAnimator("BtnSwitchOff")
		end
	end
end

function QualitySettingCellToggle:_onToggleChanged()
	self:setToggle(not self.isOn)

	if self.changeCallback then
		self.changeCallback(self.isOn)
	end
end

return QualitySettingCellToggle
