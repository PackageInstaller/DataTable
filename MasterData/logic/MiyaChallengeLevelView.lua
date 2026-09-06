-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miyachallenge/view/MiyaChallengeLevelView.lua

module("logic.extensions.miyachallenge.view.MiyaChallengeLevelView", package.seeall)

local MiyaChallengeLevelView = class("MiyaChallengeLevelView", ViewComponent)

function MiyaChallengeLevelView:ctor()
	MiyaChallengeLevelView.super.ctor(self)
end

function MiyaChallengeLevelView:buildUI()
	MiyaChallengeLevelView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._btnClose = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._stageInfo = self:getGo("stageInfo")
	self._btnStart = self:getBtn("stageInfo/btnStart")
	self._btnReload = self:getBtn("stageInfo/btnReload")
	self._btnReward = self:getBtn("stageInfo/btnReward")
	self._stageview = self:getGo("stageInfo/tableview")
	self._stagecell = self:getGo("stageInfo/stageCell")
	self._levels = self:getGo("levels")
	self._levelCells = {}

	for i = 1, 3 do
		table.insert(self._levelCells, {
			btn = self:getBtn("levels/cell_" .. i),
			select = self:getGo("levels/cell_" .. i .. "/select"),
			name = self:getTxt("levels/cell_" .. i .. "/txtName")
		})
	end

	self._clockEffectGo = self:getGo("clockEffect")
	self._txtStageName = self:getTxt("stageInfo/txtLevelTitle")
	self._txtStageDesc = self:getTxt("stageInfo/txtStageInfo")
	self._prizeTableView = self:getGo("stageInfo/totalReward")
	self._prizeCell = self:getGo("stageInfo/itemScrollercell")
	self._pan = self:getGo("bg/pan")
	self._empty = self:getGo("empty")
	self._longArrow = self:getGo("empty/pan/arrowLong")
	self._midArrow = self:getGo("empty/pan/arrowMid")
	self._txtEmpty = self:getTxt("empty/txtEmpty")
	self._txtBuyTime = self:getTxt("stageInfo/txtBuyTime")
	self._animator = self.mainGO:GetComponent(ComponentType.Animator)
end

function MiyaChallengeLevelView:bindEvents()
	MiyaChallengeLevelView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnReload, self._onClickReload, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickReward, self)

	for i = 1, 3 do
		GameUtil.addClickHandler(self._levelCells[i].btn, function()
			self:_onClickBigStage(i)
		end, self)
	end
end

function MiyaChallengeLevelView:unbindEvents()
	MiyaChallengeLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnReload)
	GameUtil.rmClickHandler(self._btnReward)

	for i = 1, 3 do
		GameUtil.rmClickHandler(self._levelCells[i].btn)
	end
end

