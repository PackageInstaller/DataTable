-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mazegame/view/MazeGameLevelView.lua

module("logic.extensions.mazegame.view.MazeGameLevelView", package.seeall)

local MazeGameLevelView = class("MazeGameLevelView", ViewComponent)

function MazeGameLevelView:ctor()
	MazeGameLevelView.super.ctor(self)
end

function MazeGameLevelView:unbindEvents()
	MazeGameLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function MazeGameLevelView:bindEvents()
	MazeGameLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function MazeGameLevelView:buildUI()
	MazeGameLevelView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._txtPlayTime = self:getTxt("txtPlayTime")
	self._tablecell = self:getGo("tableviewLevel/tablecell")
	self._tableviewLevel = self:getGo("tableviewLevel")
	self._scrollList = ScrollerList.create(self._tableviewLevel, self._tablecell, GameUtil.handler(self._updateCellLevel, self), GameUtil.handler(self._clearCellLevel, self))
end

function MazeGameLevelView:onExit()
	MazeGameLevelView.super.onExit(self)
	self._scrollList:dispose()

	for cellGo, scroll in ipairs(self._scrollMap) do
		scroll:dispose()

		self._scrollMap[cellGo] = nil
	end

	self._scrollMap = nil

	for cellGo, scroll in ipairs(self._scrollTiTanMap) do
		scroll:dispose()

		self._scrollTiTanMap[cellGo] = nil
	end

	self._scrollTiTanMap = nil
end

function MazeGameLevelView:onEnter()
	MazeGameLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MazeGameInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_MazeGameStartGameRes, self._onStartGameRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 523001
	end

	self._scrollMap = {}
	self._scrollTiTanMap = {}
	self._actCfg = MazeGameConfig.instance:getActCfg(self._activityId)
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	MazeGameController.instance:sendPM_MazeGameInfoReq(self._activityId)
end

function MazeGameLevelView:_onUpdate()
	self._info = MazeGameModel.instance:getInfo(self._activityId)
	self._stageCfgs = MazeGameConfig.instance:getStageCfgs(self._activityId)

	local dailyPassStageLimit = self._actCfg.dailyPassStageLimit
	local todayPlayTime = self._info.todayPassStageTimes
	local leftTime = dailyPassStageLimit - todayPlayTime
	local sortStageCfgs = {}

	for i, cfg in ipairs(self._stageCfgs) do
		table.insert(sortStageCfgs, cfg)
	end

	local names = {}
	local opt = {
		ArraySort.DESCENDING,
		ArraySort.NUMERIC
	}

	local function sortFunc(data)
		return (not table.indexof(self._info.passStageIds, data.stageId) or nil) and 1
	end

	table.insert(names, sortFunc)
	table.insert(names, "stageId")
	ArraySort.sortOn(sortStageCfgs, names, opt)
	self._scrollList:reloadData(sortStageCfgs)

	self._txtPlayTime.text = string.format("今日剩余次数:%d/%d", leftTime, dailyPassStageLimit)
end

function MazeGameLevelView:_updateCellLevel(view, cell, data)
	local btnCollect = goutil.findChild(cell, "btnCollect")
	local hasCollect = goutil.findChild(cell, "hasCollect")
	local lockTime = goutil.findChild(cell, "lockTime")
	local imgScene = goutil.findChild(cell, "imgScene")
	local tableviewReward = goutil.findChild(cell, "tableviewReward")
	local tablecell = goutil.findChild(cell, "tableviewReward/tablecell")
	local tableviewTiTan = goutil.findChild(cell, "tableviewTiTan")
	local tablecellTiTan = goutil.findChild(cell, "tableviewTiTan/tablecellTiTan")
	local txtName = goutil.findChildTextComponent(cell, "name/txtName")
	local txtLockTime = goutil.findChildTextComponent(cell, "lockTime/txtLockTime")

	if self._scrollMap[cell] == nil then
		self._scrollMap[cell] = ScrollerList.create(tableviewReward, tablecell, GameUtil.handler(self._updateCellReward, self), GameUtil.handler(self._clearCellReward, self))
	end

	if self._scrollTiTanMap[cell] == nil then
		self._scrollTiTanMap[cell] = ScrollerList.create(tableviewTiTan, tablecellTiTan, GameUtil.handler(self._updateCellTiTan, self), GameUtil.handler(self._clearCellTiTan, self))
	end

	local scrollList = self._scrollMap[cell]
	local tiTanScroolList = self._scrollTiTanMap[cell]
	local rewardArr = string.split(data.prize, "#")
	local hasPassed = table.indexof(self._info.passStageIds, data.stageId)
	local isInTime = MazeGameController.instance:stageIsInTime(self._activityId, data.stageId)
	local imgScenePath = string.format("ui/%s.png", data.sceneImgName)

	txtName.text = data.name

	if not isInTime then
		local timeStamp = GameUtil.string2time(data.startTime)

		txtLockTime.text = GameUtil.formatTimeStamp("%m.%d %H后开启", timeStamp)
	end

	scrollList:reloadData(rewardArr)
	scrollList:setCenterMode(true)
	tiTanScroolList:reloadData(data.elementalTitanList)
	uGuiUtil.setSpriteToImage(imgScene, uGuiUtil.SpriteType.BigBg, imgScenePath)
	GameUtil.SetActive(btnCollect, not hasPassed and isInTime)
	GameUtil.SetActive(hasCollect, hasPassed and isInTime)
	GameUtil.SetActive(lockTime, not isInTime)
	GameUtil.addClickHandler(btnCollect, GameUtil.handler(self._onClickBtnChallengeFloor, self, data.stageId))
end

function MazeGameLevelView:_clearCellLevel(cell)
	local btnCollect = goutil.findChild(cell, "btnCollect")
	local imgScene = goutil.findChild(cell, "imgScene")
	local scrollList = self._scrollMap[cell]

	if scrollList then
		scrollList:dispose()
	end

	self._scrollMap[cell] = nil

	uGuiUtil.clearImage(imgScene)
	GameUtil.rmClickHandler(btnCollect)
end

function MazeGameLevelView:_updateCellReward(view, cell, data)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.setCellByCfg(data, item)
end

function MazeGameLevelView:_clearCellReward(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function MazeGameLevelView:_updateCellTiTan(view, cell, data)
	local imgTiTan = goutil.findChild(cell, "imgTaiTan")
	local imgTaiTanComp = imgTiTan:GetComponent("UIImageSpriteChange")

	imgTaiTanComp:SetState(data - 1)
end

function MazeGameLevelView:_clearCellTiTan(cell)
	return
end

function MazeGameLevelView:_onClickBtnChallengeFloor(stageId)
	local hasPassed = table.indexof(self._info.passStageIds, stageId)
	local isInTime = MazeGameController.instance:stageIsInTime(self._activityId, stageId)
	local dailyPassStageLimit = self._actCfg.dailyPassStageLimit
	local todayPlayTime = self._info.todayPassStageTimes

	if hasPassed then
		FloatWordMgr.instance:show("已收集")

		return
	end

	if not isInTime then
		FloatWordMgr.instance:show("关卡时间未开启")

		return
	end

	if dailyPassStageLimit <= todayPlayTime then
		FloatWordMgr.instance:show("今日游戏次数已用完")

		return
	end

	MazeGameController.instance:sendPM_MazeGameStartGameReq(self._activityId, stageId)
end

function MazeGameLevelView:_onStartGameRes(stageId)
	UIStateManager.instance:push(ViewName.MazeGameView, self._activityId, stageId)
end

function MazeGameLevelView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

return MazeGameLevelView
