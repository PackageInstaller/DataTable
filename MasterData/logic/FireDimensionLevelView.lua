-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firedimension/view/FireDimensionLevelView.lua

module("logic.extensions.firedimension.view.FireDimensionLevelView", package.seeall)

local FireDimensionLevelView = class("FireDimensionLevelView", FormationLeftViewBase)

function FireDimensionLevelView:ctor()
	FireDimensionLevelView.super.ctor(self)
end

function FireDimensionLevelView:buildUI()
	FireDimensionLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtTime = self:getTxt("time/txt")
	self._txtLevel = MaterialMgr.findGraphicText(self.mainGO, "levels/bgtxt/txt")
	self._btnCommit = self:getBtn("levels/btnCommit")
	self._btnReset = self:getBtn("levels/btnReset")
	self._txtCommit = self:getTxt("levels/btnCommit/txt")
	self._cellList = {}

	local cell = self:getGo("levels/cell")

	goutil.setActive(cell, false)

	local cellsTrans = self:getGo("levels/cells").transform

	for i = 1, 9 do
		local item = {}
		local go = goutil.cloneAndSetParent(cell, cellsTrans, "cell" .. i)

		goutil.setActive(go, true)

		item.cellGo = go
		item.ban = goutil.findChild(item.cellGo, "ban")
		item.select = goutil.findChild(item.cellGo, "select")
		item.pass = goutil.findChild(item.cellGo, "pass")
		item.con = goutil.findChild(item.cellGo, "con")
		item.btn = Framework.ButtonAdapter.Get(item.cellGo)

		table.insert(self._cellList, item)
	end

	self._btnChallenge = self:getBtn("fmt/btnChallenge")
	self._txtReward = MaterialMgr.findGraphicText(self.mainGO, "fmt/reward/txt")
	self._rewardGo = self:getGo("fmt/reward")
	self._txtBuff = self:getTxt("fmt/tableview/viewport/txt")
	self._buffScrollRect = self:getGo("fmt/tableview"):GetComponent(ComponentType.ScrollRect)
	self._levelsTrans = self:getGo("levels"):GetComponent(goutil.Type_RectTransform)
	self._Nego_Left = self:getGo("Nego_Left")
	self._fmtGo = self:getGo("fmt")
	self._timeGo = self:getGo("time")
end

function FireDimensionLevelView:bindEvents()
	FireDimensionLevelView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnCommit:AddClickListener(self._onClickCommit, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)

	for i, v in ipairs(self._cellList) do
		v.btn:AddClickListener(function()
			self:_onClickCell(i)
		end)
	end
end

function FireDimensionLevelView:unbindEvents()
	FireDimensionLevelView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnCommit:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()

	for i, v in ipairs(self._cellList) do
		v.btn:RemoveClickListener()
	end
end

function FireDimensionLevelView:onEnter()
	self:_isShowNewActBonds(false)
	FireDimensionLevelView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FireDimensionClgBanRes, self._onFireDimensionClgBanRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FireDimensionClgResetRes, self._onResetRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._curSelectTeamId = 0
	self._activityType = FireDimensionModel.instance:getActivityType()
	self._cfgActivity = FireDimensionConfig.instance:getActivityCfg(self._activityId)
	self._cfgStage = FireDimensionConfig.instance:getBigStageCfg(self._activityId, self._stageId)
	self._maxBanNum = self._cfgStage.banNum
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_initAoqiGodUI()

	self._curBanedTeamIdList = FireDimensionModel.instance:getBanedList(self._activityId, self._stageId)
	self._isPlayedAnim = false

	self:_playEffect(self._stageId)
	self:_showTitle()
	self:_showActivityTime()
	self:_initLevelHeadIcons()
	self:_updateLevels()
	self:_updateLevelBtns()
	self:_updateTxtCommit()
	self:_updateTxtLevel()
	self:_initAnimState()

	if self._curSelectTeamId > 0 then
		self:_onClickCell(self._curSelectTeamId, true)
	end
end

function FireDimensionLevelView:onExit()
	FireDimensionLevelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FireDimensionClgBanRes, self._onFireDimensionClgBanRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FireDimensionClgResetRes, self._onResetRes, self)
	FireDimensionModel.instance:clearFmt()
	self:_clearLevelHeadIcons()
	self:_clearAnim()
	self:_clearEffect()
end

function FireDimensionLevelView:_initAoqiGodUI()
	GameUtil.SetActive(self._timeGo, not self._isAoqiGodProcessType)
end

function FireDimensionLevelView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, self._cfgActivity.ruleLevelTip)
end

