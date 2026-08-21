-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Social\\ARAnimBtn.lua

local ResArActConfig = require("ClientData/ResArActConfig")
local PluginManager = require("SDK/Plugin/PluginManager")
local ARAnimBtn = Class("ARAnimBtn", UIControls.Child)

function ARAnimBtn:ctor()
	PluginManager.tryInitShare()

	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onSensorClick)

	self.imgBg = UIControls.Image(self, "Icon")
	self.textName = UIControls.Label(self, "Text")
end

function ARAnimBtn:onSensorClick()
	self.mParent:onBtnActClick(self)
end

function ARAnimBtn:setData(arActId, isLocked)
	self.isLocked = isLocked
	self.arActId = arActId
	self.arActData = ResArActConfig[arActId]

	self.textName:setText(self.arActData.name or "")

	if self.arActData.icon then
		self.imgBg:setImage("Atlas/" .. self.arActData.icon_path, self.arActData.icon)
	end

	if isLocked then
		if not self.panelLock then
			self.panelLock = UIControls.Panel(self, "ImgLock")
		end

		self.panelLock:setVisible(true)
	elseif self.panelLock then
		self.panelLock:setVisible(false)
	end
end

function ARAnimBtn:setSelected(isSetected)
	self.btnSensor:setEnable(not isSetected)

	if self.panelSlider then
		self.panelSlider:setVisible(isSetected)
	end
end

function ARAnimBtn:startAction(hero)
	if self.arActData.voice_type then
		CueManager.playHeroVocal(hero.id, self.arActData.voice_type, hero:getFashionTag())
	end

	if self.arActData.dance_time then
		if not self.slider and UIControls.checkControlFunc(self, "BgBar") then
			self.panelSlider = UIControls.Panel(self, "BgBar")
			self.slider = UIControls.MaterialProgress(self, "BgBar/ImgBar")
		end

		if self.slider then
			self.panelSlider:setVisible(true)
			self.slider:setValueEx(1, 0, self.arActData.dance_time)
		end
	elseif self.slider then
		self.slider:setValue(0)
	end

	if self.arActData.dance_bgm then
		CueManager.stopBGM()
		CueManager.playAvgBGM(self.arActData.dance_bgm)
		CueManager.setBGMLoop(false)
	end
end

return ARAnimBtn
