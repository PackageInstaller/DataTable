-- chunkname: @modules/logic/autochess/main/view/game/AutoChessResultView.lua

module("modules.logic.autochess.main.view.game.AutoChessResultView", package.seeall)

local AutoChessResultView = class("AutoChessResultView", BaseView)

function AutoChessResultView:onInitView()
	self._txtHp = gohelper.findChildText(self.viewGO, "Hp/#txt_Hp")
	self._txtDamage = gohelper.findChildText(self.viewGO, "Damage/#txt_Damage")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessResultView:onClickModalMask()
	self:closeThis()
end

function AutoChessResultView:onOpen()
	if ViewMgr.instance:isOpen(ViewName.AutoChessCollectionView) then
		ViewMgr.instance:closeView(ViewName.AutoChessCollectionView)
	end

	local groupId = AudioMgr.instance:getIdFromString("autochess")
	local stateId = AudioMgr.instance:getIdFromString("prepare")

	AudioMgr.instance:setSwitch(groupId, stateId)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)

	local resultData = AutoChessModel.instance.resultData

	if resultData then
		self._txtHp.text = resultData.remainingHp
		self._txtDamage.text = resultData.injury

		AutoChessController.instance:statFightEnd(tonumber(resultData.remainingHp))
	end
end

function AutoChessResultView:onClose()
	AutoChessController.instance:onResultViewClose()
end

return AutoChessResultView
