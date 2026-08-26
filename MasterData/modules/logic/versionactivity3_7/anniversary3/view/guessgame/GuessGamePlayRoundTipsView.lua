-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayRoundTipsView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayRoundTipsView", package.seeall)

local GuessGamePlayRoundTipsView = class("GuessGamePlayRoundTipsView", BaseView)

function GuessGamePlayRoundTipsView:onInitView()
	self._goroundtip = gohelper.findChild(self.viewGO, "#go_roundtip")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_roundtip/#txt_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGamePlayRoundTipsView:addEvents()
	return
end

function GuessGamePlayRoundTipsView:removeEvents()
	return
end

function GuessGamePlayRoundTipsView:_editableInitView()
	return
end

function GuessGamePlayRoundTipsView:onUpdateParam()
	return
end

function GuessGamePlayRoundTipsView:onOpen()
	self._roundId = self.viewParam.round

	AudioMgr.instance:trigger(AudioEnum3_7.Anniversary3.play_ui_beiai_kapai_play_round)
	TaskDispatcher.runDelay(self._onStartFinished, self, 1.5)
	self:_refresh()
end

function GuessGamePlayRoundTipsView:_refresh()
	local npcId = GuessGameModel.instance:getGameRoleByIndex(self._roundId)
	local npcCo = Activity234Config.instance:getNpcCo(npcId)

	self._txttips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("guessgame_npcround_tip"), npcCo.name)
end

function GuessGamePlayRoundTipsView:_onStartFinished()
	self:closeThis()
end

function GuessGamePlayRoundTipsView:onClose()
	GuessGameController.instance:dispatchEvent(GuessGameEvent.OnRoundTipsShowFinished)
end

function GuessGamePlayRoundTipsView:onDestroyView()
	TaskDispatcher.cancelTask(self._onStartFinished, self)
end

return GuessGamePlayRoundTipsView
