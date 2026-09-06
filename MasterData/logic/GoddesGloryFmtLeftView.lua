-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddesGloryFmtLeftView.lua

module("logic.extensions.goddessglory.view.GoddesGloryFmtLeftView", package.seeall)

local GoddesGloryFmtLeftView = class("GoddesGloryFmtLeftView", FormationLeftView)

function GoddesGloryFmtLeftView:onEnter()
	self._challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
	self._stageId = GoddessGloryModel.instance:getCurStageId()

	GoddesGloryFmtLeftView.super.onEnter(self)
	self._Btn_ContractPet.gameObject:SetActive(false)
	self._Btn_Formation:SetActive(false)

	self._Btn_BuffForm.transform.localPosition = self._Btn_Formation.transform.localPosition

	self:setBtnCutePetActive(false)
	self:_setActiveBtnFormationUse(false)
end

function GoddesGloryFmtLeftView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	GoddesGloryFastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	MissionModel.instance:setForceResetOneKey(false)
end

function GoddesGloryFmtLeftView:_onClickClean()
	printInfo("_onClickClean")
	GoddesGloryFastFormation.instance:clean()
end

function GoddesGloryFmtLeftView:_SetFormationNameAndIcon(id)
	local index = self:_getCurrTeamId()
	local team = FormationNewModel.instance:GetTeam(index)

	self._TxtC_Formation.text = team:getTabName()
end

function GoddesGloryFmtLeftView:_isExceedSpecifiedNumber()
	local curPetNumber = self:_getCurFormation():getCurExistPetNumber()
	local specificNumber = GoddessGloryFmtModel.instance:canFormCount(self._challengeId, self._stageId)

	return specificNumber <= curPetNumber
end

function GoddesGloryFmtLeftView:_showFailedTips()
	local content = langPara("最多上阵%d只精灵哦！", GoddessGloryFmtModel.instance:canFormCount(self._challengeId, self._stageId))

	FloatWordMgr.instance:show(content)
end

function GoddesGloryFmtLeftView:_getCurBonds(isGetPetIdList)
	local racesInCurFormation = {}
	local positions = self:_getCurFormation():GetPositions()
	local petIdList = {}

	for i, petId in ipairs(positions) do
		if petId > 0 then
			local mo = self:_getPet(petId)

			if mo then
				local raceId = mo.raceId

				table.insert(racesInCurFormation, raceId)
				table.insert(petIdList, petId)
			end
		end
	end

	if isGetPetIdList then
		return CharacterConfig.instance:getMatchBondCfgOnForm(racesInCurFormation, petIdList, false), petIdList
	end

	return CharacterConfig.instance:getMatchBondCfgOnForm(racesInCurFormation, petIdList, false)
end

function GoddesGloryFmtLeftView:_updateStartOrder()
	local isLeftFirst = MissionModel.instance:isLeftFirst()
	local enemyPoses = MissionModel.instance:getEnemyPetPoses()
	local selfPoses = {}
	local fmtPoses = self:_getCurFormation():GetPositions()

	for i, petId in ipairs(fmtPoses) do
		if petId > 0 then
			table.insert(selfPoses, i)
		end
	end

	self:_doUpdateStartOrder(isLeftFirst, selfPoses, enemyPoses)
end

function GoddesGloryFmtLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	return true
end

function GoddesGloryFmtLeftView:_getCurFormId()
	return GoddessGloryFmtModel.instance:getCurFormationId(self._challengeId, self._stageId)
end

function GoddesGloryFmtLeftView:_getCurFormation()
	return GoddessGloryFmtModel.instance:getFormation(self._challengeId, self._stageId)
end

function GoddesGloryFmtLeftView:_changePosition(pos, value)
	self:_getCurFormation():SetPosition(pos, value)
end

function GoddesGloryFmtLeftView:_getPetsHeroSkills()
	return GoddessGloryFmtModel.instance:getFormPetsHeroSkills(self._challengeId, self._stageId)
end

function GoddesGloryFmtLeftView:_getHeroSkillId()
	return GoddessGloryFmtModel.instance:getHeroSkillId(self._challengeId, self._stageId)
end

function GoddesGloryFmtLeftView:_changeHeroSkillId(id)
	GoddessGloryFmtModel.instance:changeSkillId(self._challengeId, self._stageId, id)
end

function GoddesGloryFmtLeftView:_getPet(id)
	return GoddessGloryPetsModel.instance:getPet(self._challengeId, self._stageId, id)
end

function GoddesGloryFmtLeftView:_changeTeamId(id)
	if id == self._getCurrTeamId() then
		return
	end

	local team = FormationNewModel.instance:GetTeam(id)
	local formation = team:GetCurFormation()
	local positions = formation:GetPositions()
	local currFmt = self:_getCurFormation()

	for i = 1, #positions do
		currFmt:SetPosition(i, positions[i])
	end

	GoddessGloryFmtModel.instance:setTeamId(id)
	GlobalDispatcher:dispatch(GlobalNotify.TeamChanged)
end

function GoddesGloryFmtLeftView:_getCurrTeamId()
	return GoddessGloryFmtModel.instance:getTeamId()
end

function GoddesGloryFmtLeftView:_saveCurrFmt()
	GoddessGloryFmtModel.instance:onViewClose(self._challengeId, self._stageId)
end

function GoddesGloryFmtLeftView:_setPositionForce(positions, forceDispatch)
	return self:_getCurFormation():setPositionForce(positions, forceDispatch)
end

function GoddesGloryFmtLeftView:_getItemSeatCls()
	return GoddesGloryItemSeat
end

return GoddesGloryFmtLeftView
