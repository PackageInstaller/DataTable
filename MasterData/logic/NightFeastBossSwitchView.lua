-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nightfeastbosschallenge/view/NightFeastBossSwitchView.lua

module("logic.extensions.nightfeastbosschallenge.view.NightFeastBossSwitchView", package.seeall)

local NightFeastBossSwitchView = class("NightFeastBossSwitchView", ViewComponent)

function NightFeastBossSwitchView:ctor()
	NightFeastBossSwitchView.super.ctor(self)
end

function NightFeastBossSwitchView:unbindEvents()
	NightFeastBossSwitchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnExchange)
	GameUtil.rmClickHandler(self._btnGetBuff)
	GameUtil.rmClickHandler(self._btnFight)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
end

function NightFeastBossSwitchView:bindEvents()
	NightFeastBossSwitchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickExchange, self)
	GameUtil.addClickHandler(self._btnGetBuff, self._onClickGetBuff, self)
	GameUtil.addClickHandler(self._btnFight, self._onClickFight, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function NightFeastBossSwitchView:buildUI()
	NightFeastBossSwitchView.super.buildUI(self)

	self._btnRank = self:getGo("btnRank")
	self._btnExchange = self:getGo("btnExchange")
	self._btnGetBuff = self:getGo("btnGetBuff")
	self._lefttime = self:getGo("lefttime")
	self._btnFight = self:getGo("btnFight")
	self._btnBuff = self:getGo("btnBuff")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._txtNumLeftTime = self:getTxt("lefttime/txtNum")
	self._roleCon = self:getGo("roleCon")
	self._txtTips = self:getTxt("tips/txtTips")

	local goTabPrize = self:getGo("prize/tableview")
	local goCellPrize = self:getGo("prize/cell")

	self._tableviewPrize = ScrollerList.create(goTabPrize, goCellPrize, GameUtil.handler(self._updateCellPrize, self), GameUtil.handler(self._clearCellPrize, self))
	self._txtNumProgress = self:getTxt("prize/title/txtNum")
	self._progressBar = self:getSlider("prize/tableview/viewport/content/progressBar")

	local goTabSwitch = self:getGo("tableviewSwitch")
	local goCellSwitch = self:getGo("tableviewSwitch/tablecell")

	self._tableviewSwitch = ScrollerList.create(goTabSwitch, goCellSwitch, GameUtil.handler(self._updateCellSwitch, self), GameUtil.handler(self._clearCellSwitch, self))

	local goTabRank = self:getGo("simpleRank/tableview")
	local goCellRank = self:getGo("simpleRank/tablecell")

	self._tableviewRank = ScrollerList.create(goTabRank, goCellRank, GameUtil.handler(self._updateCellRank, self), GameUtil.handler(self._clearCellRank, self))
	self._goEmpty = self:getGo("simpleRank/goEmpty")
end

function NightFeastBossSwitchView:onExit()
	NightFeastBossSwitchView.super.onExit(self)

	if self._role then
		RoleObjectPool.instance:removeRole(self._role)

		self._role = nil
	end

	self._tableviewPrize:dispose()
	self._tableviewSwitch:dispose()
	self._tableviewRank:dispose()
end

function NightFeastBossSwitchView:onEnter()
	NightFeastBossSwitchView.super.onEnter(self)

	self._activityId = 335002

	local params = self:getOpenParam()

	if params and params[1] then
		self._activityId = checknumber(params[1])
	end

	self._curBossId = self:_getLastBossId(self._activityId)

	if self._curBossId <= 0 then
		self._curBossId = NightFeastBossController.instance:getCurrentBossId(self._activityId)
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self.addGEvent(self, GlobalNotify.NightFeastBossClgGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.NightFeastBossClgGainProgressPrizeRes, self._updatePrizes, self)
	self.addGEvent(self, GlobalNotify.NightFeastBossClgGetRankRes, self._updateRank, self)
	self:_updateUIByCfg()
	self:_updateUIByInfo()
	NightFeastBossChallengeAgent.instance:sendPM_NightFeastBossClgGetInfoReq(self._activityId)
end

function NightFeastBossSwitchView:_updateUIByCfg()
	self._actCfg = NightFeastBossConfig.instance:getActivityCfg(self._activityId)
	self._bossCfgs = NightFeastBossConfig.instance:getBossCfgsList(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._fightBossTimeMax = 0

	if self._actCfg then
		self._fightBossTimeMax = self._actCfg.dailyFightBossCount
	end
end

function NightFeastBossSwitchView:_updateUIByInfo()
	self._hasFightBossCount = NightFeastBossModel.instance:getDailyHasFightBossCount(self._activityId)
	self._hasLeftTime = self._fightBossTimeMax - self._hasFightBossCount
	self._txtNumLeftTime.text = string.format("今日剩余次数：%d/%d", self._hasLeftTime, self._fightBossTimeMax)

	self:_onSwitchBoss(self._curBossId)
end

function NightFeastBossSwitchView:_onSwitchBoss(bossId)
	self._curBossId = bossId

	self:_updatePrizes()
	self:_updateRank()
	NightFeastBossChallengeAgent.instance:sendPM_NightFeastBossClgGetRankReq(self._activityId, self._curBossId)

	local curBossCfg = self._bossCfgs[self._curBossId]

	if self._role then
		RoleObjectPool.instance:removeRole(self._role)

		self._role = nil
	end

	self._txtTips.text = ""

	if curBossCfg then
		self._txtTips.text = curBossCfg.ruleDesc or ""

		local skinId = curBossCfg.raceId

		if skinId > 0 then
			local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("drawing", skinId)

			self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._roleCon, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])
		end
	end

	self._tableviewSwitch:reloadData(self._bossCfgs)
