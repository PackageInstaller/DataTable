-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilytpFormationLeftView.lua

module("logic.extensions.familyteamplay.view.FamilytpFormationLeftView", package.seeall)

local FamilytpFormationLeftView = class("FamilytpFormationLeftView", FormationLeftView)

function FamilytpFormationLeftView:_getCurFormation()
	local params = self:getOpenParam()

	if not params[3] then
		local team = FormationNewModel.instance:GetCurTeam()
		local formation = team:GetCurFormation()

		if not formation then
			return
		end

		for pos, petId in pairs(formation._positions) do
			if petId > 0 and FamilyteamplayModel.instance:isFatiguePetId(petId, params[3]) then
				FormationController.instance:ChangePosition(pos, 0)
			elseif petId > 0 and not FamilyteamplayModel.instance:isOverLimitLv(petId) then
				FormationController.instance:ChangePosition(pos, 0)
			end
		end

		return formation
	end
end

return FamilytpFormationLeftView
