-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberpuzzlegame/view/NumberPuzzleGameNorStageSelectView.lua

module("logic.extensions.numberpuzzlegame.view.NumberPuzzleGameNorStageSelectView", package.seeall)

local NumberPuzzleGameNorStageSelectView = class("NumberPuzzleGameNorStageSelectView", ViewComponent)

function NumberPuzzleGameNorStageSelectView:buildUI()
	NumberPuzzleGameNorStageSelectView.super.buildUI(self)

	self._maskClose = goutil.findChild(self.mainGO, "maskClose")
	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._stageScrollerview = goutil.findChild(self.mainGO, "stageCol/stageScrollerview")
	self._stageScrollercell = goutil.findChild(self.mainGO, "stageCol/stageScrollercell")
	self._stageScrollList = ScrollerList.create(self._stageScrollerview, self._stageScrollercell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
end

function NumberPuzzleGameNorStageSelectView:bindEvents()
	NumberPuzzleGameNorStageSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._maskClose, self.close, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NumberPuzzleGameNorStageSelectView:unbindEvents()
	NumberPuzzleGameNorStageSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._maskClose)
	GameUtil.rmClickHandler(self._btnClose)
end

function NumberPuzzleGameNorStageSelectView:onEnter()
	NumberPuzzleGameNorStageSelectView.super.onEnter(self)

	self._activityId = NumberPuzzleGameController.instance:getActivityId()
	self._activityType = NumberPuzzleGameController.instance:getActivityType()

	local isInTime = NumberPuzzleGameController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._stageCfg = NumberPuzzleGameConfig.instance:getNpgNorStageCfg(self._activityId)

	if self._stageCfg == nil then
		self:close()

		return
	end

	self._arenaGameMo = TourArenaController.instance:getTourArenaGameMo(self._activityId)

	self.addGEvent(self, GlobalNotify.handlePM_2048InfoRes, self._onUpdate, self)
	self:_onUpdate()
end

function NumberPuzzleGameNorStageSelectView:onExit()
	NumberPuzzleGameNorStageSelectView.super.onExit(self)
	self:_onClearStageCol()
end

function NumberPuzzleGameNorStageSelectView:_onUpdate()
	self:_onUpdateStageColUI()
end

function NumberPuzzleGameNorStageSelectView:_onUpdateStageColUI()
	self._stageScrollList:reloadData(self._stageCfg)

	local index = 0

	for idx, data in ipairs(self._stageCfg) do
		local result, _ = NumberPuzzleGameController.instance:getTryStartNorStageResultAndTips(self._activityId, data.stageId)

		if result == GameEnum.ResultCode.Success then
			index = idx - 1

			break
		elseif result == GameEnum.ResultCode.IsPass then
			index = idx - 1
		elseif result == GameEnum.ResultCode.ErrorTime or result == GameEnum.ResultCode.NotPassLast then
			break
		end
	end

	self._stageScrollList:MoveCellInView(index)
end

function NumberPuzzleGameNorStageSelectView:_onClearStageCol()
	self._stageScrollList:dispose()
end

function NumberPuzzleGameNorStageSelectView:_updateStageCell(view, cell, data, tag)
	local stageId = data.stageId
	local timePeriod = GameUtil.getTimePeriod(data.openDateTime, nil)
	local isInTime = timePeriod == GameUtil.inTimePeriod
	local isPass = NumberPuzzleGameController.instance:isPassOfNorStage(stageId)
	local isHasGain = NumberPuzzleGameController.instance:isHasGainPrizeOfNorStage(stageId)
	local tryStartNorStageResult = NumberPuzzleGameController.instance:getTryStartNorStageResultAndTips(self._activityId, stageId)
	local mainGo = cell.gameObject
	local txtStage = goutil.findChildTextComponent(mainGo, "txtStage")
	local txtDifficulty = goutil.findChildTextComponent(mainGo, "txtDifficulty")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local btnStart = goutil.findChild(mainGo, "btnStart")
	local imgReceive = goutil.findChild(mainGo, "imgReceive")
	local imgPass = goutil.findChild(mainGo, "imgPass")
	local prizeParent = goutil.findChild(mainGo, "prizeParent")

	txtStage.text = data.stageName
	txtDifficulty.text = data.diffName
	txtTime.text = string.format("%s后可挑战", GameUtil.getFormatTimeByStamp(GameUtil.string2time(data.openDateTime), nil))

	if not string.nilorempty(data.prize) then
		MaterialMgr.setCellByCfg(data.prize, prizeParent)
	else
		MaterialMgr.resetAll(prizeParent)
	end

	GameUtil.SetActive(txtTime.gameObject, not isInTime)
	GameUtil.SetActive(btnStart, isInTime)
	GameUtil.SetActive(imgPass, isPass)
	GameUtil.SetActive(imgReceive, isHasGain)
	GameUtil.SetGray(btnStart, tryStartNorStageResult ~= GameEnum.ResultCode.Success)
	GameUtil.addClickHandler(btnStart, GameUtil.handler(self._onClickStageStart, self, stageId))
end

function NumberPuzzleGameNorStageSelectView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local btnStart = goutil.findChild(mainGo, "btnStart")
	local prizeParent = goutil.findChild(mainGo, "prizeParent")

	MaterialMgr.resetAll(prizeParent)
	GameUtil.rmClickHandler(btnStart)
end

function NumberPuzzleGameNorStageSelectView:_onClickStageStart(stageId)
	local result, tips = NumberPuzzleGameController.instance:getTryStartNorStageResultAndTips(self._activityId, stageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	NumberPuzzleGameController.instance:startNumberPuzzleGameOfNor(self._activityId, stageId)

	if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
		self:close()
	end
end

return NumberPuzzleGameNorStageSelectView
