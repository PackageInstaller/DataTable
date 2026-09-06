-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/LegendFormationRightView.lua

module("logic.extensions.legend.view.LegendFormationRightView", package.seeall)

local LegendFormationRightView = class("LegendFormationRightView", FormationRightView)

function LegendFormationRightView:getHasUp(data)
	if LegendModel.instance:isExistSupportPet() then
		if data then
			return (LegendModel.instance:checkHasInTeamByRaceId(data.raceId))
		end

		return false
	else
		return LegendFormationRightView.super.getHasUp(self, data)
	end
end

function LegendFormationRightView:getPetAtCurFormationFunc()
	if LegendModel.instance:isExistSupportPet() then
		return function(data)
			local res = 0

			if data ~= nil then
				if LegendModel.instance:getFormation():HasPet(data.petId) then
					res = data.petId == LegendModel.instance:getCreepsId() and 2 or 1
				end
			end

			return res
		end
	else
		return LegendFormationRightView.super.getPetAtCurFormationFunc(self)
	end
end

function LegendFormationRightView:getAllShowPetList()
	local pets
	local isExistSupport = LegendModel.instance:isExistSupportPet()

	return LegendModel.instance:getAllPets(isExistSupport) or {}
end

function LegendFormationRightView:getPetMoById(petId)
	return (LegendModel.instance:getPetMoById(petId))
end

function LegendFormationRightView:_getCurFormation()
	if LegendModel.instance:isExistSupportPet() then
		return (LegendModel.instance:getOriginalCurFormation())
	else
		return LegendModel.instance:_getCurFormation()
	end
end

return LegendFormationRightView