function FireDimensionLevelView:_onClickCommit()
	if FireDimensionModel.instance:isStageBaned(self._activityId, self._stageId) then
		FloatWordMgr.instance:show("已经禁用过了")

		return
	end

	if #self._curBanedTeamIdList < self._maxBanNum then
		FloatWordMgr.instance:show(string.format("请禁用%d个关卡", self._maxBanNum))

		return
	end

	if #self._curBanedTeamIdList > self._maxBanNum then
		FloatWordMgr.instance:show(string.format("最多禁用%d关", self._maxBanNum))

		return
	end

	local text = string.format("是否确定眩晕%d个阵容，对应阵容不需要挑战，击败剩余阵容则通过考验", #self._curBanedTeamIdList)

	local function okFunc()
		FireDimensionChallengeAgent.instance:sendPM_FireDimensionClgBanReq(self._activityId, self._stageId, self._curBanedTeamIdList)
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
end

function FireDimensionLevelView:_onClickReset()
	if not FireDimensionModel.instance:isStageBaned(self._activityId, self._stageId) then
		printInfo("还没有禁用关卡，无需重置")

		return
	end

	local text = "确认是否重置关卡？重置后需要重新禁用阵容且已挑战进度不保留，重复挑战的次数无法再次获得奖励。"

	local function okFunc()
		FireDimensionChallengeAgent.instance:sendPM_FireDimensionClgResetReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc)
end

function FireDimensionLevelView:_onClickChallenge()
	if not FireDimensionModel.instance:isStageBaned(self._activityId, self._stageId) then
		printInfo("请先禁用关卡，再开始挑战")

		return
	end

	if self._curSelectTeamId <= 0 then
		FloatWordMgr.instance:show("请先选择关卡")

		return
	end

	if FireDimensionModel.instance:isTeamBaned(self._activityId, self._stageId, self._curSelectTeamId) then
		FloatWordMgr.instance:show("当前关卡已被禁用")

		return
	end

	if FireDimensionModel.instance:isTeamPassed(self._activityId, self._stageId, self._curSelectTeamId) then
		FloatWordMgr.instance:show("当前关卡已挑战过了")

		return
	end

	printInfo("test 开始挑战", self._curSelectTeamId)
	UIStateManager.instance:updateParms(self._viewPresentor.viewName, {
		self._activityId,
		self._stageId,
		self._curSelectTeamId
	})
	FireDimensionController.instance:showMissionView(self._activityId, self._stageId, self._curSelectTeamId)
end

function FireDimensionLevelView:_onClickCell(teamId, isForce)
	if not self._isPlayedAnim then
		self:_playAnim(teamId, isForce)

		return
	end

	if not FireDimensionModel.instance:isStageBaned(self._activityId, self._stageId) then
		if #self._curBanedTeamIdList < self._maxBanNum then
			if TableUtil.isHad(self._curBanedTeamIdList, teamId) then
				table.removebyvalue(self._curBanedTeamIdList, teamId)

				local cell = self._cellList[teamId]

				if cell then
					goutil.setActive(cell.ban, false)
				end
			else
				table.insert(self._curBanedTeamIdList, teamId)

				local cell = self._cellList[teamId]

				if cell then
					goutil.setActive(cell.ban, true)
				end
			end
		elseif TableUtil.isHad(self._curBanedTeamIdList, teamId) then
			table.removebyvalue(self._curBanedTeamIdList, teamId)

			local cell = self._cellList[teamId]

			if cell then
				goutil.setActive(cell.ban, false)
			end
		end
	end

	local oldTeamId = self._curSelectTeamId

	if isForce or oldTeamId ~= teamId then
		self._curSelectTeamId = teamId

		local oldCell = self._cellList[oldTeamId]
		local newCell = self._cellList[teamId]

		if oldCell then
			goutil.setActive(oldCell.select, false)
		end

		if newCell then
			goutil.setActive(newCell.select, true)
		end

		self:_updateShowFormation(self._curSelectTeamId)
		self:_updateBuffTxt(self._curSelectTeamId)
	end

	self:_updateTxtCommit()
	self:_updateLevelBtns()
end

function FireDimensionLevelView:_onFireDimensionClgBanRes()
	self._curSelectTeamId = 0

	self:_showEmptyFormation()
	self:_updateLevels()
	self:_updateLevelBtns()
	self:_updateTxtCommit()
	self:_updateTxtLevel()
	self:_updateBuffTxt(self._curSelectTeamId)
end

