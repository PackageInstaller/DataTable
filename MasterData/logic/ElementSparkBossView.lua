-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkBossView.lua

module("logic.extensions.elementspark.view.ElementSparkBossView", package.seeall)

local ElementSparkBossView = class("ElementSparkBossView", ViewComponent)

function ElementSparkBossView:ctor()
	ElementSparkBossView.super.ctor(self)
end

function ElementSparkBossView:unbindEvents()
	ElementSparkBossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnEffect)
end

function ElementSparkBossView:bindEvents()
	ElementSparkBossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnEffect, self._onClickEffect, self)
end

function ElementSparkBossView:buildUI()
	ElementSparkBossView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._con = self:getGo("con")
	self._txtName = self:getTxt("name/txtName")
	self._guardCount = self:getGo("guard/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._txtPetName = self:getTxt("bossInfo/txtName")
	self._txtBloodRate = self:getTxt("bossInfo/txtBloodRate")
	self._txtBlood = self:getTxt("bossInfo/txtBlood")
	self._bossBlood = self:getSlider("bossInfo/bossBlood")
	self._harmCells = {}

	for i = 1, 4 do
		local cell = {}

		cell.go = self:getGo("harmRate/harmCon/cell_" .. i)
		cell.txtCamp = self:getTxt("harmRate/harmCon/cell_" .. i .. "/txtCamp")
		cell.txtRate = self:getTxt("harmRate/harmCon/cell_" .. i .. "/txtRate")

		table.insert(self._harmCells, cell)
	end

	self._empty = self:getGo("harmRate/empty")
	self._harmCon = self:getGo("harmRate/harmCon")
	self._txtCost = self:getTxt("btnChallenge/txtCost")
	self._txtChallengeMode = self:getTxt("btnChallenge/txtMode")
	self._btnEffect = self:getBtn("btnEffect")

	goutil.setActive(self._btnTip.gameObject, false)
end

function ElementSparkBossView:onExit()
	ElementSparkBossView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._loader)
	removetimer(self._recoveryBlood, self)
end

function ElementSparkBossView:onEnter()
	ElementSparkBossView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EleSparkGetOtherGuardInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.ElementSparkMapChange, self._onMapChange, self)
	self.addGEvent(self, GlobalNotify.EleSparkGetInfoRes, self._onMapChange, self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._chunkId = checknumber(self:getFirstParam())

	local planId = ElementSparkController.instance:getMapPlanId()

	self._chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, self._chunkId)
	self._raceId = self._chunkCfg.bossRaceId
	self._challengeType = 1
	self._isCanFight = false
	self._curBossHp = 0
	self._lastChallengeType = nil

	self:_sendInfoReq()
end

function ElementSparkBossView:_sendInfoReq()
	ElementSparkController.instance:sendPM_EleSparkGetOtherGuardInfoReq(self._activityId, self._chunkId)
end

function ElementSparkBossView:_refresh()
	self._otherGuardInfo = ElementSparkModel.instance:getOtherGuardInfo()

	self:_showBossInfo()
	self:_showGuardInfo()
	self:_checkGotoChallenge()
end

function ElementSparkBossView:_showBossInfo()
	self._txtPetName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(self._raceId)
	local x, y, scale = modelCfg[1], modelCfg[2], modelCfg[3]

	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, self._raceId, self._con, scale, nil, true, x, y)

	local belongCampId = ElementSparkModel.instance:getChunkBelong(self._chunkId)
	local pos = self._chunkCfg.pos
	local starLv = self._chunkCfg.star

	if belongCampId <= 0 then
		self._txtName.text = string.format("当前地块：中立-%d星地块(%d,%d)", starLv, pos[1], pos[2])
	else
		local campName = ElementSparkConfig.instance:getCampCfgById(self._activityId, belongCampId).name

		self._txtName.text = string.format("当前地块：%s阵营-%d星地块(%d,%d)", campName, starLv, pos[1], pos[2])
	end

	local bossInfo = self._otherGuardInfo.bossInfo
	local bossHp = bossInfo.bossFullHp
	local leftHp = bossInfo.bossLeftHp
	local peaceEndTimeMillis = checknumber(bossInfo.peaceEndTimeMillis)
	local lastRefreshHpMillis = checknumber(bossInfo.lastRefreshHpMillis)
	local recoveryRate = bossInfo.rate

	self._txtBlood.text = string.format("剩余血量：<color=#eb4642>%d/%d</color>", leftHp, bossHp)
	self._txtBloodRate.text = string.format("非战时回血：<color=#eb4642>%d%%</color>/分钟", recoveryRate / 100)
	self._isCanFight = true

	self._bossBlood:SetValue(1 / bossHp * leftHp)

	self._curBossHp = leftHp

	if recoveryRate > 0 and leftHp < bossHp then
		settimer(60, self._recoveryBlood, self, true)
	else
		removetimer(self._recoveryBlood, self)
	end

	if self._otherGuardInfo.leftDefenseFormCount > 0 then
		self._challengeType = GameEnum.ElementChallengeType.Guard or GameEnum.ElementChallengeType.Boss
	end

	self._txtChallengeMode.text = self._challengeType == GameEnum.ElementChallengeType.Boss and "挑战<size=34>BOSS</size>" or "挑战守卫"

	if self._challengeType == GameEnum.ElementChallengeType.Guard then
		GameUtil.SetActive(self._txtBlood.gameObject, false)
		GameUtil.SetActive(self._txtBloodRate.gameObject, false)

		self._txtCost.text = belongCampId <= 0 and "体力x" .. ElementSparkConfig.instance:getCommonCfgByKey("ATTACK_SYS_COST", true) or "体力x" .. ElementSparkConfig.instance:getCommonCfgByKey("ATTACK_PLAYER_COST", true)
	elseif self._challengeType == GameEnum.ElementChallengeType.Boss then
		GameUtil.SetActive(self._txtBlood.gameObject, true)
		GameUtil.SetActive(self._txtBloodRate.gameObject, true)

		self._txtCost.text = "体力x" .. ElementSparkConfig.instance:getCommonCfgByKey("ATTACK_BOSS_COST", true)
	end
