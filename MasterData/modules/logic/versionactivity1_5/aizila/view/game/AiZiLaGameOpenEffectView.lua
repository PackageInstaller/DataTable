-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGameOpenEffectView.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameOpenEffectView", package.seeall)

local AiZiLaGameOpenEffectView = class("AiZiLaGameOpenEffectView", BaseView)

function AiZiLaGameOpenEffectView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "ani/#simage_FullBG")
	self._txtInfo = gohelper.findChildText(self.viewGO, "ani/Title/#txt_Info")
	self._txtdaydesc = gohelper.findChildText(self.viewGO, "ani/Title/image_Info/#txt_daydesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaGameOpenEffectView:addEvents()
	return
end

function AiZiLaGameOpenEffectView:removeEvents()
	return
end

function AiZiLaGameOpenEffectView:_editableInitView()
	return
end

function AiZiLaGameOpenEffectView:onUpdateParam()
	return
end

function AiZiLaGameOpenEffectView:onOpen()
	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._onEscape, self)
	end

	self._callback = self.viewParam and self.viewParam.callback
	self._callbackObj = self.viewParam and self.viewParam.callbackObj

	TaskDispatcher.runDelay(self._onAnimFinish, self, AiZiLaEnum.AnimatorTime.EffectViewOpen)
	TaskDispatcher.runDelay(self.closeThis, self, AiZiLaEnum.AnimatorTime.EffectViewOpen + 0.1)
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_level_transition)
end

function AiZiLaGameOpenEffectView:_onEscape()
	return
end

function AiZiLaGameOpenEffectView:onClose()
	return
end

function AiZiLaGameOpenEffectView:_onAnimFinish()
	if self._callback then
		if self._callbackObj then
			self._callback(self._callbackObj)
		else
			self._callback()
		end

		self._callbackObj = nil
		self._callback = nil
	end
end

function AiZiLaGameOpenEffectView:onDestroyView()
	TaskDispatcher.cancelTask(self._onAnimFinish, self)
	TaskDispatcher.cancelTask(self.closeThis, self)
end

function AiZiLaGameOpenEffectView:refreshUI()
	local episodeMO = AiZiLaGameModel.instance:getEpisodeMO()

	if not episodeMO then
		return
	end

	local episodeCfg = episodeMO:getConfig()

	self._txtInfo.text = episodeCfg and episodeCfg.name
	self._txtdaydesc.text = formatLuaLang("v1a5_aizila_day_explore", episodeMO.day)
end

function AiZiLaGameOpenEffectView:playViewAnimator(animName)
	return
end

return AiZiLaGameOpenEffectView
