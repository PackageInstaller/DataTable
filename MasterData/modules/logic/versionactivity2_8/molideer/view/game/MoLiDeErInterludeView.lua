-- chunkname: @modules/logic/versionactivity2_8/molideer/view/game/MoLiDeErInterludeView.lua

module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErInterludeView", package.seeall)

local MoLiDeErInterludeView = class("MoLiDeErInterludeView", BaseView)

function MoLiDeErInterludeView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._txtStart = gohelper.findChildText(self.viewGO, "#txt_Start")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErInterludeView:addEvents()
	return
end

function MoLiDeErInterludeView:removeEvents()
	return
end

function MoLiDeErInterludeView:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function MoLiDeErInterludeView:onUpdateParam()
	return
end

function MoLiDeErInterludeView:onOpen()
	self._callback = self.viewParam and self.viewParam.callback
	self._callbackObj = self.viewParam and self.viewParam.callbackObj

	if self.viewParam then
		self._isNextRound = self.viewParam.isNextRound or false
	end

	self._animator:Play(MoLiDeErEnum.AnimName.InterludeViewOpen)
	TaskDispatcher.runDelay(self.onAnimFinish, self, MoLiDeErEnum.AnimationTime.InterludeDuration)
	TaskDispatcher.runDelay(self.closeThis, self, MoLiDeErEnum.AnimationTime.InterludeCloseDuration)
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_level_transition)
end

function MoLiDeErInterludeView:refreshUI()
	local desc

	if not self._isNextRound then
		local episodeCfg = MoLiDeErModel.instance:getCurEpisode()

		desc = episodeCfg and episodeCfg.name
	else
		local round = MoLiDeErGameModel.instance:getCurRound()

		desc = luaLang("molideer_interludeview_txt_title")
		desc = GameUtil.getSubPlaceholderLuaLangOneParam(desc, round)
	end

	local largeText = LuaUtil.subString(desc, 1, 1)
	local smallText = LuaUtil.subString(desc, 2)

	self._txtStart.text = string.format("<size=120>%s</size>%s", largeText, smallText)
end

function MoLiDeErInterludeView:onAnimFinish()
	self._animator:Play(MoLiDeErEnum.AnimName.InterludeViewClose)

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

function MoLiDeErInterludeView:onClose()
	return
end

function MoLiDeErInterludeView:onDestroyView()
	TaskDispatcher.cancelTask(self._onAnimFinish, self)
	TaskDispatcher.cancelTask(self.closeThis, self)
end

return MoLiDeErInterludeView
