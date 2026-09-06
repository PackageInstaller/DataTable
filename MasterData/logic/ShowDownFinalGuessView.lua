-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFinalGuessView.lua

module("logic.extensions.showdown.view.ShowDownFinalGuessView", package.seeall)

local ShowDownFinalGuessView = class("ShowDownFinalGuessView", ViewComponent)

function ShowDownFinalGuessView:ctor()
	ShowDownFinalGuessView.super.ctor(self)
end

function ShowDownFinalGuessView:unbindEvents()
	ShowDownFinalGuessView.super.unbindEvents(self)

	for i, com in ipairs(self._guessList) do
		GameUtil.rmClickHandler(com.btnSet)
		GameUtil.rmClickHandler(com.btnGuess)
		GameUtil.rmClickHandler(com.btnShow)
	end

	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function ShowDownFinalGuessView:bindEvents()
	ShowDownFinalGuessView.super.bindEvents(self)

	for i, com in ipairs(self._guessList) do
		GameUtil.addClickHandler(com.btnSet, GameUtil.handler(self._onClickSetGuess, self, com))
		GameUtil.addClickHandler(com.btnGuess, GameUtil.handler(self._onClickGuess, self, com))
		GameUtil.addClickHandler(com.btnShow, GameUtil.handler(self._onClickShowGuess, self, com))
	end

	self._btnClose:AddClickListener(self.close, self)
	self._btnSure:AddClickListener(self.close, self)
end

function ShowDownFinalGuessView:buildUI()
	ShowDownFinalGuessView.super.buildUI(self)

	self._guessList = {}

	for i = 1, 3 do
		local com = {}

		com.rank = i
		com.info = nil
		com.go = self:getGo("colGuess/col_" .. i)
		com.set = goutil.findChild(com.go, "set")
		com.btnSet = goutil.findChild(com.set, "btn")
		com.team = goutil.findChild(com.go, "team")
		com.head = goutil.findChild(com.team, "head")
		com.btnShow = goutil.findChild(com.team, "btnShow")
		com.txtName = goutil.findChildTextComponent(com.team, "name/txt")
		com.txtHeat = goutil.findChildTextComponent(com.team, "heat/txt")
		com.iconHeat = goutil.findChild(com.team, "heat/icon")
		com.txtGuessTotal = goutil.findChildTextComponent(com.team, "guess/txtTotal")
		com.txtGuessSelf = goutil.findChildTextComponent(com.team, "guess/txtSelf")
		com.btnGuess = goutil.findChild(com.team, "guess/btn")
		self._guessList[i] = com
	end

	local cellGo = self:getGo("colTeam/cell")
	local tableviewGo = self:getGo("colTeam/tableview")

	self._tableView = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._txtCountDown = self:getTxt("txtCountDown")
	self._txtTipsNum = self:getTxt("tipReward/txtNum")
	self._iconTips = self:getGo("tipReward/img")
end

function ShowDownFinalGuessView:onExit()
	ShowDownFinalGuessView.super.onExit(self)
	self._tableView:dispose()

	self._selectTeamInfo = nil

	removetimer(self._onTimeCountDown, self)

	for i, com in ipairs(self._guessList) do
		ShowDownController.instance:clearTeamHeadCellRoot(com.head)
		uGuiUtil.clearImage(com.iconHeat)
	end

	MaterialMgr.resetAll(self._iconTips)
end

function ShowDownFinalGuessView:onEnter()
	ShowDownFinalGuessView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	self:_setTimeCountDown()

	local stepData = ShowDownConfig.instance:getStepData(self._activityId, self._curStepId)

	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GetGuessRecordRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_FinalMatchGuessRes, self._getInfo, self)
	self.addGEvent(self, GlobalNotify.ShowDownStepChange, self._setTimeCountDown, self)
	self:_getInfo()

	local heatIconPath = ShowDownConfig.instance:getCommonValue(self._activityId, "heatIconPath")

	self._heatPath = string.format("%s.png", heatIconPath)

	for i, com in ipairs(self._guessList) do
		uGuiUtil.setSpriteToImage(com.iconHeat, uGuiUtil.SpriteType.BigBg, self._heatPath)
	end

	local actData = ShowDownConfig.instance:getActData(self._activityId)

	self._txtTipsNum.text = actData.finalMatchGuessFloorNum

	local itemType, itemId, itemNum = MaterialMgr.getMatParams(actData.guessItem)

	MaterialMgr.setIcon(self._iconTips, itemType, itemId)
