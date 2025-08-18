-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\CustomToggle.lua

local strClassName = "CustomToggle"
local CustomToggle = Class(strClassName, UIControls.Panel)

function CustomToggle:ctor(...)
	self:initUI()
end

function CustomToggle:initUI(...)
	self.clickBtn = UIControls.Button(self, self.mPath)

	self.clickBtn:addEventClick(self.onClickBtn)

	self.toggle = UIControls.Panel(self, self.mPath .. "/Img")
end

function CustomToggle:onClickBtn()
	if self.isOn ~= nil and self.clickFunc ~= nil then
		self.clickFunc(not self.isOn)
	end
end

function CustomToggle:addEventOnToggleClick(func, CD)
	self.clickFunc = func
end

function CustomToggle:setToggleValue(isOn)
	if isOn then
		self.toggle:playAnimator("BtnSwitchSetOn")
	else
		self.toggle:playAnimator("BtnSwitchSetOff")
	end

	self.isOn = isOn
end

function CustomToggle:refreshToggleValue(isOn)
	if isOn ~= self.isOn then
		if isOn then
			self.toggle:playStateAnimator("BtnSwitchOn")
		else
			self.toggle:playStateAnimator("BtnSwitchOff")
		end
	end

	self.isOn = isOn
end

return CustomToggle
