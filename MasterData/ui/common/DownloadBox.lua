-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\DownloadBox.lua

local SubpackageUtils = Framework.Download.SubpackageUtils
local SubpackageHelper = require("Helper/SubpackageHelper")
local DeviceHelper = require("Helper/DeviceHelper")
local strClassName = "DownloadBox"
local DownloadBox = Class(strClassName, UIControls.Window)

function DownloadBox:ctor()
	self:initUI()

	self._timerUpdate = Timer.New(Slot(self._updateProgress, self), 1, -1)
end

function DownloadBox:initUI()
	self.textProgrss = UIControls.Label(self, "Bg/ProgressPanel/Text")
	self.sliderProgrss = UIControls.Slider(self, "Bg/ProgressPanel/Slider")
	self.btnPause = UIControls.Button(self, "Bg/ProgressPanel/BtnPause")
	self.btnStart = UIControls.Button(self, "Bg/ProgressPanel/BtnStart")
	self.textNetType = UIControls.Label(self, "Bg/TextType")
	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnPause:addEventClick(self._onClickPause)
	self.btnStart:addEventClick(self._onClickStart)
	self.btnConfirm:addEventClick(self._onClickConfirm)
end

function DownloadBox:onOpen()
	DownloadBox.super.onOpen(self)
	self._timerUpdate:Restart()
	self:_updatePause()
	self:_updateProgress()
end

function DownloadBox:onClose()
	DownloadBox.super.onClose(self)
	self._timerUpdate:Stop()
end

function DownloadBox:_updatePause()
	local isDownloading = SubpackageUtils.IsDownloadingByUser()

	self.btnPause:setVisible(isDownloading)
	self.btnStart:setVisible(not isDownloading)
end

function DownloadBox:_onClickPause()
	SubpackageUtils.PauseBackground()
	self:_updatePause()
end

function DownloadBox:_onClickStart()
	SubpackageUtils.ResumeBackground()
	self:_updatePause()
end

function DownloadBox:_onClickConfirm()
	self:setVisible(false)
end

function DownloadBox:_updateProgress()
	local sizeTotalMB = SubpackageHelper.getSizeTotal()
	local sizeDoneMB = SubpackageHelper.getSizeDone()
	local progress = sizeTotalMB <= 0 and 1 or sizeDoneMB / sizeTotalMB
	local strProgress = string.format("%.2fM/%.2fM", sizeDoneMB, sizeTotalMB)

	self.textProgrss:setText(strProgress)
	self.sliderProgrss:setValue(progress)

	local strNetType = string.format(Lang.get(30212), DeviceHelper.getNetworkTypeText())

	self.textNetType:setText(strNetType)
end

return DownloadBox