end

function ShowDownFinalGuessView:_updateTeamCell(view, cellGo, data)
	local cell = self:_clearTeamCell(cellGo)

	if data then
		ShowDownController.instance:setTeamHeadCellRoot(cell.head, data.simpleMo:getLeaderHeadInfo(), self._activityId, data.simpleMo:getTeamLogo())

		cell.txtName.text = data.simpleMo:getTeamName()
		cell.txtHeat.text = data.simpleMo:getHeatValue()

		GameUtil.addClickHandler(cell.btnShow, GameUtil.handler(self._onClickShowTeam, self, data))
		GameUtil.addClickHandler(cell.btnSelect, GameUtil.handler(self._onClickSelectTeam, self, data))
		goutil.setActive(cell.select, self._selectTeamInfo == data)
		uGuiUtil.setSpriteToImage(cell.iconHeat, uGuiUtil.SpriteType.BigBg, self._heatPath)
	end
end

function ShowDownFinalGuessView:_clearTeamCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.btnSelect = goutil.findChild(cell.go, "btnSelect")
	cell.head = goutil.findChild(cell.go, "head")
	cell.btnShow = goutil.findChild(cell.go, "btnShow")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtHeat = goutil.findChildTextComponent(cell.go, "heat/txtHeat")
	cell.iconHeat = goutil.findChild(cell.go, "heat/icon")
	cell.select = goutil.findChild(cell.go, "select")

	ShowDownController.instance:clearTeamHeadCellRoot(cell.head)
	uGuiUtil.clearImage(cell.iconHeat)
	GameUtil.rmClickHandler(cell.btnSelect)
	GameUtil.rmClickHandler(cell.btnShow)

	return cell
end

function ShowDownFinalGuessView:_updateGuessCell(com)
	local info = com.info

	goutil.setActive(com.team, info)
	goutil.setActive(com.set, not info)

	if info then
		ShowDownController.instance:setTeamHeadCellRoot(com.head, info.simpleMo:getLeaderHeadInfo(), self._activityId, info.simpleMo:getTeamLogo())

		com.txtName.text = info.simpleMo:getTeamName()
		com.txtHeat.text = info.simpleMo:getHeatValue()
		com.txtGuessTotal.text = info.globalGuessNum
		com.txtGuessSelf.text = info.totalGuessNum
	end
end

function ShowDownFinalGuessView:_updateUI()
	self._selectTeamInfo = nil
	self._mo = ShowDownController.instance:getShowDownMo(self._activityId)
	self._teamInfoList = self._mo:getFinalRoundGuessInfos()
	self._teamInfoHash = self._mo:getFinalRoundGuessInfoHash()

	for i, com in ipairs(self._guessList) do
		com.info = self._teamInfoHash[i]

		self:_updateGuessCell(com)
	end

	local showDataList = {}

	for i, info in ipairs(self._teamInfoList) do
		if not self:_getIsGuess(info) then
			table.insert(showDataList, info)
		end
	end

	self._tableView:reloadData(showDataList)
end

function ShowDownFinalGuessView:_onClickSetGuess(com)
	if not ShowDownController.instance:isCanGuessInStep(self._activityId, self._curStepId) then
		return FloatWordMgr.instance:show(lang("当前不可应援。"))
	end

	if self._selectTeamInfo then
		local guessValueCurRound = 0

		for i, v in ipairs(self._mo:getGuessInfoByRound(self._curRoundId)) do
			guessValueCurRound = guessValueCurRound + checkint(v.guessValue)
		end

		local limit = ShowDownConfig.instance:getGuessRoundLimitInGuess(self._activityId, self._curRoundId)

		if limit <= guessValueCurRound then
			FloatWordMgr.instance:show(lang("本轮已达到应援上限。"))

			return
		end

		if self:_getIsGuess(self._selectTeamInfo) then
			FloatWordMgr.instance:show(lang("该队已参与应援。"))

			return
		end

		UIStateManager.instance:push(ViewName.ShowdownEliminateVoteView, self._activityId, self._selectTeamInfo.simpleMo, com.rank, true)
	end
