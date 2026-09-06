-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/view/OriginweileitanorstageView.lua

module("logic.extensions.originweileita.view.OriginweileitanorstageView", package.seeall)

local OriginweileitanorstageView = class("OriginweileitanorstageView", ViewComponent)

function OriginweileitanorstageView:ctor()
	OriginweileitanorstageView.super.ctor(self)
end

function OriginweileitanorstageView:unbindEvents()
	OriginweileitanorstageView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
end

function OriginweileitanorstageView:bindEvents()
	OriginweileitanorstageView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnBuff:AddClickListener(self._onClickbtnBuff, self)
end

function OriginweileitanorstageView:buildUI()
	OriginweileitanorstageView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))
	self._scrollerList:setCenterMode(true)

	self._txtDesc = self:getTxt("rule/txtDesc")
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._tableview = self:getGo("progressReward/tableview")
	self._rewardCell = self:getGo("progressReward/rewardCell")
	self._total = self:getGo("progressReward/total")
	self._txtCount = self:getTxt("progressReward/total/txt")
	self._rewardScrollList = ScrollerList.create(self._tableview, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._btnBuff = self:getBtn("btnBuff")
end

function OriginweileitanorstageView:onExit()
	OriginweileitanorstageView.super.onExit(self)
	self._scrollerList:dispose()
	self._rewardScrollList:dispose()
end

function OriginweileitanorstageView:onEnter()
	OriginweileitanorstageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginWeiLeiTaGainProgressPrizeRes, self._updateUI, self)

	self._activityId = self:getFirstParam()
	self._info = OriginWeiLeiTaModel.instance:getInfo(self._activityId)

	if self._info.normalInfo then
		self._stageInfos = self._info.normalInfo.stages or {}
	end

	self:_updateUI()
end

function OriginweileitanorstageView:_updateUI()
	self._normalProgress = OriginWeiLeiTaModel.instance:getTodayMaxScore(self._activityId)

	if self._info.normalInfo then
		self._gainProgressPrizeId = self._info.normalInfo.gainedPrizeIds or {}
	end

	self:_updateStageView()
	self:_updateReward()
end

function OriginweileitanorstageView:_updateReward()
	local prizeList = OriginWeiLeiTaConfig.instance:getNorPrizeCfgs(self._activityId) or {}
	local idx = -1
	local scoreArr = {}

	for i, v in ipairs(prizeList) do
		table.insert(scoreArr, v.progress)

		local isCanGet = self._normalProgress >= v.progress
		local isGainPrize = table.indexof(self._gainProgressPrizeId, v.prizeId) ~= false

		if isCanGet and not isGainPrize and idx == -1 then
			idx = i - 1
		end
	end

	self._rewardScrollList:reloadData(prizeList)
	self._rewardScrollList:updateUnderSlider(self._progressBar, self._normalProgress, scoreArr)
	self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)

	self._txtCount.text = self._normalProgress
end

function OriginweileitanorstageView:_updateStageView()
	self:_updateFormations()
	self:_updateRule()
end

function OriginweileitanorstageView:_updateFormations()
	self._scrollerList:reloadData(self._stageInfos)
end

function OriginweileitanorstageView:_updateRule()
	local ruleCfg = RulesConfig.instance:getRuleCo("originweileitanorstage")

	if ruleCfg then
		self._txtDesc.text = ruleCfg.rules
	end
end

function OriginweileitanorstageView:_updateCell(view, cell, stageInfo, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "desc/txtDesc")
	local posList = {}

	for i = 1, 9 do
		local petPosCell = {}

		petPosCell.go = goutil.findChild(cell.gameObject, "formation/cell_" .. i)
		petPosCell.con = goutil.findChild(petPosCell.go, "con")
		posList[i] = petPosCell
	end

	local stageCfg = OriginWeiLeiTaConfig.instance:getNorStageCfg(self._activityId, stageInfo.stageId)

	self:_petPosReset(posList)

	local creepsCfgs = OriginWeiLeiTaConfig.instance:getCreepsCfgs(stageCfg.creepsMasterId) or {}

	for i, v in ipairs(creepsCfgs) do
		local cellCfg = creepsCfgs[i]

		if cellCfg.posId > 0 and posList[cellCfg.posId] then
			GameUtil.SetActive(posList[cellCfg.posId].go, true)

			local faceId = checknumber(cellCfg.faceId) > 0 and checknumber(cellCfg.faceId) or cellCfg.raceId
			local modelCo = CharacterConfig.instance:getModelCo(faceId)

			if modelCo then
				uGuiUtil.setSpriteToImage(posList[cellCfg.posId].con, uGuiUtil.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
			end
		end
	end

	btn:AddClickListener(function()
		local fmtMo = OriginWeiLeiTaModel.instance:getNorFmtMo()

		fmtMo:initParams(self._activityId, stageInfo.stageId, stageCfg.creepsMasterId)
		CustomFmtController.instance:showMissionView(fmtMo)
	end)

	local value = stageInfo.todayMaxScore

	txtDesc.text = string.format("今日最多超杀次数：%s", value)
end

function OriginweileitanorstageView:_petPosReset(posList)
	for i = 1, #posList do
		GameUtil.SetActive(posList[i].go, false)
		uGuiUtil.clearImage(posList[i].con)
	end
end

function OriginweileitanorstageView:_clearCell(cell)
	return
end

function OriginweileitanorstageView:_onClickbtnTip()
	local challengeCfg = OriginWeiLeiTaController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OriginweileitanorstageView:_onClickbtnClose()
	self:close()
end

function OriginweileitanorstageView:_onReloadFinish()
	return
end

function OriginweileitanorstageView:_updateRewardCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.progress

	local isCanGet = self._normalProgress >= data.progress
	local isGainPrize = table.indexof(self._gainProgressPrizeId, data.prizeId) ~= false

	GameUtil.SetActive(canGet, isCanGet)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function OriginweileitanorstageView:_onClickGetPrize(data)
	local isCanGet = self._normalProgress >= data.progress
	local isGainPrize = table.indexof(self._gainProgressPrizeId, data.prizeId) ~= false

	if isCanGet and not isGainPrize then
		OriginWeiLeiTaAgent.instance:sendPM_OriginWeiLeiTaGainProgressPrizeReq(self._activityId, data.prizeId)
	end
end

function OriginweileitanorstageView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function OriginweileitanorstageView:_playEffect(effGo)
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

function OriginweileitanorstageView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function OriginweileitanorstageView:_onClickbtnBuff()
	UIStateManager.instance:push(ViewName.OriginweileitabufftipView, self._activityId)
end

return OriginweileitanorstageView
