-- chunkname: @modules/live2d/special/Live2dSpecialEffect_310504_zxqe.lua

module("modules.live2d.special.Live2dSpecialEffect_310504_zxqe", package.seeall)

local Live2dSpecialEffect_310504_zxqe = class("Live2dSpecialEffect_310504_zxqe", BaseLive2dSpecialEffect)
local b_fengzhizi = "b_fengzhizi"
local b_idle = "b_idle"
local b_jiaocha = "b_jiaocha"
local b_jiaocha1 = "b_jiaocha1"
local b_jiaocha2 = "b_jiaocha2"
local b_jiaocha3 = "b_jiaocha3"
local b_erji = "b_erji"
local b_erji1 = "b_erji1"
local b_zhaoshou = "b_zhaoshou"
local b_diantou = "b_diantou"
local b_yaotou = "b_yaotou"
local b_taitou = "b_taitou"
local b_taitou01 = "b_taitou01"
local b_sikao = "b_sikao"
local b_ruchang = "b_ruchang"
local b_jiaohu01 = "b_jiaohu01"
local b_jiaohu02 = "b_jiaohu02"
local b_jiaohu03 = "b_jiaohu03"
local b_jiaohu04 = "b_jiaohu04"

Live2dSpecialEffect_310504_zxqe.speedScale = 800
Live2dSpecialEffect_310504_zxqe.BodySpeed = {
	[b_fengzhizi] = {
		to = 3
	},
	[b_taitou01] = {
		to = 2
	},
	[b_idle] = {
		to = 1
	},
	[b_jiaocha] = {
		to = 1
	},
	[b_jiaocha1] = {
		to = 1
	},
	[b_jiaocha2] = {
		to = 1
	},
	[b_jiaocha3] = {
		to = 1
	},
	[b_erji] = {
		to = 1
	},
	[b_erji1] = {
		to = 1
	},
	[b_zhaoshou] = {
		to = 1
	},
	[b_diantou] = {
		to = 1
	},
	[b_yaotou] = {
		to = 1
	},
	[b_taitou] = {
		to = 1
	},
	[b_taitou01] = {
		to = 1
	},
	[b_sikao] = {
		to = 1
	},
	[b_jiaohu01] = {
		to = 1
	},
	[b_jiaohu02] = {
		to = 1
	},
	[b_jiaohu04] = {
		to = 1
	}
}
Live2dSpecialEffect_310504_zxqe.BodySequenceSpeed = {
	[b_ruchang] = {
		{
			time = 6,
			to = 5,
			from = 1
		},
		{
			time = 3,
			to = 2,
			from = 5
		},
		{
			time = 1.3,
			to = 1,
			from = 2
		}
	},
	[b_jiaohu03] = {
		{
			time = 4.1,
			to = 2,
			from = 1
		},
		{
			time = 1,
			to = 5,
			from = 2
		},
		{
			time = 11,
			to = 5,
			from = 5
		},
		{
			time = 2,
			to = 2,
			from = 5
		},
		{
			time = 3,
			to = 1,
			from = 2
		}
	}
}

function Live2dSpecialEffect_310504_zxqe:_onInit()
	Live2dSpecialEffect_310504_zxqe.super._onInit(self)

	self._index = 0
	self._maxParam = 500
	self._minParam = 0
	self._speed = 0

	TaskDispatcher.cancelTask(self._update, self)
	TaskDispatcher.runRepeat(self._update, self, 0)
end

function Live2dSpecialEffect_310504_zxqe:setLive2d(live2d)
	Live2dSpecialEffect_310504_zxqe.super.setLive2d(self, live2d)

	self._spineGo = self._live2d:getSpineGo()
end

function Live2dSpecialEffect_310504_zxqe:_onBodyChange(prevBodyName, curBodyName)
	self._seqSpeedConfig = Live2dSpecialEffect_310504_zxqe.BodySequenceSpeed[curBodyName]

	if self._seqSpeedConfig then
		self._seqSpeedIndex = 1

		self:_nextSeqSpeed()

		return
	end

	local speedConfig = Live2dSpecialEffect_310504_zxqe.BodySpeed[curBodyName]

	if speedConfig then
		self:_changeSpeed(speedConfig)
	end
end

function Live2dSpecialEffect_310504_zxqe:_nextSeqSpeed()
	if self._seqSpeedConfig then
		local config = self._seqSpeedConfig[self._seqSpeedIndex]

		if config then
			self._seqSpeedIndex = self._seqSpeedIndex + 1

			self:_changeSpeed(config)
		end
	end
end

function Live2dSpecialEffect_310504_zxqe:_changeSpeed(speedConfig)
	self:_killTween()

	if not speedConfig.from then
		local to = speedConfig.to
		local time = speedConfig.time

		if not time then
			self:_onFadeInUpdate(to)
			self:_onFadeInFinish()

			return
		end

		self._tweenId = ZProj.TweenHelper.DOTweenFloat(speedConfig.from, to, time, self._onFadeInUpdate, self._onFadeInFinish, self, nil, EaseType.Linear)
	end
end

function Live2dSpecialEffect_310504_zxqe:_killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function Live2dSpecialEffect_310504_zxqe:_onFadeInUpdate(value)
	self._speed = value * Live2dSpecialEffect_310504_zxqe.speedScale
end

function Live2dSpecialEffect_310504_zxqe:_onFadeInFinish()
	self:_nextSeqSpeed()
end

function Live2dSpecialEffect_310504_zxqe:_update()
	if self._speed <= 0 then
		return
	end

	self._index = self._index + self._speed * Time.deltaTime
	self._index = math.floor(self._index)

	if self._index > self._maxParam then
		self._index = 0
	end

	if self._live2d and not self._paramIndex and not gohelper.isNil(self._spineGo) and self._spineGo.activeInHierarchy then
		self._paramIndex = self._live2d:addParameter("Param", 0, self._index)
	end

	if self._live2d and self._paramIndex and not gohelper.isNil(self._spineGo) then
		self._live2d:updateParameter(self._paramIndex, self._index)
	end
end

function Live2dSpecialEffect_310504_zxqe:onDestroy()
	TaskDispatcher.cancelTask(self._update, self)
	self:_killTween()
end

return Live2dSpecialEffect_310504_zxqe
