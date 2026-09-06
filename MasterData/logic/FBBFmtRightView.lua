-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/mission/FBBFmtRightView.lua

module("logic.extensions.fbbchallenge.view.mission.FBBFmtRightView", package.seeall)

local FBBFmtRightView = class("FBBFmtRightView", FormationRightView)

function FBBFmtRightView:_RefreshPetList()
	self._curViewDatas = {}

	local challengeType = LightKingModel.instance:getCurChallengeType()

	self._curPetMap = {}

	local helpPets = FbbchallengeModel.instance:getAllHelpPets()

	for _, v in ipairs(helpPets) do
		self._curPetMap[v.petId] = v
	end

	self:setCurViewDatas()

	if FormationController.instance:checkCanSort(self._curViewDatas) then
		local names, opt = BagModel.instance:GetSortParms(self:getPetAtCurFormationFunc())

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	for _, v in ipairs(helpPets) do
		table.insert(self._curViewDatas, 1, v)
	end

	self._tableview:ReloadData()
end

function FBBFmtRightView:_getCurFormation()
	return FbbchallengeModel.instance:getCurFormation()
end

return FBBFmtRightView
