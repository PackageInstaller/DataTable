-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowdownfinalsguessView.lua

module("logic.extensions.showdown.view.ShowdownfinalsguessView", package.seeall)

local ShowdownfinalsguessView = class("ShowdownfinalsguessView", ViewComponent)

function ShowdownfinalsguessView:ctor()
	ShowdownfinalsguessView.super.ctor(self)
end

function ShowdownfinalsguessView:unbindEvents()
	ShowdownfinalsguessView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ShowdownfinalsguessView:bindEvents()
	ShowdownfinalsguessView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function ShowdownfinalsguessView:buildUI()
	ShowdownfinalsguessView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._cellGo = self:getGo("con/cell")
	self._tableviewGo = self:getGo("con/tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ShowdownfinalsguessView:onExit()
	ShowdownfinalsguessView.super.onExit(self)
	self._scrollerList:dispose()
end

function ShowdownfinalsguessView:onEnter()
	ShowdownfinalsguessView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._groupId = params[2]

	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)

	self._roundId = ShowDownController.instance:getRoundIdByStep(self._activityId, curStepId)
	self._mainRaceInfoMoInFinal = ShowDownController.instance:getMainRaceInfoMoInFinal(self._activityId, self._roundId)
	self._pairTeamIdList = self._mainRaceInfoMoInFinal:getPairTeamIdListInGroup(self._groupId)

	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetGuessRecordRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetMainInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GuessRes, self._handlePM_ShowDown_GuessRes, self)
	ShowDownController.instance:sendPM_ShowDown_GetGuessRecordReq(self._activityId)
	self:_updateUI()
end

function ShowdownfinalsguessView:_handlePM_ShowDown_GuessRes()
	ShowDownController.instance:sendPM_ShowDown_GetGuessRecordReq(self._activityId)
end

function ShowdownfinalsguessView:_updateUI()
	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)

	self._roundId = ShowDownController.instance:getRoundIdByStep(self._activityId, curStepId)

	local showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)

	if not showDownMo then
		return
	end

	local stepId = ShowDownController.instance:getCurStepId(self._activityId)

	self._scrollerList:reloadData(self._pairTeamIdList)
end

function ShowdownfinalsguessView:_onClickbtnClose()
	self:close()
end

function ShowdownfinalsguessView:_updateCell(view, cellGo, data)
	local pairId = cellGo.data
	local leftGo = goutil.findChild(cellGo, "left")
	local rightGo = goutil.findChild(cellGo, "right")
	local leftData = self._mainRaceInfoMoInFinal:getTeamSimpleViewMo(self._groupId, data[2])
	local righttData = self._mainRaceInfoMoInFinal:getTeamSimpleViewMo(self._groupId, data[1])

	self:_updateSub(leftGo, pairId, leftData)
	self:_updateSub(rightGo, pairId, righttData)
end

function ShowdownfinalsguessView:_updateSub(root, pairId, simpleView)
	local teamId = simpleView:getTeamId()
	local teamName = simpleView:getTeamName()
	local totalGuessValue = self:_getTotalGuessValue(self._roundId, teamId)
	local leaderHeadInfo = simpleView:getLeaderHeadInfo()
	local guessValue = self:_getGuessValue(self._roundId, teamId)
	local cell = self:_clearCell(root)

	cell.txtName.text = teamName
	cell.txtValue.text = totalGuessValue
	cell.txtVote.text = guessValue

	GameUtil.SetActive(cell.txtVote.gameObject, guessValue ~= 0)

	local result, tips = self:_getVoteResultAndTips(pairId, teamId)

	GameUtil.SetGray(cell.btnGuess, result == GameEnum.ResultCode.Error)
	HeadItemController.instance:setHeadCellByInfo(cell.head, leaderHeadInfo, false)
	GameUtil.addClickHandler(cell.btnGuess, GameUtil.handler(self._onClickBtnGuess, self, pairId, simpleView))
	GameUtil.addClickHandler(cell.btnFmt, GameUtil.handler(self._onClickBtnFmt, self, pairId, teamId))
end

function ShowdownfinalsguessView:_onClickBtnFmt(pairId, teamId)
	local stepId = ShowDownController.instance:getCurStepId(self._activityId)
	local stepData = ShowDownConfig.instance:getStepData(self._activityId, stepId)

	if stepData.canGuess then
		FloatWordMgr.instance:show(lang("当前不可查看。"))

		return
	end

	local pairTeamId = self._pairTeamIdList[pairId]

	UIStateManager.instance:push(ViewName.ShowdownfinalpkfmtView, self._activityId, pairTeamId[1], pairTeamId[2])
end

function ShowdownfinalsguessView:_onClickBtnGuess(pairId, teamMo)
	local result, tips = self:_getVoteResultAndTips(pairId, teamMo:getTeamId())

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.ShowdownEliminateVoteView, self._activityId, teamMo)
end

function ShowdownfinalsguessView:_getVoteResultAndTips(pairId, teamId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	local isCanGuess = ShowDownController.instance:isCanGuessInStep(self._activityId, curStepId)

	if not isCanGuess then
		local result = GameEnum.ResultCode.Error
		local tips = "当前阶段不可应援。"

		return result, tips
	end

	local isHasVoteOther = false
	local pairTeamId = self._pairTeamIdList[pairId]
	local aTeamId = pairTeamId[1]
	local bTeamId = pairTeamId[2]
	local aVoteValue = self:_getGuessValue(self._roundId, aTeamId)
	local bVoteValue = self:_getGuessValue(self._roundId, bTeamId)

	if aTeamId == teamId then
		if bVoteValue > 0 then
			isHasVoteOther = true
		end
	elseif aVoteValue > 0 then
		isHasVoteOther = true
	end

	if isHasVoteOther then
		local result = GameEnum.ResultCode.Error
		local tips = "已投另一队，不可投注该队。"

		return result, tips
	end

	return result, tips
end

function ShowdownfinalsguessView:_clearCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.btnFmt = goutil.findChild(cell.go, "btnFmt")
	cell.btnGuess = goutil.findChild(cell.go, "btnGuess")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtValue = goutil.findChildTextComponent(cell.go, "txtValue")
	cell.txtVote = goutil.findChildTextComponent(cell.go, "txtVote")
	cell.head = goutil.findChild(cell.go, "head")

	HeadItemController.instance:resetHeadCell(cell.head)
	GameUtil.rmClickHandler(cell.btnFmt)
	GameUtil.rmClickHandler(cell.btnGuess)

	return cell
end

function ShowdownfinalsguessView:_getGuessInfo(roundId, teamId)
	local showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)

	return showDownMo:getGuessInfoByTeamId(roundId, teamId)
end

function ShowdownfinalsguessView:_getGuessValue(roundId, teamId)
	local showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)

	return showDownMo:getGuessValue(roundId, teamId)
end

function ShowdownfinalsguessView:_getTotalGuessValue(roundId, teamId)
	local showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)

	return showDownMo:getTotalGuessValue(roundId, teamId)
end

function ShowdownfinalsguessView:getVoteResult(roundId, teamId)
	local showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)

	return showDownMo:getVoteResult(roundId, teamId)
end

return ShowdownfinalsguessView
