-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/mission/DragontrailFormationRightView.lua

module("logic.extensions.dragontrial.view.mission.DragontrailFormationRightView", package.seeall)

local DragontrailFormationRightView = class("DragontrailFormationRightView", FormationRightView)

function DragontrailFormationRightView:onEnter()
	DragontrailFormationRightView.super.onEnter(self)

	local params = self:getOpenParam()

	self._planId = params[1]
	self._stageId = params[2]
	self._petPlanId = params[3]
end

function DragontrailFormationRightView:getAllShowPetList()
	return DragontrialModel.instance:getAllShowPetList(self._petPlanId, true)
end

function DragontrailFormationRightView:_getCurFormation()
	return DragontrialModel.instance:getCurFormation(self._petPlanId)
end

function DragontrailFormationRightView:setCurViewDatas()
	self._curViewDatas = {}

	local pets = self:getAllShowPetList()
	local map = {}
	local summonMap = {}

	for k, v in pairs(pets) do
		self._curPetMap[v.petId] = v

		if self:getInTeam(v) then
			if v:isSummonedPet() or checknumber(v.summonedPetId) > 0 then
				summonMap[v.petId] = v
			else
				map[v.raceId] = v
			end

			if self:onFilter(v) then
				self._curViewDatas[#self._curViewDatas + 1] = v
			end
		end
	end

	for k, v in pairs(pets) do
		if summonMap[v.petId] == nil then
			local isAboutSummoned = v:isSummonedPet() or checknumber(v.summonedPetId) > 0

			if map[v.raceId] == nil or isAboutSummoned then
				if not isAboutSummoned then
					map[v.raceId] = v
				else
					summonMap[v.petId] = v
				end

				if self:onFilter(v) then
					self._curViewDatas[#self._curViewDatas + 1] = v
				end
			end
		end
	end
end

return DragontrailFormationRightView
