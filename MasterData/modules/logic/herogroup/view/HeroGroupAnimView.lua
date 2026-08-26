-- chunkname: @modules/logic/herogroup/view/HeroGroupAnimView.lua

module("modules.logic.herogroup.view.HeroGroupAnimView", package.seeall)

local HeroGroupAnimView = class("HeroGroupAnimView", BaseView)

function HeroGroupAnimView:onInitView()
	self._goherogroupcontain = gohelper.findChild(self.viewGO, "herogroupcontain")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._goBtnContain = gohelper.findChild(self.viewGO, "#go_container/btnContain")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupAnimView:addEvents()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupExitEffect, self._playHeroGroupExitEffect, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.PlayCloseHeroGroupAnimation, self._playCloseHeroGroupAnimation, self)
end

function HeroGroupAnimView:removeEvents()
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupExitEffect, self._playHeroGroupExitEffect, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.PlayCloseHeroGroupAnimation, self._playCloseHeroGroupAnimation, self)
end

function HeroGroupAnimView:_editableInitView()
	self._heroContainAnim = self._goherogroupcontain:GetComponent(typeof(UnityEngine.Animator))
	self._anim = self._gocontainer:GetComponent(typeof(UnityEngine.Animator))
	self._btnContainAnim = self._goBtnContain:GetComponent(typeof(UnityEngine.Animator))
end

function HeroGroupAnimView:_playHeroGroupExitEffect()
	self._anim:Play(UIAnimationName.Close, 0, 0)
	self._btnContainAnim:Play(UIAnimationName.Close, 0, 0)
end

function HeroGroupAnimView:_playCloseHeroGroupAnimation()
	self._anim:Play(UIAnimationName.Close, 0, 0)
	self._btnContainAnim:Play(UIAnimationName.Close, 0, 0)

	self._heroContainAnim.enabled = true

	self._heroContainAnim:Play("herogroupcontain_out", 0, 0)
	TaskDispatcher.runDelay(self._closeHeroContainAnim, self, 0.133)
end

function HeroGroupAnimView:_closeHeroContainAnim()
	if self._heroContainAnim then
		self._heroContainAnim.enabled = false
	end
end

function HeroGroupAnimView:onClose()
	self:_playHeroGroupExitEffect()

	self._heroContainAnim.enabled = true

	self._heroContainAnim:Play("herogroupcontain_out", 0, 0)
	TaskDispatcher.cancelTask(self._closeHeroContainAnim, self)
end

return HeroGroupAnimView
