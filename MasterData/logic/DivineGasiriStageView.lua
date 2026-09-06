-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegasiri/view/DivineGasiriStageView.lua

module("logic.extensions.divinegasiri.view.DivineGasiriStageView", package.seeall)

local DivineGasiriStageView = class("DivineGasiriStageView", ViewComponent)

function DivineGasiriStageView:ctor()
	DivineGasiriStageView.super.ctor(self)
end

function DivineGasiriStageView:unbindEvents()
	DivineGasiriStageView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()

	for _, cell in ipairs(self._formationCellList) do
		GameUtil.asBtn(cell.con):RemoveClickListener()
	end
end

function DivineGasiriStageView:bindEvents()
	DivineGasiriStageView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnReward:AddClickListener(self._onClickReward, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
end

function DivineGasiriStageView:buildUI()
	DivineGasiriStageView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnReward = self:getBtn("info/btnReward")
	self._iconReward = self:getGo("info/icon")
	self._levelSlider = self:getSlider("info/level")
	self._upLevelTxt = self:getTxt("info/txtUp")
	self._downLevelTxt = self:getTxt("info/txtDown")
	self._curLevelTxt = self:getTxt("info/level/Fill Area/info/txtLevel")
	self._headObj = self:getGo("info/level/Fill Area/info/head")
	self._stageCol = self:getGo("stageCol")
	self._formationCellList = {}

	for i = 1, 9 do
		local cell = {}

		cell.go = goutil.findChild(self._stageCol, "formation/cell_" .. i)
		cell.con = goutil.findChild(cell.go, "con")
		self._formationCellList[i] = cell
	end

	self._btnChallenge = self:getBtn("stageCol/btnChallenge")
	self._pass = self:getGo("stageCol/pass")
	self._timeTips = self:getGo("timeTips")
	self._txtTimeTips = self:getTxt("timeTips/txt")
	self._txtTarget = self:getTxt("target/txt")
	self._txtDesc = self:getTxt("desc/txt")
end

function DivineGasiriStageView:onExit()
	DivineGasiriStageView.super.onExit(self)

	for _, cell in ipairs(self._formationCellList) do
		MaterialMgr.resetAll(cell.con)
		goutil.setActive(cell.go, false)
	end

	HeadItemController.instance:resetHeadCell(self._headObj)
	MaterialMgr.resetAll(self._iconReward)
end

function DivineGasiriStageView:onEnter()
	DivineGasiriStageView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	DivineGasiriModel.instance:setCurActMo(self._activityId)

	local curPassStageId = DivineGasiriModel.instance:getCurPassStageId(self._activityId)

	self._stageCfgs = DivineGasiriConfig.instance:getStageCfgs(self._activityId)
	self._isAllPass = curPassStageId >= table.nums(self._stageCfgs)
	self._curShowStageId = self._isAllPass and curPassStageId or curPassStageId + 1
	self._curShowStageCfg = self._stageCfgs[self._curShowStageId]
	self._actCfg = DivineGasiriConfig.instance:getActCfg(self._activityId)

	MaterialMgr.setCellByCfg(self._actCfg.showPrize, self._iconReward)
	self:_updateCurStage()
	self:_updateSlider()
end

function DivineGasiriStageView:_onClickReward()
	UIStateManager.instance:push(ViewName.DivineGasiriRewardView, self._activityId)
end

function DivineGasiriStageView:_onClickChallenge()
	if self._isAllPass then
		FloatWordMgr.instance:show("已通关")

		return
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.DivineGasiri, self._activityId)
	local openTime = startTime + (self._curShowStageCfg.unlockDays - 1) * 60 * 60 * 24

	if openTime >= ServerTime.now() then
		goutil.setActive(self._timeTips, true)

		local date = GameUtil.time2date(openTime)
		local showTip = string.format("%d.%d.%d 开启", date.year, date.month, date.day)

		FloatWordMgr.instance:show(showTip)

		return
	end

	local fmtMo = DivineGasiriModel.instance:getFmtMo(self._activityId)

	fmtMo:initParams(self._activityId, self._curShowStageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineGasiriStageView:_updateCurStage()
	local creepCfgs = DivineGasiriConfig.instance:getCreepCfgs(self._curShowStageCfg.creepsMasterId)

	for _, cell in ipairs(self._formationCellList) do
		MaterialMgr.clearIcon(cell.con)
		goutil.setActive(cell.go, false)
	end

	for _, cfg in ipairs(creepCfgs) do
		local raceId, posId = cfg.raceId, cfg.posId
		local cell = self._formationCellList[posId]

		if cell then
			goutil.setActive(cell.go, true)
			MaterialMgr.setIcon(cell.con, MatType.PET_SKIN, (checknumber(cfg.faceId) > 0 or nil) and checknumber(cfg.faceId))
			GameUtil.asBtn(cell.con):RemoveClickListener()
			GameUtil.asBtn(cell.con):AddClickListener(function()
				local petMo = FightingPowerPetMo.New()

				petMo:fromChallengeCreepCo(cfg, creepCfgs)

				petMo.creepName = cfg.creepName

				CommonTipsMgr.instance:showPetTips(petMo)
			end)
		end
	end

	goutil.setActive(self._pass, self._isAllPass)

	if not self._curShowStageCfg.winScoreRequirements then
		local targetList = {}
		local showDescList = {}

		for i = 1, 3 do
			local type = i
			local target = targetList[i]
			local cfg = DivineGasiriConfig.instance:getScoreCfg(self._activityId, type)

			showDescList[i] = {
				target = target,
				desc = cfg.desc
			}
		end

		self._txtTarget.text = string.format("%s≥%s、%s≥%s、%s≥%s", showDescList[1].desc, showDescList[1].target, showDescList[2].desc, showDescList[2].target, showDescList[3].desc, showDescList[3].target)
		self._txtDesc.text = ""

		local ruleCfg = RulesConfig.instance:getRuleCo(self._curShowStageCfg.stageRuleKey)

		if ruleCfg then
			self._txtDesc.text = ruleCfg.rules or "说明规则缺失配置" .. self._curShowStageCfg.stageRuleKey
		end

		local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.DivineGasiri, self._activityId)
		local openTime = startTime + (self._curShowStageCfg.unlockDays - 1) * 60 * 60 * 24

		if openTime < ServerTime.now() then
			goutil.setActive(self._timeTips, false)
		else
			goutil.setActive(self._timeTips, true)

			local date = GameUtil.time2date(openTime)

			self._txtTimeTips.text = string.format("%d.%d.%d 开启", date.year, date.month, date.day)
		end
	end
end

function DivineGasiriStageView:_updateSlider()
	self._upLevelTxt.text = string.format("%d层", #self._stageCfgs)
	self._downLevelTxt.text = "1层"

	HeadItemController.instance:setMyHeadCell(self._headObj)

	local sValue = (self._curShowStageId - 1) / (#self._stageCfgs - 1)

	self._levelSlider:SetValue(sValue)

	self._curLevelTxt.text = string.format("当前%d层", self._curShowStageId)
end

return DivineGasiriStageView
