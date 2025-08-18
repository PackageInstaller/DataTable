-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\PatchDlg.lua

local strClassName = "PatchDlg"
local PatchDlg = Class(strClassName, UIControls.Window)

function PatchDlg:ctor()
	self:initUI()

	self._confirmBoxCallback = nil
end

function PatchDlg:initUI()
	self.imgBg = UIControls.Image(self, "BgImage")
	self.sliderProgress = UIControls.Slider(self, "SliderUpdate")
	self.labelInfo = UIControls.Label(self, "TextUpdateNum")
	self.labelResVersion = UIControls.Label(self, "TextResVersion")
	self.labelAppVersion = UIControls.Label(self, "TextAppVersion")
	self.panelConfirm = UIControls.Panel(self, "PatchConfirmPanel")
	self.labelConfirmText = UIControls.Label(self, "PatchConfirmPanel/Bg/TextDataNum")
	self.btnConfirm = UIControls.Button(self, "PatchConfirmPanel/Bg/BtnConfirm", "Text")

	self.btnConfirm:addEventClick(self.onClickConfirm)

	self.btnDeny = UIControls.Button(self, "PatchConfirmPanel/Bg/BtnDeny", "Text")

	self.btnDeny:addEventClick(self.onClickDeny)
	self.labelInfo:setVisible(true)
	self.sliderProgress:setVisible(true)
	self.labelInfo:setText("")
	self.labelResVersion:setText("")
	self.labelAppVersion:setText("")
end

function PatchDlg:onOpen()
	PatchDlg.super.onOpen(self)
end

function PatchDlg:onClose()
	PatchDlg.super.onClose(self)
end

function PatchDlg:onBtnCloseClick()
	return
end

function PatchDlg:setInfoText(text)
	self.labelInfo:setText(text)
end

function PatchDlg:setResVersionText(text)
	self.labelResVersion:setText(text)
end

function PatchDlg:setAppVersionText(text)
	self.labelAppVersion:setText(text)
end

function PatchDlg:setProgressVisible(visible)
	self.sliderProgress:setVisible(visible)
end

function PatchDlg:setProgressValue(progress)
	self.sliderProgress:setValue(progress)
end

function PatchDlg:showConfirmBox(content, callback)
	self.panelConfirm:setVisible(true)
	self.labelConfirmText:setText(content)

	self._confirmBoxCallback = callback
end

function PatchDlg:hideConfirmBox()
	self.panelConfirm:setVisible(false)
end

function PatchDlg:onClickConfirm()
	if self._confirmBoxCallback then
		self._confirmBoxCallback(true)
	end
end

function PatchDlg:onClickDeny()
	if self._confirmBoxCallback then
		self._confirmBoxCallback(true)
	end

	self:hideConfirmBox()
end

return PatchDlg
