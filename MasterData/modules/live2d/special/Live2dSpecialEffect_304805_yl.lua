-- chunkname: @modules/live2d/special/Live2dSpecialEffect_304805_yl.lua

module("modules.live2d.special.Live2dSpecialEffect_304805_yl", package.seeall)

local Live2dSpecialEffect_304805_yl = class("Live2dSpecialEffect_304805_yl", BaseLive2dSpecialEffect)
local b_zhanshi = "b_zhanshi"
local blackHoleShowTime = 0.9
local blackHoleHideTime = 5.6

function Live2dSpecialEffect_304805_yl:_onBodyChange(prevBodyName, curBodyName)
	if curBodyName == b_zhanshi then
		self:_resetMusicValue()

		self._totalTime = 0

		TaskDispatcher.runRepeat(self._update, self, 0)
	end

	if prevBodyName == b_zhanshi then
		self:_resetMusicValue()
	end
end

function Live2dSpecialEffect_304805_yl:_update()
	if not self._totalTime then
		return
	end

	self._totalTime = self._totalTime + Time.deltaTime

	if not self._musicValue and self._totalTime >= blackHoleShowTime then
		self._musicValue = SettingsModel.instance:getMusicValue()

		SettingsModel.instance:setMusicValue(0)
	elseif self._musicValue and self._totalTime >= blackHoleHideTime then
		self:_resetMusicValue()
	end
end

function Live2dSpecialEffect_304805_yl:_resetMusicValue()
	if self._musicValue then
		if SettingsModel.instance:getMusicValue() == 0 then
			SettingsModel.instance:setMusicValue(self._musicValue)
		end

		self._musicValue = nil
	end

	TaskDispatcher.cancelTask(self._update, self)
end

function Live2dSpecialEffect_304805_yl:onDestroy()
	Live2dSpecialEffect_304805_yl.super.onDestroy(self)
	self:_resetMusicValue()
end

return Live2dSpecialEffect_304805_yl
