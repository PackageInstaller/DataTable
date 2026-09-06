-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/view/copy/DivineymjdlevelsView.lua

module("logic.extensions.kingspacedragon.view.copy.DivineymjdlevelsView", package.seeall)

local DivineymjdlevelsView = class("DivineymjdlevelsView", ViewComponent)

DivineymjdlevelsView.OpType = {
	["*"] = 2,
	["/"] = 3,
	["+"] = 0,
	[">"] = 8,
	[">="] = 5,
	["="] = 7,
	["<="] = 4,
	["<"] = 6,
	["-"] = 1
}

function DivineymjdlevelsView:ctor()
	DivineymjdlevelsView.super.ctor(self)
end

function DivineymjdlevelsView:unbindEvents()
	DivineymjdlevelsView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._rewardBtn:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function DivineymjdlevelsView:bindEvents()
	DivineymjdlevelsView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._rewardBtn:AddClickListener(self._onClickReward, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function DivineymjdlevelsView:buildUI()
	DivineymjdlevelsView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._rewardBtn = self:getBtn("info/btnReward")
	self._btnTip = self:getBtn("btnTip")
	self._headObj = self:getGo("info/level/Fill Area/info/head")
	self._upLevelTxt = self:getTxt("info/txtUp")
	self._downLevelTxt = self:getTxt("info/txtDown")
	self._levelSlider = self:getSlider("info/level")
	self._txtScore1 = self:getTxt("desc/txtScore1")
	self._txtScore2 = self:getTxt("desc/txtScore2")
	self._txtTotalScore = self:getTxt("desc/txtTotalScore")
	self._curLevelTxt = self:getTxt("info/level/Fill Area/info/txtLevel")
	self._cell2Go = self:getGo("cell2")
	self._cell1Go = self:getGo("cell1")
	self._imgSysbol1 = self:getGo("desc/imgSysbol1"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgSysbol2 = self:getGo("desc/imgSysbol2"):GetComponent(ComponentType.UIImageSpriteChange)
	self._iconGo = self:getGo("info/btnReward/icon")
	self._goLock = self:getGo("txtLockDesc")
	self._txtLockDesc = self:getTxt("txtLockDesc")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
end

function DivineymjdlevelsView:onExit()
	DivineymjdlevelsView.super.onExit(self)

	for _, v in pairs(self._cellList) do
		for _, w in ipairs(v) do
			MaterialMgr.clearIcon(w)
		end
	end

	MaterialMgr.resetAll(self._iconGo)
end

function DivineymjdlevelsView:onEnter()
	DivineymjdlevelsView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.KingSpaceDragonClgFightConfirmRes, self._updateUI, self)
	HeadItemController.instance:setMyHeadCell(self._headObj)

	self._cellList = {}
	self._activityId = KingspacedragonModel.instance:getActivityId()

	local cfgs = KingspacedragonConfig.instance:getStageCfgs(self._activityId)

	self._totalCount = #cfgs
	self._stageId = KingspacedragonModel.instance:getCurrStageId(self._activityId)

	if self._stageId >= self._totalCount then
		self._stageId = self._totalCount
	end

	self._upLevelTxt.text = string.format("%d层", self._totalCount)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	self:_updateUI()
	self:_checkConfirm()
	self:_setRewardIcon()
end

function DivineymjdlevelsView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, KingspacedragonConfig.instance:getRuleKey(self._activityId, "ruleKeyLevels"))
end

function DivineymjdlevelsView:_onClickReward()
	UIStateManager.instance:push(ViewName.DivineymjdpopView, self._activityId)
end

function DivineymjdlevelsView:_updateUI()
	self._info = KingspacedragonModel.instance:getInfo(self._activityId)

	if not self._info then
		return
	end

	self._stageId = KingspacedragonModel.instance:getCurrStageId(self._activityId)

	if self._stageId >= self._totalCount then
		self._stageId = self._totalCount
	end

	self._stageCfg = KingspacedragonConfig.instance:getStageCfg(self._activityId, self._stageId)
	self._downLevelTxt.text = "1层"

	self:_updateDesc()
	self:_updateFmts()
