-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/view/home/NetInfoWidget.lua

NetInfoWidget = class("NetInfoWidget", BaseWidget)

NetInfoWidget:has("_gameServer", {
	is = "r"
}):injectWith("GameServerAgent")

NetStatus = {
	kNoNet = 0,
	kWWAN = 2,
	kWifi = 1
}
NetDelayStatus = {
	kLow = 1,
	kMiddle = 2,
	kHight = 3
}
NetColor = {
	cc.c3b(255, 255, 255),
	cc.c3b(255, 255, 255),
	cc.c3b(255, 255, 255)
}

function getNetDelayStatus(gameServer)
	local netDelayStatus
	local netDelay = gameServer and gameServer:getNetDelay() or 0

	return netDelay < 1000 and NetDelayStatus.kLow or netDelay < 2000 and NetDelayStatus.kMiddle or NetDelayStatus.kHight
end

function NetInfoWidget.class:createWidgetNode()
	local resFile = "asset/ui/NetInfoWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

function NetInfoWidget:initialize(view)
	super.initialize(self, view)
end

function NetInfoWidget:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function NetInfoWidget:setupView()
	if self._timer then
		return
	end

	local view = self:getView()
	local nonetPanel = view:getChildByFullName("nonet")
	local wifiPanel = view:getChildByFullName("wifi")
	local wwanPanel = view:getChildByFullName("wwan")

	local function update()
		local netStatus = app.getDevice():getNetworkStatus()
		local gameServer = self:getGameServer()
		local netDelayStatus = getNetDelayStatus(gameServer)

		if netStatus == NetStatus.kWifi then
			nonetPanel:setVisible(false)
			wifiPanel:setVisible(true)
			wwanPanel:setVisible(false)

			local low = wifiPanel:getChildByFullName("low")
			local middle = wifiPanel:getChildByFullName("middle")
			local hight = wifiPanel:getChildByFullName("hight")

			low:setVisible(netDelayStatus == NetDelayStatus.kLow)
			middle:setVisible(netDelayStatus ~= NetDelayStatus.kHight)
			hight:setVisible(true)
			hight:setColor(NetColor[3])

			if low:isVisible() then
				low:setColor(NetColor[1])
				middle:setColor(NetColor[1])
				hight:setColor(NetColor[1])
			elseif middle:isVisible() then
				middle:setColor(NetColor[2])
				hight:setColor(NetColor[2])
			end
		elseif netStatus == NetStatus.kWWAN then
			nonetPanel:setVisible(false)
			wifiPanel:setVisible(false)
			wwanPanel:setVisible(true)

			local low = wwanPanel:getChildByFullName("low")
			local middle = wwanPanel:getChildByFullName("middle")
			local hight = wwanPanel:getChildByFullName("hight")

			low:setVisible(netDelayStatus == NetDelayStatus.kLow)
			middle:setVisible(netDelayStatus ~= NetDelayStatus.kHight)
			hight:setVisible(true)
			hight:setColor(NetColor[3])

			if low:isVisible() then
				low:setColor(NetColor[1])
				middle:setColor(NetColor[1])
				hight:setColor(NetColor[1])
			elseif middle:isVisible() then
				middle:setColor(NetColor[2])
				hight:setColor(NetColor[2])
			end
		elseif netStatus == NetStatus.kNoNet then
			nonetPanel:setVisible(true)
			wifiPanel:setVisible(false)
			wwanPanel:setVisible(false)
		end
	end

	if device.platform ~= "mac" and device.platform ~= "windows" then
		self._timer = LuaScheduler:getInstance():schedule(update, 5, true)

		update()
	end
end
