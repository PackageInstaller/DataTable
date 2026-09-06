-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialFmtRightView.lua

module("logic.extensions.herotrial.view.HerotrialFmtRightView", package.seeall)

local HerotrialFmtRightView = class("HerotrialFmtRightView", FormationRightView)

function HerotrialFmtRightView:onEnter()
	HerotrialFmtRightView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.HeroTrialGetInfo, self._OnFormationChanged, self)
end

function HerotrialFmtRightView:onExit()
	HerotrialFmtRightView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HeroTrialGetInfo, self._OnFormationChanged, self)
end

function HerotrialFmtRightView:getInTeam(data)
	local var_3_0 = data ~= nil and HerotrialModel.instance:getFormation():HasPet(data.petId) or false
	local inTeam = true

	goto label_3_0

	::label_3_0::

	return inTeam
end

function HerotrialFmtRightView:updateForbit(data)
	local var_4_0 = data ~= nil and HerotrialModel.instance:getFormation():HasPet(data.petId) or false
	local inTeam = true

	goto label_4_0

	::label_4_0::

	local hasUp = false
	local canNotUp, hasOne = false, false

	data:setPetForbit(not inTeam and (hasUp or canNotUp or hasOne))
end

function HerotrialFmtRightView:_onForbidDragTips(petData)
	local var_5_0 = petData ~= nil and HerotrialModel.instance:getFormation():HasPet(petData.petId) or false
	local inTeam = true

	goto label_5_0

	::label_5_0::

	local hasUp = HerotrialModel.instance:checkHasInTeamByRaceId(petData.raceId)

	if not inTeam and hasUp then
		FloatWordMgr.instance:show(lang("阵上已经拥有相同的精灵了，不能重复上阵哦！"))
	end

	local canNotUpYuan = self:getYuanLimit(petData)

	if canNotUpYuan then
		FloatWordMgr.instance:show(lang("已达到上阵限制，源属性精灵最多上阵两只"))

		return
	end
end

function HerotrialFmtRightView:rankNow()
	local names, opt = BagModel.instance:GetSortParms()

	names[1] = function(data)
		local res = 0

		if data ~= nil then
			if HerotrialModel.instance:getFormation():HasPet(data.petId) then
				res = data.petId == HerotrialModel.instance:getCreepsId() and 2 or 1
			end
		end

		return res
	end

	if FormationController.instance:checkCanSort(self._curViewDatas) then
		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._tableview:ReloadData()
end

function HerotrialFmtRightView:_RefreshPetList()
	self._curViewDatas = {}

	local pets = HerotrialModel.instance:getAllPets() or {}

	table.walk(pets, function(v, k)
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end)
	self:rankNow()
end

return HerotrialFmtRightView
