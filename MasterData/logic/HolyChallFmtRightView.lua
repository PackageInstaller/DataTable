-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/holychallmission/HolyChallFmtRightView.lua

module("logic.extensions.kingway.view.holychallmission.HolyChallFmtRightView", package.seeall)

local HolyChallFmtRightView = class("HolyChallFmtRightView", FormationRightView)

function HolyChallFmtRightView:onEnter()
	HolyChallFmtRightView.super.onEnter(self)
end

function HolyChallFmtRightView:onExit()
	HolyChallFmtRightView.super.onExit(self)
end

function HolyChallFmtRightView:getInTeam(data)
	local var_3_0 = data ~= nil and HolyChallModel.instance:getFormation():HasPet(data.petId) or false
	local inTeam = true

	goto label_3_0

	::label_3_0::

	return inTeam
end

function HolyChallFmtRightView:updateForbit(data)
	local var_4_0 = data ~= nil and HolyChallModel.instance:getFormation():HasPet(data.petId) or false
	local inTeam = true

	goto label_4_0

	::label_4_0::

	local hasUp = false
	local canNotUp, hasOne = false, false
	local canNotUpWithYuan = self:getYuanLimit(data)

	data:setPetForbit(not inTeam and (hasUp or canNotUp or hasOne or canNotUpWithYuan))
end

function HolyChallFmtRightView:_onForbidDragTips(petData)
	local var_5_0 = petData ~= nil and HolyChallModel.instance:getFormation():HasPet(petData.petId) or false
	local inTeam = true

	goto label_5_0

	::label_5_0::

	local hasUp = HolyChallModel.instance:checkHasInTeamByRaceId(petData.raceId)

	if not inTeam and hasUp then
		FloatWordMgr.instance:show(lang("阵上已经拥有相同的精灵了，不能重复上阵哦！"))
	end

	local canNotUpYuan = self:getYuanLimit(petData)

	if canNotUpYuan then
		FloatWordMgr.instance:show(lang("已达到上阵限制，源属性精灵最多上阵两只"))

		return
	end
end

function HolyChallFmtRightView:rankNow()
	local names, opt = BagModel.instance:GetSortParms()

	names[1] = function(data)
		local res = 0

		if data ~= nil then
			if HolyChallModel.instance:getFormation():HasPet(data.petId) then
				res = data.petId == HolyChallModel.instance:getCreepsId() and 2 or 1
			end
		end

		return res
	end

	if FormationController.instance:checkCanSort(self._curViewDatas) then
		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._tableview:ReloadData()
end

function HolyChallFmtRightView:_RefreshPetList()
	self._curViewDatas = {}

	local pets = HolyChallModel.instance:getAllPets(true) or {}

	table.walk(pets, function(v, k)
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end)
	self:rankNow()
end

function HolyChallFmtRightView:_getCurFormation()
	return HolyChallModel.instance:getFormation()
end

return HolyChallFmtRightView
