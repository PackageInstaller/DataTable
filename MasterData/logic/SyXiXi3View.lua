-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/syxixi/view/SyXiXi3View.lua

module("logic.extensions.SyXiXi.view.SyXiXi3View", package.seeall)

local SyXiXi3View = class("SyXiXi3View", ViewComponent)

function SyXiXi3View:ctor()
	SyXiXi3View.super.ctor(self)
end

function SyXiXi3View:unbindEvents()
	SyXiXi3View.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function SyXiXi3View:bindEvents()
	SyXiXi3View.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		self:close()
	end, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "syxixiclg_lv3_rule")
	end, self)
end

function SyXiXi3View:buildUI()
	SyXiXi3View.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._levelSlider = self:getSlider("info/level")
	self._openDate = self:getTxt("time/txt")
	self._curLevelTxt = self:getTxt("total/txt")
	self._rewardObj = self:getGo("info/level/reward")
	self._rewardItem = self:getGo("info/level/reward/item")
	self._txtTitle = self:getTxt("txtTitle")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)

	self.rewardTab = {}
end

function SyXiXi3View:onExit()
	SyXiXi3View.super.onExit(self)
	self._scrollList:dispose()
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

function SyXiXi3View:onEnter()
	SyXiXi3View.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)

	local params = self:getOpenParam()

	if params and params[2] then
		self._txtTitle.text = params[2]
	end

	self.curActId = checknumber(self:getFirstParam())
	self._cellList = {}
	self.stageCfgs = InfinitefutureConfig.instance:getStageCfgs(self.curActId)
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

	InfinitefutureController.instance:sendInfoReq(self.curActId)
end

function SyXiXi3View:onRefreshUI()
	self.stageId = InfinitefutureModel.instance:getStageById(self.curActId)

	if not self.stageId or self.stageId > self.totalCount then
		FloatWordMgr.instance:show("已通过所有关卡")
		self:close()

		return
	end

	self.stageTeams = InfinitefutureConfig.instance:getTeamCfgs(self.curActId, self.stageId)
	self.curCount = #self.stageTeams

	local sValue = (self.stageId - 1) / self.totalCount

	self._levelSlider:SetValue(sValue)

	self._curLevelTxt.text = string.format("通关奖励（%d/%d）", self.stageId - 1, self.totalCount)

	self._scrollList:reloadData(self.stageTeams)

	for i = 1, #self.rewardTab do
		goutil.findChild(self.rewardTab[i], "receive"):SetActive(i < self.stageId)
	end
end

function SyXiXi3View:_updateCell(view, cell, data, tag)
	local creepId = data.creepsMasterId
	local teamId = data.teamId
	local isPass = InfinitefutureModel.instance:isChallengeTeamById(self.curActId, teamId)
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

	local list = {}

	for i = 1, 9 do
		local obj = goutil.findChild(formation, string.format("cell_%d/con", i))

		MaterialMgr.clearIcon(obj)
		obj.transform.parent.gameObject:SetActive(false)

		list[i] = obj
	end

	local creepCfgs = InfinitefutureConfig.instance:getCreepCfgs(creepId)

	for i, v in ipairs(creepCfgs) do
		local raceId, posId = v.raceId, v.posId

		if checknumber(posId) > 0 then
			local obj = list[posId]

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

function SyXiXi3View:_clearCell(cell)
	return
end

function SyXiXi3View:_setTeamInfo(cell, teamId)
	local creepId = self.stageTeams[teamId].creepsMasterId
	local isPass = InfinitefutureModel.instance:isChallengeTeamById(self.curActId, teamId)
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

return SyXiXi3View
