-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\LoginSpinner.lua

local strClassName = "LoginSpinner"
local LoginSpinner = Class(strClassName, UIControls.Window)

LoginSpinner.DEFAULT_CONTENT = Lang.get(30226)

function LoginSpinner:ctor()
	self.txtNotice = UIControls.Label(self, "Text")
	self.nowPoint = 0
	self.noticeTimer = Timer.New(Slot(self.updateNotice, self), 0.5, -1, false)
	self._showTipTimer = Timer.New(Slot(self._showTipDelay, self), 1, 1)
	self.content = self.DEFAULT_CONTENT
	self.imageBg = UIControls.Image(self, "Bg")
	self.panelTip = UIControls.Panel(self, "AniPanel")
	self._tipDisplayed = false

	self:_setTipDisplay(false)
end

function LoginSpinner:updateNotice()
	if self.nowPoint % 4 == 0 then
		self.txtNotice:setText(self.content)
	elseif self.nowPoint % 4 == 1 then
		self.txtNotice:setText(self.content .. ".")
	elseif self.nowPoint % 4 == 2 then
		self.txtNotice:setText(self.content .. "..")
	else
		self.txtNotice:setText(self.content .. "...")
	end

	self.nowPoint = self.nowPoint + 1
end

function LoginSpinner:_showTipDelay()
	self:_setTipDisplay(true)
end

function LoginSpinner:setText(content)
	self.content = content or self.DEFAULT_CONTENT
	self.nowPoint = 0
end

function LoginSpinner:onOpen()
	LoginSpinner.super.onOpen(self)

	self.nowPoint = 0

	if self.noticeTimer then
		self.noticeTimer:Restart()
	end

	self.txtNotice:setText(self.content)

	if not self._tipDisplayed then
		self._showTipTimer:Restart()
	end
end

function LoginSpinner:onClose()
	if self.noticeTimer then
		self.noticeTimer:Stop()

		self.noticeTimer = nil
	end

	self._showTipTimer:Stop()
	self:_setTipDisplay(false)
	LoginSpinner.super.onClose(self)
end

function LoginSpinner:destroy()
	if self.noticeTimer then
		self.noticeTimer:Stop()

		self.noticeTimer = nil
	end

	LoginSpinner.super.destroy(self)
end

function LoginSpinner:_setTipDisplay(visible)
	self.panelTip:setVisible(visible)

	self._tipDisplayed = visible

	self.imageBg:setColorAlpha(visible and 200 or 0)
end

function LoginSpinner:delayedClose(time)
	if not self.delayClose then
		local function closeSpinner()
			local LoginSpinnerPanel = UIManager.tryGetUI("loginSpinner")

			if LoginSpinnerPanel and LoginSpinnerPanel == self.mWindow then
				self:setVisible(false)
			end
		end

		self.delayClose = Timer.New(closeSpinner, time, 1)

		self.delayClose:Restart()
	end
end

return LoginSpinner
