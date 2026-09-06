-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/SeniorBuzhenLeftView.lua

module("logic.extensions.formation.view.SeniorBuzhenLeftView", package.seeall)

local SeniorBuzhenLeftView = class("SeniorBuzhenLeftView", BuzhenLeftView)

function SeniorBuzhenLeftView:onEnter()
	SeniorBuzhenLeftView.super.onEnter(self)
	self:_setActiveBtnFormation(false)
	SeniorArenaController.instance:setCanClickNext(true)
	GlobalDispatcher:addListener(GlobalNotify.FormationPet_POS_FINISH, self.onAllPetSetFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.CurFormTabChange, self._updateMyForms, self)
end

function SeniorBuzhenLeftView:onExit()
	SeniorBuzhenLeftView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CurFormTabChange, self._updateMyForms, self)
	SeniorArenaController.instance:setCanClickNext(true)
	GlobalDispatcher:removeListener(GlobalNotify.FormationPet_POS_FINISH, self.onAllPetSetFinish, self)
end

function SeniorBuzhenLeftView:_onClickOneKey()
	print("click oneKey")
	SeniorArenaController.instance:setCanClickNext(false)
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), function(petMo)
		if SeniorArenaController.instance:isInOtherTab(petMo.petId) then
			return false
		else
			return true
		end
	end)
	MissionModel.instance:setForceResetOneKey(false)
end

function SeniorBuzhenLeftView:onAllPetSetFinish()
	SeniorArenaController.instance:setCanClickNext(true)
end

function SeniorBuzhenLeftView:_updateMyForms()
	print("seniorbuzhen update leftView")
	MissionModel.instance:setForceResetOneKey(true)

	local curTab = SeniorArenaController.instance:getCurFormTab()
	local form = SeniorArenaController.instance:getCacheForm(curTab)
	local pos

	if form == nil then
		pos = {}

		for i = 1, 9 do
			table.insert(pos, 0)
		end
	else
		pos = form.pos
	end

	local _curMasterId = checknumber(form.elementalMasterId)
	local _targetId = checknumber(form.elementalTargetId)
	local fmo = self:_getCurFormation()

	fmo:SetElementalMasterId(_curMasterId)
	fmo:SetElementalTargetId(_targetId)

	local _cutePetId = checknumber(form.cutePetId)
	local _cutePetRaceId = checknumber(form.cutePetRaceId)
	local _cutePetQuality = checknumber(form.cutePetQuality)

	fmo:SetCutePetId(_cutePetId)
	fmo:SetCutePetRaceId(_cutePetRaceId)
	fmo:SetCutePetQuality(_cutePetQuality)
	self:_isShowNewActBonds(false)
	self:_setPositionForce(pos, true)
	self:_RefreshView(nil, nil, true)
	self:_isShowNewActBonds(true)
end

function SeniorBuzhenLeftView:_getHeroSkillId()
	local curTab = SeniorArenaController.instance:getCurFormTab()
	local form = SeniorArenaController.instance:getCacheForm(curTab)

	return form.heroSkillId
end

function SeniorBuzhenLeftView:_changeHeroSkillId(id)
	local curTab = SeniorArenaController.instance:getCurFormTab()
	local form = SeniorArenaController.instance:getCacheForm(curTab)

	form.heroSkillId = id

	SeniorBuzhenLeftView.super._changeHeroSkillId(self, id)
end

function SeniorBuzhenLeftView:_setPsychicedSkill(id)
	id = self:_checkPsychicedSkill(id)

	local curTab = SeniorArenaController.instance:getCurFormTab()
	local form = SeniorArenaController.instance:getCacheForm(curTab)

	form.psychicSkillId = id

	SeniorBuzhenLeftView.super._setPsychicedSkill(self, id)
end

function SeniorBuzhenLeftView:_getPsychicedSkillId()
	local curTab = SeniorArenaController.instance:getCurFormTab()
	local form = SeniorArenaController.instance:getCacheForm(curTab)

	return form.psychicSkillId
end

function SeniorBuzhenLeftView:_setElementSkill()
	SeniorBuzhenLeftView.super._setElementSkill(self)

	local _curMasterId = self:_getCurFormation():GetElementalMasterId()
	local _targetId = self:_getCurFormation():GetElementalTargetId()
	local curTab = SeniorArenaController.instance:getCurFormTab()
	local form = SeniorArenaController.instance:getCacheForm(curTab)

	form.elementalMasterId = checknumber(_curMasterId)
	form.elementalTargetId = checknumber(_targetId)
end

function SeniorBuzhenLeftView:_getCutePetInfo()
	local cutePetRaceId, cutePetQuality = 0, 0

	if self._isUseCutePet == nil or self._isUseCutePet == true then
		local curTab = SeniorArenaController.instance:getCurFormTab()
		local form = SeniorArenaController.instance:getCacheForm(curTab)

		cutePetQuality = form.cutePetQuality
		cutePetRaceId = form.cutePetRaceId
	end

	return cutePetRaceId, cutePetQuality
end

function SeniorBuzhenLeftView:_SetCutePet()
	local cutePetRaceId = self:_getCurFormation():GetCutePetRaceId()
	local cutePetQuality = self:_getCurFormation():GetCutePetQuality()
	local curTab = SeniorArenaController.instance:getCurFormTab()
	local form = SeniorArenaController.instance:getCacheForm(curTab)

	form.cutePetRaceId = checknumber(cutePetRaceId)
	form.cutePetQuality = checknumber(cutePetQuality)

	SeniorBuzhenLeftView.super._SetCutePet(self)
end

function SeniorBuzhenLeftView:_setBtnFormationActive()
	return false
end

function SeniorBuzhenLeftView:_saveCurrFmt()
	return
end

function SeniorBuzhenLeftView:_initSelfFormation()
	return
end

function SeniorBuzhenLeftView:dealWithLimitPetPos()
	local positions = self:_getCurFormation():GetPositions()

	for i = 1, 9 do
		local pid = checknumber(positions[i])

		if pid > 0 then
			SeniorArenaController.instance:clearSameRaceIdInOtherTab(pid)
		end
	end

	SeniorBuzhenLeftView.super.dealWithLimitPetPos(self)
end

return SeniorBuzhenLeftView
