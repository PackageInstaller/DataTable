-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/ExpeditionFmtLeftView.lua

module("logic.extensions.formation.view.ExpeditionFmtLeftView", package.seeall)

local ExpeditionFmtLeftView = class("ExpeditionFmtLeftView", FormationLeftView)

function ExpeditionFmtLeftView:onEnter()
	ExpeditionFmtLeftView.super.onEnter(self)
	self._Btn_Formation:SetActive(false)

	self._Btn_BuffForm.transform.localPosition = self._Btn_Formation.transform.localPosition
end

function ExpeditionFmtLeftView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	ExpeditionFastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	MissionModel.instance:setForceResetOneKey(false)
end

function ExpeditionFmtLeftView:_onClickClean()
	printInfo("_onClickClean")
	ExpeditionFastFormation.instance:clean()
end

function ExpeditionFmtLeftView:_SetFormationNameAndIcon(id)
	local index = self:_getCurrTeamId()
	local team = FormationNewModel.instance:GetTeam(index)

	self._TxtC_Formation.text = team:getTabName()
end

function ExpeditionFmtLeftView:_updateStartOrder()
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

function ExpeditionFmtLeftView:_isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	local petStateData = ExpeditionModel.instance:getPetState(petId)

	return not ((petStateData or nil) and petStateData.hpRate <= 0)
end

function ExpeditionFmtLeftView:_getCurFormId()
	return ExpeditionFmtModel.instance:getCurFormationId()
end

function ExpeditionFmtLeftView:_getCurFormation()
	return ExpeditionFmtModel.instance:getFormation()
end

function ExpeditionFmtLeftView:_changePosition(pos, value)
	ExpeditionFmtLeftView.super._changePosition(self, pos, value)
end

function ExpeditionFmtLeftView:_getPetsHeroSkills()
	return ExpeditionFmtModel.instance:getFormPetsHeroSkills()
end

function ExpeditionFmtLeftView:_getHeroSkillId()
	return ExpeditionFmtModel.instance:getHeroSkillId()
end

function ExpeditionFmtLeftView:_changeHeroSkillId(id)
	ExpeditionFmtModel.instance:changeSkillId(id)
end

function ExpeditionFmtLeftView:_getPet(id)
	return ExpeditionFmtModel.instance:getPet(id)
end

function ExpeditionFmtLeftView:_changeTeamId(id)
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

	ExpeditionFmtModel.instance:setTeamId(id)
	GlobalDispatcher:dispatch(GlobalNotify.TeamChanged)
end

function ExpeditionFmtLeftView:_getCurrTeamId()
	return ExpeditionFmtModel.instance:getTeamId()
end

function ExpeditionFmtLeftView:_saveCurrFmt()
	ExpeditionFmtModel.instance:onViewClose()
end

function ExpeditionFmtLeftView:_getItemSeatCls()
	return ExpeditionItemSeat
end

return ExpeditionFmtLeftView