end

function ElementSparkBossView:_showGuardInfo()
	self._guardCount:SetNum(self._otherGuardInfo.leftDefenseFormCount)

	local campDamageInfos = ElementSparkController.instance:filterCampDamageInfos(self._otherGuardInfo.campDamageInfos)
	local isEmpty = #campDamageInfos <= 0

	if isEmpty then
		GameUtil.SetActive(self._empty, true)
		GameUtil.SetActive(self._harmCon, false)
	else
		GameUtil.SetActive(self._empty, false)
		GameUtil.SetActive(self._harmCon, true)

		for i = #campDamageInfos + 1, #self._harmCells do
			GameUtil.SetActive(self._harmCells[i].go, false)
		end

		for i, v in ipairs(campDamageInfos) do
			GameUtil.SetActive(self._harmCells[i].go, true)

			local cell = self._harmCells[i]
			local myCampId = ElementSparkModel.instance:getMyCampId()

			if v.campId == myCampId then
				cell.txtCamp.text = string.format("<color=#20b376>%s</color>", ElementSparkController.instance:getCampNameById(v.campId))
				cell.txtRate.text = string.format("<color=#20b376>%d%%</color>", v.percent)
			else
				cell.txtCamp.text = string.format("<color=#ffffff>%s</color>", ElementSparkController.instance:getCampNameById(v.campId))
				cell.txtRate.text = string.format("<color=#ffffff>%d%%</color>", v.percent)
			end
		end
	end
end

function ElementSparkBossView:_recoveryBlood()
	local bossFullHp = self._otherGuardInfo.bossInfo.bossFullHp

	self._curBossHp = self._curBossHp + self._otherGuardInfo.bossInfo.rate
	self._curBossHp = math.min(self._curBossHp, bossFullHp)

	self._bossBlood:SetValue(self._curBossHp / bossFullHp)

	self._txtBlood.text = string.format("剩余血量：<color=#eb4642>%d</color>/%d", self._curBossHp, bossFullHp)
end

function ElementSparkBossView:_onClickTip()
	TipsFacade.instance:openRulesView("ElementSparkBoss_rule")
end

function ElementSparkBossView:_onClickChallenge()
	if ElementSparkController.instance:getActivityStage() ~= GameEnum.ElementSparkStageType.Battle then
		FloatWordMgr.instance:show("非交战阶段")

		return
	end

	local isRestTime = ElementSparkController.instance:isRestTime()

	if isRestTime then
		FloatWordMgr.instance:show("休战期不可挑战")

		return
	end

	local isProtect = ElementSparkModel.instance:getChunkInProtect(self._chunkId)

	if isProtect then
		local time = ElementSparkModel.instance:getGuardProtectTime(self._chunkId)
		local cutdown = ServerTime.now() - time
		local desc = string.format("再过%s即可开始攻打此地块，再等一会吧", GameUtil.FormatTimeSymbol(time))

		FloatWordMgr.instance:show(desc)

		return
	end

	self._lastChallengeType = self._challengeType

	self:_sendInfoReq()
end

function ElementSparkBossView:_onClickEffect()
	local level = ElementSparkModel.instance:getChunkLevel(self._chunkId)

	UIStateManager.instance:push(ViewName.ElementSparkBossOccupiedEffectView, self._chunkId, level)
end

function ElementSparkBossView:_onMapChange()
	local belongMe = ElementSparkModel.instance:getChunlBelongMe(self._chunkId)

	if belongMe then
		FloatWordMgr.instance:show("地块已被己方占领")
		UIStateManager.instance:push(ViewName.ElementSparkCampView, self._chunkId)
		self:close()

		return
	end
end

function ElementSparkBossView:_checkGotoChallenge()
	if not self._lastChallengeType then
		return
	end

	local ct = self._lastChallengeType

	self._lastChallengeType = nil

	if self._challengeType ~= ct then
		FloatWordMgr.instance:show("数据有刷新，请重新挑战")

		return
	end

	UIStateManager.instance:push(ViewName.ElementSparkSelectTeamView, self._challengeType, self._chunkId)
end

return ElementSparkBossView
