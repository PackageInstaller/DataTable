-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerFmtRightView.lua

module("logic.extensions.formation.view.SummontowerFmtRightView", package.seeall)

local SummontowerFmtRightView = class("SummontowerFmtRightView", FormationRightView)

function SummontowerFmtRightView:updateForbit(data)
	local inTeamId = SummontowerFmtModel.instance:getPetIdInTeamByRaceId(data.raceId)
	local canNotUp, hasOne = false, false
	local canNotUpWithYuan = self:getYuanLimit(data)

	data:setPetForbit(checknumber(inTeamId) > 0 and inTeamId ~= data.petId or hasOne or canNotUp or canNotUpWithYuan)
end

function SummontowerFmtRightView:getInTeam(data)
	return data ~= nil and SummontowerFmtModel.instance:getPetIdInTeamByRaceId(data.raceId) == data.petId
end

function SummontowerFmtRightView:_RefreshPetList()
	self._curViewDatas = {}

	local pets = SummontowerPetsModel.instance:getAllPets()

	table.walk(pets, function(v, k)
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end)
	self:rankNow()
end

function SummontowerFmtRightView:getPetMoById(petId)
	return SummontowerPetsModel.instance:getPet(petId)
end

return SummontowerFmtRightView