function FireDimensionLevelView:_onResetRes()
	table.clear(self._curBanedTeamIdList)
	self:_updateLevels()
	self:_updateLevelBtns()
	self:_updateTxtCommit()
	self:_updateTxtLevel()
	self:_updateBuffTxt(self._curSelectTeamId)
end

function FireDimensionLevelView:_showTitle()
	self._txtTitle.text = self._cfgStage.stageName
end

function FireDimensionLevelView:_showActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function FireDimensionLevelView:_initLevelHeadIcons()
	for i, v in ipairs(self._cellList) do
		local teamId = i
		local cfgTeam = FireDimensionConfig.instance:getSmallStageCfg(self._activityId, self._stageId, teamId)

		if cfgTeam then
			local cfgMonster = FireDimensionConfig.instance:getMonsterCfg(cfgTeam.creepsMasterId)

			MaterialMgr.setIcon(v.con, MatType.PET_SKIN, cfgMonster.showFaceId)
		end
	end
end

function FireDimensionLevelView:_clearLevelHeadIcons()
	for i, v in ipairs(self._cellList) do
		MaterialMgr.clearIcon(v.con)
	end
end

function FireDimensionLevelView:_updateLevels()
	for i, v in ipairs(self._cellList) do
		local teamId = i
		local isBan = FireDimensionModel.instance:isTeamBaned(self._activityId, self._stageId, teamId)
		local isPass = FireDimensionModel.instance:isTeamPassed(self._activityId, self._stageId, teamId)

		goutil.setActive(v.select, i == self._curSelectTeamId)
		goutil.setActive(v.ban, isBan)
		goutil.setActive(v.pass, isPass)
	end

	self:_updateRewardTxt()
end

function FireDimensionLevelView:_updateLevelBtns()
	local isBaned = FireDimensionModel.instance:isStageBaned(self._activityId, self._stageId)
	local isBanedTeam = FireDimensionModel.instance:isTeamBaned(self._activityId, self._stageId, self._curSelectTeamId)
	local isPassed = FireDimensionModel.instance:isTeamPassed(self._activityId, self._stageId, self._curSelectTeamId)
	local isShowChallenge = isBaned and self._curSelectTeamId > 0 and not isPassed and not isBanedTeam

	goutil.setActive(self._btnCommit.gameObject, not isBaned)
	goutil.setActive(self._btnReset.gameObject, isBaned)
	goutil.setActive(self._btnChallenge.gameObject, isShowChallenge)
	goutil.setActive(self._rewardGo, isShowChallenge and not self._isAoqiGodProcessType)
end

function FireDimensionLevelView:_updateRewardTxt()
	local passNum = FireDimensionModel.instance:getPassNum(self._activityId, self._stageId)
	local cfgNum = passNum + 1
	local cfgPrize = FireDimensionConfig.instance:getBigStagePrizeCfg(self._activityId, self._stageId, cfgNum)

	if cfgPrize and not self._isAoqiGodProcessType then
		local matType, id, num = MaterialMgr.getMatParams(cfgPrize.prize)
		local txt = string.format("奖励：%d <quad name=%d:%d|icon size=28 width=1 offsetY=-8/>", num, matType, id)

		if self._txtReward.text ~= txt then
			self._txtReward.text = txt
		end
	else
		self._txtReward.text = ""
	end
end

function FireDimensionLevelView:_updateBuffTxt(teamId)
	local txt = ""
	local cfgTeam = FireDimensionConfig.instance:getSmallStageCfg(self._activityId, self._stageId, teamId)

	if cfgTeam then
		local cfgBuff = FireDimensionConfig.instance:getBuffCfg(cfgTeam.buffId)

		if cfgBuff then
			txt = string.format("敌阵效果：\n%s", cfgBuff.desc)
		end

		if not FireDimensionModel.instance:isTeamBaned(self._activityId, self._stageId, teamId) then
			local banTeamIds = FireDimensionModel.instance:getBanedList(self._activityId, self._stageId)

			for i, v in ipairs(banTeamIds) do
				local cfg = FireDimensionConfig.instance:getSmallStageCfg(self._activityId, self._stageId, v)

				if cfg then
					local cfgBuff = FireDimensionConfig.instance:getBuffCfg(cfg.buffId)

					txt = txt .. "\n" .. cfgBuff.desc
				end
			end
		end

		self._txtBuff.text = txt
	else
		self._txtBuff.text = "敌阵效果："
	end

	self._buffScrollRect.verticalNormalizedPosition = 1
end

