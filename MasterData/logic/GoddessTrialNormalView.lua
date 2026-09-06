-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesstrial/view/GoddessTrialNormalView.lua

module("logic.extensions.goddesstrial.view.GoddessTrialNormalView", package.seeall)

local GoddessTrialNormalView = class("GoddessTrialNormalView", ViewComponent)

function GoddessTrialNormalView:ctor()
	GoddessTrialNormalView.super.ctor(self)
end

function GoddessTrialNormalView:unbindEvents()
	GoddessTrialNormalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function GoddessTrialNormalView:bindEvents()
	GoddessTrialNormalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function GoddessTrialNormalView:buildUI()
	GoddessTrialNormalView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnPrize = self:getGo("btnPrize")
	self._redPointPrize = self:getGo("btnPrize/redpoint")
	self._btnChallenge = self:getGo("btnChallenge")
	self._btnTip = self:getGo("btnTip")
	self._stageTableview = self:getGo("stageTableview")
	self._stageTablecell = self:getGo("stageTableview/stageTablecell")
	self._stageTabelList = ScrollerList.create(self._stageTableview, self._stageTablecell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))

	local formationGo = self:getGo("stageInfo/formation")

	self._formationGos = {}

	for i = 1, 9 do
		local cell = {}

		cell.go = goutil.findChild(formationGo, "cell_" .. i)
		cell.con = goutil.findChild(cell.go, "con")
		self._formationGos[i] = cell
	end

	self._txtScore = self:getTxt("stageInfo/txtScore")
	self._txtStageName = self:getTxt("stageInfo/txtName")
end

function GoddessTrialNormalView:onExit()
	GoddessTrialNormalView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPointPrize)
end

function GoddessTrialNormalView:onEnter()
	GoddessTrialNormalView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_GoddessTrialGetInfoRes, self._refreshView, self)

	self._activityId = self:getFirstParam()
	self._activityCfg = GoddessTrialConfig.instance:getActivityCfg(self._activityId)
	self._stepId = GoddessTrialController.instance:getCurStepId(self._activityId)
	self._curStageId = GoddessTrialModel.instance:getPassNormalStageId(self._activityId, self._stepId) + 1

	RedPointController.instance:regRedPoint(self._redPointPrize, self._activityCfg.redPointId)
	self:_refreshView()
	self._stageTabelList:MoveCellToCenter(self._curStageId - 1)
end

function GoddessTrialNormalView:_refreshView()
	local stepCfg = GoddessTrialConfig.instance:getStepCfg(self._activityId, self._stepId)
	local stageCgfs = GoddessTrialConfig.instance:getNormalStageCfgs(stepCfg.normalTrialPlanId)

	if self._curStageId > #stageCgfs then
		self._curStageId = #stageCgfs
	end

	self._stageTabelList:reloadData(stageCgfs)

	local curCfg = stageCgfs[self._curStageId]

	self._txtScore.text = langPara("通关可获得分数\n%d", curCfg.score)
	self._txtStageName.text = langPara("第%d关", curCfg.stageId)

	local creepCfg = GoddessTrialConfig.instance:getCreepsCfg(curCfg.creepsMasterId)

	for i, v in pairs(self._formationGos) do
		GameUtil.SetActive(v.go, false)
		MaterialMgr.resetAll(v.con)
	end

	for i, v in ipairs(creepCfg) do
		if self._formationGos[v.posId] then
			local cell = self._formationGos[v.posId]

			GameUtil.SetActive(cell.go, true)
			MaterialMgr.setCell(MatType.Pet, v.raceId, cell.con)
		end
	end
end

function GoddessTrialNormalView:_onClickPrize()
	UIStateManager.instance:push(ViewName.GoddessTrialPrizeView, self._activityId)
end

function GoddessTrialNormalView:_onClickChallenge()
	local canChallengeStageId = GoddessTrialModel.instance:getPassNormalStageId(self._activityId, self._stepId) + 1

	if canChallengeStageId < self._curStageId then
		FloatWordMgr.instance:show(lang("请通关前面的关卡"))
	elseif canChallengeStageId > self._curStageId then
		FloatWordMgr.instance:show(lang("已通关"))
	else
		GoddessTrialController.instance:openNormalMissionView(self._activityId, self._curStageId)
	end
end

function GoddessTrialNormalView:_updateStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local nodeGo = goutil.findChild(go, "node")
	local recordPos = go:GetComponent(ComponentType.TestRecordPos)
	local btn = goutil.findChild(nodeGo, "btn")
	local txtName = goutil.findChildTextComponent(btn, "txtName")
	local passGo = goutil.findChild(nodeGo, "pass")
	local selectGo = goutil.findChild(btn, "select")
	local curPassStageId = GoddessTrialModel.instance:getPassNormalStageId(self._activityId, self._stepId)
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local bubbleBg = goutil.findChild(go, "bubble")
	local bubbleTips = goutil.findChild(go, "txtTips")

	recordPos:LoadPlan(data.stageId % 2 == 0 and 0 or 1)
	GameUtil.SetActive(passGo, curPassStageId >= data.stageId)
	GameUtil.SetActive(selectGo, data.stageId == self._curStageId)
	GameUtil.SetActive(txtScore, data.stageId == self._curStageId)
	GameUtil.SetActive(bubbleBg, data.stageId == self._curStageId)
	GameUtil.SetActive(bubbleTips, data.stageId == self._curStageId)

	txtName.text = langPara("第%d关", data.stageId)
	txtScore.text = data.score

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickStage(data.stageId)
	end, self)
end

function GoddessTrialNormalView:_clearStageCell(cell)
	local go = cell.gameObject
	local nodeGo = goutil.findChild(go, "node")
	local btn = goutil.findChild(nodeGo, "btn")

	GameUtil.rmClickHandler(btn)
end

function GoddessTrialNormalView:_onClickStage(stageId)
	self._curStageId = stageId

	self:_refreshView()
end

function GoddessTrialNormalView:_onClickTip()
	TipsFacade.instance:openRulesView("goddess_trial_rule")
end

return GoddessTrialNormalView
