-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqiendgameView.lua

module("logic.extensions.doushouqi.view.DoushouqiendgameView", package.seeall)

local DoushouqiendgameView = class("DoushouqiendgameView", ViewComponent)

function DoushouqiendgameView:ctor()
	DoushouqiendgameView.super.ctor(self)
end

function DoushouqiendgameView:unbindEvents()
	DoushouqiendgameView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnAgain:RemoveClickListener()
end

function DoushouqiendgameView:bindEvents()
	DoushouqiendgameView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnAgain:AddClickListener(self._onClickbtnAgain, self)
end

function DoushouqiendgameView:buildUI()
	DoushouqiendgameView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnAgain = self:getBtn("btnAgain")
	self._player2Go = self:getGo("player2")
	self._player1Go = self:getGo("player1")
	self._txtScore = self:getTxt("txtScore")
	self._sbGo = self:getGo("sb")
	self._slGo = self:getGo("sl")
	self._pjGo = self:getGo("pj")
	self._playerItems = {}

	self:_buildPlayer(self._playerItems, DoushouqiController.Dir.Left, self._player1Go)
	self:_buildPlayer(self._playerItems, DoushouqiController.Dir.Right, self._player2Go)
end

function DoushouqiendgameView:_buildPlayer(list, index, root)
	list[index] = {
		goHead = goutil.findChild(root, "head"),
		goTag = goutil.findChild(root, "tag"),
		txtTag = goutil.findChildTextComponent(root, "tag/txt"),
		txtName = goutil.findChildTextComponent(root, "txtName")
	}
end

function DoushouqiendgameView:onExit()
	DoushouqiendgameView.super.onExit(self)
	DoushouqiGameController.instance:clearGameDatas()
end

function DoushouqiendgameView:onEnter()
	DoushouqiendgameView.super.onEnter(self)

	self._endMsg = self:getFirstParam()
	self._activityId = self._endMsg.activityId
	self._chessType = self._endMsg.typeId

	self:_updateUI()
end

function DoushouqiendgameView:_onClickbtnClose()
	local typeInfo = DoushouqiModel.instance:getTypeInfo(DoushouqiController.ChessType.Doushouqi)
	local finishNewHand = typeInfo.finishNewHand

	if not finishNewHand then
		BeastFightingChessAgent.instance:sendBeastFightingChessFinishNewHandReq(self._activityId, DoushouqiController.ChessType.Doushouqi)
	end

	UIStateManager.instance:popByName(ViewName.DoushouqigameView)
	UIStateManager.instance:popByName(ViewName.DoushouqitigergameView)
	self:close()
end

function DoushouqiendgameView:_onClickbtnAgain()
	UIStateManager.instance:popByName(ViewName.DoushouqigameView)
	UIStateManager.instance:popByName(ViewName.DoushouqitigergameView)

	if DoushouqiController.instance:isBan(self._activityId, self._chessType) then
		local banTip = DoushouqiController.instance:getBanTip(self._activityId, self._chessType)

		FloatWordMgr.instance:show(banTip)
	else
		UIStateManager.instance:push(ViewName.DoushouqimatchView, self._activityId, self._chessType)
	end

	self:close()
end

function DoushouqiendgameView:_updateUI()
	self:_updatePlayersData()
	self:_updateWinState()
end

function DoushouqiendgameView:_updatePlayersData()
	local item = self._playerItems[DoushouqiController.Dir.Left]
	local itemOther = self._playerItems[DoushouqiController.Dir.Right]

	HeadItemController.instance:resetHeadCell(item.goHead)
	HeadItemController.instance:resetHeadCell(itemOther.goHead)
	goutil.setActive(item.goTag, self._chessType == DoushouqiController.ChessType.Weihuqi)
	goutil.setActive(itemOther.goTag, self._chessType == DoushouqiController.ChessType.Weihuqi)
	HeadItemController.instance:setMyHeadCell(item.goHead)

	item.txtName.text = string.format("%s\n%s", RoleModel.instance:getUserName(), RoleModel.instance:getAreaName())

	if self._endMsg.isRobot then
		itemOther.txtName.text = DoushouqiConfig.instance:getRobotName(self._activityId)

		HeadItemController.instance:setHeadCell(itemOther.goHead, 1, 1, 0)
	else
		local headInfo = self._endMsg.opHeadInfo

		HeadItemController.instance:setHeadCellByInfo(itemOther.goHead, headInfo)

		itemOther.txtName.text = string.format("%s\n%s", headInfo.userName, headInfo.areaName)
	end

	local symbol = self._endMsg.newSocre < self._endMsg.oldScore and "-" or "+"

	self._txtScore.text = string.format("%s%s", symbol, math.abs(self._endMsg.newSocre - self._endMsg.oldScore))

	if self._chessType == DoushouqiController.ChessType.Weihuqi then
		if DoushouqiTigerGameController.instance:getMyRoundSide() == DoushouqiTigerGameController.Side.Red then
			item.txtTag.text = lang("红方")
			itemOther.txtTag.text = lang("蓝方")
		else
			item.txtTag.text = lang("蓝方")
			itemOther.txtTag.text = lang("红方")
		end
	end
end

function DoushouqiendgameView:_updateWinState()
	local isWin = self._endMsg.result == 1
	local isLost = self._endMsg.result == 2
	local isPj = not isWin and not isLost

	goutil.setActive(self._slGo, not isPj and isWin)
	goutil.setActive(self._sbGo, not isPj and isLost)
	goutil.setActive(self._pjGo, isPj)
end

return DoushouqiendgameView
