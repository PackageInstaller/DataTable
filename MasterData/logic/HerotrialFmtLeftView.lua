-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialFmtLeftView.lua

module("logic.extensions.herotrial.view.HerotrialFmtLeftView", package.seeall)

local HerotrialFmtLeftView = class("HerotrialFmtLeftView", FormationLeftView)

function HerotrialFmtLeftView:ctor()
	HerotrialFmtLeftView.super.ctor(self)
end

function HerotrialFmtLeftView:buildUI()
	HerotrialFmtLeftView.super.buildUI(self)
end

function HerotrialFmtLeftView:onEnter()
	HerotrialFmtLeftView.super.onEnter(self)
	GameUtil.SetActive(self._Btn_Formation, false)
	self:_setActiveBtnFormationUse(false)
	self:setBtnFormActive(false)

	local fixedPos = {
		2
	}

	self:_setFixedPos(fixedPos)
	ViewMgr.instance:openAt(self:getGo("Nego_Left/SelectView/Viewport/Content/Nego_Select"), ViewName.HerotrialtipView, self._viewPresentor)
	ViewMgr.instance:openAt(self:getGo("lefttop"), ViewName.HerotrialverifybtnView, self._viewPresentor)
	GlobalDispatcher:addListener(GlobalNotify.HeroTrialGetInfo, self._OnFormationChanged, self)
end

function HerotrialFmtLeftView:onExit()
	self:_onExitUnbindingEvent()
	HerotrialModel.instance:saveCurrFormation()
	GlobalDispatcher:removeListener(GlobalNotify.HeroTrialGetInfo, self._OnFormationChanged, self)
end

function HerotrialFmtLeftView:_onClickClean()
	return
end

function HerotrialFmtLeftView:_SetFormationNameAndIcon(id)
	local index = self:_getCurrTeamId()
	local team = FormationNewModel.instance:GetTeam(index)

	self._TxtC_Formation.text = team:getTabName()
end

function HerotrialFmtLeftView:_updateStartOrder()
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

function HerotrialFmtLeftView:_SetHeroSkill(id)
	self._heroSkillIcon:SetActive(true)
	self._Btn_HeroSkill:ChangeStateNow(0)

	local heroSkillId = self:_getHeroSkillId()

	self:_setSkillBtnName(heroSkillId)
	self:_changeHeroSkillId(heroSkillId)
	self:_setHeroSkillEffect(heroSkillId)
end

function HerotrialFmtLeftView:_getCurFormId()
	return HerotrialModel.instance:getCurFormationId()
end

function HerotrialFmtLeftView:_getCurFormation()
	return HerotrialModel.instance:getFormation()
end

function HerotrialFmtLeftView:_changePosition(pos, value)
	self:_getCurFormation():SetPosition(pos, value)
end

function HerotrialFmtLeftView:_getPetsHeroSkills()
	return HerotrialModel.instance:getFormPetsHeroSkills()
end

function HerotrialFmtLeftView:_getHeroSkillId()
	return HerotrialModel.instance:getHeroSkillId()
end

function HerotrialFmtLeftView:_changeHeroSkillId(id)
	return
end

function HerotrialFmtLeftView:_getPet(id)
	return HerotrialModel.instance:getPet(id)
end

function HerotrialFmtLeftView:_saveCurrFmt()
	HerotrialModel.instance:saveCurrFormation()
end

function HerotrialFmtLeftView:_getItemSeatCls()
	return HerotrialItemSeat
end

function HerotrialFmtLeftView:_OnBeginDragSeat(go, eventData)
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
	local creepId = HerotrialModel.instance:getCreepsId()

	if petId == creepId then
		return
	end

	HerotrialFmtLeftView.super._OnBeginDragSeat(self, go, eventData)
end

return HerotrialFmtLeftView
