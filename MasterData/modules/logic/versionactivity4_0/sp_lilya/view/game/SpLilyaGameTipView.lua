-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/view/game/SpLilyaGameTipView.lua

module("modules.logic.versionactivity4_0.sp_lilya.view.game.SpLilyaGameTipView", package.seeall)

local SpLilyaGameTipView = class("SpLilyaGameTipView", BaseView)

function SpLilyaGameTipView:onInitView()
	self._txtbossname = gohelper.findChildText(self.viewGO, "image_namebg/#txt_bossname")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SpLilyaGameTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function SpLilyaGameTipView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function SpLilyaGameTipView:_btncloseOnClick()
	self:closeThis()
end

function SpLilyaGameTipView:_editableInitView()
	return
end

function SpLilyaGameTipView:onUpdateParam()
	return
end

function SpLilyaGameTipView:onOpen()
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum4_0.SpLilya.play_ui_yuanzheng_mrs_pause)
	TaskDispatcher.runDelay(self.closeThis, self, SpLilyaEnum.TipCloseDelay)
end

function SpLilyaGameTipView:refreshUI()
	local actId = SpLilyaModel.instance:getActId()
	local episodeId = SpLilyaGameModel.instance:getCurEpisodeId()
	local gameConfig = SpLilyaConfig.instance:getGameCo(actId, episodeId)

	self.gameConfig = gameConfig
	self._txtbossname.text = luaLang("v4a0_sp_lilya_episode_title")
	self._txtdesc.text = gameConfig.winDesc
end

function SpLilyaGameTipView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self, SpLilyaEnum.TipCloseDelay)
	SpLilyaGameController.instance:startGame()
end

function SpLilyaGameTipView:onDestroyView()
	return
end

return SpLilyaGameTipView
