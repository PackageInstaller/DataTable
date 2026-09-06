-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InflamedlevelsView.lua

module("logic.extensions.infinitefuture.view.InflamedlevelsView", package.seeall)

local InflamedlevelsView = class("InflamedlevelsView", ViewComponent)
local LastActId

function InflamedlevelsView:ctor()
	InflamedlevelsView.super.ctor(self)
end

function InflamedlevelsView:unbindEvents()
	InflamedlevelsView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._rewardBtn:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function InflamedlevelsView:bindEvents()
	InflamedlevelsView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		self:close()
	end, self)
	self._rewardBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.InfinitefuturepopView, 2, self.curActId)
	end, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, self.actcfg.ruleId)
	end, self)
end

function InflamedlevelsView:buildUI()
	InflamedlevelsView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._rewardBtn = self:getBtn("info/btnReward")
	self._btnTip = self:getBtn("btnTip")
	self._titleTxt = self:getTxt("txtTitle")
	self._cell = self:getGo("levels/cell")
	self._levelObj = self:getGo("levels")
	self._levelSlider = self:getSlider("info/level")
	self._openDate = self:getTxt("time/txt")
	self._upLevelTxt = self:getTxt("info/txtUp")
	self._downLevelTxt = self:getTxt("info/txtDown")
	self._curLevelTxt = self:getTxt("info/level/Fill Area/info/txtLevel")
	self._headObj = self:getGo("info/level/Fill Area/info/head")
	self._pkButton = self:getBtn("btnChallenge")
	self._btnChallenge = self:getGo("btnChallenge")
	self._resetButton = self:getBtn("btnReset")
	self._fightPower = goutil.findChildComponent(self.mainGO, "zdl/imgRecZdl", "UIImgNumeralText")
	self._zdlImg = self:getGo("zdl")
	self._score = self:getTxt("score/txt")
	self._ruleTxt = self:getTxt("desc/txt")

	UGUIToolHelper.AddChild(self._levelObj, self._cell)
	UGUIToolHelper.AddChild(self._levelObj, self._cell)
end

function InflamedlevelsView:onExit()
	InflamedlevelsView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)

	for _, v in pairs(self._cellList) do
		for _, w in ipairs(v) do
			MaterialMgr.clearIcon(w)
		end
	end
end

function InflamedlevelsView:onEnter()
	InflamedlevelsView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)

	self._cellList = {}

	local curActId = self:getFirstParam()

	self.curActId = curActId and curActId or LastActId
	LastActId = self.curActId
	InfinitefutureModel.instance.curActId = self.curActId
	self.totalCount = InfinitefutureConfig.instance:getStageCount(self.curActId)
	self.actcfg = InfinitefutureConfig.instance:getPlanCfg(self.curActId)

	InfinitefutureController.instance:sendInfoReq(self.curActId)

	self._titleTxt.text = self.actcfg.checkpointsName
	self._upLevelTxt.text = string.format("%d层", self.totalCount)
	self._downLevelTxt.text = "1层"

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.EndlessChallenge, self.curActId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	self._openDate.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
	self._conditionTxt = InfinitefutureModel.instance:getConditionTxt(self.curActId)
end

function InflamedlevelsView:onRefreshUI()
	self.stageId = InfinitefutureModel.instance.curStageId

	if self.stageId > self.totalCount then
		FloatWordMgr.instance:show("已通过所有关卡")
		GameUtil.saveUserData("viretaover" .. tostring(self.curActId), "1")
		self:close()

		return
	end

	self.stageTeams = InfinitefutureConfig.instance:getTeamCfgs(self.curActId, self.stageId)
	self.curCount = #self.stageTeams

	local sValue = (self.stageId - 1) / (self.totalCount - 1)

	self._levelSlider:SetValue(sValue)

	self._curLevelTxt.text = string.format("当前%d层", self.stageId)
	self._score.text = string.format("通关要求达成:%s%s", InfinitefutureModel.instance:getAllScore(), InfinitefutureConfig.instance:getStagePassCount(self.curActId, self.stageId))
	self._ruleTxt.text = InfinitefutureConfig.instance:getPlanCfg(self.curActId).ruleDescription

	local scale = self.curCount == 3 and 1 or 1

	GameUtil.setLocalScale(self._levelObj, scale, scale, 1)

	local isSpecial = self.curActId == InfinitefutureModel.instance.viretaActIds[3]

	for i = 1, 3 do
		local show = i <= self.curCount
		local tObj = self._levelObj.transform:GetChild(i - 1).gameObject

		tObj:SetActive(show)

		if show then
			self:_setTeamInfo(tObj, i)
		end

		local arrow = goutil.findChild(tObj, "arrow")

		goutil.setActive(arrow, isSpecial and i > 1)
	end

	goutil.setActive(self._pkButton.gameObject, isSpecial)
	goutil.setActive(self._zdlImg, isSpecial)
	self._pkButton:RemoveClickListener()
	self._pkButton:AddClickListener(function()
		if not self:isStartBattle() then
			TipsFacade.instance:openTipWindow(lang("tip"), "未在开放时间", function()
				return
			end, "确定")

			return
		end

		InfinitefutureModel.instance.curTeamID = 1

		UIStateManager.instance:push(ViewName.InfinfuMissionView, self.curActId, self.stageId, 1, self.stageTeams[1].creepsMasterId, 1)
	end, self)
	self._fightPower:SetNum(self.stageTeams[1].fightingCapacity)
