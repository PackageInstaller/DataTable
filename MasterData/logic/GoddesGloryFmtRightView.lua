-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddesGloryFmtRightView.lua

module("logic.extensions.goddessglory.view.GoddesGloryFmtRightView", package.seeall)

local GoddesGloryFmtRightView = class("GoddesGloryFmtRightView", FormationRightView)

function GoddesGloryFmtRightView:onEnter()
	GoddesGloryFmtRightView.super.onEnter(self)

	self._challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
	self._stageId = GoddessGloryModel.instance:getCurStageId()

	settimer(0, self._updateCellOrders, self, -1)
end

function GoddesGloryFmtRightView:onExit()
	GoddesGloryFmtRightView.super.onExit(self)
	removetimer(self._updateCellOrders, self)
end

function GoddesGloryFmtRightView:_updateCellOrders()
	local cnt = self._tableview:GetVisibleCount() - 1

	for i = 0, cnt do
		local cell = self._tableview:GetCellByIndex(i)
		local petState = goutil.findChild(cell.gameObject, "PetState")

		if petState then
			petState.transform:SetAsLastSibling()
		end
	end
end

function GoddesGloryFmtRightView:updateForbit(data)
	local inTeamId = GoddessGloryFmtModel.instance:getPetIdInTeamByRaceId(self._challengeId, self._stageId, data.raceId)
	local isDead = false
	local canNotUp, hasOne = false, false
	local canNotUpWithYuan = self:getYuanLimit(data)

	data:setPetForbit(checknumber(inTeamId) > 0 and inTeamId ~= data.petId or isDead or hasOne or canNotUp or canNotUpWithYuan)
	print(">>>>>>>>>>>>>>>>>>>> isDead or hasOne or canNotUp", data.raceId, isDead, hasOne, canNotUp)
end

function GoddesGloryFmtRightView:getSummonLimit(data)
	local canNotUp, hasOne = false, false

	return canNotUp, hasOne
end

function GoddesGloryFmtRightView:_updateCell(view, cell, data)
	data.isDead = false

	GoddesGloryFmtRightView.super._updateCell(self, view, cell, data)

	local inTeamId = GoddessGloryFmtModel.instance:getPetIdInTeamByRaceId(self._challengeId, self._stageId, data.raceId)
	local component = ItemPet.AddOnce(cell.gameObject)

	component:SetInTeam(inTeamId == data.petId)
end

function GoddesGloryFmtRightView:_RefreshPetList()
	self._curViewDatas = {}

	local pets = GoddessGloryPetsModel.instance:getAllPets(self._challengeId, self._stageId)

	table.walk(pets, function(v, k)
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end)
	self:rankNow()
end

function GoddesGloryFmtRightView:getInTeam(data)
	return data ~= nil and GoddessGloryFmtModel.instance:getPetIdInTeamByRaceId(self._challengeId, self._stageId, data.raceId) == data.petId
end

function GoddesGloryFmtRightView:_getCurFormation()
	return GoddessGloryFmtModel.instance:getFormation(self._challengeId, self._stageId)
end

return GoddesGloryFmtRightView
