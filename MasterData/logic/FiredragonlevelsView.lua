-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/FiredragonlevelsView.lua

module("logic.extensions.infinitefuture.view.FiredragonlevelsView", package.seeall)

local FiredragonlevelsView = class("FiredragonlevelsView", ViewComponent)
local LastActId

function FiredragonlevelsView:ctor()
	FiredragonlevelsView.super.ctor(self)
end

function FiredragonlevelsView:unbindEvents()
	FiredragonlevelsView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._rewardBtn:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
end

function FiredragonlevelsView:bindEvents()
	FiredragonlevelsView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		self:close()
	end, self)
	self._rewardBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.InfinitefuturepopView, 2, self.curActId)
	end, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, self.actcfg.ruleId)
	end, self)
	self._btnBuff:AddClickListener(function()
		UIStateManager.instance:push(ViewName.InfinitefuturebuffView, self.curActId)
	end, self)
end

function FiredragonlevelsView:buildUI()
	FiredragonlevelsView.super.buildUI(self)

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
	self._btnBuff = self:getBtn("info/btnBuff")
	self._iconBuff = self:getGo("info/btnBuff/icon")
	self._redBuff = self:getGo("info/btnBuff/redpoint")

	UGUIToolHelper.AddChild(self._levelObj, self._cell)
	UGUIToolHelper.AddChild(self._levelObj, self._cell)
end

function FiredragonlevelsView:onExit()
	FiredragonlevelsView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)
	uGuiUtil.clearImage(self._iconBuff)

	for _, v in pairs(self._cellList) do
		for _, w in ipairs(v) do
			MaterialMgr.clearIcon(w)
		end
	end
end

function FiredragonlevelsView:onEnter()
	FiredragonlevelsView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)

	self._cellList = {}

	local curActId = checknumber(self:getFirstParam())

	self.curActId = curActId and curActId or LastActId
	LastActId = self.curActId
	self.totalCount = InfinitefutureConfig.instance:getStageCount(self.curActId)
	self.actcfg = InfinitefutureConfig.instance:getPlanCfg(self.curActId)

	InfinitefutureController.instance:sendInfoReq(self.curActId)
	self._levelObj:SetActive(false)

	self._titleTxt.text = self.actcfg.checkpointsName
	self._upLevelTxt.text = string.format("%d层", self.totalCount)
	self._downLevelTxt.text = ""

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.EndlessChallenge, self.curActId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	self._openDate.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)

	self._btnBuff.gameObject:SetActive(self.actcfg.buffSelect)
end

function FiredragonlevelsView:onRefreshUI()
	self._levelObj:SetActive(true)

	self.stageId = InfinitefutureModel.instance.curStageId
	self.buffId = InfinitefutureModel.instance.curBuffId

	if self.stageId > self.totalCount then
		FloatWordMgr.instance:show("已通过所有关卡")
		GameUtil.saveUserData("infinfuover" .. tostring(self.curActId), "1")
		self:close()

		return
	end

	self.stageTeams = InfinitefutureConfig.instance:getTeamCfgs(self.curActId, self.stageId)
	self.curCount = #self.stageTeams
	self.curBuffCfg = InfinitefutureConfig.instance:getSelectBuffCfg(self.curActId, self.buffId)

	local sValue = (self.stageId - 1) / (self.totalCount - 1)

	self._levelSlider:SetValue(sValue)

	self._curLevelTxt.text = string.format("当前%d层", self.stageId)

	if self.curBuffCfg then
		if not self.curBuffCfg.icon then
			local buffIcon = "icon_expedition_ydnzhufu"

			uGuiUtil.setSpriteToImage(self._iconBuff, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(buffIcon))
			self._redBuff:SetActive(InfinitefutureModel.instance:isBuffNew(self.curActId))

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
	end
end

function FiredragonlevelsView:_setTeamInfo(cell, teamId)
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

return FiredragonlevelsView