end

function InflamedlevelsView:_setTeamInfo(cell, teamId)
	local cfgTeam = self.stageTeams[teamId]
	local creepId = cfgTeam.creepsMasterId
	local isPass = InfinitefutureModel.instance:isHaveScore(teamId)
	local isSpecial = self.curActId ~= InfinitefutureModel.instance.viretaActIds[3]
	local pkBtn = goutil.findChild(cell, "btnChallenge")
	local resetBtn = goutil.findChild(cell, "btnReset")
	local pass = goutil.findChild(cell, "pass")
	local formation = goutil.findChild(cell, "formation")
	local pkText = goutil.findChildTextComponent(cell, "btnChallenge/Text")
	local fightingCapacity = goutil.findChildComponent(cell, "zdl/imgRecZdl", "UIImgNumeralText")
	local zdlImg = goutil.findChild(cell, "zdl")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")

	goutil.findChildTextComponent(formation, "txtTip").text = cfgTeam.levelDescription

	if isSpecial then
		fightingCapacity:SetNum(self.stageTeams[teamId].fightingCapacity)
	end

	txtNum.text = self._conditionTxt .. InfinitefutureModel.instance:getScoreForList(teamId)

	pkBtn:SetActive(isSpecial)
	zdlImg:SetActive(isSpecial)
	pass:SetActive(isPass)

	pkText.text = isPass and "重新挑战" or "进入挑战"

	GameUtil.asBtn(pkBtn):RemoveClickListener()
	GameUtil.asBtn(pkBtn):AddClickListener(function()
		if not self:isStartBattle() then
			TipsFacade.instance:openTipWindow(lang("tip"), "未在开放时间", function()
				return
			end, "确定")

			return
		end

		InfinitefutureModel.instance.curTeamID = teamId

		UIStateManager.instance:push(ViewName.InfinfuMissionView, self.curActId, self.stageId, teamId, creepId)
	end, self)

	self._cellList[teamId] = {}

	for i = 1, 9 do
		local obj = goutil.findChild(formation, string.format("cell_%d/con", i))

		MaterialMgr.resetAll(obj)
		obj.transform.parent.gameObject:SetActive(false)

		self._cellList[teamId][i] = obj
	end

	local creepCfgs = InfinitefutureConfig.instance:getCreepCfgs(creepId)

	for i, v in ipairs(creepCfgs) do
		local raceId, posId = v.raceId, v.posId
		local obj = self._cellList[teamId][posId]

		obj.transform.parent.gameObject:SetActive(true)
		MaterialMgr.setIcon(obj, MatType.PET_SKIN, (checknumber(v.faceId) > 0 or nil) and checknumber(v.faceId))
		GameUtil.asBtn(obj):RemoveClickListener()
		GameUtil.asBtn(obj):AddClickListener(function()
			local petMo = FightingPowerPetMo.New()

			petMo:fromChallengeCreepCo(v, creepCfgs)

			petMo.creepName = v.creepName

			CommonTipsMgr.instance:showPetTips(petMo)
		end)
	end
end

function InflamedlevelsView:isStartBattle()
	local actType = math.floor(self.curActId / 1000)

	return (ActivityDefineController.instance:isInActivityTimeById(actType, self.curActId))
end

return InflamedlevelsView
