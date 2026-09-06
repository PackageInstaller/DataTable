-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/view/ChopKingAgainstTwoView.lua

module("logic.extensions.chopking.view.ChopKingAgainstTwoView", package.seeall)

local ChopKingAgainstTwoView = class("ChopKingAgainstTwoView", ViewComponent)

function ChopKingAgainstTwoView:ctor()
	ChopKingAgainstTwoView.super.ctor(self)

	self._nodePosList = {
		Vector2(53, -173),
		Vector2(50, 14.3),
		Vector2(46, 203.2),
		Vector2(59.6, 41.1),
		Vector2(-13.2, -160.8),
		Vector2(59.3, -40),
		Vector2(36, 181.3),
		(Vector2(50.2, 15.8))
	}
	self._cycleCount = #self._nodePosList
end

function ChopKingAgainstTwoView:unbindEvents()
	ChopKingAgainstTwoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function ChopKingAgainstTwoView:bindEvents()
	ChopKingAgainstTwoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function ChopKingAgainstTwoView:buildUI()
	ChopKingAgainstTwoView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTotalScore = self:getTxt("totalScore/txtTotalScore")
end

function ChopKingAgainstTwoView:onExit()
	ChopKingAgainstTwoView.super.onExit(self)
end

function ChopKingAgainstTwoView:onEnter()
	ChopKingAgainstTwoView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ChopKingCircleClgInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())

	self:_refreshView()
end

function ChopKingAgainstTwoView:_refreshView()
	local clgCfgs = ChopKingConfig.instance:getAgainstTwoStageCfgs(self._activityId)
	local list = {}

	self._maxStage = ChopKingModel.instance:getAgainstTwoMaxStage(self._activityId)
	self._isPass = self._maxStage >= #clgCfgs

	table.insert(list, {
		index = 1,
		start = true
	})

	for i, v in ipairs(clgCfgs) do
		table.insert(list, {
			cfg = v,
			index = i + 1
		})
	end

	self._curStageId = ChopKingModel.instance:getCurAgainstTwoStageId()

	if not self._curStageId then
		if self._isPass then
			self._curStageId = self._maxStage or self._maxStage + 1
		end
	end

	self._tableList:reloadData(list)

	local curScore = ChopKingController.instance:getAgainstTwoScore(self._activityId)
	local maxScore = 0

	for i, v in ipairs(clgCfgs) do
		local maxStageScore = ChopKingConfig.instance:getScoreByNum(self._activityId, v.activeScorePlanId, 99)

		maxScore = maxScore + maxStageScore
	end

	self._txtTotalScore.text = langPara("积分：%d/%d", curScore, maxScore)
end

function ChopKingAgainstTwoView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local content = goutil.findChild(go, "content")
	local startGo = goutil.findChild(content, "startGo")
	local stageGo = goutil.findChild(content, "stageGo")
	local txtStage = goutil.findChildTextComponent(stageGo, "txtStage")
	local lockGo = goutil.findChild(stageGo, "lock")
	local curGo = goutil.findChild(stageGo, "imgCur")
	local scoreGo = goutil.findChild(stageGo, "score")
	local txtScore = goutil.findChildTextComponent(scoreGo, "txtScore")
	local posIndex = data.index % self._cycleCount

	if posIndex == 0 then
		posIndex = self._cycleCount
	end

	local pos = self._nodePosList[posIndex]

	GameUtil.setLocalPos(content, pos.x, pos.y, 0)
	GameUtil.rmClickHandler(stageGo)

	if data.start == true then
		GameUtil.SetActive(startGo, true)
		GameUtil.SetActive(stageGo, false)
	else
		local cfg = data.cfg

		txtStage.text = cfg.stageId

		GameUtil.SetActive(startGo, false)
		GameUtil.SetActive(stageGo, true)
		GameUtil.SetActive(lockGo, cfg.stageId > self._maxStage + 1)
		GameUtil.SetActive(scoreGo, cfg.stageId <= self._maxStage)
		GameUtil.SetActive(curGo, cfg.stageId == self._curStageId)

		local stageScore = ChopKingModel.instance:getAgainstTwoStageInfo(self._activityId, cfg.stageId)

		if stageScore then
			txtScore.text = langPara("存活：%d", checknumber(stageScore))
		end

		GameUtil.addClickHandler(stageGo, function()
			self:_onClickStage(cfg.stageId)
		end)
	end
end

function ChopKingAgainstTwoView:_clearCell(cell)
	local go = cell.gameObject
	local content = goutil.findChild(go, "content")
	local stageGo = goutil.findChild(content, "stageGo")

	GameUtil.rmClickHandler(stageGo)
end

function ChopKingAgainstTwoView:_onClickStage(stageId)
	if self._isPass == true then
		ChopKingModel.instance:saveCurAgainstTwoStageId(stageId)
		self:_refreshView()
		ChopKingController.instance:openAgainstTwoMissionView(self._activityId, stageId)
	elseif stageId > self._maxStage + 1 then
		FloatWordMgr.instance:show(lang("未通关前一关卡"))
	else
		ChopKingModel.instance:saveCurAgainstTwoStageId(stageId)
		self:_refreshView()
		ChopKingController.instance:openAgainstTwoMissionView(self._activityId, stageId)
	end
end

function ChopKingAgainstTwoView:_onClickTip()
	TipsFacade.instance:openRulesView("chop_king_against_two_rule")
end

return ChopKingAgainstTwoView
