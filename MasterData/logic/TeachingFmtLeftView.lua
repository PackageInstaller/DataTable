-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TeachingFmtLeftView.lua

module("logic.extensions.teachingdungeon.view.TeachingFmtLeftView", package.seeall)

local TeachingFmtLeftView = class("TeachingFmtLeftView", FormationLeftView)

function TeachingFmtLeftView:onEnter()
	TeachingFmtLeftView.super.onEnter(self)
	GameUtil.SetActive(self._Btn_Formation, false)
	self:setBtnFormActive(false)
	self:setBtnCutePetActive(false)
	self:_setActiveBtnFormationUse(false)
	ViewMgr.instance:openAt(self:getGo("Nego_Left/Nego_Select"), ViewName.TeachleveltipView, self._viewPresentor)
end

function TeachingFmtLeftView:onExit()
	self:_onExitUnbindingEvent()
	TeachingDungeonModel.instance:onViewClose()
end

function TeachingFmtLeftView:_onClickClean()
	TeachingFastFormation.instance:clean()
end

function TeachingFmtLeftView:_SetFormationNameAndIcon(id)
	local index = self:_getCurrTeamId()
	local team = FormationNewModel.instance:GetTeam(index)

	self._TxtC_Formation.text = team:getTabName()
end

function TeachingFmtLeftView:_updateStartOrder()
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

function TeachingFmtLeftView:_getCurFormId()
	return TeachingDungeonModel.instance:getCurFormationId()
end

function TeachingFmtLeftView:_getCurFormation()
	return TeachingDungeonModel.instance:getFormation()
end

function TeachingFmtLeftView:_changePosition(pos, value)
	self:_getCurFormation():SetPosition(pos, value)
end

function TeachingFmtLeftView:_getPetsHeroSkills()
	return TeachingDungeonModel.instance:getFormPetsHeroSkills()
end

function TeachingFmtLeftView:_getHeroSkillId()
	return TeachingDungeonModel.instance:getHeroSkillId()
end

function TeachingFmtLeftView:_changeHeroSkillId(id)
	TeachingDungeonModel.instance:changeSkillId(id)
end

function TeachingFmtLeftView:_getPet(id)
	return TeachingDungeonModel.instance:getPet(id)
end

function TeachingFmtLeftView:_changeTeamId(id)
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

	TeachingDungeonModel.instance:setTeamId(id)
	GlobalDispatcher:dispatch(GlobalNotify.TeamChanged)
end

function TeachingFmtLeftView:_getCurrTeamId()
	return TeachingDungeonModel.instance:getTeamId()
end

function TeachingFmtLeftView:_getItemSeatCls()
	return TeachingItemSeat
end

function TeachingFmtLeftView:_OnBeginDragSeat(go, eventData)
	TeachingFmtLeftView.super._OnBeginDragSeat(self, go, eventData)

	local ItemSeatCls = self:_getItemSeatCls()
	local itemSeat = ItemSeatCls.Get(go)

	if not itemSeat then
		return
	end

	GlobalDispatcher:dispatch(TeachingDungeonModel.OnBeginDrag, itemSeat._posId)
end

function TeachingFmtLeftView:_getPet(petId)
	return (TeachingDungeonModel.instance:getPet(petId))
end

function TeachingFmtLeftView:GetFormStrengthIdAndLv()
	return 0, 0
end

function TeachingFmtLeftView:_showFormationActive()
	removetimer(self._playFormationAni, self)
end

return TeachingFmtLeftView
