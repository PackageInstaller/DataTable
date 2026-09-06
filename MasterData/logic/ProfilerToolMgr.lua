-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/profilertool/ProfilerToolMgr.lua

module("logic.extensions.profilertool.ProfilerToolMgr", package.seeall)

local ProfilerToolMgr = class("ProfilerToolMgr")

ProfilerToolMgr.FrameCountToCutEffect = 10

function ProfilerToolMgr:ctor()
	return
end

function ProfilerToolMgr:clear()
	self:removeAvgFpsTimer()
end

function ProfilerToolMgr:showFps(_show, _setting)
	local mainCameraGO = goutil.find("MainCamera")

	if mainCameraGO then
		local _showFps = mainCameraGO:GetComponent(typeof(ShowFPSOnGUI)) or mainCameraGO:AddComponent(typeof(ShowFPSOnGUI))

		_showFps.enabled = _show

		_showFps:SetShowOnGui(_show)

		if _setting then
			_showFps.fpsMeasuringDelta = _setting.fpsMeasuringDelta or 1
			_showFps.posX = _setting.posX or -200
			_showFps.posY = _setting.posY or -88
			_showFps.fontSzie = _setting.fontSzie or 35
			_showFps.color = _setting.color or Color.New(1, 1, 1, 1)
		end
	end
end

function ProfilerToolMgr:monitorAvgFps()
	self:removeAvgFpsTimer()

	if not self._showFps then
		local mainCameraGO = goutil.find("MainCamera")

		if mainCameraGO then
			self._showFps = mainCameraGO:GetComponent(typeof(ShowFPSOnGUI)) or mainCameraGO:AddComponent(typeof(ShowFPSOnGUI))
		end
	end

	if self._showFps then
		self._showFps.fpsAvgMeasuringDelta = 15
		self._setTimered = true

		settimer(self._showFps.fpsAvgMeasuringDelta, self._setAvgFpsTimer, self, true)
	end
end

function ProfilerToolMgr:_setAvgFpsTimer()
	if HardwareQuality.getDynamicResolutionSwitch() == HardwareQuality.DynamicResolutionLevelType.Close then
		self:removeAvgFpsTimer()

		return
	end

	if self._showFps then
		local _avgFps = self._showFps:GetFrameCountAvg()

		if _avgFps > 1 and _avgFps < ProfilerToolMgr.FrameCountToCutEffect then
			if Framework.OSDef.isEditor then
				FloatWordMgr.instance:show("游戏卡顿，自动降画质已关闭")
			end

			self:removeAvgFpsTimer()
		end
	end
end

function ProfilerToolMgr:reduceQuality()
	self:removeAvgFpsTimer()
end

function ProfilerToolMgr:removeAvgFpsTimer()
	if self._setTimered then
		removetimer(self._setAvgFpsTimer, self)

		self._setTimered = false
	end
end

ProfilerToolMgr.instance = ProfilerToolMgr.New()

return ProfilerToolMgr
