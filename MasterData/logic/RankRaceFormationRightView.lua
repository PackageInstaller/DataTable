-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceFormationRightView.lua

module("logic.extensions.rankrace.view.RankRaceFormationRightView", package.seeall)

local RankRaceFormationRightView = class("RankRaceFormationRightView", FormationRightView)

function RankRaceFormationRightView:_updateCell(view, cell, data)
	local _itemData

	if data then
		_itemData = TableUtil.deepcopy(data)
	end

	local _matchType = RankRaceController.instance:getCurViewType()

	if _matchType == RankRaceController.MatchTypeLimit and _itemData then
		_itemData.level = 100
		_itemData.awakeLevel = FightingPowerPetMo._getMaxAwakenLevel(data.raceId)
	end

	local component = ItemPet.AddOnce(cell.gameObject)

	self:updateForbit(_itemData)
	component:Init(_itemData)
	component:setSelected(false)

	local inTeam = self:getInTeam(_itemData)

	component:SetInTeam(inTeam)
end

function RankRaceFormationRightView:updateForbit(data)
	RankRaceFormationRightView.super.updateForbit(self, data)

	if not data.forbit then
		local iscurBanPet = self:_isPetNotCanUp(data:getDefineId())

		data:setPetForbit(iscurBanPet)
	end
end

function RankRaceFormationRightView:_onForbidDragTips(petData)
	RankRaceFormationRightView.super._onForbidDragTips(self, petData)

	local boo, tips = self:checkPetIsForbit(petData)

	FloatWordMgr.instance:show(tips)
end

function RankRaceFormationRightView:checkPetIsForbit(checkPetMo)
	local isForbit = false
	local tips = ""

	if isForbit == false and self:_isPetNotCanUp(checkPetMo:getDefineId()) then
		isForbit = true
		tips = lang("该精灵已被禁用")
	end

	return isForbit, tips
end

function RankRaceFormationRightView:_isPetNotCanUp(raceId)
	if raceId > 0 then
		local _matchType = self:getFirstParam()

		return RankRaceController.instance:iscurBanPet(_matchType, raceId)
	else
		return false
	end
end

function RankRaceFormationRightView:getPetAtCurFormationFunc()
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

return RankRaceFormationRightView
