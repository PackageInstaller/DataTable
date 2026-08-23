local UpgradeConst = require("upgrade.UpgradeConst")
local var_0_1 = g.core.config.download_reward_info
local var_0_2 = 10485760
local SilentLayer = class("SilentLayer", function()
	return fgui.GComponent:create({
		resName = "SilentLayer",
		pkgPath = "ui/upgrade/upgrade",
		isFullScreen = true,
		pkgName = "upgrade"
	})
end)

function SilentLayer:ctor(arg_2_1)
	self.m_progressbar = self:getChild("progImg")

	self.m_progressbar:setWidth(0)

	self.m_tipText = self:getChild("tipText")

	self.m_tipText:disableAutoChange()

	self._maxWidth = 1200
	self._isPause = false
	self._pausePop = nil
	self.m_pauseText = self:getChild("pauseText")

	self.m_pauseText:setText(g.core.lang:get(100053))

	self.m_isPauseController = self:getController("isPause")
	self.m_pauseBtn = self:getChild("pauseBtn")

	self.m_pauseBtn:addClickListener(handler(self, self._onPauseClick))

	self._gemGamePop = nil
	self.m_gemGameBtn = self:getChild("gemGameBtn")

	self.m_gemGameBtn:addClickListener(handler(self, self._onGemGameBtnClick))

	self.m_preBtn = self:getChild("preBtn")

	self.m_preBtn:addClickListener(handler(self, self._onPreBgBtnClick))

	self.m_nextBtn = self:getChild("nextBtn")

	self.m_nextBtn:addClickListener(handler(self, self._onNextBgBtnClick))

	self.m_changeBgComp = self:getChild("bgLoader")
	self.m_isAwardController = self:getController("isAward")
	self._callback = nil
	self._fsmSchedule = nil
	self._startTS = nil
	self._startDown = nil
	self._curDown = 0
	self._curSpeed = "0B"
	self._curUnzipSize = 0
	self._totalUnzipSize = 0
	self._isInit = false
	self._awardCompArray = {}
	self.m_isOsController = self:getController("isOs")

	self.m_isOsController:setSelectedIndex(BATTLE_CONFIG_TYPE.isOs and 1 or 0)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
		event_id = g.core.const.ConstMgr.SuperSdkConst.SILENT_LOAD_OLD_TIP
	})
end

function SilentLayer:_initDownLoadAwardPos()
	local var_3_0 = self:getChild("awardPos"):getPosition()

	for iter_3_0 = 1, var_0_1.getLength() do
		local var_3_1 = var_0_1.indexOf(iter_3_0)
		local var_3_2 = fgui.UIPackage:createObject("upgrade", "WaitGameAwardIcon")

		var_3_2:updateAwardIcon(var_3_1, 0)
		var_3_2:setPosition(var_3_0.x + self._maxWidth * (var_3_1.progress / 10) / 100, var_3_0.y)
		self:addChild(var_3_2)
		table.insert(self._awardCompArray, var_3_2)
	end

	self.m_isAwardController:setSelectedIndex(g.core.model.User.waitGameData:isGetNewDownLoadAward() and 1 or 0)
end

function SilentLayer:onLoad()
	self._maxWidth = 1200 + display.width - CC_DESIGN_RESOLUTION.width - 2 * cc.Director:getInstance():getSafeAreaRect().x

	self:getChild("progBgImg"):setWidth(self._maxWidth)

	if not self._isInit then
		self:_initDownLoadAwardPos()
	end
end

function SilentLayer:_onPauseClick()
	if not self._isPause then
		local var_5_0 = require("app.view.base.component.BaseAssistPopComp").new({
			title = g.core.lang:get(100051),
			text = g.core.lang:get(100052),
			text_ok = g.core.lang:get(1153),
			text_cancel = g.core.lang:get(1147),
			handler_ok = handler(self, self._pauseSilentUpgrade),
			handler_cancel = handler(self, self._pausePopClose)
		})

		g.core.module.ModuleManager:pushPopup(var_5_0)

		self._pausePop = var_5_0
	else
		self._isPause = false

		self.m_isPauseController:setSelectedIndex(0)

		if self._upgradeSilent then
			self._upgradeSilent.setPause(false)
		end
	end
end

function SilentLayer:_pauseSilentUpgrade()
	self._isPause = true

	self.m_isPauseController:setSelectedIndex(1)

	if self._upgradeSilent then
		self._upgradeSilent.setPause(true)
	end

	self._pausePop = nil
end

function SilentLayer:_pausePopClose()
	self._pausePop = nil
end

function SilentLayer:fsmScheduleUpdate(arg_8_1)
	if self._startTS then
		local var_8_0 = os.time() - self._startTS

		if self._curDown - self._startDown > 1 and var_8_0 > 1 then
			self._curSpeed = g.core.utils.Number.toMemoryShortSize((self._curDown - self._startDown) / var_8_0)
		end
	end
end

function SilentLayer:stopAll()
	if self._fsmSchedule then
		g.core.common.Scheduler:cancelSchedule(self._fsmSchedule)

		self._fsmSchedule = nil
	end
end

function SilentLayer:_onUpgradeUIStart(arg_10_1)
	self.m_tipText:setText(g.core.lang:get(100013))

	if arg_10_1 and arg_10_1.total > 1 and self._startTS == nil then
		self._startTS = os.time()
		self._startDown = arg_10_1.finish
	end

	self.m_progressbar:setVisible(true)
	self:_onUpgradeUIProgress(arg_10_1)
