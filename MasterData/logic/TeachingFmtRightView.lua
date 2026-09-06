-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teachingdungeon/view/TeachingFmtRightView.lua

module("logic.extensions.teachingdungeon.view.TeachingFmtRightView", package.seeall)

local TeachingFmtRightView = class("TeachingFmtRightView", FormationRightView)

function TeachingFmtRightView:updateForbit(data)
	local inTeamId = TeachingDungeonModel.instance:getPetIdInTeamByRaceId(data.raceId)
	local notInteam = checknumber(inTeamId) > 0 and inTeamId ~= data.petId
	local canNotUp, hasOne = false, false
	local canNotUpWithYuan = self:getYuanLimit(data)

	data:setPetForbit()
	data:setPetForbit(notInteam or canNotUp or hasOne or canNotUpWithYuan)
end

function TeachingFmtRightView:_updateCell(view, cell, data)
	TeachingFmtRightView.super._updateCell(self, view, cell, data)

	local inTeamId = TeachingDungeonModel.instance:getPetIdInTeamByRaceId(data.raceId)
	local component = ItemPet.AddOnce(cell.gameObject)

	component:SetInTeam(inTeamId == data.petId)
end

function TeachingFmtRightView:_onClickPet(data)
	CommonTipsMgr.instance:showPetTips(data)
end

function TeachingFmtRightView:rankNow()
	local names, opt = BagModel.instance:GetSortParms()

	names[1] = function(data)
		local res = 0

		if data ~= nil then
			if TeachingDungeonModel.instance:getFormation():HasPet(data.petId) then
				res = 1
			end
		end

		return res
	end

	if FormationController.instance:checkCanSort(self._curViewDatas) then
		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._tableview:ReloadData()
end

function TeachingFmtRightView:_RefreshPetList()
	self._curViewDatas = {}

	local pets = TeachingDungeonModel.instance:getAllPets(false) or {}

	table.walk(pets, function(v, k)
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end)
	self:rankNow()
end

function TeachingFmtRightView:_onForbidDragTips(petData)
	local inTeamId = TeachingDungeonModel.instance:getPetIdInTeamByRaceId(petData.raceId)
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
end

return TeachingFmtRightView
