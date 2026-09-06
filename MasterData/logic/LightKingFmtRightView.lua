-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingFmtRightView.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingFmtRightView", package.seeall)

local LightKingFmtRightView = class("LightKingFmtRightView", FormationRightView)

function LightKingFmtRightView:_RefreshPetList()
	self._curViewDatas = {}

	local challengeType = LightKingModel.instance:getCurChallengeType()

	self._curPetMap = {}

	local helpPets = LightKingModel.instance:getAllHelpPets()

	for _, v in ipairs(helpPets) do
		self._curPetMap[v.petId] = v
	end

	if challengeType == GameEnum.LightKingChallengeType.SHENGGUANG then
		self:setCurViewDatas()
		self:rankNow()
	elseif challengeType == GameEnum.LightKingChallengeType.YAOSHI then
		self._curPetMap = {}
		self._curViewDatas = helpPets

		self._tableview:ReloadData()
	elseif challengeType == GameEnum.LightKingChallengeType.JIXIAN then
		self:setCurViewDatas()

		local names, opt = BagModel.instance:GetSortParms(self:getPetAtCurFormationFunc())

		if FormationController.instance:checkCanSort(self._curViewDatas) then
			ArraySort.sortOn(self._curViewDatas, names, opt)
		end

		for _, v in ipairs(helpPets) do
			table.insert(self._curViewDatas, 1, v)
		end

		self._tableview:ReloadData()
	end
end

return LightKingFmtRightView
