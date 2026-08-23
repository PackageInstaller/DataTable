local UpgradeFSM = import(".UpgradeFSM")
local UpgradeConst = require("upgrade.UpgradeConst")
local LoadingCommon = require("app.view.module.loading.common.LoadingCommon")
local UpgradeLayer = class("UpgradeLayer", function()
	return fgui.GComponent:create({
		resName = "UpgradeLayer",
		pkgPath = "ui/upgrade/upgrade",
		isFullScreen = true,
		pkgName = "upgrade"
	})
end)

function UpgradeLayer:ctor(arg_2_1)
	self.m_progressbar = self:getChild("progressbar")

	self.m_progressbar:setMax(100)
	self.m_progressbar:setVisible(false)

	self.m_tipText = self:getChild("tipText")

	self.m_tipText:disableAutoChange()

	self.m_descText = self:getChild("descText")

	self:updateDescText()

	self._callback = nil
	self._upgradeFSM = nil
	self._fsmSchedule = nil
	self.m_loopTransition = self.m_progressbar:getTransition("loop")

	self.m_loopTransition:play()
end

function UpgradeLayer:updateDescText()
	if not self.m_descText then
		return
	end

	local var_3_0 = LoadingCommon.getUpgradeTextList()
	local var_3_1 = math.random(#var_3_0)

	self.m_descText:setText((var_3_0[var_3_1] or nil) and (var_3_0[var_3_1].desc or ""))
end

function UpgradeLayer:fsmScheduleUpdate(arg_4_1)
	if self._upgradeFSM ~= nil then
		self._upgradeFSM:updateTickFSM(arg_4_1)
	end
end

function UpgradeLayer:start(arg_5_1)
	if self:_isRunning() then
		return
	end

	self._callback = arg_5_1
	self._upgradeFSM = UpgradeFSM.new()

	self._upgradeFSM:initPrepareFSM(self)
	self._upgradeFSM:setUIMessageCallback(handler(self, self._onUpgradeUIMessage))
	self._upgradeFSM:startupFSM()

	self._fsmSchedule = g.core.common.Scheduler:newSchedule(handler(self, self.fsmScheduleUpdate), 0.5)
end

function UpgradeLayer:stopAll()
	if self._fsmSchedule then
		g.core.common.Scheduler:cancelSchedule(self._fsmSchedule)

		self._fsmSchedule = nil
	end

	if self._upgradeFSM then
		self._upgradeFSM:cleanupFSM()

		self._upgradeFSM = nil
	end
end

function UpgradeLayer:_isRunning()
	return self._upgradeFSM ~= nil
end

function UpgradeLayer:_onUpgradeUIMessage(arg_8_1, arg_8_2)
	if tolua.isnull(self) then
		return
	end

	if arg_8_1 == UpgradeConst.EN_UI_MSG.VERSION then
		self:_onUpgradeUIVersion()
	elseif arg_8_1 == UpgradeConst.EN_UI_MSG.START then
		self:_onUpgradeUIStart(arg_8_2)
	elseif arg_8_1 == UpgradeConst.EN_UI_MSG.PROGRESS then
		self:_onUpgradeUIProgress(arg_8_2)
	elseif arg_8_1 == UpgradeConst.EN_UI_MSG.UNZIP then
		self:_onUpgradeUIUnzip()
	elseif arg_8_1 == UpgradeConst.EN_UI_MSG.LANGVER then
		self:_onUpgradeUILangVer()
	elseif arg_8_1 == UpgradeConst.EN_UI_MSG.LANGPROG then
		self.m_progressbar:setVisible(true)
		self:_onUpgradeUIProgress(arg_8_2)
	elseif arg_8_1 == UpgradeConst.EN_UI_MSG.REBOOT then
		self:_onUpgradeUIReboot()
	elseif arg_8_1 == UpgradeConst.EN_UI_MSG.FINISHED then
		self:_onUpgradeUIFinish()
	elseif arg_8_1 == UpgradeConst.EN_UI_MSG.ERROR then
		self:_onUpgradeUIError(arg_8_2)
	elseif arg_8_1 == UpgradeConst.EN_UI_MSG.AUTOLANG then
		self:_onUpgradeUIAutoLang()
	end
end

function UpgradeLayer:_onUpgradeUIVersion()
	self.m_tipText:setText(g.core.lang:get(100013) .. "0%")
end

function UpgradeLayer:_onUpgradeUIStart(arg_10_1)
	self.m_tipText:setText(g.core.lang:get(100013))
	self.m_progressbar:setVisible(true)
	self:_onUpgradeUIProgress(arg_10_1)
end

function UpgradeLayer:_onUpgradeUIProgress(arg_11_1)
	local var_11_0, var_11_1

	if arg_11_1 then
		var_11_0 = arg_11_1.total or 1

		if arg_11_1 then
			var_11_1 = arg_11_1.finish or 0
		end
	end

	local var_11_2 = 0

	if var_11_0 > 0 then
		var_11_2 = var_11_1 * 100 / var_11_0
	end

	self.m_tipText:setText(g.core.lang:get(100015) .. string.format("%d%%", var_11_2))
	self.m_progressbar:setValue(var_11_2)
end

function UpgradeLayer:_onUpgradeUIUnzip()
	self.m_tipText:setText(g.core.lang:get(100016))
end

function UpgradeLayer:_onUpgradeUILangVer()
	self.m_tipText:setText(g.core.lang:get(100014))
end

function UpgradeLayer:_onUpgradeUIReboot()
	self.m_tipText:setText(g.core.lang:get(100017))
	self:_downloadFinish(true)
	device.restartGame()
end

function UpgradeLayer:_onUpgradeUIFinish()
	self.m_tipText:setText(g.core.lang:get(100018))
	self:_downloadFinish(false)
end

function UpgradeLayer:_onUpgradeUIError(arg_16_1)
	self.m_tipText:setText(g.core.lang:get(100019) .. ((arg_16_1 and arg_16_1.customId or nil) and " : " .. arg_16_1.customId))
end

function UpgradeLayer:_onUpgradeUIAutoLang()
	self.m_tipText:setText(g.core.lang:get(100046))
end

function UpgradeLayer:_downloadFinish(arg_18_1)
	self:stopAll()

	if self._callback then
		self._callback(arg_18_1)
	end
end

return UpgradeLayer
