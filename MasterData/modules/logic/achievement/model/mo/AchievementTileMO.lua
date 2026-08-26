-- chunkname: @modules/logic/achievement/model/mo/AchievementTileMO.lua

module("modules.logic.achievement.model.mo.AchievementTileMO", package.seeall)

local AchievementTileMO = pureTable("AchievementTileMO")

function AchievementTileMO:init(achievementCfgs, groupId, isGroupTop)
	self.achievementCfgs = achievementCfgs
	self.groupId = groupId

	if achievementCfgs then
		self.count = #achievementCfgs or 0
	end

	self.isGroupTop = isGroupTop
	self.isFold = false
	self.firstAchievementCo = achievementCfgs and achievementCfgs[1]
end

function AchievementTileMO:getLineHeightFunction(filterType, isFold)
	if isFold then
		if self.isGroupTop then
			return AchievementEnum.SpGroupTitleBarHeight
		else
			return 0
		end
	elseif self.groupId == 0 then
		return AchievementEnum.MainTileLineItemHeight
	else
		if AchievementUtils.isGamePlayGroup(self.firstAchievementCo.id) then
			if self.isGroupTop then
				if not AchievementEnum.SpGroupTitleBarHeight then
					local headerHeight = 0

					return headerHeight + AchievementEnum.MainTileLineItemHeight
				end
			end
		end

		return AchievementEnum.MainTileGroupItemHeight
	end
end

function AchievementTileMO:getAchievementType()
	if self.groupId then
		local isGroup = self.groupId ~= 0

		return (isGroup or nil) and (AchievementEnum.AchievementType.Group or AchievementEnum.AchievementType.Single)
	end
end

function AchievementTileMO:isAchievementMatch(achievementType, dataId)
	local isMatch = false

	if achievementType == AchievementEnum.AchievementType.Single then
		if self.achievementCfgs then
			for _, achievementCfg in ipairs(self.achievementCfgs) do
				if achievementCfg.id == dataId then
					isMatch = true

					break
				end
			end
		end
	else
		isMatch = dataId == self.groupId
	end

	return isMatch
end

function AchievementTileMO:overrideLineHeight(cellHeight)
	self._cellHeight = cellHeight
end

function AchievementTileMO:clearOverrideLineHeight()
	self._cellHeight = nil
end

function AchievementTileMO:getLineHeight(filterType, isFold)
	if self._cellHeight then
		return self._cellHeight
	end

	return (self:getLineHeightFunction(filterType, isFold))
end

function AchievementTileMO:setIsFold(isFold)
	self.isFold = isFold
end

function AchievementTileMO:getIsFold()
	return self.isFold
end

function AchievementTileMO:getGroupId()
	return self.groupId
end

return AchievementTileMO