function MiyaChallengeLevelView:onEnter()
	MiyaChallengeLevelView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._activityCfg = MiyaChallengeConfig.instance:getActivityCfg(self._activityId)
	self._selectBigStage = 0

	GlobalDispatcher:addListener(GlobalNotify.MiyaChallengeGetInfoRes, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.MiyaChallengeGetStageInfo, self._refreshInfoView, self)

	self._stageTable = ScrollerList.create(self._stageview, self._stagecell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._prizeTabel = ScrollerList.create(self._prizeTableView, self._prizeCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._mainEff = UIEffectManager.instance:playEffect(self, "20221125/zhuzaimiyatiaozhan/fx_ui_lizixunhuan.prefab", nil, 0, 0, true)

	self._mainEff:setParent(self._bg.transform)
	self._mainEff:setLocalPos(0, 0, 0)
	self._mainEff:setScale(1)
	GameUtil.SetActive(self._stageInfo, false)

	for i = 1, 3 do
		GameUtil.SetActive(self._levelCells[i].btn, false)
	end

	GameUtil.SetActive(self._pan, true)
	GameUtil.SetActive(self._levels, false)
	self._animator:Play("zhuzaimiyatiaozhan03")

	self._hadShowInfo = nil
	self._closing = nil

	settimer(0.5, function()
		MiyaChallengeController.instance:sendPM_MiyaChallengeGetInfoReq(self._activityId)
	end, self, false)
end

function MiyaChallengeLevelView:onExit()
	MiyaChallengeLevelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MiyaChallengeGetInfoRes, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.MiyaChallengeGetStageInfo, self._refreshInfoView, self)
	GlobalDispatcher:removeListener(GlobalNotify.MiyaChallengeBuyAndRandom, self._refreshInfoView, self)
	removetimer(self._onClockTime, self)
	removetimer(self._firstEnter, self)
	removetimer(self.close, self)
	removetimer(self._moveArrow, self)
	UIEffectManager.instance:stopEffect(self._mainEff)
	UIEffectManager.instance:stopEffect(self._clockEffect)
	UIEffectManager.instance:stopEffect(self._endEffect)
	self._stageTable:dispose()
	self._prizeTabel:dispose()
end

function MiyaChallengeLevelView:_refreshView()
	self._tierCfg = MiyaChallengeConfig.instance:getTierStageCfg(self._activityCfg.tierPlanId, MiyaChallengeModel.instance:getTierId())
	self._closing = true
	self._haveLevel = false

	for i = 1, 3 do
		if MiyaChallengeModel.instance:getBigStagePass(i) ~= true then
			self._haveLevel = true

			GameUtil.SetActive(self._levelCells[i].btn, true)

			if i == 1 then
				self._levelCells[i].name = self._tierCfg.firstName
			elseif i == 2 then
				self._levelCells[i].name = self._tierCfg.secondName
			elseif i == 3 then
				self._levelCells[i].name = self._tierCfg.thirdName
			end
		else
			GameUtil.SetActive(self._levelCells[i].btn, false)
		end
	end

	for i, v in ipairs(self._levelCells) do
		GameUtil.SetActive(v.select, false)
	end

	if MiyaChallengeModel.instance:getPassBigStage() then
		GameUtil.SetActive(self._levelCells[MiyaChallengeModel.instance:getPassBigStage()].btn, true)
	end

	self._selectBigStage = MiyaChallengeModel.instance:getBigStage()

	if self._selectBigStage == 0 then
		self._selectBigStage = 1
	end

	if MiyaChallengeModel.instance:getBigStagePass(self._selectBigStage) == true then
		self._selectBigStage = 0

		for i = 1, 3 do
			if MiyaChallengeModel.instance:getBigStagePass(i) == false then
				self._selectBigStage = i

				break
			end
		end
	end

	if self._haveLevel == false then
		GameUtil.SetActive(self._empty, false)
		GameUtil.SetActive(self._pan, true)
		GameUtil.SetActive(self._levels, false)
		GameUtil.SetActive(self._stageInfo, false)

		self._txtEmpty.text = lang("距离下次修复时钟还剩:")

		local startTime, endTime = GameUtil.getTimestampOnStartAndEnd(ServerTime.now(), 1, 1)

		self._tagTime = endTime

		self:_onClockTime()
		removetimer(self._onClockTime, self)
		settimer(1, self._onClockTime, self, true)
	else
		GameUtil.SetActive(self._txtEmpty, false)
		GameUtil.SetActive(self._levels, true)
		GameUtil.SetActive(self._pan, false)

		self._txtEmpty.text = ""
	end

	if not MiyaChallengeModel.instance:getDailyGameStart() then
		settimer(1, self._firstEnter, self, false)
	else
		settimer(0, self._firstEnter, self, false)
	end

	if not MiyaChallengeModel.instance:getDailyGameStart() then
		self._animator:Play("zhuzaimiyatiaozhan01")
		MiyaChallengeModel.instance:setDailyGameStart()
	end
end

function MiyaChallengeLevelView:_refreshInfoView()
	local stageInfo

	if self._selectBigStage == 1 then
		stageInfo = MiyaChallengeConfig.instance:getStageCfg(self._tierCfg.firstPlanId, MiyaChallengeModel.instance:getStageSelect(self._selectBigStage))
	elseif self._selectBigStage == 2 then
		stageInfo = MiyaChallengeConfig.instance:getStageCfg(self._tierCfg.secondPlanId, MiyaChallengeModel.instance:getStageSelect(self._selectBigStage))
	elseif self._selectBigStage == 3 then
		stageInfo = MiyaChallengeConfig.instance:getStageCfg(self._tierCfg.thirdPlanId, MiyaChallengeModel.instance:getStageSelect(self._selectBigStage))
	end

	local prizes = string.split(stageInfo.prize, "#")

	self._prizeTabel:reloadData(prizes)

	if self._selectBigStage == 1 then
		self._txtStageName.text = self._tierCfg.firstName
	elseif self._selectBigStage == 2 then
		self._txtStageName.text = self._tierCfg.secondName
	elseif self._selectBigStage == 3 then
		self._txtStageName.text = self._tierCfg.thirdName
	end

	self._txtStageDesc.text = stageInfo.stageDesc
	self._txtBuyTime.text = langPara("次数:%d/%d", self._activityCfg.buyTimeLimit - MiyaChallengeModel.instance:getBuyTime(), self._activityCfg.buyTimeLimit)

	if MiyaChallengeModel.instance:getExchangeBuff() then
		UIStateManager.instance:push(ViewName.MiyaChallengeSelectView, self.activityId, self._selectBigStage, MiyaChallengeModel.instance:getStageSelect(self._selectBigStage))
	end

	GameUtil.SetActive(self._btnReward, stageInfo.prizes and #stageInfo.prizes > 0)
	GameUtil.SetActive(self._txtBuyTime, MiyaChallengeModel.instance:getBuff())
	GameUtil.SetActive(self._btnReload, MiyaChallengeModel.instance:getBuff())
end

function MiyaChallengeLevelView:_updateStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local select = goutil.findChild(go, "select")
	local pass = goutil.findChild(go, "pass")
	local challenge = goutil.findChild(go, "challenge")
	local btn = GameUtil.asBtn(go)
	local name = goutil.findChildTextComponent(go, "txtName")

	GameUtil.SetActive(select, MiyaChallengeModel.instance:getStageSelect(self._selectBigStage) == data.stageId)

	name.text = GameUtil.toRomanNumber(data.stageId)

	btn:RemoveClickListener()
	GameUtil.SetActive(pass, false)
	GameUtil.SetActive(challenge, false)

	local finishList

	if self._selectBigStage == 1 then
		finishList = MiyaChallengeModel.instance:getFirstFinishIds()
	elseif self._selectBigStage == 2 then
		finishList = MiyaChallengeModel.instance:getSecondFinishIds()
	elseif self._selectBigStage == 3 then
		finishList = MiyaChallengeModel.instance:getThirdFinishIds()
	end

	if not finishList[data.stageId] then
		if self._selectBigStage == 1 and MiyaChallengeModel.instance:getDamage(data.stageId) > 0 then
			GameUtil.SetActive(challenge, true)
		end

		btn:AddClickListener(function()
			MiyaChallengeModel.instance:setStageSelect(self._selectBigStage, data.stageId)
			self._stageTable:refresh()
			MiyaChallengeController.instance:sendPM_MiyaChallengeGetStageInfoReq(self._activityId, MiyaChallengeModel.instance:getTierId(), self._selectBigStage, MiyaChallengeModel.instance:getStageSelect(self._selectBigStage))
		end, self)
	else
		GameUtil.SetActive(pass, true)
	end
end

function MiyaChallengeLevelView:_clearStageCell(cell)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(go)

	btn:RemoveClickListener()
end

function MiyaChallengeLevelView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function MiyaChallengeLevelView:_clearPrizeCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function MiyaChallengeLevelView:_firstEnter()
	function completeEnd()
		if self._haveLevel == true and self._selectBigStage ~= 0 then
			self:_onClickBigStage(self._selectBigStage)
		else
			self._endEffect = UIEffectManager.instance:playEffect(self, "20221125/zhuzaimiyatiaozhan/fx_ui_shanglow.prefab", nil, 0, 0, true, nil, nil, function()
				GameUtil.SetActive(self._empty, true)
				GameUtil.SetActive(self._txtEmpty, true)
				settimer(0.02, self._moveArrow, self, true)
			end)

			self._endEffect:setParent(self._bg.transform)
			self._endEffect:setLocalPos(0, 0, 0)
			self._endEffect:setScale(1)
		end

		self._closing = nil
	end

	if MiyaChallengeModel.instance:getPassBigStage() ~= nil then
		local pos = GameUtil.getAnchoredPos(self._levelCells[MiyaChallengeModel.instance:getPassBigStage()].btn.gameObject)

		GameUtil.setAnchoredPos(self._clockEffectGo, pos.x, pos.y)

		self._clockEffect = UIEffectManager.instance:playEffect(self, "20221125/zhuzaimiyatiaozhan/fx_ui_3d.prefab", nil, 0, 0, false, nil, completeEnd)

		self._clockEffect:setParent(self._clockEffectGo.transform)
		self._clockEffect:setLocalPos(0, 0, 0)
		self._clockEffect:setScale(1)
	else
		if self._haveLevel == true and self._selectBigStage ~= 0 then
			self:_onClickBigStage(self._selectBigStage)
		else
			GameUtil.SetActive(self._empty, true)
			GameUtil.SetActive(self._txtEmpty, true)
			settimer(0.02, self._moveArrow, self, true)
		end

		self._closing = nil
	end

	if MiyaChallengeModel.instance:getPassBigStage() and MiyaChallengeModel.instance:getBigStagePass(MiyaChallengeModel.instance:getPassBigStage()) == true then
		GameUtil.SetActive(self._levelCells[MiyaChallengeModel.instance:getPassBigStage()].btn, false)
		MiyaChallengeModel.instance:resetPassBigStage()
	end
end

function MiyaChallengeLevelView:_showInfo()
	if not self._hadShowInfo then
		GameUtil.SetActive(self._stageInfo, true)
		self._animator:Play("zhuzaimiyatiaozhan02")

		self._hadShowInfo = true
	end
end

function MiyaChallengeLevelView:_onClickBigStage(bigStage)
	removetimer(self._firstEnter, self)
	self:_showInfo()

	self._selectBigStage = bigStage

	local stageInfo

	if self._selectBigStage == 1 then
		stageInfo = MiyaChallengeConfig.instance:getStagesCfg(self._tierCfg.firstPlanId)
	elseif self._selectBigStage == 2 then
		stageInfo = MiyaChallengeConfig.instance:getStagesCfg(self._tierCfg.secondPlanId)
	elseif self._selectBigStage == 3 then
		stageInfo = MiyaChallengeConfig.instance:getStagesCfg(self._tierCfg.thirdPlanId)
	end

	if stageInfo then
		self._stageTable:reloadData(stageInfo)

		for i, v in ipairs(self._levelCells) do
			GameUtil.SetActive(v.select, i == self._selectBigStage)
		end

		MiyaChallengeController.instance:sendPM_MiyaChallengeGetStageInfoReq(self._activityId, MiyaChallengeModel.instance:getTierId(), self._selectBigStage, MiyaChallengeModel.instance:getStageSelect(self._selectBigStage))
	end
end

function MiyaChallengeLevelView:_onClickClose()
	if self._haveLevel == false then
		self:close()
	elseif not self._closing then
		GameUtil.SetActive(self._stageInfo, false)
		self._animator:Play("zhuzaimiyatiaozhan03")
		settimer(0.5, self.close, self, false)

		self._closing = true
	end
end

function MiyaChallengeLevelView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, self._activityCfg.ruleKey)
end

function MiyaChallengeLevelView:_onClickStart()
	if MiyaChallengeModel.instance:getExchangeBuff() then
		UIStateManager.instance:push(ViewName.MiyaChallengeSelectView, self.activityId, self._selectBigStage, MiyaChallengeModel.instance:getStageSelect(self._selectBigStage))

		return
	end

	if MiyaChallengeModel.instance:getBuff() then
		local customFmtMo = MiyaChallengeModel.instance:getCustomFmtMo()

		customFmtMo:initParams()
		CustomFmtController.instance:showMissionView(customFmtMo)
	else
		UIStateManager.instance:push(ViewName.MiyaChallengeWheelView)
	end
end

function MiyaChallengeLevelView:_onClickReload()
	if MiyaChallengeModel.instance:getExchangeBuff() then
		UIStateManager.instance:push(ViewName.MiyaChallengeSelectView, self.activityId, self._selectBigStage, MiyaChallengeModel.instance:getStageSelect(self._selectBigStage))

		return
	end

	UIStateManager.instance:push(ViewName.MiyaChallengeWheelView)
end

function MiyaChallengeLevelView:_onClickReward()
	UIStateManager.instance:push(ViewName.MiyaChallengeRewardView)
end

function MiyaChallengeLevelView:_onClockTime()
	self._txtEmpty.text = langPara("距离下次修复时钟还剩:%s", GameUtil.FormatTimeSymbol(self._tagTime - ServerTime.now()), self._tagTime, ServerTime.now())
end

function MiyaChallengeLevelView:_moveArrow()
	self._longArrow.transform:Rotate(0, 0, 1)
	self._midArrow.transform:Rotate(0, 0, 1)
end

return MiyaChallengeLevelView
