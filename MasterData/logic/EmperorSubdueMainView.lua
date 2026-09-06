-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emperorsubdue/view/EmperorSubdueMainView.lua

module("logic.extensions.emperorsubdue.view.EmperorSubdueMainView", package.seeall)

local EmperorSubdueMainView = class("EmperorSubdueMainView", ViewComponent)

function EmperorSubdueMainView:ctor()
	EmperorSubdueMainView.super.ctor(self)

	self._curSelectId = 0
	self._curSelectStageId = 0
end

local displayParams = {
	{
		titleScale = 1,
		posY = -9,
		titlePosY = 2,
		scale = 1,
		posX = -378
	},
	{
		titleScale = 0.7,
		posY = 90,
		titlePosY = 63,
		scale = 0.34,
		posX = -94.8
	},
	{
		titleScale = 0.7,
		posY = 144.8,
		titlePosY = 52,
		scale = 0.4,
		posX = 90.7
	},
	{
		titleScale = 0.7,
		posY = 209,
		titlePosY = 40,
		scale = 0.45,
		posX = 296
	},
	{
		titleScale = 0.7,
		posY = 244.2,
		titlePosY = 35,
		scale = 0.45,
		posX = 515.4
	},
	{
		titleScale = 0.7,
		posY = -257,
		titlePosY = 62,
		scale = 0.34,
		posX = -551
	}
}

function EmperorSubdueMainView:unbindEvents()
	EmperorSubdueMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnFightBoss)
	GameUtil.rmClickHandler(self._btnTrial)
	GameUtil.rmClickHandler(self._btnPicRule)
	GameUtil.rmClickHandler(self._btnFightStage)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)

	for i, cell in ipairs(self._switchCells) do
		GameUtil.rmClickHandler(cell.btn)
	end
end

function EmperorSubdueMainView:bindEvents()
	EmperorSubdueMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnFightBoss, self._onClickClgFightBoss, self)
	GameUtil.addClickHandler(self._btnTrial, self._onClickTrial, self)
	GameUtil.addClickHandler(self._btnPicRule, self._onClickPicRule, self)
	GameUtil.addClickHandler(self._btnFightStage, self._onClickFightStage, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnLeft, self._onClickRight, self)
	GameUtil.addClickHandler(self._btnRight, self._onClickLeft, self)

	for i, cell in ipairs(self._switchCells) do
		local stageId = i

		GameUtil.addClickHandler(cell.btn, function()
			self:_switchSelectStage(stageId)
		end, self)
	end
end

