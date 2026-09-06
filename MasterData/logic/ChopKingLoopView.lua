-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/view/ChopKingLoopView.lua

module("logic.extensions.chopking.view.ChopKingLoopView", package.seeall)

local ChopKingLoopView = class("ChopKingLoopView", ViewComponent)

function ChopKingLoopView:ctor()
	ChopKingLoopView.super.ctor(self)

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

function ChopKingLoopView:unbindEvents()
	ChopKingLoopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function ChopKingLoopView:bindEvents()
	ChopKingLoopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function ChopKingLoopView:buildUI()
	ChopKingLoopView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTotalScore = self:getTxt("totalScore/txtTotalScore")
end

function ChopKingLoopView:onExit()
	ChopKingLoopView.super.onExit(self)
	self._tableList:dispose()
end

function ChopKingLoopView:onEnter()
	ChopKingLoopView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ChopKingLoopClgInfoRes, self._refreshView, self)

	self._effectDir = {}
	self._activityId = checknumber(self:getFirstParam())

	self:_refreshView()
end

function ChopKingLoopView:_refreshView()
	local clgCfgs = ChopKingConfig.instance:getLoopClgStageCfgs(self._activityId)
	local loopCfgs = ChopKingConfig.instance:getLoopClgLoopCfgs(self._activityId)
	local list = {}

	self._maxLoopId, self._maxStageId = ChopKingModel.instance:getLoopClgMaxStage(self._activityId)
	self._nextLoopId = self._maxLoopId
	self._nextStageId = self._maxStageId + 1

	if self._nextStageId > #clgCfgs or self._nextLoopId == 0 then
		self._nextLoopId = self._nextLoopId + 1
		self._nextStageId = 1
	end

	local curStageInfo = ChopKingModel.instance:getCurLoopStageInfo()

	if not curStageInfo then
		self._curLoopId = self._nextLoopId
		self._curStageId = self._nextStageId
	else
		self._curLoopId = curStageInfo.loopId
		self._curStageId = curStageInfo.stageId
	end

	local index = 1
	local curIndex = 1

	table.insert(list, {
		index = 1,
		start = true
	})

	index = index + 1

	for i, loopCfg in ipairs(loopCfgs) do
		for j, stageCfg in ipairs(clgCfgs) do
			table.insert(list, {
				loopId = loopCfg.loopId,
				cfg = stageCfg,
				index = index
			})

			if self._curLoopId == loopCfg.loopId and self._curStageId == stageCfg.stageId then
				curIndex = index
			end

			index = index + 1
		end
	end

	self._tableList:reloadData(list)
	self._tableList:MoveCellToCenter(curIndex - 1)

	local curScore = ChopKingController.instance:getLoopClgScore(self._activityId)

	self._txtTotalScore.text = langPara("积分：%d", curScore)
end

