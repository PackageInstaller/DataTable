-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressNormalStageView.lua

module("logic.extensions.divineempress.view.DivineEmpressNormalStageView", package.seeall)

local DivineEmpressNormalStageView = class("DivineEmpressNormalStageView", ViewComponent)

function DivineEmpressNormalStageView:ctor()
	DivineEmpressNormalStageView.super.ctor(self)
end

function DivineEmpressNormalStageView:unbindEvents()
	DivineEmpressNormalStageView.super.unbindEvents(self)
end

function DivineEmpressNormalStageView:bindEvents()
	DivineEmpressNormalStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCard, self._onClickCard, self)
end

function DivineEmpressNormalStageView:buildUI()
	DivineEmpressNormalStageView.super.buildUI(self)

	self._btnCard = self:getGo("btnCard")
	self._btnClose = self:getGo("btnClose")
	self._rewardCell = self:getGo("progressReward/rewardCell")
	self._rewardTableView = self:getGo("progressReward/rewardTableView")
	self._rewardScrollList = ScrollerList.create(self._rewardTableView, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._stageTablecell = self:getGo("stageTableview/stageTablecell")
	self._stageTableview = self:getGo("stageTableview")
	self._stageScrollList = ScrollerList.create(self._stageTableview, self._stageTablecell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._progressBar = self:getSlider("progressReward/rewardTableView/Viewport/Content/progressBar")
	self._txtCount = self:getTxt("progressReward/total/txt")
end

function DivineEmpressNormalStageView:onExit()
	DivineEmpressNormalStageView.super.onExit(self)
	self._rewardScrollList:dispose()

	for effGo, v in pairs(self._cellEffects) do
		self:_clearEffect(effGo)
	end

	self._stageScrollList:dispose()
end

function DivineEmpressNormalStageView:onEnter()
	DivineEmpressNormalStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineEmpressClgGetInfo, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_DivineEmpressNotifyNormalClgRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_DivineEmpressGainProgreePrizeRes, self._setProgressReward, self)

	self._activityId = self:getFirstParam()
	self._cellEffects = {}

	self:_refreshView()
end

function DivineEmpressNormalStageView:_refreshView()
	self:_refreshStageInfo()
	self:_setProgressReward()
end

function DivineEmpressNormalStageView:_refreshStageInfo()
	self._groupId = DivineEmpressController.instance:getNormalClgTodayGroupId(self._activityId)

	local list = DivineEmpressConfig.instance:getNormalClgsByGroupId(self._activityId, self._groupId)

	self._stageScrollList:reloadData(list)
end

function DivineEmpressNormalStageView:_setProgressReward()
	local prizeList = DivineEmpressConfig.instance:getNormalPrizeCfgs(self._activityId)

	self._score = DivineEmpressModel.instance:getNormalScore(self._activityId)

	local idx = -1
	local scoreArr = {}

	for i, v in ipairs(prizeList) do
		table.insert(scoreArr, v.immunityTimes)

		local isCanGet = self._score >= v.immunityTimes
		local isGainPrize = DivineEmpressModel.instance:isNormalGainPrize(self._activityId, v.progressId)

		if isCanGet and not isGainPrize and idx == -1 then
			idx = i - 1
		end
	end

	self._rewardScrollList:reloadData(prizeList)
	self._rewardScrollList:updateUnderSlider(self._progressBar, self._score, scoreArr)
	self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)

	self._txtCount.text = langPara("%d", self._score)
end

function DivineEmpressNormalStageView:_updateRewardCell(view, cell, data, tag)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local received = goutil.findChild(go, "received")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local canGet = goutil.findChild(go, "canGet")
	local effect = goutil.findChild(go, "effect")

	MaterialMgr.resetAll(item)
	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = langPara("%d次", data.immunityTimes)

	local isCanGet = self._score >= data.immunityTimes
	local isGainPrize = DivineEmpressModel.instance:isNormalGainPrize(self._activityId, data.progressId)

	GameUtil.SetActive(canGet, isCanGet and not isGainPrize)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function DivineEmpressNormalStageView:_clearRewardCell(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local effect = goutil.findChild(go, "effect")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function DivineEmpressNormalStageView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progressReward/rewardTableView/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function DivineEmpressNormalStageView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function DivineEmpressNormalStageView:_updateStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtScore = goutil.findChildTextComponent(go, "score/txtScore")
	local teamEnemy = goutil.findChild(go, "teamEnemy")
	local btn = goutil.findChild(teamEnemy, "btn")
	local teamGoMap = {}

	for i = 1, 9 do
		local cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		local cellCon = goutil.findChild(teamEnemy, "cell_" .. i .. "/icon")

		MaterialMgr.resetAll(cellCon)
		GameUtil.SetActive(cellGo, false)

		teamGoMap[i] = {
			con = cellCon,
			go = cellGo
		}
	end

	local stageInfo = DivineEmpressModel.instance:getNormalStageInfo(self._activityId, data.stageId)
	local creepCfg = DivineEmpressConfig.instance:getCreepsCfg(data.creepsMasterId)

	for i, v in ipairs(creepCfg) do
		if teamGoMap[v.posId] then
			local proxy = MaterialMgr.setIcon(teamGoMap[v.posId].con, MatType.Pet, v.raceId)

			GameUtil.SetActive(teamGoMap[v.posId].go, true)
		end
	end

	txtScore.text = langPara("今日最高免疫：%d", stageInfo.immunityTimes)

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickStage(data.stageId)
	end)
end

function DivineEmpressNormalStageView:_clearStageCell(cell)
	local go = cell.gameObject
	local teamEnemy = goutil.findChild(go, "teamEnemy")
	local btn = goutil.findChild(teamEnemy, "btn")

	for i = 1, 9 do
		local cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
		local cellCon = goutil.findChild(teamEnemy, "cell_" .. i .. "/icon")

		MaterialMgr.resetAll(cellCon)
		GameUtil.SetActive(cellGo, false)
	end

	GameUtil.rmClickHandler(btn)
end

function DivineEmpressNormalStageView:_onClickCard()
	UIStateManager.instance:push(ViewName.DivineEmpressNormalCardView, self._activityId)
end

function DivineEmpressNormalStageView:_onClickGetPrize(data)
	local isCanGet = self._score >= data.immunityTimes
	local isGainPrize = DivineEmpressModel.instance:isNormalGainPrize(self._activityId, data.progressId)

	if isCanGet and not isGainPrize then
		DivineEmpressChallengeAgent.instance:sendPM_DivineEmpressGainProgreePrizeReq(self._activityId, data.progressId)
	end
end

function DivineEmpressNormalStageView:_onClickStage(stageId)
	DivineEmpressController.instance:openNormalMissionView(self._activityId, self._groupId, stageId)
end

return DivineEmpressNormalStageView
