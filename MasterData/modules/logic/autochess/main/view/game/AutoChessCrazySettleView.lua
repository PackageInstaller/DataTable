-- chunkname: @modules/logic/autochess/main/view/game/AutoChessCrazySettleView.lua

module("modules.logic.autochess.main.view.game.AutoChessCrazySettleView", package.seeall)

local AutoChessCrazySettleView = class("AutoChessCrazySettleView", BaseView)

function AutoChessCrazySettleView:onInitView()
	self._txtRound = gohelper.findChildText(self.viewGO, "Round/image/#txt_Round")
	self._txtHp = gohelper.findChildText(self.viewGO, "Hp/#txt_Hp")
	self._txtDamage = gohelper.findChildText(self.viewGO, "Damage/#txt_Damage")
	self._goWin = gohelper.findChild(self.viewGO, "#go_Win")
	self._goLose = gohelper.findChild(self.viewGO, "#go_Lose")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessCrazySettleView:onClickModalMask()
	self:closeThis()
end

function AutoChessCrazySettleView:onOpen()
	self.settleData = AutoChessModel.instance.settleData

	if self.settleData then
		self._txtRound.text = self.settleData.round
		self._txtHp.text = self.settleData.remainingHp
		self._txtDamage.text = self.settleData.totalInjury

		local actMo = Activity182Model.instance:getActMo()
		local maxRound = actMo:getMaxRound(self.settleData.episodeId)

		gohelper.setActive(self._goWin, self.settleData.round == maxRound)
		gohelper.setActive(self._goLose, self.settleData.round ~= maxRound)
	end
end

function AutoChessCrazySettleView:onClose()
	AutoChessController.instance:onSettleViewClose()
end

return AutoChessCrazySettleView