function FireDimensionLevelView:_updateTxtCommit()
	local isBaned = FireDimensionModel.instance:isStageBaned(self._activityId, self._stageId)
	local isShowCommitBtn = not isBaned
	local isSelectFinish = #self._curBanedTeamIdList == self._maxBanNum
	local isDefaultTxt = isShowCommitBtn and isSelectFinish

	self._txtCommit.fontSize = isDefaultTxt and 28 or 24
	self._txtCommit.text = isDefaultTxt and "确 定" or string.format("请选择%d个阵容", self._maxBanNum)
end

function FireDimensionLevelView:_updateTxtLevel()
	local isBaned = FireDimensionModel.instance:isStageBaned(self._activityId, self._stageId)
	local matType, id, num = MaterialMgr.getMatParams(self._cfgStage.prize)

	self._txtLevel.text = not self._isAoqiGodProcessType and (isBaned and string.format("击败剩余阵容即可通关。\n通过可获得：%d <quad name=%d:%d|icon size=28 width=1 offsetY=-8/>", num, matType, id) or string.format("在银甲火次协助下，可随意眩晕\n下列%d个阵容", self._maxBanNum)) or isBaned and string.format("击败剩余阵容即可通关。") or string.format("在银甲火次协助下，可随意眩晕\n下列%d个阵容", self._maxBanNum)
end

function FireDimensionLevelView:_updateShowFormation(teamId)
	local cfgTeam = FireDimensionConfig.instance:getSmallStageCfg(self._activityId, self._stageId, teamId)

	FireDimensionModel.instance:setFmt(cfgTeam.creepsMasterId)
	self:_initSelfFormation()
end

function FireDimensionLevelView:_showEmptyFormation()
	FireDimensionModel.instance:clearFmt()
	self:_initSelfFormation()
end

function FireDimensionLevelView:_initAnimState()
	self._isPlayedAnim = false

	goutil.setActive(self._Nego_Left, false)
	goutil.setActive(self._fmtGo, false)
	Framework.TransformUtil.SetAnchoredPos(self._levelsTrans, 0, 0)
end

function FireDimensionLevelView:_playAnim(teamId, isForce)
	self._isPlayedAnim = true

	local duration = 0.3

	self._tween = self._levelsTrans:DOAnchorPosX(-320, duration):OnComplete(function()
		goutil.setActive(self._Nego_Left, true)
		goutil.setActive(self._fmtGo, true)

		if teamId then
			self:_onClickCell(teamId, isForce)
		end
	end)
end

function FireDimensionLevelView:_clearAnim()
	if self._tween then
		self._tween:Kill()

		self._tween = nil
	end
end

function FireDimensionLevelView:_getEffectPath(stageId)
	if stageId == 1 then
		return FireDimensionLevelViewPresentor.Effect1
	elseif stageId == 2 then
		return FireDimensionLevelViewPresentor.Effect2
	else
		return FireDimensionLevelViewPresentor.Effect3
	end
end

function FireDimensionLevelView:_playEffect(stageId)
	self._eff = UIEffectManager.instance:playEffect(self, self:_getEffectPath(stageId), self.mainGO.transform, 0, 0, true)

	self._eff:setParent(self.mainGO.transform)
	self._eff:setLocalPos(0, 0, 0)
	self._eff:setScale(1)
end

function FireDimensionLevelView:_clearEffect()
	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end
end

function FireDimensionLevelView:_getCurFormId()
	return 0
end

function FireDimensionLevelView:_getCurFormation()
	return FireDimensionModel.instance:getFmt()
end

function FireDimensionLevelView:_OnDropSeat(_go, eventData)
	return
end

function FireDimensionLevelView:_OnBeginDragSeat(_go, eventData)
	return
end

function FireDimensionLevelView:_OnEndDragSeat(_go, eventData)
	return
end

function FireDimensionLevelView:_OnDragSeat(_go, eventData)
	return
end

function FireDimensionLevelView:_onEnterSeat(_go, eventData)
	return
end

function FireDimensionLevelView:_onExitSeat(_go, eventData)
	return
end

function FireDimensionLevelView:_saveCurrFmt()
	return
end

function FireDimensionLevelView:_getPet(petId)
	return FireDimensionModel.instance:getPet(petId)
end

function FireDimensionLevelView:_getContractId(groupId, summonPetMo)
	return summonPetMo.contractSkillId
end

function FireDimensionLevelView:_playEffectOnChangeHeroSkillId(oldHeroSkillId, newHeroSkillId)
	return
end

function FireDimensionLevelView:_setPsychicedSkill(id)
	return
end

return FireDimensionLevelView
