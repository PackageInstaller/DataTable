-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/SccopyFmtLeftView.lua

module("logic.extensions.scenariocopy.view.SccopyFmtLeftView", package.seeall)

local SccopyFmtLeftView = class("SccopyFmtLeftView", FormationLeftView)

function SccopyFmtLeftView:ctor()
	SccopyFmtLeftView.super.ctor(self)

	self.suppportCfgs = nil
end

function SccopyFmtLeftView:buildUI()
	SccopyFmtLeftView.super.buildUI(self)
end

function SccopyFmtLeftView:onEnter()
	SccopyFmtLeftView.super.onEnter(self)
	GameUtil.SetActive(self._Btn_Formation, false)
	self:_setActiveBtnFormationUse(false)

	self.suppportCfgs = ScenariocopyModel.instance:getSupportCfgs()

	if self.suppportCfgs then
		local fixedPos = {}

		for k, v in pairs(self.suppportCfgs) do
			if v.isFixedPos == true then
				table.insert(fixedPos, v.posId)
			end
		end

		self:_setFixedPos(fixedPos)
	end
end

function SccopyFmtLeftView:onExit()
	SccopyFmtLeftView.super.onExit(self)
end

function SccopyFmtLeftView:_onClickClean()
	ScenariocopyFastFormation.instance:clean()
end

function SccopyFmtLeftView:_getCurFormId()
	return ScenariocopyModel.instance:getCurFormationId()
end

function SccopyFmtLeftView:_getCurFormation()
	return ScenariocopyModel.instance:getFormation()
end

function SccopyFmtLeftView:_changePosition(pos, value)
	self:_getCurFormation():SetPosition(pos, value)
end

function SccopyFmtLeftView:_getPetsHeroSkills()
	return ScenariocopyModel.instance:getFormPetsHeroSkills()
end

function SccopyFmtLeftView:_getHeroSkillId()
	return ScenariocopyModel.instance:getHeroSkillId()
end

function SccopyFmtLeftView:_changeHeroSkillId(id)
	ScenariocopyModel.instance:changeSkillId(id)
end

function SccopyFmtLeftView:_getPet(id)
	return ScenariocopyModel.instance:getPet(id)
end

function SccopyFmtLeftView:_changeTeamId(id)
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

	ScenariocopyModel.instance:setTeamId(id)
	GlobalDispatcher:dispatch(GlobalNotify.TeamChanged)
end

function SccopyFmtLeftView:_getCurrTeamId()
	return ScenariocopyModel.instance:getTeamId()
end

function SccopyFmtLeftView:_saveCurrFmt()
	return
end

function SccopyFmtLeftView:_getItemSeatCls()
	return SccopyItemSeat
end

function SccopyFmtLeftView:_OnBeginDragSeat(go, eventData)
	local ItemSeatCls = self:_getItemSeatCls()
	local itemSeat = ItemSeatCls.Get(go)

	if not itemSeat then
		return
	end

	local pos = itemSeat:GetPosition()

	if self:_isFixedPos(pos) then
		return
	end

	self:_SetSeatHightLight(itemSeat:IsOpen(), true)
	SccopyFmtLeftView.super._OnBeginDragSeat(self, go, eventData)
end

return SccopyFmtLeftView
