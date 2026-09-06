-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/louna/LounalevelsView.lua

module("logic.extensions.timelimitedchallenge.view.louna.LounalevelsView", package.seeall)

local LounalevelsView = class("LounalevelsView", ViewComponent)

function LounalevelsView:ctor()
	LounalevelsView.super.ctor(self)
end

function LounalevelsView:unbindEvents()
	LounalevelsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnReset)
	GameUtil.rmClickHandler(self.btnTip)
end

function LounalevelsView:bindEvents()
	LounalevelsView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnReset, self.onResetClick, self)
	GameUtil.addClickHandler(self.btnTip, self.onTipClick, self)
end

function LounalevelsView:buildUI()
	LounalevelsView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnReset = self:getGo("btnReset")
	self.btnTip = self:getGo("txtTitle/btnTip")
	self.txtTime = self:getTxt("time/txtTime")
	self._txtTimeGo = self:getGo("time")
	self.hasfinish = self:getGo("hasfinish")
	self.cell = self:getGo("cell")
	self.tableview = self:getGo("tableview")
	self.txtTitle = self:getTxt("txtTitle")
	self.desc = self:getTxt("desc/txt")
	self.rule = self:getTxt("rule/txtDesc")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))

	goutil.setActive(self._txtTimeGo, false)
end

function LounalevelsView:onExit()
	LounalevelsView.super.onExit(self)
	self.scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.ON_LOUNA_INFO_UPDATE, self.onRefreshUI, self)
end

function LounalevelsView:onEnter()
	LounalevelsView.super.onEnter(self)

	self.activityId = LounaController.instance:getActivityId()

	GlobalDispatcher:addListener(GlobalNotify.ON_LOUNA_INFO_UPDATE, self.onRefreshUI, self)
	LounaController.instance:sendGetInfo(self.activityId)

	local activityType = math.floor(checknumber(self.activityId) / 1000)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, self.activityId)
	local startDate, endDate = GameUtil.time2date(startTime), GameUtil.time2date(endTime)

	self.txtTime.text = langPara("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function LounalevelsView:onRefreshUI()
	local curTier = LounaModel.instance.curTier
	local cfg = LounaConfig.instance:getChallengeCfgById(self.activityId) or {}
	local tierPlanId = cfg.tierPlanId
	local tierCfg = LounaConfig.instance:getTierCfgById(tierPlanId, curTier) or {}
	local rulePlanId = tierCfg.rulePlanId
	local rulecfg = LounaConfig.instance:getRuleCfg(rulePlanId) or {}
	local creepsMasterPlanId = tierCfg.creepsMasterPlanId
	local masterList = LounaConfig.instance:getMasterCfg(creepsMasterPlanId)
	local list = self.scrollList:tryTransList(masterList)

	self.scrollList:reloadData(list)

	self.txtTitle.text = tierCfg.title

	local idx = 0
	local hasEnd = true

	if not LounaModel.instance.passedCreepsMasterIds then
		for i, v in ipairs(list) do
			if table.indexof(LounaModel.instance.passedCreepsMasterIds, v.creepsMasterId) == false then
				hasEnd = false
				idx = i - 1

				break
			end
		end

		self.scrollList:MoveCellToCenter(idx)
		GameUtil.SetActive(self.hasfinish, hasEnd)

		self.desc.text = rulecfg.ruleDesc
		self.rule.text = rulecfg.ruleUnderDesc

		if not rulecfg.ruleParams then
			local param = {}

			GameUtil.SetActive(self.btnReset, param.reset == true)
		end
	end
end

function LounalevelsView:_updateCell(view, cell, data, tag)
	local pass = goutil.findChild(cell, "pass")
	local btnChallenge = goutil.findChild(cell, "btnChallenge")
	local txtTip = goutil.findChildTextComponent(cell, "btnChallenge/txtTip/txt")

	txtTip.text = data.ruleDesc

	local creeps = LounaConfig.instance:getCreepsCfg(data.creepsMasterId)
	local map = {}

	for i, v in ipairs(creeps) do
		local posId = checknumber(v.posId)

		map[posId] = v
	end

	for i = 1, 9 do
		local cellgo = goutil.findChild(cell, "btnChallenge/cell_" .. i)
		local con = goutil.findChild(cell, "btnChallenge/cell_" .. i .. "/con")

		MaterialMgr.clearIcon(con)

		local cfg = map[i]

		if cfg then
			GameUtil.SetActive(cellgo, true)

			local skinId = checknumber(cfg.raceId)

			MaterialMgr.setIcon(con, MatType.Pet, (checknumber(cfg.faceId) > 0 or nil) and checknumber(cfg.faceId))
		else
			GameUtil.SetActive(cellgo, false)
		end
	end

	if not LounaModel.instance.passedCreepsMasterIds then
		local passedCreepsMasterIds = {}

		GameUtil.SetActive(pass, table.indexof(passedCreepsMasterIds, data.creepsMasterId) ~= false)
		GameUtil.addClickHandler(btnChallenge, GameUtil.handler(self.onFmtClick, self, data))
	end
end

function LounalevelsView:clearCell(cell)
	for i = 1, 9 do
		local con = goutil.findChild(cell, "btnChallenge/cell_" .. i .. "/con")

		MaterialMgr.clearIcon(con)
	end
end

function LounalevelsView:onFmtClick(data)
	if not LounaModel.instance.passedCreepsMasterIds then
		if table.indexof(LounaModel.instance.passedCreepsMasterIds, data.creepsMasterId) ~= false then
			TipsFacade.instance:openCommonTips(lang("已经通关"))
		else
			LounaController.instance:openMissionView(self.activityId, data)
		end
	end
end

function LounalevelsView:onResetClick()
	LounaController.instance:showResetView(self.activityId)
end

function LounalevelsView:onTipClick()
	local curTier = LounaModel.instance.curTier
	local cfg = LounaConfig.instance:getChallengeCfgById(self.activityId) or {}
	local tierPlanId = cfg.tierPlanId
	local tierCfg = LounaConfig.instance:getTierCfgById(tierPlanId, curTier) or {}
	local rulePlanId = tierCfg.rulePlanId
	local rulecfg = LounaConfig.instance:getRuleCfg(rulePlanId) or {}

	UIStateManager.instance:push(ViewName.RulesView, rulecfg.ruleId)
end

return LounalevelsView
