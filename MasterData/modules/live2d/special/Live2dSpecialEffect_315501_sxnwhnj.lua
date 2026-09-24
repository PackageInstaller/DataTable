-- chunkname: @modules/live2d/special/Live2dSpecialEffect_315501_sxnwhnj.lua

module("modules.live2d.special.Live2dSpecialEffect_315501_sxnwhnj", package.seeall)

local Live2dSpecialEffect_315501_sxnwhnj = class("Live2dSpecialEffect_315501_sxnwhnj", BaseLive2dSpecialEffect)
local b_idle = "b_idle"
local b_jiaohu01 = "b_jiaohu01"
local b_jiaohu03 = "b_jiaohu03"
local b_jiaohu04 = "b_jiaohu04"
local b_ruchang = "b_ruchang"
local ghostJH01 = "Drawables/bone3/effect-Bone/roleeffect_nws_jh01_3"
local inEffect = "Drawables/bone3/effect-Bone/roleeffect_nws_in3"
local outEffect = "Drawables/bone3/effect-Bone/roleeffect_nws_out3"
local nj1Effect = "Drawables/bone3/effect-Bone/roleeffect_nws_nj3"
local nj2Effect = "Drawables/bone5/effect-Bone/roleeffect_nws_nj5"
local anim_nj = "315501_sxnwhnj_nj"
local anim_in = "315501_sxnwhnj_in"
local anim_out = "315501_sxnwhnj_out"
local anim_xs = "315501_sxnwhnj_xs"
local anim_yc = "315501_sxnwhnj_yc"
local anim_jh01 = "315501_sxnwhnj_jh01"
local anim_jh03 = "315501_sxnwhnj_jh03"
local anim_jh04 = "315501_sxnwhnj_jh04"
local anim_rc = "315501_sxnwhnj_rc"
local audio_jh01 = 1315583
local audio_in = 1315585
local audio_nj = 1315586
local audio_out = 1315587
local idleTotalTime = 13.5
local idleNJMinTime = 6.84
local idlNJMaxTime = 6.94
local idleChangeMinTime = 0
local idlChangeMaxTime = 0.2
local showGhostTime = 60
local hideGhostTime = 30
local initShowGhostRate = 0.7

function Live2dSpecialEffect_315501_sxnwhnj:_onOpenView(name)
	if name == ViewName.SummonView then
		gohelper.setActive(self._ghostJHEffectGo, false)
		gohelper.setActive(self._inEffectGo, false)
		gohelper.setActive(self._outEffectGo, false)
		gohelper.setActive(self._nj1EffectGo, false)
		gohelper.setActive(self._nj2EffectGo, false)
	end
end

function Live2dSpecialEffect_315501_sxnwhnj:addEventListeners()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
end

function Live2dSpecialEffect_315501_sxnwhnj:removeEventListeners()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
end

local function restartEffect(go)
	if go then
		gohelper.setActive(go, false)
		gohelper.setActive(go, true)
	end
end

function Live2dSpecialEffect_315501_sxnwhnj:_onInit()
	self._ghostAnimTime = Time.time
	self._changeGhostTime = Time.time

	if not self._isInStoryView then
		TaskDispatcher.runRepeat(self._updateByFrame, self, 0)
	end
end

function Live2dSpecialEffect_315501_sxnwhnj:showModel()
	self._isHideModel = false
end

function Live2dSpecialEffect_315501_sxnwhnj:hideModel()
	gohelper.setActive(self._inEffectGo, false)
	gohelper.setActive(self._outEffectGo, false)
	gohelper.setActive(self._nj1EffectGo, false)
	gohelper.setActive(self._nj2EffectGo, false)

	self._isHideModel = true
end

function Live2dSpecialEffect_315501_sxnwhnj:showInScene(value)
	self._showInScene = value

	if not value and self._showGhost then
		self._showGhost = false

		if self._animator then
			self._animator:Play(anim_yc)
		end
	end

	self._changeGhostTime = Time.time

	if not value then
		gohelper.setActive(self._ghostJHEffectGo, false)
		gohelper.setActive(self._inEffectGo, false)
		gohelper.setActive(self._outEffectGo, false)
		gohelper.setActive(self._nj1EffectGo, false)
		gohelper.setActive(self._nj2EffectGo, false)
	end
end

function Live2dSpecialEffect_315501_sxnwhnj:_isShowInScene()
	return self._showInScene ~= false
end

function Live2dSpecialEffect_315501_sxnwhnj:_viewOnTop()
	if self._live2d then
		local viewName = self._live2d:getViewName()

		if self._live2d then
			return ViewHelper.instance:checkViewOnTheTop(self._live2d)
		end

		return true
	end
end

