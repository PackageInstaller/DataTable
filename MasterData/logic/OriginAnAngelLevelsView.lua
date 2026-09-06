-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originanangel/view/OriginAnAngelLevelsView.lua

module("logic.extensions.originanangel.view.OriginAnAngelLevelsView", package.seeall)

local OriginAnAngelLevelsView = class("OriginAnAngelLevelsView", DivineAnLevelsView)

function OriginAnAngelLevelsView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._rewardBtn = self:getBtn("info/btnReward")
	self._btnTip = self:getBtn("btnTip")
	self._cell = self:getGo("levels/cell")
	self._levelSlider = self:getSlider("info/level")
	self._openDate = self:getTxt("time/txt")
	self._upLevelTxt = self:getTxt("info/txtUp")
	self._downLevelTxt = self:getTxt("info/txtDown")
	self._curLevelTxt = self:getTxt("info/level/Fill Area/info/txtLevel")
	self._headObj = self:getGo("info/level/Fill Area/info/head")
	self._iconObj = self:getGo("info/btnReward/icon")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollerList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(GameUtil.handler(self._reloadFinish, self))

	self._txtDesc = self:getTxt("desc/scrView/Viewport/Content")
end

function OriginAnAngelLevelsView:_setTeamInfo(cell, teamId)
	local creepId = self.stageTeams[teamId].creepsMasterId
	local isPass = InfinitefutureModel.instance:isChallengeTeam(teamId)
	local pkBtn = goutil.findChild(cell, "btnChallenge")
	local resetBtn = goutil.findChild(cell, "btnReset")
	local pass = goutil.findChild(cell, "pass")
	local formation = goutil.findChild(cell, "formation")
	local txtTarget = goutil.findChildTextComponent(cell, "target/txtTarget")
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

	local hasPassCount = not string.nilorempty(stageCfg.passCount)

	if hasPassCount then
		txtTarget.text = string.format("精灵存活≥%s", stageCfg.passCount)
	end

	GameUtil.SetActive(txtTarget.gameObject, hasPassCount)
end

return OriginAnAngelLevelsView
