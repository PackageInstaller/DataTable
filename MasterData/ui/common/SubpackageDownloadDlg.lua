-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\SubpackageDownloadDlg.lua

local strClassName = "SubpackageDownloadDlg"
local SubpackageDownloadDlg = Class(strClassName, UIControls.Window)

function SubpackageDownloadDlg:ctor()
	self.slider = UIControls.Slider(self, "Bg/ProgressPanel/Slider")
	self.sizeTxt = UIControls.Label(self, "Bg/ProgressPanel/Text")
	self.descTxt = UIControls.Label(self, "Bg/ProgressPanel/TextTitle")
	self.cancelBtn = UIControls.Button(self, "Bg/BtnCancel")
	self.confirmBtn = UIControls.Button(self, "Bg/BtnConfirm")

	self.cancelBtn:addEventClick(self.onCancelBtn)
	self.confirmBtn:addEventClick(self.onConfirmBtn)
end

function SubpackageDownloadDlg:onCancelBtn()
	if self.cancelCallback then
		self.cancelCallback()
	end

	self:setVisible(false)
end

function SubpackageDownloadDlg:onConfirmBtn()
	if self.confirmCallback then
		self.confirmCallback()
	end
end

function SubpackageDownloadDlg:setData(data)
	self.data = data
	self.job = data.job
	self.cancelCallback = data.cancelCallback
	self.confirmCallback = data.confirmCallback

	self.cancelBtn:setVisible(true)
	self.confirmBtn:setVisible(true)
	self.slider:setVisible(false)

	local totalMB = tonumber(tostring(self.job.sizeTotalMB))
	local desc = Lang.get(42726)

	if data.desc then
		desc = data.desc
	end

	self.descTxt:setText(utils.format(desc, totalMB))
end

function SubpackageDownloadDlg:updateProgress(doneMB, totalMB, progress)
	self.confirmBtn:setVisible(false)
	self.slider:setVisible(true)
	self.descTxt:setText(Lang.get(30052))
	self.sizeTxt:setText(utils.format("%1:.2fMB/%2:.2fMB", doneMB, totalMB))
	self.slider:setValue(progress)
end

return SubpackageDownloadDlg