function Live2dSpecialEffect_315501_sxnwhnj:_updateByFrame()
	if not self._curBodyIdle or not self._idleAnimTime or self._isHideModel or not self:_isShowInScene() then
		return
	end

	if not self:_viewOnTop() then
		return
	end

	local ghostAnimTime = Time.time - self._ghostAnimTime
	local changeGhostTime = Time.time - self._changeGhostTime
	local time = Time.time - self._idleAnimTime
	local idleTime = time % idleTotalTime

	if ghostAnimTime > 0.5 and idleTime > idleNJMinTime and idleTime < idlNJMaxTime then
		self._ghostAnimTime = Time.time

		if self._animator and self._showGhost then
			self._animator:Play(anim_nj, 0, 0)
			restartEffect(self._nj1EffectGo)
			restartEffect(self._nj2EffectGo)
			AudioMgr.instance:trigger(audio_nj)
		end

		return
	end

	local canChange = self._showGhost and changeGhostTime >= showGhostTime or not self._showGhost and changeGhostTime >= hideGhostTime

	if canChange and idleTime > idleChangeMinTime and idleTime < idlChangeMaxTime then
		self._changeGhostTime = Time.time
		self._ghostAnimTime = Time.time
		self._showGhost = not self._showGhost

		if self._animator then
			if self._showGhost then
				self._animator:Play(anim_in)
				restartEffect(self._inEffectGo)
				AudioMgr.instance:trigger(audio_in)
			else
				self._animator:Play(anim_out)
				restartEffect(self._outEffectGo)
				AudioMgr.instance:trigger(audio_out)
			end
		end
	end
end

function Live2dSpecialEffect_315501_sxnwhnj:setLive2d(live2d)
	Live2dSpecialEffect_315501_sxnwhnj.super.setLive2d(self, live2d)

	self._spineGo = self._live2d:getSpineGo()
	self._animator = gohelper.findChildComponent(self._spineGo, "Drawables/roleeffect_anim", typeof(UnityEngine.Animator))

	if self._animator then
		self._animator.keepAnimatorStateOnDisable = true
	else
		logError("Live2dSpecialEffect_315501_sxnwhnj animator not found")
	end

	self._showGhost = math.random() <= initShowGhostRate
	self._isInStoryView = ViewMgr.instance:isOpen(ViewName.StoryView)

	if self._isInStoryView then
		self._showGhost = false
	end

	if self._animator then
		if self._showGhost then
			self._animator:Play(anim_xs, 0, 0)
		else
			self._animator:Play(anim_yc, 0, 0)
		end
	end

	self._ghostJHEffectGo = gohelper.findChild(self._spineGo, ghostJH01)
	self._inEffectGo = gohelper.findChild(self._spineGo, inEffect)
	self._outEffectGo = gohelper.findChild(self._spineGo, outEffect)
	self._nj1EffectGo = gohelper.findChild(self._spineGo, nj1Effect)
	self._nj2EffectGo = gohelper.findChild(self._spineGo, nj2Effect)

	if not self._ghostJHEffectGo then
		logError("Live2dSpecialEffect_315501_sxnwhnj ghostJH01 not found")
	end

	if not self._inEffectGo then
		logError("Live2dSpecialEffect_315501_sxnwhnj inEffect not found")
	end

	if not self._outEffectGo then
		logError("Live2dSpecialEffect_315501_sxnwhnj outEffect not found")
	end

	if not self._nj1EffectGo then
		logError("Live2dSpecialEffect_315501_sxnwhnj nj1Effect not found")
	end

	if not self._nj2EffectGo then
		logError("Live2dSpecialEffect_315501_sxnwhnj nj2Effect not found")
	end
end

function Live2dSpecialEffect_315501_sxnwhnj:_onBodyChange(prevBodyName, curBodyName)
	if not self._animator or self._isInStoryView or not self:_isShowInScene() then
		return
	end

	if curBodyName == b_jiaohu01 then
		if self._showGhost then
			self._showGhost = false

			self._animator:Play(anim_jh01, 0, 0)
			restartEffect(self._ghostJHEffectGo)
			AudioMgr.instance:trigger(audio_jh01)
		end
	elseif curBodyName == b_jiaohu03 then
		self._animator:Play(anim_jh03, 0, 0)
	elseif curBodyName == b_jiaohu04 then
		self._animator:Play(anim_jh04, 0, 0)
	elseif curBodyName == b_ruchang then
		self._animator:Play(anim_rc, 0, 0)

		self._showGhost = false
		self._ghostAnimTime = Time.time
		self._changeGhostTime = Time.time
	end

	if prevBodyName == b_jiaohu03 or prevBodyName == b_jiaohu04 then
		self._showGhost = false
		self._ghostAnimTime = Time.time
		self._changeGhostTime = Time.time
	end

	self._curBodyIdle = curBodyName == b_idle

	if self._curBodyIdle then
		self._idleAnimTime = Time.time
	end
end

function Live2dSpecialEffect_315501_sxnwhnj:onDestroy()
	Live2dSpecialEffect_315501_sxnwhnj.super.onDestroy(self)
	TaskDispatcher.cancelTask(self._updateByFrame, self)
end

return Live2dSpecialEffect_315501_sxnwhnj
