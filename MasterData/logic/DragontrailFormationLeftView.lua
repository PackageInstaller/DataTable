-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/mission/DragontrailFormationLeftView.lua

module("logic.extensions.dragontrial.view.mission.DragontrailFormationLeftView", package.seeall)

local DragontrailFormationLeftView = class("DragontrailFormationLeftView", FormationLeftView)

function DragontrailFormationLeftView:onEnter()
	local params = self:getOpenParam()

	self._planId = params[1]
	self._stageId = params[2]
	self._petPlanId = params[3]

	DragontrailFormationLeftView.super.onEnter(self)
	self:setBtnCutePetActive(false)
	self:_setActiveBtnFormationUse(false)
end

function DragontrailFormationLeftView:_getCurFormation()
	return DragontrialModel.instance:getCurFormation(self._petPlanId)
end

function DragontrailFormationLeftView:SetFormStrengthInfo(info)
	local formStrengthId = -1

	if info then
		formStrengthId = info.formStrengthId
	end

	local info = self:_getCurFormation():GetFormStrengthInfo(formStrengthId)
	local fomation = self:_getCurFormation()

	if info then
		if fomation and fomation._formStrengInfo ~= formStrengthId then
			fomation:SetFormStrengthInfo(info)
		end
	elseif fomation then
		fomation:SetFormStrengthInfo(nil)
	end
end

function DragontrailFormationLeftView:_getPet(id)
	local petMo

	return self._petPlanId and self._petPlanId > 0 and DragontrialModel.instance:getPetWithPlanId(self._petPlanId, id) or DragontrialModel.instance:getBagPet(id)
end

function DragontrailFormationLeftView:_getItemSeatCls()
	return DragontrialItemSeat
end

function DragontrailFormationLeftView:getIsBoundUseBagPet()
	if self._petPlanId and self._petPlanId > 0 then
		return false
	else
		return true
	end
end

return DragontrailFormationLeftView
