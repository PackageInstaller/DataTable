-- chunkname: @modules/logic/playercard/model/PlayerCardBadgeListModel.lua

module("modules.logic.playercard.model.PlayerCardBadgeListModel", package.seeall)

local PlayerCardBadgeListModel = class("PlayerCardBadgeListModel", ListScrollModel)

function PlayerCardBadgeListModel:setBadgeList()
	self:_refreshBadgeList()
end

function PlayerCardBadgeListModel:_refreshBadgeList()
	local list = {}

	self._groupDict = {}

	local moList = PlayerCardModel.instance:getBadgeMos()

	for _, mo in ipairs(moList) do
		if mo:isGain() then
			local group = mo.co.group
			local curGroup = self._groupDict[group]

			if not curGroup or curGroup.co.level < mo.co.level then
				self._groupDict[group] = mo
			end
		end
	end

	for _, mo in pairs(self._groupDict) do
		table.insert(list, mo)
	end

	table.sort(list, self.sort)
	self:setList(list)
end

function PlayerCardBadgeListModel:sortList(isRareAscend)
	self._rareAscend = isRareAscend

	table.sort(self:getList(), self.sort)
	self:onModelUpdate()
end

function PlayerCardBadgeListModel.sort(a, b)
	local cardInfo = PlayerCardModel.instance:getCardInfo()

	if cardInfo then
		local a_equipIndex = cardInfo:getEquipIndexBadge(a.id)
		local b_equipIndex = cardInfo:getEquipIndexBadge(b.id)

		if a_equipIndex > 0 and b_equipIndex > 0 then
			return a_equipIndex < b_equipIndex
		end
	end

	if a.co.level == b.co.level then
		return a.id < b.id
	end

	local isRareAscend = PlayerCardBadgeListModel.instance:isRareAscend()

	if isRareAscend then
		return a.co.level < b.co.level
	end

	return a.co.level > b.co.level
end

function PlayerCardBadgeListModel:isRareAscend()
	return self._rareAscend
end

function PlayerCardBadgeListModel:getMoByGroupId(group)
	return self._groupDict[group]
end

PlayerCardBadgeListModel.instance = PlayerCardBadgeListModel.New()

return PlayerCardBadgeListModel
