-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/SccopyFmtRightView.lua

module("logic.extensions.scenariocopy.view.SccopyFmtRightView", package.seeall)

local SccopyFmtRightView = class("SccopyFmtRightView", FormationRightView)

function SccopyFmtRightView:rankNow()
	local names, opt = BagModel.instance:GetSortParms()

	names[1] = function(data)
		local res = 0

		if data ~= nil then
			if ScenariocopyModel.instance:getFormation():HasPet(data.petId) then
				res = data.petId == ScenariocopyModel.instance:getCreepsIds() and 2 or 1
			end
		end

		return res
	end

	if FormationController.instance:checkCanSort(self._curViewDatas) then
		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._tableview:ReloadData()
end

function SccopyFmtRightView:onEnter()
	SccopyFmtRightView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FormationPet_POS_FINISH, self._RefreshPetList, self)
end

function SccopyFmtRightView:onExit()
	SccopyFmtRightView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationPet_POS_FINISH, self._RefreshPetList, self)
end

function SccopyFmtRightView:_getCurFormation()
	return ScenariocopyModel.instance:getFormation()
end

function SccopyFmtRightView:getAllShowPetList()
	return ScenariocopyModel.instance:getAllPets(true) or {}
end

function SccopyFmtRightView:setCurViewDatas()
	if not ScenariocopyModel.instance:getIsTrial() or not self:checkIsMax() then
		self:getAllPetsList()
	else
		self:getFilterPetsList()
	end
end

function SccopyFmtRightView:getAllPetsList()
	self._curViewDatas = {}

	local pets = self:getAllShowPetList()

	for k, v in pairs(pets) do
		self._curPetMap[v.petId] = v

		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end
end

function SccopyFmtRightView:checkIsMax()
	local curStageCfg = ScenariocopyModel.instance:getStageCfg()

	return curStageCfg.extreme
end

function SccopyFmtRightView:getFilterPetsList()
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

return SccopyFmtRightView
