-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/SeniorFormationLeftView.lua

module("logic.extensions.mission.view.SeniorFormationLeftView", package.seeall)

local SeniorFormationLeftView = class("SeniorFormationLeftView", FormationLeftView)

function SeniorFormationLeftView:onEnter()
	SeniorFormationLeftView.super.onEnter(self)
	self:_setActiveBtnFormation(false)
	GlobalDispatcher:addListener(GlobalNotify.CurFormTabChange, self._updateMyForms, self)
	GlobalDispatcher:addListener(GlobalNotify.SeniorCacheFormsChanged, self._updateMyForms, self)
	self:_updateMyForms()
end

function SeniorFormationLeftView:onExit()
	SeniorFormationLeftView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CurFormTabChange, self._updateMyForms, self)
	GlobalDispatcher:removeListener(GlobalNotify.SeniorCacheFormsChanged, self._updateMyForms, self)
end

function SeniorFormationLeftView:_getHeroSkillId()
	local curTab = SeniorArenaController.instance:getCurFormTab()
	local form = SeniorArenaController.instance:getCacheForm(curTab)

	return form.heroSkillId
end

function SeniorFormationLeftView:_changeHeroSkillId(id)
	local curTab = SeniorArenaController.instance:getCurFormTab()
	local form = SeniorArenaController.instance:getCacheForm(curTab)

	form.heroSkillId = id

	SeniorFormationLeftView.super._changeHeroSkillId(self, id)
end

function SeniorFormationLeftView:_setPsychicedSkill(id)
	id = self:_checkPsychicedSkill(id)

	local curTab = SeniorArenaController.instance:getCurFormTab()
	local form = SeniorArenaController.instance:getCacheForm(curTab)

	form.psychicSkillId = id

	SeniorBuzhenLeftView.super._setPsychicedSkill(self, id)
end

function SeniorFormationLeftView:_getPsychicedSkillId()
	local curTab = SeniorArenaController.instance:getCurFormTab()
	local form = SeniorArenaController.instance:getCacheForm(curTab)

	return form.psychicSkillId
end

function SeniorFormationLeftView:_setElementSkill()
	SeniorFormationLeftView.super._setElementSkill(self)

	local _curMasterId = self:_getCurFormation():GetElementalMasterId()
	local _targetId = self:_getCurFormation():GetElementalTargetId()
	local curTab = SeniorArenaController.instance:getCurFormTab()
	local form = SeniorArenaController.instance:getCacheForm(curTab)

	form.elementalMasterId = checknumber(_curMasterId)
	form.elementalTargetId = checknumber(_targetId)
end

function SeniorFormationLeftView:_getCutePetInfo()
	local cutePetRaceId, cutePetQuality = 0, 0

	if self._isUseCutePet == nil or self._isUseCutePet == true then
		local curTab = SeniorArenaController.instance:getCurFormTab()
		local form = SeniorArenaController.instance:getCacheForm(curTab)

		cutePetQuality = form.cutePetQuality
		cutePetRaceId = form.cutePetRaceId
	end

	return cutePetRaceId, cutePetQuality
end

function SeniorFormationLeftView:_SetCutePet()
	local cutePetRaceId = self:_getCurFormation():GetCutePetRaceId()
	local cutePetQuality = self:_getCurFormation():GetCutePetQuality()
	local curTab = SeniorArenaController.instance:getCurFormTab()
	local form = SeniorArenaController.instance:getCacheForm(curTab)

	form.cutePetRaceId = checknumber(cutePetRaceId)
	form.cutePetQuality = checknumber(cutePetQuality)

	SeniorFormationLeftView.super._SetCutePet(self)
end

function SeniorFormationLeftView:_updateMyForms()
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

function SeniorFormationLeftView:_setBtnFormationActive()
	return false
end

function SeniorFormationLeftView:_saveCurrFmt()
	return
end

function SeniorFormationLeftView:_initSelfFormation()
	return
end

function SeniorFormationLeftView:onAllPetSetFinish()
	self:dealWithLimitPetPos()
end

function SeniorFormationLeftView:dealWithLimitPetPos()
	local positions = self:_getCurFormation():GetPositions()

	for i = 1, 9 do
		local pid = checknumber(positions[i])

		if pid > 0 then
			SeniorArenaController.instance:clearSameRaceIdInOtherTab(pid)
		end
	end

	SeniorFormationLeftView.super.dealWithLimitPetPos(self)
end

function SeniorFormationLeftView:_setSummonContractSkillEffect()
	self:_removeSummonContractSkillEffect()

	local fmtMo = self:_getCurFormation()
	local summonId = fmtMo:GetSummonPetId()
	local masterId = fmtMo:GetSummonMasterPetId()

	if summonId > 0 then
		local effectPath = self:_getContractSkillEffectPath(summonId, masterId)

		if not string.nilorempty(effectPath) then
			local curPos = -1
			local poisitions = self:_getCurFormation():GetPositions()

			for i, v in ipairs(poisitions) do
				if v == summonId then
					curPos = i

					break
				end
			end

			if curPos > 0 then
				local ItemSeatCls = self:_getItemSeatCls()
				local itemSeat = ItemSeatCls.AddOnce(self._seats[curPos])

				itemSeat:playContractSkillEffect(self, effectPath)
			end
		end
	end
end

return SeniorFormationLeftView