end

function DivineymjdlevelsView:_updateDesc()
	local sValue = (self._stageId - 1) / (self._totalCount - 1)

	self._levelSlider:SetValue(sValue)

	self._curLevelTxt.text = string.format("当前%d层", self._stageId)
	self._txtScore1.text = self._info.curStageTimeValue < 0 and string.format("<color=%s>未通关</color>", GameEnum.ColorConst.Red) or string.format("<color=%s>%s</color>", GameEnum.ColorConst.Green, self._info.curStageTimeValue)
	self._txtScore2.text = self._info.curStageSpaceValue < 0 and string.format("<color=%s>未通关</color>", GameEnum.ColorConst.Red) or string.format("<color=%s>%s</color>", GameEnum.ColorConst.Green, self._info.curStageSpaceValue)

	if not DivineymjdlevelsView.OpType[self._stageCfg.opType] then
		local op1 = 0

		self._imgSysbol1:SetState(op1)

		if not DivineymjdlevelsView.OpType[self._stageCfg.compareType] then
			local op2 = 0

			self._imgSysbol2:SetState(op2)

			self._txtTotalScore.text = self._stageCfg.compareValue
		end
	end
end

function DivineymjdlevelsView:_updateFmts()
	local time = GameUtil.string2time(self._stageCfg.openTime)
	local isLock = time > ServerTime.now()

	goutil.setActive(self._goLock, isLock)

	if isLock then
		local date = GameUtil.string2date(self._stageCfg.openTime)

		self._txtLockDesc.text = string.format("本层挑战于%s.%s.%s开启", date.year, date.month, date.day)
	end

	self:_setTeamInfo(self._cell1Go, 1, self._stageCfg.timeCreepsMasterId, GameEnum.KingSpaceDragonClgMonsterType.Time)
	self:_setTeamInfo(self._cell2Go, 2, self._stageCfg.spaceCreepsMasterId, GameEnum.KingSpaceDragonClgMonsterType.Space)
end

function DivineymjdlevelsView:_setTeamInfo(cell, teamId, creepsMasterId, ctype)
	local creepId = creepsMasterId
	local isPass = false
	local pkBtn = goutil.findChild(cell, "btnChallenge")
	local pass = goutil.findChild(cell, "pass")
	local formation = goutil.findChild(cell, "formation")

	pkBtn:SetActive(not isPass)
	pass:SetActive(isPass)
	GameUtil.asBtn(pkBtn):AddClickListener(function()
		local time = GameUtil.string2time(self._stageCfg.openTime)

		if time > ServerTime.now() then
			FloatWordMgr.instance:show("关卡未开启")

			return
		end

		KingspacedragonController.instance:enterMission(self._activityId, ctype, creepId)
	end, self)

	self._cellList[teamId] = {}

	for i = 1, 9 do
		local obj = goutil.findChild(formation, string.format("cell_%d/con", i))

		MaterialMgr.clearIcon(obj)
		obj.transform.parent.gameObject:SetActive(false)

		self._cellList[teamId][i] = obj
	end

	local creepCfgs = KingspacedragonConfig.instance:getCreepsCfgs(creepId)

	for i, v in ipairs(creepCfgs) do
		local raceId, posId = v.raceId, v.posId

		if posId > 0 then
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

function DivineymjdlevelsView:_checkConfirm()
	local needConfirm = KingspacedragonController.instance:needConfirm()

	if needConfirm then
		UIStateManager.instance:push(ViewName.DivineymjdchangetipView)
	end
end

function DivineymjdlevelsView:_setRewardIcon()
	local actCfg = KingspacedragonConfig.instance:getActCfg(self._activityId)
	local matType, matId = MaterialMgr.getMatParams(actCfg.rewardStr)

	MaterialMgr.setIcon(self._iconGo, matType, matId)
end

return DivineymjdlevelsView
