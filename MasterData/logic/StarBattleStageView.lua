-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleStageView.lua

module("logic.extensions.starbattle.view.StarBattleStageView", package.seeall)

local StarBattleStageView = class("StarBattleStageView", ViewComponent)

function StarBattleStageView:ctor()
	StarBattleStageView.super.ctor(self)
end

function StarBattleStageView:unbindEvents()
	StarBattleStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSignIn)
end

function StarBattleStageView:bindEvents()
	StarBattleStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSignIn, self._onClickSignIn, self)
end

function StarBattleStageView:buildUI()
	StarBattleStageView.super.buildUI(self)

	self._roleCon = self:getGo("roleCon")
	self._btnSignIn = self:getGo("btnSignIn")
	self._rpSignIn = self:getGo("btnSignIn/rp")
	self._txtSignIn = self:getTxt("btnSignIn/txt")
	self._verRaceCellList = {}

	for i = 1, 2 do
		local cell = {}

		cell.go = self:getGo("verRaces/items/item_" .. i)
		cell.icon = goutil.findChild(cell.go, "icon")
		cell.txtTag = goutil.findChildTextComponent(cell.go, "tag/txt")
		cell.proxy = nil

		table.insert(self._verRaceCellList, cell)
	end

	local tableviewGo = self:getGo("tableview")
	local cellGo = self:getGo("tableview/tablecell")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableview:setOnlyCircleOffsetPos(true)
	self._tableview:extendCircleWithOffset(-120, "con")

	self._txtRule = self:getTxt("rule/txt")
end

function StarBattleStageView:onExit()
	StarBattleStageView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	for _, cell in ipairs(self._verRaceCellList) do
		MaterialMgr.instance:resetAll(cell.icon)

		cell.proxy = nil
	end

	self._tableview:dispose()
end

function StarBattleStageView:onEnter()
	StarBattleStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_StarBattleGetInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_StarBattleSignIn, self._handleSignIn, self)
	self.addGEvent(self, GlobalNotify.PM_StarBattleNotifyStageChallenge, self._updateStageInfos, self)
	self.addGEvent(self, GlobalNotify.PM_StarBattleVerifyRace, self._handleVerifyRace, self)

	self._activityId = 510001
	self._periodId = 1

	local params = self:getOpenParam()

	if params then
		if params[1] then
			self._activityId = checknumber(params[1])
		end

		self._periodId = StarBattleController.instance:getCurrentPeriodId(self._activityId)
	end

	StarBattleController.instance:getInfo(self._activityId, self._periodId)
	self:_updateUIByCfg()
	self:_updateUIByInfo()

	self._isNeedCheckVerRaceIds = true

	StarBattleController.instance:recordLastTab(self._activityId, self._periodId, 2)
end

function StarBattleStageView:_updateUIByCfg()
	self._curActCfg = StarBattleConfig.instance:getActCfg(self._activityId)
	self._periodCfg = StarBattleConfig.instance:getPeriodCfg(self._activityId, self._periodId)
	self._stageCfgs = StarBattleConfig.instance:getStageCfgs(self._periodCfg.stagePlanId) or {}
	self._buffCfgs = StarBattleConfig.instance:getBuffCfgs(self._periodCfg.buffPlanId) or {}
	self._verRaceCfgs = StarBattleConfig.instance:getFormationRaceCfgs(self._periodCfg.formationRacePlanId) or {}

	local skinId = self._periodCfg.chapterLihui

	if skinId > 0 then
		local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("drawing", skinId)

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._roleCon, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])
	end

	for i, cell in ipairs(self._verRaceCellList) do
		local cfg = self._verRaceCfgs[i]

		if cfg then
			goutil.setActive(cell.go, true)

			cell.proxy = MaterialMgr.setCell(MatType.Pet, cfg.raceId, cell.icon)
			cell.txtTag.text = string.format("+%s%%", cfg.scorePercent)
		else
			goutil.setActive(cell.go, false)
			MaterialMgr.instance:resetAll(cell.icon)

			cell.txtTag.text = ""
			cell.proxy = nil
		end
	end

	self._txtRule.text = self._periodCfg.stageRuleDesc or ""
end

function StarBattleStageView:_updateUIByInfo()
	self:_updateBuffs()
	self:_updateStageInfos()
	self:_updateVerRaceIds()
end

function StarBattleStageView:_updateBuffs()
	self._signInDays = 0
	self._isTodaySignIn = false
	self._isLvMax = false

	local showTips = "点击激活\nbuff"
	local lv = 0
	local info = StarBattleModel.instance:getBaseInfo(self._activityId, self._periodId)

	if info then
		self._signInDays = info.signInDays or 0
		self._isTodaySignIn = info.isTodaySignIn or false

		local buffCfg = StarBattleConfig.instance:getBuffCfgByDays(self._periodCfg.buffPlanId, self._signInDays)

		if buffCfg then
			lv = buffCfg.buffId or 0
			showTips = buffCfg.buffDesc or "点击激活\nbuff"
		end
	end

	self._isLvMax = lv >= #self._buffCfgs
	self._txtSignIn.text = showTips

	goutil.setActive(self._rpSignIn, not self._isTodaySignIn and not self._isLvMax)
