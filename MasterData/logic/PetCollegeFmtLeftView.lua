-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/view/PetCollegeFmtLeftView.lua

module("logic.extensions.petcollege.view.PetCollegeFmtLeftView", package.seeall)

local PetCollegeFmtLeftView = class("PetCollegeFmtLeftView", FormationLeftView)

function PetCollegeFmtLeftView:onEnter()
	self._isFirstEnter = true

	PetCollegeFmtLeftView.super.onEnter(self)
	GameUtil.SetActive(self._Btn_Formation, false)
	self:setBtnFormActive(false)
	self:setBtnCutePetActive(false)
	self:_setActiveBtnFormationUse(false)
end

function PetCollegeFmtLeftView:onExit()
	self._isFirstEnter = false

	self:_onExitUnbindingEvent()
end

function PetCollegeFmtLeftView:_SetFormationNameAndIcon(id)
	local index = self:_getCurrTeamId()
	local team = FormationNewModel.instance:GetTeam(index)

	self._TxtC_Formation.text = team:getTabName()
end

function PetCollegeFmtLeftView:_updateStartOrder()
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

function PetCollegeFmtLeftView:_getCurFormId()
	return PetCollegeModel.instance:getCurFormationId()
end

function PetCollegeFmtLeftView:_getCurFormation()
	return PetCollegeModel.instance:getFormation()
end

function PetCollegeFmtLeftView:_changePosition(pos, value)
	self:_getCurFormation():SetPosition(pos, value)
end

function PetCollegeFmtLeftView:_changeHeroSkillId(id)
	PetCollegeModel.instance:changeSkillId(id)
end

function PetCollegeFmtLeftView:_getPet(id)
	return PetCollegeModel.instance:getPet(id)
end

function PetCollegeFmtLeftView:_getCurrTeamId()
	return PetCollegeModel.instance:getTeamId()
end

function PetCollegeFmtLeftView:_getItemSeatCls()
	return PetCollegeItemSeat
end

function PetCollegeFmtLeftView:_getPet(petId)
	return (PetCollegeModel.instance:getPet(petId))
end

return PetCollegeFmtLeftView
