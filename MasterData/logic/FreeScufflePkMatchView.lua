-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScufflePkMatchView.lua

module("logic.extensions.freescuffle.view.FreeScufflePkMatchView", package.seeall)

local FreeScufflePkMatchView = class("FreeScufflePkMatchView", ViewComponent)

function FreeScufflePkMatchView:buildUI()
	FreeScufflePkMatchView.super.buildUI(self)

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

function FreeScufflePkMatchView:bindEvents()
	FreeScufflePkMatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
end

function FreeScufflePkMatchView:unbindEvents()
	FreeScufflePkMatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
end

function FreeScufflePkMatchView:onEnter()
	FreeScufflePkMatchView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = FreeScuffleController.instance:getSubMo(self._activityId)

	GameUtil.SetActive(self._success, false)
	GameUtil.SetActive(self._matching, true)

	self._txtTime.text = 0

	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleMatchRes, self._handlePM_FreeScuffleMatchRes, self)

	self._curMatChTime = 0
	self._maxMatchTime = Mathf.Random(3, 10)

	settimer(1, self._onTicking, self, true)
	self:_onTicking()
end

function FreeScufflePkMatchView:onExit()
	FreeScufflePkMatchView.super.onExit(self)
	removetimer(self._onTicking, self)
	removetimer(self._endMatch, self)
end

function FreeScufflePkMatchView:_handlePM_FreeScuffleMatchRes(status)
	if status == 0 then
		self:_showSuccess()
	else
		FloatWordMgr.instance:show("匹配失败")
		self:close()
	end
end

function FreeScufflePkMatchView:_onTicking()
	if self._curMatChTime >= self._maxMatchTime then
		removetimer(self._onTicking, self)
		FreeScuffleController.instance:sendPM_FreeScuffleMatchReq(self._activityId)

		return
	end

	self._curMatChTime = self._curMatChTime + 1
	self._txtTime.text = GameUtil.FormatTimeSymbol(self._curMatChTime)
end

function FreeScufflePkMatchView:_showSuccess()
	local opponent = self._subMo:getOpponent()
	local headInfos = {}

	headInfos[1] = RoleModel.instance:getHeadInfo()
	headInfos[2] = opponent.headInfo

	for index, mainGo in ipairs(self._playerCells) do
		local headCon = goutil.findChild(mainGo, "headCon")
		local txtName = goutil.findChildTextComponent(mainGo, "txtName")
		local headInfo = headInfos[index]

		HeadItemController.instance:setHeadCellByInfo(headCon, headInfo)

		txtName.text = headInfo.userName
	end

	GameUtil.SetActive(self._success, true)
	GameUtil.SetActive(self._matching, false)
	settimer(2, self._endMatch, self, false)
end

function FreeScufflePkMatchView:_endMatch()
	self:close()

	local opponent = self._subMo:getOpponent()

	FreeScuffleController.instance:enterPkBattle(self._activityId, opponent)
end

function FreeScufflePkMatchView:_onClear()
	for index, mainGo in ipairs(self._playerCells) do
		local headCon = goutil.findChild(mainGo, "headCon")

		HeadItemController.instance:resetHeadCell(headCon)
	end
end

function FreeScufflePkMatchView:_onClickBtnCancel()
	self:close()
end

return FreeScufflePkMatchView
