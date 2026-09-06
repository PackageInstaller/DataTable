-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummonTowerFmtLeftView.lua

module("logic.extensions.formation.view.SummonTowerFmtLeftView", package.seeall)

local SummonTowerFmtLeftView = class("SummonTowerFmtLeftView", FormationLeftView)

function SummonTowerFmtLeftView:onEnter()
	SummonTowerFmtLeftView.super.onEnter(self)
	self:setBtnContractActive(false)
	self._Btn_Formation:SetActive(false)

	self._Btn_BuffForm.transform.localPosition = self._Btn_Formation.transform.localPosition

	self:setBtnCutePetActive(false)
	self:_setActiveBtnFormationUse(false)
end

function SummonTowerFmtLeftView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	SummontowerFastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	MissionModel.instance:setForceResetOneKey(false)
end

function SummonTowerFmtLeftView:_onClickClean()
	printInfo("_onClickClean")
	SummontowerFastFormation.instance:clean()
end

function SummonTowerFmtLeftView:_SetFormationNameAndIcon(id)
	local index = self:_getCurrTeamId()
	local team = FormationNewModel.instance:GetTeam(index)

	self._TxtC_Formation.text = team:getTabName()
end

function SummonTowerFmtLeftView:_updateStartOrder()
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

function SummonTowerFmtLeftView:_OnClickBtnBuffForm()
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(96)

	if not isOpen then
		local cfgFuncOpen = FuncOpenConfig.instance:getFunctionOpenById(96)

		if cfgFuncOpen then
			FloatWordMgr.instance:show(cfgFuncOpen.description)
		end

		return
	end

	local curPetNumber = self:_getCurFormation():getCurExistPetNumber()

	UIStateManager.instance:push(ViewName.FormationactivetipView, self._CurFormId or 0, curPetNumber, false, true)
end

function SummonTowerFmtLeftView:_getContractSkillEffectPath(summonId, masterId)
	return ""
end

function SummonTowerFmtLeftView:_getCurFormId()
	return SummontowerFmtModel.instance:getCurFormationId()
end

function SummonTowerFmtLeftView:_getCurFormation()
	return SummontowerFmtModel.instance:getFormation()
end

function SummonTowerFmtLeftView:_changePosition(pos, value)
	self:_getCurFormation():SetPosition(pos, value)
end

function SummonTowerFmtLeftView:_getPetsHeroSkills()
	return SummontowerFmtModel.instance:getFormPetsHeroSkills()
end

function SummonTowerFmtLeftView:_getHeroSkillId()
	return SummontowerFmtModel.instance:getHeroSkillId()
end

function SummonTowerFmtLeftView:_changeHeroSkillId(id)
	SummontowerFmtModel.instance:changeSkillId(id)
end

function SummonTowerFmtLeftView:_getPet(id)
	return SummontowerPetsModel.instance:getPet(id)
end

function SummonTowerFmtLeftView:_changeTeamId(id)
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

	SummontowerFmtModel.instance:setTeamId(id)
	GlobalDispatcher:dispatch(GlobalNotify.TeamChanged)
end

function SummonTowerFmtLeftView:getCurAllFormStrengthInfo()
	local fsMap = {}

	for i = 1, 8 do
		local _maxlv = BattleConfig.instance:getFormStrengthMaxLv(i)

		fsMap[i] = {
			formStrengthId = i,
			formStrengthLv = _maxlv
		}
	end

	return fsMap
end

function SummonTowerFmtLeftView:_getCurrTeamId()
	return SummontowerFmtModel.instance:getTeamId()
end

function SummonTowerFmtLeftView:_saveCurrFmt()
	SummontowerFmtModel.instance:onViewClose()
end

function SummonTowerFmtLeftView:_setPositionForce(positions, forceDispatch)
	return self._getCurFormation():setPositionForce(positions, forceDispatch)
end

function SummonTowerFmtLeftView:getIsBoundUseBagPet()
	return false
end

function SummonTowerFmtLeftView:_getItemSeatCls()
	return SummontowerItemSeat
end

return SummonTowerFmtLeftView
