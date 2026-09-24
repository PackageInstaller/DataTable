-- chunkname: @modules/live2d/special/Live2dSpecialEffect_315503_tlzchnj.lua

module("modules.live2d.special.Live2dSpecialEffect_315503_tlzchnj", package.seeall)

local Live2dSpecialEffect_315503_tlzchnj = class("Live2dSpecialEffect_315503_tlzchnj", BaseLive2dSpecialEffect)
local b_idle = "b_idle"
local b_jiaohu01 = "b_jiaohu_01"
local b_jiaohu03 = "b_jiaohu_03"
local b_jiaohu04 = "b_jiaohu_04"
local b_tanshou = "b_tanshou"
local b_juntuan = "b_juntuan"
local b_feixingqi = "b_feixingqi"
local b_ruchang = "b_ruchang"
local hideGhostBody = {
	[b_tanshou] = true,
	[b_juntuan] = true,
	[b_feixingqi] = true
}
local anim_in = "315503_tlzchnj_in"
local anim_out = "315503_tlzchnj_out"
local anim_xs = "315503_tlzchnj_xs"
local anim_yc = "315503_tlzchnj_yc"
local anim_jh01 = "315503_tlzchnj_jh01"
local anim_jh03 = "315503_tlzchnj_jh03"
local anim_jh04 = "315503_tlzchnj_jh04"
local audio_in = 1315590
local audio_out = 1315591
local showGhostTime = 60
local hideGhostTime = 30
local initShowGhostRate = 0.7

function Live2dSpecialEffect_315503_tlzchnj:_onOpenView(name)
	if name == ViewName.SummonView then
		gohelper.setActive(self._fadeInEffect, false)
		gohelper.setActive(self._fadeOutEffect, false)
	end
end

function Live2dSpecialEffect_315503_tlzchnj:addEventListeners()
	self.addEventCb(self, CharacterVoiceController.instance, CharacterVoiceEvent.HongNJSkinInteractionStart, self._onHongNJSkinInteractionStart, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
end

function Live2dSpecialEffect_315503_tlzchnj:removeEventListeners()
	self.removeEventCb(self, CharacterVoiceController.instance, CharacterVoiceEvent.HongNJSkinInteractionStart, self._onHongNJSkinInteractionStart, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
end

function Live2dSpecialEffect_315503_tlzchnj:_onHongNJSkinInteractionStart()
	self._mainOut = true
	self._musicValue = SettingsModel.instance:getMusicValue()
	self._effectValue = SettingsModel.instance:getEffectValue()

	if self._fadeOutTweenId then
		ZProj.TweenHelper.KillById(self._fadeOutTweenId)

		self._fadeOutTweenId = nil
	end

	self._fadeOutTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 1.4, self._fadeOutHandler, self._fadeOutCompleteHandler, self)
end

function Live2dSpecialEffect_315503_tlzchnj:_fadeOutHandler(value)
	if self._musicValue then
		SettingsModel.instance:setMusicValue(self._musicValue * value)
	end

	if self._effectValue then
		SettingsModel.instance:setEffectValue(self._effectValue * value)
	end
end

function Live2dSpecialEffect_315503_tlzchnj:_fadeOutCompleteHandler()
	if self._musicValue then
		SettingsModel.instance:setMusicValue(0)
	end

	if self._effectValue then
		SettingsModel.instance:setEffectValue(0)
	end
end

function Live2dSpecialEffect_315503_tlzchnj:_onInit()
	self._isInStoryView = ViewMgr.instance:isOpen(ViewName.StoryView)
	self._changeGhostTime = Time.time

	if not self._isInStoryView then
		TaskDispatcher.runRepeat(self._updateByFrame, self, 0)
	end
end

function Live2dSpecialEffect_315503_tlzchnj:showModel()
	self._isHideModel = false
end

function Live2dSpecialEffect_315503_tlzchnj:hideModel()
	gohelper.setActive(self._fadeInEffect, false)
	gohelper.setActive(self._fadeOutEffect, false)

	self._isHideModel = true
end

function Live2dSpecialEffect_315503_tlzchnj:showInScene(value)
	self._showInScene = value

	if not value and self._showGhost then
		self._showGhost = false

		if self._animator then
			self._animator:Play(anim_yc)
		end
	end

	self._changeGhostTime = Time.time

	if not value then
		gohelper.setActive(self._fadeOutEffect, false)
		gohelper.setActive(self._fadeInEffect, false)
	end
end

function Live2dSpecialEffect_315503_tlzchnj:_isShowInScene()
	return self._showInScene ~= false
end

function Live2dSpecialEffect_315503_tlzchnj:_viewOnTop()
	if self._live2d then
		local viewName = self._live2d:getViewName()

		if self._live2d then
			return ViewHelper.instance:checkViewOnTheTop(self._live2d)
		end

		return true
	end
end

function Live2dSpecialEffect_315503_tlzchnj:_updateByFrame()
	if self._curBodyHideGhost or self._isHideModel or not self:_isShowInScene() then
		return
	end

	if not self:_viewOnTop() then
		return
	end

	local changeGhostTime = Time.time - self._changeGhostTime
	local canChange = self._showGhost and changeGhostTime >= showGhostTime or not self._showGhost and changeGhostTime >= hideGhostTime

	if canChange then
		self._changeGhostTime = Time.time
		self._showGhost = not self._showGhost

		if self._animator then
			if self._showGhost then
				self._animator:Play(anim_in)
				gohelper.setActive(self._fadeInEffect, true)
				gohelper.setActive(self._fadeOutEffect, false)
				AudioMgr.instance:trigger(audio_in)
			else
				self._animator:Play(anim_out)
				gohelper.setActive(self._fadeOutEffect, true)
				gohelper.setActive(self._fadeInEffect, false)
				AudioMgr.instance:trigger(audio_out)
			end

			self._showEffectTime = Time.time
		end
	end

	if self._showEffectTime and Time.time - self._showEffectTime >= 3.5 then
		self._showEffectTime = nil

		gohelper.setActive(self._fadeOutEffect, false)
		gohelper.setActive(self._fadeInEffect, false)
	end
end

function Live2dSpecialEffect_315503_tlzchnj:setLive2d(live2d)
	Live2dSpecialEffect_315503_tlzchnj.super.setLive2d(self, live2d)

	self._spineGo = self._live2d:getSpineGo()
	self._animator = gohelper.findChildComponent(self._spineGo, "Drawables/roleeffect_anim", typeof(UnityEngine.Animator))

	if self._animator then
		self._animator.keepAnimatorStateOnDisable = true
	else
		logError("Live2dSpecialEffect_315503_tlzchnj animator not found")
	end

	self._showGhost = math.random() <= initShowGhostRate

	if self._animator then
		if self._showGhost then
			self._animator:Play(anim_xs)
		else
			self._animator:Play(anim_yc)
		end
	end

	self._fadeInEffect = gohelper.findChild(self._spineGo, "Drawables/bone6/effect-Bone/roleeffect_nws_in6")
	self._fadeOutEffect = gohelper.findChild(self._spineGo, "Drawables/bone6/effect-Bone/roleeffect_nws_out6")
end

function Live2dSpecialEffect_315503_tlzchnj:_onBodyChange(prevBodyName, curBodyName)
	if not self._animator or self._isInStoryView or not self:_isShowInScene() then
		return
	end

	if curBodyName == b_jiaohu01 then
		self._animator:Play(anim_jh01)
	elseif curBodyName == b_jiaohu03 then
		TaskDispatcher.cancelTask(self._resetMusicValue, self)
		self._animator:Play(anim_jh03)
		TaskDispatcher.cancelTask(self._delayFadeIn, self)
		TaskDispatcher.runDelay(self._delayFadeIn, self, 7)
	elseif curBodyName == b_jiaohu04 then
		TaskDispatcher.cancelTask(self._resetMusicValue, self)
		self._animator:Play(anim_jh04)
		TaskDispatcher.cancelTask(self._delayFadeIn, self)
		TaskDispatcher.runDelay(self._delayFadeIn, self, 3.7)
	elseif curBodyName == b_ruchang then
		if self._showGhost then
			self._animator:Play(anim_yc)

			self._showGhost = false
		end

		self._changeGhostTime = Time.time
	elseif curBodyName == b_idle then
		TaskDispatcher.cancelTask(self._resetMusicValue, self)

		if self._musicValue or self._effectValue or self._mainOut then
			TaskDispatcher.runDelay(self._resetMusicValue, self, 0.1)
		end
	end

	local oldStatus = self._curBodyHideGhost

	self._curBodyHideGhost = hideGhostBody[curBodyName]

	if self._curBodyHideGhost and self._showGhost then
		self._showGhost = false

		self._animator:Play(anim_out)
		gohelper.setActive(self._fadeOutEffect, true)

		self._showEffectTime = Time.time
	end

	if oldStatus ~= self._curBodyHideGhost then
		self._changeGhostTime = Time.time
	end

	if prevBodyName == b_jiaohu03 or prevBodyName == b_jiaohu04 then
		self:_resetMusicValue()
	end
end

function Live2dSpecialEffect_315503_tlzchnj:_delayFadeIn()
	if self._fadeInTweenId then
		ZProj.TweenHelper.KillById(self._fadeInTweenId)

		self._fadeInTweenId = nil
	end

	self._fadeInTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 3, self._fadeInHandler, self._resetMusicValue, self)
