-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\RelinkDlg.lua

local strClassName = "RelinkDlg"
local RelinkDlg = Class(strClassName, UIControls.Window)

function RelinkDlg:ctor()
	self.txtNotice = UIControls.Label(self, "Text")
	self.slotUpdate = Slot(self.updateNotice, self)
	self.nowPoint = 0
end

function RelinkDlg:updateNotice()
	if self.battleMode then
		if self.nowPoint % 4 == 0 then
			self.txtNotice:setText(Lang.get(40196))
		elseif self.nowPoint % 4 == 1 then
			self.txtNotice:setText(Lang.get(96610))
		elseif self.nowPoint % 4 == 2 then
			self.txtNotice:setText(Lang.get(96611))
		else
			self.txtNotice:setText(Lang.get(96612))
		end
	elseif self.nowPoint % 4 == 0 then
		self.txtNotice:setText(Lang.get(30226))
	elseif self.nowPoint % 4 == 1 then
		self.txtNotice:setText(Lang.get(30223))
	elseif self.nowPoint % 4 == 2 then
		self.txtNotice:setText(Lang.get(30224))
	else
		self.txtNotice:setText(Lang.get(30225))
	end

	self.nowPoint = self.nowPoint + 1
end

function RelinkDlg:onOpen()
	self.nowPoint = 0

	if not self.noticeTimer then
		self.noticeTimer = Timer.New(self.slotUpdate, 0.3, -1, false)

		self.noticeTimer:Start()
	end

	RelinkDlg.super.onOpen(self)
end

function RelinkDlg:setBattleMode()
	self.battleMode = true

	self.txtNotice:setText(Lang.get(40196))
end

function RelinkDlg:onClose()
	self.noticeTimer:Stop()

	self.noticeTimer = nil

	RelinkDlg.super.onClose(self)
end

function RelinkDlg:destroy()
	if self.noticeTimer then
		self.noticeTimer:Stop()

		self.noticeTimer = nil
	end

	RelinkDlg.super.destroy(self)
end

return RelinkDlg
