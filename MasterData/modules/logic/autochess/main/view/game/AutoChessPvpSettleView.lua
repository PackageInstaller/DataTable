-- chunkname: @modules/logic/autochess/main/view/game/AutoChessPvpSettleView.lua

module("modules.logic.autochess.main.view.game.AutoChessPvpSettleView", package.seeall)

local AutoChessPvpSettleView = class("AutoChessPvpSettleView", BaseView)
local chessLinesPosOffsetX = {
	48,
	48,
	47.6
}
local chessPlayerLinesPosX = {
	50,
	42.2,
	31
}
local chessPlayerLinesPosY = {
	-81,
	-120,
	-160
}

function AutoChessPvpSettleView:onInitView()
	self._goWin = gohelper.findChild(self.viewGO, "root/#go_Win")
	self._goLose = gohelper.findChild(self.viewGO, "root/#go_Lose")
	self._goBadge = gohelper.findChild(self.viewGO, "root/Left/#go_Badge")
	self._txtRound = gohelper.findChildText(self.viewGO, "root/Right/Round/image/#txt_Round")
	self._txtDamage = gohelper.findChildText(self.viewGO, "root/Right/Damage/image/#txt_Damage")
	self._txtWarnExp = gohelper.findChildText(self.viewGO, "root/Right/WarnExp/image/#txt_WarnExp")
	self._goSnapChess = gohelper.findChild(self.viewGO, "root/Right/Screen/simage_chessbg/#go_SnapChess")
	self._goSnapLeaderMesh = gohelper.findChild(self.viewGO, "root/Right/Screen/simage_chessbg/#go_SnapLeaderMesh")
	self._btnSaveBattle = gohelper.findChildButtonWithAudio(self.viewGO, "root/Right/Screen/#btn_SaveBattle")
	self._goSaved = gohelper.findChild(self.viewGO, "root/Right/Screen/#go_Saved")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessPvpSettleView:addEvents()
	self._btnSaveBattle:AddClickListener(self.onClickSaveBattle, self)
end

function AutoChessPvpSettleView:removeEvents()
	self._btnSaveBattle:RemoveClickListener()
end

function AutoChessPvpSettleView:onClickSaveBattle()
	local actId = Activity182Model.instance:getCurActId()

	Activity182Rpc.instance:sendAct182SaveSnapshotRequest(actId, self.onSaveSnapshotResponse, self)
end

function AutoChessPvpSettleView:onClickModalMask()
	self:closeThis()
end

function AutoChessPvpSettleView:_editableInitView()
	local badgeGo = self:getResInst(AutoChessStrEnum.ResPath.BadgeItem, self._goBadge)

	self.badgeItem = MonoHelper.addNoUpdateLuaComOnceToGo(badgeGo, AutoChessBadgeItem)

	gohelper.setActive(self._goSaved, false)
	gohelper.setActive(self._btnSaveBattle, true)
end

function AutoChessPvpSettleView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_award_get)

	self.settleData = AutoChessModel.instance.settleData

	if self.settleData then
		local actMo = Activity182Model.instance:getActMo()

		self.badgeItem:setData(self.settleData.rank, actMo.score, AutoChessBadgeItem.ShowType.PvpSettleView)
		self.badgeItem:playProgressAnim(self.settleData.score)

		local episodeCo = AutoChessConfig.instance:getEpisodeCO(self.settleData.episodeId)
		local maxRound = episodeCo.maxRound

		self._txtRound.text = string.format("%d/%d", self.settleData.round, maxRound)
		self._txtDamage.text = self.settleData.totalInjury
		self._txtWarnExp.text = self.settleData.warnExp

		gohelper.setActive(self._goWin, self.settleData.round == maxRound)
		gohelper.setActive(self._goLose, self.settleData.round ~= maxRound)
	end

	gohelper.setActive(self._goSnapChess, false)
	gohelper.setActive(self._goSnapLeaderMesh, false)
	self:_createSnapshotMap()
end

function AutoChessPvpSettleView:onClose()
	AutoChessController.instance:checkPopView()
	AutoChessController.instance:onSettleViewClose()
end

function AutoChessPvpSettleView:onSaveSnapshotResponse(_, resultCode)
	if resultCode == 0 then
		GameFacade.showToast(ToastEnum.AutoChessSnapShotSave)
		gohelper.setActive(self._goSaved, true)
		gohelper.setActive(self._btnSaveBattle, false)
	end
end

function AutoChessPvpSettleView:_createSnapshotMap()
	self.settleData = AutoChessModel.instance.settleData

	local leaderCo = lua_auto_chess_master.configDict[self.settleData.masterId]

	if leaderCo then
		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goSnapLeaderMesh, AutoChessMeshComp)

		comp:setData(leaderCo.image, false, true)
	end

	local warZones = self.settleData.warZones

	self:refreshMonsterInfoView(warZones)
end

function AutoChessPvpSettleView:refreshMonsterInfoView(warZones)
	self._chessGoList = self:getUserDataTb_()

	local chessDatas = {}

	for _, zone in ipairs(warZones) do
		local id = zone.id
		local positions = zone.positions

		for _, positionData in ipairs(positions) do
			local idx = positionData.index
			local chessData = positionData.chess
			local chessId = chessData.id

			if chessId ~= 0 then
				local data = {}

				data.zoneId = id
				data.chessId = chessId
				data.idx = idx
				chessDatas[#chessDatas + 1] = data
			end
		end
	end

	local snapChessGo = self._goSnapChess

	for _, chessData in ipairs(chessDatas) do
		local config = AutoChessConfig.instance:getChessCfg(chessData.chessId)

		if config then
			local go = gohelper.cloneInPlace(snapChessGo, chessData.chessId)

			self._chessGoList[#self._chessGoList + 1] = go

			gohelper.setActive(go, true)

			local goMesh = gohelper.findChild(go, "Mesh")
			local comp1 = MonoHelper.addNoUpdateLuaComOnceToGo(goMesh, AutoChessMeshComp)

			comp1:setData(config.image)

			local chessPosX = chessPlayerLinesPosX[chessData.zoneId] + chessData.idx * chessLinesPosOffsetX[chessData.zoneId]
			local chessPosY = chessPlayerLinesPosY[chessData.zoneId]

			recthelper.setAnchor(go.transform, chessPosX, chessPosY)

			local x, y, z = transformhelper.getLocalScale(go.transform)

			x = -1 * x

			transformhelper.setLocalScale(go.transform, x, y, z)
		end
	end
end

return AutoChessPvpSettleView
