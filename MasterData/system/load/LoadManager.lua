-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Load\\LoadManager.lua

local GameSettingHelper = Framework.Settings.GameSettingHelper
local LoadManager = {}
local self = LoadManager

self._loadPhases = {}
self.mRunning = false
self.aupPowerOn = true

function LoadManager.clear()
	for i, phase in ipairs(self._loadPhases) do
		phase:clear()
	end

	self._loadPhases = {}
end

function LoadManager.addLoadPhase(doLoad)
	local LoadPhase = require("System/Load/LoadPhase")
	local phase = LoadPhase(self, doLoad)

	table.insert(self._loadPhases, phase)

	return phase
end

function LoadManager.start(finishCallback, loadinguiName)
	self.mLoadEndCallback = finishCallback
	self.mCurLoadingUIName = loadinguiName or "loadingui"

	if next(self._loadPhases) == nil then
		self.over()

		return
	end

	UIManager.getUI(self.mCurLoadingUIName, true):startLoad()

	self.totalRate = 0

	for i, phase in ipairs(self._loadPhases) do
		self.totalRate = self.totalRate + phase:getMaxRate()
	end

	self.mRunning = true

	self._setAUPLoading()

	if self._updateTimer == nil then
		self._updateTimer = Timer.New(Slot(self.onRateUpdate, self), 0.1, -1)
	end

	self._updateTimer:Start()
	self.onRateUpdate()
end

function LoadManager.over()
	if self._updateTimer then
		self._updateTimer:Stop()
	end

	self.mRunning = false

	self._resetAUPLoading()

	local ui = UIManager.getUI(self.mCurLoadingUIName, nil, false)

	if ui then
		ui:setVisible(false)
	end

	if self.mLoadEndCallback ~= nil then
		self.mLoadEndCallback()
	end
end

function LoadManager.onRateUpdate()
	local curRate = 0

	for i, phase in ipairs(self._loadPhases) do
		if phase.mRunning then
			curRate = curRate + phase:getRate()

			break
		elseif phase.mComplete then
			curRate = curRate + phase.mCurRate
		elseif not phase.mRunning then
			phase:start()

			break
		end
	end

	curRate = self.totalRate == 0 and 1 or curRate / self.totalRate

	local ui = UIManager.getUI(self.mCurLoadingUIName, nil, false)
	local needWait

	if ui then
		needWait = ui:setRate(curRate)
	end

	if curRate >= 1 and needWait == nil then
		self.over()
	end
end

function LoadManager._setAUPLoading(...)
	if self.aupPowerOn then
		GameSettingHelper.SetAUPTimeSlice(8)
	end
end

function LoadManager._resetAUPLoading(...)
	if self.aupPowerOn then
		GameSettingHelper.SetAUPTimeSlice(2)
	end
end

return LoadManager
