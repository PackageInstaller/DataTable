-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/view/OriginPowersClgNormalStageView.lua

module("logic.extensions.originpowersclg.view.OriginPowersClgNormalStageView", package.seeall)

local OriginPowersClgNormalStageView = class("OriginPowersClgNormalStageView", ViewComponent)
local MAX_DAILY_STAGE_NUM = 3

function OriginPowersClgNormalStageView:ctor()
	OriginPowersClgNormalStageView.super.ctor(self)
end

function OriginPowersClgNormalStageView:unbindEvents()
	OriginPowersClgNormalStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBuff)

	for i = 1, MAX_DAILY_STAGE_NUM do
		GameUtil.rmClickHandler(self._challengeForms[i].btnChallenge)
	end
end

function OriginPowersClgNormalStageView:bindEvents()
	OriginPowersClgNormalStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)

	for i = 1, MAX_DAILY_STAGE_NUM do
		GameUtil.addClickHandler(self._challengeForms[i].btnChallenge, function()
			self:_onClickFrom(i)
		end, self)
	end
end

function OriginPowersClgNormalStageView:buildUI()
	OriginPowersClgNormalStageView.super.buildUI(self)

	self._btnBuff = self:getGo("btnBuff")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._challengeForms = {}

	for i = 1, MAX_DAILY_STAGE_NUM do
		local form = {}
		local formGo = self:getGo("challenge" .. i)
		local teamEnemy = goutil.findChild(formGo, "teamEnemy")

		form.go = formGo
		form.enemyCellMap = {}

		for i = 1, 9 do
			local enemyCell = {}

			enemyCell.cellGo = goutil.findChild(teamEnemy, "cell_" .. i)
			enemyCell.con = goutil.findChild(enemyCell.cellGo, "icon")
			form.enemyCellMap[i] = enemyCell

			GameUtil.SetActive(enemyCell.cellGo, false)
		end

		form.btnChallenge = goutil.findChild(formGo, "btnChallenge")
		form.txtScore = goutil.findChildTextComponent(formGo, "txtScore")
		self._challengeForms[i] = form
	end

	self._rewardtableviewGo = self:getGo("progressReward/tableview")
	self._rewardCellGo = self:getGo("progressReward/rewardCell")
	self._rewardScrollList = ScrollerList.create(self._rewardtableviewGo, self._rewardCellGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._txtTotalScore = self:getTxt("progressReward/total/txt")
end

function OriginPowersClgNormalStageView:onExit()
	OriginPowersClgNormalStageView.super.onExit(self)
end

function OriginPowersClgNormalStageView:onEnter()
	OriginPowersClgNormalStageView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._day = OriginPowersClgController.instance:getNormalDay(self._activityId)

	OriginPowersClgAgent.instance:sendPM_OriginPowersCommonInfoReq(self._activityId)
end

function OriginPowersClgNormalStageView:_refreshView()
	local stageCfgs = OriginPowersClgConfig.instance:getNormalStageCfgs(self._activityId, self._day)

	for i = 1, MAX_DAILY_STAGE_NUM do
		local form = self._challengeForms[i]

		for j = 1, 9 do
			GameUtil.SetActive(form.enemyCellMap[j].cellGo, false)
			MaterialMgr.resetAll(form.enemyCellMap[j].con)
		end

		if stageCfgs.creepsMasterId[i] then
			local creepsCfg = OriginPowersClgConfig.instance:getCreepsCfg(stageCfgs.creepsMasterId[i])

			for j, v in ipairs(creepsCfg) do
				local enemyCell = form.enemyCellMap[v.posId]

				if enemyCell then
					MaterialMgr.resetAll(enemyCell.con)
					MaterialMgr.setIcon(enemyCell.con, MatType.Pet, v.raceId)
					GameUtil.SetActive(enemyCell.cellGo, true)
				end
			end
		else
			GameUtil.SetActive(self._challengeForms[i].go, false)
		end
	end

	local prizeList = OriginPowersClgConfig.instance:getNormalPrizeCfgs(self._activityId)

	self._totalScore = 0

	local idx = -1
	local scoreArr = {}

	for i, v in ipairs(prizeList) do
		table.insert(scoreArr, checknumber(v.progress))

		local isCanGet = self._totalScore >= checknumber(v.progress)
		local isGainPrize = OriginPowersClgModel.instance:isGainNormalPrize(self._activityId, v.prizeId)

		if isCanGet and not isGainPrize and idx == -1 then
			idx = i - 1
		end
	end

	self._rewardScrollList:reloadData(prizeList)
	self._rewardScrollList:updateUnderSlider(self._progressBar, self._totalScore, scoreArr)
	self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)

	self._txtTotalScore.text = self._totalScore
end

function OriginPowersClgNormalStageView:_updateRewardCell(view, cell, data, tag)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local received = goutil.findChild(go, "received")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local canGet = goutil.findChild(go, "canGet")
	local effect = goutil.findChild(go, "effect")

	MaterialMgr.resetAll(item)
	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.progress

	local isCanGet = self._totalScore >= checknumber(data.progress)
	local isGainPrize = OriginPowersClgModel.instance:isGainNormalPrize(self._activityId, data.prizeId)

	GameUtil.SetActive(canGet, isCanGet and not isGainPrize)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function OriginPowersClgNormalStageView:_onClickGetPrize(data)
	local isCanGet = self._totalScore >= checknumber(data.progress)
	local isGainPrize = OriginPowersClgModel.instance:isGainNormalPrize(self._activityId, data.prizeId)

	if isCanGet and not isGainPrize then
		-- block empty
	end
end

function OriginPowersClgNormalStageView:_clearRewardCell(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local effect = goutil.findChild(go, "effect")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function OriginPowersClgNormalStageView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progressReward/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function OriginPowersClgNormalStageView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function OriginPowersClgNormalStageView:_onClickBuff()
	UIStateManager.instance:push(ViewName.OriginPowersClgNormalBuffView, self._activityId)
end

function OriginPowersClgNormalStageView:_onClickFrom(index)
	OriginPowersClgController.instance:openNormalMissionView(self._activityId, index)
end

return OriginPowersClgNormalStageView
