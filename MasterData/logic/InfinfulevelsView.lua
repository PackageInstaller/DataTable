-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinfulevelsView.lua

module("logic.extensions.infinitefuture.view.InfinfulevelsView", package.seeall)

local InfinfulevelsView = class("InfinfulevelsView", ViewComponent)

function InfinfulevelsView:ctor()
	InfinfulevelsView.super.ctor(self)
end

function InfinfulevelsView:unbindEvents()
	InfinfulevelsView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._rewardBtn:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function InfinfulevelsView:bindEvents()
	InfinfulevelsView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._rewardBtn:AddClickListener(self._onClickReward, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function InfinfulevelsView:buildUI()
	InfinfulevelsView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._rewardBtn = self:getBtn("info/btnReward")
	self._btnTip = self:getBtn("btnTip")
	self._cell = self:getGo("levels/cell")
	self._levelObj = self:getGo("levels")
	self._levelSlider = self:getSlider("info/level")
	self._openDate = self:getTxt("time/txt")
	self._upLevelTxt = self:getTxt("info/txtUp")
	self._downLevelTxt = self:getTxt("info/txtDown")
	self._curLevelTxt = self:getTxt("info/level/Fill Area/info/txtLevel")
	self._headObj = self:getGo("info/level/Fill Area/info/head")
	self._iconObj = self:getGo("info/btnReward/icon")

	UGUIToolHelper.AddChild(self._levelObj, self._cell)
	UGUIToolHelper.AddChild(self._levelObj, self._cell)
end

function InfinfulevelsView:onExit()
	InfinfulevelsView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)

	for _, v in pairs(self._cellList) do
		for _, w in ipairs(v) do
			MaterialMgr.clearIcon(w)
		end
	end
end

function InfinfulevelsView:onEnter()
	InfinfulevelsView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)

	self._cellList = {}
	self.curActId = InfinitefutureModel.instance.curActId
	self._planCfg = InfinitefutureConfig.instance:getPlanCfg(self.curActId)
	self.totalCount = InfinitefutureConfig.instance:getStageCount(self.curActId)
	self._openDate.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.EndlessChallenge, self.curActId)
	self._upLevelTxt.text = string.format("%d层", self.totalCount)
	self._downLevelTxt.text = "1层"

	HeadItemController.instance:setMyHeadCell(self._headObj)

	local skinId = self._planCfg.skinId

	if checknumber(skinId) > 0 then
		MaterialMgr.setIcon(self._iconObj, MatType.PET_SKIN, skinId)
	end

	self:onRefreshUI()
end

function InfinfulevelsView:onRefreshUI()
	self.stageId = InfinitefutureModel.instance.curStageId

	if self.stageId > self.totalCount then
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

function InfinfulevelsView:_setTeamInfo(cell, teamId)
	local creepId = self.stageTeams[teamId].creepsMasterId
	local isPass = InfinitefutureModel.instance:isChallengeTeam(teamId)
	local pkBtn = goutil.findChild(cell, "btnChallenge")
	local resetBtn = goutil.findChild(cell, "btnReset")
	local pass = goutil.findChild(cell, "pass")
	local formation = goutil.findChild(cell, "formation")
	local stageCfg = InfinitefutureConfig.instance:getStageCfg(self.curActId, self.stageId)
	local actTimeCfg = ActivityDefineConfig.instance:getCfgByActivitYId(self.curActId)
	local isOnTime = true
	local openTimeStr

	if not string.nilorempty(stageCfg.openTime) then
		local openTime = GameUtil.string2time(stageCfg.openTime)
		local openDate = GameUtil.string2date(stageCfg.openTime)

		openTimeStr = langPara("%d.%d %d:%02d开启", openDate.month, openDate.day, openDate.hour, openDate.min)
		isOnTime = openTime < ServerTime.now()
	end

	pkBtn:SetActive(not isPass)
	resetBtn:SetActive(isPass)
	pass:SetActive(isPass)
	self:refreshLockTeam(cell, teamId)
	GameUtil.asBtn(pkBtn):AddClickListener(function()
		if not isOnTime then
			FloatWordMgr.instance:show(openTimeStr)
		else
			UIStateManager.instance:push(ViewName.InfinfuMissionView, self.curActId, self.stageId, teamId, creepId)
		end
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

		if obj then
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
end

function InfinfulevelsView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "infiniteFutureChapter_rule")
end

function InfinfulevelsView:_onClickReward()
	UIStateManager.instance:push(ViewName.InfinitefuturepopView, 2, self.curActId)
end

function InfinfulevelsView:refreshLockTeam(cell, teamId)
	return
end

return InfinfulevelsView
