-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/EndlessdlevelsView.lua

module("logic.extensions.infinitefuture.view.EndlessdlevelsView", package.seeall)

local EndlessdlevelsView = class("EndlessdlevelsView", ViewComponent)
local LastActId

function EndlessdlevelsView:ctor()
	EndlessdlevelsView.super.ctor(self)
end

function EndlessdlevelsView:unbindEvents()
	EndlessdlevelsView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._rewardBtn:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function EndlessdlevelsView:bindEvents()
	EndlessdlevelsView.super.bindEvents(self)
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

function EndlessdlevelsView:buildUI()
	EndlessdlevelsView.super.buildUI(self)

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

	UGUIToolHelper.AddChild(self._levelObj, self._cell)
	UGUIToolHelper.AddChild(self._levelObj, self._cell)
end

function EndlessdlevelsView:onExit()
	EndlessdlevelsView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)

	for _, v in pairs(self._cellList) do
		for _, w in ipairs(v) do
			MaterialMgr.clearIcon(w)
		end
	end
end

function EndlessdlevelsView:onEnter()
	EndlessdlevelsView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)

	self._cellList = {}

	local curActId = self:getFirstParam()

	self.curActId = curActId and curActId or LastActId
	LastActId = self.curActId
	self.totalCount = InfinitefutureConfig.instance:getStageCount(self.curActId)
	self.actcfg = InfinitefutureConfig.instance:getPlanCfg(self.curActId)

	InfinitefutureController.instance:sendInfoReq(self.curActId)

	self._titleTxt.text = self.actcfg.checkpointsName
	self._upLevelTxt.text = string.format("%d层", self.totalCount)
	self._downLevelTxt.text = "1层"

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.EndlessChallenge, self.curActId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	self._openDate.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function EndlessdlevelsView:onRefreshUI()
	self.stageId = InfinitefutureModel.instance.curStageId

	if self.stageId > self.totalCount then
		FloatWordMgr.instance:show("已通过所有关卡")
		GameUtil.saveUserData("endlessover" .. tostring(self.curActId), "1")
		self:close()

		return
	end

	self.stageTeams = InfinitefutureConfig.instance:getTeamCfgs(self.curActId, self.stageId)
	self.curCount = #self.stageTeams

	local sValue = (self.stageId - 1) / (self.totalCount - 1)

	self._levelSlider:SetValue(sValue)

	self._curLevelTxt.text = string.format("当前%d层", self.stageId)

	local scale = self.curCount == 3 and 0.8 or 1

	GameUtil.setLocalScale(self._levelObj, scale, scale, 1)

	for i = 1, 3 do
		local show = i <= self.curCount
		local tObj = self._levelObj.transform:GetChild(i - 1).gameObject

		tObj:SetActive(show)

		if show then
			self:_setTeamInfo(tObj, i)
		end
	end
end

function EndlessdlevelsView:_setTeamInfo(cell, teamId)
	local cfgTeam = self.stageTeams[teamId]
	local creepId = cfgTeam.creepsMasterId
	local isPass = InfinitefutureModel.instance:isChallengeTeam(teamId)
	local pkBtn = goutil.findChild(cell, "btnChallenge")
	local resetBtn = goutil.findChild(cell, "btnReset")
	local pass = goutil.findChild(cell, "pass")
	local formation = goutil.findChild(cell, "formation")

	goutil.findChildTextComponent(formation, "txtTip").text = cfgTeam.levelDescription

	pkBtn:SetActive(not isPass)
	resetBtn:SetActive(isPass)
	pass:SetActive(isPass)
	GameUtil.asBtn(pkBtn):AddClickListener(function()
		UIStateManager.instance:push(ViewName.InfinfuMissionView, self.curActId, self.stageId, teamId, creepId)
	end, self)
	GameUtil.asBtn(resetBtn):AddClickListener(function()
		UIStateManager.instance:push(ViewName.InfinitefutureresetView, self.curActId, self.stageId, teamId)
	end, self)

	self._cellList[teamId] = {}

	for i = 1, 9 do
		local obj = goutil.findChild(formation, string.format("cell_%d/con", i))

		MaterialMgr.clearIcon(obj)
		obj.transform.parent.gameObject:SetActive(false)

		self._cellList[teamId][i] = obj
	end

	local creepCfgs = InfinitefutureConfig.instance:getCreepCfgs(creepId)

	for i, v in ipairs(creepCfgs) do
		local raceId, posId = v.raceId, v.posId
		local obj = self._cellList[teamId][posId]

		obj.transform.parent.gameObject:SetActive(true)
		MaterialMgr.setIcon(obj, MatType.PET_SKIN, (checknumber(v.faceId) > 0 or nil) and checknumber(v.faceId))
		GameUtil.asBtn(obj):AddClickListener(function()
			local petMo = FightingPowerPetMo.New()

			petMo:fromChallengeCreepCo(v, creepCfgs)

			petMo.creepName = v.creepName

			CommonTipsMgr.instance:showPetTips(petMo)
		end)
	end
end

return EndlessdlevelsView
