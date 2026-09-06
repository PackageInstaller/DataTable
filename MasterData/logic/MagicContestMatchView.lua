-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/view/MagicContestMatchView.lua

module("logic.extensions.magiccontest.view.MagicContestMatchView", package.seeall)

local MagicContestMatchView = class("MagicContestMatchView", ViewComponent)

function MagicContestMatchView:buildUI()
	MagicContestMatchView.super.buildUI(self)

	self._txtTime = self:getTxt("matching/txtTime")
	self._matching = self:getGo("matching")
	self._btnCancel = self:getGo("matching/btnCancel")
	self._success = self:getGo("success")
	self._playerCellLeft = self:getGo("success/playerCellLeft")
	self._playerCellRight = self:getGo("success/playerCellRight")
	self._playerCells = {
		self._playerCellLeft,
		self._playerCellRight
	}
end

function MagicContestMatchView:bindEvents()
	MagicContestMatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
end

function MagicContestMatchView:unbindEvents()
	MagicContestMatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
end

function MagicContestMatchView:onEnter()
	MagicContestMatchView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._batType = checknumber(params[2])
	self._subMo = MagicContestController.instance:getSubMo(self._activityId)

	GameUtil.SetActive(self._success, false)
	GameUtil.SetActive(self._matching, true)

	self._txtTime.text = 0

	self.addGEvent(self, GlobalNotify.HandlePM_MagicContestStartMatchRes, self._handlePM_MagicContestStartMatchRes, self)

	self._matchResMsg = nil
	self._curMatChTime = 0
	self._maxMatchTime = Mathf.Random(3, 10)

	settimer(1, self._onTicking, self, true)
	self:_onTicking()
end

function MagicContestMatchView:onExit()
	MagicContestMatchView.super.onExit(self)
	removetimer(self._onTicking, self)
	removetimer(self._endMatch, self)

	self._matchResMsg = nil
end

function MagicContestMatchView:_handlePM_MagicContestStartMatchRes(status, msg)
	if (msg and checknumber(msg.matchPlayerId) == 0 or nil) and false then
		self._matchResMsg = msg

		self:_showSuccess()
	else
		self._matchResMsg = nil

		FloatWordMgr.instance:show("匹配失败")
		self:close()
	end
end

function MagicContestMatchView:_onTicking()
	if self._curMatChTime >= self._maxMatchTime then
		removetimer(self._onTicking, self)
		MagicContestController.instance:sendPM_MagicContestStartMatchReq(self._activityId, self._batType)

		return
	end

	self._curMatChTime = self._curMatChTime + 1
	self._txtTime.text = GameUtil.FormatTimeSymbol(self._curMatChTime)
end

function MagicContestMatchView:_showSuccess()
	GameUtil.SetActive(self._success, true)
	GameUtil.SetActive(self._matching, false)
	settimer(2, self._endMatch, self, false)
end

function MagicContestMatchView:_endMatch()
	local msg = self._matchResMsg

	self:close()
	MagicContestController.instance:enterBattle(self._activityId, msg)
end

function MagicContestMatchView:_onClear()
	return
end

function MagicContestMatchView:_onClickBtnCancel()
	self:close()
end

return MagicContestMatchView