end

function NightFeastBossSwitchView:_getLastBossId(activityId)
	local key = string.format("%s_lastTab_%s", self._viewPresentor.viewName, activityId)

	return checknumber(GameUtil.getUserData(key))
end

function NightFeastBossSwitchView:_saveLastBossId(activityId, bossId)
	local key = string.format("%s_lastTab_%s", self._viewPresentor.viewName, activityId)

	GameUtil.saveUserData(key, bossId)
end

function NightFeastBossSwitchView:_onClickRank()
	UIStateManager.instance:push(ViewName.NightFeastBossRankMainView, self._curBossId)
end

function NightFeastBossSwitchView:_onClickExchange()
	local jumpToStr = self._actCfg.exchangeJumpTo

	GotoMgr.gotoByString(jumpToStr)
end

function NightFeastBossSwitchView:_onClickGetBuff()
	UIStateManager.instance:push(ViewName.NightFeastBossLevelView, self._activityId)
end

function NightFeastBossSwitchView:_onClickFight()
	if self._hasLeftTime <= 0 then
		TipsFacade.instance:openCommonTips("今日挑战次数已用完")

		return
	end

	self:_saveLastBossId(self._activityId, self._curBossId)
	NightFeastBossController.instance:openBossMissionView(self._activityId, self._curBossId)
end

function NightFeastBossSwitchView:_onClickBuff()
	UIStateManager.instance:push(ViewName.NightFeastBossBuffView, self._activityId)
end

function NightFeastBossSwitchView:_onClickTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function NightFeastBossSwitchView:_onClickClose()
	self:_saveLastBossId(self._activityId, 0)
	self:close()
end

function NightFeastBossSwitchView:_updatePrizes()
	self._curTotalDamage = 0
	self._gainedPrizeIdMap = {}

	local curPrizeCfgs = {}
	local curBossCfg = self._bossCfgs[self._curBossId]

	if curBossCfg then
		curPrizeCfgs = NightFeastBossConfig.instance:getProgressList(curBossCfg.prizePlanId) or {}
	end

	local bossInfo = NightFeastBossModel.instance:getBossInfo(self._activityId, self._curBossId)

	if bossInfo then
		if not bossInfo.progressPrizeGainedBitId then
			do
				local gainedPrizeIds = {}

				for _, id in ipairs(gainedPrizeIds) do
					self._gainedPrizeIdMap[id] = true
				end

				self._curTotalDamage = checknumber(bossInfo.totalDamage)
			end

			local showIndex = -1
			local lastIndex = -1
			local scoreList = {}

			for i, cfg in ipairs(curPrizeCfgs) do
				if checknumber(cfg.progress) <= self._curTotalDamage then
					if not self._gainedPrizeIdMap[cfg.dataBitId] then
						if showIndex <= 0 then
							showIndex = cfg.dataBitId
						end
					else
						lastIndex = i
					end
				end

				table.insert(scoreList, checknumber(cfg.progress))
			end

			if lastIndex <= 0 then
				lastIndex = 1
			end

			if showIndex <= 0 then
				showIndex = lastIndex
			end

			self._tableviewPrize:updateUnderSlider(self._progressBar, self._curTotalDamage, scoreList)
			self._tableviewPrize:reloadData(curPrizeCfgs)
			self._tableviewPrize:MoveCellToBegin(showIndex - 1)

			self._txtNumProgress.text = self:_numberToString(self._curTotalDamage)
		end
	end
end

function NightFeastBossSwitchView:_updateCellPrize(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.setCellByCfg(data.prize, item)

	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")

	txtNum.text = self:_numberToString(checknumber(data.progress))

	if not self._gainedPrizeIdMap[data.dataBitId] then
		local isGain = false
		local isMatchGain = not isGain and self._curTotalDamage >= checknumber(data.progress)
		local btnGet = goutil.findChild(cell.gameObject, "btnGet")

		goutil.setActive(btnGet, isMatchGain)

		local effect = goutil.findChild(cell.gameObject, "effect")

		if isMatchGain then
			self:_playCellEffect(effect)
			GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGainPrize, self, data.dataBitId))
		else
			self:_clearCellEffect(effect)
		end

		local geted = goutil.findChild(cell.gameObject, "geted")

		goutil.setActive(geted, isGain)
	end
