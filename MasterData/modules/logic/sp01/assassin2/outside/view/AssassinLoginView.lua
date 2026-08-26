-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinLoginView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinLoginView", package.seeall)

local AssassinLoginView = class("AssassinLoginView", BaseView)

function AssassinLoginView:onInitView()
	self._btnclick = gohelper.findChildClickWithAudio(self.viewGO, "root/simage_fullbg", AudioEnum2_9.StealthGame.play_ui_cikeshang_start)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinLoginView:addEvents()
	self._btnclick:AddClickListener(self._onClick, self)
end

function AssassinLoginView:removeEvents()
	self._btnclick:RemoveClickListener()
end

function AssassinLoginView:_onClick()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.ClosingLoginView, true)
	self._animatorPlayer:Play(UIAnimationName.Close, self._onCloseAnimDone, self)
end

function AssassinLoginView:_onCloseAnimDone()
	AssassinController.instance:realOpenAssassinMapView(self.viewParam)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.ClosingLoginView, false)
end

function AssassinLoginView:_editableInitView()
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
end

function AssassinLoginView:onUpdateParam()
	return
end

function AssassinLoginView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_shadow)
end

function AssassinLoginView:onClose()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.ClosingLoginView, false)
end

function AssassinLoginView:onDestroyView()
	return
end

return AssassinLoginView
