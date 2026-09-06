-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/noahchallenge/view/NoahFormationRightView.lua

module("logic.extensions.noahchallenge.view.NoahFormationRightView", package.seeall)

local NoahFormationRightView = class("NoahFormationRightView", FormationRightView)

function NoahFormationRightView:updateForbit(data)
	local inTeam = self:getInTeam(data)
	local hasOneHire = self:getHasHireInTeam(data)
	local hasUp = false
	local canNotUp, hasOne = false, false
	local canNotUpWithYuan = self:getYuanLimit(data)
	local param = self:getOpenParam()
	local isUsed = self:_isUsedPet(data.petId)

	data:setPetForbit(not inTeam and (hasUp or hasOneHire or canNotUp or hasOne or isUsed or canNotUpWithYuan))
end

function NoahFormationRightView:_onForbidDragTips(petData)
	NoahFormationRightView.super._onForbidDragTips(self, petData)

	local isUsed = self:_isUsedPet(petData.petId)

	if isUsed then
		FloatWordMgr.instance:show(lang("noahchallenge_tip3"))

		return
	end

	local canNotUpYuan = self:getYuanLimit(petData)

	if canNotUpYuan then
		FloatWordMgr.instance:show(lang("已达到上阵限制，源属性精灵最多上阵两只"))

		return
	end
end

function NoahFormationRightView:_isUsedPet(petId)
	local param = self:getOpenParam()

	if param then
		local challengeId = param[1]

		return NoahChallengeModel.instance:isPetUsed(challengeId, petId)
	end

	return false
end

function NoahFormationRightView:rankNow()
	local names, opt = BagModel.instance:GetSortParms(self:getPetAtCurFormationFunc())

	table.insert(names, 2, function(petMo)
		if self:_isUsedPet(petMo.petId) then
			return 1
		else
			return 0
		end
	end)
	table.insert(opt, 2, ArraySort.NONE)

	if FormationController.instance:checkCanSort(self._curViewDatas) then
		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._tableview:ReloadData()
end

return NoahFormationRightView
