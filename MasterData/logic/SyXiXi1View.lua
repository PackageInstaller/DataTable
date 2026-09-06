-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/syxixi/view/SyXiXi1View.lua

module("logic.extensions.SyXiXi.view.SyXiXi1View", package.seeall)

local SyXiXi1View = class("SyXiXi1View", ViewComponent)

function SyXiXi1View:ctor()
	SyXiXi1View.super.ctor(self)
end

function SyXiXi1View:unbindEvents()
	SyXiXi1View.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function SyXiXi1View:bindEvents()
	SyXiXi1View.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		self:close()
	end, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "syxixiclg_lv1_rule")
	end, self)
end

function SyXiXi1View:buildUI()
	SyXiXi1View.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._cell = self:getGo("levels/cell")
	self._levelObj = self:getGo("levels")
	self._levelSlider = self:getSlider("info/level")
	self._openDate = self:getTxt("time/txt")
	self._curLevelTxt = self:getTxt("total/txt")
	self._rewardObj = self:getGo("info/level/reward")
	self._rewardItem = self:getGo("info/level/reward/item")
	self._txtTitle = self:getTxt("txtTitle")

	UGUIToolHelper.AddChild(self._levelObj, self._cell)
	UGUIToolHelper.AddChild(self._levelObj, self._cell)
	UGUIToolHelper.AddChild(self._levelObj, self._cell)

	self.rewardTab = {}
end

function SyXiXi1View:onExit()
	SyXiXi1View.super.onExit(self)
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

function SyXiXi1View:onEnter()
	SyXiXi1View.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)

	self.curActId = checknumber(self:getFirstParam())

	local params = self:getOpenParam()

	if params and params[2] then
		self._txtTitle.text = params[2]
	end

	self._cellList = {}
	self.stageCfgs = XingJiangConfig.instance:getStageCfgs(self.curActId)
	self.totalCount = #self.stageCfgs
	self._openDate.text = TimeGateController.instance:getActTimeShow(self.curActId)

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

	XingJiangController.instance:sendInfoReq(self.curActId)
	self:onRefreshUI()
end

function SyXiXi1View:onRefreshUI()
	self.stageId = XingJiangModel.instance:getStageById(self.curActId)

	if XingJiangModel.instance:checkIsPassById(self.curActId) then
		FloatWordMgr.instance:show("已通过所有关卡")
		self:close()

		return
	end

	self.stageTeams = XingJiangConfig.instance:getTeamCfgs(self.curActId, self.stageId)
	self.curCount = #self.stageTeams

	local sValue = (self.stageId - 1) / self.totalCount

	self._levelSlider:SetValue(sValue)

	self._curLevelTxt.text = string.format("通关奖励（%d/%d）", self.stageId - 1, self.totalCount)

	local scale = self.curCount > 2 and 1 or 1.1

	GameUtil.setLocalScale(self._levelObj, scale, scale, 1)

	for i = 1, 4 do
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

function SyXiXi1View:_setTeamInfo(cell, teamId)
	local cfgTeam = self.stageTeams[teamId]
	local creepId, teamName, teamDesc = cfgTeam.creepsMasterId, cfgTeam.teamName, cfgTeam.decs
	local isPass = XingJiangModel.instance:isChallengeTeamByActId(self.curActId, teamId)
	local activeNum = XingJiangModel.instance:getTeamActiveNumByActId(self.curActId, teamId)
	local pkBtn = goutil.findChild(cell, "btnChallenge")
	local resetBtn = goutil.findChild(cell, "btnReset")
	local pass = goutil.findChild(cell, "pass")
	local formation = goutil.findChild(cell, "formation")
	local fuhaoChange = goutil.findChildComponent(cell, "imgFuhao", typeof(UIImageSpriteChange))

	fuhaoChange:SetState(XingJiangConfig.compareType[cfgTeam.compareType])

	goutil.findChildTextComponent(cell, "txtName").text = teamName
	goutil.findChildTextComponent(cell, "txtPetNum").text = teamDesc .. ": " .. (activeNum > 0 and activeNum or "?")

	for i = 1, 2 do
		if cfgTeam.raceTab then
			local isRace = cfgTeam.raceTab[i] ~= nil

			goutil.findChild(cell, "attr" .. i):SetActive(isRace)

			if isRace then
				goutil.findChildComponent(cell, "attr" .. i, typeof(UIImageSpriteChange)):SetState(cfgTeam.raceTab[i] - 1)
			end
		end
	end

	pkBtn:SetActive(not isPass)
	resetBtn:SetActive(isPass)
	pass:SetActive(isPass)
	GameUtil.asBtn(pkBtn):AddClickListener(function()
		self:_onClickGoFight(self.curActId, self.stageId, teamId, creepId)
	end, self)
	GameUtil.asBtn(resetBtn):AddClickListener(function()
		self:_onClickGoFight(self.curActId, self.stageId, teamId, creepId)
	end, self)

	self._cellList[teamId] = {}

	for i = 1, 9 do
		local obj = goutil.findChild(formation, string.format("cell_%d/con", i))

		MaterialMgr.clearIcon(obj)
		obj.transform.parent.gameObject:SetActive(false)

		self._cellList[teamId][i] = obj
	end

	local creepCfgs = XingJiangConfig.instance:getCreepCfgs(creepId)

	for i, v in ipairs(creepCfgs) do
		local raceId, posId = v.raceId, v.posId

		if checknumber(posId) > 0 then
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
end

function SyXiXi1View:_onClickGoFight(curActId, stageId, teamId, creepId)
	UIStateManager.instance:push(ViewName.XjMissionView, curActId, stageId, teamId, creepId)
end

return SyXiXi1View
