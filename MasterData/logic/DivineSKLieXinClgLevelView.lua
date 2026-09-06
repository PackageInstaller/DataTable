-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineskliexinclg/view/DivineSKLieXinClgLevelView.lua

module("logic.extensions.divineskliexinclg.view.DivineSKLieXinClgLevelView", package.seeall)

local DivineSKLieXinClgLevelView = class("DivineSKLieXinClgLevelView", ViewComponent)

function DivineSKLieXinClgLevelView:ctor()
	DivineSKLieXinClgLevelView.super.ctor(self)
end

function DivineSKLieXinClgLevelView:unbindEvents()
	DivineSKLieXinClgLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnBuffTip)

	for i, v in pairs(self._levelCellMaps) do
		GameUtil.rmClickHandler(v.go)
	end
end

function DivineSKLieXinClgLevelView:bindEvents()
	DivineSKLieXinClgLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnBuffTip, self._onClickBuffTip, self)

	for i, v in pairs(self._levelCellMaps) do
		GameUtil.addClickHandler(v.go, function()
			self:_onClickStage(v.index)
		end, self)
	end
end

function DivineSKLieXinClgLevelView:buildUI()
	DivineSKLieXinClgLevelView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._prize = self:getGo("prize")
	self._scoreTableView = self:getGo("prize/scoreTableView")
	self._scoreRewardCell = self:getGo("prize/scoreRewardCell")
	self._scoreTableList = ScrollerList.create(self._scoreTableView, self._scoreRewardCell, GameUtil.handler(self._updateScoreCell, self), GameUtil.handler(self._clearScoreCell, self))
	self._scoreSlider = self:getSlider("prize/scoreTableView/viewport/content/progressBar")
	self._stageTableView = self:getGo("prize/stageTableView")
	self._stageRewardCell = self:getGo("prize/stageRewardCell")
	self._stageTableList = ScrollerList.create(self._stageTableView, self._stageRewardCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._stageSlider = self:getSlider("prize/stageTableView/viewport/content/progressBar")
	self._level = self:getGo("level")
	self._levelCellMaps = {}

	for i = 1, self._level.transform.childCount do
		local cell = {}

		cell.go = goutil.findChild(self._level, "cell_" .. i)
		cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
		cell.result = goutil.findChild(cell.go, "result")
		cell.txtScore = goutil.findChildTextComponent(cell.go, "result/txtScore")
		cell.select = goutil.findChild(cell.go, "select")
		cell.index = i
		self._levelCellMaps[i] = cell
	end

	self._txtScore = self:getTxt("prize/scoreTotal/txtScore")
	self._txtStage = self:getTxt("prize/stageTotal/txtStage")
	self._txtDesc = self:getTxt("txtDesc/viewport/txt")
	self._btnChallenge = self:getGo("btnChallenge")
	self._collectBuff = self:getGo("collectBuff")
	self._btnBuffTip = self:getGo("collectBuff/btnBuffTip")
	self._txtBuffDesc = self:getTxt("collectBuff/txtBuffDesc")
end

function DivineSKLieXinClgLevelView:onExit()
	DivineSKLieXinClgLevelView.super.onExit(self)
	self._stageTableList:dispose()
	self._scoreTableList:dispose()
end

function DivineSKLieXinClgLevelView:onEnter()
	DivineSKLieXinClgLevelView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityCfg = DivineSKLieXinClgConfig.instance:getActivityCfg(self._activityId)
	self._selectStageId = DivineSKLieXinClgModel.instance:getTempSelectStage()

	if not self._selectStageId then
		self._selectStageId = 1

		DivineSKLieXinClgModel.instance:saveTempSelectStage(self._selectStageId)
	end

	GameUtil.SetActive(self._collectBuff, checknumber(self._activityCfg.collectBuffPlanId) ~= 0)
	GameUtil.SetActive(self._prize, checknumber(self._activityCfg.passStagePrizePlanId) ~= 0)
	self:_refreshView()
end

function DivineSKLieXinClgLevelView:_refreshView()
	local stagePrizeCfgs = DivineSKLieXinClgConfig.instance:getPrizeCfgs(self._activityCfg.passStagePrizePlanId)
	local scorePrizeCfgs = DivineSKLieXinClgConfig.instance:getPrizeCfgs(self._activityCfg.relivePrizePlanId)

	self._scoreTableList:reloadData(scorePrizeCfgs)
	self._stageTableList:reloadData(stagePrizeCfgs)

	self._totalReliveCount = DivineSKLieXinClgModel.instance:getTotalReliveCount(self._activityId)
	self._totalPassStageCount = DivineSKLieXinClgModel.instance:getTotalPassStageCount(self._activityId)

	local scoreList1 = {}

	if stagePrizeCfgs then
		for i, v in ipairs(stagePrizeCfgs) do
			table.insert(scoreList1, v.progress)
		end
	end

	local scoreList2 = {}

	if scorePrizeCfgs then
		for i, v in ipairs(scorePrizeCfgs) do
			table.insert(scoreList2, v.progress)
		end
	end

	self._stageTableList:updateUnderSlider(self._stageSlider, self._totalPassStageCount, scoreList1)
	self._scoreTableList:updateUnderSlider(self._scoreSlider, self._totalReliveCount, scoreList2)

	self._txtStage.text = self._totalPassStageCount
	self._txtScore.text = self._totalReliveCount

	self:_refreshLevel()

	local stageCfg = DivineSKLieXinClgConfig.instance:getStageCfg(self._activityCfg.stagePlanId, self._selectStageId)

	self._txtDesc.text = stageCfg.desc

	local collectCount = DivineSKLieXinClgController.instance:getCollectPetCount(self._activityId)
	local buffCfg = DivineSKLieXinClgConfig.instance:getBuffCfg(self._activityCfg.collectBuffPlanId, collectCount)

	self._txtBuffDesc.text = buffCfg and buffCfg.desc or lang("当前未激活效果")
end

function DivineSKLieXinClgLevelView:_refreshLevel()
	for i, v in pairs(self._levelCellMaps) do
		GameUtil.SetActive(v.go)
	end

	local stageCfgs = DivineSKLieXinClgConfig.instance:getStageCfgs(self._activityCfg.stagePlanId)

	for i, v in ipairs(stageCfgs) do
		local cell = self._levelCellMaps[v.stageId]

		if cell then
			GameUtil.SetActive(cell.go, true)
			GameUtil.SetActive(cell.txtScore, true)

			local stageInfo = DivineSKLieXinClgModel.instance:getStageInfo(self._activityId, v.stageId)

			cell.txtScore.text = stageInfo and langPara("浴火重生:%d次", stageInfo.reliveCount) or langPara("浴火重生:%d次", 0)

			GameUtil.SetActive(cell.result, stageInfo ~= nil)
			GameUtil.SetActive(cell.select, self._selectStageId == i)
		end
	end
end

function DivineSKLieXinClgLevelView:_updateScoreCell(view, cell, data, tag)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local received = goutil.findChild(go, "receive")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")

	MaterialMgr.resetAll(item)
	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = langPara("%d", data.progress)

	local isGainPrize = self._totalReliveCount >= data.progress

	GameUtil.SetActive(received, isGainPrize)
end

function DivineSKLieXinClgLevelView:_clearScoreCell(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")

	MaterialMgr.resetAll(item)
end

function DivineSKLieXinClgLevelView:_updateStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local received = goutil.findChild(go, "receive")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")

	MaterialMgr.resetAll(item)
	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = langPara("%d", data.progress)

	local isGainPrize = self._totalPassStageCount >= data.progress

	GameUtil.SetActive(received, isGainPrize)
end

function DivineSKLieXinClgLevelView:_clearStageCell(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")

	MaterialMgr.resetAll(item)
end

function DivineSKLieXinClgLevelView:_onClickStage(index)
	self._selectStageId = index

	DivineSKLieXinClgModel.instance:saveTempSelectStage(self._selectStageId)
	self:_refreshView()
end

function DivineSKLieXinClgLevelView:_onClickChallenge()
	DivineSKLieXinClgController.instance:openMissionView(self._activityId, self._selectStageId)
end

function DivineSKLieXinClgLevelView:_onClickBuffTip()
	UIStateManager.instance:push(ViewName.DivineSKLieXinClgBuffView, self._activityId)
end

return DivineSKLieXinClgLevelView