function EmperorSubdueMainView:buildUI()
	EmperorSubdueMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._bossCom = self:getGo("bossCom")
	self._btnRank = self:getGo("bossCom/btnRank")
	self._btnFightBoss = self:getGo("bossCom/btnFightBoss")
	self._btnTrial = self:getGo("bossCom/btnTrial")
	self._txtTimeTips = self:getTxt("bossCom/txtTimeTips")
	self._txtBossRule = self:getTxt("bossCom/rule/Viewport/txt")

	local cellProgress = self:getGo("bossCom/prize/cell")
	local tabProgress = self:getGo("bossCom/prize/tableview")

	self._tableviewProgress = ScrollerList.create(tabProgress, cellProgress, GameUtil.handler(self._updateProgressCell, self), GameUtil.handler(self._clearProgressCell, self))
	self._progressBar = self:getSlider("bossCom/prize/tableview/viewport/content/progressBar")
	self._txtNumDamage = self:getTxt("bossCom/prize/damageNum/txtNum")
	self._txtMaxDam = self:getTxt("bossCom/txtMaxDam")
	self._txtTodayMaxDam = self:getTxt("bossCom/txtTodayMaxDam")
	self._txtTitleBoss = self:getTxt("bossCom/txtTitle")
	self._stageCom = self:getGo("stageCom")
	self._btnPicRule = self:getGo("stageCom/btnPicRule")
	self._btnFightStage = self:getGo("stageCom/btnFightStage")
	self._btnReset = self:getGo("stageCom/btnReset")

	local goCellStagePrize = self:getGo("stageCom/prize/tableview/tablecell")
	local goTableviewStagePrize = self:getGo("stageCom/prize/tableview")

	self._tableviewStagePrize = ScrollerList.create(goTableviewStagePrize, goCellStagePrize, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._txtStageRule = self:getTxt("stageCom/rule/Viewport/txt")
	self._txtTitle = self:getTxt("stageCom/txtTitle")
	self._btnLeft = self:getGo("btnLeft")
	self._btnRight = self:getGo("btnRight")
	self._switchCells = {}

	for i = 1, #displayParams do
		local cell = {}

		cell.go = self:getGo("switchcells/cell_" .. i)
		cell.info = goutil.findChild(cell.go, "info")
		cell.btn = goutil.findChild(cell.go, "info/btn")
		cell.pass = goutil.findChild(cell.go, "info/pass")
		cell.icon = goutil.findChild(cell.go, "info/icon")
		cell.title = goutil.findChild(cell.go, "title")
		cell.txtTitle = goutil.findChildTextComponent(cell.go, "title/txt")
		self._switchCells[i] = cell
	end
end

function EmperorSubdueMainView:onExit()
	EmperorSubdueMainView.super.onExit(self)
	self._tableviewProgress:dispose()
	self._tableviewStagePrize:dispose()

	for i, cell in ipairs(self._switchCells) do
		MaterialMgr.resetAll(cell.icon)
	end

	self:_setLastSelectId()
end

function EmperorSubdueMainView:onEnter()
	EmperorSubdueMainView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = 547001

	if params then
		self._activityId = checknumber(params[1])
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	self.addGEvent(self, GlobalNotify.PM_EmperorSubdueInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_EmperorSubdueResetRes, self._handleResetClg, self)
	EmperorSubdueController.instance:getInfo(self._activityId)
	EmperorSubdueController.instance:showCI()
end

function EmperorSubdueMainView:_updateUIByCfg()
	self._actCfg = EmperorSubdueConfig.instance:getActCfg(self._activityId)
	self._stageCfgs = EmperorSubdueConfig.instance:getStageCfgs(self._activityId) or {}
	self._bossCfgs = EmperorSubdueConfig.instance:getBossCfgs(self._activityId) or {}
	self._maxDailyBossClgTimes = #self._bossCfgs
	self._bossPrizeCfgs = EmperorSubdueConfig.instance:getProgressCfgs(self._activityId) or {}

	for i, cfg in ipairs(self._stageCfgs) do
		local cell = self._switchCells[i]

		if cell then
			cell.txtTitle.text = cfg.title or ""

			if not cfg.headRaceId then
				MaterialMgr.setIcon(cell.icon, MatType.PET_SKIN, cfg.headRaceId)
			end
		end
	end

	local cell = self._switchCells[#self._stageCfgs + 1]

	if cell then
		cell.txtTitle.text = self._actCfg.bossTitle or "Boss挑战"

		MaterialMgr.setIcon(cell.icon, MatType.PET_SKIN, self._actCfg.bossHeadRaceId or 0)
	end

	self._txtTitleBoss.text = self._actCfg.bossTitle or "Boss挑战"
end

function EmperorSubdueMainView:_updateUIByInfo()
	self._hasPassStageIdMap = {}
	self._hasGainStagePrizeIdMap = {}
	self._totalDamage = 0
	self._hasGainProgressPrizeIdMap = {}
	self._todayTotalDamage = 0
	self._maxDailyDamage = 0
	self._todayChallengeTimes = 0

	local info = EmperorSubdueModel.instance:getInfoByActId(self._activityId)

	if info then
		if not info.hasPassStageIds then
			local hasPassStageIds = {}

			for _, stageId in ipairs(hasPassStageIds) do
				self._hasPassStageIdMap[stageId] = true
			end

			if not info.hasGainStagePrizeIds then
				for _, stageId in ipairs(info.hasGainStagePrizeIds) do
					self._hasGainStagePrizeIdMap[stageId] = true
				end

				self._totalDamage = checknumber(info.totalDamage) or 0

				if not info.hasGainProgressPrizeIds then
					local hasGainProgressPrizeIds = {}

					for _, prizeId in ipairs(hasGainProgressPrizeIds) do
						self._hasGainProgressPrizeIdMap[prizeId] = true
					end

					self._todayTotalDamage = checknumber(info.todayTotalDamage) or 0
					self._maxDailyDamage = checknumber(info.maxDailyDamage) or 0
					self._todayChallengeTimes = checknumber(info.todayChallengeTimes) or 0
				end
			end
		end
	end

	self._stageWithBuffMap = {}

	for _, stageCfg in pairs(self._stageCfgs) do
		self._stageWithBuffMap[stageCfg.stageId] = {}
	end

	for stageId, _ in pairs(self._hasPassStageIdMap) do
		local stageCfg = self._stageCfgs[stageId]

		if stageCfg then
			if not stageCfg.counterStage then
				local counterStage = {}

				for _, affectedStageId in ipairs(counterStage) do
					local affectedStageBuffs = self._stageWithBuffMap[affectedStageId]

					if affectedStageBuffs then
						table.insert(affectedStageBuffs, stageId)
					end
				end
			end
		end
	end

	self._txtTimeTips.text = string.format("今日挑战次数：%d/%d", self._maxDailyBossClgTimes - self._todayChallengeTimes, self._maxDailyBossClgTimes)

	local curBossCfg = self._bossCfgs[self._todayChallengeTimes + 1]

	if self._maxDailyBossClgTimes <= self._todayChallengeTimes then
		curBossCfg = self._bossCfgs[self._maxDailyBossClgTimes]
	end

	self._txtBossRule.text = curBossCfg and curBossCfg.ruleDesc and curBossCfg.ruleDesc or ""

	self:_updateBossPrizes()

	self._txtMaxDam.text = string.format("历史最高伤害：<color=#ffee8d>%s</color>", EmperorSubdueController.instance:numberToString(self._maxDailyDamage))
	self._txtTodayMaxDam.text = string.format("今日累计伤害：<color=#ffee8d>%s</color>", EmperorSubdueController.instance:numberToString(self._todayTotalDamage))
	self._curSelectId = self:_getLastSelectId()

	if self._curSelectId <= 0 then
		self._curSelectId = 1
	end

	self:_switchSelectStage(self._curSelectId)
end

function EmperorSubdueMainView:_getLastSelectId()
	local saveKey = string.format("EmperorSubdueMainView_LastSelectId_%d", self._activityId)

	return checknumber(GameUtil.getUserData(saveKey))
end

function EmperorSubdueMainView:_setLastSelectId()
	local saveKey = string.format("EmperorSubdueMainView_LastSelectId_%d", self._activityId)

	GameUtil.saveUserData(saveKey, tostring(self._curSelectId))
end

function EmperorSubdueMainView:getStageDesc(stageId)
	local stageCfg = self._stageCfgs[stageId]

	if not stageCfg then
		return ""
	end

	if not stageCfg.baseRule then
		if not stageCfg.passBuffDesc then
			local passBuffDesc = ""
			local debuffDesc = "请查看克制规则后选择挑战顺序"

			if not self._stageWithBuffMap[stageId] then
				if #self._stageWithBuffMap[stageId] > 0 then
					debuffDesc = "当前关卡：" .. self._stageCfgs[self._stageWithBuffMap[stageId][1]].passDebuffDesc

					for i = 2, #self._stageWithBuffMap[stageId] do
						debuffDesc = debuffDesc .. ";" .. self._stageCfgs[self._stageWithBuffMap[stageId][i]].passDebuffDesc
					end
				end

				return stageCfg.baseRule .. "\n" .. passBuffDesc .. "\n" .. debuffDesc
			end
		end
	end
end

function EmperorSubdueMainView:_handleResetClg()
	self._hasPassStageIdMap = {}
	self._stageWithBuffMap = {}

	for _, stageCfg in pairs(self._stageCfgs) do
		self._stageWithBuffMap[stageCfg.stageId] = {}
	end

	for stageId, _ in pairs(self._hasPassStageIdMap) do
		local stageCfg = self._stageCfgs[stageId]

		if stageCfg then
			if not stageCfg.counterStage then
				for _, affectedStageId in ipairs(stageCfg.counterStage) do
					local affectedStageBuffs = self._stageWithBuffMap[affectedStageId]

					if affectedStageBuffs then
						table.insert(affectedStageBuffs, stageId)
					end
				end
			end
		end
	end

	self:_switchSelectStage(self._curSelectId)
end

function EmperorSubdueMainView:_onClickTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function EmperorSubdueMainView:_onClickClgFightBoss()
	local isPassAllStage = true

	for _, stageCfg in pairs(self._stageCfgs) do
		if not self._hasPassStageIdMap[stageCfg.stageId] then
			isPassAllStage = false

			break
		end
	end

	if not isPassAllStage then
		FloatWordMgr.instance:show("请先通关所有其他关卡,获取BUFF后再来挑战Boss！")

		return
	end

	if self._todayChallengeTimes >= self._maxDailyBossClgTimes then
		FloatWordMgr.instance:show("今日挑战次数已用完，明日再来吧！")

		return
	end

	EmperorSubdueController.instance:showBossMissionView(self._activityId, false, self._todayChallengeTimes + 1)
end

function EmperorSubdueMainView:_onClickTrial()
	local isPassAllStage = true

	for _, stageCfg in pairs(self._stageCfgs) do
		if not self._hasPassStageIdMap[stageCfg.stageId] then
			isPassAllStage = false

			break
		end
	end

	if not isPassAllStage then
		FloatWordMgr.instance:show("请先通关所有其他关卡,获取BUFF后再来进行试炼！")

		return
	end

	if self._todayChallengeTimes >= self._maxDailyBossClgTimes then
		EmperorSubdueController.instance:showBossMissionView(self._activityId, true, self._maxDailyBossClgTimes)
	else
		EmperorSubdueController.instance:showBossMissionView(self._activityId, true, self._todayChallengeTimes + 1)
	end
end

function EmperorSubdueMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.EmperorSubdueRankView, self._activityId)
end

function EmperorSubdueMainView:_onClickPicRule()
	local key = self._actCfg.picRuleKey

	TipsFacade.instance:openImageRuleViewByKey(key, "克制规则")
end

function EmperorSubdueMainView:_onClickFightStage()
	local isPass = self._hasPassStageIdMap[self._curSelectId]

	if isPass then
		FloatWordMgr.instance:show("该关卡已通关，无需再次挑战")

		return
	end

	EmperorSubdueController.instance:showMissionView(self._activityId, self._curSelectStageId)
	print("EmperorSubdueMainView:_onClickFightStage done", self._curSelectStageId)
end

function EmperorSubdueMainView:_onClickReset()
	local isNeedReset = false

	for _, stageCfg in pairs(self._stageCfgs) do
		if self._hasPassStageIdMap[stageCfg.stageId] then
			isNeedReset = true

			break
		end
	end

	if not isNeedReset then
		FloatWordMgr.instance:show("当前无需重置关卡")

		return
	end

	local text = "是否确认重置除了最终关卡外所有关卡？已通关的关卡将会被重置，且已领取的奖励不受影响。"

	local function okFunc()
		EmperorSubdueController.instance:resetStage(self._activityId)
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
end

function EmperorSubdueMainView:_updateBossPrizes()
	local showIndex = -1
	local lastIndex = -1
	local scoreList = {}

	for i, v in ipairs(self._bossPrizeCfgs) do
		if checknumber(v.totalDamage) <= self._totalDamage then
			if not self._hasGainProgressPrizeIdMap[i] then
				if showIndex <= 0 then
					showIndex = i
				end
			else
				lastIndex = i
			end
		end

		table.insert(scoreList, checknumber(v.totalDamage))
	end

	if lastIndex <= 0 then
		lastIndex = 1
	end

	if showIndex <= 0 then
		showIndex = lastIndex
	end

	self._tableviewProgress:updateUnderSlider(self._progressBar, self._totalDamage, scoreList)
	self._tableviewProgress:reloadData(self._bossPrizeCfgs)
	self._tableviewProgress:MoveCellToBegin(showIndex - 1)

	self._txtNumDamage.text = EmperorSubdueController.instance:numberToString(self._totalDamage)
end

function EmperorSubdueMainView:_updateProgressCell(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.setCellByCfg(data.prize, item)

	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")

	txtNum.text = EmperorSubdueController.instance:numberToString(checknumber(data.totalDamage))

	if not self._hasGainProgressPrizeIdMap[data.progressId] then
		local btnGet = goutil.findChild(cell.gameObject, "btnGet")

		goutil.setActive(btnGet, false)

		local geted = goutil.findChild(cell.gameObject, "geted")

		goutil.setActive(geted, self._hasGainProgressPrizeIdMap[data.progressId])
	end
end

function EmperorSubdueMainView:_clearProgressCell(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	if item then
		MaterialMgr.resetAll(item)
	end
end

function EmperorSubdueMainView:_switchSelectStage(stageId)
	self._curSelectId = stageId

	local isBossStage = stageId == #self._stageCfgs + 1

	if isBossStage then
		goutil.setActive(self._bossCom, true)
		goutil.setActive(self._stageCom, false)
	else
		self._curSelectStageId = stageId

		goutil.setActive(self._bossCom, false)
		goutil.setActive(self._stageCom, true)

		self._txtStageRule.text = self:getStageDesc(stageId)
		self._txtTitle.text = self._stageCfgs[stageId].title or ""

		local stagecfg = self._stageCfgs[stageId]

		if stagecfg then
			if not stagecfg.prize then
				local prize = ""
				local prizeArr = string.split(prize, "#")

				self._tableviewStagePrize:reloadData(prizeArr)
			end
		end
	end

	for i, cell in ipairs(self._switchCells) do
		local id = i - stageId + 1

		if id < 1 then
			id = #displayParams + id
		end

		local param = displayParams[id]

		if cell then
			GameUtil.setAnchoredPos(cell.go, param.posX, param.posY)
			GameUtil.setLocalScale(cell.info, param.scale, param.scale, param.scale)
			GameUtil.setLocalScale(cell.title, param.titleScale, param.titleScale, param.titleScale)
			GameUtil.setAnchoredPos(cell.title, 0, param.titlePosY)
			goutil.setActive(cell.pass, self._hasPassStageIdMap[i] or false)
		end
	end
end

function EmperorSubdueMainView:_updateStageCell(view, cell, data)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")

	MaterialMgr.setCellByCfg(data, item)

	local geted = goutil.findChild(go, "geted")

	if not self._hasGainStagePrizeIdMap[self._curSelectStageId] then
		goutil.setActive(geted, self._hasGainStagePrizeIdMap[self._curSelectStageId])
	end
end

function EmperorSubdueMainView:_clearStageCell(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")

	if item then
		MaterialMgr.resetAll(item)
	end
end

function EmperorSubdueMainView:_onClickLeft()
	local newSelectId = self._curSelectId + 1

	if newSelectId > #self._stageCfgs + 1 then
		newSelectId = 1
	end

	self:_switchSelectStage(newSelectId)
end

function EmperorSubdueMainView:_onClickRight()
	local newSelectId = self._curSelectId - 1

	if newSelectId < 1 then
		newSelectId = #self._stageCfgs + 1
	end

	self:_switchSelectStage(newSelectId)
end

return EmperorSubdueMainView
