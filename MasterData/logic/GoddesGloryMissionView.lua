-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddesGloryMissionView.lua

module(..., package.seeall)

local GoddesGloryMissionView = class("GoddesGloryMissionView", MissionView)

function GoddesGloryMissionView:buildUI()
	GoddesGloryMissionView.super.buildUI(self)

	local pefabs = self._viewPresentor:getPrefab(GoddesGloryMissionViewPresentor.missionRes)

	if pefabs then
		local missionView = goutil.clone(pefabs)

		if missionView then
			missionView.transform:SetParent(self.mainGO.transform, false)

			self._canFormat = goutil.findChildTextComponent(missionView, "bottom/canFormatNum")
		end
	end
end

function GoddesGloryMissionView:onEnter()
	self:onEnterInherit()

	self._challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
	self._stageId = GoddessGloryModel.instance:getCurStageId()

	GoddessGloryFmtModel.instance:checkFormationValid(self._challengeId, self._stageId)
	GoddesGloryFastFormation.instance:setCurrChallengeId(self._challengeId, self._stageId)
	self:_setMaskBlock(false)

	self._fmtChanged = false
	self._loader, self._lastCallBack, self._mdlObj = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._mdlObj)

	self._videoButton.gameObject:SetActive(false)
	self:_setMissionCfgInfo()
	self:_onSpClassLoad()

	if self._canFormat then
		self._canFormat.text = string.format("当前可上阵<color=#ff0000>%s</color>只精灵", GoddessGloryFmtModel.instance:canFormCount(self._challengeId, self._stageId))
	end

	MissionModel.instance:setForceResetOneKey(true)
end

function GoddesGloryMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	GoddesGloryFastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), nil, function(posList, petPool)
		local needPets = GoddesGloryFastFormation.instance.needPets
		local canFormatNum = GoddessGloryFmtModel.instance:canFormCount(self._challengeId, self._stageId)
		local count = canFormatNum - table.nums(petPool)
		local tem = {}

		for i, petMo in ipairs(needPets) do
			local isHas = false

			for k, v in pairs(petPool) do
				if v.petId == petMo.petId then
					isHas = true

					break
				end
			end

			if isHas == false then
				table.insert(tem, petMo)

				count = count - 1

				if count <= 0 then
					break
				end
			end
		end

		count = canFormatNum - table.nums(petPool)

		for i = 1, 9 do
			if count <= 0 then
				break
			end

			if table.indexof(posList, i) == false then
				table.insert(posList, i)
			end

			if petPool[i] == nil and #tem > 0 then
				petPool[i] = table.remove(tem, 1)
				count = count - 1
			end
		end

		return posList, petPool
	end)
	MissionModel.instance:setForceResetOneKey(false)
end

function GoddesGloryMissionView:_onClickClean()
	printInfo("_onClickClean")
	GoddesGloryFastFormation.instance:clean()
end

function GoddesGloryMissionView:_onClickStart()
	local hasOneKey = GameUtil.GetActive(self._btnOneKey)

	if GoddessGloryFmtModel.instance:isCurFormationEmpty(self._challengeId, self._stageId) then
		if hasOneKey then
			TipsFacade.instance:openPopupWindow(lang("tip"), lang("fight_unformation"), function()
				return
			end, function()
				self:_onClickOneKey()
			end, lang("fight_goto_fmt"), lang("一键布阵"))
		else
			TipsFacade.instance:openPopupWindow(lang("tip"), lang("fight_unformation"), function()
				return
			end, nil, lang("fight_goto_fmt"))
		end

		return
	end

	if self:_checkFormationPosNumber(function()
		self:_startClg()
	end) then
		return
	end

	self:_startClg()
end

function GoddesGloryMissionView:_checkFormationPosNumber(posLimitCallback)
	local formation = GoddessGloryFmtModel.instance:getFormation(self._challengeId, self._stageId)
	local numPos = formation:getCurExistPetNumber()
	local totalPos = GoddessGloryFmtModel.instance:canFormCount(self._challengeId, self._stageId)
	local petsNum = GoddessGloryPetsModel.instance:getPetsCount(self._challengeId, self._stageId)

	if totalPos <= petsNum and numPos < totalPos then
		local hasOneKey = GameUtil.GetActive(self._btnOneKey)

		if hasOneKey then
			TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("fight_fmt_num"), tostring(totalPos)), posLimitCallback, function()
				self:_onClickOneKey()
			end, lang("确定"), lang("一键布阵"))
		else
			TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("fight_fmt_num"), tostring(totalPos)), posLimitCallback)
		end

		return true
	end
end

function GoddesGloryMissionView:_startClg()
	self:_setMaskBlock(true)
	GlobalDispatcher:addListener(GlobalNotify.FormationRefresh, self._startNow, self)
	GoddessGloryFmtModel.instance:saveCurrFormation(self._challengeId, self._stageId)
end

function GoddesGloryMissionView:_setMissionCfgInfo()
	local eventInfo = self._viewPresentor._openParam[1]
	local eventCo = GoddessGloryConfig.instance:getEventCo(eventInfo.eventId)
	local creepsCo = GoddessGloryConfig.instance:getMonsterCo(eventCo.creepsMasterId)
	local titleStr = ""
	local levelStr = creepsCo.name
	local ruleDesc = creepsCo.missionDesc

	self:_setDescStr(titleStr, levelStr, ruleDesc)
	self:_setTitleName()
end

function GoddesGloryMissionView:onEnterFinished()
	GoddesGloryMissionView.super.onEnterFinished(self)
end

function GoddesGloryMissionView:_setBattleResultTxtTitle()
	GoddesGloryMissionView.super._setBattleResultTxtTitle(self)
	BattleModel.instance:setBattleName(self:_getLevelStr())
end

function GoddesGloryMissionView:_getSpClassCo()
	return nil
end

function GoddesGloryMissionView:_enterBattle()
	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.MainUI, true)
	UIJumper.instance:pushOneStack(ViewName.GoddessGloryMainView, true, self._challengeId)
	UIJumper.instance:pushOneStack(ViewName.GoddessGloryStageView, true)

	local eventInfo = self._viewPresentor._openParam[1]

	BattleFacade.instance:startGoddesGlory(self._challengeId, self._stageId, eventInfo.eventId)
	GoddessGloryController.instance:requestGoddessGloryDoEvent(self._challengeId, self._stageId, eventInfo.instanceId)
end

return GoddesGloryMissionView