end

function NightFeastBossSwitchView:_clearCellPrize(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	if item then
		MaterialMgr.resetAll(item)
	end

	local btnGet = goutil.findChild(cell.gameObject, "btnGet")

	if btnGet then
		GameUtil.rmClickHandler(btnGet)
	end

	local effect = goutil.findChild(cell.gameObject, "effect")

	if effect then
		self:_clearCellEffect(effect)
	end
end

function NightFeastBossSwitchView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("prize/tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function NightFeastBossSwitchView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function NightFeastBossSwitchView:_numberToString(num)
	return num >= 100000000 and string.format("%.2f亿", num / 100000000) or num >= 10000 and string.format("%.2f万", num / 10000) or tostring(num)
end

function NightFeastBossSwitchView:_onClickGainPrize(prizeId)
	NightFeastBossChallengeAgent.instance:sendPM_NightFeastBossClgGainProgressPrizeReq(self._activityId, prizeId, self._curBossId)
end

function NightFeastBossSwitchView:_updateCellSwitch(view, cell, data)
	local markSelect = goutil.findChild(cell.gameObject, "pet/select")
	local btnSwitch = goutil.findChild(cell.gameObject, "pet/btnSwitch")
	local icon = goutil.findChild(cell.gameObject, "pet/icon")
	local mask = goutil.findChild(cell.gameObject, "pet/mask")
	local txtDate = goutil.findChildTextComponent(cell.gameObject, "pet/mask/txt")

	MaterialMgr.setIcon(icon, MatType.PET_SKIN, data.raceId)
	goutil.setActive(markSelect, self._curBossId == data.bossId)

	local timePeriod = GameUtil.getTimePeriod(data.openTime, data.endTime)

	if timePeriod == GameUtil.inTimePeriod or timePeriod == GameUtil.afterTimePeriod then
		goutil.setActive(mask, false)
		goutil.setActive(btnSwitch, true)
		GameUtil.addClickHandler(btnSwitch, function()
			if self._curBossId ~= data.bossId then
				self:_onSwitchBoss(data.bossId)
			end
		end, self)
	elseif timePeriod == GameUtil.beforeTimePeriod then
		goutil.setActive(mask, true)
		goutil.setActive(btnSwitch, false)
		GameUtil.rmClickHandler(btnSwitch)
	end

	local dateOpen = GameUtil.string2date(data.openTime)

	txtDate.text = string.format("%02d.%02d开启", dateOpen.month, dateOpen.day)
end

function NightFeastBossSwitchView:_clearCellSwitch(cell)
	local btnSwitch = goutil.findChild(cell.gameObject, "pet/btnSwitch")

	GameUtil.rmClickHandler(btnSwitch)

	local icon = goutil.findChild(cell.gameObject, "pet/icon")

	MaterialMgr.resetAll(icon)
end

function NightFeastBossSwitchView:_updateCellRank(view, cell, data)
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtDamage = goutil.findChildTextComponent(cell.gameObject, "txtDamage")
	local imgChangeRank = goutil.findChildComponent(cell.gameObject, "imgRank", "UIImageSpriteChange")

	txtRank.text = tostring(data.rank)
	txtName.text = data.headInfo.userName
	txtDamage.text = self:_numberToString(checknumber(data.value))

	GameUtil.SetActive(imgChangeRank, data.rank <= 3 and data.rank > 0)

	if data.rank <= 3 and data.rank > 0 then
		imgChangeRank:SetState(data.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
		GameUtil.SetActive(txtRank, false)
	else
		GameUtil.SetActive(imgChangeRank, false)
		GameUtil.SetActive(txtRank, true)
	end
end

function NightFeastBossSwitchView:_clearCellRank(cell)
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtDamage = goutil.findChildTextComponent(cell.gameObject, "txtDamage")

	txtRank.text = ""
	txtName.text = ""
	txtDamage.text = ""
end

function NightFeastBossSwitchView:_updateRank()
	local rankList = {}
	local rankInfo = NightFeastBossModel.instance:getRankInfo(self._activityId, self._curBossId)

	if rankInfo then
		if not rankInfo.rankInfos then
			local rankInfos = {}
			local count = math.min(10, #rankInfos)

			for i = 1, count do
				table.insert(rankList, rankInfos[i])
			end
		end
	end

	self._tableviewRank:reloadData(rankList)

	if #rankList <= 0 then
		goutil.setActive(self._goEmpty, true)
	else
		goutil.setActive(self._goEmpty, false)
	end
end

return NightFeastBossSwitchView
