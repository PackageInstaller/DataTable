-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Login\\LoginQueueBox.lua

local RPC = require("Framework/RPC")
local strClassName = "LoginQueueBox"
local LoginQueueBox = Class(strClassName, UIControls.Window)
local NetService = require("Network/NetService")
local EventConst = require("EventConst")
local EventCenter = EventCenter

function LoginQueueBox:ctor()
	self:initUI()

	self._timerTick = Timer.New(Slot(self.onTick, self), 1, -1)
	self.slotOnDisconnect = Slot(self.onDisconnect, self)
end

function LoginQueueBox:initUI()
	self.labelTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.labelNum = UIControls.Label(self, "BgPanel/TextNum")
	self.labelServer = UIControls.Label(self, "BgPanel/TextServer")
	self.labelTime = UIControls.Label(self, "BgPanel/TextTime")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnEnter")

	self.btnClose:addEventClick(self.onClickLeave)
end

function LoginQueueBox:onOpen()
	LoginQueueBox.super.onOpen(self)
	EventCenter.addEventListener(EventConst.ZONE_SERVER_DISCONNECT, self.slotOnDisconnect)
	self._timerTick:Restart()
end

function LoginQueueBox:onClose()
	LoginQueueBox.super.onClose(self)
	EventCenter.removeEventListener(EventConst.ZONE_SERVER_DISCONNECT, self.slotOnDisconnect)
	self._timerTick:Stop()
end

function LoginQueueBox:onDisconnect()
	self:setVisible(false)
end

function LoginQueueBox:showQueueInfo(serverName, estimateTime, seatNo, total)
	if serverName ~= nil and self._serverName ~= serverName then
		self._serverName = serverName

		self.labelServer:setText(serverName)
	end

	if seatNo ~= nil and self._seatNo ~= seatNo then
		self._seatNo = seatNo

		self.labelNum:setText(string.format(Lang.get(30432), seatNo))
	end

	if estimateTime ~= nil and self._estimateTime ~= estimateTime then
		self._estimateTime = estimateTime

		local hour, min, sec = 0, 0, 0

		hour = math.modf(estimateTime / 3600)
		min = math.modf(estimateTime / 60)
		min = min - hour * 60
		sec = estimateTime % 60

		local text

		if hour == 0 then
			text = string.format(Lang.get(30433), math.max(1, min))
		else
			text = string.format(Lang.get(30434), hour, min)
		end

		self.labelTime:setText(text)
	end
end

function LoginQueueBox:onClickLeave(sender)
	self:setVisible(false)
	RPC.roleLeaveLoginQueue()
	NetService.disconnect()
end

function LoginQueueBox:onTick()
	if self._estimateTime then
		self:showQueueInfo(nil, math.max(self._estimateTime - 1, 1))
	end
end

return LoginQueueBox
