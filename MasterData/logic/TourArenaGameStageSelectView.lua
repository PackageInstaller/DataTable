-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/TourArenaGameStageSelectView.lua

module("logic.extensions.tourarena.view.TourArenaGameStageSelectView", package.seeall)

local TourArenaGameStageSelectView = class("TourArenaGameStageSelectView", ViewComponent)

function TourArenaGameStageSelectView:buildUI()
	TourArenaGameStageSelectView.super.buildUI(self)

	self._maskClose = goutil.findChild(self.mainGO, "maskClose")
	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._stageScrollerview = goutil.findChild(self.mainGO, "stageCol/stageScrollerview")
	self._stageScrollercell = goutil.findChild(self.mainGO, "stageCol/stageScrollercell")
	self._stageScrollList = ScrollerList.create(self._stageScrollerview, self._stageScrollercell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
end

function TourArenaGameStageSelectView:bindEvents()
	TourArenaGameStageSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._maskClose, self.close, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TourArenaGameStageSelectView:unbindEvents()
	TourArenaGameStageSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._maskClose)
	GameUtil.rmClickHandler(self._btnClose)
end

function TourArenaGameStageSelectView:onEnter()
	TourArenaGameStageSelectView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._gameId = checknumber(params[2])
	self._stageCfg = TourArenaGameConfig.instance:getTagStageCfg(self._activityId, self._gameId)

	if self._stageCfg == nil then
		self:close()

		return
	end

	self._arenaGameMo = TourArenaController.instance:getTourArenaGameMo(self._activityId)

	self.addGEvent(self, GlobalNotify.TourArenaGameUpdateView, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TourArenaGameInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TourArenaGameStageInfoRes, self._onUpdate, self)
	TourArenaController.instance:sendPM_TourArenaGameStageInfoReq(self._activityId, self._gameId)
	self:_onUpdate()
end

function TourArenaGameStageSelectView:onExit()
	TourArenaGameStageSelectView.super.onExit(self)
	self:_onClearStageCol()
end

function TourArenaGameStageSelectView:_onUpdate()
	self:_onUpdateStageColUI()
end

function TourArenaGameStageSelectView:_onUpdateStageColUI()
	self._stageScrollList:reloadData(self._stageCfg)
end

function TourArenaGameStageSelectView:_onClearStageCol()
	self._stageScrollList:dispose()
end

function TourArenaGameStageSelectView:_updateStageCell(view, cell, data, tag)
	local gameId = self._gameId
	local stageId = data.stageId
	local timePeriod = self._arenaGameMo:getTimePeriodOfStage(gameId, stageId)
	local isInTime = timePeriod == GameUtil.inTimePeriod
	local mainGo = cell.gameObject
	local txtStage = goutil.findChildTextComponent(mainGo, "txtStage")
	local txtDifficulty = goutil.findChildTextComponent(mainGo, "txtDifficulty")
	local txtRecord = goutil.findChildTextComponent(mainGo, "txtRecord")
	local btnStart = goutil.findChild(mainGo, "btnStart")

	txtStage.text = data.name
	txtDifficulty.text = data.difficulty

	local recordStr = ""

	if timePeriod == GameUtil.beforeTimePeriod then
		local str = GameUtil.getFormatTimeByStamp(GameUtil.string2time(data.openDateTime), nil)

		recordStr = string.format("%s后可挑战", str)
	elseif timePeriod == GameUtil.inTimePeriod then
		local list = self._arenaGameMo:getProgressIdxOfStage(gameId, stageId)
		local bestScore = self._arenaGameMo:getBestScoreOfStage(gameId, stageId)

		recordStr = #list > 0 and bestScore or "暂无成绩"
	elseif timePeriod == GameUtil.afterTimePeriod then
		recordStr = "已结束"
	end

	txtRecord.text = recordStr

	GameUtil.SetGray(btnStart, not isInTime)
	GameUtil.addClickHandler(btnStart, GameUtil.handler(self._onClickStageStart, self, stageId))
end

function TourArenaGameStageSelectView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local btnStart = goutil.findChild(mainGo, "btnStart")

	GameUtil.rmClickHandler(btnStart)
end

function TourArenaGameStageSelectView:_onClickStageStart(stageId)
	local result, tips = TourArenaController.instance:getTryGameResultAndTips(self._activityId, self._gameId, stageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	TourArenaController.instance:openTourArenaGame(self._activityId, self._gameId, stageId)

	if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
		self:close()
	end
end

return TourArenaGameStageSelectView