function ChopKingLoopView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local content = goutil.findChild(go, "content")
	local startGo = goutil.findChild(content, "startGo")
	local stageGo = goutil.findChild(content, "stageGo")
	local txtStage = goutil.findChildTextComponent(stageGo, "txtStage")
	local lockGo = goutil.findChild(stageGo, "lock")
	local curGo = goutil.findChild(stageGo, "imgCur")
	local circleGo = goutil.findChild(stageGo, "circle")
	local txtCircle = goutil.findChildTextComponent(circleGo, "txtScore")
	local activeGo = goutil.findChild(stageGo, "active")
	local txtActive = goutil.findChildTextComponent(activeGo, "txtScore")
	local passGo = goutil.findChild(stageGo, "pass")
	local loopTipsGo = goutil.findChild(stageGo, "loopTips")
	local txtLoopTips = goutil.findChildTextComponent(loopTipsGo, "txtTips")
	local effectGo = goutil.findChild(stageGo, "effect")
	local posIndex = data.index % self._cycleCount

	if posIndex == 0 then
		posIndex = self._cycleCount
	end

	local pos = self._nodePosList[posIndex]

	GameUtil.setLocalPos(content, pos.x, pos.y, 0)
	GameUtil.rmClickHandler(stageGo)

	if self._effectDir[effectGo] then
		UIEffectManager.instance:stopEffect(self._effectDir[effectGo])

		self._effectDir[effectGo] = nil
	end

	if data.start == true then
		GameUtil.SetActive(startGo, true)
		GameUtil.SetActive(stageGo, false)
	else
		local cfg = data.cfg
		local loopId = data.loopId

		txtStage.text = data.index - 1

		GameUtil.SetActive(startGo, false)
		GameUtil.SetActive(stageGo, true)

		local isLock = loopId > self._nextLoopId or loopId == self._nextLoopId and cfg.stageId > self._nextStageId

		GameUtil.SetActive(lockGo, isLock)
		GameUtil.SetActive(curGo, loopId == self._curLoopId and cfg.stageId == self._curStageId)

		local loopCfg = ChopKingConfig.instance:getLoopClgLoopCfg(self._activityId, loopId)

		txtLoopTips.text = loopCfg.loopDesc

		local stageInfo = ChopKingModel.instance:getLoopClgStageInfo(self._activityId, loopId, cfg.stageId)

		if stageInfo then
			if not stageInfo.bestCircleNum and not stageInfo.bestActiveNum or loopCfg.rank == false then
				GameUtil.SetActive(passGo, true)
			else
				GameUtil.SetActive(passGo, false)
			end

			if loopCfg.rank == true and stageInfo.bestCircleNum then
				GameUtil.SetActive(circleGo, true)

				txtCircle.text = langPara("回合：%d", checknumber(stageInfo.bestCircleNum))
			else
				GameUtil.SetActive(circleGo, false)
			end

			if loopCfg.rank == true and stageInfo.bestActiveNum then
				GameUtil.SetActive(activeGo, true)

				txtActive.text = langPara("存活：%d", checknumber(stageInfo.bestActiveNum))
			else
				GameUtil.SetActive(activeGo, false)
			end

			GameUtil.SetActive(loopTipsGo, false)
		else
			GameUtil.SetActive(loopTipsGo, loopId ~= 1 and cfg.stageId == 1)
			GameUtil.SetActive(passGo, false)
			GameUtil.SetActive(circleGo, false)
			GameUtil.SetActive(activeGo, false)
		end

		if loopCfg.rank == true and not isLock then
			-- block empty
		end

		GameUtil.addClickHandler(stageGo, function()
			self:_onClickStage(loopId, cfg.stageId)
		end)
	end
end

function ChopKingLoopView:_clearCell(cell)
	local go = cell.gameObject
	local content = goutil.findChild(go, "content")
	local stageGo = goutil.findChild(content, "stageGo")

	GameUtil.rmClickHandler(stageGo)

	local stageGo = goutil.findChild(content, "stageGo")
	local effectGo = goutil.findChild(stageGo, "effect")

	if self._effectDir[effectGo] then
		UIEffectManager.instance:stopEffect(self._effectDir[effectGo])

		self._effectDir[effectGo] = nil
	end
end

function ChopKingLoopView:_onClickStage(loopId, stageId)
	local loopCfg = ChopKingConfig.instance:getLoopClgLoopCfg(self._activityId, loopId)

	if loopId == self._nextLoopId and stageId == self._nextStageId then
		ChopKingModel.instance:saveCurLoopStageInfo({
			loopId = loopId,
			stageId = stageId
		})
		self:_refreshView()
		ChopKingController.instance:openLoopClgMissionView(self._activityId, loopId, stageId)
	elseif loopId > self._nextLoopId or loopId == self._nextLoopId and stageId > self._nextStageId then
		FloatWordMgr.instance:show(lang("未通关前一关卡"))
	elseif loopCfg.rank == false then
		FloatWordMgr.instance:show(lang("无需重复挑战"))
	else
		ChopKingModel.instance:saveCurLoopStageInfo({
			loopId = loopId,
			stageId = stageId
		})
		self:_refreshView()
		ChopKingController.instance:openLoopClgMissionView(self._activityId, loopId, stageId)
	end
end

function ChopKingLoopView:_onClickTip()
	TipsFacade.instance:openRulesView("chop_king_loop_rule")
end

return ChopKingLoopView