end

function Live2dSpecialEffect_315503_tlzchnj:_fadeInHandler(value)
	if self._musicValue then
		SettingsModel.instance:setMusicValue(self._musicValue * value)
	end

	if self._effectValue then
		SettingsModel.instance:setEffectValue(self._effectValue * value)
	end
end

function Live2dSpecialEffect_315503_tlzchnj:_resetMusicValue()
	if self._fadeInTweenId then
		ZProj.TweenHelper.KillById(self._fadeInTweenId)

		self._fadeInTweenId = nil
	end

	if self._musicValue then
		SettingsModel.instance:setMusicValue(self._musicValue)

		self._musicValue = nil
	end

	if self._effectValue then
		SettingsModel.instance:setEffectValue(self._effectValue)

		self._effectValue = nil
	end

	if self._mainOut then
		CharacterVoiceController.instance:dispatchEvent(CharacterVoiceEvent.PlayMainViewAnim, "mainview_in")

		self._mainOut = nil
	end
end

function Live2dSpecialEffect_315503_tlzchnj:onDestroy()
	Live2dSpecialEffect_315503_tlzchnj.super.onDestroy(self)

	if self._fadeOutTweenId then
		ZProj.TweenHelper.KillById(self._fadeOutTweenId)

		self._fadeOutTweenId = nil
	end

	if self._fadeInTweenId then
		ZProj.TweenHelper.KillById(self._fadeInTweenId)

		self._fadeInTweenId = nil
	end

	self:_resetMusicValue()
	TaskDispatcher.cancelTask(self._updateByFrame, self)
	TaskDispatcher.cancelTask(self._delayFadeIn, self)
	TaskDispatcher.cancelTask(self._resetMusicValue, self)
end

return Live2dSpecialEffect_315503_tlzchnj