end

function SilentLayer:_onUpgradeUIProgress(arg_11_1)
	local var_11_0, var_11_1

	if arg_11_1 then
		var_11_0 = arg_11_1.total or 1

		if arg_11_1 then
			var_11_1 = arg_11_1.finish or 0
		end
	end

	local var_11_2 = 0

	if var_11_0 > 1 then
		var_11_2 = var_11_1 * 100 / var_11_0
		self._curDown = var_11_1

		self.m_tipText:setText(g.core.lang:get(100049, {
			total = g.core.utils.Number.toMemoryShortSize(var_11_0 - var_11_1),
			speed = self._curSpeed
		}))
	end

	self.m_progressbar:setWidth(self._maxWidth * var_11_2 / 100)

	for iter_11_0, iter_11_1 in ipairs(self._awardCompArray) do
		if iter_11_1 then
			iter_11_1:upadteAwardState(var_11_2)
		end
	end
end

function SilentLayer:_onUpgradeUIUnzip()
	self.m_tipText:setText(g.core.lang:get(100016))
end

function SilentLayer:_onUpgradeUIFinish()
	self.m_tipText:setText(g.core.lang:get(100018))
	self:_downloadFinish(false)
end

function SilentLayer:_onUpgradeUIError(arg_14_1)
	self.m_tipText:setText(g.core.lang:get(100019) .. ((arg_14_1 and arg_14_1.customId or nil) and " : " .. arg_14_1.customId))
end

function SilentLayer:_downloadFinish(arg_15_1)
	self:stopAll()

	if self._pausePop then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self._pausePop)

		self._pausePop = nil
	end

	if self._gemGamePop then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self._gemGamePop)

		self._gemGamePop = nil
	end

	if self._callback then
		self._callback(arg_15_1)
	end
end

function SilentLayer:startSilentUpgrade(arg_16_1)
	self._callback = arg_16_1
	self._fsmSchedule = g.core.common.Scheduler:newSchedule(handler(self, self.fsmScheduleUpdate), 1)

	local UpgradeSilent = require("upgrade.UpgradeSilent")

	UpgradeSilent.start(handler(self, self._onUpgradeSilentEvent))

	self._upgradeSilent = UpgradeSilent
end

function SilentLayer:_onUpgradeSilentEvent(arg_17_1, arg_17_2)
	if tolua.isnull(self) then
		return
	end

	if arg_17_1 == UpgradeConst.EN_UI_SILENT.START then
		self:_onUpgradeUIStart(arg_17_2)
	elseif arg_17_1 == UpgradeConst.EN_UI_SILENT.ERROR then
		self:_onUpgradeUIError(arg_17_2)
	elseif arg_17_1 == UpgradeConst.EN_UI_SILENT.PROGRESS then
		self:_onUpgradeUIProgress(arg_17_2)
	elseif arg_17_1 == UpgradeConst.EN_UI_SILENT.FINISHED then
		self:_onUpgradeUIFinish()
	elseif arg_17_1 == UpgradeConst.EN_UI_SILENT.UNZIP_START then
		self:_onUpgradeUIUnzip()
		self:_onUnzipProgress(false, arg_17_2)
	elseif arg_17_1 == UpgradeConst.EN_UI_SILENT.UNZIP_OK then
		self:_onUnzipProgress(true)
	end
end

function SilentLayer:_onUnzipProgress(arg_18_1, arg_18_2)
	self:stopAllFGActions()

	if arg_18_1 then
		self.m_tipText:setText(g.core.lang:get(100050, {
			pros = 100
		}))
	else
		self._curUnzipSize = (os.time() - arg_18_2.startTime) * var_0_2
		self._totalUnzipSize = math.max(cc.FileUtils:getInstance():getFileSize(arg_18_2.filePath), 1)

		self:runFGAction(fgui.FRepeatForever:create(fgui.FSequence:create({
			fgui.FCallFunc:create(handler(self, self._refreshUnzipProgress)),
			fgui.FDelayTime:create(0.1)
		})))
	end
end

function SilentLayer:_refreshUnzipProgress()
	if self._totalUnzipSize < 1 then
		return
	end

	local var_19_0 = math.floor(self._curUnzipSize * 100 / self._totalUnzipSize)

	if var_19_0 > 98 then
		var_19_0 = 98
	end

	self.m_tipText:setText((g.core.lang:get(100050, {
		pros = var_19_0
	})))

	if var_19_0 >= 98 then
		self:stopAllFGActions()
	else
		self._curUnzipSize = var_19_0 > 90 and self._curUnzipSize + var_0_2 * 0.1 or var_19_0 > 60 and self._curUnzipSize + var_0_2 * 0.2 or self._curUnzipSize + var_0_2 * 0.3
	end
end

function SilentLayer:_onGemGameBtnClick()
	local var_20_0 = require("upgrade.waitGame.WaitGameGemPop").new({
		isPause = self._isPause
	})

	g.core.module.ModuleManager:pushPopup(var_20_0)

	self._gemGamePop = var_20_0
end

function SilentLayer:_onPreBgBtnClick()
	self.m_changeBgComp:updatePreBg()
end

function SilentLayer:_onNextBgBtnClick()
	self.m_changeBgComp:updateNextBg()
end

return SilentLayer
