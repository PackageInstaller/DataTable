-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/Xjlevels3View.lua

module("logic.extensions.xingjiang.view.Xjlevels3View", package.seeall)

local Xjlevels3View = class("Xjlevels3View", ViewComponent)

function Xjlevels3View:ctor()
	Xjlevels3View.super.ctor(self)
end

function Xjlevels3View:unbindEvents()
	Xjlevels3View.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function Xjlevels3View:bindEvents()
	Xjlevels3View.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		self:close()
	end, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "starCrimsonChapter_rule3")
	end, self)
end

function Xjlevels3View:buildUI()
	Xjlevels3View.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._cell = self:getGo("levels/cell")
	self._levelObj = self:getGo("levels")
	self._levelSlider = self:getSlider("info/level")
	self._openDate = self:getTxt("time/txt")
	self._curLevelTxt = self:getTxt("total/txt")
	self._rewardObj = self:getGo("info/level/reward")
	self._rewardItem = self:getGo("info/level/reward/item")

	UGUIToolHelper.AddChild(self._levelObj, self._cell)
	UGUIToolHelper.AddChild(self._levelObj, self._cell)

	self.rewardTab = {}
end

function Xjlevels3View:onExit()
	Xjlevels3View.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)

	for _, v in pairs(self._cellList) do
		for _, w in ipairs(v) do
			MaterialMgr.clearIcon(w)
		end
	end

	for i = 1, #self.rewardTab do
		local go = goutil.findChild(self.rewardTab[i], "con")

		MaterialMgr.resetAll(go)
	end
end

function Xjlevels3View:onEnter()
	Xjlevels3View.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)

	self._cellList = {}
	self.curActId = XingJiangModel.instance.curActId3
	self.stageCfgs = InfinitefutureConfig.instance:getStageCfgs(self.curActId)
	self.totalCount = #self.stageCfgs
	self._openDate.text = "活动时间：03.24 5:00 - 03.31 5:00"

	if #self.rewardTab == 0 then
		for i = 1, self.totalCount do
			if i == 1 then
				if not self._rewardItem then
					local obj = UGUIToolHelper.AddChild(self._rewardObj, self._rewardItem)

					table.insert(self.rewardTab, obj)
				end
			end
		end
	end

	for i = 1, self.totalCount do
		local prize = self.stageCfgs[i].prize
		local obj = self.rewardTab[i]
		local go = goutil.findChild(obj, "con")

		MaterialMgr.resetAll(go)
		MaterialMgr.setCellByCfg(prize, go)

		goutil.findChildTextComponent(obj, "txtNum").text = string.format("第%d关", i)
	end

	InfinitefutureController.instance:sendInfoReq(self.curActId)
end

function Xjlevels3View:onRefreshUI()
	self.stageId = InfinitefutureModel.instance.curStageId

	if not self.stageId or self.stageId > self.totalCount then
		FloatWordMgr.instance:show("已通过所有关卡")
		GameUtil.saveUserData("xingjiangover3", "1")
		self:close()

		return
	end

	self.stageTeams = InfinitefutureConfig.instance:getTeamCfgs(self.curActId, self.stageId)
	self.curCount = #self.stageTeams

	local sValue = (self.stageId - 1) / self.totalCount

	self._levelSlider:SetValue(sValue)

	self._curLevelTxt.text = string.format("通关奖励（%d/%d）", self.stageId - 1, self.totalCount)

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

	for i = 1, #self.rewardTab do
		goutil.findChild(self.rewardTab[i], "receive"):SetActive(i < self.stageId)
	end
end

function Xjlevels3View:_setTeamInfo(cell, teamId)
	local creepId = self.stageTeams[teamId].creepsMasterId
	local isPass = InfinitefutureModel.instance:isChallengeTeam(teamId)
	local pkBtn = goutil.findChild(cell, "btnChallenge")
	local resetBtn = goutil.findChild(cell, "btnReset")
	local pass = goutil.findChild(cell, "pass")
	local formation = goutil.findChild(cell, "formation")

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

return Xjlevels3View
