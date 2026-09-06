-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceDefenseFmtRightView.lua

module("logic.extensions.rankrace.view.RankRaceDefenseFmtRightView", package.seeall)

local RankRaceDefenseFmtRightView = class("RankRaceDefenseFmtRightView", FormationRightView)

function RankRaceDefenseFmtRightView:updateForbit(data)
	RankRaceDefenseFmtRightView.super.updateForbit(self, data)

	if not data.forbit then
		local _matchType = RankRaceController.instance:getCurViewType()
		local iscurBanPet = RankRaceController.instance:iscurBanPet(_matchType, data:getDefineId())

		data:setPetForbit(iscurBanPet)
	end
end

function RankRaceDefenseFmtRightView:setCurViewDatas()
	self._curViewDatas = {}

	local pets = self:getAllShowPetList()

	for k, v in pairs(pets) do
		local targetPetmo = v

		if RankRaceController.instance:getCurViewType() == RankRaceController.MatchTypeLimit then
			targetPetmo = FightingPowerPetMo.getMaxPetMoByData(v)
		end

		self._curPetMap[v.petId] = targetPetmo

		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = targetPetmo
		end
	end
end

function RankRaceDefenseFmtRightView:_updateCell(view, cell, data)
	local _itemData

	if data then
		_itemData = TableUtil.deepcopy(data)
	end

	local _matchType = RankRaceController.instance:getCurViewType()

	if _matchType == RankRaceController.MatchTypeLimit and _itemData then
		_itemData.level = 100
		_itemData.awakeLevel = FightingPowerPetMo._getMaxAwakenLevel(data.raceId) or 1
	end

	RankRaceDefenseFmtRightView.super._updateCell(self, view, cell, _itemData)

	local inTeamId = RankRaceFmtModel.instance:getPetIdInDefTeamByRaceId(self:getFirstParam(), _itemData.raceId)
	local component = ItemPet.AddOnce(cell.gameObject)

	component:SetInTeam(inTeamId == _itemData.petId)
end

function RankRaceDefenseFmtRightView:getInTeam(data)
	local formation = RankRaceFmtModel.instance:getDefenseForm(self:getFirstParam())

	return data ~= nil and formation:HasPet(data.petId)
end

function RankRaceDefenseFmtRightView:rankNow()
	local _matchType = RankRaceController.instance:getCurViewType()

	if _matchType == RankRaceController.MatchTypeLimit then
		local sortState = BagModel.instance:GetSortState()

		if sortState and sortState[1] and sortState[2] and sortState[2] == 0 and sortState[3] and sortState[3] == 0 and sortState[4] and sortState[4] == 0 then
			local names, opt = BagModel.instance:GetSortParms(self:getPetAtCurFormationFunc())

			if sortState[1] == ArraySort.CASEINSENSITIVE or sortState[1] == ArraySort.DESCENDING then
				names[5] = function(petMo)
					if petMo._rankRaceLimitMaxZdl then
						return petMo._rankRaceLimitMaxZdl
					else
						local maxMo = FightingPowerPetMo.getMaxPetMoByData(petMo)

						return checknumber(maxMo._zdl)
					end
				end

				if FormationController.instance:checkCanSort(self._curViewDatas) then
					ArraySort.sortOn(self._curViewDatas, names, opt)
				end

				self._tableview:ReloadData()
			else
				if FormationController.instance:checkCanSort(self._curViewDatas) then
					ArraySort.sortOn(self._curViewDatas, names, opt)
				end

				self._tableview:ReloadData()
			end
		else
			RankRaceDefenseFmtRightView.super.rankNow(self)
		end
	else
		RankRaceDefenseFmtRightView.super.rankNow(self)
	end
end

function RankRaceDefenseFmtRightView:_onForbidDragTips(petData)
	local inTeamId = RankRaceFmtModel.instance:getPetIdInDefTeamByRaceId(self:getFirstParam(), petData.raceId)
	local notInteam = checknumber(inTeamId) > 0 and inTeamId ~= petData.petId

	if notInteam then
		FloatWordMgr.instance:show(lang("阵上已经拥有相同的精灵了，不能重复上阵哦！"))

		return
	end

	local canNotUpYuan = self:getYuanLimit(petData)

	if canNotUpYuan then
		FloatWordMgr.instance:show(lang("已达到上阵限制，源属性精灵最多上阵两只"))

		return
	end

	local boo, tips = self:checkPetIsForbit(petData)

	if boo then
		FloatWordMgr.instance:show(tips)

		return
	end
end

function RankRaceDefenseFmtRightView:_getCurFormation()
	local _matchType = self:getFirstParam()

	return RankRaceFmtModel.instance:getDefenseForm(_matchType)
end

function RankRaceDefenseFmtRightView:getPetAtCurFormationFunc()
	return function(petMo)
		local res = 2

		if self:getInTeam(petMo) then
			res = 3
		elseif self:getHasUp(petMo) then
			res = 1
		end

		return (self:checkPetIsForbit(petMo) or nil) and 0
	end
end

function RankRaceDefenseFmtRightView:checkPetIsForbit(checkPetMo)
	local isForbit = false
	local tips = ""

	if isForbit == false and self:_isPetNotCanUp(checkPetMo:getDefineId()) then
		isForbit = true
		tips = lang("该精灵已被禁用")
	end

	return isForbit, tips
end

function RankRaceDefenseFmtRightView:_isPetNotCanUp(raceId)
	if raceId > 0 then
		local _matchType = self:getFirstParam()

		return RankRaceController.instance:iscurBanPet(_matchType, raceId)
	else
		return false
	end
end

return RankRaceDefenseFmtRightView
