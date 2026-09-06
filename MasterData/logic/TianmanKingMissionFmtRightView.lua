-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/TianmanKingMissionFmtRightView.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.TianmanKingMissionFmtRightView", package.seeall)

local TianmanKingMissionFmtRightView = class("TianmanKingMissionFmtRightView", FormationRightView)

function TianmanKingMissionFmtRightView:_RefreshPetList()
	local openParam = self:getOpenParam()
	local challengeType, stage = openParam[1], openParam[2]

	if challengeType == 2 then
		self._curViewDatas = {}
		self._curPetMap = {}

		local helpPets = TianmanKingModel.instance:getAllHelpPets(stage)
		local map = {}

		for _, v in ipairs(helpPets or {}) do
			map[v.raceId] = v
		end

		self:setCurViewDatas()

		if FormationController.instance:checkCanSort(self._curViewDatas) then
			local names, opt = BagModel.instance:GetSortParms(self:getPetAtCurFormationFunc())

			ArraySort.sortOn(self._curViewDatas, names, opt)
		end

		for i = #self._curViewDatas, 1, -1 do
			if map[self._curViewDatas[i].raceId] then
				table.remove(self._curViewDatas, i)
			end
		end

		for _, v in ipairs(helpPets) do
			table.insert(self._curViewDatas, 1, v)
		end

		self._tableview:ReloadData()
	else
		TianmanKingMissionFmtRightView.super._RefreshPetList(self)
	end
end

function TianmanKingMissionFmtRightView:_getCurFormation()
	local openParam = self:getOpenParam()
	local challengeType = openParam[1]

	if challengeType == 2 then
		return TianmanKingModel.instance:getForm()
	else
		return TianmanKingMissionFmtRightView.super._getCurFormation(self)
	end
end

return TianmanKingMissionFmtRightView