end

function ShowDownFinalGuessView:_onClickGuess(com)
	local info = com.info

	if not info then
		return
	end

	if not ShowDownController.instance:isCanGuessInStep(self._activityId, self._curStepId) then
		return FloatWordMgr.instance:show(lang("当前不可应援。"))
	end

	local guessValueCurRound = 0

	for i, v in ipairs(self._mo:getGuessInfoByRound(self._curRoundId)) do
		guessValueCurRound = guessValueCurRound + checkint(v.guessValue)
	end

	local limit = ShowDownConfig.instance:getGuessRoundLimitInGuess(self._activityId, self._curRoundId)

	if limit <= guessValueCurRound then
		FloatWordMgr.instance:show(lang("本轮已达到应援上限。"))

		return
	end

	UIStateManager.instance:push(ViewName.ShowdownEliminateVoteView, self._activityId, info.simpleMo, com.rank)
end

function ShowDownFinalGuessView:_onClickShowGuess(com)
	local info = com.info

	if not info then
		return
	end

	ShowDownController.instance:opTeamDetailView(self._activityId, self._curRoundId, info.simpleMo:getTeamId(), info.simpleMo:getTeamName())
end

function ShowDownFinalGuessView:_onClickShowTeam(data)
	ShowDownController.instance:opTeamDetailView(self._activityId, self._curRoundId, data.simpleMo:getTeamId(), data.simpleMo:getTeamName())
end

function ShowDownFinalGuessView:_getIsGuess(data)
	if self._teamInfoHash then
		return table.keyof(self._teamInfoHash, data)
	end

	return false
end

function ShowDownFinalGuessView:_getIsAllGuess()
	if self._teamInfoHash then
		return table.nums(self._teamInfoHash) >= #self._guessList
	end

	return false
end

function ShowDownFinalGuessView:_onClickSelectTeam(data)
	local isCover = self:_getIsGuess(data)
	local isAllCover = self:_getIsAllGuess()

	if isCover then
		return
	end

	if isAllCover then
		return
	end

	if self._selectTeamInfo ~= data then
		self._selectTeamInfo = data

		self._tableView:refresh()
	end
end

function ShowDownFinalGuessView:_getInfo()
	ShowDownController.instance:sendPM_ShowDown_GetGuessRecordReq(self._activityId)
end

function ShowDownFinalGuessView:_setTimeCountDown()
	self._curStepId = ShowDownController.instance:getCurStepId(self._activityId)
	self._curRoundId = ShowDownController.instance:getRoundIdByStep(self._activityId, self._curStepId)

	if ShowDownEnum.RoundInRace[self._curRoundId] ~= ShowDownEnum.RacePeriod_Final then
		self:close()
		FloatWordMgr.instance:show(lang("不在决赛阶段"))

		return
	end

	removetimer(self._onTimeCountDown, self)

	if ShowDownController.instance:isCanGuessInStep(self._activityId, self._curStepId) then
		self._endTimestamp = ShowDownController.instance:getLeftTimeStampToNext(self._activityId, self._curStepId) + 1

		self:_onTimeCountDown()
		settimer(1, self._onTimeCountDown, self)
	else
		self._txtCountDown.text = "决赛应援"
	end
end

function ShowDownFinalGuessView:_onTimeCountDown()
	self._endTimestamp = self._endTimestamp - 1

	if self._endTimestamp <= 0 then
		self:_setTimeCountDown()
	end

	self._txtCountDown.text = string.format("决赛应援倒计时：%s", GameUtil.FormatTimeSymbol(self._endTimestamp))
end

return ShowDownFinalGuessView