end

function StarBattleStageView:_handleSignIn()
	TipsFacade.instance:openCommonTips("签到成功")
	self:_updateBuffs()
end

function StarBattleStageView:_updateStageInfos()
	self._maxStageId = 0
	self._stageInfoMap = {}

	local info = StarBattleModel.instance:getBaseInfo(self._activityId, self._periodId)

	if info then
		self._maxStageId = info.maxPassStageId or 0

		if not info.stageInfos then
			local stageInfos = {}

			for _, stageInfo in ipairs(stageInfos) do
				self._stageInfoMap[stageInfo.stageId] = stageInfo
			end
		end
	end

	self._tableview:reloadData(self._stageCfgs)

	if self._maxStageId >= #self._stageCfgs then
		self._tableview:MoveCellToBegin(#self._stageCfgs - 1)
	else
		self._tableview:MoveCellToBegin(self._maxStageId)
	end
end

function StarBattleStageView:_updateVerRaceIds()
	self._verRaceIdMap = {}

	local info = StarBattleModel.instance:getBaseInfo(self._activityId, self._periodId)

	if info then
		if not info.verifiedRaceId then
			for _, raceId in ipairs(info.verifiedRaceId) do
				self._verRaceIdMap[raceId] = true
			end

			if self._isNeedCheckVerRaceIds then
				self:_checkVerRaceIds()
			end
		end
	end

	for i, cell in ipairs(self._verRaceCellList) do
		local cfg = self._verRaceCfgs[i]

		if cfg then
			if not self._verRaceIdMap[cfg.raceId] then
				if cell.proxy then
					if self._verRaceIdMap[cfg.raceId] then
						cell.proxy:setGray(false)
						cell.proxy.binder:setAutoTips(true)
						cell.proxy:setCallBack(nil)
					else
						local para = string.format("%s:%s", MatType.Pet, cfg.raceId)

						cell.proxy.binder:setAutoTips(false)
						cell.proxy:setCallBack(function()
							MaterialMgr.openGetSourceByStr(para)
						end)
						cell.proxy:setGray(true)
					end
				end
			end
		end
	end
end

function StarBattleStageView:_handleVerifyRace()
	self._isNeedCheckVerRaceIds = true

	self:_updateVerRaceIds()
	self:_updateStageInfos()
end

function StarBattleStageView:_checkVerRaceIds()
	self._isNeedCheckVerRaceIds = false

	if not self._verRaceCfgs or #self._verRaceCfgs <= 0 then
		return
	end

	for i, cfg in ipairs(self._verRaceCfgs) do
		if not self._verRaceIdMap[cfg.raceId] and BagPetsController.instance:getPetNumByRaceId(cfg.raceId) > 0 then
			StarBattleController.instance:verifyRace(self._activityId, cfg.raceId, self._periodId)

			return
		end
	end
end

function StarBattleStageView:_onClickSignIn()
	if self._isTodaySignIn then
		TipsFacade.instance:openCommonTips("今日已签到")

		return
	end

	if self._isLvMax then
		TipsFacade.instance:openCommonTips("buff已满级")

		return
	end

	StarBattleController.instance:signIn(self._activityId, self._periodId)
end

function StarBattleStageView:_updateCell(view, cell, data)
	local btn = goutil.findChild(cell.gameObject, "con/btn")

	if btn then
		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickStage, self, data.stageId))
	end

	local item = goutil.findChild(cell.gameObject, "con/prize/item")

	if item then
		MaterialMgr.setCellByCfg(data.prize, item)
	end

	local txtStage = goutil.findChildTextComponent(cell.gameObject, "con/txtStage")

	if txtStage then
		txtStage.text = string.format("关卡%s", data.stageId)
	end

	local info = self._stageInfoMap[data.stageId]
	local txtScore = goutil.findChildTextComponent(cell.gameObject, "con/score/txt")

	if txtScore then
		txtScore.text = string.format("最高分：%s", (info or nil) and (info.maxScore or 0))
	end

	local pass = goutil.findChild(cell.gameObject, "con/prize/pass")

	if pass then
		goutil.setActive(pass, data.stageId <= self._maxStageId)
	end
end

function StarBattleStageView:_clearCell(cell)
	local btn = goutil.findChild(cell.gameObject, "con/btn")

	if btn then
		GameUtil.rmClickHandler(btn)
	end

	local item = goutil.findChild(cell.gameObject, "con/prize/item")

	if item then
		MaterialMgr.resetAll(item)
	end
end

function StarBattleStageView:_onClickStage(stageId)
	if stageId > self._maxStageId + 1 then
		TipsFacade.instance:openCommonTips("请先通关前一关卡")

		return
	end

	StarBattleController.instance:showStageMissionView(self._activityId, self._periodId, stageId)
end

return StarBattleStageView
