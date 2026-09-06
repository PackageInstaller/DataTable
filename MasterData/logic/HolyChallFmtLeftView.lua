-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/holychallmission/HolyChallFmtLeftView.lua

module("logic.extensions.kingway.view.holychallmission.HolyChallFmtLeftView", package.seeall)

local HolyChallFmtLeftView = class("HolyChallFmtLeftView", FormationLeftView)

function HolyChallFmtLeftView:buildUI()
	HolyChallFmtLeftView.super.buildUI(self)
end

function HolyChallFmtLeftView:onEnter()
	HolyChallFmtLeftView.super.onEnter(self)
	self._Btn_Formation:SetActive(false)
	self:_setActiveBtnFormationUse(false)

	local creepId = HolyChallModel.instance:getCreepsId()
	local suppportCfg = HolyChallConfig.instance:getSupportCreep(creepId)

	self:_setFixedPos({
		suppportCfg.posId
	})
end

function HolyChallFmtLeftView:onExit()
	self:_onExitUnbindingEvent()
	self:_saveCurrFmt()
end

function HolyChallFmtLeftView:_OnClickBtnHeroSkill()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickSwitchHeroSkill)
	FloatWordMgr.instance:show(lang("当前挑战规则不可更改英雄技"))
end

function HolyChallFmtLeftView:_SetHeroSkill(id)
	self._heroSkillIcon:SetActive(true)
	self._Btn_HeroSkill:ChangeStateNow(0)
	self:_setSkillBtnName(410027)
	self:_changeHeroSkillId(410027)
	self:_setHeroSkillEffect(410027)
end

function HolyChallFmtLeftView:_onClickClean()
	HolyChallFastFormation.instance:clean()
end

function HolyChallFmtLeftView:_showFailedTips()
	FloatWordMgr.instance:show("最多上阵6只精灵哦！")
end

function HolyChallFmtLeftView:_getCurFormId()
	return HolyChallModel.instance:getCurFormationId()
end

function HolyChallFmtLeftView:_getCurFormation()
	return HolyChallModel.instance:getFormation()
end

function HolyChallFmtLeftView:_changePosition(pos, value)
	self:_getCurFormation():SetPosition(pos, value)
end

function HolyChallFmtLeftView:_setPositionForce(positions, forceDispatch)
	self:_getCurFormation():setPositionForce(positions, forceDispatch)
end

function HolyChallFmtLeftView:_getPetsHeroSkills()
	return HolyChallModel.instance:getFormPetsHeroSkills()
end

function HolyChallFmtLeftView:_getHeroSkillId()
	return HolyChallModel.instance:getHeroSkillId()
end

function HolyChallFmtLeftView:_changeHeroSkillId(id)
	HolyChallModel.instance:changeSkillId(id)
end

function HolyChallFmtLeftView:_getPet(id)
	return HolyChallModel.instance:getPet(id)
end

function HolyChallFmtLeftView:_changeTeamId(id)
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

	HolyChallModel.instance:setTeamId(id)
	GlobalDispatcher:dispatch(GlobalNotify.TeamChanged)
end

function HolyChallFmtLeftView:_getCurrTeamId()
	return HolyChallModel.instance:getTeamId()
end

function HolyChallFmtLeftView:_saveCurrFmt()
	HolyChallModel.instance:saveCurrFormation()
end

function HolyChallFmtLeftView:_getItemSeatCls()
	return HolyChallItemSeat
end

function HolyChallFmtLeftView:_OnBeginDragSeat(go, eventData)
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

	local petId = itemSeat:GetData()
	local creepId = HolyChallModel.instance:getCreepsId()

	if petId == creepId then
		return
	end

	HolyChallFmtLeftView.super._OnBeginDragSeat(self, go, eventData)
end

return HolyChallFmtLeftView
