-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaresmom/view/OriginaresmomnorstageView.lua

module("logic.extensions.originaresmom.view.OriginaresmomnorstageView", package.seeall)

local OriginaresmomnorstageView = class("OriginaresmomnorstageView", ViewComponent)

function OriginaresmomnorstageView:ctor()
	OriginaresmomnorstageView.super.ctor(self)
end

function OriginaresmomnorstageView:unbindEvents()
	OriginaresmomnorstageView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function OriginaresmomnorstageView:bindEvents()
	OriginaresmomnorstageView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function OriginaresmomnorstageView:buildUI()
	OriginaresmomnorstageView.super.buildUI(self)

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
end

function OriginaresmomnorstageView:onExit()
	OriginaresmomnorstageView.super.onExit(self)
	self._scrollerList:dispose()
	self._rewardScrollList:dispose()
end

function OriginaresmomnorstageView:onEnter()
	OriginaresmomnorstageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginAresMomClgGainNormalPrizeRes, self._updateUI, self)

	self._activityId = self:getFirstParam()
	self._isFirstEnter = true
	self._stageCfgs = OriginaresmomConfig.instance:getNorStageCfgs(self._activityId)

	self:_updateUI()
end

function OriginaresmomnorstageView:_updateUI()
	self._info = OriginaresmomModel.instance:getInfo(self._activityId)
	self._normalProgress = self._info.normalProgress
	self._gainProgressPrizeId = self._info.normalGainedPrizeIds

	self:_updateStageView()
	self:_updateReward()
end

function OriginaresmomnorstageView:_updateReward()
	local prizeList = OriginaresmomConfig.instance:getNorPrizeCfgs(self._activityId) or {}
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

function OriginaresmomnorstageView:_updateStageView()
	self:_updateFormations()
	self:_updateRule()
end

function OriginaresmomnorstageView:_updateFormations()
	local stime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.OriginaresMom, self._activityId)
	local day = GameUtil.getDaysByTimestamp(stime, ServerTime.now())
	local cnt = #self._stageCfgs

	if cnt < day then
		day = day % cnt

		if day == 0 then
			day = cnt
		end
	end

	local stageCfg = self._stageCfgs[day]

	self._scrollerList:reloadData(stageCfg.creepsMasterIds)
end

function OriginaresmomnorstageView:_updateRule()
	local ruleCfg = RulesConfig.instance:getRuleCo("originaresmomnorstage")

	self._txtDesc.text = ruleCfg.rules
end

function OriginaresmomnorstageView:_updateCell(view, cell, creepsMasterId, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local passGo = goutil.findChild(cell.gameObject, "passGo")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "name/txtName")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "desc/txtDesc")
	local posList = {}

	for i = 1, 9 do
		local petPosCell = {}

		petPosCell.go = goutil.findChild(cell.gameObject, "formation/cell_" .. i)
		petPosCell.con = goutil.findChild(petPosCell.go, "con")
		posList[i] = petPosCell
	end

	self:_petPosReset(posList)

	local creepsCfgs = OriginaresmomConfig.instance:getCreepsCfgs(creepsMasterId)

	for i, v in ipairs(creepsCfgs) do
		local cellCfg = creepsCfgs[i]

		if cellCfg.posId > 0 then
			GameUtil.SetActive(posList[cellCfg.posId].go, true)

			local faceId = checknumber(cellCfg.faceId) > 0 and checknumber(cellCfg.faceId) or cellCfg.raceId
			local modelCo = CharacterConfig.instance:getModelCo(faceId)

			uGuiUtil.setSpriteToImage(posList[cellCfg.posId].con, uGuiUtil.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		end
	end

	btn:AddClickListener(function()
		if OriginaresmomModel.instance:isAllNorStagePass(self._activityId) then
			FloatWordMgr.instance:show("已领取所有奖励")

			return
		end

		local fmtMo = OriginaresmomModel.instance:getNorFmtMo()

		fmtMo:initParams(self._activityId, cell.data, creepsMasterId)
		CustomFmtController.instance:showMissionView(fmtMo)
	end)

	local value = OriginaresmomModel.instance:getNormalDailyMaxScore(self._activityId, cell.data)
	local masterCfg = OriginaresmomConfig.instance:getCreepsMasterCfg(creepsMasterId)

	txtDesc.text = string.format("今日最多复活次数：%s", value)
	txtName.text = masterCfg.name
end

function OriginaresmomnorstageView:_petPosReset(posList)
	for i = 1, #posList do
		GameUtil.SetActive(posList[i].go, false)
		uGuiUtil.clearImage(posList[i].con)
	end
end

function OriginaresmomnorstageView:_clearCell(cell)
	return
end

function OriginaresmomnorstageView:_onClickbtnTip()
	local challengeCfg = OriginaresmomController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OriginaresmomnorstageView:_onClickbtnClose()
	DivinewatertianyanModel.instance:setCurrStageType(nil)
	self:close()
end

function OriginaresmomnorstageView:_onReloadFinish()
	return
end

function OriginaresmomnorstageView:_updateRewardCell(view, cell, data, tag)
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

function OriginaresmomnorstageView:_onClickGetPrize(data)
	local isCanGet = self._normalProgress >= data.progress
	local isGainPrize = table.indexof(self._gainProgressPrizeId, data.prizeId) ~= false

	if isCanGet and not isGainPrize then
		OriginAresMomClgAgent.instance:sendPM_OriginAresMomClgGainNormalPrizeReq(self._activityId, data.prizeId)
	end
end

function OriginaresmomnorstageView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function OriginaresmomnorstageView:_playEffect(effGo)
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

function OriginaresmomnorstageView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

return OriginaresmomnorstageView
