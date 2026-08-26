-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameResultView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameResultView", package.seeall)

local AssassinStealthGameResultView = class("AssassinStealthGameResultView", BaseView)

function AssassinStealthGameResultView:onInitView()
	self._btnclick = gohelper.findChildClickWithAudio(self.viewGO, "#simage_FullBG", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._gosucceed = gohelper.findChild(self.viewGO, "root/#go_succeed")
	self._gofailed = gohelper.findChild(self.viewGO, "root/#go_failed")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinStealthGameResultView:addEvents()
	self._btnclick:AddClickListener(self._onClick, self)
end

function AssassinStealthGameResultView:removeEvents()
	self._btnclick:RemoveClickListener()
end

function AssassinStealthGameResultView:_onClick()
	local gameState = AssassinStealthGameModel.instance:getGameState()
	local isWin = gameState == AssassinEnum.GameState.Win

	if isWin then
		AssassinStealthGameController.instance:exitGame()
		self:closeThis()
	else
		AssassinStealthGameController.instance:recoverAssassinStealthGame()
		self:closeThis()
	end
end

function AssassinStealthGameResultView:_editableInitView()
	local gameState = AssassinStealthGameModel.instance:getGameState()
	local isWin = gameState == AssassinEnum.GameState.Win

	gohelper.setActive(self._gosucceed, isWin)
	gohelper.setActive(self._gofailed, not isWin)

	if isWin then
		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_syncsucceed)
	end

	if isWin then
		if not StatEnum.Result2Cn[StatEnum.Result.Success] then
			local result = StatEnum.Result2Cn[StatEnum.Result.Fail]

			AssassinStealthGameController.instance:sendSettleTrack(result, not isWin)
		end
	end
end

function AssassinStealthGameResultView:onUpdateParam()
	return
end

function AssassinStealthGameResultView:onOpen()
	return
end

function AssassinStealthGameResultView:onClose()
	return
end

function AssassinStealthGameResultView:onDestroyView()
	return
end

return AssassinStealthGameResultView
